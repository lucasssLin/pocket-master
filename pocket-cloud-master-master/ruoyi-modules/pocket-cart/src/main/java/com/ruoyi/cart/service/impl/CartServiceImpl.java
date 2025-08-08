package com.ruoyi.cart.service.impl;

import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.domain.CartInfoVo;
import com.ruoyi.cart.service.ICartService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.SkuPrice;
import com.ruoyi.product.api.domain.SkuStockVo;
import com.ruoyi.product.api.service.RemoteProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service

public class CartServiceImpl implements ICartService {

    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private RemoteProductService remoteProductService;

    private String getCartKey(Long userId) {

        return "user:cart:" + userId;
    }


    @Override
    public void addToCart(Long skuId, Integer skuNum) {
        Long userId = SecurityContextHolder.getUserId();

        String cartKey = getCartKey(userId);

        BoundHashOperations<String, String, CartInfo> hashOps = redisTemplate.boundHashOps(cartKey);

        //Check whether the user's shopping cart contains the item.
        //If the item contains: The quantity is added. (The maximum quantity of an item is 99.)
        String hashKey = skuId.toString();
        Integer limitation = 99;

        if(hashOps.hasKey(hashKey)){
            CartInfo cartInfo = hashOps.get(hashKey);
            int totalCount = cartInfo.getCount() + skuNum;
            cartInfo.setCount(totalCount > limitation ? limitation : totalCount);
            cartInfo.setUpdateTime(new Date());
            hashOps.put(hashKey, cartInfo);
        } else {
            Long count = hashOps.size();
            if (++count > 50){
                throw new RuntimeException("Product category number exceeds the limit.");
            }

            CartInfo cartInfo = new CartInfo();
            cartInfo.setUserId(userId);
            cartInfo.setCount(skuNum > limitation ? limitation : skuNum);
            cartInfo.setUpdateTime(new Date());
            cartInfo.setCreateTime(new Date());

            R<ProductSku> productSkuResult = remoteProductService.getProductSku(skuId, SecurityConstants.INNER);

            if(productSkuResult.getCode() == R.FAIL){
                throw new ServiceException(productSkuResult.getMsg());
            }

            ProductSku productSku = productSkuResult.getData();
            cartInfo.setSkuId(skuId);
            cartInfo.setSkuName(productSku.getSkuName());
            cartInfo.setThumbImg(productSku.getThumbImg());
            cartInfo.setSpuId(productSku.getProductId());
            cartInfo.setAttrsText(productSku.getSkuSpec());
            if(productSku.getStatus()!=1){
                cartInfo.setIsEffective(false);
            }else {
                cartInfo.setIsEffective(true);
            }
            cartInfo.setSkuName(productSku.getSkuName());
            R<SkuPrice> skuPriceResult = remoteProductService.getSkuPrice(skuId, SecurityConstants.INNER);
            if(skuPriceResult.getCode() == R.FAIL){
                throw new ServiceException(skuPriceResult.getMsg());
            }
            SkuPrice skuPrice = skuPriceResult.getData();
            cartInfo.setCartPrice(skuPrice.getSalePrice());
            cartInfo.setSkuPrice(skuPrice.getSalePrice());
            cartInfo.setMarketPrice(skuPrice.getMarketPrice());

            hashOps.put(hashKey, cartInfo);
        }

    }

    @Override
    public List<CartInfo> getCartList() {
        Long userId = SecurityContextHolder.getUserId();

        String cartKey = this.getCartKey(userId);

        List<CartInfo> cartInfoList = redisTemplate.opsForHash().values(cartKey);

        if(!CollectionUtils.isEmpty(cartInfoList)){
            List<CartInfo> sortedCartInfoList = cartInfoList.stream().sorted((o1, o2)-> o2.getUpdateTime().compareTo(o1.getUpdateTime())).collect(Collectors.toList());

            List<Long> skuIdList = sortedCartInfoList.stream().map(CartInfo::getSkuId).collect(Collectors.toList());

            R<List<SkuPrice>> skuPriceListResult = remoteProductService.getSkuPriceList(skuIdList, SecurityConstants.INNER);

            if(skuPriceListResult.getCode() == R.FAIL){
                throw new ServiceException(skuPriceListResult.getMsg());
            }

            Map<Long, BigDecimal> skuIdToPriceMap = skuPriceListResult.getData().stream().collect(Collectors.toMap(SkuPrice::getSkuId, SkuPrice::getSalePrice));

            sortedCartInfoList.forEach(cartInfo -> cartInfo.setSkuPrice(skuIdToPriceMap.get(cartInfo.getSkuId())));

            R<List<SkuStockVo>> skuStockListBySkuIdListResult = remoteProductService.getSkuStockListBySkuIdList(skuIdList, SecurityConstants.INNER);
            if(skuStockListBySkuIdListResult.getCode() == R.FAIL){
                throw new ServiceException(skuStockListBySkuIdListResult.getMsg());
            }
            Map<Long, Integer> skuIdToStockMap = skuStockListBySkuIdListResult.getData().stream().collect(Collectors.toMap(SkuStockVo::getSkuId, SkuStockVo::getAvailableNum));
            sortedCartInfoList.forEach(cartInfo -> {
                cartInfo.setStock(skuIdToStockMap.get(cartInfo.getSkuId()));
            });


            return sortedCartInfoList;
        }
        return new ArrayList<>();
    }

    @Override
    public void deleteCart(Long skuId) {
        Long userId = SecurityContextHolder.getUserId();

        String cartKey = this.getCartKey(userId);

        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);

        hashOperations.delete(skuId.toString());
    }

    @Override
    public void checkCart(Long skuId, Integer isChecked) {
//        Long userId = SecurityContextHolder.getUserId();
//
//        String cartKey = this.getCartKey(userId);
//
//        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);
//
//        if(hashOperations.hasKey(skuId.toString())){
//            CartInfo cartInfo = hashOperations.get(skuId.toString());
//
//            cartInfo.setIsChecked(isChecked);
//
//            hashOperations.put(skuId.toString(), cartInfo);
//        }

    }

    @Override
    public void allCheckCart(CartInfoVo cartInfoVo) {
        Long userId = SecurityContextHolder.getUserId();

        String cartKey = getCartKey(userId);

        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);

        List<CartInfo> cartInfoList = hashOperations.values();

        cartInfoList.forEach(product -> {
            CartInfo cartInfo = hashOperations.get(product.getSkuId().toString());
            cartInfo.setIsChecked(cartInfoVo.getIsChecked());
            hashOperations.put(product.getSkuId().toString(), cartInfo);
        });
    }

    @Override
    public void clearCart() {
        Long userId = SecurityContextHolder.getUserId();
        String cartKey = getCartKey(userId);

        redisTemplate.delete(cartKey);
    }

    @Override
    public List<CartInfo> getCartCheckedList(Long userId) {
        List<CartInfo> cartInfoList = new ArrayList<>();

        String cartKey = this.getCartKey(userId);
        List<CartInfo> cartCachInfoList = redisTemplate.opsForHash().values(cartKey);
        if (!CollectionUtils.isEmpty(cartCachInfoList)) {
            for (CartInfo cartInfo : cartCachInfoList) {

                if (cartInfo.getIsChecked()) {
                    cartInfoList.add(cartInfo);
                }
            }
        }
        return cartInfoList;
    }


    @Override
    public Boolean updateCartPrice(Long userId) {
        String cartKey = getCartKey(userId);
        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);
        List<CartInfo> cartCacheInfoList = hashOperations.values();

        if (!CollectionUtils.isEmpty(cartCacheInfoList)) {
            for (CartInfo cartInfo : cartCacheInfoList) {
                if (cartInfo.getIsChecked()== true) {
                    SkuPrice skuPrice = remoteProductService.getSkuPrice(cartInfo.getSkuId(), SecurityConstants.INNER).getData();
                    cartInfo.setCartPrice(skuPrice.getSalePrice());
                    cartInfo.setSkuPrice(skuPrice.getSalePrice());
                    hashOperations.put(cartInfo.getSkuId().toString(), cartInfo);
                }
            }
        }
        return true;
    }

    @Override
    public Boolean deleteCartCheckedList(Long userId) {
        String cartKey = getCartKey(userId);
        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);
        List<CartInfo> cartCachInfoList = hashOperations.values();

        if (!CollectionUtils.isEmpty(cartCachInfoList)) {
            for (CartInfo cartInfo : cartCachInfoList) {

                if (cartInfo.getIsChecked() == true) {
                    hashOperations.delete(cartInfo.getSkuId().toString());
                }
            }
        }
        return true;
    }

    @Override
    public Boolean updateAllUnchecked(Long userId) {

        BoundHashOperations<String, String, CartInfo> cart = redisTemplate.boundHashOps(getCartKey(userId));
        List<CartInfo> cartInfoList = cart.values();

        try {
            for (CartInfo cartInfo : cartInfoList) {
                cartInfo.setIsChecked(false);
                cart.put(cartInfo.getSkuId().toString(), cartInfo);
            }
            return true;
        }catch (Exception e){
            return false;
        }
    }

    @Override
    public void updateCartSku(Long skuId, CartInfoVo cartInfoVo) {
        Long userId = SecurityContextHolder.getUserId();

        String cartKey = getCartKey(userId);

        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);

        String hashKey = skuId.toString();
        CartInfo cartInfo = hashOperations.get(hashKey);

        if (cartInfo != null) {
            if(cartInfoVo.getIsChecked() != null){
                // 更新选中状态和数量
                cartInfo.setIsChecked(cartInfoVo.getIsChecked());
            }
            if(cartInfoVo.getCount()!= null){
                // 限制商品数量不超过 99
                Integer limitation = 99;
                cartInfo.setCount(Math.min(cartInfoVo.getCount(), limitation));
            }
            // 将更新后的信息存回 Redis
            hashOperations.put(hashKey, cartInfo);
        }

    }

    @Override
    public void deleteCartItemList(List<Long> skuIdList) {
        Long userId = SecurityContextHolder.getUserId();
        String cartKey = getCartKey(userId);

        BoundHashOperations<String, String, CartInfo> cart = redisTemplate.boundHashOps(cartKey);
        skuIdList.forEach(skuId -> {
            cart.delete(skuId.toString());
        });
    }

}
