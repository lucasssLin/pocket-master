package com.ruoyi.payment.service.impl;


import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.api.domain.OrderItem;
import com.ruoyi.order.api.service.RemoteOrderInfoService;
import com.ruoyi.payment.domain.PaymentInfo;
import com.ruoyi.payment.mapper.PaymentInfoMapper;
import com.ruoyi.payment.service.IPaymentInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 支付信息表 服务层实现
 */
@Service
public class PaymentInfoServiceImpl extends ServiceImpl<PaymentInfoMapper, PaymentInfo> implements IPaymentInfoService {
    @Autowired
    private PaymentInfoMapper paymentInfoMapper;

    @Autowired
    private RemoteOrderInfoService remoteOrderInfoService;
    @Autowired
    private RabbitService rabbitService;


    @Override
    public PaymentInfo savePaymentInfo(String orderNo) {
        PaymentInfo paymentInfo = paymentInfoMapper.selectOne(new LambdaQueryWrapper<PaymentInfo>().eq(PaymentInfo::getOrderNo, orderNo));
        if(null == paymentInfo) {
            R<OrderInfo> orderInfoResult = remoteOrderInfoService.getByOrderNo(orderNo, SecurityConstants.INNER);
            if (R.FAIL == orderInfoResult.getCode()) {
                throw new ServiceException(orderInfoResult.getMsg());
            }
            OrderInfo orderInfo = orderInfoResult.getData();

            paymentInfo = new PaymentInfo();
            paymentInfo.setUserId(orderInfo.getUserId());
            String content = "";
            for(OrderItem item : orderInfo.getOrderItemList()) {
                content += item.getSkuName() + " ";
            }
            paymentInfo.setContent(content);
            paymentInfo.setAmount(orderInfo.getTotalAmount());
            paymentInfo.setOrderNo(orderNo);
            paymentInfo.setPaymentStatus(0);
            paymentInfoMapper.insert(paymentInfo);
        }else if(paymentInfo.getPaymentStatus().intValue() == 1) {
            throw new ServiceException("订单已支付");
        }
        return paymentInfo;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updatePaymentStatus(Map<String, String> map, Integer payType) {
        PaymentInfo paymentInfo = paymentInfoMapper.selectOne(new LambdaQueryWrapper<PaymentInfo>().eq(PaymentInfo::getOrderNo, map.get("out_trade_no")));
        if (paymentInfo.getPaymentStatus().intValue() == 1) {
            return;
        }

        //更新支付信息
        paymentInfo.setPayType(payType);
        paymentInfo.setPaymentStatus(1);
        paymentInfo.setTradeNo(map.get("trade_no"));
        paymentInfo.setCallbackTime(new Date());
        paymentInfo.setCallbackContent(JSON.toJSONString(map));
        paymentInfoMapper.updateById(paymentInfo);

        //基于MQ通知订单系统，修改订单状态
        rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PAYMENT_PAY, MessageQueueConstant.ROUTING_PAYMENT_PAY, paymentInfo.getOrderNo());
    }
}
