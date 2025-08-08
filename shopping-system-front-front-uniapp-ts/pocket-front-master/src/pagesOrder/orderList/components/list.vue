<script setup lang="ts">
import type {OrderListParams, OrderItem} from '@/types/order'
import { getMemberOrderAPI } from '@/services/order'
import { onMounted,ref } from 'vue';
import { OrderState,orderStateList } from '@/services/constants';
import { getPayMockAPI, getPayWxPayMiniPayAPI } from '@/services/payment';
import { deleteMemberOrderAPI } from '@/services/order';
import { onLoad } from '@dcloudio/uni-app';

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

//定义props
const props = defineProps<{
    orderState: number
}>()    

//请求参数
const queryParams: Required<OrderListParams> = {
    page: 1,
    pageSize:5,
    orderState: props.orderState
}

//获取订单列表
const orderList = ref<OrderItem[]>([])


// 加载状态
const isLoading = ref(false)
// 是否还有更多数据
const hasMore = ref(true)
// 已结束标记
const finish = ref(false)

const getMemberOrderData = async() => {
    if (isLoading.value || !hasMore.value) return
    if (finish.value == true){
    return uni.showToast({ icon: 'none', title: '没有更多数据' })
    }
    isLoading.value = true
    const response = await getMemberOrderAPI(queryParams)
    //import type { PageParams, PageResult } from '@/types/global'
    const newOrders = response.data.rows || []
    orderList.value = [...orderList.value, ...newOrders]
    
    // 判断是否还有更多数据
    hasMore.value = newOrders.length === queryParams.pageSize
    if (hasMore.value) {
        queryParams.page++
    }
    isLoading.value = false
}
// 滚动到底部触发加载更多
const onScrollToLower = () => {
    getMemberOrderData()
}

// 下拉刷新状态
const isTrigered = ref(false)
// 下拉刷新方法
const onRefresh = async () => {
    isTrigered.value = true
    // 重置分页参数
    queryParams.page = 1
    hasMore.value = true
    try {
        const response = await getMemberOrderAPI(queryParams)
        orderList.value = response.data.rows
        // 判断是否还有更多数据
        hasMore.value = response.data.rows.length === queryParams.pageSize
        if (hasMore.value) {
            queryParams.page++
        }
    } catch (error) {
        console.error('下拉刷新失败:', error)
    } finally {
        isTrigered.value = false
    }
}

//订单支付
const onOrderPayment=async(orderId:string)=>{
    // Find the order safely
  const order = orderList.value.find(item => item.orderId === orderId)
  if (!order) {
    uni.showToast({ icon: 'none', title: '订单信息不存在' })
    return
  }
  if (!orderList.value) return
  uni.navigateTo({
    url: `/pagesOrder/paymentSelection/paymentSelection?orderId=${order.orderId}`
  })
  console.log('发送参数:', { orderId, payMoney: order.payMoney })
  // // 通过环境变量区分开发环境
  // if (import.meta.env.DEV) {
  //   // 开发环境：模拟支付，修改订单状态为已支付
  //   await getPayMockAPI({ orderId: id })
  // } else {
  //   // 生产环境：获取支付参数 + 发起微信支付
  //   const response = await getPayWxPayMiniPayAPI({ orderId: id })
  //   await wx.requestPayment(response.data)
  // }
  // //成功提示
  // uni.showToast({ title: '支付成功', icon: 'success' })
  // const order = orderList.value.find(item => item.orderId === id)
  // order!.orderState = OrderState.DaiFaHuo
}

// 删除订单
const onOrderDelete = async (orderId: string) => {
  uni.showModal({
    content: '确认删除订单？',
    success: async (success) => {
      if(success.confirm){
        try {
          // 调用删除订单 API
          await deleteMemberOrderAPI({ ids: [Number(orderId)] })
          // 显示删除成功提示
          uni.showToast({ icon: 'success', title: '订单删除成功' })
          // 重新获取订单列表
          await getMemberOrderData()
        } catch (error) {
          // 显示删除失败提示
          console.error('删除订单失败:', error)
          uni.showToast({ icon: 'none', title: '订单删除失败' })
        }
      }
    },
  })
}

onLoad(() => {
    getMemberOrderData()
})



</script>


<template>
    <scroll-view scroll-y 
    refresher-enabled="true"
    @refresherrefresh="onRefresh"
    :refresher-triggered="isTrigered"
    class="orders" 
    id="scroller" 
    @scrolltolower="onScrollToLower">
        <view class="card" v-for="order in orderList" :key="order.orderId">
        <!-- 订单信息 -->
        <view class="status">
            <text class="date">{{order.createTime}}</text>
            <!-- 订单状态文字 -->
            <text>{{orderStateList[order.orderState].text}}</text>
            <!-- 待评价/已完成/已取消 状态: 展示删除订单 -->
            <text class="icon-delete" v-if="order.orderState >= OrderState.DaiPingJia "></text>
        </view>
        <!-- 商品信息，点击商品跳转到订单详情，不是商品详情 -->
        <navigator
            v-for="sku in order.orderItemList"
            :key="sku.spuId"
            class="goods"
            :url="`/pagesOrder/orderDetails/orderDetails?id=${order.orderId}`"
            hover-class="none"
        >
            <view class="cover">
            <image
                mode="aspectFit"
                :src="sku.thumbImg"
            ></image>
            </view>
            <view class="meta">
            <view class="name ellipsis">{{sku.skuName}}</view>
            <view class="type">{{sku.attrsText}}</view>
            </view>
        </navigator>
        <!-- 支付信息 -->
        <view class="payment">
            <text class="quantity">共{{order.totalNum}}件商品</text>
            <text>实付</text>
            <text class="amount"> <text class="symbol">¥</text>{{order.payMoney}}</text>
        </view>
        <!-- 订单操作按钮 -->
        <view class="action">
            <!-- 待付款状态：显示去支付按钮 -->
            <template v-if="order.orderState === OrderState.DaiFuKuan">
                <view class="button primary" @tap="onOrderPayment(order.orderId)">去支付</view>
            </template>
            <template v-else>
            <navigator
                class="button secondary"
                :url="`/pagesOrder/createOrder/createOrder?orderId=${order.orderId}`"
                hover-class="none"
            >
                再次购买
            </navigator>
            <view class="button primary"  @tap="onOrderDelete(order.orderId)" v-if="order.orderState >= OrderState.DaiPingJia" > 删除 </view>
            <!-- 待收货状态: 展示确认收货 -->
            <view v-if="order.orderState === OrderState.DaiShouHuo" class="button primary">确认收货</view>
            </template>
        </view>
        </view>
        <!-- 底部提示文字 -->
        <view class="loading-text" :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }">
          {{ hasMore ? '正在加载...' : '没有更多数据~' }}
        </view>
    </scroll-view>

</template>



<style lang="scss">  
/* 订单列表
*/
.orders {
  .card {
    min-height: 100rpx;
    padding: 20rpx;
    margin: 20rpx 20rpx 0;
    border-radius: 10rpx;
    background-color: #fff;

    &:last-child {
      padding-bottom: 40rpx;
    }
  }

  .status {
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 28rpx;
    color: #999;
    margin-bottom: 15rpx;

    .date {
      color: #666;
      flex: 1;
    }

    .primary {
      color: #ff9240;
    }

    .icon-delete {
      line-height: 1;
      margin-left: 10rpx;
      padding-left: 10rpx;
      border-left: 1rpx solid #e3e3e3;
    }
  }

  .goods {
    display: flex;
    margin-bottom: 20rpx;

    .cover {
      width: 170rpx;
      height: 170rpx;
      margin-right: 20rpx;
      border-radius: 10rpx;
      overflow: hidden;
      position: relative;
    }

    .quantity {
      position: absolute;
      bottom: 0;
      right: 0;
      line-height: 1;
      padding: 6rpx 4rpx 6rpx 8rpx;
      font-size: 24rpx;
      color: #fff;
      border-radius: 10rpx 0 0 0;
      background-color: rgba(0, 0, 0, 0.6);
    }

    .meta {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .name {
      height: 80rpx;
      font-size: 26rpx;
      color: #444;
    }

    .type {
      line-height: 1.8;
      padding: 0 15rpx;
      margin-top: 10rpx;
      font-size: 24rpx;
      align-self: flex-start;
      border-radius: 4rpx;
      color: #888;
      background-color: #f7f7f8;
    }

    .more {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22rpx;
      color: #333;
    }
  }

  .payment {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    line-height: 1;
    padding: 20rpx 0;
    text-align: right;
    color: #999;
    font-size: 28rpx;
    border-bottom: 1rpx solid #eee;

    .quantity {
      font-size: 24rpx;
      margin-right: 16rpx;
    }

    .amount {
      color: #444;
      margin-left: 6rpx;
    }

    .symbol {
      font-size: 20rpx;
    }
  }

  .action {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding-top: 20rpx;

    .button {
      width: 180rpx;
      height: 60rpx;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-left: 20rpx;
      border-radius: 60rpx;
      border: 1rpx solid #ccc;
      font-size: 26rpx;
      color: #444;
    }

    .secondary {
      color: #cf4261;
      border-color: #cf4261;
    }

    .primary {
      color: #fff;
      background-color: #cf4261;
    }
  }

  .loading-text {
    text-align: center;
    font-size: 28rpx;
    color: #666;
    padding: 20rpx 0;
  }
}
</style>