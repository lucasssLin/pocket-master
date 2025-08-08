package com.ruoyi.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.domain.CategoryBrand;


import java.util.List;

public interface CategoryBrandService extends IService<CategoryBrand> {
    List<CategoryBrand> selectCategoryBrandList(CategoryBrand categoryBrand);

    CategoryBrand selectCategoryBrandInfoById(Long id);

    int insertCategoryBrand(CategoryBrand categoryBrand);

    int updateCategoryBrand(CategoryBrand categoryBrand);

    int deleteCategoryBrand(Long[] ids);

    List<Brand> selectBrandListByCategoryId(Long id);
}
