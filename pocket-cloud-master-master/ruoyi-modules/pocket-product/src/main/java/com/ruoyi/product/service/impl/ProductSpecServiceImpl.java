package com.ruoyi.product.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.mysql.cj.xdevapi.JsonParser;
import com.mysql.cj.xdevapi.JsonString;
import com.ruoyi.product.api.domain.ProductSpecValues;
import com.ruoyi.product.api.domain.ProductSpecs;
import com.ruoyi.product.api.domain.vo.SpecValueVo;
import com.ruoyi.product.domain.ProductSpec;
import com.ruoyi.product.mapper.ProductSpecMapper;
import com.ruoyi.product.mapper.ProductSpecValuesMapper;
import com.ruoyi.product.mapper.ProductSpecsMapper;
import com.ruoyi.product.service.CategoryService;
import com.ruoyi.product.service.ProductSpecService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Service
public class ProductSpecServiceImpl extends ServiceImpl<ProductSpecMapper, ProductSpec> implements ProductSpecService {
    @Autowired
    private ProductSpecMapper productSpecMapper;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductSpecsMapper productSpecsMapper;
    @Autowired
    private ProductSpecValuesMapper productSpecValuesMapper;

    @Override
    public List<ProductSpec> selectProductSpecList(ProductSpec productSpec) {

        return productSpecMapper.selectProductSpecList(productSpec);
    }

    @Override
    public ProductSpec selectProductSpecById(Long id) {
        ProductSpec productSpec = productSpecMapper.selectById(id);
        List<Long> categoryIdList = categoryService.selectCategoryIdList(productSpec.getCategoryId());
        productSpec.setCategoryIdList(categoryIdList);

        return productSpec;
    }

    @Override
    public int insertProductSpec(ProductSpec productSpec) {
        Long categoryId = productSpec.getCategoryId();

        productSpec.setCategoryIdList(categoryService.selectCategoryIdList(categoryId));

        return productSpecMapper.insert(productSpec);
    }

    @Override
    public int updateProductSpec(ProductSpec productSpec) {
        int row = productSpecMapper.updateById(productSpec);
        return row;
    }

    @Override
    public int removeProductSpec(Long[] ids) {
        return productSpecMapper.deleteBatchIds(Arrays.asList(ids));
    }

    @Override
    public List<ProductSpec> selectProductSpecListByCategoryId(Long categoryId) {
        List<ProductSpec> list = productSpecMapper.selectList(new LambdaQueryWrapper<ProductSpec>().eq(ProductSpec::getCategoryId, categoryId));
        return list;
    }

    @Override
    public int newInsertProductSpec(ProductSpecs productSpecs){
        Long categoryId = productSpecs.getCategoryId();

        productSpecsMapper.insert(productSpecs);

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            List<SpecValueVo> specValueVoList = objectMapper.readValue(productSpecs.getSpecValue(), new TypeReference<List<SpecValueVo>>() {});
            for (SpecValueVo specValueVo : specValueVoList) {
                for(String value: specValueVo.getValueList()){
                    ProductSpecValues productSpecValues = new ProductSpecValues();
                    productSpecValues.setSpecId(productSpecs.getId());
                    productSpecValues.setName(value);
                    productSpecValues.setIsAvailable(true);
                    productSpecValuesMapper.insert(productSpecValues);
                }
            }
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return 1;
    }

    @Override
    public List<ProductSpecs> newSelectProductSpecList() {
        List<ProductSpecs> productSpecsList = productSpecsMapper.selectList(null);
        for(ProductSpecs productSpecs: productSpecsList){
            List<ProductSpecValues> productSpecValuesList = productSpecValuesMapper.selectList(new LambdaQueryWrapper<ProductSpecValues>().eq(ProductSpecValues::getSpecId, productSpecs.getId()));

            List<String> valueList = new ArrayList<>();
            for (ProductSpecValues productSpecValues : productSpecValuesList) {
                valueList.add(productSpecValues.getName());
            }
            SpecValueVo specValueVo = new SpecValueVo();
            specValueVo.setKey(productSpecs.getSpecName());
            specValueVo.setValueList(valueList);

            productSpecs.setValues(productSpecValuesList);
            String specValueVojsonString = JSON.toJSONString(specValueVo);
            productSpecs.setSpecValue(specValueVojsonString);
        }
        return productSpecsList;
    }


}
