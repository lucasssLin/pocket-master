package com.ruoyi.order.api.domain;

import lombok.Data;
import java.math.BigDecimal;
import java.util.List;


@Data
public class OrderSalesVo {

    private BigDecimal totalSalesAmount;
    private BigDecimal growthRate;
    private List<TopSalesVo> topSalesVosList;

}
