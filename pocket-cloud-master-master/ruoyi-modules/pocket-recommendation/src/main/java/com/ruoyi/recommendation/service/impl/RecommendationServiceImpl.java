package com.ruoyi.recommendation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.service.RemoteProductService;
import com.ruoyi.recommendation.algorithm.ItemCFRecommendationAlgorithm;
import com.ruoyi.recommendation.domain.RecommendationResult;
import com.ruoyi.recommendation.domain.vo.HotResult;
import com.ruoyi.recommendation.domain.vo.RecommendVo;
import com.ruoyi.recommendation.domain.vo.SubTypeItem;
import com.ruoyi.recommendation.mapper.RecommendationResultMapper;
import com.ruoyi.recommendation.service.RecommendationService;
import com.ruoyi.user.api.domain.UserBehavior;
import com.ruoyi.user.api.service.RemoteUserInfoService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class RecommendationServiceImpl implements RecommendationService {
    
    @Autowired
    private ItemCFRecommendationAlgorithm itemCFAlgorithm;
    
    @Autowired
    private RecommendationResultMapper recommendationResultMapper;

    @Autowired
    private RemoteUserInfoService remoteUserInfoService;
    
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private RemoteProductService remoteProductService;
    
    @Override
    public HotResult getRecommendations(Integer pageNum, Integer pageSize, int topN) {
        Long userId = SecurityContextHolder.getUserId();
        // 首先从缓存中获取
        String cacheKey = "user_recommendations:" + userId;
        List<Long> cachedRecommendations = getCachedRecommendations(cacheKey);
        
//        if (cachedRecommendations != null && !cachedRecommendations.isEmpty()) {
//            HotResult recommendVoList = convertToRecommendVoList(cachedRecommendations, pageNum, pageSize, topN);
//            return recommendVoList;
//        }
        
        // 从数据库获取预计算的推荐结果
        List<RecommendationResult> results = recommendationResultMapper.selectList(new LambdaQueryWrapper<RecommendationResult>()
                                                                                   .eq(RecommendationResult::getUserId, userId)
                                                                                   .orderByDesc(RecommendationResult::getScore));
        
        List<Long> recommendations = results.stream()
                                           .map(RecommendationResult::getItemId)
                                           .limit(topN)
                                           .collect(Collectors.toList());
        
        if (recommendations.isEmpty()) {
            // 如果没有预计算的结果，实时计算
            recommendations = itemCFAlgorithm.generateRecommendations(userId, topN);
        }
        
        // 缓存结果
        cacheRecommendations(cacheKey, recommendations);


        HotResult recommendVoList = convertToRecommendVoList(recommendations,pageNum, pageSize, topN);

        return recommendVoList;
    }


    private HotResult convertToRecommendVoList(List<Long> productIdList, Integer pageNum, Integer pageSize, int topN) {
        List<RecommendVo> recommendVoList = new ArrayList<>();

        R<TableDataInfo> recommendedProductsResult = remoteProductService.selectProductListPageBySpuIdList(productIdList, pageNum, pageSize, SecurityConstants.INNER);
        if(R.FAIL==(recommendedProductsResult.getCode())){
            log.error("获取商品列表失败:{}",recommendedProductsResult.getMsg());
            throw new ServiceException(recommendedProductsResult.getMsg());
        }
        TableDataInfo recommendProductListTableDataInfo = recommendedProductsResult.getData();

        HotResult hotResult = new HotResult();
        hotResult.setId("2");
        hotResult.setBannerPicture("");
        hotResult.setTitle("个性化推荐");
        SubTypeItem subTypeItem = new SubTypeItem();
        subTypeItem.setId("1");
        subTypeItem.setTitle("推荐排名");

        subTypeItem.setGoodsItems(recommendProductListTableDataInfo);
        hotResult.setSubTypes(Arrays.asList(subTypeItem));
        return hotResult;
    }



    @Override
    public void generateRecommendationsForAllUsers() {
        log.info("开始为所有用户生成推荐");

        // 获取最近180天的用户行为数据
        LocalDateTime startTime = LocalDateTime.now().minusDays(180);
        // 获取所有有行为记录的用户
        R<List<UserBehavior>> userBehaviorListResult = remoteUserInfoService.selectUserBehavior(startTime, SecurityConstants.INNER);
        if(R.FAIL==(userBehaviorListResult.getCode())){
            log.error("获取用户行为数据失败:{}",userBehaviorListResult.getMsg());
            throw new ServiceException(userBehaviorListResult.getMsg());
        }
        List<Long> activeUsers = userBehaviorListResult.getData().stream()
                                             .map(UserBehavior::getUserId).distinct().collect(Collectors.toList());

        int batchSize = 100;
        for (int i = 0; i < activeUsers.size(); i += batchSize) {
            int end = Math.min(i + batchSize, activeUsers.size());
            List<Long> batch = activeUsers.subList(i, end);
            
            processBatch(batch);
        }
        
        log.info("为所有用户生成推荐完成，共处理{}个用户", activeUsers.size());
    }
    
    private void processBatch(List<Long> userIds) {
        for (Long userId : userIds) {
            try {
                // 生成推荐
                List<Long> recommendations = itemCFAlgorithm.generateRecommendations(userId, 50);
                
                // 保存推荐结果
                saveRecommendationResults(userId, recommendations);
                
                // 缓存推荐结果
                String cacheKey = "user_recommendations:" + userId;
                cacheRecommendations(cacheKey, recommendations);
                
            } catch (Exception e) {
                log.error("为用户{}生成推荐失败: {}", userId, e.getMessage(), e);
            }
        }
    }
    
    private void saveRecommendationResults(Long userId, List<Long> recommendations) {
        // 清除旧的推荐结果
        recommendationResultMapper.delete(new LambdaQueryWrapper<RecommendationResult>().eq(RecommendationResult::getUserId, userId));
        
        // 保存新的推荐结果
        List<RecommendationResult> results = new ArrayList<>();
        for (int i = 0; i < recommendations.size(); i++) {
            RecommendationResult result = new RecommendationResult();
            result.setUserId(userId);
            result.setItemId(recommendations.get(i));
            result.setScore((double) (recommendations.size() - i)); // 简单的分数计算
            result.setAlgorithmType("ITEM_CF");
            result.setCreatedTime(LocalDateTime.now());
            result.setUpdatedTime(LocalDateTime.now());
            results.add(result);
        }
        for(RecommendationResult result : results){
            recommendationResultMapper.insert(result);
        }
    }
    
    @Override
    @Scheduled(cron = "0 0 2 * * ?") // 每天凌晨2点执行
    public void updateItemSimilarityMatrix() {
        log.info("开始更新物品相似度矩阵");
        
        try {
            // 计算新的相似度矩阵
            Map<Long, Map<Long, Double>> newMatrix = itemCFAlgorithm.calculateItemSimilarityMatrix();
            
            // 更新Redis缓存
            String key = "item_similarity_matrix";
            redisTemplate.opsForValue().set(key, newMatrix, Duration.ofHours(24));
            
            log.info("物品相似度矩阵更新完成");
            
        } catch (Exception e) {
            log.error("物品相似度矩阵更新失败: {}", e.getMessage(), e);
        }
    }



    @SuppressWarnings("unchecked")
    private List<Long> getCachedRecommendations(String cacheKey) {
        Object cached = redisTemplate.opsForValue().get(cacheKey);
        return cached != null ? (List<Long>) cached : null;
    }
    
    private void cacheRecommendations(String cacheKey, List<Long> recommendations) {
        redisTemplate.opsForValue().set(cacheKey, recommendations, Duration.ofHours(6));
    }


    @Override
    public HotResult selectHotProductSpuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery) {

        R<TableDataInfo> tableDataInfoResult = remoteProductService.selectHotProductSpuList(pageNum, pageSize, skuQuery, SecurityConstants.INNER);
        if (R.FAIL == tableDataInfoResult.getCode()) {
            throw new ServiceException(tableDataInfoResult.getMsg());
        }

        HotResult hotResult = new HotResult();
        hotResult.setId("1");
        hotResult.setBannerPicture("");
        hotResult.setTitle("年销量排名");
        SubTypeItem subTypeItem = new SubTypeItem();
        subTypeItem.setId("1");
        subTypeItem.setTitle("热销商品");

        subTypeItem.setGoodsItems(tableDataInfoResult.getData());
        hotResult.setSubTypes(Arrays.asList(subTypeItem));
        return hotResult;
    }
}