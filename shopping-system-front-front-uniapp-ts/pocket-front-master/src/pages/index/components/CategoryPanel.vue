<script setup lang="ts">
import type { CategoryItem } from '@/types/home'

// 定义 props 接收数据
defineProps<{
  list: CategoryItem[]
}>()

const onSwitchToCategory=(category1id:string)=>{
  uni.setStorageSync('category1id', category1id);
  uni.switchTab({
    url: '/pages/category/category'
  })
}
</script>

<template>
  <view class="category">
    <navigator class="category-item" hover-class="none" url="/pages/category/category" @tap="onSwitchToCategory(item.id)"  v-for="item in list" :key="item.id">
      <image class="icon" :src="item.imageUrl"></image>
      <text class="text">{{ item.name }}</text>
    </navigator>
  </view>
</template>

<style lang="scss">
/* 前台类目 */
.category {
  margin: 20rpx 0 0;
  padding: 10rpx 0;
  display: flex;
  flex-wrap: wrap;
  min-height: 328rpx;

  .category-item {
    width: calc(20% - 4rpx);
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    box-sizing: border-box;

    .icon {
      width: 100rpx;
      height: 100rpx;
    }

    .text {
      font-size: 26rpx;
      color: #666;
    }
  }
}
</style>