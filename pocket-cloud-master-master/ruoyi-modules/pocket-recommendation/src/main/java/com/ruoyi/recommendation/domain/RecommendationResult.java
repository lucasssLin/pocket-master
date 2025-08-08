package com.ruoyi.recommendation.domain;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data

public class RecommendationResult {

    /** id */
    @TableId(type = IdType.AUTO)
    private Long id;



    private Long userId;
    

    private Long itemId;
    

    private Double score;
    

    private String algorithmType = "ITEM_CF";
    

    private LocalDateTime createdTime;
    

    private LocalDateTime updatedTime;
}