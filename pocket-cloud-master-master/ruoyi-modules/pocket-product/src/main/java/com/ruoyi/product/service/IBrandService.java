package com.ruoyi.product.service;


import com.ruoyi.product.api.domain.Brand;

import java.util.List;

public interface IBrandService {
    List<Brand> selectBrandList(Brand brand);

    Brand selectBrandById(Long id);

    int insertBrand(Brand brand);

    int updateBrand(Brand brand);

    int deleteBrandByIds(Long[] ids);

    List<Brand> selectBrandAll();
}
