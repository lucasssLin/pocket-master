package com.ruoyi.payment.controller;

import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.security.annotation.RequiresLogin;
import com.ruoyi.payment.domain.PaymentInfo;
import com.ruoyi.payment.service.IPaymentInfoService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;


@Slf4j
@RestController
@RequestMapping("/mockpay")
public class MockController extends BaseController {

    @Autowired
    private IPaymentInfoService paymentInfoService;

    @Operation(summary = "模拟支付")
    @RequiresLogin
    @RequestMapping("submitMockPay/{orderNo}")
    public AjaxResult submitMockPay(@PathVariable(value = "orderNo") String orderNo) {
        // Return empty form string, payment will be handled on frontend
        PaymentInfo paymentInfo = paymentInfoService.savePaymentInfo(orderNo);
        return success(paymentInfo);
    }

    @Operation(summary = "验证模拟支付密码并完成支付")
    @RequiresLogin
    @RequestMapping("verifyPayment/{orderNo}")
    public AjaxResult verifyPayment(
            @PathVariable(value = "orderNo") String orderNo,
            @RequestParam(value = "password") String password) {

        log.info("验证模拟支付密码: {}", orderNo);

        // Check if password is correct (for demo, use "123456" as correct password)
        if ("123456".equals(password)) {
            // Process successful payment
            HashMap<String, String> map = new HashMap<>();
            map.put("trade_no", orderNo);
            map.put("out_trade_no",orderNo);
            paymentInfoService.updatePaymentStatus(map, 3);
            return success(true);
        } else {
            return error("支付密码错误，请重试");
        }
    }
}
