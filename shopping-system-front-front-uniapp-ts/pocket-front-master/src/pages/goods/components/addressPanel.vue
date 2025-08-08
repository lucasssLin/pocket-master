<script setup lang="ts">
import type { AddressItem } from '@/types/address'
import { ref, onMounted } from 'vue';
import { getMemberAddressAPI } from '@/services/address';

//子调父
const emit = defineEmits<{
  (event:'close'):void
  (event: 'confirm', selectedAddress: AddressItem): void
}>()

// 定义接收的地址列表属性
// const props = defineProps<{
//   addressList: AddressItem[]
// }>();

const addressList = ref<AddressItem[]>([])
const getMemberAddressData=async()=>{
  const response = await getMemberAddressAPI()
  //console.log(response)
  addressList.value = response.data
}

// 记录当前选中的地址 ID
const selectedAddressId = ref<string | null>(null);
// 处理地址勾选事件
const onSelectAddress = (id: string) => {
  selectedAddressId.value = id;
};

const onConfirm = () => {
  if(selectedAddressId.value){
    const selectedAddress = addressList.value.find((item: AddressItem)=>item.id ===selectedAddressId.value)
  
    if (selectedAddress) {
        // 触发确认事件并传递选中的地址
        emit('confirm', selectedAddress);
    }
  }  
  emit('close');
};

onMounted(() => {
  getMemberAddressData()
  const defaultAddress = addressList.value.find((item: AddressItem) => item.isDefault === 1);
  if (defaultAddress) {
    selectedAddressId.value = defaultAddress.id;
  }
  
});

</script>

<template>
  <view class="address-panel">
    <!-- 关闭按钮 -->
    <text class="close icon-close" @tap="emit('close')"></text>
    <!-- 标题 -->
    <view class="title">配送至</view>
    <!-- 内容 -->
    <view class="content">
      <view class="item" v-for="item in addressList" :key="item.id">
        <view class="user">{{item.receiver}} {{item.contact}}</view>
        <view class="address">{{ item.fullLocation }} {{ item.address }}</view>
        <text class="icon"
        :class="{ 'icon-checked': selectedAddressId === item.id, 'icon-ring': selectedAddressId !== item.id }"
        @tap="onSelectAddress(item.id)"
        ></text>
      </view>

    </view>
    <view class="footer">
      <navigator
      class="shipment"
      hover-class="none"
      url="/pagesMember/address/address?from=order"
      >
        <view class="button primary"> 新建地址 </view>
      </navigator>  
      <view v-if="selectedAddressId" class="button primary"  @tap="onConfirm">确定</view>
    </view>
  </view>
</template>

<style lang="scss">
.address-panel {
  padding: 0 30rpx;
  border-radius: 10rpx 10rpx 0 0;
  position: relative;
  background-color: #fff;
}

.title {
  line-height: 1;
  padding: 40rpx 0;
  text-align: center;
  font-size: 32rpx;
  font-weight: normal;
  border-bottom: 1rpx solid #ddd;
  color: #444;
}

.close {
  position: absolute;
  right: 24rpx;
  top: 24rpx;
}

.content {
  min-height: 300rpx;
  max-height: 540rpx;
  overflow: auto;
  padding: 20rpx;
  .item {
    padding: 30rpx 50rpx 30rpx 60rpx;
    background-size: 40rpx;
    background-repeat: no-repeat;
    background-position: 0 center;
    background-image: url('@/static/images/address.png');
    position: relative;
  }
  .icon {
    color: #999;
    font-size: 40rpx;
    transform: translateY(-50%);
    position: absolute;
    top: 50%;
    right: 0;
  }
  .icon-checked {
    color: #cf4261;
  }
  .icon-ring {
    color: #444;
  }
  .user {
    font-size: 28rpx;
    color: #444;
    font-weight: 500;
  }
  .address {
    font-size: 26rpx;
    color: #666;
  }
}

.footer {
  display: flex;
  justify-content: space-between;
  padding: 20rpx 0 40rpx;
  font-size: 28rpx;
  color: #444;

  .shipment {
    flex: 1;
    margin: 0 20rpx;
  }

  .button {
    flex: 1;
    height: 72rpx;
    text-align: center;
    line-height: 72rpx;
    margin: 0 20rpx;
    color: #fff;
    border-radius: 72rpx;
  }

  .primary {
    color: #fff;
    background-color: #cf4261;
  }

  .secondary {
    background-color: #ffa868;
  }
}
</style>