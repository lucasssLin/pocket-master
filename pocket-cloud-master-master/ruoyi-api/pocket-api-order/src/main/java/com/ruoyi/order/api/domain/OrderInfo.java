package com.ruoyi.order.api.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 订单对象 order_info
 * 
 * @author pocket
 * @date 2025-01-26
 */
@Data
public class OrderInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 会员_id */
    @Excel(name = "会员_id")
    private Long userId;

    /** 昵称 */
    @Excel(name = "昵称")
    private String nickName;

    /** 订单号 */
    @Excel(name = "订单号")
    private String orderNo;

    /** 使用的优惠券 */
    @Excel(name = "使用的优惠券")
    private Long couponId;

    /** 订单总额 */
    @Excel(name = "订单总额")
    private BigDecimal totalAmount;

    /** 优惠券 */
    @Excel(name = "优惠券")
    private BigDecimal couponAmount;

    /** 原价金额 */
    @Excel(name = "原价金额")
    private BigDecimal originalTotalAmount;

    /** 运费 */
    @Excel(name = "运费")
    private BigDecimal freightFee;

    /** 订单状态【0->待付款；1->待发货；2->已发货；3->待用户收货，已完成；-1->已取消】 */
    @Excel(name = "订单状态【0->待付款；1->待发货；2->已发货；3->待用户收货，已完成；-1->已取消】")
    private Integer orderStatus;

    /** 收货人姓名 */
    @Excel(name = "收货人姓名")
    private String receiverName;

    /** 收货人电话 */
    @Excel(name = "收货人电话")
    private String receiverPhone;

    /** 收货人地址标签 */
    @Excel(name = "收货人地址标签")
    private String receiverTagName;

    /** 省份/直辖市 */
    @Excel(name = "省份/直辖市")
    private String receiverProvince;

    /** 城市 */
    @Excel(name = "城市")
    private String receiverCity;

    /** 区 */
    @Excel(name = "区")
    private String receiverDistrict;

    /** 详细地址 */
    @Excel(name = "详细地址")
    private String receiverAddress;

    @TableField(exist = false)
    private List<OrderItem> orderItemList;

    /** 支付时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "支付时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date paymentTime;

    /** 发货时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发货时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date deliveryTime;

    /** 确认收货时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "确认收货时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date receiveTime;

    /** 取消订单时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "取消订单时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date cancelTime;

    /** 取消订单原因 */
    @Excel(name = "取消订单原因")
    private String cancelReason;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    private Integer deliveryTimeType;

    private String buyerMessage;

    private Integer payType;

    private Integer payChannel;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setNickName(String nickName) 
    {
        this.nickName = nickName;
    }

    public String getNickName() 
    {
        return nickName;
    }
    public void setOrderNo(String orderNo) 
    {
        this.orderNo = orderNo;
    }

    public String getOrderNo() 
    {
        return orderNo;
    }
    public void setCouponId(Long couponId) 
    {
        this.couponId = couponId;
    }

    public Long getCouponId() 
    {
        return couponId;
    }
    public void setTotalAmount(BigDecimal totalAmount) 
    {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getTotalAmount() 
    {
        return totalAmount;
    }
    public void setCouponAmount(BigDecimal couponAmount) 
    {
        this.couponAmount = couponAmount;
    }

    public BigDecimal getCouponAmount() 
    {
        return couponAmount;
    }
    public void setOriginalTotalAmount(BigDecimal originalTotalAmount) 
    {
        this.originalTotalAmount = originalTotalAmount;
    }

    public BigDecimal getOriginalTotalAmount() 
    {
        return originalTotalAmount;
    }
    public void setFreightFee(BigDecimal freightFee)
    {
        this.freightFee = freightFee;
    }

    public BigDecimal getFreightFee()
    {
        return freightFee;
    }
    public void setOrderStatus(Integer orderStatus)
    {
        this.orderStatus = orderStatus;
    }

    public Integer getOrderStatus()
    {
        return orderStatus;
    }
    public void setReceiverName(String receiverName) 
    {
        this.receiverName = receiverName;
    }

    public String getReceiverName() 
    {
        return receiverName;
    }
    public void setReceiverPhone(String receiverPhone) 
    {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverPhone() 
    {
        return receiverPhone;
    }
    public void setReceiverTagName(String receiverTagName) 
    {
        this.receiverTagName = receiverTagName;
    }

    public String getReceiverTagName() 
    {
        return receiverTagName;
    }
    public void setReceiverProvince(String receiverProvince) 
    {
        this.receiverProvince = receiverProvince;
    }

    public String getReceiverProvince() 
    {
        return receiverProvince;
    }
    public void setReceiverCity(String receiverCity) 
    {
        this.receiverCity = receiverCity;
    }

    public String getReceiverCity() 
    {
        return receiverCity;
    }
    public void setReceiverDistrict(String receiverDistrict) 
    {
        this.receiverDistrict = receiverDistrict;
    }

    public String getReceiverDistrict() 
    {
        return receiverDistrict;
    }
    public void setReceiverAddress(String receiverAddress) 
    {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverAddress() 
    {
        return receiverAddress;
    }
    public void setPaymentTime(Date paymentTime) 
    {
        this.paymentTime = paymentTime;
    }

    public Date getPaymentTime() 
    {
        return paymentTime;
    }
    public void setDeliveryTime(Date deliveryTime) 
    {
        this.deliveryTime = deliveryTime;
    }

    public Date getDeliveryTime() 
    {
        return deliveryTime;
    }
    public void setReceiveTime(Date receiveTime) 
    {
        this.receiveTime = receiveTime;
    }

    public Date getReceiveTime() 
    {
        return receiveTime;
    }
    public void setCancelTime(Date cancelTime) 
    {
        this.cancelTime = cancelTime;
    }

    public Date getCancelTime() 
    {
        return cancelTime;
    }
    public void setCancelReason(String cancelReason) 
    {
        this.cancelReason = cancelReason;
    }

    public String getCancelReason() 
    {
        return cancelReason;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("nickName", getNickName())
            .append("orderNo", getOrderNo())
            .append("couponId", getCouponId())
            .append("totalAmount", getTotalAmount())
            .append("couponAmount", getCouponAmount())
            .append("originalTotalAmount", getOriginalTotalAmount())
            .append("freightFee", getFreightFee())
            .append("orderStatus", getOrderStatus())
            .append("receiverName", getReceiverName())
            .append("receiverPhone", getReceiverPhone())
            .append("receiverTagName", getReceiverTagName())
            .append("receiverProvince", getReceiverProvince())
            .append("receiverCity", getReceiverCity())
            .append("receiverDistrict", getReceiverDistrict())
            .append("receiverAddress", getReceiverAddress())
            .append("paymentTime", getPaymentTime())
            .append("deliveryTime", getDeliveryTime())
            .append("receiveTime", getReceiveTime())
            .append("cancelTime", getCancelTime())
            .append("cancelReason", getCancelReason())
            .append("createTime", getCreateTime())
            .append("createBy", getCreateBy())
            .append("updateTime", getUpdateTime())
            .append("updateBy", getUpdateBy())
            .append("delFlag", getDelFlag())
            .append("remark", getRemark())
            .toString();
    }
}
