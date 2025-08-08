package com.ruoyi.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.product.api.domain.BannerItem;

import java.util.List;

public interface BannerService extends IService<BannerItem> {
    List<BannerItem> getList();
}
