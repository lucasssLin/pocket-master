package com.ruoyi.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.product.domain.ProductUnit;


import java.util.List;

public interface IProductUnitService extends IService<ProductUnit>{
    IPage<ProductUnit> selectProductUnitPage(Page<ProductUnit> pageParam, ProductUnit productUnit);

    ProductUnit selectProductUnitById(Long id);

    int insertProductUnit(ProductUnit productUnit);

    int updateProductUnit(ProductUnit productUnit);

    int deleteProductUnitByIds(Long[] ids);

    List<ProductUnit> selectUnitAll();
}
