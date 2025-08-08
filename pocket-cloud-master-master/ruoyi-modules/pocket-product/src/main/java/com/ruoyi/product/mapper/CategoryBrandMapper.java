package com.ruoyi.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.domain.CategoryBrand;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CategoryBrandMapper extends BaseMapper<CategoryBrand> {
    List<CategoryBrand> selectCategoryBrandList(CategoryBrand categoryBrand);

    List<Brand> selectBrandListByCategoryId(Long categoryId);
}
