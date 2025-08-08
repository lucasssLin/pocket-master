package com.ruoyi.user.api.service;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.user.api.domain.UserAddress;
import com.ruoyi.user.api.factory.RemoteUserAddressFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteUserAddressService" , value = ServiceNameConstants.USER_SERVICE, fallbackFactory = RemoteUserAddressFallbackFactory.class)
public interface RemoteUserAddressService {

    @GetMapping(value = "/userAddress/getUserAddress/{id}")
    public R<UserAddress> getUserAddress(@PathVariable("id") Long id, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    @GetMapping(value = "/userAddress/userAddressList")
    public R<List<UserAddress>> userAddressList(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}