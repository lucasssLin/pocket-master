import { http } from '@/utils/http'

/**
 * 获取微信支付参数
 * @param data orderId 订单id
 */
export const getPayWxPayMiniPayAPI = (data: { orderId: string }) => {
    return http<WechatMiniprogram.RequestPaymentOption>({
        method: 'GET',
        url: '/pay/wxPay/miniPay',
        data,
    })
}

/**
 * 模拟支付-内测版
 * @param data orderId 订单id
 */
export const getPayMockAPI = (orderNo: string) => {
    return http({
        method: 'GET',
        url: `/payment/mockpay/submitMockPay/${orderNo}`,
    })
}
/**
 * 验证模拟支付密码
 * @param orderNo 订单编号
 * @param password 支付密码
 */
export const verifyMockPayment = (orderNo: string, password: string) => {
    return http<{ success: boolean }>({
        method: 'GET',
        url: `/payment/mockpay/verifyPayment/${orderNo}`,
        data: { password }
    })
}


/**
 * 获取支付宝支付参数
 * @param data orderId 订单ID
 */
export const getPayAliPayMiniPayAPI = (orderNo: string) => {
    return http<{ msg: string; code: number }>({
        method: 'GET',
        url: `/payment/alipay/submitAlipay/${orderNo}`,
    })
}

/**
 * 检查订单支付状态
 * @param orderNo 订单编号
 * @returns 支付状态
 */
export const checkOrderPaymentStatus = (orderNo: string) => {
    return http<{
        paid: boolean;
        orderState: number;
    }>({
        method: 'GET',
        url: `/order/checkPayment/${orderNo}`
    })
}

/** 支付宝支付结果类型 */
export type AlipayResult = {
    orderNo: string;
    paySuccess: boolean;
}