package com.ruoyi.channel.service.impl;

import com.ruoyi.channel.service.IBrandService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;

import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.api.service.RemoteBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandServiceImpl implements IBrandService {
    @Autowired
    private RemoteBrandService remoteBrandService;

    @Override
    public List<Brand> getBrandAll() {
        R<List<Brand>> brandAllListResult = remoteBrandService.getBrandAllList(SecurityConstants.INNER);

        if(brandAllListResult.getCode() == R.FAIL){
            throw new ServiceException(brandAllListResult.getMsg());
        }

        return brandAllListResult.getData();
    }
}
