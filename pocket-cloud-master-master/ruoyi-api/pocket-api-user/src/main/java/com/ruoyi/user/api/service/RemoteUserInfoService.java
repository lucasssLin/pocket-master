package com.ruoyi.user.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.user.api.domain.UpdateUserLogin;
import com.ruoyi.user.api.domain.UserBehavior;
import com.ruoyi.user.api.domain.UserInfo;
import com.ruoyi.user.api.factory.RemoteUserInfoFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@FeignClient(contextId = "remoteUserInfoService", value = ServiceNameConstants.USER_SERVICE, fallbackFactory = RemoteUserInfoFallbackFactory.class)
public interface RemoteUserInfoService {

    @PostMapping("/userInfo/register")
    public R<Boolean> register(@RequestBody UserInfo userInfo, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);


    @GetMapping("/userInfo/info/{username}")
    public R<UserInfo> getUserInfo(@PathVariable("username") String username, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PutMapping("/userInfo/updateUserLogin")
    public R<Boolean> updateUserLogin(@RequestBody UpdateUserLogin updateUserLogin, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @PostMapping("/userInfo/selectUserBehavior")
    public R<List<UserBehavior>> selectUserBehavior(@RequestBody LocalDateTime startTime, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping("/userInfo/selectUserBehaviorByUserId/{userId}")
    R<List<UserBehavior>> selectUserBehaviorByUserId(@PathVariable("userId") Long userId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

//    @GetMapping("/userInfo/isCollect/{spuId}")
//    public R<Boolean> isCollect(@PathVariable("spuId")Long spuId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}