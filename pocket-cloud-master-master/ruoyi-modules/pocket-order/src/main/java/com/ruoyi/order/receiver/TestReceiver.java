package com.ruoyi.order.receiver;

import com.rabbitmq.client.Channel;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.order.config.DeadLetterMqConfig;
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

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class TestReceiver {

    @Autowired
    private RedisTemplate redisTemplate;

    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_TEST, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_TEST, durable = "true"),
            key = MessageQueueConstant.ROUTING_TEST
    ))
    public void receiveMessage(String content, Message message){
        log.info("Receive message：{}", content);
        log.info("Receive message：{}", new String(message.getBody()));
    }


    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_TEST, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_CONFIRM, durable = "true"),
            key = MessageQueueConstant.ROUTING_CONFIRM
    ))
    public void confirmMessage(String content, Message message, Channel channel){
        log.info("Receive confirm message：{}", content);
        // false 确认一个消息，true 批量确认
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
    }

    @SneakyThrows
    @RabbitListener(queues = {DeadLetterMqConfig.queue_dead_2})
    public void getDeadLetterMsg(String msg, Message message, Channel channel) {
        String key = "mq" + msg + UUID.randomUUID().toString();
        Boolean flag = redisTemplate.opsForValue().setIfAbsent(key, "", 20, TimeUnit.SECONDS);

        if(!flag){
            //已经执行过
            log.info("Message already processed, acknowledging message with delivery tag: {}", message.getMessageProperties().getDeliveryTag());
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
            return;
        }

        log.info("DeadLetterCustomer：{}", msg);
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
    }

    @SneakyThrows
    @RabbitListener(queues = {"queue.delay.1"})
    public void getDelayLetterMsg(String msg, Message message, Channel channel) {
        String key = "mq" + msg + UUID.randomUUID().toString();
        Boolean flag = redisTemplate.opsForValue().setIfAbsent(key, "", 20, TimeUnit.SECONDS);

        if(!flag){
            //已经执行过
            log.info("Message already processed, acknowledging message with delivery tag: {}", message.getMessageProperties().getDeliveryTag());
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
            return;
        }

        log.info("DelayLetterCustomer：{}", msg);
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
    }

}
