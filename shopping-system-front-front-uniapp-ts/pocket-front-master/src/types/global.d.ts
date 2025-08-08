import type { ProductItem } from "./goods"
/** 通用分页结果类型 */
export type PageResult<T> = {
    /** 列表数据 */
    rows: T[]
    /** 总条数 */
    total: number
    /** 当前页数 */
}

/** 通用分页参数类型 */
export type PageParams = {
    /** 页码：默认值为 1 */
    page?: number
    /** 页大小：默认值为 10 */
    pageSize?: number
}

/** 通用商品类型 */
export type GoodsItem = {

    /** 商品已下单数量 */
    orderNum: number
    /** 商品图片 */
    picture: string
    /** 商品价格 */
    price: number

    product: ProductItem
}












