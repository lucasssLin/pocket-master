package com.ruoyi.live.service;

import java.util.Set;


public interface ILiveSessionService {
    
    /**
     * 用户加入直播间
     */
    void userJoinRoom(String roomId, String userId, String sessionId);
    
    /**
     * 用户离开直播间
     */
    void userLeaveRoom(String roomId, String userId);
    
    /**
     * 获取房间内的所有用户
     */
    Set<String> getRoomUsers(String roomId);
    
    /**
     * 获取房间内的用户数量
     */
    int getRoomUserCount(String roomId);
    
    /**
     * 检查用户是否在房间内
     */
    boolean isUserInRoom(String roomId, String userId);
    
    /**
     * 清空房间所有用户
     */
    void clearRoomUsers(String roomId);
    
    /**
     * 获取用户当前所在的房间
     */
    String getUserCurrentRoom(String userId);
    
    /**
     * 设置用户状态（主播、观众等）
     */
    void setUserRole(String roomId, String userId, String role);
    
    /**
     * 获取用户在房间内的角色
     */
    String getUserRole(String roomId, String userId);
} 