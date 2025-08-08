package com.ruoyi.recommendation.controller;

import com.alibaba.nacos.api.model.v2.Result;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.service.RemoteProductService;
import com.ruoyi.recommendation.domain.vo.HotResult;
import com.ruoyi.recommendation.domain.vo.RecommendVo;
import com.ruoyi.recommendation.service.RecommendationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// 推荐控制器
@RestController
@RequestMapping("/recommendationList")
public class RecommendationController extends BaseController {
    
    @Autowired
    private RecommendationService recommendationService;
    

    
    @GetMapping("/generate-all")
    @Operation(summary = "为所有用户生成推荐")
    public Result<Void> generateRecommendationsForAllUsers() {
        recommendationService.generateRecommendationsForAllUsers();
        return Result.success();
    }
    
    @GetMapping("/update-similarity")
    @Operation(summary = "更新物品相似度矩阵")
    public Result<Void> updateItemSimilarityMatrix() {
        recommendationService.updateItemSimilarityMatrix();
        return Result.success();
    }

    @GetMapping("/user")
    @Operation(summary = "获取用户推荐")
    public AjaxResult getUserRecommendations(@Parameter(name = "page", description = "pageNum", required = true)
                                                                @RequestParam Integer page,

                                                            @Parameter(name = "pageSize", description = "pageSize", required = true)
                                                                @RequestParam Integer pageSize,

                                                            @Parameter(name = "productQuery", description = "productQuery", required = false)
                                                                SkuQuery skuQuery)  {

        HotResult recommendations = recommendationService.getRecommendations(page, pageSize, 20);
        return success(recommendations);
    }

    @GetMapping("/hotSpuList")
    @Operation(summary = "热门排名")
    public AjaxResult spuList(@Parameter(name = "page", description = "pageNum", required = true)
                                    @RequestParam Integer page,

                              @Parameter(name = "pageSize", description = "pageSize", required = true)
                                    @RequestParam Integer pageSize,

                              @Parameter(name = "productQuery", description = "productQuery", required = false)
                                    SkuQuery skuQuery) {

        return success(recommendationService.selectHotProductSpuList(page, pageSize, skuQuery));
    }
}