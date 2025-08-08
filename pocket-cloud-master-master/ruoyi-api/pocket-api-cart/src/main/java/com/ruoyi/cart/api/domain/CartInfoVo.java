package com.ruoyi.cart.api.domain;

import lombok.Data;

import java.util.List;

@Data
public class CartInfoVo {

    Boolean isChecked;

    Integer count;

    List<Long> ids;

    Long addressId;
}
