package com.ruoyi.product.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.domain.vo.CategoryVo;
import com.ruoyi.product.api.service.RemoteCategoryService;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;
import org.slf4j.Logger;

import java.util.List;

@Component
public class RemoteCategoryFallbackFactory implements FallbackFactory<RemoteCategoryService> {

    private static final Logger log = LoggerFactory.getLogger(RemoteCategoryFallbackFactory.class);

    @Override
    public RemoteCategoryService create(Throwable throwable) {
        log.error("Product service invocation failed:{}", throwable.getMessage());
        return new RemoteCategoryService() {

            @Override
            public R<List<CategoryVo>> getOneCategory(String source) {
                return R.fail("Get first class category fail:" + throwable.getMessage());
            }

            @Override
            public R<List<CategoryVo>> tree(String source) {
                return R.fail("Get all category fail:" + throwable.getMessage());
            }
        };
    }


}
