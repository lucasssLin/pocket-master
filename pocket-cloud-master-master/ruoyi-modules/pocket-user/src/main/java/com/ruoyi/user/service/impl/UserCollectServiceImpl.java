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
import com.ruoyi.user.domain.UserCollect;
import com.ruoyi.user.mapper.UserBehaviorMapper;
import com.ruoyi.user.mapper.UserCollectMapper;
import com.ruoyi.user.service.IUserCollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class UserCollectServiceImpl extends ServiceImpl<UserCollectMapper, UserCollect> implements IUserCollectService {
    @Autowired
    private UserCollectMapper userCollectMapper;
    @Autowired
    private RemoteProductService remoteProductService;
    @Autowired
    private UserBehaviorMapper userBehaviorMapper;

    /**
     * 查询用户收藏列表
     *
     * @param userCollect 用户收藏
     * @return 用户收藏
     */
    @Override
    public List<UserCollect> selectUserCollectList(UserCollect userCollect)
    {
        //return userCollectMapper.selectUserCollectList(userCollect.getUserId(), userCollect.getSkuId());
        List<UserCollect> userCollectList = userCollectMapper.selectList(new LambdaQueryWrapper<UserCollect>().eq(UserCollect::getUserId, SecurityContextHolder.getUserId())
                .eq(UserCollect::getSpuId, userCollect.getSpuId()));
        return userCollectList;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean isCollect(Long spuId) {
        Long userId = SecurityContextHolder.getUserId();
        UserCollect userCollect = userCollectMapper.selectOne(new LambdaQueryWrapper<UserCollect>()
                .eq(UserCollect::getUserId, SecurityContextHolder.getUserId()).eq(UserCollect::getSpuId, spuId));

        if(userCollect != null){
            if(userCollect.getIsCollect() == 1){
                return true;
            }
        }
        return false;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean collect(Long spuId) {
        Long userId = SecurityContextHolder.getUserId();

        //用户行为记录
        UserBehavior behavior = new UserBehavior();
        behavior.setUserId(userId);
        behavior.setItemId(spuId);
        behavior.setBehaviorType(BehaviorType.FAVORITE);
        behavior.setScore(0.4);
        behavior.setCreateTime(new Date());
        userBehaviorMapper.insert(behavior);


        UserCollect userCollect = userCollectMapper.selectOne(new LambdaQueryWrapper<UserCollect>()
                .eq(UserCollect::getUserId, SecurityContextHolder.getUserId()).eq(UserCollect::getSpuId, spuId));
        if(userCollect == null){
            userCollect = new UserCollect();
            userCollect.setUserId(SecurityContextHolder.getUserId());
            userCollect.setSpuId(spuId);
            userCollect.setIsCollect(1);
            userCollect.setUpdateTime(new Date());

            return userCollectMapper.insert(userCollect) > 0;
        }else if(userCollect.getIsCollect() == 0 && userCollect != null){
            userCollect.setIsCollect(1);
            userCollect.setUpdateTime(new Date());
            return userCollectMapper.updateById(userCollect) > 0;
        }
        return false;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean cancelCollect(Long spuId) {
        UserCollect userCollect = userCollectMapper.selectOne(new LambdaQueryWrapper<UserCollect>()
                .eq(UserCollect::getUserId, SecurityContextHolder.getUserId()).eq(UserCollect::getSpuId, spuId));
        if(userCollect!=null && userCollect.getIsCollect() == 1){
            userCollect.setIsCollect(0);
            return userCollectMapper.updateById(userCollect) > 0;
        }
        return false;
    }

    @Override
    public List<UserCollect> userCollectList() {
        Long userId = SecurityContextHolder.getUserId();
        List<UserCollect> userCollectList = userCollectMapper.selectList(new LambdaQueryWrapper<UserCollect>().eq(UserCollect::getUserId, userId)
                .eq(UserCollect::getIsCollect, 1));

        List<Long> spuIdList = userCollectList.stream().map(UserCollect::getSpuId).collect(Collectors.toList());
        if(!CollectionUtils.isEmpty(spuIdList)){

            R<List<Product>> productListResult = remoteProductService.getProductListBySpuIdList(spuIdList, SecurityConstants.INNER);
            if(productListResult.getCode() == R.FAIL){
                throw new ServiceException(productListResult.getMsg());
            }
            List<Product> productList = productListResult.getData();

            Map<Long, Product> spuIdToProductMap = productList.stream().collect(Collectors.toMap(Product::getId, Function.identity()));


            userCollectList.forEach(userCollect -> {
                userCollect.setSpuName(spuIdToProductMap.get(userCollect.getSpuId()).getName());

                userCollect.setThumbImg(spuIdToProductMap.get(userCollect.getSpuId()).getSliderUrls().split(",")[0]);

                List<ProductSku> productSkuList = spuIdToProductMap.get(userCollect.getSpuId()).getProductSkuList();
                ProductSku minSalePriceSku = productSkuList.stream()
                        .min((sku1, sku2) -> sku1.getSalePrice().compareTo(sku2.getSalePrice()))
                        .orElse(null);
                userCollect.setSalePrice(minSalePriceSku.getSalePrice());
            });
            List<UserCollect> sortedCollectList = userCollectList.stream()
                    .sorted((o1, o2) -> o2.getUpdateTime().compareTo(o1.getUpdateTime()))
                    .collect(Collectors.toList());

            return sortedCollectList;
        }
        return userCollectList;
    }

}