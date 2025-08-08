package com.ruoyi.live.domain.vo;

import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;


@Data
@Schema(description = "直播间信息")
public class LiveRoomVO {
    
    @Schema(description = "直播间ID")
    private String roomId;
    
    @Schema(description = "直播间标题")
    private String title;
    
    @Schema(description = "直播间描述")
    private String description;
    
    @Schema(description = "主播用户ID")
    private Long streamerId;
    
    @Schema(description = "主播用户名")
    private String streamerName;
    
    @Schema(description = "关联商品ID")
    private Long productId;
    
    @Schema(description = "商品名称")
    private String productName;
    
    @Schema(description = "直播间状态（0-未开始，1-直播中，2-已结束，3-已暂停）")
    private Integer status;
    
    @Schema(description = "当前观看人数")
    private Integer viewerCount;
    
    @Schema(description = "总观看人数")
    private Integer totalViewers;
    
    @Schema(description = "点赞数")
    private Integer likeCount;
    
    @Schema(description = "直播开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;
    
    @Schema(description = "直播结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;
    
    @Schema(description = "直播间封面图")
    private String coverImage;
    
    @Schema(description = "是否支持回放")
    private Integer replayEnabled;
    
    @Schema(description = "回放视频URL")
    private String replayUrl;
    
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    
    @Schema(description = "直播间状态描述")
    public String getStatusText() {
        switch (status) {
            case 0: return "未开始";
            case 1: return "直播中";
            case 2: return "已结束";
            case 3: return "已暂停";
            default: return "未知状态";
        }
    }
} 