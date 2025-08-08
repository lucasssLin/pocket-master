package com.ruoyi.order.config;

import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.CustomExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;
@Configuration
public class CancelOrderMqConfig {
    @Bean
    public Queue cancelQueue() {
        // 第一个参数是创建的queue的名字，第二个参数是是否支持持久化
        return new Queue(MessageQueueConstant.QUEUE_CANCEL_ORDER, true);
    }

    @Bean
    public CustomExchange cancelExchange() {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("x-delayed-type", "direct");
        return new CustomExchange(MessageQueueConstant.EXCHANGE_CANCEL_ORDER, "x-delayed-message", true, false, args);
    }

    @Bean
    public Binding bindingCancel() {
        return BindingBuilder.bind(cancelQueue()).to(cancelExchange()).with(MessageQueueConstant.ROUTING_CANCEL_ORDER).noargs();
    }

}
