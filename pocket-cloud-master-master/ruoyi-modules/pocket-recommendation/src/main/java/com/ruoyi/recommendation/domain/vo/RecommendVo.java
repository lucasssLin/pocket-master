package com.ruoyi.recommendation.domain.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class RecommendVo {
    private Long spuId;

    private String picture;

    private String name;

    private BigDecimal price;

    private String desc;

    private BigDecimal discount;
}