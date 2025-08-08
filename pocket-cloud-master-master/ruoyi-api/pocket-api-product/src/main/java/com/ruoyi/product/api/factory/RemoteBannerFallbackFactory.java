package com.ruoyi.product.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.domain.BannerItem;
import com.ruoyi.product.api.domain.Brand;
import com.ruoyi.product.api.service.RemoteBannerService;
import com.ruoyi.product.api.service.RemoteBrandService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RemoteBannerFallbackFactory implements FallbackFactory<RemoteBannerService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteBannerFallbackFactory.class);
    @Override
    public RemoteBannerService create(Throwable throwable) {
        log.error("商品服务调用失败:{}", throwable.getMessage());
        return new RemoteBannerService() {
            @Override
            public R<List<BannerItem>> bannerList(String source) {
                return R.fail("获取banner失败:" + throwable.getMessage());
            }
        };
    }
}
