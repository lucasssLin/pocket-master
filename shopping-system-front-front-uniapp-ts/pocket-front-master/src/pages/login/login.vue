<script setup lang="ts">
import { ref } from 'vue';
import { onLoad } from '@dcloudio/uni-app';
import { postLoginAPI, postSendCodeAPI } from '@/services/login';
import { useMemberStore } from '@/stores';
import type { LoginResult } from '@/types/member';

// Form data
const formData = ref({
  username: '',
  password: ''
});

// Error messages
const errorMsg = ref('');

// Loading state
const isLoading = ref(false);

// Password visibility toggle
const showPassword = ref(false);
const togglePasswordVisibility = () => {
  showPassword.value = !showPassword.value;
};

// Form validation
const validateForm = (): boolean => {
  // Reset error message
  errorMsg.value = '';

  // Validate username (phone number)
  if (!formData.value.username) {
    errorMsg.value = 'Username/Phone must be entered';
    return false;
  }
  if (formData.value.username.length !== 11) {
    errorMsg.value = 'Username length must be 11 characters';
    return false;
  }

  // Validate password
  if (!formData.value.password) {
    errorMsg.value = 'Password must be entered';
    return false;
  }
  if (formData.value.password.length < 5 || formData.value.password.length > 20) {
    errorMsg.value = 'The password must be between 5 and 20 characters long';
    return false;
  }

  return true;
};

// Login handler
const handleLogin = async () => {
  if (!validateForm()) return;
  
  try {
    isLoading.value = true;
    const response = await postLoginAPI({
      username: formData.value.username,
      password: formData.value.password
    });
    
    if(response.code !== 200) {
      uni.showToast({
        icon: 'none',
        title: (response.msg || 'Registration failed'),
      })
      isLoading.value = false;
      return;
    }

    // Handle login success
    loginSuccess(response.data);
  } catch (error: any) {
    errorMsg.value = error.message || 'Login failed. Please try again.';
  } finally {
    isLoading.value = false;
  }
};

// WeChat login code
let wxCode = '';
onLoad(async () => {
  try {
    // Get WeChat login code
    const response = await wx.login();
    wxCode = response.code;
  } catch (error) {
    console.error('Failed to get WeChat login code:', error);
  }
});




// Handle successful login
const loginSuccess = (profile: LoginResult) => {
  // Save member information
  const memberStore = useMemberStore();
  memberStore.setProfile(profile);
  
  // Success notification
  uni.showToast({ icon: 'success', title: 'Login Success' });
  
  setTimeout(() => {
    // Navigate back or to home page
    uni.navigateBack();
  }, 500);
};

// Navigate to register page
const goToRegister = () => {
  uni.navigateTo({
    url: "/pages/register/register"
  });
};
</script>

<template>
  <view class="viewport">
    <view class="logo">
      <image src="/static/images/logo1.png"></image>
    </view>
    
    <view class="login">
      <!-- Error message display -->
      <view class="error-message" v-if="errorMsg">
        {{ errorMsg }}
      </view>
      
      <!-- Phone/Username input -->
      <view class="input-group">
        <text class="icon icon-phone"></text>
        <input 
          class="input" 
          type="text" 
          maxlength="11"
          placeholder="Please enter phone number" 
          v-model="formData.username"
        />
      </view>
      
      <!-- Password input -->
      <view class="input-group">
        <text class="icon icon-lock"></text>
        <input 
          class="input" 
          :type="showPassword ? 'text' : 'password'" 
          placeholder="Please enter password" 
          v-model="formData.password"
        />
        <text 
          class="icon icon-eye" 
          :class="showPassword ? 'icon-eye-active' : ''" 
          @tap="togglePasswordVisibility"
        ></text>
      </view>
      
      <!-- Login button -->
      <button 
        class="button phone" 
        :disabled="isLoading" 
        @tap="handleLogin"
      >
        <text v-if="isLoading">Logging in...</text>
        <text v-else>Login</text>
      </button>
      
      <!-- Register link -->
      <view class="register-link">
        <text @tap="goToRegister">No account? Register now</text>
      </view>

      
      <view class="tips">
        By logging in/registering, you agree to the Terms of Service and Privacy Policy
      </view>
    </view>
  </view>
</template>

<style lang="scss">
page {
  height: 100%;
}

.viewport {
  display: flex;
  flex-direction: column;
  height: 100%;
  padding: 20rpx 40rpx;
  background-color: #f5f5f5;
}

.logo {
  flex: 1;
  text-align: center;
  
  image {
    width: 220rpx;
    height: 220rpx;
    margin-top: 15vh;
  }
}

.login {
  display: flex;
  flex-direction: column;
  height: 60vh;
  padding: 40rpx 20rpx 20rpx;
  
  .error-message {
    color: #e74c3c;
    font-size: 28rpx;
    text-align: center;
    margin-bottom: 20rpx;
    padding: 10rpx;
    background-color: rgba(231, 76, 60, 0.1);
    border-radius: 8rpx;
  }
  
  .input-group {
    display: flex;
    align-items: center;
    width: 100%;
    height: 80rpx;
    border-radius: 72rpx;
    border: 1px solid #ddd;
    padding: 0 30rpx;
    margin-bottom: 20rpx;
    background-color: #fff;
    
    .icon {
      font-size: 40rpx;
      color: #999;
      margin-right: 10rpx;
    }
    
    .input {
      flex: 1;
      height: 80rpx;
      font-size: 28rpx;
    }
    
    .icon-eye-active {
      color: #cf4261;
    }
  }
  
  .button {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 80rpx;
    font-size: 28rpx;
    border-radius: 72rpx;
    color: #fff;
    margin-bottom: 20rpx;
    
    .icon {
      font-size: 40rpx;
      margin-right: 6rpx;
    }
    
    &:disabled {
      opacity: 0.7;
    }
  }
  
  .phone {
    background-color: #cf4261;
  }
  
  .wechat {
    background-color: #cf4261;
  }
  
  .simulation {
    background-color: #3498db;
  }
  
  .register-link {
    text-align: right;
    font-size: 26rpx;
    color: #cf4261;
    margin-bottom: 30rpx;
  }
  
  .extra {
    padding: 40rpx 70rpx 0;
    
    .caption {
      width: 440rpx;
      line-height: 1;
      border-top: 1rpx solid #ddd;
      font-size: 26rpx;
      color: #999;
      position: relative;
      
      text {
        transform: translate(-40%);
        background-color: #f5f5f5;
        position: absolute;
        top: -12rpx;
        left: 50%;
        padding: 0 20rpx;
      }
    }
    
    .options {
      display: flex;
      flex-direction: column;
      gap: 20rpx;
      margin-top: 40rpx;
    }
  }
  
  .tips {
    position: absolute;
    bottom: 80rpx;
    left: 20rpx;
    right: 20rpx;
    font-size: 22rpx;
    color: #999;
    text-align: center;
  }
}
</style>