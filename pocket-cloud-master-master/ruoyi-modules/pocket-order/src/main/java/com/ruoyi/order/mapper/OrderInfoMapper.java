package com.ruoyi.order.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.api.domain.TopSalesVo;
import org.apache.ibatis.annotations.Param;

/**
 * 订单Mapper接口
 * 
 * @author pocket
 * @date 2025-01-26
 */
public interface OrderInfoMapper extends BaseMapper<OrderInfo>
{
    /**
     * 查询订单
     * 
     * @param id 订单主键
     * @return 订单
     */
    public OrderInfo selectOrderInfoById(Long id);

    /**
     * 查询订单列表
     * 
     * @param orderInfo 订单
     * @return 订单集合
     */
    public List<OrderInfo> selectOrderInfoList(OrderInfo orderInfo);

    /**
     * 新增订单
     * 
     * @param orderInfo 订单
     * @return 结果
     */
    public int insertOrderInfo(OrderInfo orderInfo);

    /**
     * 修改订单
     * 
     * @param orderInfo 订单
     * @return 结果
     */
    public int updateOrderInfo(OrderInfo orderInfo);

    /**
     * 删除订单
     * 
     * @param id 订单主键
     * @return 结果
     */
    public int deleteOrderInfoById(Long id);

    /**
     * 批量删除订单
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteOrderInfoByIds(Long[] ids);

    public List<OrderInfo> selectUserOrderInfoList(@Param("userId") Long userId, @Param("orderStatus") Integer orderStatus);

    public OrderSalesVo selectOrderSalesData(@Param("startTime") String startTime, @Param("endTime") String endTime);

    public List<TopSalesVo> selectTopThreeBestSellingProducts(@Param("startTime") String startTime, @Param("endTime") String endTime);

    public OrderSalesVo selectOrderData(@Param("userId") Long userId, @Param("startTime") String startTime, @Param("endTime") String endTime);
}
