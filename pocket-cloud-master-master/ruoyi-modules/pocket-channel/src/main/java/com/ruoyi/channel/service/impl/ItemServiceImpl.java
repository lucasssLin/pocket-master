package com.ruoyi.channel.service.impl;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.channel.domain.ItemVo;
import com.ruoyi.channel.domain.RelevantVo;
import com.ruoyi.channel.service.IItemService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;

import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.product.api.domain.*;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.service.RemoteProductService;
import com.ruoyi.user.api.factory.RemoteUserInfoFallbackFactory;
import com.ruoyi.user.api.service.RemoteUserInfoService;
import lombok.extern.slf4j.Slf4j;

import org.redisson.api.RBloomFilter;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ThreadPoolExecutor;

@Service
@Slf4j
public class ItemServiceImpl implements IItemService {
    @Autowired
    private RemoteProductService remoteProductService;
    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;
    @Autowired
    private RabbitService rabbitService;
    @Autowired
    private RemoteUserInfoService remoteUserInfoService;

    @Override
    public ItemVo item(Long skuId) {
        RBloomFilter<Object> bloomFilter = redissonClient.getBloomFilter("sku:bloom:filter");
        if(!bloomFilter.contains(skuId)){
            log.error("The query product SKU is not existed：{}", skuId);
            throw new ServiceException("The query product SKU is not existed");
        }

        ItemVo itemVo = new ItemVo();

        //获取sku信息
        CompletableFuture<ProductSku> skuCompletableFuture = CompletableFuture.supplyAsync(()->{

            R<ProductSku> productSkuResult = remoteProductService.getProductSku(skuId, SecurityConstants.INNER);
            if (R.FAIL == productSkuResult.getCode()) {
                throw new ServiceException(productSkuResult.getMsg());
            }
            ProductSku productSku = productSkuResult.getData();
            itemVo.setProductSku(productSku);

            return productSku;

        }, threadPoolExecutor);


        //获取商品信息
        CompletableFuture<Void> productCompletableFuture = skuCompletableFuture.thenAcceptAsync(productSku -> {

            R<ProductVo> productResult = remoteProductService.getProduct(productSku.getProductId(), SecurityConstants.INNER);
            if (R.FAIL == productResult.getCode()) {
                throw new ServiceException(productResult.getMsg());
            }
            Product product = productResult.getData().getProduct();
            itemVo.setProduct(product);
            itemVo.setSliderUrlList(Arrays.asList(product.getSliderUrls().split(",")));
            //itemVo.setSpecValueList(JSON.parseArray(product.getSpecValue()));
            // specValue: [{"key":"颜色","valueList":["白色","红色","黑色"]},{"key":"内存","valueList":["8G","18G"]}]

        }, threadPoolExecutor);



        //获取商品最新价格
        CompletableFuture<Void> skuPriceCompletableFuture = CompletableFuture.runAsync(()->{

            R<SkuPrice> skuPriceResult = remoteProductService.getSkuPrice(skuId, SecurityConstants.INNER);
            if (R.FAIL == skuPriceResult.getCode()) {
                throw new ServiceException(skuPriceResult.getMsg());
            }
            SkuPrice skuPrice = skuPriceResult.getData();
            //itemVo.setSkuPrice(skuPrice);

        }, threadPoolExecutor);



        //获取商品详情
        CompletableFuture<Void> productDetailCompletableFuture = skuCompletableFuture.thenAcceptAsync(productSku -> {

            R<ProductDetails> productDetailsResult = remoteProductService.getProductDetails(productSku.getProductId(), SecurityConstants.INNER);
            if (R.FAIL == productDetailsResult.getCode()) {
                throw new ServiceException(productDetailsResult.getMsg());
            }
            ProductDetails productDetails = productDetailsResult.getData();
            itemVo.setDetailsImageUrlList(Arrays.asList(productDetails.getImageUrls().split(",")));

        }, threadPoolExecutor);


        //获取商品规格对应商品skuId信息
        CompletableFuture<Void> skuSpecValueComCompletableFuture = skuCompletableFuture.thenAcceptAsync(productSku -> {

            R<Map<String, Long>> skuSpecValueResult = remoteProductService.getSkuSpecValue(productSku.getProductId(), SecurityConstants.INNER);
            if (R.FAIL == skuSpecValueResult.getCode()) {
                throw new ServiceException(skuSpecValueResult.getMsg());
            }
            Map<String, Long> skuSpecValueMap = skuSpecValueResult.getData();
            itemVo.setSkuSpecValueMap(skuSpecValueMap);

        }, threadPoolExecutor);


        //获取商品库存信息
        CompletableFuture<Void> skuStockVoComCompletableFuture = CompletableFuture.runAsync(()-> {

            R<SkuStockVo> skuStockResult = remoteProductService.getSkuStock(skuId, SecurityConstants.INNER);
            if (R.FAIL == skuStockResult.getCode()) {
                throw new ServiceException(skuStockResult.getMsg());
            }
            SkuStockVo skuStockVo = skuStockResult.getData();
            itemVo.setSkuStockVo(skuStockVo);

        }, threadPoolExecutor);


        CompletableFuture.allOf(
                skuCompletableFuture,
                productCompletableFuture,
                skuPriceCompletableFuture,
                productDetailCompletableFuture,
                skuSpecValueComCompletableFuture,
                skuStockVoComCompletableFuture
        ).join();

        //记录浏览记录
        Long userId = SecurityContextHolder.getUserId();
        HashMap<String, Object> map = new HashMap<>();

        map.put("skuId", skuId);
        String mapJsonStr = JSON.toJSONString(map);
        rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_BROWSE_HISTORY, MessageQueueConstant.ROUTING_BROWSE_HISTORY, mapJsonStr);


        return itemVo;
    }


    @Override
    public ItemVo selectGoodsBySpuId(Long spuId) {

        ItemVo itemVo = new ItemVo();

        //获取skuList信息
        CompletableFuture<List<Long>> skuCompletableFuture = CompletableFuture.supplyAsync(()->{

            R<List<ProductSku>> productSkuResult = remoteProductService.getProductSkuListBySpuId(spuId, SecurityConstants.INNER);
            if (R.FAIL == productSkuResult.getCode()) {
                throw new ServiceException(productSkuResult.getMsg());
            }
            List<ProductSku> productSkuList = productSkuResult.getData();
            itemVo.setProductSkuList(productSkuList);

            //获取skuId
            List<Long> skuIdList = new ArrayList<>();
            for (ProductSku productSku : productSkuList) {
                skuIdList.add(productSku.getId());
            }
            return skuIdList;


        }, threadPoolExecutor);


        //获取商品信息
        CompletableFuture<Void> productCompletableFuture = CompletableFuture.runAsync(() -> {

            R<ProductVo> productResult = remoteProductService.getProduct(spuId, SecurityConstants.INNER);
            if (R.FAIL == productResult.getCode()) {
                throw new ServiceException(productResult.getMsg());
            }
            ProductVo productVo = productResult.getData();
            itemVo.setProduct(productVo.getProduct());
            if(productVo.getProduct().getSliderUrls() != null){
                itemVo.setSliderUrlList(Arrays.asList(productVo.getProduct().getSliderUrls().split(",")));
            }

            itemVo.setSpecValueList(productVo.getSpecsList());
            // specValue: [{"key":"颜色","valueList":["白色","红色","黑色"]},{"key":"内存","valueList":["8G","18G"]}]

        }, threadPoolExecutor);


        //获取商品最新价格
        CompletableFuture<Void> skuPriceCompletableFuture = skuCompletableFuture.thenAcceptAsync((skuIdList)->{
            List<SkuPrice> skuPriceList = new ArrayList<>();

            for (Long skuId : skuIdList){
                R<SkuPrice> skuPriceResult = remoteProductService.getSkuPrice(skuId, SecurityConstants.INNER);
                if (R.FAIL == skuPriceResult.getCode()) {
                    throw new ServiceException(skuPriceResult.getMsg());
                }
                SkuPrice skuPrice = skuPriceResult.getData();
                skuPriceList.add(skuPrice);
            }
            itemVo.setSkuPriceList(skuPriceList);

        }, threadPoolExecutor);

        //获取商品详情
        CompletableFuture<Void> productDetailCompletableFuture = CompletableFuture.runAsync(() -> {

            R<ProductDetails> productDetailsResult = remoteProductService.getProductDetails(spuId, SecurityConstants.INNER);
            if (R.FAIL == productDetailsResult.getCode()) {
                throw new ServiceException(productDetailsResult.getMsg());
            }
            ProductDetails productDetails = productDetailsResult.getData();
            if(productDetails.getImageUrls() != null){
                itemVo.setDetailsImageUrlList(Arrays.asList(productDetails.getImageUrls().split(",")));
            }
            String jsonStr = productDetails.getProperties();
            Map<String, String> propertiesMap = JSON.parseObject(jsonStr, new HashMap<String, String>().getClass());
            List<Map<String, String>> propertiesList = new ArrayList<>();
            // 遍历 Map 并转换为符合前端要求的格式
            for (Map.Entry<String, String> entry : propertiesMap.entrySet()) {
                Map<String, String> item = new HashMap<>();
                item.put("name", entry.getKey());
                item.put("value", entry.getValue());
                propertiesList.add(item);
            }
            itemVo.setProperties(propertiesList);

        }, threadPoolExecutor);


        //获取商品规格对应商品skuId信息
        CompletableFuture<Void> skuSpecValueComCompletableFuture = CompletableFuture.runAsync(() -> {

            R<Map<String, Long>> skuSpecValueResult = remoteProductService.getSkuSpecValue(spuId, SecurityConstants.INNER);
            if (R.FAIL == skuSpecValueResult.getCode()) {
                throw new ServiceException(skuSpecValueResult.getMsg());
            }
            Map<String, Long> skuSpecValueMap = skuSpecValueResult.getData();
            itemVo.setSkuSpecValueMap(skuSpecValueMap);

        }, threadPoolExecutor);


        //获取商品库存信息
        CompletableFuture<Void> skuStockVoComCompletableFuture = skuCompletableFuture.thenAcceptAsync((skuIdList)-> {

            R<List<SkuStockVo>> skuStockResult = remoteProductService.getSkuStockListBySkuIdList(skuIdList, SecurityConstants.INNER);
            if (R.FAIL == skuStockResult.getCode()) {
                throw new ServiceException(skuStockResult.getMsg());
            }
            List<SkuStockVo> skuStockVoList = skuStockResult.getData();
            itemVo.setSkuStockVoList(skuStockVoList);

            for(SkuStockVo skuStockVo : itemVo.getSkuStockVoList()){
                for(ProductSku productSku : itemVo.getProductSkuList()){
                    if(productSku.getId().equals(skuStockVo.getSkuId())){
                        productSku.setStockNum(skuStockVo.getAvailableNum());
                        productSku.setSaleNum(skuStockVo.getSaleNum());
                    }
                }
            }

        }, threadPoolExecutor);


        CompletableFuture.allOf(
                skuCompletableFuture,
                productCompletableFuture,
                skuPriceCompletableFuture,
                productDetailCompletableFuture,
                skuSpecValueComCompletableFuture,
                skuStockVoComCompletableFuture
        ).join();

        //记录浏览记录
        Long userId = SecurityContextHolder.getUserId();
        HashMap<String, Object> map = new HashMap<>();

        map.put("spuId", spuId);
        map.put("userId", userId);
        String mapJsonStr = JSON.toJSONString(map);
        rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_BROWSE_HISTORY, MessageQueueConstant.ROUTING_BROWSE_HISTORY, mapJsonStr);



        return itemVo;
    }

    @Override
    public List<RelevantVo> selectRelevantGoodsBySpuId(Long spuId, int limit) {

        List<RelevantVo> relevantVoList = new ArrayList<>();

        R<List<Product>> recommendedProducts = remoteProductService.selectRelevantGoodsBySpuId(spuId, SecurityConstants.INNER);

        if (R.FAIL == recommendedProducts.getCode()) {
            throw new ServiceException(recommendedProducts.getMsg());
        }
        List<Product> productList = recommendedProducts.getData();
        for (Product product : productList) {
            if (relevantVoList.size() >= limit) {
                break;
            }
            RelevantVo relevantVo = new RelevantVo();
            relevantVo.setSpuId(product.getId());
            relevantVo.setPicture(product.getSliderUrls().split(",")[0]);
            relevantVo.setName(product.getName());
            relevantVo.setDesc(product.getDescription());
            if (product.getProductSku() != null) {
                relevantVo.setPrice(product.getProductSku().getSalePrice());
                relevantVo.setDiscount(product.getProductSku().getDiscount());
            }
            relevantVoList.add(relevantVo);
        }

        return relevantVoList;
    }



}
