package com.ruoyi.live.domain.vo;

import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;


@Data
@Schema(description = "创建直播间请求")
public class LiveRoomCreateVO {
    
    @NotBlank(message = "直播间标题不能为空")
    @Size(max = 100, message = "直播间标题长度不能超过100个字符")
    @Schema(description = "直播间标题", required = true)
    private String title;
    
    @Size(max = 500, message = "直播间描述长度不能超过500个字符")
    @Schema(description = "直播间描述")
    private String description;
    
    @Schema(description = "关联商品ID（可选，用于商品直播）")
    private Long productId;
    
    @Schema(description = "直播间封面图")
    private String coverImage;
    
    @Schema(description = "是否支持回放（0-不支持，1-支持）", defaultValue = "1")
    private Integer replayEnabled = 1;
} 