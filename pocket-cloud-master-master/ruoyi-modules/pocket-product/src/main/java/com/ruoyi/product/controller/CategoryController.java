package com.ruoyi.product.controller;


import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.product.domain.Category;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.service.CategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Tag(name = "Category API Management")
@RestController
@RequestMapping("/category")
public class CategoryController extends BaseController {

    @Autowired
    private CategoryService categoryService;

    @Operation(summary = "Gets a list of category drop-down trees")
    @GetMapping("/{id}")
    public AjaxResult treeSelect(@PathVariable Long id){
        List<Category> list = categoryService.treeSelect(id);
        return success(list);
    }

    @Operation(summary = "Export Data")
    @PostMapping("/export")
    public void exportData(HttpServletResponse response){
        categoryService.exportData(response);
    }

    @Operation(summary = "Import Data")
    @PostMapping("/import")
    public AjaxResult importData(@RequestParam("file") MultipartFile multipartFile){
        try {
            categoryService.importData(multipartFile);
            return AjaxResult.success("Import Success");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return AjaxResult.error("Import Fail");
    }


    //获取category一级分类集合再封装成categoryVo集合
    @Operation(summary = "Get CategoryVo")
    @InnerAuth
    @GetMapping("/getOneCategory")
    public R<List<CategoryVo>> getOneCategory(){
        List<CategoryVo> categoryVoList = categoryService.getOneCategory();
        return R.ok(categoryVoList);
    }

    @Operation(summary = "three class category data loaded as tree")
    @InnerAuth
    @GetMapping("/tree")
    public AjaxResult selectTree(){
        List<CategoryVo> categoryVoTreeList = categoryService.selectTree();
        return success(categoryVoTreeList);
    }

}
