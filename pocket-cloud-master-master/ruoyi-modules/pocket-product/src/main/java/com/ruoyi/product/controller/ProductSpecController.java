package com.ruoyi.product.controller;

import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.product.api.domain.ProductSpecs;
import com.ruoyi.product.domain.ProductSpec;
import com.ruoyi.product.service.ProductSpecService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Product Spec API Management")
@RestController
@RequestMapping("/productSpec")
public class ProductSpecController extends BaseController {
    @Autowired
    private ProductSpecService productSpecService;

    @Operation(summary = "Get productSpec list")
    @GetMapping("/list")
    public TableDataInfo list(ProductSpec productSpec){
        startPage();
        List<ProductSpec> list = productSpecService.selectProductSpecList(productSpec);
        return getDataTable(list);
    }

    @Operation(summary = "Get productSpec detail")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id){
        ProductSpec productSpec = productSpecService.selectProductSpecById(id);
        return success(productSpec);
    }

    @Operation(summary = "Add productSpec")
    @PostMapping
    public AjaxResult addProductSpec(@RequestBody ProductSpec productSpec){
        productSpec.setCreateBy(SecurityUtils.getUsername());
        int row = productSpecService.insertProductSpec(productSpec);
        return toAjax(row);
    }

    @Operation(summary = "Edit productSpec")
    @PutMapping
    public AjaxResult editProductSpec(@RequestBody ProductSpec productSpec){
        int row = productSpecService.updateProductSpec(productSpec);
        return toAjax(row);
    }

    @Operation(summary = "Delete productSpec")
    @DeleteMapping("/{ids}")
    public AjaxResult removeProductSpec(@PathVariable Long[] ids){
        int row = productSpecService.removeProductSpec(ids);
        return toAjax(row);
    }

    @Operation(summary = "Get product specification list according to the  category3id")
    @GetMapping("/productSpecList/{categoryId}")
    public AjaxResult selectProductSpecListByCategoryId(@PathVariable Long categoryId){
        List<ProductSpec> list = productSpecService.selectProductSpecListByCategoryId(categoryId);
        return success(list);
    }

    @Operation(summary = "New Add productSpec")
    @PostMapping("/newAddProductSpec")
    public AjaxResult newAddProductSpec(@RequestBody ProductSpecs productSpecs){
        productSpecs.setCreateBy(SecurityUtils.getUsername());
        int row = productSpecService.newInsertProductSpec(productSpecs);
        return toAjax(row);
    }

    @Operation(summary = "Get productSpec list")
    @GetMapping("/newList")
    public TableDataInfo newList(){
        startPage();
        List<ProductSpecs> list = productSpecService.newSelectProductSpecList();
        return getDataTable(list);
    }
}
