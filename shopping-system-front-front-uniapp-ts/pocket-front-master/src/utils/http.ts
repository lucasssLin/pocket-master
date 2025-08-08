
import { useMemberStore } from '@/stores'

// 请求基地址
const baseURL = 'https://pocketapp.mynatapp.cc'

// 拦截器配置
const httpInterceptor = {
    // 拦截前触发
    invoke(options: UniApp.RequestOptions) {
        // 1. 非 http 开头需拼接地址
        if (!options.url.startsWith('http')) {
            options.url = baseURL + options.url
        }
        // 2. 请求超时
        options.timeout = 30000
        // 3. 添加小程序端请求头标识
        options.header = {
            'source-client': 'miniapp',
            ...options.header,
        }
        // 4. 添加 token 请求头标识
        const memberStore = useMemberStore()
        const token = memberStore.profile?.token
        if (token) {
            options.header.Authorization = token
        }
    },
}

// 拦截 request 请求
uni.addInterceptor('request', httpInterceptor)
// 拦截 uploadFile 文件上传
uni.addInterceptor('uploadFile', httpInterceptor)


type Data<T> = {
    code: number
    msg: string
    data: T
}
// 2.2 添加类型，支持泛型
export const http = <T>(options: UniApp.RequestOptions) => {
    // 1. 返回 Promise 对象
    return new Promise<Data<T>>((resolve, reject) => {
        uni.request({
            ...options,
            // 响应成功
            success(res) {
                const responseData = res.data as Data<T>;
                if (responseData && responseData.code === 401) {
                    // 401 error code in response body -> clear user info, redirect to login
                    const memberStore = useMemberStore();
                    memberStore.clearProfile();
                    uni.navigateTo({ url: '/pages/login/login' });
                    reject(res);
                }
                // 状态码 2xx，参考 axios 的设计
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    // 2.1 提取核心数据 res.data
                    resolve(res.data as Data<T>)
                } else if (res.statusCode === 401) {
                    // 401错误  -> 清理用户信息，跳转到登录页
                    const memberStore = useMemberStore()
                    memberStore.clearProfile()
                    uni.navigateTo({ url: '/pages/login/login' })
                    reject(res)
                } else {
                    // 其他错误 -> 根据后端错误信息轻提示
                    uni.showToast({
                        icon: 'none',
                        title: (res.data as Data<T>).msg || '请求错误',
                    })
                    reject(res)
                }
            },
            // 响应失败
            fail(err) {
                uni.showToast({
                    icon: 'none',
                    title: '网络错误，请重试',
                })
                reject(err)
            },
        })
    })
}