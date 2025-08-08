package com.ruoyi.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.product.api.domain.ProductSpecs;
import com.ruoyi.product.domain.ProductSpec;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProductSpecsMapper extends BaseMapper<ProductSpecs> {
    List<ProductSpecs> selectProductSpecList(Long productId);
}