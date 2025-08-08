<script setup lang="ts">
import { getMemberProfileAPI } from '@/services/profile';
import { onLoad } from '@dcloudio/uni-app';
import { ref } from 'vue';
import type{ ProfileDetail, UpdateUserInfoParams } from '@/types/member'
import { putMemberProfileAPI } from '@/services/profile'
import { useMemberStore } from '@/stores/modules/member'
type Gender = 0 | 1 | 2;
// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

const form = ref<UpdateUserInfoParams>({
  nickName: '',
  gender: 0,
  birthday: '',
  fullLocation: '',
  provinceCode: '',
  cityCode: '',
  countyCode: '',
  profession: '',
})


// 获取用户信息
//修改个人信息时，需要提供初始值
const profile = ref<ProfileDetail>({} as ProfileDetail)
const getMemberProfileData = async() => {
  const response = await getMemberProfileAPI()
  profile.value = response.data

  form.value = {
    nickName: profile.value.nickName || '',
    gender: profile.value.gender || 0,
    birthday: profile.value.birthday || '',
    fullLocation: profile.value.fullLocation || '',
    provinceCode: profile.value.provinceCode || '',
    cityCode: profile.value.cityCode || '',
    countyCode: profile.value.countyCode || '',
    profession: profile.value.profession || '',
  }
  fullLocationCode = [
    profile.value.provinceCode || '',
    profile.value.cityCode || '',
    profile.value.countyCode || ''
  ]
}

const memberstore = useMemberStore()

// 头像点击事件
const onAvatarChange =()=>{
  // 调用选择/拍照
  uni.chooseMedia({
    count: 1,
    mediaType: ['image'],
    success:(res)=>{
      //本地路径
      const {tempFilePath} = res.tempFiles[0]
      // 上传图片
      uni.uploadFile({
        url: '/member/profile/avatar',
        name: 'file',
        filePath: tempFilePath,
        success:(res)=>{
          if(res.statusCode === 200){
            // 提取头像
            const avatar = JSON.parse(res.data).result.avatar
            // 当前页面更新头像
            profile.value!.avatar = avatar 
            // 全局更新头像
            memberstore.profile!.avatar = avatar

            uni.showToast({ icon: 'success', title: '更新成功' })
          }else {
            uni.showToast({ icon: 'error', title: '出现错误' })
          }
        },
      })
    },
  })
}

// 用户性别
const onGenderChange:UniHelper.RadioGroupOnChange=(event)=>{
  //console.log(event.detail.value)
  let genderValue: Gender = 0; // 默认未知
  const selectedValue = event.detail.value;

  if (selectedValue === '1') {
    genderValue = 1;
  } else if (selectedValue === '2') {
    genderValue = 2;
  }
  form.value.gender = genderValue;
}

// 生日
const onBirthdayChange:UniHelper.DatePickerOnChange = (event)=>{
  //console.log(event.detail.value)
  form.value.birthday = event.detail.value
}

// 城市选择
let fullLocationCode:[string,string,string] = ['','','']
const onFullLocationChange:UniHelper.RegionPickerOnChange = (event)=>{
  //console.log(event.detail.value)
  //修改前端界面
  form.value.fullLocation = event.detail.value.join(' ') 
  //提交后端更新
  fullLocationCode = event.detail.code!
}



// 提交表单
const onSubmit = async() => {
  const provinceCode = fullLocationCode[0] || form.value.provinceCode
  const cityCode = fullLocationCode[1] || form.value.cityCode 
  const countyCode = fullLocationCode[2] || form.value.countyCode

  const response = await putMemberProfileAPI({
    nickName: form.value?.nickName,
    gender: form.value.gender,
    birthday: form.value.birthday,
    provinceCode,
    cityCode,
    countyCode,
    profession: form.value.profession,
    fullLocation: form.value.fullLocation,
  })
  //更新store里面的昵称
  memberstore.profile!.nickName = form.value?.nickName
  uni.showToast({ icon: 'success', title: 'Update Success' })
  setTimeout(() => {
    uni.navigateBack()
  }, 400)
}





onLoad(()=>{
  getMemberProfileData()
})



</script>

<template>
  <view class="viewport">
    <!-- 导航栏 -->
    <view class="navbar" :style="{ paddingTop: safeAreaInsets?.top + 'px' }">
      <navigator open-type="navigateBack" class="back icon-left" hover-class="none"></navigator>
      <view class="title">Personal Info</view>
    </view>
    <!-- 头像 -->
    <view class="avatar">
      <view class="avatar-content" @tap="onAvatarChange">
        <image class="image" :src="profile?.avatar" mode="aspectFill" />
        <text class="text">Click to change</text>
      </view>
    </view>
    <!-- 表单 -->
    <view class="form">
      <!-- 表单内容 -->
      <view class="form-content">
        <view class="form-item">
          <text class="label">Account</text>
          <text class="account">{{profile?.phone}}</text>
        </view>
        <view class="form-item">
          <text class="label">Nickname</text>
          <input class="input" type="text" placeholder="Enter nickname" v-model="form!.nickName" />
        </view>
        <view class="form-item">
          <text class="label">Gender</text>
          <radio-group @change="onGenderChange">
            <label class="radio">
              <radio value="1" color="#27ba9b" :checked="form?.gender === 1" />
              Male
            </label>
            <label class="radio">
              <radio value="2" color="#27ba9b" :checked="form?.gender === 2" />
              Female
            </label>
          </radio-group>
        </view>
        <view class="form-item">
          <text class="label">Birth</text>
          <picker
            @change="onBirthdayChange"
            class="picker"
            mode="date"
            start="1900-01-01"
            :end="new Date()"
            :value="form?.birthday"
          >
            <view v-if="form?.birthday">{{form?.birthday}}</view>
            <view class="placeholder" v-else>Select date</view>
          </picker>
        </view>
        <view class="form-item">
          <text class="label">City</text>
          <picker class="picker" mode="region" :value="form?.fullLocation?.split(' ')" @change="onFullLocationChange">
            <view v-if="form?.fullLocation">{{form?.fullLocation}}</view>
            <view class="placeholder" v-else>Select city</view>
          </picker>
        </view>
        <view class="form-item">
          <text class="label">Occupation</text>
          <input class="input" type="text" placeholder="Select occupation" v-model="form.profession" />
        </view>
      </view>
      <!-- 提交按钮 -->
      <button class="form-button" @tap="onSubmit">Submit</button>
    </view>
  </view>
</template>

<style lang="scss">
page {
  background-color: #f4f4f4;
}

.viewport {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-image: url('@/static/images/navigator_bg.png');
  background-size: auto 420rpx;
  background-repeat: no-repeat;
}

/*导航栏
*/
.navbar {
  position: relative;

  .title {
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    font-weight: 500;
    color: #000000;
  }

  .back {
    position: absolute;
    height: 40px;
    width: 40px;
    left: 0;
    font-size: 20px;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
  }
}

/*头像
*/
.avatar {
  text-align: center;
  width: 100%;
  height: 260rpx;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

  .image {
    width: 160rpx;
    height: 160rpx;
    border-radius: 50%;
    background-color: #eee;
  }

  .text {
    display: block;
    padding-top: 20rpx;
    line-height: 1;
    font-size: 26rpx;
    color: #000000;
  }
}

/* 表单
*/
.form {
  background-color: #f4f4f4;

  &-content {
    margin: 20rpx 20rpx 0;
    padding: 0 20rpx;
    border-radius: 10rpx;
    background-color: #fff;
  }

  &-item {
    display: flex;
    height: 96rpx;
    line-height: 46rpx;
    padding: 25rpx 10rpx;
    background-color: #fff;
    font-size: 28rpx;
    border-bottom: 1rpx solid #ddd;

    &:last-child {
      border: none;
    }

    .label {
      width: 180rpx;
      color: #333;
    }

    .account {
      color: #666;
    }

    .input {
      flex: 1;
      display: block;
      height: 46rpx;
    }

    .radio {
      margin-right: 20rpx;
    }

    .picker {
      flex: 1;
    }
    .placeholder {
      color: #808080;
    }
  }

  &-button {
    height: 80rpx;
    text-align: center;
    line-height: 80rpx;
    margin: 30rpx 20rpx;
    color: #fff;
    border-radius: 80rpx;
    font-size: 30rpx;
    background-color: #e06c6c;
  }
}
</style>