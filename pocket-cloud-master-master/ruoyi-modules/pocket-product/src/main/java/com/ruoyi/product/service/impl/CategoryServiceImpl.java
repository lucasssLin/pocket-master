package com.ruoyi.product.service.impl;


import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.domain.Category;
import com.ruoyi.product.domain.CategoryExcelVo;
import com.ruoyi.product.helper.CategoryHelper;
import com.ruoyi.product.listener.CategoryExcelListener;
import com.ruoyi.product.mapper.CategoryMapper;
import com.ruoyi.product.mapper.ProductMapper;
import com.ruoyi.product.service.CategoryService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ProductMapper productMapper;

    //获取分类下拉树列表
    @Override
    public List<Category> treeSelect(Long parentId) {
        List<Category> categorylist = categoryMapper.selectList(new LambdaQueryWrapper<Category>().eq(Category::getParentId, parentId));

        if(!CollectionUtils.isEmpty(categorylist)){
            for(Category category : categorylist){
                Long count = categoryMapper.selectCount(new LambdaQueryWrapper<Category>().eq(Category::getParentId, category.getId()));
                if(count > 0){
                    category.setHasChildren(true);
                }else{
                    category.setHasChildren(false);
                }
            }
        }
        return categorylist;
    }

    //递归获取分类id
    @Override
    public List<Long> selectCategoryIdList(Long categoryId) {

        ArrayList<Long> categoryIdList = new ArrayList<>();

        List<Category> list = new ArrayList<>();

        List<Category> categoryList = getCategoryList(categoryId, list);

        for (int i = categoryList.size(); i > 0 ; i--) {
            categoryIdList.add(categoryList.get(i-1).getId());
        }

        return categoryIdList;
    }
    //递归获取分类id
    private List<Category> getCategoryList(Long categoryId, List<Category> list){

        if(categoryId > 0){
            Category category = categoryMapper.selectOne(new LambdaQueryWrapper<Category>().eq(Category::getId,categoryId));
            list.add(category);
            getCategoryList(category.getParentId(),list);

        }
        return list;
    }

    //导出分类
    @Override
    public void exportData(HttpServletResponse response) {
        try {
            // 设置响应结果类型
            response.setContentType("application/vnd.ms-excel");
            response.setCharacterEncoding("utf-8");

            // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
            String fileName = URLEncoder.encode("CategoryData","utf-8");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
            response.setHeader("Access-Control-Expose-Headers", "Content-Disposition");

            // 查询数据库中的数据
            List<Category> categoryList = categoryMapper.selectList(null);

            ArrayList<CategoryExcelVo> categoryExcelVoList = new ArrayList<>(categoryList.size());

            for(Category category : categoryList){
                CategoryExcelVo categoryExcelVo = new CategoryExcelVo();
                BeanUtils.copyProperties(category, categoryExcelVo);
                categoryExcelVoList.add(categoryExcelVo);
            }
            EasyExcel.write(response.getOutputStream(), CategoryExcelVo.class).sheet("CategoryData").doWrite(categoryExcelVoList);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    //导入数据
    @Override
    public void importData(MultipartFile multipartFile) throws IOException {

        EasyExcel.read(multipartFile.getInputStream(), CategoryExcelVo.class, new CategoryExcelListener(categoryMapper)).sheet("CategoryData").doRead();
    }



    //通过parentId=0获取category一级分类集合再封装成categoryVo集合
    @Override
    public List<CategoryVo> getOneCategory() {
        List<Category> categoryList = categoryMapper.selectList(new LambdaQueryWrapper<Category>().eq(Category::getParentId,0));

        List<CategoryVo> list = categoryList.stream().map(category -> {
            CategoryVo categoryVo = new CategoryVo();
            BeanUtils.copyProperties(category, categoryVo);
            return categoryVo;
        }).collect(Collectors.toList());
        return list;
    }

    //首页加载所有树形分类数据
    @Override
    public List<CategoryVo> selectTree() {

        List<Category> categoryList = categoryMapper.selectList(null);

        List<CategoryVo> categoryVoList = categoryList.stream().map(category -> {
            CategoryVo categoryVo = new CategoryVo();
            BeanUtils.copyProperties(category, categoryVo);
            return categoryVo;
        }).collect(Collectors.toList());

        for(CategoryVo categoryVo : categoryVoList){
            if(categoryVo.getParentId() != 0){
                SkuQuery skuQuery = new SkuQuery();
                skuQuery.setCategory2Id(categoryVo.getId());
                List<ProductVo> productVoList = productMapper.selectSpuList(skuQuery);
                categoryVo.setProductVoList(productVoList);
            }
        }
        return CategoryHelper.createTree(categoryVoList);
    }

}
