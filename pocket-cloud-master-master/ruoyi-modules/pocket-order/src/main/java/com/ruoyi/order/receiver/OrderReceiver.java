package com.ruoyi.order.receiver;

import com.rabbitmq.client.Channel;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.service.IOrderInfoService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
public class OrderReceiver {
    @Autowired
    private IOrderInfoService orderInfoService;
    @Autowired
    private RabbitService rabbitService;

    @SneakyThrows
    @RabbitListener(queues = MessageQueueConstant.QUEUE_CANCEL_ORDER)
    public void processCloseOrder(String orderNo, Message message, Channel channel) throws IOException {

        if(orderNo != null){
            log.info("[Order service] close order：{}", orderNo);
            //关闭订单
            orderInfoService.processCloseOrder(orderNo);

            //发送MQ消息通知支付系统关闭可能产生本地交易记录跟支付宝交易记录
            OrderInfo orderInfo = orderInfoService.getByOrderNo(orderNo);
            if (orderInfo != null) {
                rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PAYMENT_PAY, MessageQueueConstant.ROUTING_PAYMENT_CLOSE, orderInfo.getOrderNo());
            }

        }
        //2.手动应答
        // false 确认一个消息，true 批量确认，并将消息重新放回队列末尾，以便之后重新尝试消费。
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);

    }

    //监听订单支付成功消息；更新订单状态
    @SneakyThrows
    @RabbitListener(bindings = @QueueBinding(
            exchange = @Exchange(value = MessageQueueConstant.EXCHANGE_PAYMENT_PAY, durable = "true"),
            value = @Queue(value = MessageQueueConstant.QUEUE_PAYMENT_PAY, durable = "true"),
            key = MessageQueueConstant.ROUTING_PAYMENT_PAY
    ))
    public void processPaySuccess(String orderNo, Message message, Channel channel) {
        //业务处理
        if (StringUtils.isNotEmpty(orderNo)) {
            log.info("[订单服务]监听订单支付成功消息：{}", orderNo);
            //更改订单支付状态
            orderInfoService.processPaySuccess(orderNo);
            //基于MQ通知扣减库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_MINUS, orderNo);
        }
        //手动应答
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
    }

}
