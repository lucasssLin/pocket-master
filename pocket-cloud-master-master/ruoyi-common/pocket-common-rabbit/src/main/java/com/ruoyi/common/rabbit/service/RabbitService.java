package com.ruoyi.common.rabbit.service;


import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.rabbit.entity.MessageQueueCorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.concurrent.TimeUnit;


@Service
public class RabbitService {

    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 发送消息
     * @param exchange   交换机
     * @param routingKey 路由键
     * @param message    消息
     */

    public boolean sendMessage(String exchange, String routingKey, Object message) {
        //1.创建自定义相关消息对象-包含业务数据本身，交换器名称，路由键，队列类型，延迟时间,重试次数
        MessageQueueCorrelationData messageQueueCorrelationData = new MessageQueueCorrelationData();
        String uuid = "messageQueue:" + UUID.randomUUID().toString().replaceAll("-", "");
        messageQueueCorrelationData.setId(uuid);
        messageQueueCorrelationData.setMessage(message);
        messageQueueCorrelationData.setExchange(exchange);
        messageQueueCorrelationData.setRoutingKey(routingKey);

        //2.将相关消息封装到发送消息方法中
        rabbitTemplate.convertAndSend(exchange, routingKey, message, messageQueueCorrelationData);

        //3.将相关消息存入Redis  Key：UUID  相关消息对象  10 分钟
        redisTemplate.opsForValue().set(uuid, JSON.toJSONString(messageQueueCorrelationData), 10, TimeUnit.MINUTES);
        return true;
    }

    public boolean sendDelayMessage(String exchange, String routingKey, Object message, int delayTime){
        MessageQueueCorrelationData messageQueueCorrelationData = new MessageQueueCorrelationData();
        String uuid = "messageQueue:" + UUID.randomUUID().toString().replaceAll("-", "");
        messageQueueCorrelationData.setId(uuid);
        messageQueueCorrelationData.setMessage(message);
        messageQueueCorrelationData.setExchange(exchange);
        messageQueueCorrelationData.setRoutingKey(routingKey);
        messageQueueCorrelationData.setDelay(true);
        messageQueueCorrelationData.setDelayTime(delayTime);

        //2.将相关消息封装到发送消息方法中
        rabbitTemplate.convertAndSend(exchange, routingKey, message, message1 -> {
            message1.getMessageProperties().setDelay(delayTime*1000);
        return message1;
        }, messageQueueCorrelationData);

        //3.将相关消息存入Redis  Key：UUID  相关消息对象  10 分钟
        //使用 redisTemplate.opsForValue().set 方法将消息的相关数据以JSON字符串的形式存入Redis。
        redisTemplate.opsForValue().set(uuid, JSON.toJSONString(messageQueueCorrelationData), 10, TimeUnit.MINUTES);

        return true;

    }

}
