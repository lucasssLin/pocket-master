package com.ruoyi.auth.form;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 用户注册对象
 * 
 * @author ruoyi
 */
public class RegisterBody extends LoginBody
{
    @Schema(description = "nickName")
    private String nickName;

    @Schema(description = "Auth code")
    private String code;

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
