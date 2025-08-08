package com.ruoyi.aiagent.controller;

import com.ruoyi.aiagent.tools.UserContextHolder;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.web.controller.BaseController;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.AbstractChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.PromptChatMemoryAdvisor;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/frontAi")
public class FrontStageAgentController extends BaseController {
    private final ChatClient chatClient;

    public FrontStageAgentController(ChatClient.Builder chatClientBuilder, ChatMemory chatMemory) {
        this.chatClient = chatClientBuilder.defaultSystem("""
                        你是Pocket电商平台的智能客服助手，请以友好、专业的语气与客户交流。
                
                                        重要规则：
                                        1. 当客户询问消费数据、订单数据时，需要时间范围信息。
                                        2. 如果客户提供了时间信息（如"2024年全年"、"最近6个月"、"2024年1月到3月"等），
                                           请立即解析时间并调用getFrontStageSalesData函数。
                                        3. 只有在客户首次询问但没有提供时间时，才询问时间信息。
                                        4. 一旦获得时间信息，请立即处理，不要重复询问。

                                        时间解析规则：
                                        - "2024年全年" → startTime: "2024-01-01", endTime: "2024-12-31"
                                        - "最近6个月" → startTime: "2024-07-01", endTime: "2024-12-31"
                                        - "2024年1月到3月" → startTime: "2024-01-01", endTime: "2024-03-31"
                                        - "最近3个月" → startTime: "2024-10-01", endTime: "2024-12-31"

                                        当有时间信息时，直接调用getFrontStageSalesData函数获取数据并提供详细分析。
                """)
                .defaultAdvisors(new PromptChatMemoryAdvisor(chatMemory))
                .defaultFunctions("getFrontStageSalesData")
                .build();
    }



    @GetMapping(value = "/frontStage/order", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> completion(@RequestParam(value = "message", defaultValue = "请问有什么可以帮到你？")
                                   String message) {

        // 获取当前用户ID
        Long currentUserId = SecurityContextHolder.getUserId();

        // 构建包含用户ID的消息上下文
        String messageWithUserId = String.format("用户ID: %d, 消息: %s", currentUserId, message);

        Flux<String> content = this.chatClient.prompt()
                .user(messageWithUserId)
                .advisors(advisorSpec -> advisorSpec.param(AbstractChatMemoryAdvisor.CHAT_MEMORY_RETRIEVE_SIZE_KEY, 100))
                .stream().content();

        return content.concatWith(Flux.just("[DONE]"));

    }
}
