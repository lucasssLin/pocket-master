package com.ruoyi.product.domain;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

@Data
public class CategoryExcelVo {

    @ExcelProperty(value = "id" ,index = 0)
    private Long id;

    @ExcelProperty(value = "Category Name" ,index = 1)
    private String name;

    @ExcelProperty(value = "Image url" ,index = 2)
    private String imageUrl ;

    @ExcelProperty(value = "parentId" ,index = 3)
    private Long parentId;

    @ExcelProperty(value = "status" ,index = 4)
    private Integer status;

    @ExcelProperty(value = "order Number" ,index = 5)
    private Long orderNum;

}