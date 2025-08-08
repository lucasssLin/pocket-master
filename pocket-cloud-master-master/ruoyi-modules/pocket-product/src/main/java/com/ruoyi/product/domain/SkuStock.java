package com.ruoyi.product.domain;

import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "product sku stock")
@Data
public class SkuStock extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Schema(description = "skuID")
    private Long skuId;

    @Schema(description = "total stock number")
    private Integer totalNum;

    @Schema(description = "lock stock Num")
    private Integer lockNum;

    @Schema(description = "available stock Num")
    private Integer availableNum;
    
    @Schema(description = "sale Num")
    private Integer saleNum;

    @Schema(description = "status：0-init，1-pass，-1-not pass")
    private Integer status;
}