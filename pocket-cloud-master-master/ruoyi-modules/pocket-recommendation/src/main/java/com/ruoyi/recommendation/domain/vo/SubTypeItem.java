package com.ruoyi.recommendation.domain.vo;

import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.Product;
import lombok.Data;

@Data
public class SubTypeItem {
    /** 子类id */
    private String id;
    /** 子类标题 */
    private String title;
    /** 子类对应的商品集合 */
    private TableDataInfo goodsItems;
}