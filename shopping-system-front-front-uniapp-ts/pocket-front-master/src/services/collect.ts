import { http } from "@/utils/http"
import type { PageParams } from "@/types/global"
import type { PageResult } from "@/types/global"
import type { CollectedItem } from "@/types/collect"


export const getCollectedListAPI = (query: PageParams) => {
    return http<PageResult<CollectedItem>>({
        method: 'GET',
        url: `/user/userInfo/userCollectList/${query.page}/${query.pageSize}`,

    })
}
