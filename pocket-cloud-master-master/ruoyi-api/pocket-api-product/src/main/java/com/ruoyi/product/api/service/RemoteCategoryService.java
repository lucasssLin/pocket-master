package com.ruoyi.product.api.service;


import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.factory.RemoteCategoryFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteCategoryService", value = ServiceNameConstants.PRODUCT_SERVICE, fallbackFactory = RemoteCategoryFallbackFactory.class)
public interface RemoteCategoryService {

    @GetMapping(value = "/category/getOneCategory")
    public R<List<CategoryVo>> getOneCategory(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/category/tree")
    public R<List<CategoryVo> > tree(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}
