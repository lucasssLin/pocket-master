package com.ruoyi.product.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.product.domain.ProductUnit;
import com.ruoyi.product.service.IProductUnitService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Product Unit API Management")
@RestController
@RequestMapping("/productUnit")
public class ProductUnitController extends BaseController {
    @Autowired
    private IProductUnitService iProductUnitService;

    @Operation(summary = "Get ProductUnit List By Page")
    @GetMapping("/list")
    public TableDataInfo findPage(
            @Parameter(name = "pageNum", description = "Current Page", required = true)
            @RequestParam(value = "pageNum", defaultValue = "0", required = true) Integer pageNum,
            @Parameter(name = "pageSize", description = "Record Number Per Page", required = true)
            @RequestParam(value = "pageSize", defaultValue = "10", required = true)Integer pageSize,
            @Parameter(name = "driverInfoQuery", description = "Query Object", required = false)ProductUnit productUnit){

                Page<ProductUnit> pageParam = new Page<>(pageNum, pageSize);
                IPage<ProductUnit> page = iProductUnitService.selectProductUnitPage(pageParam, productUnit);
                return getDataTable(page);
    }

    @Operation(summary = "Get ProductUnit Detail")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id){
        ProductUnit productUnit = iProductUnitService.selectProductUnitById(id);
        return success(productUnit);
    }

    @Operation(summary = "Add ProductUnit")
    @PostMapping
    public AjaxResult add(@RequestBody ProductUnit productUnit){
        productUnit.setCreateBy(SecurityUtils.getUsername());
        int row = iProductUnitService.insertProductUnit(productUnit);
        return toAjax(row);
    }

    @Operation(summary = "Edit ProductUnit")
    @PutMapping
    public AjaxResult edit(@RequestBody ProductUnit productUnit){
        productUnit.setUpdateBy(SecurityUtils.getUsername());
        int row = iProductUnitService.updateProductUnit(productUnit);
        return toAjax(row);
    }

    @Operation(summary = "Delete ProductUnit")
    @DeleteMapping("/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids){
        int result = iProductUnitService.deleteProductUnitByIds(ids);
        return toAjax(result);
    }

    @Operation(summary = "Get All ProductUnit")
    @GetMapping("/getUnitAll")
    public AjaxResult selectUnitAll(){
        List<ProductUnit> list = iProductUnitService.selectUnitAll();
        return success(list);
    }
}
