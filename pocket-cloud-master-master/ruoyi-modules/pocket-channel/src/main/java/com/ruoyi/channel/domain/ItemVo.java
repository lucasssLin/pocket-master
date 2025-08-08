package com.ruoyi.channel.domain;

import com.alibaba.fastjson2.JSONArray;
import com.ruoyi.product.api.domain.*;
import io.swagger.v3.core.util.Json;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
@Schema(description = "商品详情对象")
public class ItemVo {

   @Schema(description = "商品sku信息")
   private ProductSku productSku;

   private List<ProductSku> productSkuList;

   @Schema(description = "商品信息")
   private Product product;

   @Schema(description = "最新价格信息")
   private List<SkuPrice> skuPriceList;

   @Schema(description = "商品轮播图列表")
   private List<String> sliderUrlList;

   @Schema(description = "商品详情图片列表")
   private List<String> detailsImageUrlList;

   @Schema(description = "商品规格信息")
   private List<ProductSpecs> specValueList;

   @Schema(description = "商品库存信息")
   private SkuStockVo skuStockVo;

   private List<SkuStockVo> skuStockVoList;

   @Schema(description = "商品规格对应商品skuId信息")
   private Map<String,Long> skuSpecValueMap;

   private List<Map<String, String>> properties;

}