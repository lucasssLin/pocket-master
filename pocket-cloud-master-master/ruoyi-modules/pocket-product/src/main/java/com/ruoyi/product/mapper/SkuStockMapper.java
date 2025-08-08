package com.ruoyi.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.product.domain.SkuStock;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SkuStockMapper extends BaseMapper<SkuStock> {
    SkuStock check(@Param("skuId") Long skuId, @Param("skuNum") Integer skuNum);

    Integer lock(@Param("skuId")Long skuId, @Param("skuNum") Integer skuNum);

    Integer unlock(@Param("skuId")Long skuId, @Param("skuNum") Integer skuNum);

    Integer minusStock(@Param("skuId")Long skuId, @Param("skuNum") Integer skuNum);
}
