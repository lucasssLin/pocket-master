package com.ruoyi.channel.controller;

import com.ruoyi.channel.service.IItemService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.security.annotation.RequiresLogin;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "Product detail API Management")
@RestController
@RequestMapping("/item")
public class ItemController extends BaseController {

    @Autowired
    private IItemService itemService;

    @Operation(summary = "商品详情")
    @GetMapping("/{skuId}")
    public AjaxResult item(@PathVariable Long skuId) {

        return success(itemService.item(skuId));
    }

    @Operation(summary = "商品详情")
    @GetMapping("/goods/{spuId}")
    public AjaxResult selectGoodsBySpuId(@PathVariable Long spuId) {

        return success(itemService.selectGoodsBySpuId(spuId));
    }

    @Operation(summary = "商品详情")
    @GetMapping("/goods/relevantGoods/{spuId}/{limit}")
    public AjaxResult selectRelevantGoodsBySpuId(@PathVariable(value = "spuId") Long spuId, @PathVariable(value = "limit") int limit) {

        return success(itemService.selectRelevantGoodsBySpuId(spuId, limit));
    }


}
