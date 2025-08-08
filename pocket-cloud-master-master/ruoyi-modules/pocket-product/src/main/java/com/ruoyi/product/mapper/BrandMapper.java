package com.ruoyi.product.mapper;

import com.ruoyi.product.api.domain.Brand;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BrandMapper {
    List<Brand> selectBrandList(Brand brand);

    Brand selectBrandById(Long id);

    int insertBrand(Brand brand);

    int updateBrand(Brand brand);

    int deleteBrandByIds(Long[] ids);


}
