package com.ruoyi.live.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.live.domain.LiveRoom;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LiveRoomMapper extends BaseMapper<LiveRoom> {
    
    /**
     * 根据房间ID查询直播间
     */
    LiveRoom selectByRoomId(@Param("roomId") String roomId);
    
    /**
     * 查询正在直播的房间列表
     */
    List<LiveRoom> selectLivingRooms();
    
    /**
     * 根据主播ID查询直播间列表
     */
    List<LiveRoom> selectByStreamerId(@Param("streamerId") Long streamerId);
    
    /**
     * 分页查询指定状态的直播间列表
     */
    List<LiveRoom> selectLiveRoomsByStatusWithPage(@Param("status") Integer status, 
                                                  @Param("offset") Integer offset, 
                                                  @Param("limit") Integer limit);
    
    /**
     * 统计指定状态的直播间数量
     */
    int countLiveRoomsByStatus(@Param("status") Integer status);
    
    /**
     * 更新直播间观看人数
     */
    int updateViewerCount(@Param("roomId") String roomId, @Param("viewerCount") Integer viewerCount);
    
    /**
     * 增加总观看人数
     */
    int incrementTotalViewers(@Param("roomId") String roomId, @Param("increment") Integer increment);
    
    /**
     * 增加点赞数
     */
    int incrementLikeCount(@Param("roomId") String roomId, @Param("increment") Integer increment);
    
    /**
     * 更新直播间状态
     */
    int updateStatus(@Param("roomId") String roomId, @Param("status") Integer status);
} 