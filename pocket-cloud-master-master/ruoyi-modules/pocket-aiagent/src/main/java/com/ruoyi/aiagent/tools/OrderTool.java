package com.ruoyi.aiagent.tools;

import com.alibaba.dashscope.tools.FunctionDefinition;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.api.domain.TopSalesVo;
import com.ruoyi.order.api.service.RemoteOrderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Description;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Configuration
public class OrderTool {
    @Autowired
    private RemoteOrderInfoService  remoteOrderInfoService;

    // 定义 getSalesData 函数描述
    public record GetSalesDataRequest(String startTime, String endTime){}
    // 前台用户消费数据查询 - 包含userId参数
    public record GetOrderDataRequest(Long userId, String startTime, String endTime) {}

    @Bean
    @Description("处理根据开始时间和结束时间获取订单销售数据")
    public Function<GetSalesDataRequest,String> getSalesData(){
        return getSalesDataRequest -> {
            R<OrderSalesVo> salesDataResult = remoteOrderInfoService.getSalesData(getSalesDataRequest.startTime, getSalesDataRequest.endTime, SecurityConstants.INNER);
            if (R.FAIL == salesDataResult.getCode()) {
                throw new ServiceException(salesDataResult.getMsg());
            }
            OrderSalesVo orderSalesVo = salesDataResult.getData();
            return formatSalesData(orderSalesVo);
        };
    }

    public String formatSalesData(OrderSalesVo orderSalesVo) {
        if (orderSalesVo == null) {
            return "没有找到销售数据";
        }
        StringBuilder result = new StringBuilder();

        result.append("销售数据摘要:\n");
        result.append("- 总销售额: ¥").append(orderSalesVo.getTotalSalesAmount()).append("\n");
        result.append("- 较上月的增长率: ").append(orderSalesVo.getGrowthRate().multiply(BigDecimal.valueOf(100))+"%").append("\n");

        if (orderSalesVo.getTopSalesVosList() != null && !orderSalesVo.getTopSalesVosList().isEmpty()) {
            result.append("\n热销商品排行:\n");
            int rank = 1;
            for (TopSalesVo product : orderSalesVo.getTopSalesVosList()) {
                result.append(rank++).append(". ")
                        .append(product.getSkuName())
                        .append(" - 销量: ").append(product.getTotalSalesQuantity())
                        .append("\n");
            }
        }
        return result.toString();
    }


    @Bean
    @Description("处理根据开始时间和结束时间获取订单消费数据")
    public Function<GetOrderDataRequest,String> getFrontStageSalesData(){
        return getOrderDataRequest -> {
            Long userId = getOrderDataRequest.userId;

            R<OrderSalesVo> salesDataResult = remoteOrderInfoService.getOrderData(userId, getOrderDataRequest.startTime, getOrderDataRequest.endTime, SecurityConstants.INNER);
            if (R.FAIL == salesDataResult.getCode()) {
                throw new ServiceException(salesDataResult.getMsg());
            }
            OrderSalesVo orderSalesVo = salesDataResult.getData();
            return formatUserSalesData(orderSalesVo);
        };
    }

    // 专门为用户消费数据格式化的方法
    public String formatUserSalesData(OrderSalesVo orderSalesVo) {
        if (orderSalesVo == null) {
            return "没有找到您的消费数据";
        }
        StringBuilder result = new StringBuilder();

        result.append("📊 您的消费数据分析\n\n");
        result.append("💰 消费总额: ¥").append(orderSalesVo.getTotalSalesAmount()).append("\n");
        result.append("📈 较上期增长: ").append(orderSalesVo.getGrowthRate().multiply(BigDecimal.valueOf(100))).append("%").append("\n");

        if (orderSalesVo.getTopSalesVosList() != null && !orderSalesVo.getTopSalesVosList().isEmpty()) {
            result.append("\n🛍️ 您的购买偏好:\n");
            int rank = 1;
            for (TopSalesVo product : orderSalesVo.getTopSalesVosList()) {
                result.append(rank++).append(". ")
                        .append(product.getSkuName())
                        .append(" (购买 ").append(product.getTotalSalesQuantity()).append(" 件)")
                        .append("\n");
            }
        }

        result.append("\n💡 消费建议:\n");
        result.append("- 您的消费习惯很健康，继续保持\n");
        result.append("- 关注我们的会员优惠活动\n");
        result.append("- 可设置月度消费预算提醒");

        return result.toString();
    }
}
