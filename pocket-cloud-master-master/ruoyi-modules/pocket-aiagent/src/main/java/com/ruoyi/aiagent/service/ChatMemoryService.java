package com.ruoyi.aiagent.service;

import com.ruoyi.aiagent.domain.Message;

import java.util.List;

public interface ChatMemoryService {
    
    /**
     * 添加消息到会话
     *
     * @param message 消息对象
     * @return 添加后的消息
     */
    Message addMessage(Message message);
    
    /**
     * 获取会话历史消息
     *
     * @param sessionId 会话ID
     * @param limit 最大消息数量限制
     * @return 消息列表
     */
    List<Message> getSessionHistory(String sessionId, int limit);
    
    /**
     * 获取或创建会话ID
     *
     * @param userId 用户ID
     * @return 会话ID
     */
    String getOrCreateSessionId(String userId);
    
    /**
     * 清除会话历史
     *
     * @param sessionId 会话ID
     */
    void clearSessionHistory(String sessionId);
}