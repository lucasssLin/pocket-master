package com.ruoyi.cart.api.service;

import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.factory.RemoteCartFallbackFactory;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import com.ruoyi.common.core.constant.ServiceNameConstants;

import java.util.List;

@FeignClient(value = ServiceNameConstants.CART_SERVICE, fallbackFactory = RemoteCartFallbackFactory.class)
public interface RemoteCartService
{

    @GetMapping("/getCartCheckedList/{userId}")
    public R<List<CartInfo>> getCartCheckedList(@PathVariable("userId") Long userId, @RequestHeader(SecurityConstants.FROM_SOURCE)String source);

    @GetMapping("/updateCartPrice/{userId}")
    public R<Boolean> updateCartPrice(@PathVariable("userId") Long userId, @RequestHeader(SecurityConstants.FROM_SOURCE)String source);

    @GetMapping("/deleteCartCheckedList/{userId}")
    public R<Boolean> deleteCartCheckedList(@PathVariable("userId") Long userId, @RequestHeader(SecurityConstants.FROM_SOURCE)String source);

    @PutMapping("/updateAllUnchecked/{userId}")
    public R<Boolean> updateAllUnchecked(@PathVariable("userId") Long userId, @RequestHeader(SecurityConstants.FROM_SOURCE)String source);
}