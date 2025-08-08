package com.ruoyi.product.api.domain.vo;

import lombok.Data;

import java.util.List;

@Data
public class CategoryVo {


    private Long id;

    private String name;

    private String imageUrl;

    private Long parentId;

    private List<CategoryVo> children;

    private List<ProductVo> productVoList;
}
