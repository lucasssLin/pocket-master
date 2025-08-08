package com.ruoyi.live.service.impl;

import com.ruoyi.live.service.ILiveSessionService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.concurrent.TimeUnit;


@Slf4j
@Service
public class LiveSessionServiceImpl implements ILiveSessionService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    // Redis Key前缀
    private static final String ROOM_USERS_KEY = "live:room:users:";
    private static final String USER_ROOM_KEY = "live:user:room:";
    private static final String USER_ROLE_KEY = "live:user:role:";
    private static final String SESSION_KEY = "live:session:";

    // 会话过期时间（小时）
    private static final long SESSION_EXPIRE_HOURS = 24;

    @Override
    public void userJoinRoom(String roomId, String userId, String sessionId) {
        try {
            // 如果用户已经在其他房间，先离开
            String currentRoom = getUserCurrentRoom(userId);
            if (currentRoom != null && !currentRoom.equals(roomId)) {
                userLeaveRoom(currentRoom, userId);
            }

            // 将用户添加到房间用户集合
            redisTemplate.opsForSet().add(ROOM_USERS_KEY + roomId, userId);
            
            // 记录用户当前房间
            redisTemplate.opsForValue().set(USER_ROOM_KEY + userId, roomId, SESSION_EXPIRE_HOURS, TimeUnit.HOURS);
            
            // 记录会话信息
            redisTemplate.opsForValue().set(SESSION_KEY + userId, sessionId, SESSION_EXPIRE_HOURS, TimeUnit.HOURS);
            
            // 默认设置为观众角色
            setUserRole(roomId, userId, "viewer");

            log.info("用户 {} 加入直播间 {}", userId, roomId);
        } catch (Exception e) {
            log.error("用户加入直播间失败: userId={}, roomId={}", userId, roomId, e);
        }
    }

    @Override
    public void userLeaveRoom(String roomId, String userId) {
        try {
            // 从房间用户集合中移除
            redisTemplate.opsForSet().remove(ROOM_USERS_KEY + roomId, userId);
            
            // 清除用户当前房间记录
            redisTemplate.delete(USER_ROOM_KEY + userId);
            
            // 清除会话信息
            redisTemplate.delete(SESSION_KEY + userId);
            
            // 清除用户角色
            redisTemplate.delete(USER_ROLE_KEY + roomId + ":" + userId);

            log.info("用户 {} 离开直播间 {}", userId, roomId);
        } catch (Exception e) {
            log.error("用户离开直播间失败: userId={}, roomId={}", userId, roomId, e);
        }
    }

    @Override
    public Set<String> getRoomUsers(String roomId) {
        try {
            Set<Object> members = redisTemplate.opsForSet().members(ROOM_USERS_KEY + roomId);
            return members != null ? Set.copyOf(members.stream().map(Object::toString).toList()) : Set.of();
        } catch (Exception e) {
            log.error("获取房间用户列表失败: roomId={}", roomId, e);
            return Set.of();
        }
    }

    @Override
    public int getRoomUserCount(String roomId) {
        try {
            Long count = redisTemplate.opsForSet().size(ROOM_USERS_KEY + roomId);
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            log.error("获取房间用户数量失败: roomId={}", roomId, e);
            return 0;
        }
    }

    @Override
    public boolean isUserInRoom(String roomId, String userId) {
        try {
            Boolean isMember = redisTemplate.opsForSet().isMember(ROOM_USERS_KEY + roomId, userId);
            return isMember != null && isMember;
        } catch (Exception e) {
            log.error("检查用户是否在房间失败: userId={}, roomId={}", userId, roomId, e);
            return false;
        }
    }

    @Override
    public void clearRoomUsers(String roomId) {
        try {
            Set<String> users = getRoomUsers(roomId);
            for (String userId : users) {
                userLeaveRoom(roomId, userId);
            }
            log.info("清空直播间 {} 所有用户", roomId);
        } catch (Exception e) {
            log.error("清空房间用户失败: roomId={}", roomId, e);
        }
    }

    @Override
    public String getUserCurrentRoom(String userId) {
        try {
            Object roomId = redisTemplate.opsForValue().get(USER_ROOM_KEY + userId);
            return roomId != null ? roomId.toString() : null;
        } catch (Exception e) {
            log.error("获取用户当前房间失败: userId={}", userId, e);
            return null;
        }
    }

    @Override
    public void setUserRole(String roomId, String userId, String role) {
        try {
            redisTemplate.opsForValue().set(USER_ROLE_KEY + roomId + ":" + userId, role, SESSION_EXPIRE_HOURS, TimeUnit.HOURS);
            log.debug("设置用户角色: userId={}, roomId={}, role={}", userId, roomId, role);
        } catch (Exception e) {
            log.error("设置用户角色失败: userId={}, roomId={}, role={}", userId, roomId, role, e);
        }
    }

    @Override
    public String getUserRole(String roomId, String userId) {
        try {
            Object role = redisTemplate.opsForValue().get(USER_ROLE_KEY + roomId + ":" + userId);
            return role != null ? role.toString() : "viewer";
        } catch (Exception e) {
            log.error("获取用户角色失败: userId={}, roomId={}", userId, roomId, e);
            return "viewer";
        }
    }
} 