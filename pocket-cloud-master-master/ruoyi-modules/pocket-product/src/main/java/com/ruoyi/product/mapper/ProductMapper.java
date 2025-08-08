package com.ruoyi.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.vo.ProductVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper extends BaseMapper<Product> {
    List<Product> selectPageList(Product product);

    List<ProductVo> selectSpuList(SkuQuery skuQuery);

    List<Product> selectRelevantGoodsBySpuId(Long spuId);

}
