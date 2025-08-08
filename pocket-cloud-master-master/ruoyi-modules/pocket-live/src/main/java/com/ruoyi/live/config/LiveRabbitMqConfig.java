package com.ruoyi.live.config;

import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;



/**
 * 直播模块RabbitMQ配置
 */
@Configuration
public class LiveRabbitMqConfig {

    //直播交换机
    @Bean
    public DirectExchange liveExchange() {
        return new DirectExchange(MessageQueueConstant.EXCHANGE_LIVE, true, false);
    }


    //播间状态变更队列
    @Bean
    public Queue liveStatusQueue() {
        return new Queue(MessageQueueConstant.QUEUE_LIVE_STATUS, true);
    }


    //直播间观看人数变更队列
    @Bean
    public Queue liveViewerQueue() {
        return new Queue(MessageQueueConstant.QUEUE_LIVE_VIEWER, true);
    }


    //直播间聊天消息队列
    @Bean
    public Queue liveChatQueue() {
        return new Queue(MessageQueueConstant.QUEUE_LIVE_CHAT, true);
    }


    //直播间礼物消息队列
    @Bean
    public Queue liveGiftQueue() {
        return new Queue(MessageQueueConstant.QUEUE_LIVE_GIFT, true);
    }

    //绑定直播间状态变更队列到交换机
    @Bean
    public Binding liveStatusBinding() {
        return BindingBuilder.bind(liveStatusQueue())
                .to(liveExchange())
                .with(MessageQueueConstant.ROUTING_LIVE_STATUS);
    }


    //绑定直播间观看人数变更队列到交换机
    @Bean
    public Binding liveViewerBinding() {
        return BindingBuilder.bind(liveViewerQueue())
                .to(liveExchange())
                .with(MessageQueueConstant.ROUTING_LIVE_VIEWER);
    }


    //绑定直播间聊天消息队列到交换机

    @Bean
    public Binding liveChatBinding() {
        return BindingBuilder.bind(liveChatQueue())
                .to(liveExchange())
                .with(MessageQueueConstant.ROUTING_LIVE_CHAT);
    }

    //绑定直播间礼物消息队列到交换机

    @Bean
    public Binding liveGiftBinding() {
        return BindingBuilder.bind(liveGiftQueue())
                .to(liveExchange())
                .with(MessageQueueConstant.ROUTING_LIVE_GIFT);
    }
} 