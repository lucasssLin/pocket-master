package com.ruoyi.product.receiver;

import com.rabbitmq.client.Channel;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.product.service.IProductService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ProductReceiver {

    @Autowired
    private IProductService productService;

    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_PRODUCT, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_UNLOCK, durable = "true"),
            key = {MessageQueueConstant.ROUTING_UNLOCK}
    ))
    public void unlock(String orderNo, Message message, Channel channel) {
        try{
            if (!StringUtils.isEmpty(orderNo)){
                log.info("[Product service] listens unlock message：{}", orderNo);
                //解锁库存
                log.info("productService: {}", productService);
                productService.unlock(orderNo);
            }
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);

        }catch (Exception e){
            log.error("Error in unlock method", e);
        }

    }

    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_PRODUCT, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_MINUS, durable = "true"),
            key = {MessageQueueConstant.ROUTING_MINUS}
    ))
    public void minusStock(String orderNo, Message message, Channel channel) {
        if(!StringUtils.isEmpty(orderNo)){
            log.info("[Product service] listens minus stock message：{}", orderNo);
            productService.minusStock(orderNo);
        }
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
    }


}
