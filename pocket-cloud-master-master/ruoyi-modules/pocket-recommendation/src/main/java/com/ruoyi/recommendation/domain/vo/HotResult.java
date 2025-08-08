package com.ruoyi.recommendation.domain.vo;

import lombok.Data;

import java.util.List;

@Data
public class HotResult {
    /** id信息 */
    private String id;
    /** 活动图片 */
    private String bannerPicture;
    /** 活动标题 */
    private String title;
    /** 子类选项 */
    private List<SubTypeItem> subTypes;
}