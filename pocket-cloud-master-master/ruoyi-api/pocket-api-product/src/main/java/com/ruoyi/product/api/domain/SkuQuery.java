package com.ruoyi.product.api.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class SkuQuery
{

    @Schema(description = "keyword")
    private String keyword;

    @Schema(description = "brandId")
    private Long brandId;

    @Schema(description = "category1Id")
    private Long category1Id;

    @Schema(description = "category2Id")
    private Long category2Id;

    @Schema(description = "category3Id")
    private Long category3Id;

    @Schema(description = "order（comprehensive ranking:1  Upward price order:2  Falling price order:3）")
    private Integer order = 1;
}