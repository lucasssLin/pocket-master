package com.ruoyi.user.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.user.api.domain.UpdateUserLogin;
import com.ruoyi.user.api.domain.UserBehavior;
import com.ruoyi.user.api.domain.UserInfo;
import com.ruoyi.user.api.service.RemoteUserInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
public class RemoteUserInfoFallbackFactory implements FallbackFactory<RemoteUserInfoService>
{
    private static final Logger log = LoggerFactory.getLogger(RemoteUserInfoFallbackFactory.class);

    @Override
    public RemoteUserInfoService create(Throwable throwable)
    {
        log.error("User service invocation failed:{}", throwable.getMessage());
        return new RemoteUserInfoService()
        {

            @Override
            public R<Boolean> register(UserInfo userInfo, String source) {
                return R.fail("User register failed:" + throwable.getMessage());
            }

            @Override
            public R<UserInfo> getUserInfo(String username, String source) {
                return R.fail("Get userInfo by username failed:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> updateUserLogin(UpdateUserLogin updateUserLogin, String source) {
                return R.fail("Update userInfo login failed:" + throwable.getMessage());
            }

            @Override
            public R<List<UserBehavior>> selectUserBehavior(LocalDateTime startTime, String source) {
                return R.fail("Get userInfo behavior failed:" + throwable.getMessage());
            }

            @Override
            public R<List<UserBehavior>> selectUserBehaviorByUserId(Long userId, String source) {
                return R.fail("Get userInfo behavior by userId failed:" + throwable.getMessage());
            }

//            @Override
//            public R<Boolean> isCollect(Long spuId, String source) {
//                return R.fail("Get user collect info by username failed:" + throwable.getMessage());
//            }

        };

    }

}