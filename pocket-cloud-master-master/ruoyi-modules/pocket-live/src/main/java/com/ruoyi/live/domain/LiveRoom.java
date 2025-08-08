package com.ruoyi.live.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;


@Data
@EqualsAndHashCode(callSuper = true)
@TableName("live_room")
public class LiveRoom extends BaseEntity {
    
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Excel(name = "直播间ID")
    @TableField("room_id")
    private String roomId;
    

    @Excel(name = "直播间标题")
    @TableField("title")
    private String title;


    @Excel(name = "直播间描述")
    @TableField("description")
    private String description;
    

    @Excel(name = "主播用户ID")
    @TableField("streamer_id")
    private Long streamerId;
    

    @Excel(name = "主播用户名")
    @TableField("streamer_name")
    private String streamerName;
    

    @Excel(name = "关联商品ID")
    @TableField("product_id")
    private Long productId;

    @Excel(name = "直播间状态", readConverterExp = "0=未开始,1=直播中,2=已结束,3=已暂停")
    @TableField("status")
    private Integer status;
    

    @Excel(name = "当前观看人数")
    @TableField("viewer_count")
    private Integer viewerCount;

    @Excel(name = "总观看人数")
    @TableField("total_viewers")
    private Integer totalViewers;
    

    @Excel(name = "点赞数")
    @TableField("like_count")
    private Integer likeCount;
    

    @Excel(name = "直播开始时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    @TableField("start_time")
    private LocalDateTime startTime;
    

    @Excel(name = "直播结束时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    @TableField("end_time")
    private LocalDateTime endTime;
    

    @Excel(name = "封面图")
    @TableField("cover_image")
    private String coverImage;
    

    @Excel(name = "是否支持回放", readConverterExp = "0=不支持,1=支持")
    @TableField("replay_enabled")
    private Integer replayEnabled;
    

    @Excel(name = "回放视频URL")
    @TableField("replay_url")
    private String replayUrl;
    

    @TableLogic
    @TableField("del_flag")
    private String delFlag;
} 