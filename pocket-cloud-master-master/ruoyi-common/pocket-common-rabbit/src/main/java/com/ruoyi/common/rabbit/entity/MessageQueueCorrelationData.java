package com.ruoyi.common.rabbit.entity;

import lombok.Data;
import org.springframework.amqp.rabbit.connection.CorrelationData;

@Data
public class MessageQueueCorrelationData extends CorrelationData {
    private Object message;

    private String exchange;

    private String routingKey;

    private int retryCount = 0;
    //是否延迟消息
    private boolean isDelay = false;
    //延迟时长
    private int delayTime = 10;

}
