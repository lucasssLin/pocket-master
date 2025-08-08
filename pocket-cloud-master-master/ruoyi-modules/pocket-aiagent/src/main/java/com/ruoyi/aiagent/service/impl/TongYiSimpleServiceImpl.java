package com.ruoyi.aiagent.service.impl;

import com.ruoyi.aiagent.domain.Message;
import com.ruoyi.aiagent.service.ChatMemoryService;
import com.ruoyi.aiagent.service.TongYiService;

import com.ruoyi.aiagent.tools.OrderTool;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.order.api.service.RemoteOrderInfoService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

@Service
@Slf4j
public class TongYiSimpleServiceImpl implements TongYiService {
    @Override
    public Flux<String> completion(String message) {
        return null;
    }
//    /**
//     * 自动注入ChatClient、StreamingChatClient，屏蔽模型调用细节
//     */
//    private final ChatClient chatClient;
//
//    private final StreamingChatClient streamingChatClient;
//
//    private final ChatMemoryService chatMemoryService;
//
//    private final OrderTool orderTool;
//
//    @Autowired
//    public TongYiSimpleServiceImpl(ChatClient chatClient, StreamingChatClient streamingChatClient,
//                                   ChatMemoryService chatMemoryService, OrderTool orderTool) {
//        this.chatClient = chatClient;
//        this.streamingChatClient = streamingChatClient;
//        this.chatMemoryService = chatMemoryService;
//        this.orderTool = orderTool;
//
//    }
//
//    private static final String ROLE_PRESET_PROMPT = "你是一位Pocket电商平台的智能客服，请以友好的、客气的语气跟顾客进行交流，你现在正在通过在线客服聊天系统与客户互动。" +
//            "在提供获取订单销售数据信息之前，你需要始终从客户中获取以下信息：开始时间、结束时间";
//
//    /**
//     * 具体实现：解决累加问题的流式响应
//     */
//    @Override
//    public Flux<String> completion(String message) {
//        String userId = String.valueOf(SecurityContextHolder.getUserId());
//        // 获取或创建会话ID
//        String sessionId = chatMemoryService.getOrCreateSessionId(String.valueOf(userId));
//        // 保存用户消息到会话历史
//        Message userMessage = Message.builder()
//                .id(UUID.randomUUID().toString())
//                .sessionId(sessionId)
//                .userId(userId)
//                .role("user")
//                .content(message)
//                .createTime(LocalDateTime.now())
//                .build();
//        chatMemoryService.addMessage(userMessage);
//
//        // 构建带有对话历史的Prompt
//        Prompt prompt = buildPromptWithHistory(sessionId, message);
//
//        // 使用原子引用记录完整响应和前一次的完整响应
//        final AtomicReference<String> fullResponseRef = new AtomicReference<>("");
//        final StringBuilder completedResponseBuilder = new StringBuilder();
//
//        // 使用流式调用API并处理响应
//        return streamingChatClient.stream(prompt)
//                .map(response -> {
//                    // 获取当前完整响应
//                    String fullContent = response.getResult().getOutput().getContent();
//                    log.debug("原始流式返回内容: {}", fullContent);
//
//                    // 保存完整响应，用于后续保存到会话历史
//                    fullResponseRef.set(fullContent);
//
//                    // 计算增量部分 - 修复累加问题
//                    String incrementalContent;
//
//                    // 如果当前内容比累积内容更短，说明是新的回复开始
//                    if (fullContent.length() < completedResponseBuilder.length()) {
//                        completedResponseBuilder.setLength(0);
//                    }
//
//                    // 提取增量部分
//                    if (completedResponseBuilder.length() <= fullContent.length()) {
//                        incrementalContent = fullContent.substring(completedResponseBuilder.length());
//                        completedResponseBuilder.append(incrementalContent);
//                    } else {
//                        incrementalContent = fullContent;
//                        completedResponseBuilder.setLength(0);
//                        completedResponseBuilder.append(fullContent);
//                    }
//
//                    log.debug("增量内容: {}", incrementalContent);
//                    return incrementalContent;
//                })
//                .doOnComplete(() -> {
//                    String aiResponse = fullResponseRef.get();
//                    if (aiResponse != null && !aiResponse.isEmpty()) {
//                        Message assistantMessage = Message.builder()
//                                .id(UUID.randomUUID().toString())
//                                .sessionId(sessionId)
//                                .userId(userId)
//                                .role("assistant")
//                                .content(aiResponse)
//                                .createTime(LocalDateTime.now())
//                                .build();
//                        chatMemoryService.addMessage(assistantMessage);
//                        log.info("已保存AI回复到会话历史，长度: {}", aiResponse.length());
//                    }
//                })
//                // 发生错误时提供友好的错误消息
//                .onErrorResume(error -> {
//                    log.error("流式AI回复出错: ", error);
//                    return Flux.just("很抱歉，服务出现了一点问题，请稍后再试。");
//                })
//                // 添加结束标记
//                .doOnComplete(() -> log.info("流式回复完成"))
//                .concatWithValues("[DONE]");
//    }
//
//    /**
//     * 构建带有对话历史的Prompt
//     */
//    private Prompt buildPromptWithHistory(String sessionId, String currentMessage) {
//        // 获取会话历史消息
//        List<Message> historyMessages = chatMemoryService.getSessionHistory(sessionId, 50);
//
//        // 构建Spring AI消息列表
//        List<org.springframework.ai.chat.messages.Message> aiMessages = new ArrayList<>();
//
//        // 添加系统角色提示
//        aiMessages.add(new SystemMessage(ROLE_PRESET_PROMPT));
//
//        // 添加历史消息
//        for (Message msg : historyMessages) {
//            if ("user".equals(msg.getRole())) {
//                aiMessages.add(new UserMessage(msg.getContent()));
//            } else if ("assistant".equals(msg.getRole())) {
//                aiMessages.add(new AssistantMessage(msg.getContent()));
//            }
//            // 忽略其他角色的消息
//        }
//
//        // 如果当前消息不在历史记录中，则添加到列表末尾
//        if (!historyMessages.stream().anyMatch(m ->
//                "user".equals(m.getRole()) && currentMessage.equals(m.getContent()))) {
//            aiMessages.add(new UserMessage(currentMessage));
//        }
//
//
//        log.debug("构建的对话历史条数: {}", aiMessages.size());
//
//        // 创建并返回Prompt对象
//        return new Prompt(aiMessages);
//    }
}