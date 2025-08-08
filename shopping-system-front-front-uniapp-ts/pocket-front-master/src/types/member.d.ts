/** 小程序登录 登录用户信息 */
export type LoginResult = {
    /** 用户ID */
    id: number
    /** 头像  */
    avatar: string
    /** 账户名  */
    account: string
    /** 昵称 */
    nickName?: string
    /** 手机号 */
    phone: string
    /** 登录凭证 */
    token: string
}


export type ProfileDetail = {
    /** User ID */
    id: number
    /** Username */
    username: string
    /** Nickname */
    nickName: string
    /** Avatar image */
    avatar: string
    /** Mobile phone */
    phone: string
    /** Gender (0-Unknown, 1-Male, 2-Female) */
    gender: 0 | 1 | 2;
    /** Birthday */
    birthday: string
    /** Location info */
    fullLocation?: string

    countyCode?: string
    profession?: string
    cityCode?: string
    /** Province code */
    provinceCode?: string
    /** County code */
    countyCode?: string
    /** Account status */
    status?: number
    /** Last login IP */
    lastLoginIp?: string
    /** Last login time */
    lastLoginTime?: string
}

/**
 * Login API response
 */
export type LoginResult = ProfileDetail

/**
 * Register API request
 */
export type RegisterParams = {
    /** Username/Phone */
    username: string
    /** Password */
    password: string
    /** Verification code */
    code: string
    /** Nickname (optional) */
    nickName?: string
}

export type UpdateUserInfoParams = {
    /** 用户昵称 */
    nickName: string
    /** 用户性别 */
    gender: 0 | 1 | 2
    /** 用户生日 */
    birthday: string
    /** 用户职业 */
    profession: string
    /** 省份编码 */
    provinceCode: string
    /** 城市编码 */
    cityCode: string
    /** 区县编码 */
    countyCode: string
    fullLocation: string
}