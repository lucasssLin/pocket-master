package com.ruoyi.product.controller;


import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.domain.CategoryBrand;
import com.ruoyi.product.service.CategoryBrandService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Category Brand API Management")
@RestController
@RequestMapping("/categoryBrand")
public class CategoryBrandController extends BaseController {
    @Autowired
    private CategoryBrandService categoryBrandService;

    @Operation(summary = "Get Category Brand List By Page")
    @GetMapping("/list")
    public TableDataInfo list(CategoryBrand categoryBrand){
        startPage();
        List<CategoryBrand> list = categoryBrandService.selectCategoryBrandList(categoryBrand);
        TableDataInfo result = getDataTable(list);
        return result;
    }

    @Operation(summary = "Get Category Brand Detail")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id ){
        CategoryBrand categoryBrand = categoryBrandService.selectCategoryBrandInfoById(id);
        return success(categoryBrand);
    }

    @Operation(summary = "Add Category Brand")
    @PostMapping
    public AjaxResult addCategoryBrand(@RequestBody CategoryBrand categoryBrand) {
        categoryBrand.setCreateBy(SecurityUtils.getUsername());
        return toAjax(categoryBrandService.insertCategoryBrand(categoryBrand));
    }

    @Operation(summary = "Edit Category Brand")
    @PutMapping
    public AjaxResult updateCategoryBrand(@RequestBody CategoryBrand categoryBrand){
        return toAjax(categoryBrandService.updateCategoryBrand(categoryBrand));
    }

    @Operation(summary = "Delete Category Brand")
    @DeleteMapping(value = "/{ids}")
    public AjaxResult deleteCategoryBrand(@PathVariable Long[] ids){
        return toAjax(categoryBrandService.deleteCategoryBrand(ids));
    }

    @Operation(summary = "Get brand list according to the third category")
    @GetMapping("/getBrand/{id}")
    public AjaxResult getBrandList(@PathVariable Long id ){
        List<Brand> brandList = categoryBrandService.selectBrandListByCategoryId(id);
        return success(brandList);
    }


}
