package com.ruoyi.product.controller;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.service.BannerService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/banner")
public class BannerController extends BaseController {
    @Autowired
    private BannerService bannerService;

    /**
     * 获取所有 Banner
     */
    @GetMapping("/list")
    @InnerAuth
    public R<List<BannerItem>> bannerList() {
        return R.ok(bannerService.getList());

    }
}
