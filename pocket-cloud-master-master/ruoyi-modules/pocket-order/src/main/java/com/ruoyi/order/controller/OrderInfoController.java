package com.ruoyi.order.controller;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresLogin;
import com.ruoyi.order.api.domain.OrderDetailVo;
import com.ruoyi.order.api.domain.OrderRequest;
import com.ruoyi.order.domain.OrderForm;
import com.ruoyi.order.domain.OrderFormVo;
import com.ruoyi.order.api.domain.OrderSalesVo;
import com.ruoyi.order.domain.TradeVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.order.api.domain.OrderInfo;
import com.ruoyi.order.service.IOrderInfoService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

import static com.ruoyi.common.core.utils.PageUtils.startPage;

/**
 * 订单Controller
 * 
 * @author pocket
 * @date 2025-01-26
 */
@RestController
@RequestMapping("/orderInfo")
public class OrderInfoController extends BaseController
{
    @Autowired
    private IOrderInfoService orderInfoService;


    /**
     * 查询订单列表
     */
    @RequiresPermissions("order:info:list")
    @GetMapping("/list")
    public TableDataInfo list(OrderInfo orderInfo)
    {
        startPage();
        List<OrderInfo> list = orderInfoService.selectOrderInfoList(orderInfo);
        return getDataTable(list);
    }

    /**
     * 导出订单列表
     */
    @RequiresPermissions("order:info:export")
    @Log(title = "订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, OrderInfo orderInfo)
    {
        List<OrderInfo> list = orderInfoService.selectOrderInfoList(orderInfo);
        ExcelUtil<OrderInfo> util = new ExcelUtil<OrderInfo>(OrderInfo.class);
        util.exportExcel(response, list, "订单数据");
    }

    /**
     * 获取订单详细信息
     */
    @RequiresPermissions("order:info:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(orderInfoService.selectOrderInfoById(id));
    }

    /**
     * 新增订单
     */
    @RequiresPermissions("order:info:add")
    @Log(title = "订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OrderInfo orderInfo)
    {
        return toAjax(orderInfoService.insertOrderInfo(orderInfo));
    }

    /**
     * 修改订单
     */
    @RequiresPermissions("order:info:edit")
    @Log(title = "订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OrderInfo orderInfo)
    {
        return toAjax(orderInfoService.updateOrderInfo(orderInfo));
    }

    /**
     * 删除订单
     */
    @RequiresPermissions("order:info:remove")
    @Log(title = "订单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(orderInfoService.deleteOrderInfoByIds(ids));
    }



    @Operation(summary = "Get Order Trade Data")
    @RequiresLogin
    @GetMapping("/trade")
    public AjaxResult orderTradeData() {
        return success(orderInfoService.orderTradeData());
    }


    @Operation(summary = "User submit order")
    @RequiresLogin
    @PostMapping("/submitOrder")
    public AjaxResult submitOrder(@RequestBody OrderForm orderForm) {
        return success(orderInfoService.submitOrder(orderForm));
    }


    @Operation(summary = "Buy immediately")
    @RequiresLogin
    @GetMapping("buy/{skuId}")
    public AjaxResult buy(@PathVariable Long skuId) {
        return success(orderInfoService.buy(skuId));
    }


    @Operation(summary = "Get Order Info")
    @RequiresLogin
    @GetMapping("getOrderInfo/{orderId}")
    public AjaxResult getOrderInfo(@PathVariable("orderId") Long orderId) {
        OrderInfo orderInfo = orderInfoService.selectOrderInfoById(orderId);
        return success(orderInfo);
    }

    @Operation(summary = "Get Order List")
    @GetMapping("/userOrderInfoList/{pageNum}/{pageSize}")
    public TableDataInfo list(
            @Parameter(name = "pageNum", description = "current page", required = true)
            @PathVariable Integer pageNum,

            @Parameter(name = "pageSize", description = "records per page", required = true)
            @PathVariable Integer pageSize,

            @Parameter(name = "orderStatus", description = "订单状态", required = false)
            @RequestParam(required = false, defaultValue = "") Integer orderStatus) {
        PageHelper.startPage(pageNum, pageSize);
        List<OrderInfo> list = orderInfoService.selectUserOrderInfoList(orderStatus);
        return getDataTable(list);
    }

    @Operation(summary = "Cancel order")
    @RequiresLogin
    @GetMapping("cancelOrder/{orderId}")
    public AjaxResult cancelOrder(@PathVariable Long orderId) {
        orderInfoService.cancelOrder(orderId);
        return success();
    }

    @Operation(summary = "根据订单号获取订单信息")
    @InnerAuth
    @GetMapping("getByOrderNo/{orderNo}")
    public R<OrderInfo> getByOrderNo(@PathVariable String orderNo) {
        OrderInfo orderInfo = orderInfoService.getByOrderNo(orderNo);
        return R.ok(orderInfo);
    }

    @Operation(summary = "Get Order Trade Data from cart")
    @RequiresLogin
    @GetMapping("/orderPreTrade")
    public AjaxResult getOrderPreTradeData() {
        return success(orderInfoService.getOrderPreTradeData());
    }

    @Operation(summary = "Get Order Trade Data from cart")
    @RequiresLogin
    @GetMapping("/orderPreTradeFromProduct")
    public AjaxResult getOrderPreTradeFromProduct(@RequestParam(required = true, name = "skuId") Long skuId,
                                                  @RequestParam(required = true,  name = "count") Integer count,
                                                  @Parameter(name = "addressId", required = false)
                                                  @RequestParam(required = false, name = "addressId") String addressId
    ) {
        TradeVo tradeVo = orderInfoService.getOrderPreTradeFromProduct(skuId, count, addressId);
        return success(tradeVo);
    }

    @Operation(summary = "New user submit order")
    @RequiresLogin
    @PostMapping("/newSubmitOrder")
    public AjaxResult newSubmitOrder(@RequestBody OrderFormVo orderFormVo) {
        Long orderId = orderInfoService.newSubmitOrder(orderFormVo);
        return success(orderId);
    }

    @Operation(summary = "NEW Get Order Info")
    @RequiresLogin
    @GetMapping("newGetOrderDetail/{orderId}")
    public AjaxResult newGetOrderDetail(@PathVariable("orderId") Long orderId) {
        OrderDetailVo orderDetailVo = orderInfoService.selectOrderDetailByOrderId(orderId);
        return success(orderDetailVo);
    }

    @Operation(summary = "Cancel order")
    @RequiresLogin
    @PutMapping("newCancelOrder/{orderId}")
    public AjaxResult newCancelOrder(@PathVariable(value = "orderId") Long orderId, @RequestBody OrderRequest orderRequest) {
        orderInfoService.newCancelOrder(orderId, orderRequest);
        return success();
    }

    @Operation(summary = "Delete order")
    @RequiresLogin
    @DeleteMapping("newDeleteOrder")
    public AjaxResult newDeleteOrder(@RequestBody OrderRequest orderRequest) {
        orderInfoService.newDeleteOrder(orderRequest);
        return success();
    }


    @Operation(summary = "Get Order List")
    @RequiresLogin
    @GetMapping("/newUserOrderInfoList/{pageNum}/{pageSize}/{orderState}")
    public R<TableDataInfo> newUserOrderInfoList(@PathVariable(value = "pageNum", required = true) Integer pageNum,
                                    @PathVariable(value = "pageSize", required = true) Integer pageSize,
                                    @PathVariable(value = "orderState", required = false)Integer orderState) {
        PageHelper.startPage(pageNum, pageSize, "create_time desc");
        List<OrderDetailVo> orderDetailVoList = orderInfoService.newUserOrderInfoList(orderState);
        return R.ok(getDataTable(orderDetailVoList));

    }

    @Operation(summary = "Repurchase by orderId")
    @RequiresLogin
    @GetMapping("newRepurchase/{orderId}")
    public AjaxResult newRepurchase(@PathVariable("orderId") Long orderId) {
        TradeVo tradeVo = orderInfoService.newRepurchase(orderId);
        return success(tradeVo);
    }

    @Operation(summary = "Get Order List from Backstage")
    @GetMapping("/newUserOrderInfoListFromBackstage")
    public TableDataInfo newUserOrderInfoListFromBackstage(
            @Parameter(name = "pageNum", description = "当前页码", required = true)
            @RequestParam(defaultValue = "1") Integer pageNum,
            @Parameter(name = "pageSize", description = "每页记录数", required = true)
            @RequestParam(defaultValue = "10") Integer pageSize
    ) {
        Page<OrderDetailVo> page = orderInfoService.newUserOrderInfoListFromBackstage(pageNum, pageSize);

        TableDataInfo tableDataInfo = new TableDataInfo();
        tableDataInfo.setRows(page.getRecords());
        tableDataInfo.setTotal(page.getTotal());

        return tableDataInfo;
    }


    @Operation(summary = "Get sales data by AI")
    @GetMapping("getSalesData/{startTime}/{endTime}")
    public R<OrderSalesVo> getSalesData(@PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime) {
        OrderSalesVo orderSalesVo = orderInfoService.getSalesData(startTime, endTime);
        return R.ok(orderSalesVo);
    }

    @Operation(summary = "Get order data by AI from customer")
    @GetMapping("getOrderData/{userId}/{startTime}/{endTime}")
    public R<OrderSalesVo> getOrderData(@PathVariable("userId") Long userId,@PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime) {
        OrderSalesVo orderSalesVo = orderInfoService.getOrderData(userId, startTime, endTime);
        return R.ok(orderSalesVo);
    }
}
