<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onLoad, onUnload } from '@dcloudio/uni-app'
import { getMemberOrderByIdAPI } from '@/services/order'
import type { OrderResult } from '@/types/order'
import { OrderState } from '@/services/constants'
import { getPayAliPayMiniPayAPI } from '@/services/payment'
import {useAlipayPayment, PaymentStatus} from '../paymentSelection/components/alipayPayment'
import { getPayMockAPI ,verifyMockPayment} from '@/services/payment'

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

// 获取页面参数
const props = defineProps<{
  orderId: string
}>()

//模拟支付
const showPasswordDialog = ref(false)
const paymentPassword = ref('')
const passwordError = ref('')
const passwordPopupRef = ref(null)

// 订单信息
const order = ref<OrderResult>()

// 选择的支付方式
const paymentMethod = ref<'wechat' | 'alipay' | 'mockpay' | null>(null)

// 支付中状态
const isLoading = ref(false)

// 是否已取消
const isOrderCanceled = computed(() => {
  return order.value?.orderState === OrderState.YiQuXiao || 
         order.value?.countdown === 0 || 
         !order.value?.countdown
})

// 是否为开发环境
const isDev = import.meta.env.DEV
// 支付宝支付处理器
const alipayPayment = useAlipayPayment()
// 获取订单详情
const getMemberOrderByIdData = async () => {
  try {
    const response = await getMemberOrderByIdAPI(props.orderId)
    order.value = response.data
    
    // 检查订单状态
    if (isOrderCanceled.value) {
      showOrderCanceledTip()
    }
  } catch (error) {
    console.error('获取订单详情失败', error)
    uni.showToast({
      icon: 'none',
      title: '获取订单详情失败'
    })
  }
}

// 显示订单已取消提示
const showOrderCanceledTip = () => {
  uni.showModal({
    title: '订单已取消',
    content: '当前订单已超时或已被取消',
    showCancel: false,
    success: () => {
      goToOrderList()
    }
  })
}

// 处理倒计时结束
const onTimeup = () => {
  // 订单倒计时结束，显示订单已取消
  if (order.value) {
    order.value.orderState = OrderState.YiQuXiao // 设置为已取消状态 (6)
  }
  showOrderCanceledTip()
}

// 跳转到订单列表
const goToOrderList = () => {
  uni.redirectTo({
    url: '/pagesOrder/orderList/orderList'
  })
}

// 处理参数加载
onLoad(() => {
  if (props.orderId) {
    // 获取订单详情
    getMemberOrderByIdData()
  } else {
    // 没有订单ID，提示错误
    uni.showToast({
      icon: 'none',
      title: '订单参数错误'
    })
    setTimeout(() => {
      goBack()
    }, 1500)
  }
})

// 支付方式选择
const selectPaymentMethod = (method: 'wechat' | 'alipay' | 'mockpay') => {
  paymentMethod.value = method
}

// 执行支付
const handlePay = async () => {
  // 检查订单是否已取消
  if (isOrderCanceled.value) {
    return showOrderCanceledTip()
  }
  
  // 检查支付方式
  if (!paymentMethod.value) {
    return uni.showToast({
      icon: 'none',
      title: '请选择支付方式'
    })
  }

  isLoading.value = true

  try {
    // 通过环境变量区分开发环境
    if (paymentMethod.value === 'mockpay') {
      //开发环境：模拟支付，修改订单状态为已支付
      if (!order.value?.orderNo) {
        throw new Error('订单编号不存在')
      }
      const response = await getPayMockAPI(order.value?.orderNo)
      if(response.code!==200){
        uni.showToast({
          icon: 'error',
          title: response.msg
        })
        isLoading.value = false
        return
      }
      // Reset password input
      paymentPassword.value = ''
      passwordError.value = ''
      // Show password dialog
      passwordPopupRef.value?.open()
      isLoading.value = false
      return

    }else if (paymentMethod.value === 'wechat') {
      // 调用微信支付
      const response = await getPayWxPayMiniPayAPI({ orderId: props.orderId })
      await wx.requestPayment(response.result)
      // 支付成功处理
      handlePaymentSuccess()
    } else if (paymentMethod.value === 'alipay') {
      // 调用支付宝支付
      if (!order.value?.orderNo) {
        throw new Error('订单编号不存在')
      }
      const result = await alipayPayment.pay(order.value.orderNo)
      if (result.status === PaymentStatus.SUCCESS) {
        // 直接处理支付成功
        handlePaymentSuccess()
      } else if (result.status === PaymentStatus.PROCESSING) {
        // 支付处理中，跳转到WebView页面后会由WebView页面处理结果
        isLoading.value = false
      } else {
        // 支付失败
        uni.showToast({
          icon: 'none',
          title: result.message
        })
        isLoading.value = false
      }  
    }
  
  } catch (error) {
    console.error('支付失败', error)
    uni.showToast({
      icon: 'none',
      title: '支付失败，请重试'
    })
  } finally {
    isLoading.value = false
  }
}


// 模拟支付
// Add this new function to handle mock payment submission
const submitMockPayment = async () => {
  if (!paymentPassword.value) {
    passwordError.value = '请输入支付密码'
    return
  }
  
  isLoading.value = true
  
  try {
    if (!order.value?.orderNo) {
      throw new Error('订单编号不存在')
    }
    
    // Call the verify payment API
    const res = await verifyMockPayment(order.value.orderNo, paymentPassword.value)
    
    if (res.code === 200 && res.data) {
      // Close dialog
      showPasswordDialog.value = false
      // Show success message and redirect
      handlePaymentSuccess()
    } else {
      // Show error message
      passwordError.value = res.msg || '支付密码错误，请重试'
    }
  } catch (error) {
    console.error('支付验证失败', error)
    passwordError.value = '支付验证失败，请重试'
  } finally {
    isLoading.value = false
  }
}
// Add function to close the password dialog
const closePasswordDialog = () => {
  passwordPopupRef.value?.close()
  paymentPassword.value = ''
  passwordError.value = ''
}



// 支付成功后处理
const handlePaymentSuccess = () => {
  uni.showToast({
    icon: 'success',
    title: '支付成功'
  })
  
  // 跳转到支付结果页
  setTimeout(() => {
    uni.redirectTo({
      url: `/pagesOrder/paymentResult/paymentResult?id=${props.orderId}&status=success`
    })
  }, 1500)
}

// 返回上一页
const goBack = () => {
  uni.navigateBack()
}

// 页面卸载时清理
onUnload(() => {
  // 清理工作（如果有）
  alipayPayment.stopPolling()
})
</script>

<template>
  <view class="payment-selection" :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }">
    <!-- 支付金额信息 -->
    <view class="overview" v-if="order">
      <view class="price">¥{{ order.payMoney.toFixed(2) }}</view>
      <view class="tips" v-if="!isOrderCanceled">
        <text class="time">支付剩余</text>
        <uni-countdown
          v-if="order.countdown"
          :second="order.countdown"
          @timeup="onTimeup"
          color="#fff"
          splitor-color="#fff"
          :show-day="false"
        />
        <text v-else>00:00:00</text>
      </view>
      <view class="tips" v-else>
        <text class="canceled">订单已取消</text>
      </view>
    </view>
    
    <!-- 支付方式选择 -->
    <view class="payment-methods" v-if="!isOrderCanceled">
      <view class="section-title">请选择支付方式</view>
      
      <!-- 微信支付 -->
      <view 
        class="payment-method-item" 
        :class="{ active: paymentMethod === 'wechat' }"
        @tap="selectPaymentMethod('wechat')"
      >
        <view class="payment-icon wechat-icon">
          <image src="/static/images/wechat.jpg" mode="aspectFit"></image>
        </view>
        <view class="payment-info">
          <view class="payment-name">微信支付</view>
          <view class="payment-desc">亿万用户都在用，安全便捷</view>
        </view>
        <view class="payment-select">
          <radio :checked="paymentMethod === 'wechat'" color="#cf4261" />
        </view>
      </view>
      
      <!-- 支付宝支付 -->
      <view 
        class="payment-method-item" 
        :class="{ active: paymentMethod === 'alipay' }"
        @tap="selectPaymentMethod('alipay')"
      >
        <view class="payment-icon alipay-icon">
          <image src="/static/images/alipay.png" mode="aspectFit"></image>
        </view>
        <view class="payment-info">
          <view class="payment-name">支付宝支付</view>
          <view class="payment-desc">全球领先的第三方支付平台</view>
        </view>
        <view class="payment-select">
          <radio :checked="paymentMethod === 'alipay'" color="#cf4261" />
        </view>
      </view>

            <!-- 模拟支付 -->
      <view 
        class="payment-method-item" 
        :class="{ active: paymentMethod === 'mockpay' }"
        @tap="selectPaymentMethod('mockpay')"
      >
        <view class="payment-icon mockpay-icon">
          <image src="/static/images/mockpay.png" mode="aspectFit"></image>
        </view>
        <view class="payment-info">
          <view class="payment-name">模拟支付</view>
          <view class="payment-desc">模拟支付</view>
        </view>
        <view class="payment-select">
          <radio :checked="paymentMethod === 'mockpay'" color="#cf4261" />
        </view>
      </view>
    </view>
    
    <!-- 订单已取消提示 -->
    <view class="canceled-notice" v-if="isOrderCanceled">
      <image src="/static/images/order-canceled.png" mode="aspectFit"></image>
      <text>订单已取消</text>
      <text class="sub-text">您可以重新下单或查看其他商品</text>
    </view>
    
    <!-- 订单信息 -->
    <view class="order-info" v-if="order">
      <view class="section-title">订单信息</view>
      <view class="info-item">
        <text class="label">订单编号</text>
        <text class="value">{{ order.orderNo }}</text>
      </view>
    </view>
    
    <!-- 底部支付按钮 -->
    <view class="toolbar" 
          :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }"
          v-if="!isOrderCanceled">
      <button 
        class="button primary"
        :disabled="!paymentMethod || isLoading"
        :loading="isLoading"
        @tap="handlePay"
      >
        确认支付
      </button>
      <navigator url="/pagesOrder/orderList/orderList" open-type="redirect" class="button">
        返回订单列表
      </navigator>
    </view>
    
    <!-- 已取消的底部按钮 -->
    <view class="toolbar" 
          :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }"
          v-if="isOrderCanceled">
      <navigator url="/pages/index/index" open-type="switchTab" class="button primary">
        继续购物
      </navigator>
      <navigator url="/pagesOrder/orderList/orderList" open-type="redirect" class="button">
        返回订单列表
      </navigator>
    </view>

    <!-- 模拟支付密码弹窗 -->
    <uni-popup ref="passwordPopupRef" type="dialog" @close="closePasswordDialog">
      <view class="mockpay-dialog">
        <view class="dialog-header">
          <text class="dialog-title">输入支付密码</text>
        </view>
        
        <view class="dialog-body">
          <view class="payment-amount">
            <text class="amount-label">支付金额</text>
            <text class="amount-value">¥{{ order?.payMoney.toFixed(2) }}</text>
          </view>
          
          <view class="password-input-container">
            <input 
              class="password-input" 
              type="password" 
              v-model="paymentPassword" 
              maxlength="6" 
              placeholder="请输入6位数字密码" 
              :password="true"
            />
          </view>
          
          <view v-if="passwordError" class="password-error">
            {{ passwordError }}
          </view>
          
          <view class="tip-text">
            提示：模拟支付密码为 123456
          </view>
        </view>
        
        <view class="dialog-footer">
          <button class="dialog-btn cancel" @tap="closePasswordDialog">取消</button>
          <button 
            class="dialog-btn confirm" 
            @tap="submitMockPayment" 
            :loading="isLoading"
            :disabled="isLoading"
          >
            确认支付
          </button>
        </view>
      </view>
    </uni-popup>
  </view>
</template>

<style lang="scss">
.payment-selection {
  min-height: 100vh;
  background-color: #f7f7f8;
  padding-bottom: 120rpx;
  
  .overview {
    display: flex;
    flex-direction: column;
    align-items: center;
    line-height: 1;
    padding: 80rpx 30rpx;
    color: #fff;
    background-image: url('../../static/images/navigator_bg.png');
    background-size: cover;
    
    .price {
      font-size: 60rpx;
      font-weight: 600;
      margin-bottom: 20rpx;
    }
    
    .tips {
      margin-top: 20rpx;
      display: flex;
      font-size: 26rpx;
      align-items: center;
      gap: 10rpx;
    }
    
    .canceled {
      background-color: rgba(255, 255, 255, 0.2);
      border-radius: 24rpx;
      padding: 6rpx 20rpx;
    }
  }
  
  .payment-methods {
    background-color: #ffffff;
    margin: 20rpx;
    border-radius: 12rpx;
    padding: 20rpx;
    
    .section-title {
      font-size: 28rpx;
      color: #333;
      padding-bottom: 15rpx;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .payment-method-item {
      display: flex;
      align-items: center;
      padding: 24rpx 10rpx;
      border-bottom: 1px solid #f0f0f0;
      
      &:last-child {
        border-bottom: none;
      }
      
      &.active {
        background-color: #f9f9f9;
      }
      
      .payment-icon {
        width: 80rpx;
        height: 80rpx;
        border-radius: 10rpx;
        overflow: hidden;
        margin-right: 20rpx;
        
        image {
          width: 100%;
          height: 100%;
        }
      }
      
      .payment-info {
        flex: 1;
        
        .payment-name {
          font-size: 28rpx;
          color: #333;
        }
        
        .payment-desc {
          font-size: 24rpx;
          color: #999;
          margin-top: 6rpx;
        }
      }
    }
  }
  
  .canceled-notice {
    background-color: #ffffff;
    margin: 20rpx;
    border-radius: 12rpx;
    padding: 40rpx 20rpx;
    display: flex;
    flex-direction: column;
    align-items: center;
    
    image {
      width: 200rpx;
      height: 200rpx;
      margin-bottom: 30rpx;
    }
    
    text {
      font-size: 32rpx;
      color: #333;
      margin-bottom: 10rpx;
    }
    
    .sub-text {
      font-size: 24rpx;
      color: #999;
    }
  }
  
  .order-info {
    background-color: #ffffff;
    margin: 20rpx;
    border-radius: 12rpx;
    padding: 20rpx;
    
    .section-title {
      font-size: 28rpx;
      color: #333;
      padding-bottom: 15rpx;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .info-item {
      display: flex;
      justify-content: space-between;
      font-size: 26rpx;
      margin-top: 20rpx;
      
      .label {
        color: #666;
      }
      
      .value {
        color: #333;
        max-width: 400rpx;
        text-align: right;
      }
    }
  }
  
  .toolbar {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ffffff;
    padding: 20rpx 30rpx;
    box-shadow: 0 -2rpx 10rpx rgba(0, 0, 0, 0.05);
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-sizing: content-box;
    
    .button {
      flex: 1;
      height: 72rpx;
      text-align: center;
      line-height: 72rpx;
      margin: 0 20rpx;
      color: #444;
      border-radius: 72rpx;
      border: 1rpx solid #ccc;
      font-size: 28rpx;
    }
    
    .primary {
      color: #fff;
      background-color: #cf4261;
      border: none;
      
      &[disabled] {
        opacity: 0.6;
        background-color: #ffb6b6;
      }
    }
  }
}

.mockpay-dialog {
  width: 650rpx;
  background-color: #fff;
  border-radius: 16rpx;
  overflow: hidden;
  
  .dialog-header {
    padding: 30rpx;
    text-align: center;
    border-bottom: 1px solid #eee;
    
    .dialog-title {
      font-size: 32rpx;
      color: #333;
      font-weight: 500;
    }
  }
  
  .dialog-body {
    padding: 40rpx 30rpx;
    
    .payment-amount {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 40rpx;
      
      .amount-label {
        font-size: 28rpx;
        color: #666;
        margin-bottom: 10rpx;
      }
      
      .amount-value {
        font-size: 48rpx;
        color: #333;
        font-weight: 600;
      }
    }
    
    .password-input-container {
      margin-bottom: 20rpx;
      
      .password-input {
        width: 100%;
        height: 80rpx;
        border: 1px solid #ddd;
        border-radius: 8rpx;
        padding: 0 20rpx;
        font-size: 32rpx;
        color: #333;
        text-align: center;
        letter-spacing: 8rpx;
      }
    }
    
    .password-error {
      color: #cf4261;
      font-size: 24rpx;
      text-align: center;
      margin-bottom: 20rpx;
    }
    
    .tip-text {
      font-size: 24rpx;
      color: #999;
      text-align: center;
    }
  }
  
  .dialog-footer {
    display: flex;
    border-top: 1px solid #eee;
    
    .dialog-btn {
      flex: 1;
      height: 90rpx;
      line-height: 90rpx;
      text-align: center;
      font-size: 30rpx;
      background-color: #fff;
      border-radius: 0;
      margin: 0;
      
      &.cancel {
        color: #666;
        border-right: 1px solid #eee;
      }
      
      &.confirm {
        color: #cf4261;
      }
      
      &[disabled] {
        opacity: 0.6;
      }
    }
  }
}
</style>