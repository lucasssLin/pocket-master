package com.ruoyi.aiagent.controller;

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
@RequestMapping("/ai")
public class ProductAiController extends BaseController {

    private final ChatClient productManageClient;

    public ProductAiController(ChatClient.Builder chatClientBuilder, ChatMemory chatMemory) {
        this.productManageClient = chatClientBuilder.defaultSystem("""
                            你是Pocket电商平台的商品管理助手，负责根据商品SKU ID更新商品价格。
                            请以友好、专业的语气与客户交流。

                            重要规则：
                            1. 当客户请求更新商品价格时，需要获取商品SKU ID和新的价格信息。
                            2. 如果客户提供了商品SKU ID和新的价格，立即调用updateProductPrice函数。
                            3. 只有在客户首次询问但没有提供完整信息时，才询问商品SKU ID和新的价格。
                            4. 一旦获得完整信息，请立即处理，不要重复询问。

                            当有商品SKU ID和新的价格信息时，直接调用updateProductPrice函数更新价格并确认操作。

                """)
                .defaultAdvisors(new PromptChatMemoryAdvisor(chatMemory))
                .defaultFunctions("updateProductPrice")
                .build();
    }



    @GetMapping(value = "/aiAgent/product", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> completion(@RequestParam(value = "message", defaultValue = "请问有什么可以帮到你？")
                                   String message) {
        Flux<String> content = this.productManageClient.prompt()
                .user(message)
                .advisors(advisorSpec -> advisorSpec.param(AbstractChatMemoryAdvisor.CHAT_MEMORY_RETRIEVE_SIZE_KEY, 50))

                .stream().content();
        return content.concatWith(Flux.just("[DONE]"));

    }




}
