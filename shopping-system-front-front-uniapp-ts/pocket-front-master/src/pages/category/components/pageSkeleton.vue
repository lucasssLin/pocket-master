
<template name="skeleton">
    <view class="sk-container">
      <view class="viewport viewport">
        <view class="search search">
          <view class="input input">
            <text class="icon-search sk-transparent sk-text-14-2857-979 sk-text sk-pseudo sk-pseudo-circle">女靴</text>
          </view>
        </view>
        <view class="categories categories">
          <scroll-view :scroll-y="true" class="primary primary">
            <view class="item active sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-522 sk-text">居家</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-213 sk-text">美食</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-547 sk-text">服饰</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-607 sk-text">母婴</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-346 sk-text">个护</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-226 sk-text">严选</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-661 sk-text">数码</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-505 sk-text">运动</text>
            </view>
            <view class="item sk-pseudo sk-pseudo-circle">
              <text class="name sk-transparent sk-text-14-2857-660 sk-text">杂项</text>
            </view>
          </scroll-view>
          <scroll-view :scroll-y="true" class="secondary secondary">
            <view is="components/PocketSwiper" class="banner banner">
              <view class="carousel PocketSwiper--carousel">
                <swiper :circular="true" :interval="3000" :current="0" :autoplay="false">
                  <swiper-item style="position: absolute; width: 100%; height: 100%; transform: translate(0%, 0px) translateZ(0px);">
                    <navigator class="navigator PocketSwiper--navigator" hover-class="none">
                      <image class="image PocketSwiper--image sk-image" mode="aspectFill"></image>
                    </navigator>
                  </swiper-item>
                  <swiper-item style="position: absolute; width: 100%; height: 100%; transform: translate(100%, 0px) translateZ(0px);">
                    <navigator class="navigator PocketSwiper--navigator" hover-class="none">
                      <image class="image PocketSwiper--image sk-image" mode="aspectFill"></image>
                    </navigator>
                  </swiper-item>
                </swiper>
                <view class="indicator PocketSwiper--indicator">
                  <text class="dot PocketSwiper--dot active PocketSwiper--active"></text>
                  <text class="dot PocketSwiper--dot"></text>
                  <text class="dot PocketSwiper--dot"></text>
                  <text class="dot PocketSwiper--dot"></text>
                  <text class="dot PocketSwiper--dot"></text>
                </view>
              </view>
            </view>
            <view class="panel panel">
              <view class="title title">
                <text class="name sk-transparent sk-text-26-4706-74 sk-text">居家生活用品</text>
                <navigator class="more sk-transparent sk-text-30-8824-541 sk-text sk-pseudo sk-pseudo-circle" hover-class="none">全部</navigator>
              </view>
              <view class="section section">
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-896 sk-text">极光限定 珠光蓝珐琅锅</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-276 sk-text">199.00</text>
                  </view>
                </navigator>
              </view>
            </view>
            <view class="panel panel">
              <view class="title title">
                <text class="name sk-transparent sk-text-26-4706-374 sk-text">收纳</text>
                <navigator class="more sk-transparent sk-text-30-8824-527 sk-text sk-pseudo sk-pseudo-circle" hover-class="none">全部</navigator>
              </view>
              <view class="section section">
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-863 sk-text">给衣柜减减肥，真空防潮压缩袋</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-792 sk-text">79.00</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-680 sk-text">爆款明星好物，抽屉式透明储物柜</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-839 sk-text">129.00</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-613 sk-text">衣柜省空间神器，棉麻涤·收纳挂袋</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-215 sk-text">55.00</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-969 sk-text">换季好帮手，大容量防尘衣物收纳袋</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-781 sk-text">69.00</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-962 sk-text">可水洗的布艺收纳盒</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-256 sk-text">29.90</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                  <view class="name ellipsis sk-transparent sk-text-14-2857-208 sk-text">开发员自留款，带滚轮双层脏衣篓</view>
                  <view class="price price">
                    <text class="symbol sk-transparent sk-opacity">¥</text>
                    <text class="number sk-transparent sk-text-14-2857-892 sk-text">125.00</text>
                  </view>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                </navigator>
                <navigator class="goods goods" hover-class="none">
                  <image class="image sk-image"></image>
                </navigator>
              </view>
            </view>
          </scroll-view>
        </view>
      </view>
    </view>
  </template>


  <style>

.sk-transparent {
    color: transparent !important;
  }
.sk-text-14-2857-979 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 39.0698rpx;
    position: relative !important;
  }
.sk-text {
    background-origin: content-box !important;
    background-clip: content-box !important;
    background-color: transparent !important;
    color: transparent !important;
    background-repeat: repeat-y !important;
  }
.sk-text-14-2857-522 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-213 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-547 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-607 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-346 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-226 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-661 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-505 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-660 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-26-4706-74 {
    background-image: linear-gradient(transparent 26.4706%, #EEEEEE 0%, #EEEEEE 73.5294%, transparent 0%) !important;
    background-size: 100% 59.3023rpx;
    position: relative !important;
  }
.sk-text-30-8824-541 {
    background-image: linear-gradient(transparent 30.8824%, #EEEEEE 0%, #EEEEEE 69.1176%, transparent 0%) !important;
    background-size: 100% 59.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-896 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-opacity {
    opacity: 0 !important;
  }
.sk-text-14-2857-276 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-26-4706-374 {
    background-image: linear-gradient(transparent 26.4706%, #EEEEEE 0%, #EEEEEE 73.5294%, transparent 0%) !important;
    background-size: 100% 59.3023rpx;
    position: relative !important;
  }
.sk-text-30-8824-527 {
    background-image: linear-gradient(transparent 30.8824%, #EEEEEE 0%, #EEEEEE 69.1176%, transparent 0%) !important;
    background-size: 100% 59.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-863 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-792 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-14-2857-680 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-839 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-14-2857-613 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-215 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-14-2857-969 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-781 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-14-2857-962 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-256 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-text-14-2857-208 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 29.3023rpx;
    position: relative !important;
  }
.sk-text-14-2857-892 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 31.7442rpx;
    position: relative !important;
  }
.sk-image {
    background: #EFEFEF !important;
  }
.sk-pseudo::before, .sk-pseudo::after {
      background: #EFEFEF !important;
      background-image: none !important;
      color: transparent !important;
      border-color: transparent !important;
    }
.sk-pseudo-rect::before, .sk-pseudo-rect::after {
      border-radius: 0 !important;
    }
.sk-pseudo-circle::before, .sk-pseudo-circle::after {
      border-radius: 50% !important;
    }
.sk-container {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    background-color: transparent;
  }


  </style>