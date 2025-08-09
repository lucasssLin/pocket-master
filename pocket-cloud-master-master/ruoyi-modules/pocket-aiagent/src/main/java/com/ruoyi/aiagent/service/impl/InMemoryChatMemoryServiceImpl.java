package com.ruoyi.aiagent.service.impl;

import com.ruoyi.aiagent.domain.Message;
import com.ruoyi.aiagent.service.ChatMemoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;


@Service
@Slf4j
public class InMemoryChatMemoryServiceImpl implements ChatMemoryService {

    // 用户会话映射表 userId -> sessionId
    private final Map<String, String> userSessionMap = new ConcurrentHashMap<>();
    
    // 会话消息存储 sessionId -> List<Message>
    private final Map<String, List<Message>> sessionMessages = new ConcurrentHashMap<>();

    @Override
    public Message addMessage(Message message) {
        if (message.getId() == null || message.getId().isEmpty()) {
            message.setId(UUID.randomUUID().toString());
        }
        
        if (message.getCreateTime() == null) {
            message.setCreateTime(LocalDateTime.now());
        }
        
        List<Message> messages = sessionMessages.computeIfAbsent(
            message.getSessionId(), k -> new ArrayList<>()
        );
        
        // 设置消息序号
        message.setSequence(messages.size() + 1);
        
        // 添加消息到会话
        messages.add(message);
        log.debug("添加消息到会话: {}", message);
        
        return message;
    }

    @Override
    public List<Message> getSessionHistory(String sessionId, int limit) {
        List<Message> messages = sessionMessages.getOrDefault(sessionId, Collections.emptyList());
        
        // 如果消息数量小于等于限制，返回全部
        if (messages.size() <= limit) {
            return new ArrayList<>(messages);
        }
        
        // 否则返回最近的limit条消息
        return messages.stream()
                .sorted(Comparator.comparing(Message::getSequence))
                .skip(messages.size() - limit)
                .collect(Collectors.toList());
    }

    @Override
    public String getOrCreateSessionId(String userId) {
        return userSessionMap.computeIfAbsent(userId, k -> {
            String sessionId = UUID.randomUUID().toString();
            log.info("为用户[{}]创建新会话: {}", userId, sessionId);
            return sessionId;
        });
    }

    @Override
    public void clearSessionHistory(String sessionId) {
        sessionMessages.remove(sessionId);
        log.info("已清除会话历史: {}", sessionId);
    }
}