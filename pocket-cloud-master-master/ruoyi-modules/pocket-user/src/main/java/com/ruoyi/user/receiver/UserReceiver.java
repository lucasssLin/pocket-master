package com.ruoyi.user.receiver;

import com.alibaba.fastjson2.JSON;
import com.rabbitmq.client.Channel;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.user.service.IUserBrowseHistoryService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class UserReceiver {
    @Autowired
    private IUserBrowseHistoryService userBrowseHistoryService;
    @Autowired
    private RabbitService rabbitService;
    @Autowired
    private RedisTemplate redisTemplate;

    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_BROWSE_HISTORY, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_BROWSE_HISTORY, durable = "true"),
            key = MessageQueueConstant.ROUTING_BROWSE_HISTORY
    ))
    public void createBrowseHistory(String mapJsonStr, Message message, Channel channel) {
        System.out.println("浏览历史的监听");

        HashMap<String, Object> map = JSON.parseObject(mapJsonStr, HashMap.class);

        Long spuId = Long.valueOf(map.get("spuId").toString());
        Long userId = Long.valueOf(map.get("userId").toString());

        String key = "mq:" + spuId;
        Boolean flag = redisTemplate.opsForValue().setIfAbsent(key, "", 5, TimeUnit.SECONDS);
        if(!flag){
            //说明该业务数据以及被执行
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
            return;
        }

        try {
            log.info("接收确认消息：{}", spuId);
            userBrowseHistoryService.createBrowseHistory(spuId, userId);
            // false 确认一个消息，true 批量确认
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        }catch (Exception e) {
            //回滚消息
            //手动应答 false 确认一个消息，true 批量确认，并将消息重新放回队列末尾，以便之后重新尝试消费。
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, true);
        }
    }

}