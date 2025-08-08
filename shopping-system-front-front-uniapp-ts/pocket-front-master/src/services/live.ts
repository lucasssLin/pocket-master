// 导入http工具
import { http } from "@/utils/http";

// 声明uni对象，避免类型错误
declare const uni: any;

// 定义类型
export interface PageParams {
  page: number
  pageSize: number
  status?: number
}

export interface LiveRoomInfo {
  roomId: string
  title: string
  streamerName: string
  streamerId?: string
  viewerCount?: number
  status: number
  startTime?: string
  endTime?: string
  coverImage?: string
  description?: string
}

export interface ApiResponse<T = any> {
  code: number
  msg: string
  data: T
}

// 直播间列表API
export const getLiveRoomListAPI = (params: PageParams) => {
  return http<ApiResponse<{ rows: LiveRoomInfo[], total: number }>>({
    method: 'GET',
    url: `/live/live/room/list/${params.page}/${params.pageSize}`,
    params: {
      status: params.status
    }
  })
}

// 获取直播间信息API
export const getLiveRoomInfoAPI = (roomId: string) => {
  return http<ApiResponse<{ liveRoom: LiveRoomInfo, onlineUsers: number }>>({
    method: 'GET',
    url: `/live/live/room/info/${roomId}`
  })
}

// 创建直播间API
export const createLiveRoomAPI = (data: Partial<LiveRoomInfo>) => {
  return http<ApiResponse<LiveRoomInfo>>({
    method: 'POST',
    url: '/live/live/room/create',
    data
  })
}

// 开始直播API
export const startLiveAPI = (roomId: string) => {
  return http<ApiResponse>({
    method: 'PUT',
    url: `/live/live/room/start/${roomId}`
  })
}

// 结束直播API
export const endLiveAPI = (roomId: string) => {
  return http<ApiResponse>({
    method: 'PUT',
    url: `/live/live/room/end/${roomId}`
  })
}

// 连接到直播间
export const connectToRoom = async (roomId: string, userId: string, role: 'viewer' | 'streamer'): Promise<{
  websocket: any;
  roomInfo?: LiveRoomInfo;
}> => {
  try {
    // 获取直播间信息
    const roomInfo = await getLiveRoomInfoAPI(roomId)

    // 建立WebSocket连接 - 使用uni.connectSocket代替原生WebSocket
    const wsUrl = `ws://192.168.1.12:9213/live/signaling/${roomId}?userId=${userId}&role=${role}`

    // 小程序环境中直接使用uni.connectSocket
    const socketTask = uni.connectSocket({
      url: wsUrl,
      success: (res) => {
        console.log('WebSocket连接创建成功', res)
      },
      fail: (err) => {
        console.error('WebSocket连接创建失败:', err)
      }
    })

    // 等待连接打开
    return new Promise((resolve, reject) => {
      // 设置连接打开的处理函数
      socketTask.onOpen(() => {
        console.log('WebSocket连接已打开')
        resolve({
          websocket: socketTask,
          roomInfo: roomInfo.data?.liveRoom
        })
      })

      // 设置错误处理函数
      socketTask.onError((error) => {
        console.error('WebSocket连接错误:', error)
        reject(error)
      })

      // 设置超时
      setTimeout(() => {
        reject(new Error('WebSocket连接超时'))
      }, 5000)
    })
  } catch (error) {
    console.error('连接直播间失败:', error)
    throw error
  }
}

// 创建WebRTC连接
export const createPeerConnection = (iceServers: RTCConfiguration): RTCPeerConnection => {
  const peerConnection = new RTCPeerConnection(iceServers)
  return peerConnection
}

// 发送信令消息
export interface SignalingMessage {
  type: string;
  data?: any;
  targetUserId?: string;
  fromUserId?: string;
}

export const sendSignalingMessage = (websocket: any, message: SignalingMessage): void => {
  if (websocket) {
    try {
      websocket.send({
        data: JSON.stringify(message),
        success: () => {
          console.log('信令消息发送成功:', message.type)
        },
        fail: (err: any) => {
          console.error('信令消息发送失败:', err)
        }
      })
    } catch (error) {
      console.error('发送信令消息错误:', error)
    }
  }
} 