import { http } from "@/utils/http";
import type { CartItem } from "@/types/cart";
/**
 * 加入购物车
 * @param data 请求体参数
 */
export const postMemberCartAPI = (skuId: string, count: number) => {
    return http({
        method: 'POST',
        url: `/cart/addToCart/${skuId}/${count}`,

    })
}

export const getMemberCartAPI = () => {
    return http<CartItem[]>({
        method: 'GET',
        url: '/cart/cartList',
    })
}


/**
 * 删除/清空购物车单品
 * @param data 请求体参数 ids SKUID 集合
 */
export const deleteMemberCartAPI = (data: { ids: string[] }) => {
    return http({
        method: 'DELETE',
        url: '/cart/deleteCartItemList',
        data,
    })
}

/**
 * 修改购物车单品
 * @param skuId SKUID
 * @param data selected 选中状态 count 商品数量
 */
export const putMemberCartBySkuIdAPI = (
    skuId: string,
    data: { isChecked?: boolean, count?: number },
) => {
    return http({
        method: 'PUT',
        url: `/cart/updateCartSku/${skuId}`,
        data,
    })
}

/**
 * 购物车全选/取消全选
 * @param data selected 是否选中
 */
export const putMemberCartSelectedAPI = (data: { isChecked: boolean }) => {
    return http({
        method: 'PUT',
        url: '/cart/allCheckCart',
        data,
    })
}