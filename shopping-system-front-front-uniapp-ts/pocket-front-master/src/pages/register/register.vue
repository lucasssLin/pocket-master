<script setup lang="ts">
import { ref, computed } from 'vue';
import { postRegisterAPI, postSendCodeAPI } from '@/services/login';

// Form data
const formData = ref({
  username: '',   // phone number
  password: '',
  confirmPassword: '',
  nickName: ''    // optional
});

// Error messages
const errorMsg = ref('');

// Loading states
const isLoading = ref(false);
const isSendingCode = ref(false);



// Password visibility toggle
const showPassword = ref(false);
const togglePasswordVisibility = () => {
  showPassword.value = !showPassword.value;
};

// Form validation
const validateForm = (checkAll = true): boolean => {
  // Reset error message
  errorMsg.value = '';

  // Validate username (phone number)
  if (!formData.value.username) {
    errorMsg.value = 'Phone number must be entered';
    return false;
  }
  if (formData.value.username.length !== 11) {
    errorMsg.value = 'Phone number must be 11 characters';
    return false;
  }

  // Skip other validations if we're just checking the phone number
  if (!checkAll) return true;

  // Validate password
  if (!formData.value.password) {
    errorMsg.value = 'Password must be entered';
    return false;
  }
  if (formData.value.password.length < 5 || formData.value.password.length > 20) {
    errorMsg.value = 'The password must be between 5 and 20 characters long';
    return false;
  }

  // Validate password confirmation
  if (formData.value.password !== formData.value.confirmPassword) {
    errorMsg.value = 'Passwords do not match';
    return false;
  }

  return true;
};

// // Send verification code
// const sendVerificationCode = async () => {
//   // Don't send if countdown is active
//   if (countdown.value > 0) return;

//   // Validate phone number
//   if (!validateForm(false)) return;

//   try {
//     isSendingCode.value = true;
//     await postSendCodeAPI(formData.value.username);
    
//     // Start countdown (60 seconds)
//     countdown.value = 60;
//     const timer = setInterval(() => {
//       countdown.value--;
//       if (countdown.value <= 0) {
//         clearInterval(timer);
//       }
//     }, 1000);
    
//     uni.showToast({ 
//       icon: 'success', 
//       title: 'Verification code sent' 
//     });
//   } catch (error: any) {
//     errorMsg.value = error.message || 'Failed to send verification code';
//   } finally {
//     isSendingCode.value = false;
//   }
// };

// Register handler
const handleRegister = async () => {
  if (!validateForm()) return;
  
  try {
    isLoading.value = true;
    const response = await postRegisterAPI({
      username: formData.value.username,
      password: formData.value.password,
      nickName: formData.value.nickName || formData.value.username // Use username as default if nickname is empty
    });

    if(response.code !== 200) {
      uni.showToast({
        icon: 'none',
        title: (response.msg || 'Registration failed'),
      })
      isLoading.value = false;
      return;
    }
    
    // Registration success
    uni.showToast({ 
      icon: 'success', 
      title: 'Regis success' 
    });
    
    // Redirect to login page after successful registration
    setTimeout(() => {
      uni.navigateBack();
    }, 1500);
  }catch (error: any) {
    errorMsg.value = error.msg || 'Registration failed. Please try again.';
  }
};

// Navigate back to login page
const goToLogin = () => {
  uni.navigateBack();
};
</script>

<template>
  <view class="viewport">
    <view class="header">
      <text class="title">Register</text>
      <text class="subtitle">Create a new account</text>
    </view>
    
    <view class="form-container">
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
          placeholder="Please enter password (5-20 characters)" 
          v-model="formData.password"
        />
        <text 
          class="icon icon-eye" 
          :class="showPassword ? 'icon-eye-active' : ''" 
          @tap="togglePasswordVisibility"
        ></text>
      </view>
      
      <!-- Confirm password input -->
      <view class="input-group">
        <text class="icon icon-lock"></text>
        <input 
          class="input" 
          :type="showPassword ? 'text' : 'password'" 
          placeholder="Please confirm password" 
          v-model="formData.confirmPassword"
        />
      </view>
      
      <!-- Nickname input (optional) -->
      <view class="input-group">
        <text class="icon icon-user"></text>
        <input 
          class="input" 
          type="text" 
          placeholder="Enter nickname (optional)" 
          v-model="formData.nickName"
        />
      </view>
      
      <!-- Register button -->
      <button 
        class="register-button" 
        :disabled="isLoading" 
        @tap="handleRegister"
      >
        <text v-if="isLoading">Registering...</text>
        <text v-else>Register</text>
      </button>
      
      <!-- Login link -->
      <view class="login-link">
        <text @tap="goToLogin">Already have an account? Login</text>
      </view>
      
      <view class="tips">
        By registering, you agree to the Terms of Service and Privacy Policy
      </view>
    </view>
  </view>
</template>

<style lang="scss">
page {
  height: 100%;
  background-color: #f5f5f5;
}

.viewport {
  display: flex;
  flex-direction: column;
  min-height: 100%;
  padding: 40rpx;
}

.header {
  margin-bottom: 60rpx;
  padding-top: 60rpx;
  
  .title {
    display: block;
    font-size: 48rpx;
    font-weight: bold;
    color: #333;
    margin-bottom: 20rpx;
  }
  
  .subtitle {
    font-size: 28rpx;
    color: #999;
  }
}

.form-container {
  display: flex;
  flex-direction: column;
  
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
    height: 90rpx;
    border-radius: 45rpx;
    border: 1px solid #ddd;
    padding: 0 30rpx;
    margin-bottom: 30rpx;
    background-color: #fff;
    
    .icon {
      font-size: 40rpx;
      color: #999;
      margin-right: 10rpx;
    }
    
    .input {
      flex: 1;
      height: 90rpx;
      font-size: 28rpx;
    }
    
    .icon-eye-active {
      color: #cf4261;
    }
  }
  
  .code-group {
    position: relative;
    padding-right: 220rpx;
    
    .code-button {
      position: absolute;
      right: 8rpx;
      top: 8rpx;
      height: 74rpx;
      line-height: 74rpx;
      width: 200rpx;
      font-size: 24rpx;
      border-radius: 37rpx;
      background-color: #cf4261;
      color: #fff;
      text-align: center;
      padding: 0;
      
      &:disabled {
        background-color: #cccccc;
      }
    }
  }
  
  .register-button {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 90rpx;
    font-size: 32rpx;
    font-weight: bold;
    border-radius: 45rpx;
    background-color: #cf4261;
    color: #fff;
    margin: 30rpx 0;
    
    &:disabled {
      opacity: 0.7;
    }
  }
  
  .login-link {
    text-align: center;
    font-size: 28rpx;
    color: #cf4261;
    margin-bottom: 30rpx;
  }
  
  .tips {
    font-size: 24rpx;
    color: #999;
    text-align: center;
    margin-top: 40rpx;
  }
}
</style>