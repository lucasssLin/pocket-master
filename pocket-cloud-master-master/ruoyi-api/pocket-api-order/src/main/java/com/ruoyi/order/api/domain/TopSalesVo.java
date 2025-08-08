package com.ruoyi.order.api.domain;

import lombok.Data;

@Data
public class TopSalesVo {
    private Long skuId;
    private String skuName;
    private Integer totalSalesQuantity;
}
