package com.ruoyi.cart.api.domain;

import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "Cart")
public class CartInfo extends BaseEntity {

   private static final long serialVersionUID = 1L;

   @Schema(description = "userId")
   private Long userId;

   @Schema(description = "skuid")
   private Long skuId;

   @Schema(description = "product price when put in cart")
   private BigDecimal cartPrice;

   @Schema(description = "current product price")
   private BigDecimal skuPrice;  

   @Schema(description = "sku number")
   private Integer count;

   @Schema(description = "image")
   private String thumbImg;

   @Schema(description = "sku name")
   private String skuName;

   @Schema(description = "isChecked")
   private Boolean isChecked = true;

   private Long spuId;

   private String attrsText;

   private Integer stock;

   private Boolean isCollect;

   private Boolean isEffective;

   private BigDecimal marketPrice;
}