package com.ruoyi.order.controller;

import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.order.config.DeadLetterMqConfig;
import com.ruoyi.order.config.DelayedMqConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mq")
public class MessageQueueController extends BaseController {

    @Autowired
    private RabbitService rabbitService;

    @GetMapping("/sendMessage")
    public AjaxResult sendMessage(){

        rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_TEST, MessageQueueConstant.ROUTING_TEST, "Hello World");
        return success();
    }

    @GetMapping("/sendConfirmMessage")
    public AjaxResult sendConfirmMessage()
    {
        rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_TEST, MessageQueueConstant.ROUTING_CONFIRM, "hello, confirm");
        return success();
    }

    @GetMapping("/sendDeadLetterMsg")
    public AjaxResult sendDeadLetterMsg() {
        rabbitService.sendMessage(DeadLetterMqConfig.exchange_dead, DeadLetterMqConfig.routing_dead_1, "DeadLetterMsg Received!!!!");
        return success();
    }

    @GetMapping("/sendDelayMsg")
    public AjaxResult sendDelayMsg() {
        //调用工具方法发送延迟消息
        int delayTime = 10;
        rabbitService.sendDelayMessage(DelayedMqConfig.exchange_delay, DelayedMqConfig.routing_delay, "Delayed Message!!!", delayTime);
        return success();
    }




}
