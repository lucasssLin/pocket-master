<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { onLoad } from '@dcloudio/uni-app';
import { getHistoryListAPI,deleteHistoryProductAPI } from '@/services/browseHistory';
import type { PageParams } from '@/types/global';
import type { BrowseHistoryItem } from '@/types/browseHistory';

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync();

// 请求参数
const queryParams = ref<PageParams>({
  page: 1,
  pageSize: 10
});

// 浏览历史列表
const historyList = ref<BrowseHistoryItem[]>([]);

// 加载状态
const isLoading = ref(false);
// 是否还有更多数据
const hasMore = ref(true);
// 已结束标记
const finish = ref(false);

// 数据过滤和验证函数
const validateHistoryItem = (item: any): item is BrowseHistoryItem => {
  return item && 
         item.id && 
         item.spuId && 
         item.productName && 
         item.salePrice !== null && 
         item.salePrice !== undefined;
};

// 获取浏览历史数据
const getHistoryData = async() => {
  if (isLoading.value || !hasMore.value) return;
  if (finish.value) {
    return uni.showToast({ icon: 'none', title: '没有更多数据' });
  }
  
  isLoading.value = true;
  try {
    const response = await getHistoryListAPI(queryParams.value);
    
    // 检查返回数据的结构
    console.log('API Response:', response);
    
    // 获取原始数据
    const rawData = response.rows || [];
    
    // 过滤掉无效数据（商品已删除或下架的记录）
    const validHistory = rawData.filter(validateHistoryItem);
    
    // 记录过滤掉的无效数据数量
    const filteredCount = rawData.length - validHistory.length;
    if (filteredCount > 0) {
      console.log(`过滤掉 ${filteredCount} 条无效记录`);
    }
    
    // 添加到历史列表
    historyList.value = [...historyList.value, ...validHistory];
    
    // 判断是否还有更多数据的逻辑需要调整
    // 如果原始数据长度等于pageSize，说明可能还有更多数据
    const shouldLoadMore = rawData.length === queryParams.value.pageSize;
    
    if (shouldLoadMore) {
      queryParams.value.page++;
      hasMore.value = true;
      
      // 如果当前页有效数据太少（比如少于3条），自动加载下一页
      if (validHistory.length < 3 && validHistory.length > 0) {
        // 延迟一下再自动加载，避免请求过于频繁
        setTimeout(() => {
          getHistoryData();
        }, 100);
      }
    } else {
      hasMore.value = false;
      finish.value = true;
    }
    
  } catch (error) {
    console.error('获取浏览历史数据失败:', error);
    uni.showToast({ icon: 'none', title: '获取浏览历史数据失败' });
  } finally {
    isLoading.value = false;
  }
};

// 滚动到底部触发加载更多
const onScrollToLower = () => {
  getHistoryData();
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
  historyList.value = [];
  
  try {
    const response = await getHistoryListAPI(queryParams.value);
    const rawData = response.rows || [];
    
    // 过滤无效数据
    const validHistory = rawData.filter(validateHistoryItem);
    historyList.value = validHistory;
    
    // 判断是否还有更多数据
    const shouldLoadMore = rawData.length === queryParams.value.pageSize;
    
    if (shouldLoadMore) {
      queryParams.value.page++;
      hasMore.value = true;
    } else {
      hasMore.value = false;
      finish.value = true;
    }
    
  } catch (error) {
    console.error('下拉刷新失败:', error);
    uni.showToast({ icon: 'none', title: '刷新失败' });
  } finally {
    isTrigered.value = false;
  }
};

// 删除历史记录
const onDeleteHistory = async (id: number) => {
  uni.showModal({
    content: '确认删除该浏览记录？',
    success: async (success) => {
      if (success.confirm) {
        try {
          await deleteHistoryProductAPI(id);
          // 显示删除成功提示
          uni.showToast({ icon: 'success', title: '删除成功' });
          // 从列表中移除该商品
          historyList.value = historyList.value.filter(item => item.id !== id);
        } catch (error) {
          // 显示删除失败提示
          console.error('删除浏览记录失败:', error);
          uni.showToast({ icon: 'none', title: '删除失败' });
        }
      }
    },
  });
};

// 跳转到商品详情
const goToDetail = (spuId: number) => {
  if (!spuId) return;
  uni.navigateTo({
    url: `/pages/goods/goods?id=${spuId}`
  });
};

// 图片加载失败处理
const handleImageError = (e: any) => {
  e.target.src = '/static/images/placeholder.png';
};

// 页面加载时获取数据
onLoad(() => {
  getHistoryData();
});
</script>

<template>
  <view class="viewport">
    <scroll-view 
      scroll-y 
      refresher-enabled="true"
      @refresherrefresh="onRefresh"
      :refresher-triggered="isTrigered"
      class="history" 
      id="scroller" 
      @scrolltolower="onScrollToLower"
    >
      <!-- 浏览历史为空时显示 -->
      <view class="empty" v-if="historyList.length === 0 && !isLoading">
        <text class="empty-text">暂无浏览记录</text>
        <navigator url="/pages/index/index" hover-class="none" class="button primary">
          去逛逛
        </navigator>
      </view>
      
      <!-- 浏览历史列表 -->
      <view 
        class="card" 
        v-for="item in historyList" 
        :key="item.id"
      >
        <!-- 浏览时间 -->
        <view class="status">
          <text class="date">{{ item.updateTime || '未知时间' }}</text>
          <text class="history-status">已浏览</text>
        </view>
        
        <!-- 商品信息 -->
        <view class="goods" @tap="goToDetail(item.spuId)">
          <view class="cover">
            <image 
              mode="aspectFit" 
              :src="item.thumbImg || '/static/images/placeholder.png'"
              @error="handleImageError"
            ></image>
          </view>
          <view class="meta">
            <view class="name ellipsis">{{ item.productName || '商品名称未知' }}</view>
            <view class="price" v-if="item.salePrice !== null && item.salePrice !== undefined">
              <text class="symbol">¥</text>{{ Number(item.salePrice).toFixed(2) }}
            </view>
            <view class="price unavailable" v-else>
              <text>价格暂无</text>
            </view>
          </view>
        </view>
        
        <!-- 操作按钮 -->
        <view class="action">
          <view 
            class="button secondary" 
            @tap="goToDetail(item.spuId)"
          >
            查看详情
          </view>
          <view class="button primary" @tap="onDeleteHistory(item.id)">删除记录</view>
        </view>
      </view>
      
      <!-- 加载状态 -->
      <view class="loading" v-if="isLoading">
        <text>正在加载...</text>
      </view>
      
      <!-- 底部提示文字 -->
      <view 
        class="loading-text" 
        :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }"
        v-if="!isLoading"
      >
        {{ hasMore ? '上拉加载更多' : (historyList.length > 0 ? '没有更多数据~' : '') }}
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

.history {
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
    
    .history-status {
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

/* 空浏览历史样式 */
.empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-top: 200rpx;
  
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

/* 新增样式 - 处理无效数据显示 */
.unavailable {
  opacity: 0.6;
  
  .placeholder {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f0f0f0;
    color: #999;
    font-size: 24rpx;
  }
  
  .price {
    color: #999 !important;
  }
}

.button.disabled {
  background-color: #ccc !important;
  color: #666 !important;
  border-color: #ccc !important;
  pointer-events: none;
}

.loading {
  text-align: center;
  padding: 40rpx 0;
  color: #666;
  font-size: 28rpx;
}
</style>