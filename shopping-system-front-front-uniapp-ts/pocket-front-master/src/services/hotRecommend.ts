import type { PageParams } from "@/types/global";
import { http } from "@/utils/http";
import type { HotResult } from "@/types/hotRec";

type HotParams = PageParams & { subType?: string }
export const getHotRecommendAPI = (url: string, data?: HotParams) => {
    return http<HotResult>({
        method: 'GET',
        url,
        data,
    })
}