package com.ruoyi.product.service.impl;


import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.product.domain.ProductUnit;
import com.ruoyi.product.mapper.ProductUnitMapper;
import com.ruoyi.product.service.IProductUnitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class IProductUnitServiceImpl extends ServiceImpl<ProductUnitMapper, ProductUnit> implements IProductUnitService {
    @Autowired
    private ProductUnitMapper productUnitMapper;

    @Override
    public IPage<ProductUnit> selectProductUnitPage(Page<ProductUnit> pageParam, ProductUnit productUnit) {

        IPage<ProductUnit> page = productUnitMapper.selectProductUnitPage(pageParam, productUnit);
        return page;
    }

    @Override
    public ProductUnit selectProductUnitById(Long id) {
        return productUnitMapper.selectById(id);
    }

    @Override
    public int insertProductUnit(ProductUnit productUnit) {
        return productUnitMapper.insert(productUnit);
    }

    @Override
    public int updateProductUnit(ProductUnit productUnit) {
        LambdaUpdateWrapper<ProductUnit> productUnitUpdateWrapper = new LambdaUpdateWrapper<ProductUnit>();
        productUnitUpdateWrapper.eq(ProductUnit::getId, productUnit.getId());
        return productUnitMapper.update(productUnit,productUnitUpdateWrapper);
    }

    @Override
    public int deleteProductUnitByIds(Long[] ids) {
        LambdaUpdateWrapper<ProductUnit> productUnitUpdateWrapper = new LambdaUpdateWrapper<>();
        productUnitUpdateWrapper.in(ProductUnit::getId, Arrays.asList(ids));
        productUnitUpdateWrapper.set(ProductUnit::getDelFlag, 2);
        return productUnitMapper.update(null, productUnitUpdateWrapper);
    }

    @Override
    public List<ProductUnit> selectUnitAll() {
        return productUnitMapper.selectList(null);
    }
}
