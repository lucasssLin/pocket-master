package com.ruoyi.product.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class CategoryBrand extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Schema(description = "Brand ID")
    @NotNull(message = "Brand ID cannot be empty")
    private Long brandId;

    @Schema(description = "Category ID")
    @NotNull(message = "Category ID cannot be empty")
    private Long categoryId;

    @Schema(description = "Category Name")
    @TableField(exist = false)
    private String categoryName;

    @Schema(description = "Brand Name")
    @TableField(exist = false)
    private String brandName;

    @Schema(description = "Brand Logo")
    @TableField(exist = false)
    private String logo;

    @Schema(description = "Category ID List")
    @TableField(exist = false)
    private List<Long> categoryIdList;

}