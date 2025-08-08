package com.ruoyi.channel.service;

import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.vo.CategoryVo;

import java.util.List;
import java.util.Map;

public interface IIndexService {
    Map<String, Object> getIndexData();
    List<BannerItem> getBannerList();
    List<CategoryVo> getCategoryList();
}
