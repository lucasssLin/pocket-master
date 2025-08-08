package com.ruoyi.user.api.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class UpdateUserLogin
{

    private Long userId;

    private String lastLoginIp;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date lastLoginTime;


}