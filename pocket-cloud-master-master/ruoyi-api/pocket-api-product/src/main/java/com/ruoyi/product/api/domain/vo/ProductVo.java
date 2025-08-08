package com.ruoyi.product.api.domain.vo;

import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSpecs;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
@Data
public class ProductVo  {

    private List<ProductSpecs> specsList;
    private Product product;
    private Integer orderNum;
    private BigDecimal price;

}
