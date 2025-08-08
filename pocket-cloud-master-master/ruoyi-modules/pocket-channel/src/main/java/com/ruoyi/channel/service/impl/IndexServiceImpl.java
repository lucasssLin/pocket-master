package com.ruoyi.channel.service.impl;


import com.ruoyi.channel.service.IIndexService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.service.RemoteBannerService;
import com.ruoyi.product.api.service.RemoteCategoryService;
import com.ruoyi.product.api.service.RemoteProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class IndexServiceImpl implements IIndexService {
    @Autowired
    private RemoteCategoryService remoteCategoryService;
    @Autowired
    private RemoteProductService remoteProductService;
    @Autowired
    private RemoteBannerService  remoteBannerService;

    @Override
    public Map<String, Object> getIndexData() {

        R<List<ProductSku>> productSkuListResult = remoteProductService.getTopSale(SecurityConstants.INNER);

        if(R.FAIL == productSkuListResult.getCode()){
            throw new ServiceException(productSkuListResult.getMsg());
        }

        R<List<CategoryVo>> categoryListResult = remoteCategoryService.getOneCategory(SecurityConstants.INNER);
        
        if(R.FAIL == categoryListResult.getCode()){
            throw new ServiceException(categoryListResult.getMsg());
        }

        HashMap<String, Object> map = new HashMap<>();

        map.put("categoryList", categoryListResult.getData());
        map.put("productSkuList", productSkuListResult.getData());

        return map;
    }

    @Override
    public List<BannerItem> getBannerList() {
        R<List<BannerItem>> bannerListResult = remoteBannerService.bannerList(SecurityConstants.INNER);

        if(R.FAIL == bannerListResult.getCode()){
            throw new ServiceException(bannerListResult.getMsg());
        }
        return bannerListResult.getData();
    }

    @Override
    public List<CategoryVo> getCategoryList() {
        R<List<CategoryVo>> categoryListResult = remoteCategoryService.getOneCategory(SecurityConstants.INNER);

        if(R.FAIL == categoryListResult.getCode()){
            throw new ServiceException(categoryListResult.getMsg());
        }
        List<CategoryVo> categoryVoList = categoryListResult.getData();
        List<CategoryVo> categoryVoFirstCategoryList = new ArrayList<>();
        for(CategoryVo categoryVo : categoryVoList){
            if (categoryVo.getParentId() == 0){
                categoryVoFirstCategoryList.add(categoryVo);
            }
        }
        return categoryVoFirstCategoryList;
    }
}
