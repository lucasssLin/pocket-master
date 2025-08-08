package com.ruoyi.product.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.product.api.domain.SkuPrice;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.SkuStockVo;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.ProductDetails;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.domain.RecommendType;


import java.util.List;
import java.util.Map;

public interface IProductService extends IService<Product> {
    List<Product> selectPageList(Product product);

    int insertProduct(Product product);

    Product selectProductInfo(Long id);

    int updateProduct(Product product);

    int deleteProductsByProductIds(Long[] ids);

    void updateAuditStatus(Long id, int auditStatus);

    void updateStatus(Long id, Integer status);

    List<ProductSku> getTopSale();

    List<ProductSku> selectSkuList(SkuQuery skuQuery);

    ProductSku getProductSku(Long skuId);

    ProductVo getProductByProductId(Long id);

    SkuPrice getSkuPrice(Long skuId);

    ProductDetails getProductDetails(Long id);

    Map<String, Long> getSkuSpecValue(Long id);

    SkuStockVo getSkuStock(Long skuId);

    List<SkuPrice> getSkuPriceList(List<Long> skuIdList);

    String checkAndLock(String orderNo, List<SkuLockVo> skuLockVoList);


    void unlock(String orderNo);

    void minusStock(String orderNo);

    List<ProductSku> getProductSkuList(List<Long> skuIdList);

    List<ProductSku> getProductSkuListBySpuId(Long spuId);

    List<SkuStockVo> getSkuStockListBySpuId(List<Long> skuIdList);

    List<ProductVo> selectSpuList(SkuQuery skuQuery);

    int newInsertProduct(Product product);

    List<Product> selectRelevantGoodsBySpuId(Long spuId);

    List<Product> getProductListBySpuIdList(List<Long> spuIdList);

    int updateProductPrice(Long skuId, Double salePrice);

    List<RecommendType> getHotRecommendType();

    List<ProductVo> selectProductListPageBySpuIdList(List<Long> spuIdList);
}
