package com.ruoyi.user.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;


@Data
@Schema(description = "User vo")
public class UserInfoVo {

    @Schema(description = "nickName")
    private String nickName;

    @Schema(description = "avatar")
    private String avatar;

}