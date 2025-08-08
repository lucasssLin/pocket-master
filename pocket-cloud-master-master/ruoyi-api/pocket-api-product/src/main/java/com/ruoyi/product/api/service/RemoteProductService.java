package com.ruoyi.product.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.*;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.factory.RemoteProductFallbackFactory;

import org.springframework.cloud.openfeign.FeignClient;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@FeignClient(contextId = "remoteProductService", value = ServiceNameConstants.PRODUCT_SERVICE, fallbackFactory = RemoteProductFallbackFactory.class)
public interface RemoteProductService {


    @GetMapping("/product/getTopSale")
    public R<List<ProductSku>> getTopSale(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping("/product/skuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> skuList(@PathVariable("pageNum") Integer pageNum, @PathVariable("pageSize") Integer pageSize, @SpringQueryMap SkuQuery skuQuery, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping("/product/spuList/{pageNum}/{pageSize}")
    R<TableDataInfo> spuList(@PathVariable("pageNum") Integer pageNum, @PathVariable("pageSize") Integer pageSize, @SpringQueryMap SkuQuery skuQuery, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    //PRODUCT DETAIL
    @GetMapping("/product/getProductSku/{skuId}")
    public R<ProductSku> getProductSku(@PathVariable("skuId") Long skuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getProduct/{id}")
    public R<ProductVo> getProduct(@PathVariable("id") Long id, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getSkuPrice/{skuId}")
    public R<SkuPrice> getSkuPrice(@PathVariable("skuId") Long skuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getProductDetails/{id}")
    public R<ProductDetails> getProductDetails(@PathVariable("id") Long id, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getSkuSpecValue/{id}")
    public R<Map<String, Long>> getSkuSpecValue(@PathVariable("id") Long id, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getSkuStock/{skuId}")
    public R<SkuStockVo> getSkuStock(@PathVariable("skuId") Long skuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping(value = "/product/getSkuStockList")
    public R<List<SkuStockVo>> getSkuStockListBySkuIdList(@RequestBody List<Long> skuIdList, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping(value = "/product/getSkuPriceList")
    public R<List<SkuPrice>> getSkuPriceList(@RequestBody List<Long> skuIdList, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping("/product/checkAndLock/{orderNo}")
    public R<String> checkAndLock(@PathVariable("orderNo") String orderNo, @RequestBody List<SkuLockVo> skuLockVoList, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getProductSkuList")
    public R<List<ProductSku>> getProductSkuList(@RequestBody List<Long> skuIdList, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/getProductSkuListBySpuId/{spuId}")
    public R<List<ProductSku>> getProductSkuListBySpuId(@PathVariable("spuId")Long spuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/selectRelevantGoodsBySpuId/{spuId}")
    public R<List<Product>> selectRelevantGoodsBySpuId(@PathVariable("spuId")Long spuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping(value = "/product/getProductListBySpuIdList")
    public R<List<Product>> getProductListBySpuIdList(@RequestBody List<Long> spuIdList, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PutMapping(value = "/product/updateProductPrice/{skuId}/{salePrice}")
    public R<Integer> updateProductPrice( @PathVariable("skuId") Long skuId, @PathVariable("salePrice") Double salePrice, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/product/recommendType")
    public R<List<RecommendType>> getHotRecommend(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping("/product/selectHotProductSpuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> selectHotProductSpuList(@PathVariable("pageNum") Integer pageNum, @PathVariable("pageSize") Integer pageSize, @ModelAttribute SkuQuery skuQuery, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping("/product/selectProductListPageBySpuIdList/{pageNum}/{pageSize}")
    public R<TableDataInfo> selectProductListPageBySpuIdList(@RequestBody List<Long> spuIdList, @PathVariable("pageNum") Integer pageNum, @PathVariable("pageSize") Integer pageSize, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);


}
