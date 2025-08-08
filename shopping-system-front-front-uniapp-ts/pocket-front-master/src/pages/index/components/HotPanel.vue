<script setup lang="ts">
import type { HotItem } from '@/types/home'

defineProps<{
  list: HotItem[]
}>()

const splitPictures = (pictures: string | string[]) => {
  if (typeof pictures === 'string') {
    return pictures.split(',')
  }
  return pictures
}
</script>

<template>
  <!-- 推荐专区 -->
  <view class="panel hot">
    <view class="item" v-for="item in list" :key="item.id">
      <view class="title">
        <text class="title-text">{{ item.title }}</text>
        <!-- <text class="title-desc">{{ item.alt }}</text> -->
      </view>
      <navigator hover-class="none" :url="`/pages/hot/hot?type=${item.type}`" class="cards">
        <image
          v-for="src in splitPictures(item.pictures)"
          :key="src"
          class="image"
          mode="aspectFit"
          :src="src"
        ></image>

      </navigator>
    </view>
  </view>
</template>

<style lang="scss">
/* 热门推荐 */
.hot {
  display: flex;
  flex-wrap: wrap;
  // 移除固定的最小高度，让内容自适应
  // min-height: 508rpx;
  margin: 20rpx 20rpx 0;
  border-radius: 10rpx;
  background-color: #fff;

  .title {
    display: flex;
    align-items: center;
    padding: 24rpx 24rpx 0;
    font-size: 32rpx;
    color: #262626;
    position: relative;
    .title-desc {
      font-size: 24rpx;
      color: #7f7f7f;
      margin-left: 18rpx;
    }
  }

  .item {
    display: flex;
    flex-direction: column;
    width: 50%;
    // 调整高度为自适应，而不是固定高度
    min-height: 200rpx;
    border-right: 1rpx solid #eee;
    border-top: 1rpx solid #eee;
    
    .title {
      justify-content: start;
      // 减少标题的内边距，让内容更紧凑
      padding: 20rpx 24rpx 10rpx;
    }
    
    &:nth-child(2n) {
      border-right: 0 none;
    }
    &:nth-child(-n + 2) {
      border-top: 0 none;
    }
    
    .image {
      width: 150rpx;
      height: 150rpx;
    }
  }
  
  .cards {
    flex: 1;
    // 调整内边距，让内容更紧凑
    padding: 10rpx 20rpx 20rpx;
    display: flex;
    justify-content: space-between;
    align-items: center;
    // 确保卡片区域能够填满剩余空间
    min-height: 0;
  }
}
</style>