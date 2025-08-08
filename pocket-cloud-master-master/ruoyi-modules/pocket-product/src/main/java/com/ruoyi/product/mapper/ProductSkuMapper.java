package com.ruoyi.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.SkuQuery;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductSkuMapper extends BaseMapper<ProductSku> {
    List<ProductSku> selectTopSale();


    List<ProductSku> selectSkuList(SkuQuery skuQuery);

    int updateSalePrice(@Param("skuId")Long skuId, @Param("salePrice") Double salePrice);
}
