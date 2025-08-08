import type { BannerItem, CategoryItem, HotItem, GuessItem } from '@/types/home'
import { http } from '@/utils/http'
import type { PageParams, PageResult } from '@/types/global'

//首页广告区域接口
export const getHomeBannerAPI = (distributionSite = 1) => {
    return http<BannerItem[]>({
        method: 'GET',
        url: '/channel/index/banner',
        data: {
            distributionSite,
        },
    })
}

//首页-前台分类-小程序
export const getHomeCategoryAPI = () => {
    return http<CategoryItem[]>({
        method: 'GET',
        url: '/channel/index/category',
    })
}

// 首页-热门推荐-小程序
export const getHomeHotAPI = () => {
    return http<HotItem[]>({
        method: 'GET',
        url: '/channel/index/recommendType',
    })
}


//猜你喜欢-小程序
export const getHomeCustomerRecAPI = (data?: PageParams) => {
    return http<PageResult<GuessItem>>({
        method: 'GET',
        url: `/channel/list/spuList/${data?.page}/${data?.pageSize}`,

    })
}