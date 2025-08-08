package com.ruoyi.product.api.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
public class ProductSpecs extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Long productId;

    private String specName;

    private Long categoryId;

    @TableField(exist = false)
    private List<ProductSpecValues> values;

    @Schema(description = "categoryIdList")
    @TableField(exist = false)
    private List<Long> categoryIdList;

    @TableField(exist = false)
    private String specValue;
}
