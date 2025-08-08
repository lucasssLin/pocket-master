package com.ruoyi.payment.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.core.web.domain.BaseEntity;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * 支付信息实体类
 */
@Data
@TableName("payment_info")
public class PaymentInfo extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("user_id")
    private Long userId;

    @TableField("order_no")
    private String orderNo;

    @TableField("pay_type")
    private Integer payType;

    @TableField("trade_no")
    private String tradeNo;

    @TableField("amount")
    private BigDecimal amount;

    @TableField("content")
    private String content;

    @TableField("payment_status")
    private Integer paymentStatus;

    @TableField("callback_time")
    private Date callbackTime;

    @TableField("callback_content")
    private String callbackContent;

    @TableField("create_time")
    private Date createTime;

    @TableField("create_by")
    private String createBy;

    @TableField("update_time")
    private Date updateTime;

    @TableField("update_by")
    private String updateBy;

    @TableField("del_flag")
    private String delFlag;

    @TableField("remark")
    private String remark;
}