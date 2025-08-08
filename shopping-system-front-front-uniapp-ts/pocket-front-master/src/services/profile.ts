import type { ProfileDetail } from '@/types/member'
import { http } from '@/utils/http'
import type { UpdateUserInfoParams } from '@/types/member'
/**
 * 获取个人信息
 */
export const getMemberProfileAPI = () => {
    return http<ProfileDetail>({
        method: 'GET',
        url: '/user/userInfo/getLoginUserInfo',
    })
}

//修改个人信息
// @param data 请求体参数
export const putMemberProfileAPI = (data: UpdateUserInfoParams) => {
    return http<ProfileDetail>({
        method: 'PUT',
        url: '/user/userInfo/updateLoginUserInfo',
        data,
    })
}