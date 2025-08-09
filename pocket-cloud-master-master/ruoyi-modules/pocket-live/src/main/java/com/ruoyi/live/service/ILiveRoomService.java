package com.ruoyi.live.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.live.domain.LiveRoom;
import com.ruoyi.live.domain.vo.LiveRoomCreateVO;
import com.ruoyi.live.domain.vo.LiveRoomVO;

import java.util.List;


public interface ILiveRoomService extends IService<LiveRoom> {
    
    /**
     * 创建直播间
     */
    LiveRoomVO createLiveRoom(LiveRoomCreateVO createVO);
    
    /**
     * 开始直播
     */
    boolean startLive(String roomId, Long streamerId);
    
    /**
     * 结束直播
     */
    boolean endLive(String roomId, Long streamerId);
    
    /**
     * 暂停直播
     */
    boolean pauseLive(String roomId, Long streamerId);
    
    /**
     * 恢复直播
     */
    boolean resumeLive(String roomId, Long streamerId);
    
    /**
     * 根据房间ID获取直播间信息
     */
    LiveRoomVO getLiveRoomByRoomId(String roomId);
    
    /**
     * 获取正在直播的房间列表
     */
    List<LiveRoomVO> getLivingRooms();
    
    /**
     * 分页获取指定状态的直播间列表
     */
    List<LiveRoomVO> getLiveRoomsByStatusWithPage(Integer status, Integer page, Integer pageSize);
    
    /**
     * 统计指定状态的直播间数量
     */
    int countLiveRoomsByStatus(Integer status);
    
    /**
     * 获取用户的直播间列表
     */
    List<LiveRoomVO> getLiveRoomsByStreamer(Long streamerId);
    
    /**
     * 更新直播间观看人数
     */
    void updateViewerCount(String roomId, Integer viewerCount);
    
    /**
     * 增加总观看人数
     */
    void incrementTotalViewers(String roomId);
    
    /**
     * 增加点赞数
     */
    void incrementLikeCount(String roomId, Integer count);
    
    /**
     * 删除直播间
     */
    boolean deleteLiveRoom(String roomId, Long streamerId);
} 