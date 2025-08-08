package com.ruoyi.live.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.annotation.RequiresLogin;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.live.domain.vo.LiveRoomCreateVO;
import com.ruoyi.live.domain.vo.LiveRoomVO;
import com.ruoyi.live.service.ILiveRoomService;
import com.ruoyi.live.service.ILiveSessionService;
import com.ruoyi.product.api.domain.Product;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.SkuQuery;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.service.RemoteProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Tag(name = "直播间管理", description = "直播间相关API")
@RestController
@RequestMapping("/live/room")
public class LiveRoomController extends BaseController {

    @Autowired
    private ILiveRoomService liveRoomService;

    @Autowired
    private ILiveSessionService liveSessionService;

    @Autowired
    private RemoteProductService remoteProductService;

    @Operation(summary = "创建直播间")
    @RequiresLogin
    @PostMapping("/create")
    public AjaxResult createLiveRoom(@Validated @RequestBody LiveRoomCreateVO createVO) {
        try {
            LiveRoomVO liveRoom = liveRoomService.createLiveRoom(createVO);
            return success(liveRoom);
        } catch (Exception e) {
            log.error("创建直播间失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "开始直播")
    @RequiresLogin
    @PostMapping("/start/{roomId}")
    public AjaxResult startLive(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long streamerId = SecurityUtils.getUserId();
            boolean success = liveRoomService.startLive(roomId, streamerId);
            return success ? success() : error("开始直播失败");
        } catch (Exception e) {
            log.error("开始直播失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "结束直播")
    @RequiresLogin
    @PostMapping("/end/{roomId}")
    public AjaxResult endLive(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long streamerId = SecurityUtils.getUserId();
            boolean success = liveRoomService.endLive(roomId, streamerId);
            return success ? success() : error("结束直播失败");
        } catch (Exception e) {
            log.error("结束直播失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "暂停直播")
    @RequiresLogin
    @PostMapping("/pause/{roomId}")
    public AjaxResult pauseLive(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long streamerId = SecurityUtils.getUserId();
            boolean success = liveRoomService.pauseLive(roomId, streamerId);
            return success ? success() : error("暂停直播失败");
        } catch (Exception e) {
            log.error("暂停直播失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "恢复直播")
    @RequiresLogin
    @PostMapping("/resume/{roomId}")
    public AjaxResult resumeLive(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long streamerId = SecurityUtils.getUserId();
            boolean success = liveRoomService.resumeLive(roomId, streamerId);
            return success ? success() : error("恢复直播失败");
        } catch (Exception e) {
            log.error("恢复直播失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "获取直播间信息")
    @GetMapping("/info/{roomId}")
    public AjaxResult getLiveRoomInfo(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            LiveRoomVO liveRoom = liveRoomService.getLiveRoomByRoomId(roomId);
            if (liveRoom == null) {
                return error("直播间不存在");
            }

            // 获取额外信息
            Map<String, Object> result = new HashMap<>();
            result.put("liveRoom", liveRoom);
            result.put("onlineUsers", liveSessionService.getRoomUserCount(roomId));
            result.put("userList", liveSessionService.getRoomUsers(roomId));

            return success(result);
        } catch (Exception e) {
            log.error("获取直播间信息失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "获取正在直播的房间列表")
    @GetMapping("/living")
    public AjaxResult getLivingRooms() {
        try {
            List<LiveRoomVO> liveRooms = liveRoomService.getLivingRooms();
            return success(liveRooms);
        } catch (Exception e) {
            log.error("获取直播房间列表失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "获取我的直播间列表")
    @RequiresLogin
    @GetMapping("/my")
    public AjaxResult getMyLiveRooms() {
        try {
            Long streamerId = SecurityUtils.getUserId();
            List<LiveRoomVO> liveRooms = liveRoomService.getLiveRoomsByStreamer(streamerId);
            return success(liveRooms);
        } catch (Exception e) {
            log.error("获取我的直播间列表失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "点赞直播间")
    @RequiresLogin
    @PostMapping("/like/{roomId}")
    public AjaxResult likeLiveRoom(@Parameter(description = "直播间ID") @PathVariable String roomId,
                                   @Parameter(description = "点赞数量") @RequestParam(defaultValue = "1") Integer count) {
        try {
            liveRoomService.incrementLikeCount(roomId, count);
            return success("点赞成功");
        } catch (Exception e) {
            log.error("点赞失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "删除直播间")
    @RequiresLogin
    @DeleteMapping("/{roomId}")
    public AjaxResult deleteLiveRoom(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long streamerId = SecurityUtils.getUserId();
            boolean success = liveRoomService.deleteLiveRoom(roomId, streamerId);
            return success ? success("删除成功") : error("删除失败");
        } catch (Exception e) {
            log.error("删除直播间失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "检查用户是否在直播间")
    @RequiresLogin
    @GetMapping("/check/{roomId}")
    public AjaxResult checkUserInRoom(@Parameter(description = "直播间ID") @PathVariable String roomId) {
        try {
            Long userId = SecurityUtils.getUserId();
            boolean inRoom = liveSessionService.isUserInRoom(roomId, userId.toString());
            String currentRoom = liveSessionService.getUserCurrentRoom(userId.toString());
            String userRole = liveSessionService.getUserRole(roomId, userId.toString());

            Map<String, Object> result = new HashMap<>();
            result.put("inRoom", inRoom);
            result.put("currentRoom", currentRoom);
            result.put("userRole", userRole);

            return success(result);
        } catch (Exception e) {
            log.error("检查用户房间状态失败", e);
            return error(e.getMessage());
        }
    }

    @Operation(summary = "分页获取直播间列表")
    @GetMapping("/list/{page}/{pageSize}")
    public AjaxResult getLiveRoomsByPage(
            @Parameter(description = "页码") @PathVariable("page") Integer page,
            @Parameter(description = "每页大小") @PathVariable("pageSize") Integer pageSize,
            @Parameter(description = "直播间状态") @RequestParam(value = "status", required = false, defaultValue = "1") Integer status) {
        try {
            // 参数校验
            if (page == null || page < 1) {
                page = 1;
            }
            if (pageSize == null || pageSize < 1 || pageSize > 100) {
                pageSize = 10;
            }

            // 查询数据
            List<LiveRoomVO> liveRooms = liveRoomService.getLiveRoomsByStatusWithPage(status, page, pageSize);
            int total = liveRoomService.countLiveRoomsByStatus(status);

            // 构建返回结果
            Map<String, Object> result = new HashMap<>();
            result.put("total", total);
            result.put("rows", liveRooms);
            result.put("pageNum", page);
            result.put("pageSize", pageSize);

            return success(result);
        } catch (Exception e) {
            log.error("分页获取直播间列表失败", e);
            return error("获取直播间列表失败: " + e.getMessage());
        }
    }

    @Operation(summary = "分页获取商品列表")
    @GetMapping("/productList")
    public AjaxResult getLiveRoomsProductList(
            @Parameter(description = "页码") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小") @RequestParam(defaultValue = "10") Integer pageSize,
            @Parameter(name = "productQuery", description = "productQuery", required = false)
            SkuQuery skuQuery) {

        R<TableDataInfo> tableDataInfoResult = remoteProductService.selectHotProductSpuList(page, pageSize, skuQuery, SecurityConstants.INNER);
        if (R.FAIL == tableDataInfoResult.getCode()) {
            throw new ServiceException(tableDataInfoResult.getMsg());
        }
        TableDataInfo productList = tableDataInfoResult.getData();
        return success(productList);
    }

    @Operation(summary = "获取商品信息")
    @GetMapping("/product/{productId}")
    public AjaxResult getProductInfo(@Parameter(description = "商品ID") @PathVariable Long productId) {
        try {
            List<Long> productIdList = new ArrayList<>();
            productIdList.add(productId);
            R<List<Product>> productListBySpuIdListResult = remoteProductService.getProductListBySpuIdList(productIdList, SecurityConstants.INNER);
            if (R.FAIL == productListBySpuIdListResult.getCode()) {
                throw new ServiceException(productListBySpuIdListResult.getMsg());
            }
            List<Product> productList = productListBySpuIdListResult.getData();
            Product product = productList.get(0);

            ProductSku minSalePriceSku = product.getProductSkuList().stream()
                    .min((sku1, sku2) -> sku1.getSalePrice().compareTo(sku2.getSalePrice()))
                    .orElse(null);
            product.setProductSku(minSalePriceSku);

            return success(product);
        } catch (Exception e) {
            log.error("获取商品信息失败", e);
            return error(e.getMessage());
        }
    }

} 