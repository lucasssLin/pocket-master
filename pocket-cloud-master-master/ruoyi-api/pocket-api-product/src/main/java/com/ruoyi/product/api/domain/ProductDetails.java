package com.ruoyi.product.api.domain;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "商品详情")
@Data
public class ProductDetails extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 商品id
     */
    @Schema(description = "商品id")
    private Long productId;

    /**
     * 详情图片地址
     */
    @Schema(description = "详情图片地址")
    private String imageUrls;

    private String properties;

}