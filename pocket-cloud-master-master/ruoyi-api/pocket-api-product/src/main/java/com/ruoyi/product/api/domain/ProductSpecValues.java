package com.ruoyi.product.api.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ruoyi.common.core.web.domain.BaseEntity;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class ProductSpecValues extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Long specId;

    private String name;

    private String picture;

    private Boolean isAvailable;

    private String valueDesc;


}
