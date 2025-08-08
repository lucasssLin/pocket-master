<script setup lang="ts">
import { ref, reactive, toRefs, getCurrentInstance, nextTick, watch, onMounted } from 'vue'
import List from './components/list.vue'
import { http } from '@/utils/http';

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

// tabs 数据
const orderTabs = ref([
  { orderState: 0, title: '全部' },
  { orderState: 1, title: '待付款' },
  { orderState: 2, title: '待发货' },
  { orderState: 3, title: '待收货' },
  { orderState: 4, title: '待评价' },
])

//获取页面参数
const query = defineProps<{type: string}>()

// 高亮下标
const tabIndex = ref(orderTabs.value.findIndex(item=> item.orderState === Number(query.type)))

// ========== AI Agent 相关代码 ==========
interface ChatMessage {
  id: string
  type: 'user' | 'assistant'
  content: string
  timestamp: Date
  isLoading?: boolean
}

// AI 助手状态
const aiAssistantVisible = ref(false)
const unreadMessages = ref(0)
const userInput = ref('')
const messages = ref<ChatMessage[]>([])
const isLoading = ref(false)
const chatContainer = ref(null)

// 常用问题建议
const suggestions = ref([
  '查询我的订单消费数据2024年全年',
  '查询我最近6个月的消费数据',
  '我的订单状态说明',
  '如何查看订单详情'
])

// 初始化聊天
const initializeChat = () => {
  if (messages.value.length === 0) {
    messages.value.push({
      id: '1',
      type: 'assistant',
      content: '您好！我是Pocket电商平台的智能客服小助手 🤖\n\n我可以帮您：\n• 查询订单消费数据\n• 了解订单状态信息\n• 解答订单相关问题\n\n请问有什么可以帮到您的吗？',
      timestamp: new Date()
    })
  }
}

// 切换 AI 助手显示状态
const toggleAiAssistant = () => {
  aiAssistantVisible.value = !aiAssistantVisible.value
  if (aiAssistantVisible.value) {
    initializeChat()
    unreadMessages.value = 0
    nextTick(() => {
      scrollToBottom()
    })
  }
}

// 格式化消息内容，处理换行和链接
const formatMessage = (content) => {
  if (!content) return ''
  return content
    .replace(/\n/g, '<br>')
    .replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank">$1</a>')
}

// 使用问题建议 - 修改为填入输入框而不是直接发送
const useQuerySuggestion = (suggestion) => {
  userInput.value = suggestion
  // 不再自动调用sendMessage，让用户确认后发送
}

// 处理SSE格式数据，移除"data:"前缀并优化文本显示
const processSSEData = (data) => {
  if (!data) return '';
  
  // 检查是否是字符串
  if (typeof data !== 'string') {
    return JSON.stringify(data);
  }
  
  // 将数据按行分割
  const lines = data.split('\n');
  
  // 处理每一行，移除"data:"前缀
  const processedLines = lines.map(line => {
    // 移除行首的"data:"前缀
    if (line.startsWith('data:')) {
      return line.substring(5).trim();
    }
    return line.trim();
  });
  
  // 移除[DONE]标记和空行
  const filteredLines = processedLines.filter(line => line !== '[DONE]' && line !== '');
  
  // 合并文本，优化显示格式
  let result = '';
  
  // 处理特殊格式的文本，使其更连贯
  for (let i = 0; i < filteredLines.length; i++) {
    const line = filteredLines[i];
    
    // 如果当前行是短破折号或冒号，与下一行合并
    if ((line === '-' || line === ':') && i < filteredLines.length - 1) {
      result += line + ' ';
      continue;
    }
    
    // 特殊处理带**的标题行，确保它们与数值行在一起
    if (line.includes('**') && i < filteredLines.length - 1 && !filteredLines[i+1].includes('**')) {
      result += line + '\n';
      continue;
    }
    
    // 处理金额和百分比数值，确保它们与前面的标题紧密排列
    if ((line.startsWith('¥') || line.endsWith('%')) && i > 0 && !result.endsWith('\n\n')) {
      result += line + '\n\n';
      continue;
    }
    
    // 处理普通行
    result += line + '\n';
  }
  
  // 移除多余的换行符，确保格式一致
  result = result.replace(/\n{3,}/g, '\n\n');
  
  return result.trim();
}

// 模拟EventSource，使用轮询实现SSE效果
const sendMessage = async () => {
  if (!userInput.value.trim() || isLoading.value) return;

  // 添加用户消息
  const userMessage = userInput.value.trim();
  messages.value.push({
    id: Date.now().toString(),
    type: 'user',
    content: userMessage,
    timestamp: new Date()
  });

  // 清空输入框
  userInput.value = '';
  
  // 添加 AI 正在输入的消息
  const aiMessageIndex = messages.value.length;
  messages.value.push({
    id: (Date.now() + 1).toString(),
    type: 'assistant',
    content: '',
    timestamp: new Date(),
    isLoading: true
  });
  
  // 滚动到底部
  await nextTick();
  scrollToBottom();
  
  // 设置加载状态
  isLoading.value = true;

  try {
    // 模拟index.vue中的EventSource实现
    let fullResponse = '';
    let isComplete = false;
    const startTime = Date.now();
    const pollInterval = 300; // 300毫秒轮询一次，模拟实时流式更新
    
    // 轮询函数 - 模拟流式响应
    const simulateSSE = () => {
      if (isComplete) return;
      
      // 随机进度百分比，0-100之间
      const progress = Math.floor((Date.now() - startTime) / 100); // 每100ms增加1%
      
      // 执行请求
      uni.request({
        url: `/aiAgent/frontAi/frontStage/order?message=${encodeURIComponent(userMessage)}&progress=${progress}`,
        method: 'GET',
        header: {
          'Accept': 'text/event-stream',
          'Content-Type': 'application/json'
        },
        success: (response) => {
          if (response.statusCode === 200 && response.data) {
            // 处理SSE格式数据
            const processedData = processSSEData(response.data);
            
            // 更新内容 - 只有当内容实际发生变化时才更新
            if (processedData && processedData !== fullResponse) {
              fullResponse = processedData;
              
              // 优化格式，确保数据展示连贯
              const formattedResponse = formatResponseForDisplay(fullResponse);
              
              // 更新消息显示
              if (messages.value[aiMessageIndex]) {
                messages.value[aiMessageIndex].content = formattedResponse;
              }
              
              // 滚动到底部
              scrollToBottom();
            }
            
            // 检查是否完成
            if (response.data.includes('[DONE]') || 
                progress >= 100 || 
                Date.now() - startTime > 30000) { // 最多30秒
              isComplete = true;
              
              // 最终处理，确保消息格式正确
              if (messages.value[aiMessageIndex]) {
                // 再次优化格式，确保最终显示是连贯的
                const finalResponse = formatResponseForDisplay(fullResponse);
                messages.value[aiMessageIndex].content = finalResponse;
                messages.value[aiMessageIndex].isLoading = false;
              }
              
              isLoading.value = false;
            } else {
              // 继续轮询
              setTimeout(simulateSSE, pollInterval);
            }
          } else {
            // 请求失败
            handleError();
          }
        },
        fail: (error) => {
          console.error('请求失败:', error);
          handleError();
        }
      });
    };
    
    // 格式化响应，使其在界面上显示更连贯
    const formatResponseForDisplay = (text) => {
      if (!text) return '';
      
      // 如果是消费数据分析，应用特殊格式化规则
      if (text.includes('订单消费数据分析') || text.includes('消费总额')) {
        // 将消费数据格式化为更好的结构
        return formatConsumptionData(text);
      }
      
      return text;
    };
    
    // 特殊格式化消费数据，确保显示连贯
    const formatConsumptionData = (text) => {
      // 替换分散的格式为更连贯的格式
      return text
        // 确保标题与内容之间没有多余空行
        .replace(/(\*\*[^*]+\*\*)\s*\n+\s*([¥\d])/g, '$1 $2')
        // 确保数字与百分比之间没有多余空行
        .replace(/(\d+\.\d+)\s*\n+\s*(%)/g, '$1$2')
        // 规范化空行
        .replace(/\n{3,}/g, '\n\n');
    };
    
    // 错误处理函数
    const handleError = () => {
      isComplete = true;
      isLoading.value = false;
      
      if (messages.value[aiMessageIndex]) {
        messages.value[aiMessageIndex].content = '很抱歉，处理您的请求时出现了问题，请稍后再试。';
        messages.value[aiMessageIndex].isLoading = false;
      }
    };
    
    // 开始轮询
    simulateSSE();
    
  } catch (error) {
    console.error('发送消息错误:', error);
    isLoading.value = false;
    
    // 更新 AI 消息为错误提示
    const aiMessageIndex = messages.value.length - 1;
    if (messages.value[aiMessageIndex] && messages.value[aiMessageIndex].type === 'assistant') {
      messages.value[aiMessageIndex].content = '很抱歉，处理您的请求时出现了问题，请稍后再试。';
      messages.value[aiMessageIndex].isLoading = false;
    }
  }
};

// 滚动到对话底部
const scrollToBottom = () => {
  setTimeout(() => {
    const query = uni.createSelectorQuery()
    query.select('#msg-bottom').boundingClientRect()
    query.exec((res) => {
      if (res[0]) {
        uni.pageScrollTo({
          selector: '#msg-bottom',
          duration: 300
        })
      }
    })
  }, 150)
}

// 键盘事件处理
const handleConfirm = () => {
  sendMessage()
}

// 监视 AI 助手可见性，当不可见时增加未读消息数
watch(() => messages.value.length, (newLength, oldLength) => {
  if (!aiAssistantVisible.value && newLength > oldLength) {
    unreadMessages.value++
  }
})

// 组件挂载完成时初始化
onMounted(() => {
  // 可以在这里添加其他初始化逻辑
})
</script>

<template>
  <view class="viewport">
    <!-- tabs -->
    <view class="tabs">
      <text class="item" v-for="(item, index) in orderTabs" 
      :key="item.orderState"
      @tap="tabIndex = index"
      > {{item.title}} </text>
      <!-- 游标 -->
      <view class="cursor" :style="{ left: tabIndex * 20 + '%' }"></view>
    </view>
    
    <!-- 滑动容器 -->
    <swiper class="swiper" :current="tabIndex" @change="tabIndex = $event.detail.current">
      <!-- 滑动项 -->
      <swiper-item v-for="item in orderTabs" :key="item.title">
        <!--订单列表-->
        <List :order-state="item.orderState"/>
      </swiper-item>
    </swiper>
    
    <!-- AI 助手浮动按钮 -->
    <view class="ai-assistant-button" @tap="toggleAiAssistant">
      <view :value="unreadMessages" :hidden="unreadMessages === 0" class="ai-badge">
        <text class="badge-content">{{ unreadMessages }}</text>
      </view>
      <view class="ai-button-icon" :class="{ active: aiAssistantVisible }">
        <text class="icon">{{ aiAssistantVisible ? '✕' : '🤖' }}</text>
      </view>
    </view>

    <!-- AI 助手对话窗口 -->
    <view class="ai-overlay" v-if="aiAssistantVisible" @tap="toggleAiAssistant">
      <view class="ai-assistant-panel" @tap.stop>
        <view class="ai-header">
          <view class="ai-title">
            <view class="ai-avatar">AI</view>
            <text>智能订单助手</text>
          </view>
          <view class="close-btn" @tap="toggleAiAssistant">✕</view>
        </view>
        
        <scroll-view 
          class="ai-body" 
          scroll-y 
          scroll-into-view="msg-bottom"
          :scroll-top="99999"
          ref="chatContainer"
        >
          <view class="ai-messages">
            <view class="message system">
              <view class="message-content">
                <text>{{ messages[0]?.content || '您好！我是您的订单智能助手。我可以帮您查询订单信息、解答订单问题或提供订单管理建议。请问有什么可以帮到您的？' }}</text>
              </view>
            </view>
            
            <view v-for="(message, index) in messages.slice(1)" :key="message.id" :class="['message', message.type]">
              <view v-if="message.type === 'user'" class="message-avatar">
                <view class="user-avatar">👤</view>
              </view>
              <view v-else class="message-avatar">
                <view class="ai-message-avatar">AI</view>
              </view>
              
              <view class="message-content">
                <view v-if="message.type === 'assistant' && message.isLoading" class="typing-indicator">
                  <view class="dot"></view>
                  <view class="dot"></view>
                  <view class="dot"></view>
                </view>
                <rich-text v-else :nodes="formatMessage(message.content)"></rich-text>
              </view>
            </view>
          </view>
          <view id="msg-bottom"></view>
        </scroll-view>
        
        <view class="ai-footer">
          <view class="input-container">
            <input
              v-model="userInput"
              placeholder="输入您的问题..."
              :disabled="isLoading"
              @confirm="handleConfirm"
              confirm-type="send"
              class="input-field"
              maxlength="500"
            />
            <view 
              class="send-btn" 
              :class="{ active: userInput.trim() && !isLoading, loading: isLoading }"
              @tap="sendMessage"
            >
              <text class="send-icon" v-if="!isLoading">➤</text>
              <view class="loading-icon" v-else>
                <view class="loading-dot"></view>
                <view class="loading-dot"></view>
                <view class="loading-dot"></view>
              </view>
            </view>
          </view>
          <view class="ai-suggestions">
            <view 
              v-for="(suggestion, index) in suggestions" 
              :key="index" 
              @tap="useQuerySuggestion(suggestion)" 
              class="suggestion-tag"
            >
              {{ suggestion }}
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss">
page {
  height: 100%;
  overflow: hidden;
}

.viewport {
  height: 100%;
  display: flex;
  flex-direction: column;
  background-color: #fff;
}

/* tabs */
.tabs {
  display: flex;
  justify-content: space-around;
  line-height: 60rpx;
  margin: 0 10rpx;
  background-color: #fff;
  box-shadow: 0 4rpx 6rpx rgba(240, 240, 240, 0.6);
  position: relative;
  z-index: 9;

  .item {
    flex: 1;
    text-align: center;
    padding: 20rpx;
    font-size: 28rpx;
    color: #262626;
  }

  .cursor {
    position: absolute;
    left: 0;
    bottom: 0;
    width: 20%;
    height: 6rpx;
    padding: 0 50rpx;
    background-color: #cf4261;
    transition: all 0.4s;
  }
}

/* swiper */
.swiper {
  background-color: #f7f7f8;
}

/* AI 助手样式 - 完全模仿 index.vue */
.ai-assistant-button {
  position: fixed;
  right: 30rpx;
  bottom: 200rpx;
  z-index: 999;
  box-shadow: 0 8rpx 24rpx rgba(51, 112, 255, 0.3);
  border-radius: 50%;
  transition: all 0.3s;

  &:active {
    transform: scale(0.95);
  }

  .ai-badge {
    position: absolute;
    top: -10rpx;
    right: -10rpx;
    min-width: 36rpx;
    height: 36rpx;
    background-color: #ff4757;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20rpx;
    font-weight: bold;
    z-index: 1000;
    
    &[hidden] {
      display: none !important;
    }
    
    .badge-content {
      font-size: 20rpx;
      color: white;
    }
  }

  .ai-button-icon {
    width: 120rpx;
    height: 120rpx;
    background: linear-gradient(90deg, #3370ff, #5e96ff);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;

    &.active {
      background: linear-gradient(90deg, #f56c6c, #ff8a8a);
    }

    .icon {
      font-size: 48rpx;
      color: white;
      font-weight: bold;
    }
  }
}

.ai-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  display: flex;
  align-items: flex-end;
  padding: 20rpx;
}

.ai-assistant-panel {
  width: 100%;
  height: 85vh;
  max-height: 90vh;
  background-color: #fff;
  border-radius: 40rpx 40rpx 0 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  animation: slideUp 0.3s ease-out;
}

.ai-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 30rpx 40rpx;
  background: linear-gradient(90deg, #3370ff, #5e96ff);
  color: white;
  border-radius: 40rpx 40rpx 0 0;
}

.ai-title {
  display: flex;
  align-items: center;
  gap: 20rpx;
  font-weight: bold;
  font-size: 32rpx;
}

.ai-avatar {
  width: 64rpx;
  height: 64rpx;
  background-color: #fff;
  color: #3370ff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 28rpx;
}

.ai-message-avatar {
  width: 72rpx;
  height: 72rpx;
  background-color: #3370ff;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 28rpx;
}

.user-avatar {
  width: 72rpx;
  height: 72rpx;
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28rpx;
}

.close-btn {
  width: 60rpx;
  height: 60rpx;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32rpx;
  font-weight: bold;
  color: white;
}

.ai-body {
  flex: 1;
  overflow-y: auto;
  padding: 32rpx;
  background: linear-gradient(180deg, #f7f8fc 0%, #ffffff 100%);
}

.ai-messages {
  display: flex;
  flex-direction: column;
  gap: 32rpx;
}

.message {
  display: flex;
  gap: 16rpx;
  max-width: 80%;

  &.system {
    align-self: center;
    text-align: center;
    max-width: 90%;
    margin-bottom: 32rpx;

    .message-content {
      background-color: #f0f2f5;
      border-radius: 20rpx;
      padding: 20rpx 32rpx;
      font-size: 28rpx;
      color: #666;
    }
  }

  &.user {
    align-self: flex-end;
    flex-direction: row-reverse;

    .message-content {
      background: linear-gradient(135deg, #3370ff 0%, #5e96ff 100%);
      color: white;
      border-radius: 24rpx 24rpx 8rpx 24rpx;
    }
  }

  &.assistant {
    align-self: flex-start;

    .message-content {
      background-color: white;
      box-shadow: 0 2rpx 24rpx rgba(0, 0, 0, 0.1);
      color: #333;
      border-radius: 24rpx 24rpx 24rpx 8rpx;
    }
  }
}

.message-avatar {
  display: flex;
  align-items: flex-start;
  flex-shrink: 0;
}

.message-content {
  padding: 24rpx 32rpx;
  font-size: 28rpx;
  line-height: 1.5;
  word-wrap: break-word;
}

.ai-footer {
  padding: 32rpx;
  border-top: 2rpx solid #eee;
  background-color: #fff;
}

.input-container {
  display: flex;
  align-items: center;
  background: #f7f8fc;
  border-radius: 50rpx;
  padding: 8rpx;
  margin-bottom: 24rpx;
}

.input-field {
  flex: 1;
  padding: 24rpx 32rpx;
  background: transparent;
  border: none;
  font-size: 28rpx;
  color: #333;

  &::placeholder {
    color: #999;
  }
}

.send-btn {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  background: #e0e0e0;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;

  &.active {
    background: linear-gradient(135deg, #3370ff 0%, #5e96ff 100%);
    transform: scale(1.05);

    .send-icon {
      color: white;
    }
  }

  &.loading {
    background: #f0f0f0;
  }

  .send-icon {
    font-size: 32rpx;
    color: #999;
    transform: rotate(-45deg);
  }

  .loading-icon {
    display: flex;
    align-items: center;
    gap: 6rpx;

    .loading-dot {
      width: 8rpx;
      height: 8rpx;
      border-radius: 50%;
      background: #999;
      animation: loading 1.4s infinite;

      &:nth-child(1) { animation-delay: 0s; }
      &:nth-child(2) { animation-delay: 0.2s; }
      &:nth-child(3) { animation-delay: 0.4s; }
    }
  }
}

.ai-suggestions {
  display: flex;
  flex-wrap: wrap;
  gap: 16rpx;
}

.suggestion-tag {
  flex: 1;
  min-width: 0;
  padding: 16rpx 20rpx;
  background: #f0f2f5;
  border-radius: 40rpx;
  text-align: center;
  font-size: 24rpx;
  color: #3370ff;
  border: 2rpx solid #e8f3ff;
  transition: all 0.2s;

  &:active {
    transform: scale(0.95);
    background: #e8f3ff;
  }
}

.typing-indicator {
  display: flex;
  align-items: center;
  gap: 8rpx;

  .dot {
    width: 8rpx;
    height: 8rpx;
    border-radius: 50%;
    background: #3370ff;
    animation: typing 1.4s infinite;

    &:nth-child(1) { animation-delay: 0s; }
    &:nth-child(2) { animation-delay: 0.2s; }
    &:nth-child(3) { animation-delay: 0.4s; }
  }
}

/* 动画 */
@keyframes slideUp {
  from {
    transform: translateY(100%);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes loading {
  0%, 20% { transform: translateY(0); opacity: 1; }
  50% { transform: translateY(-8rpx); opacity: 0.7; }
  80%, 100% { transform: translateY(0); opacity: 1; }
}

@keyframes typing {
  0%, 20% { transform: translateY(0); opacity: 0.4; }
  50% { transform: translateY(-8rpx); opacity: 0.8; }
  80%, 100% { transform: translateY(0); opacity: 0.4; }
}
</style>