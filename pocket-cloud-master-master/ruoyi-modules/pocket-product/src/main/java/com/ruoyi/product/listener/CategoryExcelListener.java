package com.ruoyi.product.listener;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.ruoyi.common.core.utils.bean.BeanUtils;
import com.ruoyi.product.domain.Category;
import com.ruoyi.product.domain.CategoryExcelVo;
import com.ruoyi.product.mapper.CategoryMapper;
import org.apache.poi.ss.formula.functions.T;

import java.util.ArrayList;
import java.util.List;

public class CategoryExcelListener extends AnalysisEventListener<CategoryExcelVo> {

    //此处不能使用注入，因为CategoryExcelListener不是spring管理的bean，所以无法注入
    CategoryMapper categoryMapper;

    public CategoryMapper getCategoryMapper(){
        return categoryMapper;
    }

    public void setCategoryMapper(CategoryMapper categoryMapper){
        this.categoryMapper = categoryMapper;
    }

    public CategoryExcelListener(CategoryMapper categoryMapper){
        this.categoryMapper = categoryMapper;
    }

    // 共享资源，不能被多线程访问
    List<CategoryExcelVo> list = new ArrayList<CategoryExcelVo>();


    @Override
    public void invoke(CategoryExcelVo categoryExcelVo, AnalysisContext analysisContext) {
        list.add(categoryExcelVo);

        if(list.size()%100==0){
            System.out.println("Import data in batches："+categoryExcelVo.getName());
            System.out.println(list.size());

            for (CategoryExcelVo excelVo : list){
                Category category = new Category();
                BeanUtils.copyProperties(excelVo, category);
                categoryMapper.insert(category);
            }
            list.clear();
        }

    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {

        System.out.println("final method，handle the rest data");
        System.out.println(list);

        for(CategoryExcelVo excelVo : list){
            Category category = new Category();
            BeanUtils.copyProperties(excelVo, category);
            categoryMapper.insert(category);
        }
        list.clear();
    }
}
