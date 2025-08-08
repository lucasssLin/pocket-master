package com.ruoyi.payment.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipayTradeCloseRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradeCloseResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ruoyi.payment.config.AlipayConfig;
import com.ruoyi.payment.domain.PaymentInfo;
import com.ruoyi.payment.service.IAlipayService;
import com.ruoyi.payment.service.IPaymentInfoService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
@Slf4j
public class AlipayServiceImpl implements IAlipayService {

    @Autowired
    private AlipayClient alipayClient;

    @Autowired
    private IPaymentInfoService paymentInfoService;

    @SneakyThrows
    @Override
    public String submitAlipay(String orderNo) {


        //保存支付记录
        PaymentInfo paymentInfo = paymentInfoService.savePaymentInfo(orderNo);
        // 生产二维码
        AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();//创建API对应的request
        // 同步回调
        alipayRequest.setReturnUrl(AlipayConfig.return_payment_url);
        // 异步回调
        alipayRequest.setNotifyUrl(AlipayConfig.notify_payment_url);//在公共参数中设置回跳和通知地址
        // 参数
        // 声明一个map 集合
        HashMap<String, Object> map = new HashMap<>();
        map.put("out_trade_no",paymentInfo.getOrderNo());
        map.put("product_code","QUICK_WAP_WAY");
        //map.put("total_amount",orderInfo.getTotalAmount());
        map.put("total_amount",paymentInfo.getAmount());
        map.put("subject",paymentInfo.getContent());

        alipayRequest.setBizContent(JSON.toJSONString(map));

        return alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单;
    }

    @Override
    public void closePayment(String orderNo) {
        //1.查询交易记录
        PaymentInfo paymentInfo = paymentInfoService.getOne(new LambdaQueryWrapper<PaymentInfo>().eq(PaymentInfo::getOrderNo, orderNo));
        //2.判断交易记录是否存在，并且未支付
        if (paymentInfo != null && paymentInfo.getPaymentStatus().intValue() == 0) {
            //3 产生本地交易记录 要进行关闭
            paymentInfo.setPaymentStatus(-1);
            paymentInfoService.updateById(paymentInfo);

            //4.查询支付宝交易记录是否关闭
            Boolean flag = this.checkAlipayPayment(orderNo);
            if (flag) {
                this.closeAlipayTrade(orderNo);
            }
        }
    }


    /**
     * 查看是否有交易记录是否可以关闭
     */
    private Boolean checkAlipayPayment(String orderNo) {
        try {
            AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
            JSONObject bizContent = new JSONObject();
            bizContent.put("out_trade_no", orderNo);
            request.setBizContent(bizContent.toString());
            AlipayTradeQueryResponse response = alipayClient.execute(request);
            if (response.isSuccess()) {
                //交易状态：WAIT_BUYER_PAY（交易创建，等待买家付款）、TRADE_CLOSED（未付款交易超时关闭，或支付完成后全额退款）、TRADE_SUCCESS（交易支付成功）、TRADE_FINISHED（交易结束，不可退款）
                if ("WAIT_BUYER_PAY".equals(response.getTradeStatus())) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 关闭支付宝交易
     */
    private Boolean closeAlipayTrade(String orderNo) {
        try {
            AlipayTradeCloseRequest request = new AlipayTradeCloseRequest();
            JSONObject bizContent = new JSONObject();
            bizContent.put("out_trade_no", orderNo);
            request.setBizContent(bizContent.toString());
            AlipayTradeCloseResponse response = alipayClient.execute(request);
            if (response.isSuccess()) {
                log.info("支付宝关闭交易调用成功");
                return true;
            } else {
                log.info("支付宝关闭交易调用失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}