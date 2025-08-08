package com.ruoyi.product.helper;

import com.ruoyi.product.api.domain.vo.CategoryVo;

import java.util.ArrayList;
import java.util.List;

public class CategoryHelper {

    public static List<CategoryVo> createTree(List<CategoryVo> categoryVoList){
        List<CategoryVo> trees = new ArrayList<CategoryVo>();

        for(CategoryVo categoryVo : categoryVoList){
            if(categoryVo.getParentId().longValue() == 0){
                trees.add(findChildren(categoryVo, categoryVoList));
            }
        }
        return trees;
    }

    private static CategoryVo findChildren(CategoryVo categoryVo, List<CategoryVo> categoryVoList) {
        categoryVo.setChildren(new ArrayList<CategoryVo>());

        for(CategoryVo item : categoryVoList){
            if(item.getParentId().longValue() == categoryVo.getId().longValue()){
                if(categoryVo.getChildren()==null){
                    categoryVo.setChildren(new ArrayList<>());
                }
                categoryVo.getChildren().add(findChildren(item, categoryVoList));
            }
        }
        return categoryVo;
    }


}
