package com.ruoyi.product.api.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class BannerItem {
    @TableId
    private String id;
    @TableField("img_url")
    private String imgUrl;
    @TableField("href_url")
    private String hrefUrl;

    private Integer type;
}
