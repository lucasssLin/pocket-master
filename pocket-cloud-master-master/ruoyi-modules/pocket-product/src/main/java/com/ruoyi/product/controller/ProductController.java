package com.ruoyi.product.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.product.api.domain.SkuPrice;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.SkuStockVo;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.ProductDetails;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.domain.RecommendType;
import com.ruoyi.product.service.IProductService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/product")
public class ProductController extends BaseController {

    @Autowired
    private IProductService productService;

    @Operation(summary = "product page list")
    @GetMapping("/list")
    public TableDataInfo getPageList(Product product){
        startPage();
        List<Product> list = productService.selectPageList(product);
        return getDataTable(list);
    }

    @Operation(summary = "Add Product")
    @PostMapping
    public AjaxResult addProduct(@RequestBody Product product){
        int row = productService.insertProduct(product);
        return toAjax(row);
    }

    @Operation(summary = "Get Product Detail")
    @GetMapping("/{id}")
    public AjaxResult selectProductInfo(@PathVariable(value = "id") Long id){
        Product product = productService.selectProductInfo(id);
        return success(product);
    }

    @Operation(summary = "Edit Product")
    @PutMapping
    public AjaxResult updateProduct(@RequestBody Product product){
        int row = productService.updateProduct(product);
        return toAjax(row);
    }

    @Operation(summary = "Delete products")
    @DeleteMapping("/{ids}")
    public AjaxResult deleteProductsByProductIds(@PathVariable Long[] ids){
        int row = productService.deleteProductsByProductIds(ids);
        return toAjax(row);
    }

    @Operation(summary = "Audit Product")
    @GetMapping ("updateAuditStatus/{id}/{auditStatus}")
    public AjaxResult updateAuditStatus(@PathVariable Long id, @PathVariable Integer auditStatus){
        productService.updateAuditStatus(id, auditStatus);
        return success();
    }

    @Operation(summary = "Update status")
    @GetMapping("updateStatus/{id}/{status}")
    public AjaxResult updateStatus(@PathVariable Long id, @PathVariable Integer status){
        productService.updateStatus(id, status);
        return success();
    }

    @InnerAuth
    @Operation(summary = "Get top sales SKU")
    @GetMapping("/getTopSale")
    public R<List<ProductSku>> getTopSale(){
        List<ProductSku> list = productService.getTopSale();
        return R.ok(list);
    }


    @InnerAuth
    @Operation(summary = "get product SKU list")
    @GetMapping("/skuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> skuList(
            @PathVariable(value = "pageNum") Integer pageNum,
            @PathVariable(value = "pageSize") Integer pageSize,
            @ModelAttribute SkuQuery skuQuery){

        PageHelper.startPage(pageNum, pageSize);
        List<ProductSku> productSkuList = productService.selectSkuList(skuQuery);
        return R.ok(getDataTable(productSkuList));

    }

    @InnerAuth
    @GetMapping("/spuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> spuList(
            @PathVariable(value = "pageNum") Integer pageNum,
            @PathVariable(value = "pageSize") Integer pageSize,
            @ModelAttribute SkuQuery skuQuery){

        PageHelper.startPage(pageNum, pageSize);
        List<ProductVo> productSpuList = productService.selectSpuList(skuQuery);
        return R.ok(getDataTable(productSpuList));

    }


    //获取商品详情

    //获取商品sku信息
    @InnerAuth
    @Operation(summary = "获取商品sku信息")
    @GetMapping("/getProductSku/{skuId}")
    public R<ProductSku> getProductSku(@PathVariable(value = "skuId") Long skuId){
        ProductSku productSku = productService.getProductSku(skuId);
        return R.ok(productSku);
    }

    @InnerAuth
    @Operation(summary = "获取商品信息")
    @GetMapping( "/getProduct/{id}")
    public R<ProductVo> getProduct(@PathVariable(value = "id") Long id){
        ProductVo productVo = productService.getProductByProductId(id);
        return R.ok(productVo);
    }

    @Operation(summary = "获取商品sku最新价格信息")
    @InnerAuth
    @GetMapping(value = "/getSkuPrice/{skuId}")
    public R<SkuPrice> getSkuPrice(@PathVariable(value = "skuId") Long skuId){
        SkuPrice skuPrice = productService.getSkuPrice(skuId);
        return R.ok(skuPrice);
    }

    @Operation(summary = "获取商品详细信息")
    @InnerAuth
    @GetMapping(value = "/getProductDetails/{id}")
    public R<ProductDetails> getProductDetails(@PathVariable("id")Long id){
        ProductDetails productDetails = productService.getProductDetails(id);
        return R.ok(productDetails);
    }

    @Operation(summary = "获取商品sku规格详细信息")
    @InnerAuth
    @GetMapping(value = "/getSkuSpecValue/{id}")
    public R<Map<String, Long>> getSkuSpecValue(@PathVariable("id") Long id ){
        Map<String, Long> skuSpecValueMap = productService.getSkuSpecValue(id);
        return R.ok(skuSpecValueMap);
    }

    @Operation(summary = "获取商品sku库存信息")
    @InnerAuth
    @GetMapping(value = "/getSkuStock/{skuId}")
    public R<SkuStockVo> getSkuStock(@PathVariable("skuId") Long skuId){
        SkuStockVo skuStockVo = productService.getSkuStock(skuId);
        return R.ok(skuStockVo);
    }

    @InnerAuth
    @PostMapping(value = "/getSkuStockList")
    public R<List<SkuStockVo>> getSkuStockListBySkuIdList(@RequestBody List<Long> skuIdList){
        List<SkuStockVo> skuStockVoList = productService.getSkuStockListBySpuId(skuIdList);
        return R.ok(skuStockVoList);
    }

    //Inquiry cart list current price
    @PostMapping(value = "/getSkuPriceList")
    public R<List<SkuPrice>> getSkuPriceList(@RequestBody List<Long>skuIdList) {
        List<SkuPrice> skuPriceList = productService.getSkuPriceList(skuIdList);
        return R.ok(skuPriceList);
    }


    @InnerAuth
    @Operation(summary = "Check and lock inventory")
    @PostMapping("/checkAndLock/{orderNo}")
    public R<String> checkAndLock(@PathVariable("orderNo") String orderNo, @RequestBody List<SkuLockVo> skuLockVoList){
        try {
            String result = productService.checkAndLock(orderNo, skuLockVoList);
            return R.ok(result);
        }catch (ServiceException e){
            e.printStackTrace();
            return R.ok(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            return R.ok("Inventory lock failed");
        }
    }

    @InnerAuth
    @PostMapping(value = "/getProductSkuList")
    public R<List<ProductSku>> getProductSkuList(@RequestBody List<Long> skuIdList){
        List<ProductSku> productSkuList = productService.getProductSkuList(skuIdList);
        return R.ok(productSkuList);
    }

    //new
    @InnerAuth
    @GetMapping(value = "/getProductSkuListBySpuId/{spuId}")
    public R<List<ProductSku>> getProductSkuListBySpuId(@PathVariable("spuId") Long spuId){
        List<ProductSku> productSkuList = productService.getProductSkuListBySpuId(spuId);
        return R.ok(productSkuList);
    }

    @Operation(summary = "NEW Add Product")
    @PostMapping("newAddProduct")
    public AjaxResult newAddProduct(@RequestBody Product product){
        int row = productService.newInsertProduct(product);
        return toAjax(row);
    }
    //new
    @InnerAuth
    @GetMapping(value = "/selectRelevantGoodsBySpuId/{spuId}")
    public R<List<Product>> selectRelevantGoodsBySpuId(@PathVariable("spuId") Long spuId){
        List<Product> productList = productService.selectRelevantGoodsBySpuId(spuId);
        return R.ok(productList);
    }

    //new
    @InnerAuth
    @PostMapping(value = "/getProductListBySpuIdList")
    public R<List<Product>> getProductListBySpuIdList(@RequestBody List<Long> spuIdList){
        List<Product> productList = productService.getProductListBySpuIdList(spuIdList);
        return R.ok(productList);
    }

    @InnerAuth
    @PutMapping(value = "/updateProductPrice/{skuId}/{salePrice}")
    public R<Integer> updateProductPrice( @PathVariable("skuId") Long skuId, @PathVariable("salePrice") Double salePrice){
        int row = productService.updateProductPrice(skuId, salePrice);
        return R.ok(row);
    }

    @InnerAuth
    @Operation(summary = "Get hot recommend type")
    @GetMapping("/recommendType")
    public R<List<RecommendType>> getHotRecommend() {
        List<RecommendType> hotItemList = productService.getHotRecommendType();
        return R.ok(hotItemList);
    }

    @InnerAuth
    @Operation(summary = "Get hot product list")
    @PostMapping("/selectHotProductSpuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> selectHotProductSpuList(@PathVariable(value = "pageNum") Integer pageNum,
                                                    @PathVariable(value = "pageSize") Integer pageSize,
                                                    @RequestBody(required = false) SkuQuery skuQuery) {
        // 如果skuQuery为空，创建一个空的查询对象
        if (skuQuery == null) {
            skuQuery = new SkuQuery();
        }
        String orderBy = "orderNum desc";
        PageHelper.startPage(pageNum, pageSize, orderBy);
        List<ProductVo> productSpuList = productService.selectSpuList(skuQuery);

        return R.ok(getDataTable(productSpuList));
    }

    @InnerAuth
    @Operation(summary = "Get recommend product list")
    @PostMapping("/selectProductListPageBySpuIdList/{pageNum}/{pageSize}")
    public R<TableDataInfo> selectProductListPageBySpuIdList(@RequestBody List<Long> spuIdList,
                                                             @PathVariable(value = "pageNum") Integer pageNum,
                                                    @PathVariable(value = "pageSize") Integer pageSize
                                                    ) {
        // 如果spuIdList为空，创建一个空的查询对象
        if (spuIdList == null) {
            spuIdList = new ArrayList<>();
        }

        PageHelper.startPage(pageNum, pageSize);

        List<ProductVo> productVoList = productService.selectProductListPageBySpuIdList(spuIdList);
        return R.ok(getDataTable(productVoList));
    }
}
