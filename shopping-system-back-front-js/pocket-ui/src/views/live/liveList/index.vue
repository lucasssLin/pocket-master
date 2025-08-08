<template>
  <div class="streamer-container">
    <!-- 头部信息 -->
    <el-card class="header-card">
      <template #header>
        <div class="card-header">
          <span>🎥 直播管理台</span>
          <div class="status-indicator" :class="connectionStatus.type">
            {{ connectionStatus.message }}
          </div>
        </div>
      </template>
      
      <!-- 主播信息和直播间管理 -->
      <el-form label-width="100px">
        <el-form-item label="主播信息">
          <div class="streamer-info">
            <span>{{ streamerInfo.username }}</span>
            <el-tag type="primary" size="small">ID: {{ streamerInfo.userId }}</el-tag>
          </div>
        </el-form-item>
        
        <el-form-item v-if="!hasActiveRoom">
          <template #label>
            直播商品
            <span v-if="productList.length > 0" class="product-count">({{ productList.length }}个商品可选)</span>
          </template>
          
          <!-- 商品搜索框 -->
          <el-input
            v-model="productSearchKeyword"
            placeholder="搜索商品名称..."
            prefix-icon="el-icon-search"
            class="product-search"
            clearable
            @input="filterProducts"
            @focus="loadProducts"
          />
          
          <!-- 商品网格展示 -->
          <div class="product-grid-container" v-loading="loadingProducts">
            <div v-if="filteredProductList.length === 0 && !loadingProducts" class="empty-products">
              <i class="el-icon-box"></i>
              <p>{{ productSearchKeyword ? '未找到匹配的商品' : '暂无商品可选' }}</p>
            </div>
            
            <div 
              v-for="item in filteredProductList" 
              :key="item.product.id"
              class="product-card"
              :class="{ 'selected': selectedProductId === item.product.id }"
              @click="selectProduct(item)"
            >
              <div class="product-image-container">
                <img 
                  v-if="getProductImage(item.product)" 
                  :src="getProductImage(item.product)" 
                  class="product-image" 
                  @error="handleImageError"
                  loading="lazy"
                />
                <div v-else class="product-image-placeholder">
                  <i class="el-icon-picture"></i>
                </div>
                <div v-if="selectedProductId === item.product.id" class="selected-indicator">
                  <i class="el-icon-check"></i>
                </div>
              </div>
              
                             <div class="product-info">
                 <div class="product-name" :title="item.product.name">{{ item.product.name }}</div>
                 <div class="product-price">¥{{ item.price.toFixed(0) }}</div>
                 <div class="product-sales" v-if="item.orderNum">销量{{ item.orderNum }}</div>
               </div>
            </div>
          </div>
          
          <!-- 已选择的商品显示 -->
          <div v-if="selectedProductId" class="selected-product-info">
            <el-tag type="success" closable @close="clearSelectedProduct">
              已选择: {{ getSelectedProductName() }}
            </el-tag>
          </div>
        </el-form-item>

        <el-form-item label="直播间状态" v-if="roomInfo.roomId">
          <div class="room-status">
            <span class="room-id">直播间ID: {{ roomInfo.roomId }}</span>
            <el-button type="text" @click="copyRoomId" size="small">
              <i class="el-icon-document-copy"></i> 复制
            </el-button>
          </div>
        </el-form-item>

        <el-form-item label="关联商品" v-if="roomInfo.roomId && roomInfo.productName">
          <div class="room-product">
            <span class="product-name">{{ roomInfo.productName }}</span>
            <el-tag type="success" size="small">已关联</el-tag>
          </div>
        </el-form-item>
        
        <el-form-item>
          <el-button 
            type="primary" 
            @click="createLiveRoom" 
            :disabled="hasActiveRoom" 
            :loading="creating"
            v-if="!hasActiveRoom"
          >
            创建直播间
          </el-button>
          
          <el-button 
            type="danger" 
            @click="closeLiveRoom" 
            :disabled="!hasActiveRoom"
            v-if="hasActiveRoom"
          >
            关闭直播间
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 设备检测 -->
    <el-card class="device-card">
      <template #header>
        <div class="card-header"><span>📹 设备设置</span></div>
      </template>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="摄像头">
            <el-select v-model="selectedCamera" placeholder="选择摄像头" style="width: 100%;" :disabled="isStreaming">
              <el-option v-for="device in videoDevices" :key="device.deviceId" :label="device.label" :value="device.deviceId" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="麦克风">
            <el-select v-model="selectedMicrophone" placeholder="选择麦克风" style="width: 100%;" :disabled="isStreaming">
              <el-option v-for="device in audioDevices" :key="device.deviceId" :label="device.label" :value="device.deviceId" />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-button @click="checkDevices" :disabled="isStreaming">检测设备</el-button>
      <el-button @click="testCamera" :disabled="isStreaming">测试摄像头</el-button>
      <el-button @click="stopTest" v-if="testStream">停止测试</el-button>
      <div v-if="deviceStatus.message" class="device-status">
        <el-alert :title="deviceStatus.message" :type="deviceStatus.type" :closable="false" show-icon />
      </div>
    </el-card>

    <!-- 直播预览 -->
    <el-card class="video-card">
      <template #header>
        <div class="card-header">
          <span>📹 直播预览</span>
          <div class="viewer-count" v-if="viewerCount > 0">
            <i class="el-icon-view"></i>
            {{ viewerCount }} 人观看
          </div>
        </div>
      </template>
      <div class="video-container">
        <video ref="localVideoRef" class="video-player" autoplay muted playsinline></video>
        <div class="video-overlay" v-if="!localStream">
          <i class="el-icon-video-camera"></i>
          <p>{{ hasActiveRoom ? '点击开始直播显示画面' : '请先创建直播间' }}</p>
        </div>
      </div>
      <div class="controls">
        <el-button 
          type="primary" 
          @click="startStream" 
          :disabled="!hasActiveRoom || isStreaming" 
          :loading="startingStream"
        >
          开始直播
        </el-button>
        <el-button type="danger" @click="stopStream" :disabled="!isStreaming">
          停止直播
        </el-button>
        <el-button @click="toggleVideo" :disabled="!isStreaming">
          {{ videoEnabled ? '关闭摄像头' : '开启摄像头' }}
        </el-button>
        <el-button @click="toggleAudio" :disabled="!isStreaming">
          {{ audioEnabled ? '关闭麦克风' : '开启麦克风' }}
        </el-button>
      </div>
    </el-card>

    <!-- 实时聊天 -->
    <el-card class="chat-card">
      <template #header>
        <div class="card-header">
          <span>💬 观众互动</span>
          <span class="online-count">在线: {{ onlineUsers }}</span>
        </div>
      </template>
      <div class="chat-container" ref="chatContainerRef">
        <div v-for="(msg, index) in chatMessages" :key="index" :class="['chat-message', msg.type]">
          <span class="time">{{ formatTime(msg.timestamp) }}</span>
          <strong class="user">{{ msg.user }}:</strong> 
          <span class="text">{{ msg.text }}</span>
        </div>
      </div>
      <div class="chat-input">
        <el-input 
          v-model="chatInput" 
          placeholder="与观众互动..." 
          @keyup.enter="sendChatMessage"
          :disabled="!hasActiveRoom"
        >
          <template #append>
            <el-button @click="sendChatMessage" :disabled="!chatInput.trim() || !hasActiveRoom">发送</el-button>
          </template>
        </el-input>
      </div>
    </el-card>

    <!-- 直播统计 -->
    <el-card class="stats-card" v-if="isStreaming">
      <template #header>
        <div class="card-header"><span>📊 直播数据</span></div>
      </template>
      <el-row :gutter="20">
        <el-col :span="6">
          <div class="stat-item">
            <div class="stat-value">{{ viewerCount }}</div>
            <div class="stat-label">当前观看</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-item">
            <div class="stat-value">{{ totalViewers }}</div>
            <div class="stat-label">总观看量</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-item">
            <div class="stat-value">{{ streamDuration }}</div>
            <div class="stat-label">直播时长</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-item">
            <div class="stat-value">{{ peerConnections.size }}</div>
            <div class="stat-label">连接数</div>
          </div>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, nextTick, computed, onUnmounted } from 'vue';
import { ElMessage } from 'element-plus';
import request from '@/utils/request';

// API函数
function getCurrentUser() {
  return request({
    url: '/system/user/profile',
    method: 'get'
  });
}

function createLiveRoomAPI(productId = null) {
  return request({
    url: '/live/live/room/create',
    method: 'post',
    data: {
      title: `${streamerInfo.username}的直播间`,
      description: '欢迎来到我的直播间！',
      productId: productId
    }
  });
}

function getProductListAPI(page = 1, pageSize = 50) {
  return request({
    url: '/live/live/room/productList',
    method: 'get',
    params: {
      page: page,
      pageSize: pageSize
    }
  });
}

function getRoomInfo(roomId) {
  return request({
    url: `/live/live/room/info/${roomId}`,
    method: 'get'
  });
}

function startLive(roomId) {
  return request({
    url: `/live/live/room/start/${roomId}`,
    method: 'post'
  });
}

function endLive(roomId) {
  return request({
    url: `/live/live/room/end/${roomId}`,
    method: 'post'
  });
}

// DOM引用
const localVideoRef = ref(null);
const chatContainerRef = ref(null);

// 状态管理
let websocket = null;
let localStream = null;
let testStream = null;
const peerConnections = reactive(new Map());

// 响应式数据
const videoDevices = ref([]);
const audioDevices = ref([]);
const selectedCamera = ref('');
const selectedMicrophone = ref('');

// 主播信息
const streamerInfo = reactive({
  userId: '',
  username: '',
  email: '',
});

// 直播间信息
const roomInfo = reactive({
  roomId: '',
  title: '',
  status: 0,
  productId: null,
  productName: '',
});

// 商品相关
const productList = ref([]);
const filteredProductList = ref([]);
const selectedProductId = ref(null);
const loadingProducts = ref(false);
const productSearchKeyword = ref('');

const deviceStatus = reactive({ message: '', type: 'info' });
const connectionStatus = reactive({ message: '未创建直播间', type: 'info' });
const chatMessages = ref([]);
const chatInput = ref('');

// 状态计算属性
const hasActiveRoom = computed(() => !!roomInfo.roomId);
const creating = ref(false);
const isStreaming = ref(false);
const startingStream = ref(false);
const videoEnabled = ref(true);
const audioEnabled = ref(true);
const viewerCount = ref(0);
const totalViewers = ref(0);
const onlineUsers = ref(0);
const streamDuration = ref('00:00:00');

// 直播计时器
let streamTimer = null;
let streamStartTime = null;

const iceServers = {
  iceServers: [
    { urls: 'stun:stun.l.google.com:19302' },
    { urls: 'stun:stun1.l.google.com:19302' },
  ],
};

// 获取当前登录用户信息
const loadUserInfo = async () => {
  try {
    const response = await getCurrentUser();
    if (response.code === 200) {
      const user = response.data;
      streamerInfo.userId = user.userId;
      streamerInfo.username = user.userName;
      streamerInfo.email = user.email;
      console.log('当前登录用户:', streamerInfo);
    }
  } catch (error) {
    console.error('获取用户信息失败:', error);
    ElMessage.error('获取用户信息失败，请重新登录');
  }
};

// 获取商品图片
const getProductImage = (product) => {
  if (!product || !product.sliderUrls) {
    return null;
  }
  
  // sliderUrls是逗号分隔的字符串，取第一张图片
  const urls = product.sliderUrls.split(',');
  return urls.length > 0 ? urls[0].trim() : null;
};

// 处理图片加载错误
const handleImageError = (event) => {
  // 设置默认图片或隐藏图片
  event.target.style.display = 'none';
};

// 获取商品名称用于显示
const getSelectedProductName = () => {
  if (!selectedProductId.value || !productList.value.length) {
    return '';
  }
  
  const selectedItem = productList.value.find(item => item.product.id === selectedProductId.value);
  return selectedItem ? selectedItem.product.name : '';
};

// 商品筛选
const filterProducts = () => {
  if (!productSearchKeyword.value.trim()) {
    filteredProductList.value = productList.value;
  } else {
    filteredProductList.value = productList.value.filter(item => 
      item.product.name.toLowerCase().includes(productSearchKeyword.value.toLowerCase()) ||
      (item.product.description && item.product.description.toLowerCase().includes(productSearchKeyword.value.toLowerCase()))
    );
  }
};

// 选择商品
const selectProduct = (item) => {
  selectedProductId.value = item.product.id;
  ElMessage.success(`已选择商品: ${item.product.name}`);
};

// 清除选择的商品
const clearSelectedProduct = () => {
  selectedProductId.value = null;
  ElMessage.info('已取消选择商品');
};

// 加载商品列表
const loadProducts = async () => {
  if (productList.value.length > 0 || loadingProducts.value) {
    return; // 避免重复加载
  }

  loadingProducts.value = true;
  try {
    const response = await getProductListAPI(1, 50);
    if (response.code === 200) {
      productList.value = response.data.rows || [];
      filteredProductList.value = productList.value; // 初始化筛选列表
      console.log('商品列表加载成功:', productList.value);
    }
  } catch (error) {
    console.error('加载商品列表失败:', error);
    ElMessage.warning('加载商品列表失败，但您仍可创建不关联商品的直播间');
  }
  loadingProducts.value = false;
};

// 创建直播间
const createLiveRoom = async () => {
  if (!streamerInfo.userId) {
    ElMessage.error('用户信息未加载，请刷新页面重试');
    return;
  }

  creating.value = true;
  try {
    console.log('创建直播间，选中的商品ID:', selectedProductId.value);
    const response = await createLiveRoomAPI(selectedProductId.value);
    console.log('创建直播间响应:', response);
    if (response.code === 200) {
      const liveRoom = response.data;
      roomInfo.roomId = liveRoom.roomId;
      roomInfo.title = liveRoom.title;
      roomInfo.status = liveRoom.status;
      roomInfo.productId = liveRoom.productId;
      
      // 如果后端没有返回productName，从本地获取
      roomInfo.productName = liveRoom.productName || getSelectedProductName();
      
      let successMsg = '直播间创建成功！';
      if (roomInfo.productName) {
        successMsg += ` 已关联商品：${roomInfo.productName}`;
      }
      ElMessage.success(successMsg);
      updateStatus('created', `直播间已创建: ${roomInfo.roomId}`);
      
      // 自动连接到创建的直播间
      await connectToRoom();
    }
  } catch (error) {
    console.error('创建直播间失败:', error);
    ElMessage.error('创建直播间失败: ' + (error.message || '未知错误'));
  }
  creating.value = false;
};

// 关闭直播间
const closeLiveRoom = async () => {
  try {
    if (isStreaming.value) {
      await stopStream();
    }
    
    if (websocket) {
      websocket.close();
    }
    
    // 清空直播间信息
    roomInfo.roomId = '';
    roomInfo.title = '';
    roomInfo.status = 0;
    roomInfo.productId = null;
    roomInfo.productName = '';
    
    // 重置商品选择
    selectedProductId.value = null;
    productSearchKeyword.value = '';
    filteredProductList.value = productList.value;
    
    updateStatus('closed', '直播间已关闭');
    cleanUp();
    ElMessage.success('直播间已关闭');
    
  } catch (error) {
    console.error('关闭直播间失败:', error);
    ElMessage.error('关闭直播间失败: ' + (error.message || '未知错误'));
  }
};

// 连接到直播间
const connectToRoom = async () => {
  if (!roomInfo.roomId || !streamerInfo.username) {
    return;
  }

  try {
    // 获取直播间信息
    const response = await getRoomInfo(roomInfo.roomId);
    if (response.code === 200) {
      onlineUsers.value = response.data.onlineUsers || 0;
    }
  } catch (error) {
    console.warn('获取直播间信息失败，继续连接', error);
  }

  // WebSocket连接
  const wsUrl = `ws://pocketapp.mynatapp.cc/live/live/signaling/${roomInfo.roomId}?userId=${streamerInfo.username}&role=streamer`;
  websocket = new WebSocket(wsUrl);

  websocket.onopen = () => {
    updateStatus('connected', `已连接到直播间: ${roomInfo.roomId}`);
    addChatMessage('系统', `主播 ${streamerInfo.username} 进入直播间`);
  };
  
  websocket.onmessage = handleWebSocketMessage;
  
  websocket.onclose = () => {
    updateStatus('disconnected', '连接已断开');
  };
  
  websocket.onerror = (error) => {
    console.error('WebSocket Error:', error);
    updateStatus('error', '连接错误');
  };
};

// 复制直播间ID
const copyRoomId = () => {
  navigator.clipboard.writeText(roomInfo.roomId).then(() => {
    ElMessage.success('直播间ID已复制到剪贴板');
  }).catch(() => {
    ElMessage.error('复制失败，请手动复制');
  });
};

// WebSocket消息处理
const handleWebSocketMessage = async (event) => {
  const message = JSON.parse(event.data);
  console.log('Received signaling message:', message);

  const fromUser = message.fromUserId;
  const pc = peerConnections.get(fromUser);

  switch (message.type) {
    case 'request-stream':
      if (localStream) {
        addChatMessage('系统', `${fromUser} 请求观看直播`, 'system');
        await createPeerConnection(fromUser, true);
      }
      break;
    case 'answer':
      if (pc) {
        try {
          await pc.setRemoteDescription(new RTCSessionDescription(message.data));
        } catch (error) {
          console.error('设置answer失败:', error);
        }
      }
      break;
    case 'ice-candidate':
      if (pc) {
        try {
          await pc.addIceCandidate(new RTCIceCandidate(message.data));
        } catch (error) {
          console.error('添加ICE候选者失败:', error);
        }
      }
      break;
    case 'user-joined':
      addChatMessage('系统', `${fromUser} 加入了直播间`, 'system');
      onlineUsers.value++;
      break;
    case 'user-left':
      addChatMessage('系统', `${fromUser} 离开了直播间`, 'system');
      if (pc) {
        pc.close();
        peerConnections.delete(fromUser);
      }
      onlineUsers.value = Math.max(0, onlineUsers.value - 1);
      viewerCount.value = Math.max(0, viewerCount.value - 1);
      break;
    case 'chat':
      addChatMessage(message.data.user, message.data.text, 'user');
      break;
  }
};

// 创建WebRTC连接
const createPeerConnection = async (peerId, shouldSendOffer) => {
  if (peerConnections.has(peerId)) return;

  const pc = new RTCPeerConnection(iceServers);
  peerConnections.set(peerId, pc);

  if (localStream) {
    localStream.getTracks().forEach(track => pc.addTrack(track, localStream));
  }

  pc.onicecandidate = (event) => {
    if (event.candidate) {
      sendSignalingMessage({ type: 'ice-candidate', data: event.candidate, targetUserId: peerId });
    }
  };

  pc.onconnectionstatechange = () => {
    if (pc.connectionState === 'connected') {
      viewerCount.value++;
      totalViewers.value++;
    } else if (pc.connectionState === 'disconnected' || pc.connectionState === 'failed') {
      viewerCount.value = Math.max(0, viewerCount.value - 1);
    }
  };

  if (shouldSendOffer) {
    try {
      const offer = await pc.createOffer();
      await pc.setLocalDescription(offer);
      sendSignalingMessage({ type: 'offer', data: offer, targetUserId: peerId });
    } catch (error) {
      console.error('创建offer失败:', error);
    }
  }
};

// 发送信令消息
const sendSignalingMessage = (message) => {
  if (websocket && websocket.readyState === WebSocket.OPEN) {
    message.fromUserId = streamerInfo.username;
    websocket.send(JSON.stringify(message));
  }
};

// 开始直播
async function startStream() {
  if (!hasActiveRoom.value) {
    return ElMessage.error('请先创建直播间');
  }

  startingStream.value = true;
  try {
    await startLive(roomInfo.roomId);
    
    if (testStream) stopTest();
    
    const constraints = {
      video: selectedCamera.value ? { deviceId: { exact: selectedCamera.value } } : true,
      audio: selectedMicrophone.value ? { deviceId: { exact: selectedMicrophone.value } } : true,
    };

    localStream = await navigator.mediaDevices.getUserMedia(constraints);
    localVideoRef.value.srcObject = localStream;
    
    isStreaming.value = true;
    streamStartTime = Date.now();
    startStreamTimer();
    
    addChatMessage('系统', '直播已开始，等待观众加入...', 'system');
    ElMessage.success('直播开始成功');
    
  } catch (error) {
    console.error('开始直播失败:', error);
    ElMessage.error(`开始直播失败: ${error.message}`);
  }
  startingStream.value = false;
}

// 停止直播
async function stopStream() {
  try {
    await endLive(roomInfo.roomId);
    
    if (localStream) {
      localStream.getTracks().forEach(track => track.stop());
      localStream = null;
      localVideoRef.value.srcObject = null;
    }
    
    isStreaming.value = false;
    stopStreamTimer();
    
    // 关闭所有WebRTC连接但保持WebSocket连接
    peerConnections.forEach(pc => pc.close());
    peerConnections.clear();
    viewerCount.value = 0;
    
    addChatMessage('系统', '直播已结束', 'system');
    ElMessage.success('直播已结束');
    
  } catch (error) {
    console.error('停止直播失败:', error);
    ElMessage.error(`停止直播失败: ${error.message}`);
  }
}

// 清理资源
function cleanUp() {
  peerConnections.forEach(pc => pc.close());
  peerConnections.clear();
  viewerCount.value = 0;
  onlineUsers.value = 0;
  
  if (localStream) {
    localStream.getTracks().forEach(track => track.stop());
    localStream = null;
    if (localVideoRef.value) localVideoRef.value.srcObject = null;
  }
  
  if (isStreaming.value) {
    isStreaming.value = false;
    stopStreamTimer();
  }
}

// 更新连接状态
const updateStatus = (status, message) => {
  const types = { 
    created: 'success', 
    connected: 'success', 
    connecting: 'warning', 
    disconnected: 'info', 
    closed: 'info',
    error: 'error' 
  };
  connectionStatus.type = types[status] || 'info';
  connectionStatus.message = message;
};

// 设备相关函数
async function checkDevices() {
  try {
    if (!navigator.mediaDevices || !navigator.mediaDevices.enumerateDevices) {
      return showDeviceStatus('浏览器不支持设备检测', 'error');
    }
    
    showDeviceStatus('正在检测设备...', 'warning');
    await navigator.mediaDevices.getUserMedia({ video: true, audio: true }).then(s => s.getTracks().forEach(t => t.stop()));
    
    const devices = await navigator.mediaDevices.enumerateDevices();
    videoDevices.value = devices.filter(d => d.kind === 'videoinput');
    audioDevices.value = devices.filter(d => d.kind === 'audioinput');
    
    if (videoDevices.value.length > 0) selectedCamera.value = videoDevices.value[0].deviceId;
    if (audioDevices.value.length > 0) selectedMicrophone.value = audioDevices.value[0].deviceId;
    
    const msg = `检测到 ${videoDevices.value.length} 个摄像头，${audioDevices.value.length} 个麦克风`;
    showDeviceStatus(msg, 'success');
    
  } catch (error) {
    showDeviceStatus('设备检测失败: ' + error.message, 'error');
  }
}

async function testCamera() {
  try {
    if (testStream) stopTest();
    
    const constraints = {
      video: selectedCamera.value ? { deviceId: { exact: selectedCamera.value } } : true,
      audio: selectedMicrophone.value ? { deviceId: { exact: selectedMicrophone.value } } : true
    };
    
    testStream = await navigator.mediaDevices.getUserMedia(constraints);
    localVideoRef.value.srcObject = testStream;
    showDeviceStatus('设备测试中...', 'info');
    
  } catch (error) {
    showDeviceStatus('设备测试失败: ' + error.message, 'error');
  }
}

function stopTest() {
  if (testStream) {
    testStream.getTracks().forEach(track => track.stop());
    testStream = null;
    if (localVideoRef.value) localVideoRef.value.srcObject = null;
    showDeviceStatus('测试已停止', 'success');
  }
}

function toggleVideo() {
  if (localStream) {
    const videoTrack = localStream.getVideoTracks()[0];
    if (videoTrack) {
      videoTrack.enabled = !videoTrack.enabled;
      videoEnabled.value = videoTrack.enabled;
      addChatMessage('系统', `摄像头已${videoTrack.enabled ? '开启' : '关闭'}`, 'system');
    }
  }
}

function toggleAudio() {
  if (localStream) {
    const audioTrack = localStream.getAudioTracks()[0];
    if (audioTrack) {
      audioTrack.enabled = !audioTrack.enabled;
      audioEnabled.value = audioTrack.enabled;
      addChatMessage('系统', `麦克风已${audioTrack.enabled ? '开启' : '关闭'}`, 'system');
    }
  }
}

// 聊天相关函数
function sendChatMessage() {
  if (!chatInput.value.trim() || !hasActiveRoom.value) return;
  
  const message = {
    type: 'chat',
    data: {
      user: streamerInfo.username,
      text: chatInput.value,
    }
  };
  
  sendSignalingMessage(message);
  addChatMessage(streamerInfo.username, chatInput.value, 'streamer');
  chatInput.value = '';
}

function addChatMessage(user, text, type = 'system') {
  chatMessages.value.push({ 
    user, 
    text, 
    type, 
    timestamp: Date.now() 
  });
  
  nextTick(() => {
    const container = chatContainerRef.value;
    if (container) container.scrollTop = container.scrollHeight;
  });
}

function formatTime(timestamp) {
  return new Date(timestamp).toLocaleTimeString();
}

const showDeviceStatus = (message, type = 'info') => {
  deviceStatus.message = message;
  deviceStatus.type = type;
};

// 直播计时器
function startStreamTimer() {
  streamTimer = setInterval(() => {
    if (streamStartTime) {
      const elapsed = Date.now() - streamStartTime;
      const hours = Math.floor(elapsed / 3600000);
      const minutes = Math.floor((elapsed % 3600000) / 60000);
      const seconds = Math.floor((elapsed % 60000) / 1000);
      streamDuration.value = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }
  }, 1000);
}

function stopStreamTimer() {
  if (streamTimer) {
    clearInterval(streamTimer);
    streamTimer = null;
  }
  streamDuration.value = '00:00:00';
}

// 生命周期
onMounted(async () => {
  await loadUserInfo();
  await checkDevices();
});

onUnmounted(() => {
  cleanUp();
  stopStreamTimer();
  if (websocket) {
    websocket.close();
  }
});
</script>

<style scoped>
.streamer-container {
  padding: 20px;
  max-width: 1400px;
  margin: 0 auto;
}

.header-card, .device-card, .video-card, .chat-card, .stats-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.status-indicator {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
}

.status-indicator.success { background: #f0f9ff; color: #10b981; }
.status-indicator.warning { background: #fef3c7; color: #f59e0b; }
.status-indicator.error { background: #fee2e2; color: #ef4444; }
.status-indicator.info { background: #f3f4f6; color: #6b7280; }

.streamer-info {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 16px;
}

.room-status {
  display: flex;
  align-items: center;
  gap: 10px;
}

.room-id {
  font-family: monospace;
  background: #f5f5f5;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 14px;
}

.room-product {
  display: flex;
  align-items: center;
  gap: 10px;
}

.room-product .product-name {
  font-weight: 500;
  color: #374151;
}

.product-count {
  font-size: 12px;
  color: #6b7280;
  font-weight: normal;
  margin-left: 5px;
}

/* 商品搜索框样式 */
.product-search {
  margin-bottom: 16px;
}

/* 商品网格容器样式 */
.product-grid-container {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  max-height: 450px;
  overflow-y: auto;
  padding: 20px;
  background: #fafafa;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 20px;
}

@media (max-width: 768px) {
  .product-grid-container {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    padding: 16px;
    gap: 16px;
  }
}

/* 空状态样式 */
.empty-products {
  grid-column: 1 / -1;
  text-align: center;
  padding: 40px 20px;
  color: #9ca3af;
}

.empty-products i {
  font-size: 48px;
  margin-bottom: 16px;
  display: block;
}

.empty-products p {
  font-size: 16px;
  margin: 0;
}

/* 商品卡片样式 */
.product-card {
  background: white;
  border-radius: 8px;
  padding: 0;
  border: 2px solid transparent;
  transition: all 0.3s ease;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
  border-color: #d1d5db;
}

.product-card.selected {
  border-color: #3b82f6;
  box-shadow: 0 6px 20px rgba(59, 130, 246, 0.2);
}

.product-image-container {
  position: relative;
  width: 100%;
  height: 160px;
  background: #f8f9fa;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 0;
  border: none;
}

.product-image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
  color: #9ca3af;
  font-size: 28px;
}

.selected-indicator {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 24px;
  height: 24px;
  background: #3b82f6;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  z-index: 2;
}

.product-info {
  padding: 12px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
  text-align: center;
}

.product-name {
  font-size: 12px;
  font-weight: 400;
  color: #333333;
  margin: 0;
  line-height: 1.3;
  max-height: 2.6em;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.product-card.selected .product-name {
  color: #1d4ed8;
  font-weight: 500;
}

.product-price {
  font-size: 15px;
  color: #ff6b35;
  font-weight: 600;
  margin: 4px 0 0 0;
}

.product-card.selected .product-price {
  color: #1d4ed8;
}

.product-sales {
  font-size: 11px;
  color: #999999;
  margin: 2px 0 0 0;
  font-weight: normal;
}

.product-description {
  display: none;
}

/* 已选择商品信息样式 */
.selected-product-info {
  margin-top: 12px;
  padding: 12px;
  background: #f0f9ff;
  border-radius: 8px;
  border: 1px solid #bfdbfe;
}

.selected-product-info .el-tag {
  font-size: 14px;
  padding: 8px 12px;
}

.device-status {
  margin-top: 15px;
}

.video-container {
  position: relative;
  background: #000;
  border-radius: 8px;
  overflow: hidden;
}

.video-player {
  width: 100%;
  height: 900px;
  object-fit: cover;
}

.video-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #fff;
  background: rgba(0, 0, 0, 0.7);
}

.video-overlay i {
  font-size: 48px;
  margin-bottom: 16px;
}

.controls {
  text-align: center;
  padding: 15px 0;
}

.controls .el-button {
  margin: 0 8px;
}

.viewer-count {
  color: #10b981;
  font-size: 14px;
}

.online-count {
  color: #6b7280;
  font-size: 14px;
}

.chat-container {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 15px;
  height: 300px;
  overflow-y: auto;
  background: #f9fafb;
}

.chat-message {
  margin-bottom: 8px;
  line-height: 1.5;
}

.chat-message .time {
  color: #9ca3af;
  font-size: 12px;
  margin-right: 8px;
}

.chat-message .user {
  margin-right: 8px;
}

.chat-message.system .user { color: #6b7280; }
.chat-message.streamer .user { color: #ef4444; }
.chat-message.user .user { color: #10b981; }

.chat-input {
  margin-top: 15px;
}

.stats-card .el-row {
  text-align: center;
}

.stat-item {
  padding: 20px;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #374151;
  margin-bottom: 8px;
}

.stat-label {
  font-size: 14px;
  color: #6b7280;
}
</style>