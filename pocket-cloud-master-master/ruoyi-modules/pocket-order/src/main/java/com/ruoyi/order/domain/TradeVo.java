package com.ruoyi.order.domain;

import com.ruoyi.order.api.domain.OrderItem;
import com.ruoyi.order.api.domain.OrderItemVo;
import com.ruoyi.user.api.domain.UserAddress;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "结算实体类")
public class TradeVo {

    @Schema(description = "结算总金额")
    private BigDecimal totalAmount;

    @Schema(description = "结算商品列表")
    private List<OrderItemVo> orderItemVoList;

    @Schema(description = "交易号")
    private String tradeNo;

    private List<UserAddress> userAddressList;

    private Integer goodsCount;

    private BigDecimal totalOriginalPrice;

    private BigDecimal discountPrice;

    private BigDecimal postFee;

}