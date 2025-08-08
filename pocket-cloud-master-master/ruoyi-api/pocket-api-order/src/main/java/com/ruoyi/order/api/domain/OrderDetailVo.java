package com.ruoyi.order.api.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class OrderDetailVo {
    private String orderId;

    private String createTime;

    private Integer payType;

    private Integer orderState;

    private Integer payLatestTime;

    private Long countdown;

    private BigDecimal postFee;

    private BigDecimal payMoney;

    private Integer payChannel;

    private BigDecimal totalMoney;

    private Integer totalNum;

    private Integer deliveryTimeType;

    private String receiverContact;

    private String receiverMobile;

    private String receiverAddress;

    private String payTime;

    private String consignTime;

    private String arrivalEstimatedTime;

    private String endTime;

    private String closeTime;

    private String evaluationTime;

    private List<OrderItemVo> orderItemVoList;

    private List<OrderItem> orderItemList;

    private String orderNo;
}
