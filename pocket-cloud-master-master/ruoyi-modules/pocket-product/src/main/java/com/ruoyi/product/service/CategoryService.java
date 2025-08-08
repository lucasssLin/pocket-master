package com.ruoyi.product.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.ruoyi.product.domain.Category;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface CategoryService extends IService<Category> {

    List<Category> treeSelect(Long parentId);

    List<Long> selectCategoryIdList(Long categoryId);

    List<CategoryVo> getOneCategory();

    void exportData(HttpServletResponse response);

    void importData(MultipartFile multipartFile) throws IOException;

    List<CategoryVo> selectTree();
}
