package com.ruoyi.product.controller;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.service.IBrandService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Brand API Management")
@RestController
@RequestMapping("/brand")
public class BrandController extends BaseController
{
    @Autowired
    private IBrandService brandService;

    @RequiresPermissions("product:brand:list")
    @Operation(summary = "Get Brand List")
    @GetMapping("/list")
    public TableDataInfo list(Brand brand)
    {
        startPage();
        List<Brand> list = brandService.selectBrandList(brand);
        return getDataTable(list);
    }

    @RequiresPermissions("product:brand:query")
    @Operation(summary = "Get Brand Details")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(brandService.selectBrandById(id));
    }

    @RequiresPermissions("product:brand:add")
    @Operation(summary = "Add New Brand")
    @PostMapping
    public AjaxResult add(@RequestBody @Validated Brand brand) {
        brand.setCreateBy(SecurityUtils.getUsername());
        return toAjax(brandService.insertBrand(brand));
    }

    @RequiresPermissions("product:brand:edit")
    @Operation(summary = "Edit Brand")
    @PutMapping
    public AjaxResult edit(@RequestBody @Validated Brand brand) {
        brand.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(brandService.updateBrand(brand));
    }

    @RequiresPermissions("product:brand:remove")
    @Operation(summary = "Delete Brand")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(brandService.deleteBrandByIds(ids));
    }

    @RequiresPermissions("product:brand:query")
    @Operation(summary = "Get All Brands")
    @GetMapping("getBrandAll")
    public AjaxResult getBrandAll() {
        return success(brandService.selectBrandAll());
    }

    @InnerAuth
    @Operation(summary = "Get all brand in product list")
    @GetMapping("getBrandAllList")
    public R<List<Brand>> getBrandAllList() {
        return R.ok(brandService.selectBrandAll());
    }

}