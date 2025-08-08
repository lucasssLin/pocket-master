package com.ruoyi.user.api.domain;

import lombok.Data;

@Data
public class UserInfoLoginVo extends UserInfo{
    private String token;
}
