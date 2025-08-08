package com.ruoyi.product.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.*;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.service.RemoteProductService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class RemoteProductFallbackFactory implements FallbackFactory<RemoteProductService> {

    private static final Logger log = LoggerFactory.getLogger(RemoteProductFallbackFactory.class);


    @Override
    public RemoteProductService create(Throwable throwable) {
        log.error("Service invoked failed:{}", throwable.getMessage());

        return new RemoteProductService() {
            @Override
            public R<List<ProductSku>> getTopSale(String source) {
                return R.fail("Get product failed"+throwable.getMessage());
            }

            @Override
            public R<TableDataInfo> skuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery, String source) {
                return R.fail("Get productSKU List failed:" + throwable.getMessage());
            }

            @Override
            public R<TableDataInfo> spuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery, String source) {
                return R.fail("Get product spu List failed:" + throwable.getMessage());
            }

            @Override
            public R<ProductSku> getProductSku(Long skuId, String source) {
                return R.fail("Get product SKU failed:" + throwable.getMessage());
            }

            @Override
            public R<ProductVo> getProduct(Long id, String source) {
                return R.fail("Get product info failed:" + throwable.getMessage());
            }

            @Override
            public R<SkuPrice> getSkuPrice(Long skuId, String source) {
                return R.fail("Get product SKU price failed:" + throwable.getMessage());
            }

            @Override
            public R<ProductDetails> getProductDetails(Long id, String source) {
                return R.fail("Get product detail failed:" + throwable.getMessage());
            }

            @Override
            public R<Map<String, Long>> getSkuSpecValue(Long id, String source) {
                return R.fail("Get product spec failed:" + throwable.getMessage());
            }

            @Override
            public R<SkuStockVo> getSkuStock(Long skuId, String source) {
                return R.fail("Get product stock failed:" + throwable.getMessage());
            }

            @Override
            public R<List<SkuStockVo>> getSkuStockListBySkuIdList(List<Long> skuIdList, String source) {
                return R.fail("Get product stock failed:" + throwable.getMessage());
            }


            @Override
            public R<List<SkuPrice>> getSkuPriceList(List<Long> skuIdList, String source) {
                return R.fail("Get product SKU price list failed:" + throwable.getMessage());
            }

            @Override
            public R<String> checkAndLock(String orderNo, List<SkuLockVo> skuLockVoList, String source) {
                return R.fail("Check and lock product failed:" + throwable.getMessage());
            }

            @Override
            public R<List<ProductSku>> getProductSkuList(List<Long> skuIdList, String source) {
                return R.fail("获取ProductSkuList失败:" + throwable.getMessage());

            }

            @Override
            public R<List<ProductSku>> getProductSkuListBySpuId(Long spuId, String source) {
                return R.fail("获取ProductSkuList失败:" + throwable.getMessage());
            }

            @Override
            public R<List<Product>> selectRelevantGoodsBySpuId(Long spuId, String source) {
                return R.fail("获取ProductList失败:" + throwable.getMessage());
            }

            @Override
            public R<List<Product>> getProductListBySpuIdList(List<Long> spuIdList, String source) {
                return R.fail("获取ProductList失败:" + throwable.getMessage());
            }

            @Override
            public R<Integer> updateProductPrice(Long skuId, Double salePrice, String source) {
                return R.fail("updateProductPrice失败:" + throwable.getMessage());
            }

            @Override
            public R<List<RecommendType>> getHotRecommend(String source) {
                return R.fail("获取HotRecommend失败:" + throwable.getMessage());
            }

            @Override
            public R<TableDataInfo> selectHotProductSpuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery, String source) {
                return R.fail("获取HotProductSpuList失败:" + throwable.getMessage());
            }



            @Override
            public R<TableDataInfo> selectProductListPageBySpuIdList(List<Long> spuIdList, Integer pageNum, Integer pageSize, String source) {
                return R.fail("获取ProductList失败:" + throwable.getMessage());
            }
        };

    }
}
