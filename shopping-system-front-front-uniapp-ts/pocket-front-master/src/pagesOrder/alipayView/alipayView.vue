<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { onLoad, onUnload } from '@dcloudio/uni-app'
import { useAlipayPayment, PaymentStatus } from '@/pagesOrder/paymentSelection/components/alipayPayment'

// 获取页面参数
const orderNo = ref('')
const formHtml = ref('')

// 支付状态管理
const alipayPayment = useAlipayPayment()
const { startPollingPaymentStatus, stopPolling } = alipayPayment

// WebView加载状态
const webviewLoading = ref(true)

// 接收页面参数
onLoad((options) => {
  if (options) {
    orderNo.value = options.orderNo || ''
    formHtml.value = decodeURIComponent(options.formHtml || '')
  }
})

// 处理支付结果
const handlePaymentResult = (result: any) => {
  if (result.status === PaymentStatus.SUCCESS) {
    // 支付成功，跳转到支付成功页面
    uni.redirectTo({
      url: `/pagesOrder/paymentResult/paymentResult?id=${orderNo.value}&status=success`
    })
  } else if (result.status === PaymentStatus.FAILED) {
    // 支付失败，提示用户
    uni.showToast({
      icon: 'none',
      title: result.message
    })
    
    // 返回支付选择页面
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  }
}

// WebView加载完成
const handleWebViewLoaded = () => {
  webviewLoading.value = false
}

// WebView加载失败
const handleWebViewError = (err: any) => {
  console.error('WebView加载失败:', err)
  uni.showToast({
    icon: 'none',
    title: '支付页面加载失败'
  })
  
  // 返回上一页
  setTimeout(() => {
    uni.navigateBack()
  }, 1500)
}

// 处理WebView消息事件
const handleWebViewMessage = (event: any) => {
  try {
    const data = event.detail ? JSON.parse(event.detail.data) : null
    
    if (data && data.type === 'alipay_callback') {
      // 支付宝回调消息
      if (data.success) {
        // 支付成功
        handlePaymentResult({
          status: PaymentStatus.SUCCESS,
          message: '支付成功'
        })
      } else {
        // 支付失败或取消
        handlePaymentResult({
          status: PaymentStatus.FAILED,
          message: data.message || '支付未完成'
        })
      }
    }
  } catch (error) {
    console.error('处理WebView消息失败:', error)
  }
}

// 页面加载完成开始检查支付状态
onMounted(() => {
  if (orderNo.value) {
    // 开始轮询检查支付状态
    startPollingPaymentStatus(orderNo.value, handlePaymentResult)
  }
})

// 页面卸载时停止轮询
onUnload(() => {
  stopPolling()
})

// 返回上一页
const goBack = () => {
  uni.navigateBack()
}
</script>

<template>
  <view class="alipay-webview">
    <!-- 导航栏 -->
    <view class="navbar">
      <view class="back-icon" @tap="goBack">
        <text class="iconfont icon-left"></text>
      </view>
      <view class="title">支付宝支付</view>
    </view>
    
    <!-- 加载提示 -->
    <view class="loading" v-if="webviewLoading">
      <view class="spinner"></view>
      <text>正在加载支付页面...</text>
    </view>
    
    <!-- 支付表单WebView -->
    <web-view 
      v-if="formHtml"
      :src="'data:text/html;charset=utf-8,' + encodeURIComponent(formHtml)"
      @load="handleWebViewLoaded"
      @error="handleWebViewError"
      @message="handleWebViewMessage"
    ></web-view>
    
    <!-- 提示信息 -->
    <view class="tips">
      <text>请在支付宝中完成支付</text>
      <text>付款成功后将自动返回商城</text>
    </view>
  </view>
</template>

<style lang="scss">
.alipay-webview {
  min-height: 100vh;
  background-color: #f7f7f8;
  
  .navbar {
    display: flex;
    align-items: center;
    height: 88rpx;
    background-color: #ffffff;
    padding: 0 30rpx;
    position: relative;
    
    .back-icon {
      font-size: 36rpx;
      color: #333;
      width: 60rpx;
    }
    
    .title {
      flex: 1;
      text-align: center;
      font-size: 32rpx;
      font-weight: 500;
      color: #333;
    }
  }
  
  .loading {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    
    .spinner {
      width: 60rpx;
      height: 60rpx;
      border: 6rpx solid #f3f3f3;
      border-top: 6rpx solid #cf4261;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin-bottom: 20rpx;
    }
    
    text {
      font-size: 28rpx;
      color: #666;
    }
  }
  
  .tips {
    position: fixed;
    bottom: 40rpx;
    left: 0;
    right: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    
    text {
      font-size: 24rpx;
      color: #999;
      line-height: 1.5;
    }
  }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>