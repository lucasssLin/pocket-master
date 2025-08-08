package com.ruoyi.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.mapper.BannerMapper;
import com.ruoyi.product.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerServiceImpl extends ServiceImpl<BannerMapper, BannerItem> implements BannerService {
    @Autowired
    private BannerMapper bannerMapper;
    @Override
    public List<BannerItem> getList() {
        return bannerMapper.selectList(null);
    }
}
