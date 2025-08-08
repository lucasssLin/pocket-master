package com.ruoyi.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.service.RemoteProductService;
import com.ruoyi.user.api.domain.BehaviorType;
import com.ruoyi.user.api.domain.UserBehavior;
import com.ruoyi.user.domain.UserBrowseHistory;
import com.ruoyi.user.mapper.UserBehaviorMapper;
import com.ruoyi.user.mapper.UserBrowseHistoryMapper;
import com.ruoyi.user.service.IUserBrowseHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class UserBrowseHistoryServiceImpl extends ServiceImpl<UserBrowseHistoryMapper, UserBrowseHistory> implements IUserBrowseHistoryService
{
    @Autowired
    private UserBrowseHistoryMapper userBrowseHistoryMapper;
    @Autowired
    private RemoteProductService remoteProductService;
    @Autowired
    private UserBehaviorMapper userBehaviorMapper;


    @Override
    public List<UserBrowseHistory> selectUserBrowseHistoryList() {
        Long userId = SecurityContextHolder.getUserId();
        List<UserBrowseHistory> userBrowseHistoryList = userBrowseHistoryMapper.selectList(new LambdaQueryWrapper<UserBrowseHistory>()
                .eq(UserBrowseHistory::getUserId, userId).orderByDesc(UserBrowseHistory::getUpdateTime));

        List<Long> spuIdList = userBrowseHistoryList.stream().map(UserBrowseHistory::getSpuId).collect(Collectors.toList());

        if(!CollectionUtils.isEmpty(spuIdList)){

            R<List<Product>> productListResult = remoteProductService.getProductListBySpuIdList(spuIdList, SecurityConstants.INNER);
            if(productListResult.getCode() == R.FAIL){
                throw new ServiceException(productListResult.getMsg());
            }
            List<Product> productList = productListResult.getData();
            // 将productSpuList转换为Map
            Map<Long, Product> productToIdMap = productList.stream()
                    .collect(Collectors.toMap(Product::getId, Function.identity()));

            userBrowseHistoryList.forEach(userBrowseHistory -> {
                if(productToIdMap.get(userBrowseHistory.getSpuId()) == null){
                    return;
                }
                userBrowseHistory.setProductName(productToIdMap.get(userBrowseHistory.getSpuId()).getName());

                userBrowseHistory.setThumbImg(productToIdMap.get(userBrowseHistory.getSpuId()).getSliderUrls().split(",")[0]);

                List<ProductSku> productSkuList = productToIdMap.get(userBrowseHistory.getSpuId()).getProductSkuList();
                ProductSku minSalePriceSku = productSkuList.stream()
                        .min((sku1, sku2) -> sku1.getSalePrice().compareTo(sku2.getSalePrice()))
                        .orElse(null);
                userBrowseHistory.setSalePrice(minSalePriceSku.getSalePrice());
            });
        }
        return userBrowseHistoryList;
    }

    @Override
    public void createBrowseHistory(Long spuId, Long userId) {
        if(userId == null || spuId == 0){
            return;
        }

        //用户行为记录
        // 检查是否已有记录
        UserBehavior existingBehavior = userBehaviorMapper.selectOne(new LambdaQueryWrapper<UserBehavior>().eq(UserBehavior::getUserId, userId).eq(UserBehavior::getItemId, spuId));

        if (existingBehavior == null) {
            // 用户行为记录
            UserBehavior behavior = new UserBehavior();
            behavior.setUserId(userId);
            behavior.setItemId(spuId);
            behavior.setBehaviorType(BehaviorType.VIEW);
            behavior.setScore(0.3);
            behavior.setCreateTime(new Date());
            userBehaviorMapper.insert(behavior);
        }


        UserBrowseHistory userBrowseHistory = userBrowseHistoryMapper.selectOne(new LambdaQueryWrapper<UserBrowseHistory>()
                .eq(UserBrowseHistory::getUserId, userId).eq(UserBrowseHistory::getSpuId, spuId));
        UserBrowseHistory newUserBrowseHistory = new UserBrowseHistory();

        if(userBrowseHistory == null){
            newUserBrowseHistory.setUserId(userId);
            newUserBrowseHistory.setSpuId(spuId);
            newUserBrowseHistory.setCreateTime(new Date());
            newUserBrowseHistory.setUpdateTime(new Date());
            userBrowseHistoryMapper.insert(newUserBrowseHistory);
        }else {
            userBrowseHistory.setUpdateTime(new Date());
            userBrowseHistoryMapper.updateById(userBrowseHistory);
        }
    }

    @Override
    public Boolean deleteUserBrowseHistory(Long id) {
        int i = userBrowseHistoryMapper.deleteById(id);
        return i > 0;
    }

}