package com.ruoyi.user.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 用户地址对象 user_address
 * 
 * @author pocket
 * @date 2025-01-25
 */
@Data
public class UserAddress extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String receiver;

    /** 电话 */
    @Excel(name = "电话")
    private String contact;

    /** 标签名称 */
    @Excel(name = "标签名称")
    private String tagName;

    /** 省code */
    @Excel(name = "省code")
    private String provinceCode;

    /** 市code */
    @Excel(name = "市code")
    private String cityCode;

    /** 区code */
    @Excel(name = "区code")
    private String countyCode;

    /** 详细地址 */
    @Excel(name = "详细地址")
    private String address;

    /** 完整地址 */
    @Excel(name = "省市区(县)")
    private String fullLocation;

    /** 是否默认地址（0：否 1：是） */
    @Excel(name = "是否默认地址", readConverterExp = "0=：否,1=：是")
    private Long isDefault;

    /** 删除标志（0代表存在 2代表删除） */
    @TableLogic
    private String delFlag;


}
