package com.ruoyi.channel.controller;


import com.ruoyi.channel.service.IIndexService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.RecommendType;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.service.RemoteProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@Slf4j
@Tag(name = "Index Page API Management")
@RequestMapping("/index")
@RestController
public class IndexController extends BaseController {

    @Autowired
    private IIndexService indexService;
    @Autowired
    private RemoteProductService remoteProductService;

    @Operation(summary = "Get index page data")
    @GetMapping
    private AjaxResult index(){
        Map<String, Object> map = indexService.getIndexData();
        return success(map);
    }

    @GetMapping("banner")
    private AjaxResult bannerList(){
        List<BannerItem> bannerList = indexService.getBannerList();
        return success(bannerList);
    }


    @GetMapping("category")
    private AjaxResult categoryList(){
        List<CategoryVo> categoryList = indexService.getCategoryList();
        return success(categoryList);
    }


    @Operation(summary = "Get hot recommend type")
    @GetMapping("recommendType")
    private AjaxResult getHotRecommend() {
        R<List<RecommendType>> hotRecommendResult = remoteProductService.getHotRecommend(SecurityConstants.INNER);
        if(R.FAIL== hotRecommendResult.getCode()){
            throw new ServiceException(hotRecommendResult.getMsg());
        }
        return success(hotRecommendResult.getData());
    }
}
