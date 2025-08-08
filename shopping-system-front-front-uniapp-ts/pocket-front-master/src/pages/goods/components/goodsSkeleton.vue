
<template name="skeleton">
  <view class="sk-container">
    <view is="components/vk-data-goods-sku-popup/vk-data-goods-sku-popup" class="r r"></view>
    <scroll-view scroll-y="true" class="viewport viewport" enable-back-to-top="true">
      <view class="goods goods">
        <view class="preview preview">
          <swiper circular="true" current="0" autoplay="false">
            <swiper-item style="position: absolute; width: 100%; height: 100%; transform: translate(0%, 0px) translateZ(0px);">
              <image mode="aspectFill" class="sk-image"></image>
            </swiper-item>
          </swiper>
          <view class="indicator indicator">
            <text class="current sk-transparent sk-opacity">1</text>
            <text class="split sk-transparent sk-opacity">/</text>
            <text class="total sk-transparent sk-opacity">4</text>
          </view>
        </view>
        <view class="meta meta">
          <view class="price price">
            <text class="symbol sk-transparent sk-opacity">¥</text>
            <text class="number sk-transparent sk-text-14-2857-342 sk-text">150</text>
          </view>
          <view class="name ellipsis sk-transparent sk-text-14-2857-372 sk-text">钻石陶瓷涂层多用锅18cm 小奶锅</view>
          <view class="desc sk-transparent sk-text-0-0000-291 sk-text">安全耐用，易于清洗APP</view>
        </view>
        <view class="action action">
          <view class="item arrow sk-pseudo sk-pseudo-circle">
            <text class="label sk-transparent sk-text-14-2857-949 sk-text">选择</text>
            <text class="text ellipsis sk-transparent sk-text-14-2857-461 sk-text">请选择商品规格</text>
          </view>
          <view class="item arrow sk-pseudo sk-pseudo-circle">
            <text class="label sk-transparent sk-text-14-2857-993 sk-text">送至</text>
            <text class="text ellipsis sk-transparent sk-text-14-2857-734 sk-text">请选择收获地址</text>
          </view>
          <view class="item arrow sk-pseudo sk-pseudo-circle">
            <text class="label sk-transparent sk-text-14-2857-773 sk-text">服务</text>
            <text class="text ellipsis sk-transparent sk-text-14-2857-895 sk-text"> 无忧退 快速退款 免费包邮 </text>
          </view>
        </view>
      </view>
      <view class="detail detail panel panel">
        <view class="title title">
          <text class="sk-transparent sk-text-0-0000-831 sk-text">详情</text>
        </view>
        <view class="content content">
          <view class="properties properties">
            <view class="item item">
              <text class="label sk-transparent sk-text-25-0000-614 sk-text">执行标准</text>
              <text class="value sk-transparent sk-text-25-0000-125 sk-text">GB4706.1 - 2005</text>
            </view>
          </view>
        </view>
      </view>
    </scroll-view>
    <view class="toolbar toolbar" style="padding-bottom:34px">
      <view class="icons icons">
        <button class="icons-button sk-transparent sk-button sk-pseudo sk-pseudo-circle">
          <text class="icon-heart sk-pseudo sk-pseudo-circle"></text>收藏</button>
        <button class="icons-button sk-transparent sk-button sk-pseudo sk-pseudo-circle" open-type="contact">
          <text class="icon-handset sk-pseudo sk-pseudo-circle"></text>客服 </button>
        <navigator class="icons-button sk-transparent" open-type="navigate">
          <text class="icon-cart sk-pseudo sk-pseudo-circle"></text>购物车 </navigator>
      </view>
      <view class="buttons buttons">
        <view class="addcart sk-transparent sk-text-32-4324-53 sk-text" style="background-position-x: 50%;"> 加入购物车 </view>
        <view class="buynow sk-transparent sk-text-32-4324-262 sk-text" style="background-position-x: 50%;"> 立即购买 </view>
      </view>
    </view>
  </view>
</template>

  <style>

.sk-transparent {
    color: transparent !important;
  }
.sk-opacity {
    opacity: 0 !important;
  }
.sk-text-14-2857-781 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 78.1395rpx;
    position: relative !important;
  }
.sk-text {
    background-origin: content-box !important;
    background-clip: content-box !important;
    background-color: transparent !important;
    color: transparent !important;
    background-repeat: repeat-y !important;
  }
.sk-text-14-2857-695 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 43.9535rpx;
    position: relative !important;
  }
.sk-text-0-0000-222 {
    background-image: linear-gradient(transparent 0.0000%, #EEEEEE 0%, #EEEEEE 100.0000%, transparent 0%) !important;
    background-size: 100% 22.6744rpx;
    position: relative !important;
  }
.sk-text-14-2857-66 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-728 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-978 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-981 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-213 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-14-2857-371 {
    background-image: linear-gradient(transparent 14.2857%, #EEEEEE 0%, #EEEEEE 85.7143%, transparent 0%) !important;
    background-size: 100% 34.1860rpx;
    position: relative !important;
  }
.sk-text-0-0000-639 {
    background-image: linear-gradient(transparent 0.0000%, #EEEEEE 0%, #EEEEEE 100.0000%, transparent 0%) !important;
    background-size: 100% 27.9070rpx;
    position: relative !important;
  }
.sk-text-25-0000-165 {
    background-image: linear-gradient(transparent 25.0000%, #EEEEEE 0%, #EEEEEE 75.0000%, transparent 0%) !important;
    background-size: 100% 48.8372rpx;
    position: relative !important;
  }
.sk-text-25-0000-916 {
    background-image: linear-gradient(transparent 25.0000%, #EEEEEE 0%, #EEEEEE 75.0000%, transparent 0%) !important;
    background-size: 100% 48.8372rpx;
    position: relative !important;
  }
.sk-text-32-9268-984 {
    background-image: linear-gradient(transparent 32.9268%, #EEEEEE 0%, #EEEEEE 67.0732%, transparent 0%) !important;
    background-size: 100% 71.5116rpx;
    position: relative !important;
  }
.sk-text-32-9268-381 {
    background-image: linear-gradient(transparent 32.9268%, #EEEEEE 0%, #EEEEEE 67.0732%, transparent 0%) !important;
    background-size: 100% 71.5116rpx;
    position: relative !important;
  }
.sk-button {
    color: #EFEFEF !important;
    background: #EFEFEF !important;
    border: none !important;
    box-shadow: none !important;
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