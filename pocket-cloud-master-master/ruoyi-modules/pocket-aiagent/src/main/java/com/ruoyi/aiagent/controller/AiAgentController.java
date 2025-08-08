package com.ruoyi.aiagent.controller;

import com.ruoyi.aiagent.service.TongYiService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.order.api.service.RemoteOrderInfoService;


import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.AbstractChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.PromptChatMemoryAdvisor;

import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

import java.util.Map;

@RestController
@RequestMapping("/ai")
public class AiAgentController extends BaseController {

    private final ChatClient chatClient;

    public AiAgentController(ChatClient.Builder chatClientBuilder, ChatMemory chatMemory) {
        this.chatClient = chatClientBuilder.defaultSystem("""
                你是Pocket电商平台的智能客服，请以友好的、客气的语气跟顾客进行交流，你现在正在通过在线客服聊天系统与客户互动。
                在提供获取订单销售数据信息之前，你需要始终从客户中获取以下信息：开始时间、结束时间
                """)
                .defaultAdvisors(new PromptChatMemoryAdvisor(chatMemory))
                .defaultFunctions("getSalesData")
                .build();
    }



    @GetMapping(value = "/aiAgent", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> completion(@RequestParam(value = "message", defaultValue = "请问有什么可以帮到你？")
            String message) {
        Flux<String> content = this.chatClient.prompt()
                .user(message)
                .advisors(advisorSpec -> advisorSpec.param(AbstractChatMemoryAdvisor.CHAT_MEMORY_RETRIEVE_SIZE_KEY, 50))

                .stream().content();
        return content.concatWith(Flux.just("[DONE]"));

    }


}
