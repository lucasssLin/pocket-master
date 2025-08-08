package com.ruoyi.channel.service;

import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.SkuQuery;

public interface IListService {

    TableDataInfo selectProductSkuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery);

    TableDataInfo selectProductSpuList(Integer pageNum, Integer pageSize, SkuQuery skuQuery);
}
