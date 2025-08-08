package com.ruoyi.live.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.bean.BeanUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.live.domain.LiveRoom;
import com.ruoyi.live.domain.vo.LiveRoomCreateVO;
import com.ruoyi.live.domain.vo.LiveRoomVO;
import com.ruoyi.live.mapper.LiveRoomMapper;
import com.ruoyi.live.service.ILiveRoomService;
import com.ruoyi.live.service.ILiveSessionService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.product.api.service.RemoteProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;


@Slf4j
@Service
public class LiveRoomServiceImpl extends ServiceImpl<LiveRoomMapper, LiveRoom> implements ILiveRoomService {

    @Autowired
    private LiveRoomMapper liveRoomMapper;

    @Autowired
    private ILiveSessionService liveSessionService;

    @Autowired
    private RemoteProductService remoteProductService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public LiveRoomVO createLiveRoom(LiveRoomCreateVO createVO) {
        try {
            // 获取当前用户信息
            Long currentUserId = SecurityContextHolder.getUserId();
            String currentUsername = SecurityContextHolder.getUserName();

            if (currentUserId == null) {
                throw new ServiceException("用户未登录");
            }

            // 生成唯一的房间ID
            String roomId = generateRoomId();

            // 创建直播间实体
            LiveRoom liveRoom = new LiveRoom();
            BeanUtils.copyProperties(createVO, liveRoom);
            liveRoom.setRoomId(roomId);
            liveRoom.setStreamerId(currentUserId);
            liveRoom.setStreamerName(currentUsername);
            liveRoom.setStatus(0); // 未开始
            liveRoom.setViewerCount(0);
            liveRoom.setTotalViewers(0);
            liveRoom.setLikeCount(0);
            liveRoom.setDelFlag("0");

            // 打印调试信息
            log.info("创建直播间: roomId={}, productId={}, title={}", roomId, liveRoom.getProductId(), liveRoom.getTitle());

            // 保存到数据库
            boolean saved = save(liveRoom);
            if (!saved) {
                throw new ServiceException("创建直播间失败");
            }

            log.info("用户 {} 创建直播间成功: {}", currentUsername, roomId);

            // 转换为VO返回
            return convertToVO(liveRoom);
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("创建直播间失败", e);
            throw new ServiceException("创建直播间失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean startLive(String roomId, Long streamerId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                throw new ServiceException("直播间不存在");
            }

            if (!liveRoom.getStreamerId().equals(streamerId)) {
                throw new ServiceException("无权限操作此直播间");
            }

            if (liveRoom.getStatus() == 1) {
                throw new ServiceException("直播间已在直播中");
            }

            // 更新状态为直播中
            int result = liveRoomMapper.updateStatus(roomId, 1);
            if (result > 0) {
                log.info("主播 {} 开始直播: {}", streamerId, roomId);
                return true;
            }
            return false;
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("开始直播失败: roomId={}, streamerId={}", roomId, streamerId, e);
            throw new ServiceException("开始直播失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean endLive(String roomId, Long streamerId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                throw new ServiceException("直播间不存在");
            }

            if (!liveRoom.getStreamerId().equals(streamerId)) {
                throw new ServiceException("无权限操作此直播间");
            }

            // 更新状态为已结束
            int result = liveRoomMapper.updateStatus(roomId, 2);
            if (result > 0) {
                // 清空房间内所有用户
                liveSessionService.clearRoomUsers(roomId);
                log.info("主播 {} 结束直播: {}", streamerId, roomId);
                return true;
            }
            return false;
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("结束直播失败: roomId={}, streamerId={}", roomId, streamerId, e);
            throw new ServiceException("结束直播失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean pauseLive(String roomId, Long streamerId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                throw new ServiceException("直播间不存在");
            }

            if (!liveRoom.getStreamerId().equals(streamerId)) {
                throw new ServiceException("无权限操作此直播间");
            }

            if (liveRoom.getStatus() != 1) {
                throw new ServiceException("直播间未在直播中");
            }

            // 更新状态为已暂停
            int result = liveRoomMapper.updateStatus(roomId, 3);
            if (result > 0) {
                log.info("主播 {} 暂停直播: {}", streamerId, roomId);
                return true;
            }
            return false;
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("暂停直播失败: roomId={}, streamerId={}", roomId, streamerId, e);
            throw new ServiceException("暂停直播失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean resumeLive(String roomId, Long streamerId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                throw new ServiceException("直播间不存在");
            }

            if (!liveRoom.getStreamerId().equals(streamerId)) {
                throw new ServiceException("无权限操作此直播间");
            }

            if (liveRoom.getStatus() != 3) {
                throw new ServiceException("直播间未暂停");
            }

            // 更新状态为直播中
            int result = liveRoomMapper.updateStatus(roomId, 1);
            if (result > 0) {
                log.info("主播 {} 恢复直播: {}", streamerId, roomId);
                return true;
            }
            return false;
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("恢复直播失败: roomId={}, streamerId={}", roomId, streamerId, e);
            throw new ServiceException("恢复直播失败: " + e.getMessage());
        }
    }

    @Override
    public LiveRoomVO getLiveRoomByRoomId(String roomId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                return null;
            }

            LiveRoomVO vo = convertToVO(liveRoom);
            // 获取实时观看人数
            int currentViewers = liveSessionService.getRoomUserCount(roomId);
            vo.setViewerCount(currentViewers);

            return vo;
        } catch (Exception e) {
            log.error("获取直播间信息失败: roomId={}", roomId, e);
            return null;
        }
    }

    @Override
    public List<LiveRoomVO> getLivingRooms() {
        try {
            List<LiveRoom> liveRooms = liveRoomMapper.selectLivingRooms();
            return liveRooms.stream()
                    .map(this::convertToVO)
                    .peek(vo -> {
                        // 更新实时观看人数
                        int currentViewers = liveSessionService.getRoomUserCount(vo.getRoomId());
                        vo.setViewerCount(currentViewers);
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("获取直播房间列表失败", e);
            return List.of();
        }
    }

    @Override
    public List<LiveRoomVO> getLiveRoomsByStreamer(Long streamerId) {
        try {
            List<LiveRoom> liveRooms = liveRoomMapper.selectByStreamerId(streamerId);
            return liveRooms.stream()
                    .map(this::convertToVO)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("获取主播直播间列表失败: streamerId={}", streamerId, e);
            return List.of();
        }
    }

    @Override
    public void updateViewerCount(String roomId, Integer viewerCount) {
        try {
            liveRoomMapper.updateViewerCount(roomId, viewerCount);
        } catch (Exception e) {
            log.error("更新观看人数失败: roomId={}, viewerCount={}", roomId, viewerCount, e);
        }
    }

    @Override
    public void incrementTotalViewers(String roomId) {
        try {
            liveRoomMapper.incrementTotalViewers(roomId, 1);
        } catch (Exception e) {
            log.error("增加总观看人数失败: roomId={}", roomId, e);
        }
    }

    @Override
    public void incrementLikeCount(String roomId, Integer count) {
        try {
            liveRoomMapper.incrementLikeCount(roomId, count);
        } catch (Exception e) {
            log.error("增加点赞数失败: roomId={}, count={}", roomId, count, e);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteLiveRoom(String roomId, Long streamerId) {
        try {
            LiveRoom liveRoom = liveRoomMapper.selectByRoomId(roomId);
            if (liveRoom == null) {
                throw new ServiceException("直播间不存在");
            }

            if (!liveRoom.getStreamerId().equals(streamerId)) {
                throw new ServiceException("无权限删除此直播间");
            }

            if (liveRoom.getStatus() == 1) {
                throw new ServiceException("直播进行中，无法删除");
            }

            // 逻辑删除
            liveRoom.setDelFlag("2");
            boolean updated = updateById(liveRoom);
            if (updated) {
                // 清空房间用户
                liveSessionService.clearRoomUsers(roomId);
                log.info("删除直播间成功: roomId={}, streamerId={}", roomId, streamerId);
                return true;
            }
            return false;
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            log.error("删除直播间失败: roomId={}, streamerId={}", roomId, streamerId, e);
            throw new ServiceException("删除直播间失败: " + e.getMessage());
        }
    }

    @Override
    public List<LiveRoomVO> getLiveRoomsByStatusWithPage(Integer status, Integer page, Integer pageSize) {
        try {
            // 计算偏移量
            int offset = (page - 1) * pageSize;
            
            // 查询数据
            List<LiveRoom> liveRooms = liveRoomMapper.selectLiveRoomsByStatusWithPage(status, offset, pageSize);
            
            // 转换为VO对象
            return liveRooms.stream()
                    .map(this::convertToVO)
                    .peek(vo -> {
                        // 更新实时观看人数
                        int currentViewers = liveSessionService.getRoomUserCount(vo.getRoomId());
                        vo.setViewerCount(currentViewers);
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("分页获取直播间列表失败: status={}, page={}, pageSize={}", status, page, pageSize, e);
            return List.of();
        }
    }
    
    @Override
    public int countLiveRoomsByStatus(Integer status) {
        try {
            return liveRoomMapper.countLiveRoomsByStatus(status);
        } catch (Exception e) {
            log.error("统计直播间数量失败: status={}", status, e);
            return 0;
        }
    }

    /**
     * 生成唯一的房间ID
     */
    private String generateRoomId() {
        return "live_" + System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8);
    }

    /**
     * 转换LiveRoom为LiveRoomVO
     */
    private LiveRoomVO convertToVO(LiveRoom liveRoom) {
        LiveRoomVO vo = new LiveRoomVO();
        BeanUtils.copyProperties(liveRoom, vo);
        
        // 如果有关联商品，获取商品名称
        if (liveRoom.getProductId() != null) {
            try {
                R<?> productResult = remoteProductService.getProduct(liveRoom.getProductId(), SecurityConstants.INNER);
                if (R.SUCCESS == productResult.getCode() && productResult.getData() != null) {
                    // 根据ProductVo结构获取商品名称
                    Object productData = productResult.getData();
                    if (productData instanceof java.util.Map) {
                        @SuppressWarnings("unchecked")
                        java.util.Map<String, Object> productMap = (java.util.Map<String, Object>) productData;
                        Object nameObj = productMap.get("name");
                        if (nameObj != null) {
                            vo.setProductName(nameObj.toString());
                        }
                    }
                    log.info("获取商品名称成功: productId={}, productName={}", liveRoom.getProductId(), vo.getProductName());
                }
            } catch (Exception e) {
                log.warn("获取商品名称失败: productId={}", liveRoom.getProductId(), e);
                // 即使获取商品名称失败，也不影响直播间信息返回
            }
        }
        
        return vo;
    }
} 