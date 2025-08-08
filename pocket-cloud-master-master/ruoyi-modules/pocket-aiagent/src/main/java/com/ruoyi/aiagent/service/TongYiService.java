package com.ruoyi.aiagent.service;

import org.springframework.ai.image.ImageResponse;
import reactor.core.publisher.Flux;

public interface TongYiService {

    /**
     * 基本问答
     */
    Flux<String> completion(String message);
    /**
     * 文生图
     */
    //ImageResponse genImg(String imgPrompt);

    /**
     * 语音合成
     */
    //String genAudio(String text);

}
