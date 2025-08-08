package com.ruoyi.recommendation.service;

import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.recommendation.domain.vo.HotResult;
import com.ruoyi.recommendation.domain.vo.RecommendVo;

import java.util.List;

public interface RecommendationService {
    HotResult getRecommendations(Integer pageNum, Integer pageSize, int topN);
    void generateRecommendationsForAllUsers();
    void updateItemSimilarityMatrix();

    HotResult selectHotProductSpuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery);
}