package com.ruoyi.aiagent.tools;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;

import com.ruoyi.product.api.service.RemoteProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Description;

import java.util.function.Function;

@Configuration
public class ProductTool {
    @Autowired
    private RemoteProductService remoteProductService;

    public record UpdateProductPriceRequest(Long skuId, Double salePrice){}

    @Bean
    @Description("处理根据商品skuId更新商品价格sale_price")
    public Function<ProductTool.UpdateProductPriceRequest,String> updateProductPrice(){
        return updateProductPriceRequest -> {
            R<Integer> updateProductPriceResult = remoteProductService.updateProductPrice(updateProductPriceRequest.skuId, updateProductPriceRequest.salePrice, SecurityConstants.INNER);

            if(R.FAIL == updateProductPriceResult.getCode()){
                throw new ServiceException(updateProductPriceResult.getMsg());
            }
            if(updateProductPriceResult.getData() != 1) {
                throw new ServiceException("更新商品价格失败");
            } else {
                return "更新商品价格成功";
            }
        };

    }


}
