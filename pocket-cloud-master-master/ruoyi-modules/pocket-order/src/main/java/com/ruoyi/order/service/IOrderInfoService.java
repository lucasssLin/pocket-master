package com.ruoyi.order.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.order.api.domain.OrderDetailVo;
import com.ruoyi.order.api.domain.OrderRequest;
import com.ruoyi.order.domain.OrderForm;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.domain.OrderFormVo;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.domain.TradeVo;

/**
 * 订单Service接口
 * 
 * @author pocket
 * @date 2025-01-26
 */
public interface IOrderInfoService extends IService<OrderInfo> {
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
     * 批量删除订单
     * 
     * @param ids 需要删除的订单主键集合
     * @return 结果
     */
    public int deleteOrderInfoByIds(Long[] ids);

    /**
     * 删除订单信息
     * 
     * @param id 订单主键
     * @return 结果
     */
    public int deleteOrderInfoById(Long id);

    TradeVo orderTradeData();

    Long submitOrder(OrderForm orderForm);

    TradeVo buy(Long skuId);

    List<OrderInfo> selectUserOrderInfoList(Integer orderStatus);

    void processCloseOrder(String orderNo);

    void cancelOrder(Long orderId);

    OrderInfo getByOrderNo(String orderNo);

    void processPaySuccess(String orderNo);

    TradeVo getOrderPreTradeData();

    TradeVo getOrderPreTradeFromProduct(Long skuId,  Integer count, String addressId);

    Long newSubmitOrder(OrderFormVo orderFormVo);

    OrderDetailVo selectOrderDetailByOrderId(Long orderId);

    void newCancelOrder(Long orderId, OrderRequest orderRequest);

    void newDeleteOrder(OrderRequest orderRequest);


    List<OrderDetailVo> newUserOrderInfoList(Integer orderState);

    TradeVo newRepurchase(Long orderId);

    Page<OrderDetailVo> newUserOrderInfoListFromBackstage(Integer pageNum, Integer pageSize);

    OrderSalesVo getSalesData(String startTime, String endTime);

    OrderSalesVo getOrderData(Long userId, String startTime, String endTime);
}
