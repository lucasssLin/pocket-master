package com.ruoyi.product.api.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
public class Product extends BaseEntity {

    private static final long serialVersionUID = 1L;


    @Schema(description = "Product Name")
    private String name;


    @Schema(description = "Brand ID")
    private Long brandId;


    @Schema(description = "category1Id")
    private Long category1Id;


    @Schema(description = "category2Id")
    private Long category2Id;


    @Schema(description = "category3Id")
    private Long category3Id;


    @Schema(description = "Unit Name")
    private String unitName;


    @Setter
    @Getter
    @Schema(description = "Slider Urls")
    private String sliderUrls;


    @Schema(description = "specValue JSON")
    private String specValue;


    @Schema(description = "Product Status：0-init，1-issued，-1-not issued")
    private Integer status;


    @Schema(description = "auditStatus：0-init，1-pass，-1-not pass")
    private Integer auditStatus;


    @Schema(description = "auditMessage")
    private String auditMessage;


    @Schema(description = "brandName")
    @TableField(exist = false)
    private String brandName;


    @Schema(description = "category1Name")
    @TableField(exist = false)
    private String category1Name;


    @Schema(description = "category2Name")
    @TableField(exist = false)
    private String category2Name;


//    @Schema(description = "category3Name")
//    @TableField(exist = false)
//    private String category3Name;


    @Schema(description = "Product sku List")
    @TableField(exist = false)
    private List<ProductSku> productSkuList;

    @TableField(exist = false)
    private List<ProductSpecs> specsList;


    @TableField(exist = false)
    private ProductDetails productDetails;

    @Schema(description = "description")
    private String description;

    @TableField(exist = false)
    private ProductSku productSku;

}