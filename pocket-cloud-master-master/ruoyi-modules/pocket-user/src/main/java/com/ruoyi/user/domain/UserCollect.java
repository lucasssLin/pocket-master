package com.ruoyi.user.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "用户收藏")
public class UserCollect extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    @Excel(name = "用户ID")
    @Schema(description = "用户ID")
    private Long userId;

    /** 商品skuID */
    @Excel(name = "spuId")
    @Schema(description = "spuId")
    private Long spuId;

    @Schema(description = "收藏标识")
    private Integer isCollect;

    @TableField(exist = false)
    private String spuName;

    @TableField(exist = false)
    private String thumbImg;

    @TableField(exist = false)
    private BigDecimal salePrice;
}