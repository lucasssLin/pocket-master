package com.ruoyi.payment.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.payment.domain.PaymentInfo;

import java.util.Map;

public interface IPaymentInfoService extends IService<PaymentInfo> {

    PaymentInfo savePaymentInfo(String orderNo);

    void updatePaymentStatus(Map<String, String> map, Integer payType);
}