package com.ruoyi.cart.controller;


import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.domain.CartInfoVo;
import com.ruoyi.cart.service.ICartService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresLogin;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Cart Interface")
@RestController
@RequestMapping
public class CartController extends BaseController {

    @Autowired
    private ICartService cartService;


    @Operation(summary = "Add to cart")
    @RequiresLogin
    @PostMapping("addToCart/{skuId}/{skuNum}")
    public AjaxResult addToCart(@Parameter(name = "skuId", description = "商品skuId", required = true) @PathVariable("skuId") Long skuId,
                                @Parameter(name = "skuNum", description = "数量", required = true) @PathVariable("skuNum") Integer skuNum) {
        cartService.addToCart(skuId, skuNum);
        return success();
    }

    @Operation(summary = "Inquiry cart list")
    @RequiresLogin
    @GetMapping("cartList")
    public AjaxResult cartList() {
        return success(cartService.getCartList());
    }

    @Operation(summary = "Delete cart items")
    @RequiresLogin
    @DeleteMapping("deleteCart/{skuId}")
    public AjaxResult deleteCart(@Parameter(name = "skuId", description = "product skuId", required = true) @PathVariable("skuId") Long skuId) {
        cartService.deleteCart(skuId);
        return success();
    }

    @Operation(summary="Update cart isChecked")
    @RequiresLogin
    @GetMapping("checkCart/{skuId}/{isChecked}")
    public AjaxResult checkCart(@Parameter(name = "skuId", description = "Product skuId", required = true) @PathVariable(value = "skuId") Long skuId,
                                @Parameter(name = "isChecked", description = "1:isChecked 0:unChecked", required = true) @PathVariable(value = "isChecked") Integer isChecked) {
        cartService.checkCart(skuId, isChecked);
        return success();
    }

    @Operation(summary="Update cart all products isChecked")
    @RequiresLogin
    @PutMapping("allCheckCart")
    public AjaxResult allCheckCart(@RequestBody CartInfoVo cartInfoVo){
        cartService.allCheckCart(cartInfoVo);
        return success();
    }

    @Operation(summary="clear cart")
    @RequiresLogin
    @GetMapping("clearCart")
    public AjaxResult clearCart(){
        cartService.clearCart();
        return success();
    }

    @Operation(summary="query cart selected list")
    @InnerAuth
    @GetMapping("/getCartCheckedList/{userId}")
    public R<List<CartInfo>> getCartCheckedList(@Parameter(name = "userId", required = true) @PathVariable Long userId){
        return R.ok(cartService.getCartCheckedList(userId));
    }

    @Operation(summary="update cart price")
    @InnerAuth
    @GetMapping("/updateCartPrice/{userId}")
    public R<Boolean> updateCartPrice(@PathVariable("userId") Long userId){
        return R.ok(cartService.updateCartPrice(userId));
    }

    @Operation(summary="Remove selected list from cart")
    @InnerAuth
    @GetMapping("/deleteCartCheckedList/{userId}")
    public R<Boolean> deleteCartCheckedList(@PathVariable("userId") Long userId){
        return R.ok(cartService.deleteCartCheckedList(userId));
    }

    @Operation(summary="直接购买同时更新购物车的选中状态")
    @InnerAuth
    @PutMapping("/updateAllUnchecked/{userId}")
    public R<Boolean> updateAllUnchecked(@PathVariable("userId") Long userId){
        return R.ok(cartService.updateAllUnchecked(userId));
    }

    @Operation(summary="Update cart sku count or selected")
    @RequiresLogin
    @PutMapping("updateCartSku/{skuId}")
    public AjaxResult updateCartSku(@Parameter(name = "skuId", description = "Product skuId", required = true) @PathVariable(value = "skuId") Long skuId,
                                    @RequestBody CartInfoVo cartInfoVo) {
        cartService.updateCartSku(skuId, cartInfoVo);
        return success();
    }

    @Operation(summary = "Delete cart items")
    @RequiresLogin
    @DeleteMapping("deleteCartItemList")
    public AjaxResult deleteCartItemList(@RequestBody CartInfoVo cartInfoVo) {
        cartService.deleteCartItemList(cartInfoVo.getIds());
        return success();
    }
}