package com.ruoyi.channel.domain;

import lombok.Data;

import java.math.BigDecimal;
@Data
public class RelevantVo {
    private Long spuId;

    private String picture;

    private String name;

    private BigDecimal price;

    private String desc;

    private BigDecimal discount;
}
