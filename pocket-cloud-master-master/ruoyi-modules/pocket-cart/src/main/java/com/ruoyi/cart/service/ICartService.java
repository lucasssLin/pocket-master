package com.ruoyi.cart.service;

import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.domain.CartInfoVo;

import java.util.List;

public interface ICartService {

    void addToCart(Long skuId, Integer skuNum);

    List<CartInfo> getCartList();

    void deleteCart(Long skuId);

    void checkCart(Long skuId, Integer isChecked);

    void allCheckCart(CartInfoVo cartInfoVo);

    void clearCart();

    List<CartInfo> getCartCheckedList(Long userId);

    Boolean updateCartPrice(Long userId);

    Boolean deleteCartCheckedList(Long userId);

    Boolean updateAllUnchecked(Long userId);

    void updateCartSku(Long skuId, CartInfoVo cartInfoVo);

    void deleteCartItemList(List<Long> skuIdList);
}