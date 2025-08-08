<!-- /src/pages/hot/hot.vue -->
<script setup lang="ts">
import { getHotRecommendAPI } from '@/services/hotRecommend';
import { onLoad } from '@dcloudio/uni-app';
import { ref, computed, getCurrentInstance } from 'vue';

// 获取当前实例
const { proxy } = getCurrentInstance()!;

// 定义数据类型接口
interface ProductItem {
  id: number;
  name: string;
  sliderUrls: string;
  status: number;
  auditStatus: number;
  auditMessage: string;
}

interface HotItem {
  specsList: any;
  product: ProductItem;
  orderNum: number;
  price: number;
}

interface SubTypeItem {
  id: string;
  title: string;
  goodsItems: {
    total: number;
    rows: HotItem[];
    code: number;
    msg: string;
  };
  finish?: boolean;
}

// 热门推荐页 标题和url
const hotMap = [
  { type: '1', title: '热门排名', url: '/recommendation/recommendationList/hotSpuList' },
  { type: '2', title: '个性化推荐', url: '/recommendation/recommendationList/user' },
  { type: '3', title: '一站买全', url: '/hot/oneStop' },
  { type: '4', title: '新鲜好物', url: '/hot/new' },
]

//uniapp获取页面参数
const query = defineProps<{type: string}>()
const currentUrlMap = hotMap.find((v)=> v.type === query.type)
// 导航栏标题
uni.setNavigationBarTitle({title: currentUrlMap!.title})

//推荐封面图
const bannerPicture = ref('')

//推荐选项
const subTypes = ref<SubTypeItem[]>([])

//高亮下标
const activeIndex = ref(0)

//分页参数
const pageParams = {
  page: 1,
  pageSize: 10
}

// 获取当前活跃列表，按orderNum排序
const currentSortedList = computed(() => {
  if (!subTypes.value[activeIndex.value]) return []
  
  const currentSubType = subTypes.value[activeIndex.value]
  return [...currentSubType.goodsItems.rows].sort((a, b) => (b.orderNum || 0) - (a.orderNum || 0))
})

// 格式化销量显示
const formatSalesNum = (num: number) => {
  if (!num) return '0'
  if (num >= 10000) {
    return (num / 10000).toFixed(1) + '万'
  }
  return num.toString()
}

//获取热门推荐数据
const getHotRecommendData = async() =>{
  const response = await getHotRecommendAPI(currentUrlMap!.url, pageParams)
  bannerPicture.value = response.data.bannerPicture
  subTypes.value = response.data.subTypes
  
  // 当 type 为 2 时，发起额外请求
  if (query.type === '2') {
    try {
      // 发起 /generate-all 请求
      await getHotRecommendAPI('/recommendation/recommendationList/generate-all');
      // 发起 /update-similarity 请求
      await getHotRecommendAPI('/recommendation/recommendationList/update-similarity');
    } catch (error) {
      console.error('额外请求出错:', error);
      uni.showToast({ icon: 'none', title: '额外请求失败' });
    }
  }  
}

//滚动触底
const onScrollToLower = async() =>{
  //获取当前选项
  const currentSubType = subTypes.value[activeIndex.value]
  
  if (currentSubType.finish) {
    return uni.showToast({ icon: 'none', title: '没有更多数据~' })
  }

  // 手动计算总页数
  const totalPages = Math.ceil(currentSubType.goodsItems.total / pageParams.pageSize)
  
  //判断是否还有更多数据
  if (pageParams.page < totalPages) {
    //当前页面累加
    pageParams.page++
  } else {
    // 标记已结束
    currentSubType.finish = true
    return uni.showToast({ icon: 'none', title: '没有更多数据~' })
  }

  //调用api传参
  const response = await getHotRecommendAPI(currentUrlMap!.url, {
    subType: currentSubType.id,
    page: pageParams.page,
    pageSize: pageParams.pageSize,
  })
  
  //新列表
  const newSubTypes = response.data.subTypes[activeIndex.value]
  
  //数组追加
  currentSubType.goodsItems.rows.push(...newSubTypes.goodsItems.rows)
}

// 页面加载时调用
onLoad(()=>{
  getHotRecommendData()
})

// 切换标签时重置分页
const onTabChange = (index: number) => {
  activeIndex.value = index
  pageParams.page = 1
}

// 跳转到商品详情
const goToGoodsDetail = (goodsId: number) => {
  proxy?.$uni?.navigateTo?.({
    url: `/pages/goods/goods?id=${goodsId}`
  }) || uni.navigateTo({
    url: `/pages/goods/goods?id=${goodsId}`
  })
}
</script>

<template>
  <view class="viewport">
    <!-- 推荐封面图 -->
    <view class="cover">
      <image :src="bannerPicture"></image>
      <view class="cover-content">
        <text class="cover-title">{{ currentUrlMap?.title }}</text>
        <text class="cover-subtitle">为你寻觅世间好物</text>
      </view>
    </view>

    <!-- 推荐选项 -->
    <view class="tabs">
      <text 
        v-for="(item,index) in subTypes" 
        :key="item.id" 
        class="text" 
        :class="{active: index === activeIndex}" 
        @tap="onTabChange(index)"
      >{{ item.title }}</text>
    </view>

    <!-- 推荐列表 -->
    <scroll-view 
      v-for="(item,index) in subTypes"
      :key="item.id"
      v-show="activeIndex === index"
      scroll-y 
      class="scroll-view"
      @scrolltolower="onScrollToLower"
    >
      <!-- 商品列表 -->
      <view class="goods-list">
        <view 
          v-for="(goods, goodsIndex) in currentSortedList"
          :key="goods.product.id"
          class="goods-item"
          @tap="goToGoodsDetail(goods.product.id)"
        >
          <!-- 商品图片 -->
          <view class="goods-image">
            <image
              mode="aspectFill"
              :src="goods.product.sliderUrls.split(',')[0]"
            ></image>
          </view>

          <!-- 商品信息 -->
          <view class="goods-info">
            <view class="goods-name">{{ goods.product.name }}</view>
            <view class="goods-price">
              <text class="price-symbol">¥</text>
              <text class="price-value">{{ goods.price }}</text>
            </view>
            <view class="goods-sales">销量 {{ formatSalesNum(goods.orderNum || 0) }}</view>
          </view>

          <!-- 排名标识 -->
          <view class="rank-number" :class="{
            'rank-top3': goodsIndex < 3,
            'rank-1': goodsIndex === 0,
            'rank-2': goodsIndex === 1, 
            'rank-3': goodsIndex === 2
          }">
            {{ goodsIndex + 1 }}
          </view>
        </view>
      </view>

      <view class="loading-text">
        {{ subTypes[activeIndex]?.finish ? '没有更多数据~' : '正在加载...' }}
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss">
page {
  height: 100%;
  background-color: #f4f4f4;
}

.viewport {
  display: flex;
  flex-direction: column;
  height: 100%;
  padding: 180rpx 0 0;
  position: relative;
}

.cover {
  width: 750rpx;
  height: 180rpx;
  border-radius: 0 0 40rpx 40rpx;
  overflow: hidden;
  position: absolute;
  left: 0;
  top: 0;
  background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
  
  > image {
    width: 100%;
    height: 100%;
    opacity: 0.3;
  }
  
  .cover-content {
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: #fff;
    
    .cover-title {
      font-size: 32rpx;
      font-weight: bold;
      margin-bottom: 8rpx;
    }
    
    .cover-subtitle {
      font-size: 24rpx;
      opacity: 0.9;
    }
  }
}

.tabs {
  display: flex;
  justify-content: space-evenly;
  height: 100rpx;
  line-height: 90rpx;
  margin: 0 20rpx;
  font-size: 28rpx;
  border-radius: 10rpx;
  box-shadow: 0 4rpx 5rpx rgba(200, 200, 200, 0.3);
  color: #333;
  background-color: #fff;
  position: relative;
  z-index: 9;
  
  .text {
    margin: 0 20rpx;
    position: relative;
  }
  
  .active {
    color: #ff6b6b;
    font-weight: 600;
    
    &::after {
      content: '';
      width: 40rpx;
      height: 4rpx;
      transform: translate(-50%);
      background-color: #ff6b6b;
      position: absolute;
      left: 50%;
      bottom: 24rpx;
      border-radius: 2rpx;
    }
  }
}

.scroll-view {
  flex: 1;
  padding: 20rpx;
}

.goods-list {
  .goods-item {
    display: flex;
    align-items: center;
    background: #fff;
    border-radius: 16rpx;
    padding: 20rpx;
    margin-bottom: 16rpx;
    box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);
    position: relative;
    transition: transform 0.2s ease;
    
    &:active {
      transform: scale(0.98);
    }
  }
}

.goods-image {
  width: 140rpx;
  height: 140rpx;
  border-radius: 12rpx;
  overflow: hidden;
  margin-right: 20rpx;
  flex-shrink: 0;
  background-color: #f8f8f8;
  
  > image {
    width: 100%;
    height: 100%;
    display: block;
  }
}

.goods-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 140rpx;
  padding-right: 80rpx;
  
  .goods-name {
    font-size: 28rpx;
    color: #333;
    font-weight: 500;
    line-height: 1.4;
    margin-bottom: 8rpx;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
  }
  
  .goods-price {
    display: flex;
    align-items: baseline;
    margin-bottom: 8rpx;
    
    .price-symbol {
      font-size: 24rpx;
      color: #ff4444;
      margin-right: 2rpx;
    }
    
    .price-value {
      font-size: 32rpx;
      color: #ff4444;
      font-weight: bold;
    }
  }
  
  .goods-sales {
    font-size: 24rpx;
    color: #999;
  }
}

.rank-number {
  position: absolute;
  right: 20rpx;
  top: 50%;
  transform: translateY(-50%);
  width: 60rpx;
  height: 60rpx;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28rpx;
  font-weight: bold;
  color: #fff;
  background: linear-gradient(135deg, #999, #666);
  
  &.rank-top3 {
    width: 70rpx;
    height: 70rpx;
    font-size: 32rpx;
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.2);
  }
  
  &.rank-1 {
    background: linear-gradient(135deg, #ffd700, #ffed4e);
    color: #b8860b;
    animation: goldShine 2s infinite;
  }
  
  &.rank-2 {
    background: linear-gradient(135deg, #c0c0c0, #e8e8e8);
    color: #666;
  }
  
  &.rank-3 {
    background: linear-gradient(135deg, #cd7f32, #daa55a);
    color: #8b4513;
  }
}

.loading-text {
  text-align: center;
  font-size: 28rpx;
  color: #666;
  padding: 20rpx 0 50rpx;
}

@keyframes goldShine {
  0%, 100% { 
    box-shadow: 0 4rpx 12rpx rgba(255, 215, 0, 0.3); 
  }
  50% { 
    box-shadow: 0 6rpx 20rpx rgba(255, 215, 0, 0.6); 
  }
}
</style>