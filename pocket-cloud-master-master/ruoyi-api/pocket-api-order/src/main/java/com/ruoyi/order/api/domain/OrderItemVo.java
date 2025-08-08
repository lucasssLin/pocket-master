package com.ruoyi.order.api.domain;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class OrderItemVo extends OrderItem{

    private Long spuId;

    private String attrsText;

    private BigDecimal originalPrice;

    private BigDecimal totalOriginalPrice;

    private BigDecimal totalSkuPrice;

}
