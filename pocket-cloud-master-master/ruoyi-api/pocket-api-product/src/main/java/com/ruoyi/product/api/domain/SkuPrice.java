package com.ruoyi.product.api.domain;

import io.swagger.v3.oas.annotations.media.Schema;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class SkuPrice {

    @Schema(description = "skuId")
    private Long skuId;

    @Schema(description = "salePrice")
    private BigDecimal salePrice;

    /**
     * 市场价
     */
    @Schema(description = "marketPrice")
    private BigDecimal marketPrice;
}