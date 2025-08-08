package com.ruoyi.user.api.domain;

// 用户行为实体类

import com.ruoyi.common.core.web.domain.BaseEntity;
import lombok.Data;

@Data

public class UserBehavior extends BaseEntity {
    private static final long serialVersionUID = 1L;

    private Long userId;
    

    private Long itemId;

    private BehaviorType behaviorType;

    private Double score;

}



