package com.ruoyi.product.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.List;

@Data
public class ProductSpec extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Schema(description = "Category ID")
    @NotNull(message = "Category ID cannot be empty")
    private Long categoryId;

    @Schema(description = "Specification Name")
    @NotBlank(message = "Specification Name cannot be empty")
    @Size(min = 0, max = 64, message = "Length of Specification Name cannot exceed 64 characters")
    private String specName;

    @Schema(description = "Specification Value")
    @NotBlank(message = "Specification Value cannot be empty")
    @Size(min = 0, max = 200, message = "Length of Specification Value cannot exceed 200 characters")
    private String specValue;
    
    @Schema(description = "categoryName")
    @TableField(exist = false)
    private String categoryName;

    @Schema(description = "categoryIdList")
    @TableField(exist = false)
    private List<Long> categoryIdList;
}