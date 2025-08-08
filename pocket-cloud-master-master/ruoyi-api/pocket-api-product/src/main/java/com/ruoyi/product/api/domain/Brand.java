package com.ruoyi.product.api.domain;

import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
@Schema(description = "Brand")
public class Brand extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @NotBlank(message = "Brand name cannot be empty")
    @Size(min = 0, max = 64, message = "Length of the brand name cannot exceed 64 characters")
    @Schema(description = "Brand Name")
    private String name;

    @NotBlank(message = "Brand icon cannot be empty")
    @Size(min = 0, max = 200, message = "Brand log cannot exceed 200 characters in length")
    @Schema(description = "Brand Logo")
    private String logo;

}