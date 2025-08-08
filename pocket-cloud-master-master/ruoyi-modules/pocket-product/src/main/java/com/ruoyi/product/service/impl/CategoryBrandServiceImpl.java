package com.ruoyi.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.domain.CategoryBrand;
import com.ruoyi.product.mapper.CategoryBrandMapper;
import com.ruoyi.product.service.CategoryBrandService;
import com.ruoyi.product.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@Service
public class CategoryBrandServiceImpl extends ServiceImpl<CategoryBrandMapper, CategoryBrand> implements CategoryBrandService {
    @Autowired
    private CategoryBrandMapper categoryBrandMapper;
    @Autowired
    private CategoryService categoryService;

    @Override
    public List<CategoryBrand> selectCategoryBrandList(CategoryBrand categoryBrand) {
        return categoryBrandMapper.selectCategoryBrandList(categoryBrand);
    }

    @Override
    public CategoryBrand selectCategoryBrandInfoById(Long id) {

        CategoryBrand categoryBrand = categoryBrandMapper.selectOne(new LambdaQueryWrapper<CategoryBrand>().eq(CategoryBrand::getId, id));

        List<Long> categoryIdList = categoryService.selectCategoryIdList(categoryBrand.getCategoryId());

        categoryBrand.setCategoryIdList(categoryIdList);

        return categoryBrand;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insertCategoryBrand(CategoryBrand categoryBrand) {

        Long count = categoryBrandMapper.selectCount(new LambdaQueryWrapper<CategoryBrand>().eq(CategoryBrand::getCategoryId, categoryBrand.getCategoryId())
                .eq(CategoryBrand::getBrandId, categoryBrand.getBrandId()));

        if(count > 0) {
            throw new ServiceException("The brand has been added to this Category");
        }
        return categoryBrandMapper.insert(categoryBrand);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateCategoryBrand(CategoryBrand categoryBrand) {

        CategoryBrand originalCategoryBrand = categoryBrandMapper.selectOne(new LambdaQueryWrapper<CategoryBrand>().eq(CategoryBrand::getId, categoryBrand.getId()));

        if(originalCategoryBrand.getCategoryId() != categoryBrand.getCategoryId() || originalCategoryBrand.getBrandId() != categoryBrand.getBrandId()) {

            Long count = categoryBrandMapper.selectCount(new LambdaQueryWrapper<CategoryBrand>().eq(CategoryBrand::getBrandId, categoryBrand.getBrandId()).eq(CategoryBrand::getCategoryId, categoryBrand.getCategoryId()));

            if(count > 0){
                throw new ServiceException("The brand has been added to this Category");
            }
        }
        return categoryBrandMapper.updateById(categoryBrand);
    }

    @Override
    public int deleteCategoryBrand(Long[] ids) {

        LambdaUpdateWrapper<CategoryBrand> updateWrapper = new LambdaUpdateWrapper<CategoryBrand>().in(CategoryBrand::getId, Arrays.asList(ids)).set(CategoryBrand::getDelFlag, 2);

        return categoryBrandMapper.update(null,updateWrapper);
    }

    //根据分类id获取所有品牌
    @Override
    public List<Brand> selectBrandListByCategoryId(Long id) {
        return categoryBrandMapper.selectBrandListByCategoryId(id);
    }

}
