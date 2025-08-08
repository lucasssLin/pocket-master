package com.ruoyi.channel.service.impl;

import com.ruoyi.channel.service.ICategoryService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.service.RemoteCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryServiceImpl implements ICategoryService {
    @Autowired
    private RemoteCategoryService remoteCategoryService;

    @Override
    public List<CategoryVo> tree() {

        R<List<CategoryVo>> categoryVoListResult = remoteCategoryService.tree(SecurityConstants.INNER);
        if(categoryVoListResult.getCode() == R.FAIL){
            throw new ServiceException(categoryVoListResult.getMsg());
        }

        return categoryVoListResult.getData();
    }
}
