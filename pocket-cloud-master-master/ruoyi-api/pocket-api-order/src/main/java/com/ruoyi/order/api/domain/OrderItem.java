package com.ruoyi.order.api.domain;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 订单项信息对象 order_item
 * 
 * @author pocket
 * @date 2025-01-26
 */
@Data
public class OrderItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** order_id */
    @Excel(name = "order_id")
    private Long orderId;

    /** 商品sku编号 */
    @Excel(name = "商品sku编号")
    private Long skuId;

    /** 商品sku名字 */
    @Excel(name = "商品sku名字")
    private String skuName;

    /** 商品sku图片 */
    @Excel(name = "商品sku图片")
    private String thumbImg;

    /** 商品sku价格 */
    @Excel(name = "商品sku价格")
    private BigDecimal skuPrice;

    /** 商品购买的数量 */
    @Excel(name = "商品购买的数量")
    private Integer skuNum;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    private String attrsText;

    private Long spuId;
}
