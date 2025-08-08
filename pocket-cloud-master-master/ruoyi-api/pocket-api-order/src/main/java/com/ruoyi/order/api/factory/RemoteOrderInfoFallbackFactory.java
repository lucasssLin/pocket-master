package com.ruoyi.order.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.api.service.RemoteOrderInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class RemoteOrderInfoFallbackFactory implements FallbackFactory<RemoteOrderInfoService>
{
    private static final Logger log = LoggerFactory.getLogger(RemoteOrderInfoFallbackFactory.class);

    @Override
    public RemoteOrderInfoService create(Throwable throwable)
    {
        log.error("订单服务调用失败:{}", throwable.getMessage());
        return new RemoteOrderInfoService()
        {

            @Override
            public R<OrderInfo> getByOrderNo(String orderNo, String source) {
                return R.fail("根据订单号获取订单信息失败:" + throwable.getMessage());
            }

            @Override
            public R<OrderSalesVo> getSalesData(String startTime, String endTime, String source) {
                return R.fail("getSalesData failed:" + throwable.getMessage());
            }

            @Override
            public R<OrderSalesVo> getOrderData(Long userId, String startTime, String endTime, String source) {
                return R.fail("getOrderData failed:" + throwable.getMessage());
            }
        };
    }
}