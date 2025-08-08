<script setup lang="ts">
import { useMemberStore } from '@/stores';
import { getMemberCartAPI } from '@/services/cart';
import { onShow } from '@dcloudio/uni-app';
import type { CartItem } from '@/types/cart';
import {computed, ref} from 'vue';
import { customerRecList } from '@/composables';
import {deleteMemberCartAPI} from '@/services/cart';
import type {InputNumberBoxEvent} from '@/components/vk-data-input-number-box/vk-data-input-number-box.d.ts';
import {putMemberCartBySkuIdAPI, putMemberCartSelectedAPI} from '@/services/cart';

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

//获取会员信息
const memberStore = useMemberStore()

//获取购物车数据
const cartList = ref<CartItem[]>([])

const getMemberCartData = async() => {
  const response = await getMemberCartAPI()
  cartList.value = response.data
}

//滚动到底部加载更多
const {guessRef, onScrollToLower} = customerRecList()


// 删除购物车商品
const onDeleteCart = (skuId: string) =>{
  // 弹窗二次确认
  uni.showModal({
    content: 'Confirm to delete?',
    success: async (res) => {
      if (res.confirm) {
        // 后端删除单品
        await deleteMemberCartAPI({ ids: [skuId] })
        // 重新获取列表
        getMemberCartData()
      }
    },
  })
}

// 修改商品数量
const onChangeCount=(ev:InputNumberBoxEvent)=>{
  putMemberCartBySkuIdAPI(ev.index, {count: ev.value})

}

// 修改商品选中状态
const onChangeSelected=(item:CartItem)=>{
  // 前端--相反状态
  item.isChecked = !item.isChecked
  // 后端数据更新
  putMemberCartBySkuIdAPI(item.skuId,{isChecked: item.isChecked})

}

//计算全选状态
const isSelectedAll=computed(()=>{
  return cartList.value.length && cartList.value.every(v=>v.isChecked)
})


//修改商品选中状态--全选
const onChangeSelectedAll=()=>{
  // 前端
  const _isSelectedAll = !isSelectedAll.value
  cartList.value.forEach((item)=>{
    item.isChecked = _isSelectedAll
  })
  // 后端数据更新
  putMemberCartSelectedAPI({isChecked: _isSelectedAll})
}

// 计算选中列表
const selectedCartList=computed(()=>{
  return cartList.value.filter(v=>v.isChecked)
})
//计算选中数量
  //reduce用于对数组中的元素进行累加操作。它接受两个参数：一个回调函数和一个初始值
  //sum 是累加的结果，item 是当前遍历到的商品对象。在每次迭代中，将当前商品的 count 属性值累加到 sum 上
const selectedCartListCount=computed(()=>{
  return selectedCartList.value.reduce((sum, item)=> sum+item.count, 0)
})

//计算合计
const selectedCartListtotalPrice=computed(()=>{
  return selectedCartList.value.reduce((sum, item)=> sum+item.skuPrice*item.count, 0).toFixed(2)
})

const onPayment=()=>{
  if(selectedCartListCount.value === 0){
    return uni.showToast({
      icon: 'none',
      title: 'Please select product',
    })
  }
  // 跳转到结算页面
  uni.showToast({title: "Waiting..."})
  uni.navigateTo({url: '/pagesOrder/createOrder/createOrder'})
}


//页面加载时调用
onShow(() => {
  if(memberStore.profile){
    getMemberCartData()
  }
})


</script>

<template>
  <scroll-view scroll-y class="scroll-view" @scrolltolower="onScrollToLower">
    <!-- 已登录: 显示购物车 -->
    <template v-if="memberStore.profile">
      <!-- 购物车列表 -->
      <view class="cart-list" v-if="cartList.length">
        <!-- 优惠提示 -->
        <view class="tips">
          <text class="label">满减</text>
          <text class="desc">满1件, 即可享受9折优惠</text>
        </view>
        <!-- 滑动操作分区 -->
        <uni-swipe-action>
          <!-- 滑动操作项 -->
          <uni-swipe-action-item v-for="item in cartList" :key="item.skuId" class="cart-swipe">
            <!-- 商品信息 -->
            <view class="goods">
              <!-- 选中状态 -->
              <text class="checkbox" :class="{ checked: item.isChecked }" @tap="onChangeSelected(item)"></text>
              <navigator
                :url="`/pages/goods/goods?id=${item.spuId}`"
                hover-class="none"
                class="navigator"
              >
                <image
                  mode="aspectFill"
                  class="picture"
                  :src="item.thumbImg"
                ></image>
                <view class="meta">
                  <view class="name ellipsis">{{item.skuName}}</view>
                  <view class="attrsText ellipsis">{{item.attrsText}}</view>
                  <view class="price">{{item.skuPrice}}</view>
                </view>
              </navigator>
              <!-- 商品数量 -->
              <view class="count">
                <vk-data-input-number-box 
                v-model="item.count" 
                :min="1" 
                :max="item.stock"
                @change="onChangeCount"
                :index="item.skuId"
                />

              </view>
            </view>
            <!-- 右侧删除按钮 -->
            <template #right>
              <view class="cart-swipe-right">
                <button class="button delete-button" @tap="onDeleteCart(item.skuId)">Delete</button>
              </view>
            </template>
          </uni-swipe-action-item>
        </uni-swipe-action>
      </view>
      <!-- 购物车空状态 -->
      <view class="cart-blank" v-else>
        <image src="/static/images/blank_cart.png" class="image" />
        <text class="text">购物车还是空的，快来挑选好货吧</text>
        <navigator open-type="switchTab" url="/pages/index/index" hover-class="none">
          <button class="button">去首页看看</button>
        </navigator>
      </view>
      <!-- 吸底工具栏 -->
      <view class="toolbar"  :style="{ paddingBottom: 8 + 'px' }">
        <text class="all" :class="{ checked: isSelectedAll }" @tap="onChangeSelectedAll">All</text>
        <text class="text">Total:</text>
        <text class="amount">{{selectedCartListtotalPrice}}</text>
        <view class="button-grounp">
          <view class="button payment-button" :class="{ disabled: selectedCartListCount=== 0 }" @tap="onPayment"> Checkout ({{selectedCartListCount}}) </view>
        </view>
      </view>
    </template>
    <!-- 未登录: 提示登录 -->
    <view class="login-blank" v-else>
      <text class="text">登录后可查看购物车中的商品</text>
      <navigator url="/pages/login/login" hover-class="none">
        <button class="button">去登录</button>
      </navigator>
    </view>
    <!-- 猜你喜欢 -->
    <PocketCustomerRec ref="guessRef"/>
    <!-- 底部占位空盒子 -->
    <view class="toolbar-height"></view>
  </scroll-view>
</template>

<style lang="scss">
// 根元素
:host {
  height: 100vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  background-color: #f7f7f8;
}

// 滚动容器
.scroll-view {
  flex: 1;
}

// 购物车列表
.cart-list {
  padding: 0 20rpx;

  // 优惠提示
  .tips {
    display: flex;
    align-items: center;
    line-height: 1;
    margin: 30rpx 10rpx;
    font-size: 26rpx;
    color: #666;

    .label {
      color: #fff;
      padding: 7rpx 15rpx 5rpx;
      border-radius: 4rpx;
      font-size: 24rpx;
      background-color: #cf4261;
      margin-right: 10rpx;
    }
  }

  // 购物车商品
  .goods {
    display: flex;
    padding: 20rpx 20rpx 20rpx 80rpx;
    border-radius: 10rpx;
    background-color: #fff;
    position: relative;

    .navigator {
      display: flex;
    }

    .checkbox {
      position: absolute;
      top: 0;
      left: 0;

      display: flex;
      align-items: center;
      justify-content: center;
      width: 80rpx;
      height: 100%;

      &::before {
        content: '\e6cd';
        font-family: 'erabbit' !important;
        font-size: 40rpx;
        color: #444;
      }

      &.checked::before {
        content: '\e6cc';
        color: #cf4261;
      }
    }

    .picture {
      width: 170rpx;
      height: 170rpx;
    }

    .meta {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      margin-left: 20rpx;
    }

    .name {
      height: 72rpx;
      font-size: 26rpx;
      color: #444;
    }

    .attrsText {
      line-height: 1.8;
      padding: 0 15rpx;
      font-size: 24rpx;
      align-self: flex-start;
      border-radius: 4rpx;
      color: #888;
      background-color: #f7f7f8;
    }

    .price {
      line-height: 1;
      font-size: 26rpx;
      color: #444;
      margin-bottom: 2rpx;
      color: #cf4444;

      &::before {
        content: '￥';
        font-size: 80%;
      }
    }

    // 商品数量
    .count {
      position: absolute;
      bottom: 20rpx;
      right: 5rpx;

      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 220rpx;
      height: 48rpx;

      .text {
        height: 100%;
        padding: 0 20rpx;
        font-size: 32rpx;
        color: #444;
      }

      .input {
        height: 100%;
        text-align: center;
        border-radius: 4rpx;
        font-size: 24rpx;
        color: #444;
        background-color: #f6f6f6;
      }
    }
  }

  .cart-swipe {
    display: block;
    margin: 20rpx 0;
  }

  .cart-swipe-right {
    display: flex;
    height: 100%;

    .button {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 50px;
      padding: 6px;
      line-height: 1.5;
      color: #fff;
      font-size: 26rpx;
      border-radius: 0;
    }

    .delete-button {
      background-color: #cf4444;
    }
  }
}

// 空状态
.cart-blank,
.login-blank {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  height: 60vh;
  .image {
    width: 400rpx;
    height: 281rpx;
  }
  .text {
    color: #444;
    font-size: 26rpx;
    margin: 20rpx 0;
  }
  .button {
    width: 240rpx !important;
    height: 60rpx;
    line-height: 60rpx;
    margin-top: 20rpx;
    font-size: 26rpx;
    border-radius: 60rpx;
    color: #fff;
    background-color: #cf4261;
  }
}

// 吸底工具栏
.toolbar {
  position: fixed;
  left: 0;
  right: 0;
  bottom: var(--window-bottom);
  z-index: 1;

  height: 100rpx;
  padding: 0 20rpx;
  display: flex;
  align-items: center;
  border-top: 1rpx solid #ededed;
  border-bottom: 1rpx solid #ededed;
  background-color: #fff;
  box-sizing: content-box;

  .all {
    margin-left: 25rpx;
    font-size: 14px;
    color: #444;
    display: flex;
    align-items: center;
  }

  .all::before {
    font-family: 'erabbit' !important;
    content: '\e6cd';
    font-size: 40rpx;
    margin-right: 8rpx;
  }

  .checked::before {
    content: '\e6cc';
    color: #cf4261;
  }

  .text {
    margin-right: 8rpx;
    margin-left: 32rpx;
    color: #444;
    font-size: 14px;
  }

  .amount {
    font-size: 20px;
    color: #cf4444;

    .decimal {
      font-size: 12px;
    }

    &::before {
      content: '￥';
      font-size: 12px;
    }
  }

  .button-grounp {
    margin-left: auto;
    display: flex;
    justify-content: space-between;
    text-align: center;
    line-height: 72rpx;
    font-size: 13px;
    color: #fff;

    .button {
      width: 240rpx;
      margin: 0 10rpx;
      border-radius: 72rpx;
    }

    .payment-button {
      background-color: #cf4261;

      &.disabled {
        opacity: 0.6;
      }
    }
  }
}
// 底部占位空盒子
.toolbar-height {
  height: 100rpx;
}
</style>