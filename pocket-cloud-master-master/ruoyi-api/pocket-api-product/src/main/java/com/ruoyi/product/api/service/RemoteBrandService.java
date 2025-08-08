package com.ruoyi.product.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.api.factory.RemoteBrandFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteBrandService", value = ServiceNameConstants.PRODUCT_SERVICE, fallbackFactory = RemoteBrandFallbackFactory.class)
public interface RemoteBrandService {


    @GetMapping("/brand/getBrandAllList")
    public R<List<Brand>> getBrandAllList(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}
