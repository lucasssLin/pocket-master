package com.ruoyi.channel.controller;

import com.ruoyi.channel.service.IBrandService;

import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/brand")
public class BrandController extends BaseController {

    @Autowired
    private IBrandService brandService;

    @Operation(summary = "Get all brand from category")
    @GetMapping("getBrandAll")
    public AjaxResult selectBrandAll() {
        return success(brandService.getBrandAll());
    }
}
