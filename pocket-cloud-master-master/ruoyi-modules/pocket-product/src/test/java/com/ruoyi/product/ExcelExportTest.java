package com.ruoyi.product;

import com.alibaba.excel.EasyExcel;
import com.ruoyi.product.domain.CategoryExcelVo;
import com.ruoyi.product.service.CategoryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.util.List;

import java.util.stream.Collectors;

@SpringBootTest
public class ExcelExportTest {

    @Autowired
    private CategoryService categoryService;

    @Test
    public void writeDataToExcel() {
        List<CategoryExcelVo> list = categoryService.list().stream().map(category -> {
            CategoryExcelVo categoryExcelVo = new CategoryExcelVo();
            BeanUtils.copyProperties(category, categoryExcelVo);
            return categoryExcelVo;
        }).collect(Collectors.toList());

        String userHome = System.getProperty("user.home");

        EasyExcel.write(userHome + File.separator + "Desktop" + File.separator + "CategoryData-Export.xlsx" , CategoryExcelVo.class).sheet("CategoryData").doWrite(list);
    }
}
