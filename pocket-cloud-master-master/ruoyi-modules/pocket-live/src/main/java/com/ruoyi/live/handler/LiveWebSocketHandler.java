package com.ruoyi.live.handler;

import com.alibaba.fastjson2.JSON;

import com.ruoyi.live.domain.message.SignalingMessage;
import com.ruoyi.live.service.ILiveRoomService;
import com.ruoyi.live.service.ILiveSessionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.net.URI;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;


//直播WebSocket处理器
//处理WebRTC信令交换和实时通信

@Slf4j
@Component
public class LiveWebSocketHandler implements WebSocketHandler {

    @Autowired
    private ILiveRoomService liveRoomService;
    
    @Autowired
    private ILiveSessionService liveSessionService;

    // 存储WebSocket会话，roomId -> Map<userId, WebSocketSession>
    private final Map<String, Map<String, WebSocketSession>> roomSessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String roomId = extractRoomId(session);
        String userId = extractUserId(session);
        
        log.info("用户 {} 连接到直播间 {}", userId, roomId);
        
        // 将会话添加到房间
        roomSessions.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>())
                   .put(userId, session);
        
        // 记录用户加入直播间
        liveSessionService.userJoinRoom(roomId, userId, session.getId());
        
        // 从session attributes中获取用户角色（前端设置的role参数）
        String userRole = (String) session.getAttributes().get("role");
        log.info("从session attributes获取到用户 {} 的角色参数: {}", userId, userRole);
        
        if (userRole != null) {
            liveSessionService.setUserRole(roomId, userId, userRole);
            log.info("设置用户 {} 在房间 {} 中的角色为: {}", userId, roomId, userRole);
        } else {
            log.warn("用户 {} 连接时未提供角色参数", userId);
        }
        
        // 验证角色设置结果
        String actualRole = liveSessionService.getUserRole(roomId, userId);
        log.info("用户 {} 在房间 {} 中的最终角色: {}", userId, roomId, actualRole);
        
        // 通知房间内其他用户有新用户加入
        broadcastToRoom(roomId, new SignalingMessage("user-joined", userId, null), userId);
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        String roomId = extractRoomId(session);
        String userId = extractUserId(session);
        
        try {
            SignalingMessage signalingMessage = JSON.parseObject(message.getPayload().toString(), SignalingMessage.class);
            
            log.debug("收到来自用户 {} 的消息: {}", userId, signalingMessage.getType());
            
            switch (signalingMessage.getType()) {
                case "offer":
                case "answer":
                case "ice-candidate":
                    // WebRTC信令消息，转发给目标用户
                    forwardSignalingMessage(roomId, signalingMessage, userId);
                    break;
                case "request-stream":
                    // 观众请求观看直播，转发给主播
                    log.info("观众 {} 请求观看直播间 {} 的直播", userId, roomId);
                    // 查找房间内的主播并转发请求
                    forwardToStreamer(roomId, signalingMessage, userId);
                    break;
                case "chat":
                    // 聊天消息，广播给所有用户
                    broadcastToRoom(roomId, signalingMessage, null);
                    break;
                case "heart-beat":
                    // 心跳消息，回复确认
                    session.sendMessage(new TextMessage(JSON.toJSONString(
                        new SignalingMessage("heart-beat-ack", userId, null))));
                    break;
                default:
                    log.warn("未知的消息类型: {}", signalingMessage.getType());
            }
        } catch (Exception e) {
            log.error("处理WebSocket消息时发生错误", e);
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        log.error("WebSocket传输错误: {}", exception.getMessage());
        session.close(CloseStatus.SERVER_ERROR);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        String roomId = extractRoomId(session);
        String userId = extractUserId(session);
        
        log.info("用户 {} 离开直播间 {}", userId, roomId);
        
        // 从房间移除会话
        Map<String, WebSocketSession> roomSession = roomSessions.get(roomId);
        if (roomSession != null) {
            roomSession.remove(userId);
            if (roomSession.isEmpty()) {
                roomSessions.remove(roomId);
            }
        }
        
        // 记录用户离开直播间
        liveSessionService.userLeaveRoom(roomId, userId);
        
        // 通知房间内其他用户有用户离开
        broadcastToRoom(roomId, new SignalingMessage("user-left", userId, null), userId);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 转发信令消息给目标用户
     */
    private void forwardSignalingMessage(String roomId, SignalingMessage message, String fromUserId) {
        String targetUserId = message.getTargetUserId();
        if (targetUserId == null) {
            log.warn("信令消息缺少目标用户ID");
            return;
        }
        
        Map<String, WebSocketSession> roomSession = roomSessions.get(roomId);
        if (roomSession != null) {
            WebSocketSession targetSession = roomSession.get(targetUserId);
            if (targetSession != null && targetSession.isOpen()) {
                try {
                    message.setFromUserId(fromUserId);
                    targetSession.sendMessage(new TextMessage(JSON.toJSONString(message)));
                } catch (IOException e) {
                    log.error("转发信令消息失败", e);
                }
            }
        }
    }


    //转发消息给主播
    //使用角色管理服务来准确识别主播
    private void forwardToStreamer(String roomId, SignalingMessage message, String fromUserId) {
        Map<String, WebSocketSession> roomSession = roomSessions.get(roomId);
        if (roomSession != null) {
            log.info("房间 {} 中当前用户列表:", roomId);
            // 查找房间内的主播
            for (Map.Entry<String, WebSocketSession> entry : roomSession.entrySet()) {
                String userId = entry.getKey();
                WebSocketSession session = entry.getValue();
                
                // 使用服务层查询用户角色
                String userRole = liveSessionService.getUserRole(roomId, userId);
                log.info("用户 {} 的角色: {}, 会话状态: {}", userId, userRole, session.isOpen() ? "开启" : "关闭");
                
                if ("streamer".equals(userRole) && session.isOpen()) {
                    try {
                        message.setFromUserId(fromUserId);
                        message.setTargetUserId(userId);
                        session.sendMessage(new TextMessage(JSON.toJSONString(message)));
                        log.info("已将观看请求转发给主播: {}", userId);
                        return;
                    } catch (IOException e) {
                        log.error("转发观看请求给主播失败", e);
                    }
                }
            }
            log.warn("房间 {} 中未找到主播", roomId);
        } else {
            log.warn("房间 {} 不存在", roomId);
        }
    }

    //向房间内所有用户广播消息
    private void broadcastToRoom(String roomId, SignalingMessage message, String excludeUserId) {
        Map<String, WebSocketSession> roomSession = roomSessions.get(roomId);
        if (roomSession != null) {
            roomSession.forEach((userId, session) -> {
                if (!userId.equals(excludeUserId) && session.isOpen()) {
                    try {
                        session.sendMessage(new TextMessage(JSON.toJSONString(message)));
                    } catch (IOException e) {
                        log.error("广播消息失败", e);
                    }
                }
            });
        }
    }



    private String extractRoomId(WebSocketSession session) {
        URI uri = session.getUri();
        if (uri != null) {
            String path = uri.getPath();
            String[] segments = path.split("/");
            if (segments.length > 0) {
                return segments[segments.length - 1];
            }
        }
        return "default";
    }


    private String extractUserId(WebSocketSession session) {
        // 首先从session attributes中获取用户ID
        Object userId = session.getAttributes().get("userId");
        if (userId != null) {
            return userId.toString();
        }
        
        // 尝试从URI查询参数中获取用户ID
        URI uri = session.getUri();
        if (uri != null && uri.getQuery() != null) {
            String query = uri.getQuery();
            String[] params = query.split("&");
            for (String param : params) {
                String[] keyValue = param.split("=");
                if (keyValue.length == 2 && "userId".equals(keyValue[0])) {
                    return keyValue[1];
                }
            }
        }
        
        // 如果没有设置用户ID，使用session ID作为临时ID
        return "user_" + session.getId().substring(0, 8);
    }
} 