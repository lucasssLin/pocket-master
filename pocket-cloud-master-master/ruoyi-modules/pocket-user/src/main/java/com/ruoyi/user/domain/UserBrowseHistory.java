package com.ruoyi.user.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class UserBrowseHistory extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    @Schema(description = "用户ID")
    private Long userId;

    /** 商品skuID */
    @Schema(description = "商品skuID")
    private Long spuId;

    @TableField(exist = false )
    private String productName;

    @TableField(exist = false)
    private String thumbImg;

    @TableField(exist = false)
    private BigDecimal salePrice;

}