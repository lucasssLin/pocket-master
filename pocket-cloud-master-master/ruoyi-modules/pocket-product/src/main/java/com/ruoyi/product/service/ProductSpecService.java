package com.ruoyi.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.product.api.domain.ProductSpecs;
import com.ruoyi.product.domain.ProductSpec;

import java.util.List;

public interface ProductSpecService extends IService<ProductSpec> {
    List<ProductSpec> selectProductSpecList(ProductSpec productSpec);

    ProductSpec selectProductSpecById(Long id);

    int insertProductSpec(ProductSpec productSpec);

    int updateProductSpec(ProductSpec productSpec);

    int removeProductSpec(Long[] ids);

    List<ProductSpec> selectProductSpecListByCategoryId(Long categoryId);


    int newInsertProductSpec(ProductSpecs productSpecs);

    List<ProductSpecs> newSelectProductSpecList();
}
