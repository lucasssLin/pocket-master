/** 购物车类型 */
export type CartItem = {
    /** 商品 ID */
    id: string
    /** SKU ID */
    skuId: string
    /** 商品名称 */
    skuName: string
    /** 图片 */
    thumbImg: string
    /** 数量 */
    count: number

    spuId: string

    /** 当前的价格 */
    skuPrice: number
    /** 库存 */
    stock: number
    /** 是否选中 */
    isChecked: boolean
    /** 属性文字 */
    attrsText: string
    /** 是否为有效商品 */
    isEffective: boolean
}