package com.ruoyi.channel.service.impl;

import com.ruoyi.channel.service.IListService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.service.RemoteProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class ListServiceImpl implements IListService {

    @Autowired
    private RemoteProductService remoteProductService;

    @Override
    public TableDataInfo selectProductSkuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery) {
        R<TableDataInfo> tableDataInfoResult = remoteProductService.skuList(pageNum, pageSize, skuQuery, SecurityConstants.INNER);
        if (R.FAIL == tableDataInfoResult.getCode()) {
            throw new ServiceException(tableDataInfoResult.getMsg());
        }
        return tableDataInfoResult.getData();
    }

    @Override
    public TableDataInfo selectProductSpuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery) {
        R<TableDataInfo> tableDataInfoResult = remoteProductService.spuList(pageNum, pageSize, skuQuery, SecurityConstants.INNER);
        if (R.FAIL == tableDataInfoResult.getCode()) {
            throw new ServiceException(tableDataInfoResult.getMsg());
        }
        return tableDataInfoResult.getData();
    }
}
