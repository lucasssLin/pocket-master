package com.ruoyi.channel.controller;

import com.ruoyi.channel.service.ICategoryService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/category")
public class CategoryController extends BaseController {


    @Autowired
    private ICategoryService categoryService;

    @GetMapping(value = "/tree")
    public AjaxResult tree() {
        return success(categoryService.tree());
    }
}
