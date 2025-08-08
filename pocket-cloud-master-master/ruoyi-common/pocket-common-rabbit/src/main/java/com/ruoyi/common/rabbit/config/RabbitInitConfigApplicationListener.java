package com.ruoyi.common.rabbit.config;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.rabbit.entity.MessageQueueCorrelationData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class RabbitInitConfigApplicationListener implements ApplicationListener<ApplicationReadyEvent> {


    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {
        this.setupCallbacks();
    }

    private void setupCallbacks() {

        /*
         * 只确认消息是否正确到达 Exchange 中,成功与否都会回调
         *
         * @param correlation 相关数据  非消息本身业务数据
         * @param ack             应答结果
         * @param reason           如果发送消息到交换器失败，错误原因
         */

        this.rabbitTemplate.setConfirmCallback((correlation, ack, reason)->{
            if (ack) {
                //消息到交换器成功
                log.info("Successfully sent message to exchange:{}", correlation);
            }
            else {
                //消息到交换器失败
                log.error("Failed to send message to exchange:{}", reason);

                this.retrySendMsg(correlation);

            }

        });

        /*
         * 消息没有正确到达队列时触发回调，如果正确到达队列不执行
         */
        this.rabbitTemplate.setReturnsCallback(returned -> {
            log.error("Returned:" + returned.getMessage() + "\nreplyCode: " + returned.getReplyCode()
                    + "\nreplyText: " + returned.getReplyText() + "\nexchange/rk: "
                    + returned.getExchange() + "/" + returned.getRoutingKey());

            //当路由队列失败 也需要重发
            //1.构建相关数据对象
            String redisKey = returned.getMessage().getMessageProperties().getHeader("spring_returned_message_correlation");
            if (redisKey == null) {
                log.error("Redis key is null, cannot retry message.");
                return;
            }
            //从 Redis 中获取与失败消息相关联的 correlationData 数据。
            String correlationDataStr = (String) redisTemplate.opsForValue().get(redisKey);

            MessageQueueCorrelationData correlationData = JSON.parseObject(correlationDataStr, MessageQueueCorrelationData.class);

            //todo 方式一:如果不考虑延迟消息重发 直接返回
//            if(correlationData.isDelay()){
//                return;
//            }

            //2.调用消息重发方法
            this.retrySendMsg(correlationData);

        });

    }


    private void retrySendMsg(CorrelationData correlationData) {
        MessageQueueCorrelationData messageQueueCorrelationData = (MessageQueueCorrelationData) correlationData;

        //获取redis中存放重试次数
        //先重发，在写会到redis中次数
        int retryCount = messageQueueCorrelationData.getRetryCount();



        if (retryCount >= 3) {
            //超过最大重试次数
            log.error(" The producer exceeds the maximum retries and saves the failed message to the database for manual processing.");
            return;
        }else {
            log.info("Reties time：{}",retryCount,"cannot be processed.");
        }

        retryCount += 1;
        messageQueueCorrelationData.setRetryCount(retryCount);
        redisTemplate.opsForValue().set(messageQueueCorrelationData.getId(), JSON.toJSONString(messageQueueCorrelationData), 10, TimeUnit.MINUTES);



        //重发消息
        //todo 方式二：如果是延迟消息，依然需要设置消息延迟时间
        if (messageQueueCorrelationData.isDelay()) {
            //延迟消息
            rabbitTemplate.convertAndSend(messageQueueCorrelationData.getExchange(),
                    messageQueueCorrelationData.getRoutingKey(),
                    messageQueueCorrelationData.getMessage(),
                    message -> {message.getMessageProperties().setDelay(messageQueueCorrelationData.getDelayTime()*1000);
            return message;},
                    messageQueueCorrelationData);

        } else {
            //普通消息
            rabbitTemplate.convertAndSend(messageQueueCorrelationData.getExchange(),
                    messageQueueCorrelationData.getRoutingKey(),
                    messageQueueCorrelationData.getMessage(),
                    messageQueueCorrelationData);

            log.info("Message resent！");
        }

    }

}
