import { getPayAliPayMiniPayAPI, checkOrderPaymentStatus } from '@/services/payment'
import { ref } from 'vue'

// 支付状态枚举
export enum PaymentStatus {
    PENDING = 0,     // 待支付
    SUCCESS = 1,     // 支付成功
    FAILED = -1,     // 支付失败
    PROCESSING = 2   // 处理中
}

// 支付结果接口
export interface PaymentResult {
    status: PaymentStatus;
    message: string;
}

/**
 * 支付宝支付处理类
 */
export const useAlipayPayment = () => {
    // 支付状态
    const paymentStatus = ref<PaymentStatus>(PaymentStatus.PENDING)
    // 加载状态
    const loading = ref(false)
    // 支付结果消息
    const resultMessage = ref('')
    // 轮询定时器ID
    let pollingTimer: number | null = null

    /**
     * 从支付宝响应中提取表单HTML
     * @param responseMsg 响应消息字符串
     * @returns 提取的HTML表单字符串
     */
    const extractFormHtml = (responseMsg: string): string => {
        // 直接返回响应消息，它已经包含完整的表单HTML
        return responseMsg
    }

    /**
     * 发起支付宝支付
     * @param orderNo 订单编号
     * @returns Promise<PaymentResult>
     */
    const pay = async (orderNo: string): Promise<PaymentResult> => {
        if (!orderNo) {
            return {
                status: PaymentStatus.FAILED,
                message: '订单编号不能为空'
            }
        }

        loading.value = true
        paymentStatus.value = PaymentStatus.PENDING

        try {
            // 1. 调用后端接口获取支付表单
            const response = await getPayAliPayMiniPayAPI(orderNo)

            if (!response.data || response.data.code !== 200) {
                loading.value = false
                paymentStatus.value = PaymentStatus.FAILED
                resultMessage.value = '获取支付链接失败'
                return {
                    status: PaymentStatus.FAILED,
                    message: '获取支付链接失败'
                }
            }

            // 2. 提取表单HTML
            const formHtml = extractFormHtml(response.data.msg)

            if (!formHtml) {
                loading.value = false
                paymentStatus.value = PaymentStatus.FAILED
                resultMessage.value = '解析支付表单失败'
                return {
                    status: PaymentStatus.FAILED,
                    message: '解析支付表单失败'
                }
            }

            // 3. 创建一个WebView来加载支付表单
            // 在小程序中使用web-view组件，需要在导航到一个新页面
            uni.navigateTo({
                url: `/pagesOrder/alipayWebView/alipayWebView?orderNo=${orderNo}&formHtml=${encodeURIComponent(formHtml)}`
            })

            // 4. 启动轮询检查支付状态
            paymentStatus.value = PaymentStatus.PROCESSING
            resultMessage.value = '支付处理中，请在支付宝完成支付'

            // 返回处理中状态，实际支付结果将通过轮询更新
            return {
                status: PaymentStatus.PROCESSING,
                message: '支付处理中，请在支付宝完成支付'
            }
        } catch (error) {
            console.error('发起支付宝支付失败:', error)
            loading.value = false
            paymentStatus.value = PaymentStatus.FAILED
            resultMessage.value = '发起支付失败，请重试'

            return {
                status: PaymentStatus.FAILED,
                message: '发起支付失败，请重试'
            }
        }
    }

    /**
     * 开始轮询检查支付状态
     * @param orderNo 订单编号
     * @param callback 状态变化回调
     */
    const startPollingPaymentStatus = (
        orderNo: string,
        callback: (result: PaymentResult) => void
    ) => {
        // 清除之前的定时器
        if (pollingTimer) {
            clearInterval(pollingTimer)
        }

        let attempts = 0
        const maxAttempts = 30 // 最多轮询30次，约5分钟

        // 每10秒检查一次支付状态
        pollingTimer = setInterval(async () => {
            attempts++

            try {
                const result = await checkOrderPaymentStatus(orderNo)

                if (result.data.paid) {
                    // 支付成功
                    clearInterval(pollingTimer as number)
                    loading.value = false
                    paymentStatus.value = PaymentStatus.SUCCESS
                    resultMessage.value = '支付成功'

                    callback({
                        status: PaymentStatus.SUCCESS,
                        message: '支付成功'
                    })
                } else if (attempts >= maxAttempts) {
                    // 超过最大尝试次数，视为支付失败
                    clearInterval(pollingTimer as number)
                    loading.value = false
                    paymentStatus.value = PaymentStatus.FAILED
                    resultMessage.value = '支付超时，请重新支付'

                    callback({
                        status: PaymentStatus.FAILED,
                        message: '支付超时，请重新支付'
                    })
                }
            } catch (error) {
                console.error('检查支付状态失败:', error)
                // 错误不停止轮询，继续尝试
            }
        }, 10000) // 每10秒检查一次
    }

    /**
     * 停止轮询
     */
    const stopPolling = () => {
        if (pollingTimer) {
            clearInterval(pollingTimer)
            pollingTimer = null
        }
    }

    /**
     * 手动触发检查支付状态
     * @param orderNo 订单编号
     */
    const checkPaymentStatus = async (orderNo: string): Promise<PaymentResult> => {
        try {
            const result = await checkOrderPaymentStatus(orderNo)

            if (result.data.paid) {
                loading.value = false
                paymentStatus.value = PaymentStatus.SUCCESS
                resultMessage.value = '支付成功'

                return {
                    status: PaymentStatus.SUCCESS,
                    message: '支付成功'
                }
            } else {
                return {
                    status: PaymentStatus.PENDING,
                    message: '等待支付'
                }
            }
        } catch (error) {
            console.error('检查支付状态失败:', error)
            return {
                status: PaymentStatus.FAILED,
                message: '检查支付状态失败'
            }
        }
    }

    return {
        // 状态
        paymentStatus,
        loading,
        resultMessage,

        // 方法
        pay,
        startPollingPaymentStatus,
        stopPolling,
        checkPaymentStatus
    }
}