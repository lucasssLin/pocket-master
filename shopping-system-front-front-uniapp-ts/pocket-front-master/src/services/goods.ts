import { http } from "@/utils/http"
import type { GoodsData, RelevantVo } from "@/types/goods"

//@param id 商品id

export const getGoodsByIdAPI = (id: string) => {
    return http<GoodsData>({
        method: 'GET',
        url: `/channel/item/goods/${id}`,

    })
}

export const getRelevantGoodsByIdAPI = (spuId: string, limit: number) => {
    return http<RelevantVo[]>({
        method: 'GET',
        url: `/channel/item/goods/relevantGoods/${spuId}/${limit}`,

    })
}

export const getIsCollectedAPI = (spuId: string) => {
    return http<boolean>({
        method: 'GET',
        url: `/user/userInfo/isCollect/${spuId}`,

    })
}

export const collectProductAPI = (spuId: string) => {
    return http<boolean>({
        method: 'GET',
        url: `/user/userInfo/collect/${spuId}`,

    })
}

export const cancelCollectProductAPI = (spuId: string) => {
    return http<boolean>({
        method: 'GET',
        url: `/user/userInfo/cancelCollect/${spuId}`,

    })
}