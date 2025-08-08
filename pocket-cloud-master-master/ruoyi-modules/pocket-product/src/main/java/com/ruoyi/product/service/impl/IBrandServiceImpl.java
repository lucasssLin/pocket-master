package com.ruoyi.product.service.impl;


import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.mapper.BrandMapper;
import com.ruoyi.product.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IBrandServiceImpl implements IBrandService {
    @Autowired
    private BrandMapper brandMapper;
    @Override
    public List<Brand> selectBrandList(Brand brand) {
        return brandMapper.selectBrandList(brand);
    }

    @Override
    public Brand selectBrandById(Long id) {
        return brandMapper.selectBrandById(id);
    }

    @Override
    public int insertBrand(Brand brand) {
        return brandMapper.insertBrand(brand);
    }

    @Override
    public int updateBrand(Brand brand) {
        return brandMapper.updateBrand(brand);
    }

    @Override
    public int deleteBrandByIds(Long[] ids) {
        return brandMapper.deleteBrandByIds(ids);
    }

    @Override
    public List<Brand> selectBrandAll() {
        return brandMapper.selectBrandList(null);
    }


}
