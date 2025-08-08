import { http } from "@/utils/http"
import type { LoginResult } from "@/types/member"

//小程序登录
//param data 请求参数
type LoginParams = {
    code: string
    encryptedData: string
    iv: string
}

export const postLoginWxMinAPI = (data: LoginParams) => {
    return http<LoginResult>({
        method: 'POST',
        url: '/login/wxMin',
        data,
    })
}

//小程序登录_内测版
//param phoneNumber 模拟手机号码
export const postLoginWxMinSimpleAPI = (phoneNumber: string) => {
    return http<LoginResult>({
        method: 'POST',
        url: '/login/wxMin/simple',
        data: {
            phoneNumber,
        },
    })
}

/**
 * Login API - username & password
 */
export const postLoginAPI = (data: {
    username: string
    password: string
}) => {
    return http<LoginResult>({
        method: 'POST',
        url: '/auth/h5/login',
        data,
    })
}

/**
 * Register API
 */
export const postRegisterAPI = (data: {
    username: string
    password: string
    nickName?: string
}) => {
    return http<LoginResult>({
        method: 'POST',
        url: '/auth/h5/register',
        data,
    })
}

/**
 * Send verification code API
 */
export const postSendCodeAPI = (mobile: string) => {
    return http({
        method: 'POST',
        url: '/auth/sendCode',
        data: { mobile },
    })
}

export const LogoutH5API = () => {
    return http({
        method: 'DELETE',
        url: '/auth/h5/logout',
    })
}