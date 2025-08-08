<script setup lang="ts">
import { onLoad, onReady, onUnload } from '@dcloudio/uni-app'
import { ref, reactive, nextTick, computed } from 'vue'
import { connectToRoom, createPeerConnection, sendSignalingMessage } from '@/services/live'

// 声明uni和getCurrentPages，避免类型错误
declare const uni: any;
declare const getCurrentPages: () => any[];

// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()

// 直播间参数
const roomId = ref('')
const roomTitle = ref('')
const streamerName = ref('')
const productId = ref('')

// 商品信息
const productInfo = ref(null)
const loadingProduct = ref(false)

// 获取页面参数 - 从onLoad获取URL参数
onLoad((option) => {
  roomId.value = option.roomId || 'room_001'
  roomTitle.value = decodeURIComponent(option.title || '直播间')
  streamerName.value = decodeURIComponent(option.streamerName || '主播')
  productId.value = option.productId || ''
  
  console.log('直播间参数:', {
    roomId: roomId.value,
    title: roomTitle.value,
    streamer: streamerName.value,
    productId: productId.value
  })
  
  // 如果有商品ID，获取商品信息
  if (productId.value) {
    getProductInfo()
  }
  
  // 直接初始化web-view URL
  initWebViewUrl()
})

// 页面栈
const pages = getCurrentPages()
const pageInstance = pages.at(-1) as any

// 页面渲染完毕，绑定动画效果
onReady(() => {
  // #ifdef MP-WEIXIN
  // 微信小程序端执行滚动驱动动画
  pageInstance.animate('.navbar', [
    {backgroundColor: 'transparent'},
    {backgroundColor: '#000'},
  ], 1000, {
    scrollSource: '#scroller',
    startScrollOffset: 0,
    endScrollOffset: 50,
    timeRange: 1000,
  })
  
  pageInstance.animate('.navbar .title', [
    { color: 'transparent' }, 
    { color: '#fff' }], 
    1000, {
      scrollSource: '#scroller',
      timeRange: 1000,
      startScrollOffset: 0,
      endScrollOffset: 50,
  })
  
  pageInstance.animate('.navbar .back', [
    { color: '#fff' }, 
    { color: '#fff' }], 
    1000, {
      scrollSource: '#scroller',
      timeRange: 1000,
      startScrollOffset: 0,
      endScrollOffset: 50,
  })
  // #endif
})

// 直播间信息
interface LiveRoomInfo {
  roomId: string
  title: string
  streamerName: string
  viewerCount: number
  status: number
}

interface ChatMessage {
  user: string
  text: string
  type: 'system' | 'user' | 'streamer'
  timestamp: number
}

// 响应式数据
const remoteVideoRef = ref<any>() // 修改类型为any，支持小程序环境
const chatContainerRef = ref<HTMLElement>()

let websocket: any = null // 修改为any类型，支持uni.connectSocket
let peerConnection: RTCPeerConnection | null = null

// 调试用的状态
const debugInfo = reactive({
  videoElementFound: false,
  streamReceived: false,
  srcObjectSet: false,
  videoPlaying: false
})

const roomInfo = ref<LiveRoomInfo>({
  roomId: '',
  title: '直播间',
  streamerName: '',
  viewerCount: 0,
  status: 0
})

const connectionStatus = reactive({
  connected: false,
  message: '连接中...',
  type: 'warning' as 'success' | 'warning' | 'error'
})

const viewerInfo = reactive({
  nickname: `观众_${Math.floor(Math.random() * 1000)}`,
  userId: '',
})

const chatMessages = ref<ChatMessage[]>([])
const chatInput = ref('')
const showChatPanel = ref(false)
const isPlaying = ref(false)
const isMuted = ref(false)
const isFullscreen = ref(false)
const liveStreamUrl = ref('')

// web-view相关变量
const webViewSrc = ref('')

// 计算属性
const isConnected = computed(() => connectionStatus.connected)
const hasVideo = computed(() => debugInfo.streamReceived && debugInfo.srcObjectSet)

// WebRTC配置
const iceServers = {
  iceServers: [
    { urls: 'stun:stun.l.google.com:19302' },
    { urls: 'stun:stun1.l.google.com:19302' },
  ],
}

// API函数
async function getRoomInfo(roomId: string) {
  try {
    const response = await uni.request({
      url: `/live/live/room/info/${roomId}`,
      method: 'GET'
    })
    return response.data
  } catch (error) {
    console.error('获取直播间信息失败:', error)
    throw error
  }
}

// 获取商品信息
async function getProductInfo() {
  if (!productId.value) return
  
  loadingProduct.value = true
  try {
    const response = await uni.request({
      url: `/live/live/room/product/${productId.value}`,
      method: 'GET'
    })
    
    if (response.data.code === 200) {
      productInfo.value = response.data.data
      console.log('获取商品信息成功:', productInfo.value)
      addChatMessage('系统', `直播商品：${productInfo.value?.name || '商品信息'}`, 'system')
    } else {
      console.error('获取商品信息失败:', response.data.msg)
    }
  } catch (error) {
    console.error('获取商品信息失败:', error)
  } finally {
    loadingProduct.value = false
  }
}

// 初始化连接
const initConnection = async () => {
  try {
    // 生成用户ID
    viewerInfo.userId = `${viewerInfo.nickname}_${Date.now()}`
    
    // 使用导入的connectToRoom函数
    const result = await connectToRoom(roomId.value, viewerInfo.userId, 'viewer')
    
    websocket = result.websocket
    if (result.roomInfo) {
      roomInfo.value = { ...roomInfo.value, ...result.roomInfo }
    }
    
    // WebSocket已在connectToRoom中打开，直接设置其他事件处理函数
    
    // 设置消息接收处理
    websocket.onMessage((res: any) => {
      try {
        const message = JSON.parse(res.data)
        handleWebSocketMessage(message)
      } catch (error) {
        console.error('解析WebSocket消息失败:', error)
      }
    })
    
    // 设置连接关闭处理
    websocket.onClose(() => {
      connectionStatus.connected = false
      connectionStatus.message = '连接已断开'
      connectionStatus.type = 'error'
      cleanUp()
    })
    
    // 连接已建立
    connectionStatus.connected = true
    connectionStatus.message = '已连接到直播间'
    connectionStatus.type = 'success'
    addChatMessage('系统', `欢迎 ${viewerInfo.nickname} 加入直播间！`, 'system')
    
    // 请求观看直播
    setTimeout(() => {
      requestStream()
    }, 1000)
    
  } catch (error) {
    console.error('连接直播间失败:', error)
    uni.showToast({
      title: '连接失败，请重试',
      icon: 'none'
    })
  }
}

// WebSocket消息处理
const handleWebSocketMessage = async (message: any) => {
  console.log('Received signaling message:', message)

  switch (message.type) {
    case 'offer':
      await handleOffer(message)
      break
    case 'ice-candidate':
      await handleIceCandidate(message)
      break
    case 'user-joined':
      addChatMessage('系统', `${message.fromUserId} 加入了直播间`, 'system')
      roomInfo.value.viewerCount++
      break
    case 'user-left':
      addChatMessage('系统', `${message.fromUserId} 离开了直播间`, 'system')
      roomInfo.value.viewerCount = Math.max(0, roomInfo.value.viewerCount - 1)
      break
    case 'chat':
      addChatMessage(message.data.user, message.data.text, 'user')
      break
    case 'heart-beat-ack':
      console.log('心跳确认')
      break
  }
}

// 处理Offer
const handleOffer = async (message: any) => {
  if (!peerConnection) {
    await createPeerConnectionInstance()
  }
  
  if (peerConnection) {
    try {
      await peerConnection.setRemoteDescription(new RTCSessionDescription(message.data))
      const answer = await peerConnection.createAnswer()
      await peerConnection.setLocalDescription(answer)
      sendSignalingMessageToServer({ 
        type: 'answer', 
        data: answer, 
        targetUserId: message.fromUserId 
      })
      addChatMessage('系统', '正在连接直播流...', 'system')
    } catch (error) {
      console.error('处理offer失败:', error)
      addChatMessage('系统', '连接失败，请重试', 'system')
    }
  }
}

// 处理ICE候选者
const handleIceCandidate = async (message: any) => {
  if (peerConnection) {
    try {
      await peerConnection.addIceCandidate(new RTCIceCandidate(message.data))
    } catch (error) {
      console.error('添加ICE候选者失败:', error)
    }
  }
}

// 创建WebRTC连接
const createPeerConnectionInstance = async () => {
  // 根据参考文章，在小程序环境中也要使用WebRTC
  console.log('创建WebRTC连接')
  
  peerConnection = createPeerConnection(iceServers)
  
  peerConnection.ontrack = (event) => {
    console.log('收到远程视频流:', event)
    if (event.streams && event.streams[0]) {
      try {
        console.log('设置视频流到video元素')
        
        // 小程序环境专用的处理方式
        handleVideoStreamInMiniProgram(event.streams[0])
      } catch (error) {
        console.error('设置视频流失败:', error)
        addChatMessage('系统', '设置视频失败，请重试', 'system')
      }
    }
  }
  
  peerConnection.onicecandidate = (event) => {
    if (event.candidate) {
      sendSignalingMessageToServer({ 
        type: 'ice-candidate', 
        data: event.candidate, 
        targetUserId: roomInfo.value.streamerName 
      })
    }
  }
  
  peerConnection.onconnectionstatechange = () => {
    console.log('连接状态变化:', peerConnection?.connectionState)
    if (peerConnection?.connectionState === 'connected') {
      addChatMessage('系统', '直播连接已建立', 'system')
    } else if (peerConnection?.connectionState === 'disconnected') {
      addChatMessage('系统', '直播连接已断开', 'system')
      isPlaying.value = false
    }
  }
}

// 小程序环境专用的视频流处理
const handleVideoStreamInMiniProgram = (stream: MediaStream) => {
  console.log('=== 小程序环境视频流处理 ===')
  
  // 更新调试状态
  debugInfo.streamReceived = true
  
  // 在小程序中，不使用ref，直接使用uni选择器
  let retryCount = 0
  const maxRetries = 3
  
  const trySetVideoStreamWithUni = () => {
    retryCount++
    console.log(`第${retryCount}次尝试使用uni选择器获取video元素...`)
    
    try {
      // 使用uni.createSelectorQuery()直接操作DOM
      const query = uni.createSelectorQuery()
      
      // 获取video元素的节点信息
      query.select('#remoteVideo').fields({
        node: true,
        size: true
      }).exec((res) => {
        console.log('uni查询结果:', res)
        
        if (res && res[0] && res[0].node) {
          const videoNode = res[0].node
          console.log('✅ 通过uni获取到video节点:', videoNode)
          debugInfo.videoElementFound = true
          
          // 直接在video节点上设置流
          setVideoStreamDirectly(videoNode, stream)
        } else {
          console.log('❌ uni查询未返回有效节点')
          
          if (retryCount < maxRetries) {
            console.log(`${retryCount}/${maxRetries} 重试中...`)
            setTimeout(trySetVideoStreamWithUni, 200)
          } else {
            console.error('❌ uni查询重试次数用尽')
            debugInfo.videoElementFound = false
            
            // 最后尝试：直接通过video context操作
            tryVideoContext(stream)
          }
        }
      })
    } catch (error) {
      console.error('uni查询出错:', error)
      if (retryCount < maxRetries) {
        setTimeout(trySetVideoStreamWithUni, 200)
      } else {
        tryVideoContext(stream)
      }
    }
  }
  
  // 延迟开始，确保DOM渲染完成
  setTimeout(trySetVideoStreamWithUni, 100)
}

// 尝试使用video context
const tryVideoContext = (stream: MediaStream) => {
  console.log('=== 尝试使用video context ===')
  
  try {
    // 创建video上下文
    const videoContext = uni.createVideoContext('remoteVideo')
    console.log('video context:', videoContext)
    
    if (videoContext) {
      console.log('✅ 获取到video context')
      debugInfo.videoElementFound = true
      
      // 在小程序中，video context可能不支持直接设置srcObject
      // 但我们可以尝试其他方法
      addChatMessage('系统', '获取到视频上下文，但小程序不支持WebRTC流', 'system')
      
      // 提示用户当前环境的限制
      showMiniProgramLimitation()
    } else {
      console.error('❌ 无法获取video context')
      showMiniProgramLimitation()
    }
  } catch (error) {
    console.error('video context创建失败:', error)
    showMiniProgramLimitation()
  }
}

// 直接在video节点上设置流
const setVideoStreamDirectly = (videoNode: any, stream: MediaStream) => {
  try {
    console.log('=== 直接设置video节点流 ===')
    console.log('videoNode:', videoNode)
    console.log('videoNode类型:', typeof videoNode)
    
    // 检查节点是否有srcObject属性
    if (videoNode && 'srcObject' in videoNode) {
      console.log('✅ video节点支持srcObject')
      
      try {
        videoNode.srcObject = stream
        console.log('✅ 成功设置srcObject到video节点')
        debugInfo.srcObjectSet = true
        isPlaying.value = true
        addChatMessage('系统', '✅ 成功连接到直播流！', 'system')
        
        // 尝试播放
        if (videoNode.play && typeof videoNode.play === 'function') {
          videoNode.play().then(() => {
            console.log('✅ 视频开始播放')
            debugInfo.videoPlaying = true
          }).catch(err => {
            console.log('⚠️ 播放需要用户交互:', err)
          })
        }
        
      } catch (srcError) {
        console.error('❌ 设置srcObject失败:', srcError)
        debugInfo.srcObjectSet = false
        showMiniProgramLimitation()
      }
    } else {
      console.error('❌ video节点不支持srcObject')
      showMiniProgramLimitation()
    }
    
    console.log('=== 最终调试状态 ===', debugInfo)
    
  } catch (error) {
    console.error('❌ 直接设置video节点失败:', error)
    showMiniProgramLimitation()
  }
}

// 显示小程序环境限制说明
const showMiniProgramLimitation = () => {
  console.log('=== 小程序环境限制 ===')
  debugInfo.videoElementFound = false
  debugInfo.srcObjectSet = false
  
  addChatMessage('系统', '⚠️ 当前环境不支持WebRTC视频流', 'system')
  addChatMessage('系统', '小程序环境对WebRTC支持有限', 'system')
  addChatMessage('系统', '建议在浏览器中打开或使用专用直播组件', 'system')
}

// 发送信令消息
const sendSignalingMessageToServer = (message: any) => {
  if (websocket) {
    message.fromUserId = viewerInfo.userId
    sendSignalingMessage(websocket, message)
  }
}

// 请求观看直播
const requestStream = async () => {
  if (!websocket) {
    return
  }
  
  try {
    // 在小程序环境中，我们不需要获取音频权限
    // 直接发送请求观看直播的信令
    sendSignalingMessageToServer({ type: 'request-stream' })
    addChatMessage('系统', '正在请求观看直播...', 'system')
    
  } catch (error) {
    console.error('请求观看失败:', error)
    addChatMessage('系统', '请求观看直播失败，请重试', 'system')
  }
}

// 断开连接
const disconnect = () => {
  if (websocket) {
    try {
      websocket.close({
        success: () => {
          console.log('WebSocket连接已关闭')
        },
        fail: (err: any) => {
          console.error('关闭WebSocket连接失败:', err)
        }
      })
    } catch (error) {
      console.error('关闭WebSocket连接出错:', error)
    }
  }
  cleanUp()
}

// 清理资源
const cleanUp = () => {
  if (peerConnection) {
    try {
      peerConnection.close()
    } catch (error) {
      console.error('关闭RTCPeerConnection失败:', error)
    }
    peerConnection = null
  }
  
  if (remoteVideoRef.value && remoteVideoRef.value.srcObject) {
    try {
      const mediaStream = remoteVideoRef.value.srcObject as MediaStream
      mediaStream.getTracks().forEach(track => track.stop())
      remoteVideoRef.value.srcObject = null
    } catch (error) {
      console.error('清理视频资源失败:', error)
    }
  }
  
  isPlaying.value = false
  websocket = null
}

// 聊天相关
const sendChatMessage = () => {
  if (!chatInput.value.trim() || !isConnected.value) return
  
  const message = {
    type: 'chat',
    data: {
      user: viewerInfo.nickname,
      text: chatInput.value,
    }
  }
  
  sendSignalingMessageToServer(message)
  addChatMessage(viewerInfo.nickname, chatInput.value, 'user')
  chatInput.value = ''
}

const addChatMessage = (user: string, text: string, type: ChatMessage['type'] = 'system') => {
  chatMessages.value.push({
    user,
    text,
    type,
    timestamp: Date.now()
  })
  
  nextTick(() => {
    if (chatContainerRef.value) {
      chatContainerRef.value.scrollTop = chatContainerRef.value.scrollHeight
    }
  })
}

const formatTime = (timestamp: number) => {
  return new Date(timestamp).toLocaleTimeString()
}

// 视频控制
const togglePlay = () => {
  if (remoteVideoRef.value) {
    if (isPlaying.value) {
      remoteVideoRef.value.pause()
    } else {
      remoteVideoRef.value.play()
    }
    isPlaying.value = !isPlaying.value
  }
}

const toggleMute = () => {
  if (remoteVideoRef.value) {
    remoteVideoRef.value.muted = !remoteVideoRef.value.muted
    isMuted.value = remoteVideoRef.value.muted
  }
}

const toggleFullscreen = () => {
  if (remoteVideoRef.value) {
    if (!isFullscreen.value) {
      remoteVideoRef.value.requestFullscreen?.()
    } else {
      document.exitFullscreen?.()
    }
    isFullscreen.value = !isFullscreen.value
  }
}

const toggleChatPanel = () => {
  showChatPanel.value = !showChatPanel.value
}

// 复制直播间ID
const copyRoomId = () => {
  uni.setClipboardData({
    data: roomInfo.value.roomId,
    success: () => {
      uni.showToast({
        title: '直播间ID已复制',
        icon: 'success'
      })
    }
  })
}

// 生命周期
onUnload(() => {
  disconnect()
})

// 处理网络状态
const handleNetStatus = (e: any) => {
  console.log('网络状态:', e.detail)
  const info = e.detail?.info
  if (info) {
    console.log(`视频码率: ${info.videoBitrate}, 音频码率: ${info.audioBitrate}`)
  }
}

// 处理视频播放事件
const handleVideoPlay = () => {
  console.log('视频开始播放')
  isPlaying.value = true
  addChatMessage('系统', '视频开始播放', 'system')
}

// 处理视频暂停事件
const handleVideoPause = () => {
  console.log('视频已暂停')
  isPlaying.value = false
}

// 处理视频结束事件
const handleVideoEnded = () => {
  console.log('视频播放结束')
  isPlaying.value = false
}

// 处理视频加载开始
const handleVideoLoadStart = () => {
  console.log('视频开始加载')
}

// 处理视频可以播放
const handleVideoCanPlay = () => {
  console.log('视频可以播放')
  addChatMessage('系统', '视频流已准备就绪', 'system')
}

// 处理视频错误
const handleVideoError = (e: any) => {
  console.error('视频播放错误:', e)
  const error = e.target?.error
  if (error) {
    console.error('错误代码:', error.code, '错误信息:', error.message)
    addChatMessage('系统', `视频播放错误: ${error.message || '未知错误'}`, 'system')
  }
}

// 单独的函数来设置视频流
const setVideoStream = (videoElement: any, stream: MediaStream) => {
  try {
    console.log('=== 开始设置视频流 ===')
    console.log('videoElement:', videoElement)
    console.log('stream:', stream)
    console.log('stream.getTracks():', stream.getTracks())
    
    // 更新调试状态
    debugInfo.streamReceived = true
    debugInfo.videoElementFound = !!videoElement
    
    if (!videoElement) {
      console.error('videoElement 为空')
      addChatMessage('系统', '视频元素未找到', 'system')
      return
    }
    
    // 检查流是否有效
    const videoTracks = stream.getVideoTracks()
    const audioTracks = stream.getAudioTracks()
    console.log('视频轨道数量:', videoTracks.length)
    console.log('音频轨道数量:', audioTracks.length)
    
    if (videoTracks.length === 0) {
      console.warn('没有视频轨道')
      addChatMessage('系统', '接收到的流中没有视频轨道', 'system')
    }
    
    // 尝试设置srcObject
    try {
      console.log('尝试设置 srcObject...')
      
      if ('srcObject' in videoElement) {
        videoElement.srcObject = stream
        console.log('✅ 成功设置 srcObject')
        debugInfo.srcObjectSet = true
        
        // 监听视频元素的事件
        videoElement.onloadedmetadata = () => {
          console.log('✅ 视频元数据加载完成')
          console.log('视频尺寸:', videoElement.videoWidth, 'x', videoElement.videoHeight)
        }
        
        videoElement.oncanplay = () => {
          console.log('✅ 视频可以播放了')
        }
        
        videoElement.onplay = () => {
          console.log('✅ 视频开始播放')
          debugInfo.videoPlaying = true
          isPlaying.value = true
        }
        
      } else {
        console.error('❌ video元素不支持 srcObject 属性')
        addChatMessage('系统', '当前环境不支持 srcObject', 'system')
        return
      }
    } catch (srcError) {
      console.error('❌ 设置 srcObject 失败:', srcError)
      addChatMessage('系统', '设置视频源失败', 'system')
      return
    }
    
    // 尝试播放
    console.log('尝试播放视频...')
    if (videoElement.play && typeof videoElement.play === 'function') {
      videoElement.play().then(() => {
        console.log('✅ 视频播放成功')
        debugInfo.videoPlaying = true
        isPlaying.value = true
        addChatMessage('系统', '✅ 成功连接到直播流！', 'system')
      }).catch(err => {
        console.log('⚠️ 自动播放失败，需要用户交互:', err)
        addChatMessage('系统', '请点击播放按钮开始观看', 'system')
        debugInfo.srcObjectSet = true // 流已设置，只是播放需要用户交互
      })
    } else {
      console.log('⚠️ video元素没有play方法')
      debugInfo.srcObjectSet = true
      addChatMessage('系统', '✅ 视频流已设置', 'system')
    }
    
    // 输出最终的调试状态
    console.log('=== 调试状态 ===', debugInfo)
    
  } catch (error) {
    console.error('❌ 设置视频流过程中出错:', error)
    addChatMessage('系统', '设置视频流失败，请重试', 'system')
  }
}

// 强制重试视频流设置
const forceRetryVideoSetup = (stream: MediaStream) => {
  console.log('强制重试视频流设置...')
  // 在小程序环境中，我们无法直接操作DOM元素，
  // 所以这里只是记录一下，实际不会生效。
  // 如果需要强制重试，可以考虑重新初始化整个页面或组件。
  // 例如，可以尝试重新调用 initConnection 或重新加载页面。
  // 但要注意，这可能会导致不必要的重连或状态混乱。
  // 目前，我们只是记录日志，并提示用户刷新页面。
  console.warn('小程序环境无法强制重试视频流设置，请尝试刷新页面。')
  addChatMessage('系统', '无法获取视频元素，请刷新页面重试', 'system')
}

// 初始化WebView URL
const initWebViewUrl = () => {
  // 手动构建URL参数，避免使用URLSearchParams（小程序不支持）
  const params = [
    `roomId=${encodeURIComponent(roomId.value)}`,
    `streamerName=${encodeURIComponent(streamerName.value)}`,
    `title=${encodeURIComponent(roomTitle.value)}`,
    `role=viewer`
  ]
  
  // 如果有商品ID，添加到参数中
  if (productId.value) {
    params.push(`productId=${encodeURIComponent(productId.value)}`)
  }
  
  const paramString = params.join('&')
  
  // 使用您的IP地址部署WebRTC页面
  const baseUrl = 'http://pocketapp.mynatapp.cc/webView'  // 您的服务器IP:端口
  // 现在使用真正的WebRTC页面
  webViewSrc.value = `${baseUrl}/webrtc-viewer.html?${paramString}`
  
  console.log('WebView URL:', webViewSrc.value)
  addChatMessage('系统', '正在加载WebRTC视频组件...', 'system')
}

// 处理web-view消息
const handleWebViewMessage = (event: any) => {
  console.log('🔄 接收到WebView消息:', event)
  console.log('🔄 event.detail:', event.detail)
  
  // 处理不同的消息格式
  let data = null
  if (event.detail && event.detail.data) {
    // 标准uni-app格式
    data = Array.isArray(event.detail.data) ? event.detail.data[0] : event.detail.data
  } else if (event.detail) {
    // 直接在detail中
    data = event.detail
  } else {
    // 消息在顶层
    data = event
  }
  
  console.log('📨 解析后的消息数据:', data)
  
  if (!data || !data.type) {
    console.log('⚠️ 无效的消息格式')
    return
  }
  
  // 根据消息类型处理
  switch (data.type) {
    case 'webrtc-connected':
      console.log('✅ WebRTC连接成功')
      connectionStatus.connected = true
      connectionStatus.message = '已连接到直播间'
      connectionStatus.type = 'success'
      
      debugInfo.streamReceived = true
      debugInfo.videoElementFound = true
      debugInfo.srcObjectSet = true
      
      isPlaying.value = true
      addChatMessage('系统', '✅ WebRTC连接成功！', 'system')
      break
      
    case 'webrtc-error':
      console.log('❌ WebRTC连接错误:', data.message)
      connectionStatus.connected = false
      connectionStatus.message = '连接失败'
      connectionStatus.type = 'error'
      addChatMessage('系统', `WebRTC错误: ${data.message}`, 'system')
      break
      
    case 'video-playing':
      console.log('📺 视频开始播放')
      debugInfo.videoPlaying = true
      isPlaying.value = true
      addChatMessage('系统', '📺 视频开始播放', 'system')
      break
      
    case 'test-message':
      console.log('🧪 收到测试消息:', data.message)
      addChatMessage('WebView', data.message, 'system')
      break
      
    case 'navigate-to-product':
      console.log('🛍️ 跳转到商品详情:', data.data)
      // 处理商品详情页跳转
      if (data.data && data.data.url) {
        uni.navigateTo({
          url: data.data.url,
          success: () => {
            console.log('跳转商品详情页成功')
          },
          fail: (err) => {
            console.error('跳转商品详情页失败:', err)
            uni.showToast({
              title: '跳转失败',
              icon: 'none'
            })
          }
        })
      }
      break
      
    default:
      console.log('🔄 未知消息类型:', data.type)
      addChatMessage('系统', `收到消息: ${data.type}`, 'system')
  }
}

// 向web-view发送消息
const sendWebViewMessage = (message: any) => {
  // 在小程序中，需要通过其他方式与web-view通信
  // 可以通过URL参数或localStorage等方式
  console.log('发送消息到WebView:', message)
}

// 判断是否为小程序环境
const isMiniprogramEnv = computed(() => {
  return uni.getSystemInfoSync().platform === 'mp-weixin'
})

// 商品相关函数
const getProductImage = () => {
  // 从productSku.thumbImg获取商品图片
  if (productInfo.value?.productSku?.thumbImg) {
    return productInfo.value.productSku.thumbImg
  }
  return getDefaultProductImage()
}

const getDefaultProductImage = () => {
  return 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIyMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+CjxwYXRoIGQ9Ik04MCA4MEgxMjBWMTIwSDgwVjgwWiIgZmlsbD0iI0NDQyIvPgo8dGV4dCB4PSIxMDAiIHk9IjE0MCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSIgZm9udC1zaXplPSIxMiI+5ZWG5ZOB5Zu+54mHPC90ZXh0Pgo8L3N2Zz4K'
}

const handleProductImageError = (e) => {
  e.target.src = getDefaultProductImage()
}

const formatPrice = (price) => {
  if (!price) return '0.00'
  return Number(price).toFixed(2)
}

// 获取商品价格
const getProductPrice = () => {
  return productInfo.value?.productSku?.salePrice || 0
}

const goToProductDetail = () => {
  if (!productInfo.value?.id) {
    uni.showToast({
      title: '商品信息加载中',
      icon: 'none'
    })
    return
  }
  
  // 跳转到商品详情页
  uni.navigateTo({
    url: `/pages/goods/goods?id=${productInfo.value.id}`
  })
}

// 打开浏览器
const openInBrowser = () => {
  uni.navigateTo({
    url: `/pages/index/index?roomId=${roomId.value}&title=${encodeURIComponent(roomTitle.value)}&streamerName=${encodeURIComponent(streamerName.value)}`
  })
}
</script>

<template>
  <!-- 自定义导航栏 -->
  <view class="navbar" :style="{ paddingTop: safeAreaInsets?.top + 'px' }">
    <view class="wrap">
      <navigator v-if="pages.length > 1" open-type="navigateBack" class="back icon-left"></navigator>
      <navigator v-else url="/pages/index/index" open-type="switchTab" class="back icon-home"></navigator>
      <view class="title">{{ roomInfo.title || '直播间' }}</view>
      <view class="viewer-count">{{ roomInfo.viewerCount || 0 }}</view>
    </view>
  </view>

  <scroll-view scroll-y class="viewport" id="scroller">
    <!-- 直播视频区域 -->
    <view class="video-section" :style="{ paddingTop: safeAreaInsets!.top + 44 + 'px' }">
      <view class="video-container">
        <!-- 使用web-view加载部署的WebRTC页面 -->
        <web-view 
          :src="webViewSrc"
          class="video-player"
          @message="handleWebViewMessage"
          @onPostMessage="handleWebViewMessage"
        ></web-view>
        
        <!-- 简洁的加载状态 -->
        <view v-if="!isPlaying && !isConnected" class="loading-overlay">
          <view class="loading-spinner"></view>
          <text class="loading-text">连接中...</text>
        </view>
        
        <!-- 简洁的直播信息栏 -->
        <view class="live-info-bar" v-if="isPlaying">
          <view class="live-indicator">
            <view class="live-dot"></view>
            <text>LIVE</text>
          </view>
        </view>

        <!-- 简洁的视频控制 -->
        <view class="video-controls" v-if="isPlaying">
          <view class="control-btn" @tap="toggleMute">
            <text class="icon">{{ isMuted ? '🔇' : '🔊' }}</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 直播间信息 -->
    <view class="room-info">
      <view class="streamer-info">
        <view class="avatar">👤</view>
        <view class="info">
          <view class="name">{{ roomInfo.streamerName || '主播' }}</view>
          <view class="room-id" @tap="copyRoomId">
            直播间: {{ roomInfo.roomId }} 
            <text class="copy-icon">📋</text>
          </view>
        </view>
      </view>
      <view class="live-status" :class="{ active: isPlaying }">
        <text class="status-text">{{ isPlaying ? '直播中' : '未开播' }}</text>
      </view>
    </view>

    <!-- 商品信息展示区域 -->
    <view class="product-info" v-if="productInfo && !loadingProduct">
      <view class="product-card" @tap="goToProductDetail">
        <view class="product-image-container">
          <image 
            class="product-image" 
            :src="getProductImage()" 
            mode="aspectFill"
            @error="handleProductImageError"
          ></image>
          <view class="product-badge">直播商品</view>
        </view>
        <view class="product-details">
          <view class="product-name">{{ productInfo?.name || '商品名称' }}</view>
          <view class="product-price">¥{{ formatPrice(getProductPrice()) }}</view>
          <view class="product-action">
            <text class="action-text">点击查看详情 ></text>
          </view>
        </view>
      </view>
    </view>

    <!-- 聊天消息列表 -->
    <view class="chat-preview" v-if="chatMessages.length > 0 && !showChatPanel">
      <view class="chat-item" v-for="(msg, index) in chatMessages.slice(-3)" :key="index">
        <text class="chat-user" :class="msg.type">{{ msg.user }}:</text>
        <text class="chat-text">{{ msg.text }}</text>
      </view>
    </view>
  </scroll-view>

  <!-- 底部操作栏 -->
  <view class="bottom-bar" :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }">
    <view class="chat-input-container">
      <input 
        v-model="chatInput"
        class="chat-input"
        placeholder="说点什么..."
        @confirm="sendChatMessage"
        :disabled="!isConnected"
      />
      <button class="send-btn" @tap="sendChatMessage" :disabled="!chatInput.trim() || !isConnected">
        发送
      </button>
    </view>
    <view class="action-btns">
      <button class="action-btn" @tap="toggleChatPanel">
        💬 聊天
      </button>
    </view>
  </view>

  <!-- 聊天面板 -->
  <view class="chat-panel" :class="{ show: showChatPanel }">
    <view class="chat-header">
      <text class="chat-title">聊天室</text>
      <button class="close-btn" @tap="toggleChatPanel">✕</button>
    </view>
    <scroll-view scroll-y class="chat-messages" ref="chatContainerRef">
      <view class="chat-message" v-for="(msg, index) in chatMessages" :key="index">
        <view class="message-time">{{ formatTime(msg.timestamp) }}</view>
        <view class="message-content" :class="msg.type">
          <text class="message-user">{{ msg.user }}:</text>
          <text class="message-text">{{ msg.text }}</text>
        </view>
      </view>
    </scroll-view>
  </view>

  <!-- 连接状态提示 -->
  <view class="connection-toast" :class="connectionStatus.type" v-if="!isConnected">
    {{ connectionStatus.message }}
  </view>

</template>

<style lang="scss">
page {
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow: hidden;
  background-color: #000;
}

.navbar {
  width: 750rpx;
  color: #fff;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 9;
  background-color: transparent;

  .wrap {
    position: relative;
    display: flex;
    align-items: center;
    height: 44px;
    padding: 0 20rpx;

    .title {
      flex: 1;
      text-align: center;
      font-size: 32rpx;
      font-weight: bold;
    }

    .back {
      position: absolute;
      left: 20rpx;
      height: 44px;
      width: 44px;
      font-size: 44rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
    }

    .viewer-count {
      position: absolute;
      right: 20rpx;
      font-size: 24rpx;
      padding: 8rpx 16rpx;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 20rpx;
    }
  }
}

.viewport {
  flex: 1;
  background-color: #000;
}

.video-section {
  position: relative;
}

.video-container {
  position: relative;
  width: 100%;
  height: 400rpx;
  background: #000;
}

.video-player {
  width: 100%;
  height: 100%;
  background: #000;
  border-radius: 12px;
  overflow: hidden;
}

.miniprogram-notice {
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.notice-content {
  text-align: center;
  color: white;
  padding: 40px 20px;
}

.notice-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.notice-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 12px;
}

.notice-desc {
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 24px;
  opacity: 0.9;
}

.notice-btn {
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 12px 24px;
  border-radius: 25px;
  font-size: 14px;
  backdrop-filter: blur(10px);
}

  .notice-btn:hover {
    background: rgba(255, 255, 255, 0.3);
  }
  
  .loading-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.9);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    z-index: 10;
  }
  
  .loading-spinner {
    width: 40px;
    height: 40px;
    border: 3px solid rgba(255, 255, 255, 0.3);
    border-top: 3px solid #fff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 16px;
  }
  
  .loading-text {
    color: white;
    font-size: 16px;
  }
  
  .live-info-bar {
    position: absolute;
    top: 20rpx;
    left: 20rpx;
    z-index: 20;
  }
  
  .live-indicator {
    display: flex;
    align-items: center;
    background: rgba(255, 0, 0, 0.8);
    color: white;
    padding: 8rpx 16rpx;
    border-radius: 20rpx;
    font-size: 24rpx;
    font-weight: bold;
  }
  
  .live-dot {
    width: 8rpx;
    height: 8rpx;
    background: white;
    border-radius: 50%;
    margin-right: 8rpx;
    animation: blink 2s infinite;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  @keyframes blink {
    0%, 50% { opacity: 1; }
    51%, 100% { opacity: 0.3; }
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
  background: rgba(0, 0, 0, 0.8);
}

.loading-container, .error-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #fff;
}

.loading-icon, .error-icon {
  font-size: 80rpx;
  margin-bottom: 20rpx;
}

.loading-text, .error-text {
  font-size: 28rpx;
  margin-bottom: 20rpx;
}

.retry-btn {
  padding: 16rpx 32rpx;
  background: #007aff;
  color: #fff;
  border-radius: 8rpx;
  border: none;
  font-size: 28rpx;
}

.video-controls {
  position: absolute;
  bottom: 20rpx;
  right: 20rpx;
  display: flex;
  gap: 16rpx;
}

.control-btn {
  width: 80rpx;
  height: 80rpx;
  background: rgba(0, 0, 0, 0.6);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;

  .icon {
    font-size: 32rpx;
  }
}

.room-info {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 30rpx;
  background: #1a1a1a;
  border-bottom: 1px solid #333;
}

.streamer-info {
  display: flex;
  align-items: center;
  flex: 1;
}

.avatar {
  width: 80rpx;
  height: 80rpx;
  background: #333;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40rpx;
  margin-right: 20rpx;
}

.info {
  flex: 1;

  .name {
    color: #fff;
    font-size: 32rpx;
    font-weight: bold;
    margin-bottom: 8rpx;
  }

  .room-id {
    color: #999;
    font-size: 24rpx;
    display: flex;
    align-items: center;

    .copy-icon {
      margin-left: 8rpx;
      font-size: 20rpx;
    }
  }
}

.live-status {
  padding: 8rpx 16rpx;
  border-radius: 20rpx;
  border: 1px solid #666;

  .status-text {
    color: #999;
    font-size: 24rpx;
  }

  &.active {
    background: #ff3333;
    border-color: #ff3333;

    .status-text {
      color: #fff;
    }
  }
}

.product-info {
  padding: 20rpx 30rpx;
  background: #1a1a1a;
}

.product-card {
  background: #2a2a2a;
  border-radius: 12rpx;
  padding: 20rpx;
  display: flex;
  align-items: center;
  gap: 20rpx;
  border: 1px solid #333;
  transition: all 0.3s ease;
}

.product-card:active {
  transform: scale(0.98);
  background: #333;
}

.product-image-container {
  position: relative;
  width: 120rpx;
  height: 120rpx;
  flex-shrink: 0;
}

.product-image {
  width: 100%;
  height: 100%;
  border-radius: 8rpx;
  background: #f5f5f5;
}

.product-badge {
  position: absolute;
  top: -8rpx;
  right: -8rpx;
  background: #ff3333;
  color: white;
  font-size: 18rpx;
  padding: 4rpx 8rpx;
  border-radius: 8rpx;
  font-weight: bold;
}

.product-details {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.product-name {
  color: #fff;
  font-size: 28rpx;
  font-weight: bold;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-price {
  color: #ff6b35;
  font-size: 32rpx;
  font-weight: bold;
}

.product-action {
  margin-top: 8rpx;
}

.action-text {
  color: #007aff;
  font-size: 24rpx;
  font-weight: 500;
}

.chat-preview {
  padding: 20rpx 30rpx;
  background: #1a1a1a;
  max-height: 200rpx;
  overflow: hidden;
}

.chat-item {
  display: flex;
  margin-bottom: 12rpx;
  font-size: 24rpx;

  .chat-user {
    color: #007aff;
    margin-right: 8rpx;
    
    &.system { color: #999; }
    &.streamer { color: #ff3333; }
  }

  .chat-text {
    color: #fff;
    flex: 1;
  }
}

.bottom-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20rpx;
  background: #1a1a1a;
  border-top: 1px solid #333;
  display: flex;
  align-items: center;
  gap: 20rpx;
}

.chat-input-container {
  flex: 1;
  display: flex;
  align-items: center;
  background: #333;
  border-radius: 40rpx;
  padding: 0 20rpx;
}

.chat-input {
  flex: 1;
  height: 60rpx;
  color: #fff;
  font-size: 28rpx;
  background: transparent;
  border: none;
  outline: none;
}

.send-btn {
  padding: 12rpx 20rpx;
  background: #007aff;
  color: #fff;
  border-radius: 20rpx;
  border: none;
  font-size: 24rpx;
  
  &:disabled {
    background: #666;
  }
}

.action-btns {
  display: flex;
  gap: 16rpx;
}

.action-btn {
  padding: 16rpx 24rpx;
  background: #333;
  color: #fff;
  border-radius: 20rpx;
  border: none;
  font-size: 24rpx;
}

.chat-panel {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60%;
  background: #1a1a1a;
  transform: translateY(100%);
  transition: transform 0.3s ease;
  z-index: 10;

  &.show {
    transform: translateY(0);
  }
}

.chat-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 30rpx;
  border-bottom: 1px solid #333;

  .chat-title {
    color: #fff;
    font-size: 32rpx;
    font-weight: bold;
  }

  .close-btn {
    width: 60rpx;
    height: 60rpx;
    background: #333;
    color: #fff;
    border: none;
    border-radius: 50%;
    font-size: 24rpx;
  }
}

.chat-messages {
  flex: 1;
  padding: 20rpx;
}

.chat-message {
  margin-bottom: 24rpx;

  .message-time {
    color: #666;
    font-size: 20rpx;
    text-align: center;
    margin-bottom: 8rpx;
  }

  .message-content {
    display: flex;
    font-size: 28rpx;

    .message-user {
      margin-right: 8rpx;
      color: #007aff;
      
      &.system { color: #999; }
      &.streamer { color: #ff3333; }
    }

    .message-text {
      color: #fff;
      flex: 1;
    }
  }
}

.connection-toast {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  padding: 20rpx 40rpx;
  border-radius: 8rpx;
  color: #fff;
  font-size: 28rpx;
  z-index: 100;

  &.warning {
    background: #ff9500;
  }

  &.error {
    background: #ff3333;
  }

  &.success {
    background: #34c759;
  }
}
</style> 