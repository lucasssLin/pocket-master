package com.ruoyi.live.service;

import java.util.Set;


public interface ILiveSessionService {
    
    /**
     * 用户加入直播间
     * 
     * @param roomId 直播间ID
     * @param userId 用户ID
     * @param sessionId WebSocket会话ID
     */
    void userJoinRoom(String roomId, String userId, String sessionId);
    
    /**
     * 用户离开直播间
     * 
     * @param roomId 直播间ID
     * @param userId 用户ID
     */
    void userLeaveRoom(String roomId, String userId);
    
    /**
     * 获取房间内的所有用户
     * 
     * @param roomId 直播间ID
     * @return 用户ID集合
     */
    Set<String> getRoomUsers(String roomId);
    
    /**
     * 获取房间内的用户数量
     * 
     * @param roomId 直播间ID
     * @return 用户数量
     */
    int getRoomUserCount(String roomId);
    
    /**
     * 检查用户是否在房间内
     * 
     * @param roomId 直播间ID
     * @param userId 用户ID
     * @return 是否在房间内
     */
    boolean isUserInRoom(String roomId, String userId);
    
    /**
     * 清空房间所有用户
     * 
     * @param roomId 直播间ID
     */
    void clearRoomUsers(String roomId);
    
    /**
     * 获取用户当前所在的房间
     * 
     * @param userId 用户ID
     * @return 房间ID，如果不在任何房间则返回null
     */
    String getUserCurrentRoom(String userId);
    
    /**
     * 设置用户状态（主播、观众等）
     * 
     * @param roomId 直播间ID
     * @param userId 用户ID
     * @param role 用户角色: streamer, viewer
     */
    void setUserRole(String roomId, String userId, String role);
    
    /**
     * 获取用户在房间内的角色
     * 
     * @param roomId 直播间ID
     * @param userId 用户ID
     * @return 用户角色
     */
    String getUserRole(String roomId, String userId);
} 