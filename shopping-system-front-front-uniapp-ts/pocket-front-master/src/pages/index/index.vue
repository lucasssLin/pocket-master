<script setup lang="ts">
import PocketSwiper from '@/components/PocketSwiper.vue';
import CustomNNavBar from './components/CustomNavbar.vue'

import { getHomeBannerAPI, getHomeCategoryAPI, getHomeHotAPI } from '@/services/home';
import { onLoad } from '@dcloudio/uni-app';
import { ref } from 'vue';
import type { BannerItem, CategoryItem, HotItem } from '@/types/home';

import CategoryPanel from './components/CategoryPanel.vue'

import HotPanel from './components/HotPanel.vue'
import type { PocketCustomerRecInstance } from '@/types/component'

import PageSkeleton from './components/PageSkeleton.vue';


//获取轮播图数据
const bannerList = ref<BannerItem[]>([])
const getHomeBannerData = async () => {
  const response = await getHomeBannerAPI()
  bannerList.value = response.data
}


//获取前台分类数据
const categoryList = ref<CategoryItem[]>([])
const getHomeCategoryData = async () => {
  const response = await getHomeCategoryAPI()
  categoryList.value = response.data

}

//获取热门推荐数据
const hotList = ref<HotItem[]>([])
const getHomeHotData = async () => {
  const response = await getHomeHotAPI()
  hotList.value = response.data
}

//下拉加载更多
const customerRecRef = ref<PocketCustomerRecInstance>()
const onScrollToLower = () => {
  customerRecRef.value?.getHomeCustomerRecData()
}

//自定义下拉刷新被触发
const isTrigered = ref(false)

const onRefresh = async () => {
  //console.log('下拉刷新被触发')
  isTrigered.value = true
  //重置猜你喜欢数据
  customerRecRef.value?.resetData()

  await Promise.all([getHomeBannerData(), getHomeCategoryData(), getHomeHotData(), customerRecRef.value?.getHomeCustomerRecData()])

  isTrigered.value = false
}

//是否加载中标记
const isLoading = ref(false)

onLoad(async () => {
  isLoading.value = true

  await Promise.all([getHomeBannerData(), getHomeCategoryData(), getHomeHotData()])

  isLoading.value = false
})

</script>




<template>
  <!--自定义导航栏-->
  <CustomNNavBar />

  <!--滚动容器-->
  <scroll-view refresher-enabled="true" @refresherrefresh="onRefresh" :refresher-triggered="isTrigered"
    @scrolltolower="onScrollToLower" class="scroll-view" scroll-y>

    <!--骨架图-->
    <PageSkeleton v-if="isLoading" />

    <template v-else>

      <!--轮播图-->
      <PocketSwiper :list="bannerList" />

      <!--分类面板-->
      <CategoryPanel :list="categoryList" />

      <!--热门推荐-->
      <HotPanel :list="hotList" />

      <!--猜你喜欢-->
      <PocketCustomerRec ref="customerRecRef" />

    </template>



  </scroll-view>



</template>

<style lang="scss">
page {
  background-color: #F7F7F7;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.scroll-view {
  flex: 1;
}
</style>
