package com.ruoyi.cart.api.factory;

import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.service.RemoteCartService;
import com.ruoyi.common.core.domain.R;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RemoteCartFallbackFactory implements FallbackFactory<RemoteCartService> {

    private static final Logger log = LoggerFactory.getLogger(RemoteCartFallbackFactory.class);

    @Override
    public RemoteCartService create(Throwable throwable) {
        log.error("Cart service failed:{}", throwable.getMessage());

        return new RemoteCartService() {
            @Override
            public R<List<CartInfo>> getCartCheckedList(Long userId, String source) {
                return R.fail("Get selected cart info failed:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> updateCartPrice(Long userId, String source) {
                return R.fail("Update cart price failed:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> deleteCartCheckedList(Long userId, String source) {
                return R.fail("Remove selected items from cart failed:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> updateAllUnchecked(Long userId, String source) {
                return R.fail("更新购物车状态失败:" + throwable.getMessage());
            }
        };

    }
}
