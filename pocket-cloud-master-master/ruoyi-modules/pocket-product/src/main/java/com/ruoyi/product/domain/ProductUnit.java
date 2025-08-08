package com.ruoyi.product.domain;

import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;


@Data
@Schema(description = "Product Unit")
public class ProductUnit extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "Product Unit Name")
    @NotBlank(message = "Product Unit Name cannot be empty")
    @Size(min = 0, max = 10, message = "Length of Product Unit Name cannot exceed 10 characters")
    private String name;

}