package com.ruoyi.product.api.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RecommendType {
    /** 说明 */
    private String alt;
    /** id */
    private String id;
    /** 图片集合[ 图片路径 ] */
    private String pictures;
    /** 跳转地址 */
    private String target;
    /** 标题 */
    private String title;
    /** 推荐类型 */
    private String type;
}