package com.ruoyi.order.api.domain;

import lombok.Data;

import java.util.List;

@Data
public class OrderRequest {

    String cancelReason;

    List<Long> ids;

}
