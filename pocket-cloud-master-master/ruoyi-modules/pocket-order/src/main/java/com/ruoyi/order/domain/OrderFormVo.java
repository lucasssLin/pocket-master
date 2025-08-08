package com.ruoyi.order.domain;

import com.ruoyi.order.api.domain.OrderItem;
import com.ruoyi.order.api.domain.OrderItemVo;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
@Data
public class OrderFormVo {

    private List<OrderItemVo> orderItemVoList;

    private BigDecimal freightFee;

    private String tradeNo;

    private String addressId;

    private Integer deliveryTimeType;

    private String buyerMessage;

    private Integer payType;

    private Integer payChannel;
}
