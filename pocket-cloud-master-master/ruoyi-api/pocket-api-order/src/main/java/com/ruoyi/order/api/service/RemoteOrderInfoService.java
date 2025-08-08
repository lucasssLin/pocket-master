package com.ruoyi.order.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.api.factory.RemoteOrderInfoFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import com.ruoyi.common.core.constant.ServiceNameConstants;

@FeignClient(contextId = "remoteOrderInfoService", value = ServiceNameConstants.ORDER_SERVICE, fallbackFactory = RemoteOrderInfoFallbackFactory.class)
public interface RemoteOrderInfoService {

    @GetMapping("/orderInfo/getByOrderNo/{orderNo}")
    public R<OrderInfo> getByOrderNo(@PathVariable("orderNo") String orderNo, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping("/orderInfo/getSalesData/{startTime}/{endTime}")
    public R<OrderSalesVo> getSalesData(@PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping("/orderInfo/getOrderData/{userId}/{startTime}/{endTime}")
    public R<OrderSalesVo> getOrderData(@PathVariable("userId") Long userId, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}