package com.ruoyi.product.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.Brand;

import com.ruoyi.product.api.factory.RemoteBannerFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteBannerService", value = ServiceNameConstants.PRODUCT_SERVICE, fallbackFactory = RemoteBannerFallbackFactory.class)
public interface RemoteBannerService {
    @GetMapping("/banner/list")
    public R<List<BannerItem>> bannerList(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}
