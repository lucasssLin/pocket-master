
import { http } from "@/utils/http"
import type { PageParams } from "@/types/global"
import type { PageResult } from "@/types/global"
import type { BrowseHistoryItem } from '@/types/browseHistory';
export const getHistoryListAPI = (query: PageParams) => {
    return http<PageResult<BrowseHistoryItem>>({
        method: 'GET',
        url: `/user/userInfo/userBrowseHistoryList/${query.page}/${query.pageSize}`,

    })
}


export const deleteHistoryProductAPI = (id: number) => {
    return http({
        method: 'DELETE',
        url: `/user/userInfo/DeleteUserBrowseHistory/${id}`,

    })
}