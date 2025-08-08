package com.ruoyi.product.api.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Schema(description = "ProductSku")
@Data
public class ProductSku extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Schema(description = "skuCode")
    private String skuCode;

    @Schema(description = "skuName")
    private String skuName;

    @Schema(description = "productId")
    private Long productId;

    @Schema(description = "thumbImg url")
    private String thumbImg;

    @Schema(description = "salePrice")
    private BigDecimal salePrice;

    @Schema(description = "marketPrice")
    private BigDecimal marketPrice;

    @Schema(description = "costPrice")
    private BigDecimal costPrice;

    @Schema(description = "skuSpec name json")
    private String skuSpec;

    @Schema(description = "weight")
    private BigDecimal weight;

    @Schema(description = "volume")
    private BigDecimal volume;

    @Schema(description = "status：0-init，1-issued，-1-not issued")
    private Integer status;

    private BigDecimal discount;

    // 扩展的属性
    @Schema(description = "sku stock number")
    @TableField(exist = false)
    private Integer stockNum;

    @Schema(description = "sku sales number")
    @TableField(exist = false)
    private Integer saleNum;
}