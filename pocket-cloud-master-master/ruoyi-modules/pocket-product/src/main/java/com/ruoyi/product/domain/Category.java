package com.ruoyi.product.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Schema(description = "Product Category")
@Data
public class Category extends BaseEntity
{
    private static final long serialVersionUID = 1L;


    @Schema(description = "Category Name")
    private String name;

    @Schema(description = "Image URL")
    private String imageUrl;

    @Schema(description = "Category Parent ID")
    private Long parentId;

    @Schema(description = "whether Display[0-Not Display，1-Display]")
    private Integer status;

    @Schema(description = "Order Number")
    private Long orderNum;

    @TableField(exist = false)
    private Boolean hasChildren;

    @TableField(exist = false)
    private List<Category> children;

}