package com.ruoyi.recommendation.algorithm;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.recommendation.mapper.RecommendationResultMapper;
import com.ruoyi.user.api.domain.UserBehavior;

import com.ruoyi.user.api.service.RemoteUserInfoService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

// Item-CF推荐算法实现
@Component
@Slf4j
public class ItemCFRecommendationAlgorithm{
    
    @Autowired
    private RemoteUserInfoService remoteUserInfoService;
//    @Autowired
//    private RecommendationResultMapper recommendationResultMapper;
    
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    
    //计算物品相似度矩阵
    public Map<Long, Map<Long, Double>> calculateItemSimilarityMatrix() {
        log.info("开始计算物品相似度矩阵");
        
        // 1. 构建用户-物品评分矩阵
        Map<Long, Map<Long, Double>> userItemMatrix = buildUserItemMatrix();
        
        // 2. 计算物品相似度
        Map<Long, Map<Long, Double>> itemSimilarityMatrix = new HashMap<>();
        
        Set<Long> items = new HashSet<>();
        userItemMatrix.values().forEach(itemMap -> items.addAll(itemMap.keySet()));
        
        for (Long itemA : items) {
            itemSimilarityMatrix.put(itemA, new HashMap<>());
            
            for (Long itemB : items) {
                if (!itemA.equals(itemB)) {
                    double similarity = calculateCosineSimilarity(userItemMatrix, itemA, itemB);
                    if (similarity > 0) {
                        itemSimilarityMatrix.get(itemA).put(itemB, similarity);
                    }
                }
            }
        }
        
        log.info("物品相似度矩阵计算完成，共{}个物品", items.size());
        return itemSimilarityMatrix;
    }
    

    //构建用户-物品评分矩阵
    private Map<Long, Map<Long, Double>> buildUserItemMatrix() {
        Map<Long, Map<Long, Double>> userItemMatrix = new HashMap<>();
        
        // 获取最近60天的用户行为数据
        LocalDateTime startTime = LocalDateTime.now().minusDays(60);
        //List<UserBehavior> userBehaviors = userBehaviorMapper.selectList(new LambdaQueryWrapper<UserBehavior>().gt(UserBehavior::getCreateTime, startTime));
        R<List<UserBehavior>> userBehaviorResult = remoteUserInfoService.selectUserBehavior(startTime, SecurityConstants.INNER);

        if(R.FAIL==(userBehaviorResult.getCode())){
            log.error("获取用户行为数据失败:{}",userBehaviorResult.getMsg());
            throw new ServiceException(userBehaviorResult.getMsg());
            //return userItemMatrix;
        }
        List<UserBehavior> userBehaviors = userBehaviorResult.getData();
        for (UserBehavior behavior : userBehaviors) {
            Long userId = behavior.getUserId();
            Long itemId = behavior.getItemId();
            
            // 根据行为类型计算评分
            double score = behavior.getBehaviorType().getWeight();
            
            userItemMatrix.computeIfAbsent(userId, k -> new HashMap<>()).merge(itemId, score, Double::sum);
        }
        
        return userItemMatrix;
    }
    

    //计算余弦相似度
    private double calculateCosineSimilarity(Map<Long, Map<Long, Double>> userItemMatrix, 
                                           Long itemA, Long itemB) {
        Set<Long> commonUsers = new HashSet<>();
        
        // 找到同时评价过两个物品的用户
        for (Map.Entry<Long, Map<Long, Double>> entry : userItemMatrix.entrySet()) {
            // 从 userItemMatrix 中取出每个用户对应的物品评分映射
            Map<Long, Double> itemMap = entry.getValue();
            // 检查该用户是否同时对 itemA 和 itemB 进行过评分
            if (itemMap.containsKey(itemA) && itemMap.containsKey(itemB)) {
                // 如果是，则将该用户的 ID 添加到 commonUsers 集合中
                commonUsers.add(entry.getKey());
            }
        }
        
        if (commonUsers.isEmpty()) {
            return 0.0;
        }
        
        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;
        
        for (Long userId : commonUsers) {
            double ratingA = userItemMatrix.get(userId).get(itemA);
            double ratingB = userItemMatrix.get(userId).get(itemB);
            
            dotProduct += ratingA * ratingB;
            normA += ratingA * ratingA;
            normB += ratingB * ratingB;
        }
        
        if (normA == 0.0 || normB == 0.0) {
            return 0.0;
        }
        
        return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
    }
    
    //为指定用户生成推荐
    public List<Long> generateRecommendations(Long userId, int topN) {
        log.info("为用户{}生成推荐", userId);
        
        // 1. 获取用户的历史行为

        //List<UserBehavior> userBehaviors = userBehaviorMapper.selectList(new LambdaQueryWrapper<UserBehavior>().eq(UserBehavior::getUserId, userId));

        R<List<UserBehavior>> userBehaviorResult = remoteUserInfoService.selectUserBehaviorByUserId(userId, SecurityConstants.INNER);

        if(R.FAIL==(userBehaviorResult.getCode())){
            log.error("获取用户行为数据失败:{}",userBehaviorResult.getMsg());
            throw new ServiceException(userBehaviorResult.getMsg());

        }


        Set<Long> userItems = userBehaviorResult.getData().stream().map(UserBehavior::getItemId).collect(Collectors.toSet());
        
        if (userItems.isEmpty()) {
            log.warn("用户{}没有历史行为数据", userId);
            return Collections.emptyList();
        }
        
        // 2. 从Redis获取相似度矩阵
        Map<Long, Map<Long, Double>> itemSimilarityMatrix = getItemSimilarityFromCache();
        
        // 3. 计算推荐分数
        Map<Long, Double> recommendationScores = new HashMap<>();
        
        for (Long userItem : userItems) {
            Map<Long, Double> similarItems = itemSimilarityMatrix.get(userItem);
            if (similarItems != null) {
                for (Map.Entry<Long, Double> entry : similarItems.entrySet()) {
                    Long candidateItem = entry.getKey();
                    Double similarity = entry.getValue();

                    recommendationScores.merge(candidateItem, similarity, Double::sum);
//                    // 排除用户已经交互过的物品
//                    if (!userItems.contains(candidateItem)) {
//                        recommendationScores.merge(candidateItem, similarity, Double::sum);
//                    }
                }
            }
        }
        
        // 4. 排序并返回TopN
        List<Long> recommendations = recommendationScores.entrySet()
                                                        .stream()
                                                        .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                                                        .limit(topN)
                                                        .map(Map.Entry::getKey)
                                                        .collect(Collectors.toList());
        
        log.info("为用户{}生成{}个推荐", userId, recommendations.size());
        return recommendations;
    }
    

    //从Redis获取相似度矩阵
    @SuppressWarnings("unchecked")
    private Map<Long, Map<Long, Double>> getItemSimilarityFromCache() {
        String key = "item_similarity_matrix";
        Object cachedMatrix = redisTemplate.opsForValue().get(key);
        
        if (cachedMatrix != null) {
            return (Map<Long, Map<Long, Double>>) cachedMatrix;
        }
        
        // 如果缓存中没有，重新计算
        Map<Long, Map<Long, Double>> matrix = calculateItemSimilarityMatrix();
        redisTemplate.opsForValue().set(key, matrix, Duration.ofHours(12));
        return matrix;
    }
}