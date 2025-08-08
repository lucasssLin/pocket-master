<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { onLoad } from '@dcloudio/uni-app';
import { getCollectedListAPI } from '@/services/collect';
import type { PageParams } from '@/types/global';
import type { CollectedItem } from "@/types/collect"
import {cancelCollectProductAPI} from '@/services/goods';


// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync();

// 请求参数
const queryParams = ref<PageParams>({
  page: 1,
  pageSize: 10
});

// 收藏列表
const favoriteList = ref<CollectedItem[]>([]);

// 加载状态
const isLoading = ref(false);
// 是否还有更多数据
const hasMore = ref(true);
// 已结束标记
const finish = ref(false);

// 获取收藏列表数据
const getFavoriteData = async() => {
  if (isLoading.value || !hasMore.value) return;
  if (finish.value) {
    return uni.showToast({ icon: 'none', title: '没有更多数据' });
  }
  isLoading.value = true;
  try {
    const response = await getCollectedListAPI(queryParams.value);
    
    // 检查返回数据的结构
    console.log('API Response:', response);
    
    // 正确处理API返回的数据结构
    const newFavorites = response.rows || [];
    // 如果API直接返回了完整的响应而不是包装在data属性中
    favoriteList.value = [...favoriteList.value, ...newFavorites];
    
    // 判断是否还有更多数据
    hasMore.value = newFavorites.length === queryParams.value.pageSize;
    if (hasMore.value) {
      queryParams.value.page++;
    } else {
      finish.value = true;
    }
  } catch (error) {
    console.error('获取收藏数据失败:', error);
    uni.showToast({ icon: 'none', title: '获取收藏数据失败' });
  } finally {
    isLoading.value = false;
  }
};

// 滚动到底部触发加载更多
const onScrollToLower = () => {
  getFavoriteData();
};

// 下拉刷新状态
const isTrigered = ref(false);
// 下拉刷新方法
const onRefresh = async () => {
  isTrigered.value = true;
  // 重置分页参数
  queryParams.value.page = 1;
  hasMore.value = true;
  finish.value = false;
  favoriteList.value = []; // 清空当前列表
  try {
    const response = await getCollectedListAPI(queryParams.value);
    // 正确处理API返回的数据结构
    favoriteList.value = response.rows || [];
    
    // 判断是否还有更多数据
    hasMore.value = favoriteList.value.length === queryParams.value.pageSize;
    if (hasMore.value) {
      queryParams.value.page++;
    } else {
      finish.value = true;
    }
  } catch (error) {
    console.error('下拉刷新失败:', error);
  } finally {
    isTrigered.value = false;
  }
};

// 取消收藏
const onCancelCollect = async (id: number) => {
  uni.showModal({
    content: '确认取消收藏该商品？',
    success: async (success) => {
      if (success.confirm) {
        try {
          // TODO: 实现取消收藏API调用
          await cancelCollectProductAPI(String(id));
          // 模拟API调用成功
          setTimeout(() => {
            // 显示取消成功提示
            uni.showToast({ icon: 'success', title: '取消收藏成功' });
            // 从列表中移除该商品
            favoriteList.value = favoriteList.value.filter(item => item.id !== id);
          }, 500);
        } catch (error) {
          // 显示取消失败提示
          console.error('取消收藏失败:', error);
          uni.showToast({ icon: 'none', title: '取消收藏失败' });
        }
      }
    },
  });
};

// 跳转到商品详情
const goToDetail = (spuId: number) => {
  uni.navigateTo({
    url: `/pages/goods/goods?id=${spuId}`
  });
};

// 页面加载时获取数据
onLoad(() => {
  getFavoriteData();
  
});
</script>

<template>
  <view class="viewport">
    <scroll-view 
      scroll-y 
      refresher-enabled="true"
      @refresherrefresh="onRefresh"
      :refresher-triggered="isTrigered"
      class="favorites" 
      id="scroller" 
      @scrolltolower="onScrollToLower"
    >
      <!-- 收藏列表为空时显示 -->
      <view class="empty" v-if="favoriteList.length === 0">
        <text class="empty-text">暂无收藏商品</text>
        <navigator url="/pages/index/index" hover-class="none" class="button primary">
          去逛逛
        </navigator>
      </view>
      
      <!-- 收藏列表 -->
      <view class="card" v-for="item in favoriteList" :key="item.id">
        <!-- 收藏时间 -->
        <view class="status">
          <text class="date">{{item.updateTime}}</text>
          <text class="collect-status">已收藏</text>
        </view>
        
        <!-- 商品信息 -->
        <view class="goods" @tap="goToDetail(item.spuId)">
          <view class="cover">
            <image mode="aspectFit" :src="item.thumbImg"></image>
          </view>
          <view class="meta">
            <view class="name ellipsis">{{item.spuName}}</view>
            <view class="price">
              <text class="symbol">¥</text>{{item.salePrice.toFixed(2)}}
            </view>
          </view>
        </view>
        
        <!-- 操作按钮 -->
        <view class="action">
          <view class="button secondary" @tap="goToDetail(item.spuId)">查看详情</view>
          <view class="button primary" @tap="onCancelCollect(item.spuId)">取消收藏</view>
        </view>
      </view>
      
      <!-- 底部提示文字 -->
      <view class="loading-text" :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }">
        {{ hasMore ? '正在加载...' : '没有更多数据~' }}
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss">
page {
  height: 100%;
  background-color: #f7f7f8;
}

.viewport {
  height: 100%;
}

.favorites {
  height: 100%;
  
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
    
    .collect-status {
      color: #cf4261;
    }
  }

  .goods {
    display: flex;
    margin-bottom: 20rpx;
    border-bottom: 1rpx solid #eee;
    padding-bottom: 20rpx;
    
    .cover {
      width: 170rpx;
      height: 170rpx;
      margin-right: 20rpx;
      border-radius: 10rpx;
      overflow: hidden;
      background-color: #f5f5f5;
    }
    
    .meta {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 10rpx 0;
    }
    
    .name {
      font-size: 28rpx;
      color: #333;
      line-height: 1.5;
      margin-bottom: 60rpx;
    }
    
    .price {
      font-size: 32rpx;
      color: #cf4261;
      
      .symbol {
        font-size: 24rpx;
      }
    }
  }

  .action {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding-top: 10rpx;
    
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

/* 空收藏列表样式 */
.empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-top: 200rpx;
  
  .empty-image {
    width: 220rpx;
    height: 220rpx;
    margin-bottom: 30rpx;
  }
  
  .empty-text {
    font-size: 28rpx;
    color: #999;
    margin-bottom: 40rpx;
  }
  
  .button {
    width: 200rpx;
    height: 70rpx;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 35rpx;
    font-size: 28rpx;
    
    &.primary {
      background-color: #cf4261;
      color: #fff;
    }
  }
}

/* 文本省略 */
.ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
</style>