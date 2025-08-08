<script setup lang="ts">
import { getHomeCustomerRecAPI } from '@/services/home';
import type { PageParams } from '@/types/global';
import type { GuessItem } from '@/types/home';
import { onMounted, ref } from 'vue';

//分页参数
const pageParams:Required<PageParams> = {
  page:1,
  pageSize:10
}
//获取猜你喜欢Recommend的数据
const customerRecList = ref<GuessItem[]>([])
// 已结束标记
const finish = ref(false)
const getHomeCustomerRecData = async() =>{
  if (finish.value == true){
    return uni.showToast({ icon: 'none', title: '没有更多数据' })
  }
  const response = await getHomeCustomerRecAPI(pageParams)
  //customerRecList.value = response.result.items
  //数组追加
  customerRecList.value.push(...response.data.rows)
  // 手动计算总页数
  const totalPages = Math.ceil(response.data.total / pageParams.pageSize);

  //页码累加
  if (pageParams.page < totalPages) {

    pageParams.page++
  } else {
    finish.value = true
  }

}

//重置数据
const resetData = () => {
  pageParams.page = 1
  customerRecList.value = []
  finish.value = false
}


onMounted(() => {
  getHomeCustomerRecData()
})

//暴露方法
defineExpose({
  getHomeCustomerRecData,
  resetData
})

</script>

<template>
  <!-- 猜你喜欢 -->
  <view class="caption">
    <text class="text">Recommend</text>
  </view>
  <view class="guess">
    <navigator
      class="guess-item"
      v-for="item in customerRecList"
      :key="item.product.id"
      :url="`/pages/goods/goods?id=${item.product.id}`"
    >
      <image
        class="image"
        mode="aspectFill"
        :src="item.product.sliderUrls.split(',')[0]"
      ></image>
      <view class="name"> {{ item.product.name }} </view>
      <view class="item-bottom">
        <view class="price">
          <text class="small">¥</text>
          <text>{{ item.price }}</text>
        </view>
        <view class="sales-num">销量 {{ item.orderNum || 0 }}</view>
      </view>  
    </navigator>
  </view>
  <view class="loading-text"> {{ finish ? '没有更多数据~' : '正在加载...' }} </view>
</template>

<style lang="scss">
:host {
  display: block;
}
/* 分类标题 */
.caption {
  display: flex;
  justify-content: center;
  line-height: 1;
  padding: 36rpx 0 40rpx;
  font-size: 32rpx;
  color: #262626;
  .text {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 28rpx 0 30rpx;

    &::before,
    &::after {
      content: '';
      width: 20rpx;
      height: 20rpx;
      background-image: url(@/static/images/bubble.png);
      background-size: contain;
      margin: 0 10rpx;
    }
  }
}

/* 猜你喜欢 */
.guess {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  padding: 0 20rpx;
  .guess-item {
    width: 345rpx;
    padding: 24rpx 20rpx 20rpx;
    margin-bottom: 20rpx;
    border-radius: 10rpx;
    overflow: hidden;
    background-color: #fff;
  }
  .image {
    width: 304rpx;
    height: 304rpx;
  }
  .name {
    height: 75rpx;
    margin: 10rpx 0;
    font-size: 26rpx;
    color: #262626;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
  }
  .item-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 4rpx;
  }
  .price {
    line-height: 1;
    color: #cf4444;
    font-size: 26rpx;
  }
  .small {
    font-size: 80%;
  }
  .sales-num {
    font-size: 22rpx;
    color: #999;
    line-height: 1;
  }
}
// 加载提示文字
.loading-text {
  text-align: center;
  font-size: 28rpx;
  color: #666;
  padding: 20rpx 0;
}
</style>