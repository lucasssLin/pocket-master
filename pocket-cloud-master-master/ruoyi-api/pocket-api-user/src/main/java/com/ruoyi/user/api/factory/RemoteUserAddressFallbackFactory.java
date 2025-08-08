package com.ruoyi.user.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.user.api.domain.UserAddress;
import com.ruoyi.user.api.service.RemoteUserAddressService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RemoteUserAddressFallbackFactory implements FallbackFactory<RemoteUserAddressService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteUserAddressFallbackFactory.class);

    @Override
    public RemoteUserAddressService create(Throwable throwable) {
        log.error("User service failed:{}", throwable.getMessage());
        return new RemoteUserAddressService() {

            @Override
            public R<UserAddress> getUserAddress(Long id, String source) {
                return R.fail("Get user address failed:" + throwable.getMessage());
            }

            @Override
            public R<List<UserAddress>> userAddressList(String source) {
                return R.fail("Get user address failed:" + throwable.getMessage());
            }
        };
    }
}