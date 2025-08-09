package com.ruoyi.aiagent.service;

import com.ruoyi.aiagent.domain.Message;

import java.util.List;

public interface ChatMemoryService {
    
    /**
     * 添加消息到会话
     */
    Message addMessage(Message message);
    
    /**
     * 获取会话历史消息
     */
    List<Message> getSessionHistory(String sessionId, int limit);
    
    /**
     * 获取或创建会话ID
     */
    String getOrCreateSessionId(String userId);
    
    /**
     * 清除会话历史
     */
    void clearSessionHistory(String sessionId);
}