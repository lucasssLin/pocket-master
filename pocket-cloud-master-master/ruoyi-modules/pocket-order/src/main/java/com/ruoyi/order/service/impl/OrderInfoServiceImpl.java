package com.ruoyi.order.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.cart.api.domain.CartInfo;
import com.ruoyi.cart.api.service.RemoteCartService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.rabbit.constant.MessageQueueConstant;
import com.ruoyi.common.rabbit.service.RabbitService;
import com.ruoyi.order.api.domain.*;
import com.ruoyi.order.domain.*;
import com.ruoyi.order.mapper.OrderItemMapper;
import com.ruoyi.order.mapper.OrderLogMapper;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.api.domain.SkuPrice;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.service.RemoteProductService;
import com.ruoyi.system.api.RemoteUserService;
import com.ruoyi.system.api.model.LoginUser;
import com.ruoyi.user.api.domain.UserAddress;
import com.ruoyi.user.api.service.RemoteUserAddressService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;
import com.ruoyi.order.mapper.OrderInfoMapper;
import com.ruoyi.order.service.IOrderInfoService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import static com.ruoyi.common.core.utils.PageUtils.startPage;

/**
 * 订单Service业务层处理
 * 
 * @author pocket
 * @date 2025-01-26
 */
@Service
public class OrderInfoServiceImpl extends ServiceImpl<OrderInfoMapper, OrderInfo> implements IOrderInfoService {
    @Autowired
    private OrderInfoMapper orderInfoMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RemoteCartService remoteCartService;

    @Autowired
    private RemoteProductService remoteProductService;

    @Autowired
    private RemoteUserAddressService remoteUserAddressService;

    @Autowired
    private OrderLogMapper orderLogMapper;

    @Autowired
    private RabbitService rabbitService;
    @Autowired
    private RemoteUserService remoteUserService;

    /**
     * 查询订单
     * 
     * @param id 订单主键
     * @return 订单
     */
    @Override
    public OrderInfo selectOrderInfoById(Long id)
    {
        OrderInfo orderInfo = orderInfoMapper.selectById(id);
        List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, id));
        orderInfo.setOrderItemList(orderItemList);
        return orderInfo;
    }

    /**
     * 查询订单列表
     * 
     * @param orderInfo 订单
     * @return 订单
     */
    @Override
    public List<OrderInfo> selectOrderInfoList(OrderInfo orderInfo)
    {
        return orderInfoMapper.selectOrderInfoList(orderInfo);
    }

    /**
     * 新增订单
     * 
     * @param orderInfo 订单
     * @return 结果
     */
    @Override
    public int insertOrderInfo(OrderInfo orderInfo)
    {
        orderInfo.setCreateTime(DateUtils.getNowDate());
        return orderInfoMapper.insertOrderInfo(orderInfo);
    }

    /**
     * 修改订单
     * 
     * @param orderInfo 订单
     * @return 结果
     */
    @Override
    public int updateOrderInfo(OrderInfo orderInfo)
    {
        orderInfo.setUpdateTime(DateUtils.getNowDate());
        return orderInfoMapper.updateOrderInfo(orderInfo);
    }

    /**
     * 批量删除订单
     * 
     * @param ids 需要删除的订单主键
     * @return 结果
     */
    @Override
    public int deleteOrderInfoByIds(Long[] ids)
    {
        return orderInfoMapper.deleteOrderInfoByIds(ids);
    }

    /**
     * 删除订单信息
     * 
     * @param id 订单主键
     * @return 结果
     */
    @Override
    public int deleteOrderInfoById(Long id)
    {
        return orderInfoMapper.deleteOrderInfoById(id);
    }

    @Override
    public TradeVo orderTradeData() {
        Long userId = SecurityContextHolder.getUserId();

        R<List<CartInfo>> cartInfoListResult = remoteCartService.getCartCheckedList(userId, SecurityConstants.INNER);

        if (R.FAIL == cartInfoListResult.getCode()) {
            throw new ServiceException(cartInfoListResult.getMsg());
        }
        List<CartInfo> cartInfoList = cartInfoListResult.getData();

        if (CollectionUtils.isEmpty(cartInfoList)) {
            throw new ServiceException("There is no selected item in shopping cart");
        }

        List<OrderItem> orderItemList = null;

        BigDecimal totalAmount = new BigDecimal(0);

        if(!CollectionUtils.isEmpty(cartInfoList)){
            orderItemList = cartInfoList.stream().map(cartInfo -> {
                OrderItem orderItem = new OrderItem();
                BeanUtils.copyProperties(cartInfo, orderItem);
                //orderItem.setSkuPrice(cartInfo.getSkuPrice());
                return orderItem;
            }).collect(Collectors.toList());

        }

        for (OrderItem orderItem : orderItemList){
            totalAmount = totalAmount.add(orderItem.getSkuPrice().multiply(new BigDecimal(orderItem.getSkuNum())));
        }

        String tradeNo = this.generateTradeNo(userId);

        TradeVo tradeVo = new TradeVo();
        tradeVo.setTotalAmount(totalAmount);
        //tradeVo.setOrderItemVoList(orderItemList);
        tradeVo.setTradeNo(tradeNo);
        return tradeVo;

    }



    private String generateTradeNo(Long userId) {

        String userTradeKey = "user:tradeNo:" + userId;


        String tradeNo = UUID.randomUUID().toString().replaceAll("-", "");


        redisTemplate.opsForValue().set(userTradeKey, tradeNo, 5, TimeUnit.MINUTES);
        return tradeNo;
    }


    private Boolean checkTradeNo(String userId, String tradeNo){
        String userTradeKey = "user:tradeNo:" + userId;

        String tradeNoFromRedis = (String) redisTemplate.opsForValue().get(userTradeKey);

        return tradeNo.equals(tradeNoFromRedis);
    }

    private void deleteTradeNo(String userId) {
        String userTradeKey = "user:tradeNo:" + userId;
        redisTemplate.delete(userTradeKey);
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long submitOrder(OrderForm orderForm) {
        Long userId = SecurityContextHolder.getUserId();

        //1 采用Lua脚本保证判断删除流水号原子性 KEYS[1]:流水号Key    ARGV[1]：用户流水号
        String userTradeKey = "user:tradeNo:" + userId;
        String scriptText = "if redis.call(\"get\",KEYS[1]) == ARGV[1]\n" +
                "then\n" +
                "    return redis.call(\"del\",KEYS[1])\n" +
                "else\n" +
                "    return 0\n" +
                "end";
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();

        redisScript.setScriptText(scriptText);
        redisScript.setResultType(Long.class);

        Long flag = (Long) redisTemplate.execute(redisScript, Arrays.asList(userTradeKey), orderForm.getTradeNo());
        if (flag == 0) {
            throw new ServiceException("Do not submit the order repeatedly, please try again");
        }

        //2. Assert the validity of the order
        List<OrderItem> orderItemList = orderForm.getOrderItemList();
        if (CollectionUtils.isEmpty(orderItemList)) {
            throw new ServiceException("Request parameter error");
        }

        //3.订单校验
        //3.1.校验价格
        List<Long> skuIdList = orderItemList.stream().map(OrderItem::getSkuId).collect(Collectors.toList());

        R<List<SkuPrice>> skuPriceListResult = remoteProductService.getSkuPriceList(skuIdList, SecurityConstants.INNER);

        if (R.FAIL == skuPriceListResult.getCode()) {
            throw new ServiceException(skuPriceListResult.getMsg());
        }

        List<SkuPrice> skuPriceList = skuPriceListResult.getData();
        Map<Long, BigDecimal> skuIdskuPriceMap = skuPriceList.stream().collect(Collectors.toMap(SkuPrice::getSkuId, SkuPrice::getSalePrice));

        String priceCheckResult = "";
        for(OrderItem orderItem : orderItemList){
            if(orderItem.getSkuPrice().compareTo(skuIdskuPriceMap.get(orderItem.getSkuId())) != 0){
                priceCheckResult += orderItem.getSkuName() + "price changed; ";
            }
        }

        if(!StringUtils.isEmpty(priceCheckResult)){
            remoteCartService.updateCartPrice(userId, SecurityConstants.INNER);
            throw new ServiceException(priceCheckResult);
        }

        //3.2.校验库存并锁定库存
        List<SkuLockVo> skuLockVoList = orderItemList.stream().map(orderItem -> {
            SkuLockVo skuLockVo = new SkuLockVo();
            skuLockVo.setSkuId(orderItem.getSkuId());
            skuLockVo.setSkuNum(orderItem.getSkuNum());
            return skuLockVo;
        }).collect(Collectors.toList());

        R<String> checkAndLockResult = remoteProductService.checkAndLock(orderForm.getTradeNo(), skuLockVoList, SecurityConstants.INNER);
        if (R.FAIL == checkAndLockResult.getCode()) {
            throw new ServiceException(checkAndLockResult.getMsg());
        }

        if(!StringUtils.isEmpty(checkAndLockResult.getData())){
            throw new ServiceException(checkAndLockResult.getData());
        }




        Long orderId = null;

        try {
            //4 下单
            orderId = this.saveOrder(orderForm);
        } catch (Exception e) {
            e.printStackTrace();
            //4.1 下单失败，解锁库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_UNLOCK, orderForm.getTradeNo());
            throw new ServiceException("Submit Order Failed");
        }

        //5 删除购物车选项
        remoteCartService.deleteCartCheckedList(userId, SecurityConstants.INNER);

        //6 发送延迟消息，取消订单
        rabbitService.sendDelayMessage(MessageQueueConstant.EXCHANGE_CANCEL_ORDER, MessageQueueConstant.ROUTING_CANCEL_ORDER,
                String.valueOf(orderId), MessageQueueConstant.CANCEL_ORDER_DELAY_TIME);

        return orderId;

    }


    @Transactional(rollbackFor = Exception.class)
    public Long saveOrder(OrderForm orderForm) {

        Long userId = SecurityContextHolder.getUserId();
        String userName = SecurityContextHolder.getUserName();

        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setOrderNo(orderForm.getTradeNo());
        orderInfo.setUserId(userId);
        orderInfo.setNickName(userName);
        orderInfo.setRemark(orderForm.getRemark());


        UserAddress userAddress = remoteUserAddressService.getUserAddress(orderForm.getUserAddressId(), SecurityConstants.INNER).getData();

        orderInfo.setReceiverName(userAddress.getReceiver());
        orderInfo.setReceiverPhone(userAddress.getContact());
        orderInfo.setReceiverTagName(userAddress.getTagName());
        orderInfo.setReceiverProvince(userAddress.getProvinceCode());
        orderInfo.setReceiverCity(userAddress.getCityCode());
        orderInfo.setReceiverDistrict(userAddress.getCountyCode());
        orderInfo.setReceiverAddress(userAddress.getAddress());

        List<OrderItem> orderItemList = orderForm.getOrderItemList();
        BigDecimal totalAmount = new BigDecimal(0);
        for (OrderItem orderItem : orderItemList) {
            totalAmount = totalAmount.add(orderItem.getSkuPrice().multiply(new BigDecimal(orderItem.getSkuNum())));
        }

        orderInfo.setTotalAmount(totalAmount);
        orderInfo.setCouponAmount(new BigDecimal(0));
        orderInfo.setOriginalTotalAmount(totalAmount);
        orderInfo.setFreightFee(orderForm.getFreightFee());
        //OrderInfo类的orderStatus属性的类型改为Integer
        orderInfo.setOrderStatus(0);
        orderInfoMapper.insert(orderInfo);

        //Save order details
        for (OrderItem orderItem : orderItemList) {
            orderItem.setOrderId(orderInfo.getId());
            orderItemMapper.insert(orderItem);
        }

        //记录日志
        OrderLog orderLog = new OrderLog();
        orderLog.setOrderId(orderInfo.getId());
        orderLog.setProcessStatus(0);
        orderLog.setNote("submit order");
        orderLogMapper.insert(orderLog);

        return orderInfo.getId();
    }

    private String getOrderNo(Long userId) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");

        String currentTime = LocalDateTime.now().format(formatter);
        String orderNo = "pocket" + userId +currentTime;
        return orderNo;
    }




    @Override
    public TradeVo buy(Long skuId) {
        Long userId = SecurityContextHolder.getUserId();
        String tradeNo = this.generateTradeNo(userId);

        ProductSku productSku = remoteProductService.getProductSku(skuId, SecurityConstants.INNER).getData();
        List<OrderItem> orderItemList = new ArrayList<>();

        OrderItem orderItem = new OrderItem();
        orderItem.setSkuId(skuId);
        orderItem.setSkuName(productSku.getSkuName());
        orderItem.setSkuNum(1);
        orderItem.setSkuPrice(productSku.getSalePrice());
        orderItem.setThumbImg(productSku.getThumbImg());
        orderItemList.add(orderItem);

        BigDecimal totalAmount = productSku.getSalePrice();

        TradeVo tradeVo = new TradeVo();
        tradeVo.setTradeNo(tradeNo);
        tradeVo.setTotalAmount(totalAmount);
        //tradeVo.setOrderItemList(orderItemList);

        R<Boolean> updateAllUncheckedResult = remoteCartService.updateAllUnchecked(userId, SecurityConstants.INNER);
        Boolean flag = updateAllUncheckedResult.getData();
        if(flag){
            System.out.println("调用updateAllUnchecked方法success");
        }else {
            System.out.println("调用updateAllUnchecked方法failure");
        }
        return tradeVo;
    }

    @Override
    public List<OrderInfo> selectUserOrderInfoList(Integer orderStatus) {
        Long userId = SecurityContextHolder.getUserId();
        List<OrderInfo> orderInfoList =  orderInfoMapper.selectUserOrderInfoList(userId, orderStatus);
        
        if(!CollectionUtils.isEmpty(orderInfoList)){
            List<Long> orderIdList = orderInfoList.stream().map(OrderInfo::getId).collect(Collectors.toList());

            List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().in(OrderItem::getOrderId, orderIdList));

            Map<Long, List<OrderItem>> orderIdToOrderItemListMap = orderItemList.stream().collect(Collectors.groupingBy(OrderItem::getOrderId));

            for (OrderInfo orderInfo : orderInfoList){
                orderInfo.setOrderItemList(orderIdToOrderItemListMap.get(orderInfo.getId()));
            }
        }
        return orderInfoList;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void processCloseOrder(String orderNo) {
        OrderInfo orderInfo = orderInfoMapper.selectOne(new LambdaQueryWrapper<OrderInfo>().eq(OrderInfo::getOrderNo, orderNo));

        if(orderInfo != null && orderInfo.getOrderStatus().intValue() == 1){
            //1 待付款 2 待发货 3 待收货 4 待评价 5 已完成 6	已取消
            orderInfo.setOrderStatus(6);
            orderInfo.setCancelTime(new Date());
            orderInfo.setCancelReason("Non-payment is automatically cancelled");
            orderInfoMapper.updateById(orderInfo);

            //记录日志
            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderInfo.getId());
            orderLog.setProcessStatus(6);
            orderLog.setNote("System cancel order");
            orderLogMapper.insert(orderLog);

            //发送MQ消息通知商品系统解锁库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_UNLOCK, orderInfo.getOrderNo());
        }
    }

    @Override
    public void cancelOrder(Long orderId) {
        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);

        if(orderInfo != null && orderInfo.getOrderStatus().intValue() == 0){
            orderInfo.setOrderStatus(-1);
            orderInfo.setCancelTime(new Date());
            orderInfo.setCancelReason("User cancel order");
            orderInfoMapper.updateById(orderInfo);

            //记录日志
            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderInfo.getId());
            orderLog.setProcessStatus(-1);
            orderLog.setNote("User cancel order");
            orderLogMapper.insert(orderLog);

            //发送MQ消息通知商品系统解锁库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_UNLOCK, orderInfo.getOrderNo());
        }

    }


    @Override
    public OrderInfo getByOrderNo(String orderNo) {
        OrderInfo orderInfo = orderInfoMapper.selectOne(new LambdaQueryWrapper<OrderInfo>().eq(OrderInfo::getOrderNo, orderNo));
        List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderInfo.getId()));
        orderInfo.setOrderItemList(orderItemList);
        return orderInfo;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void processPaySuccess(String orderNo) {
        //获取订单信息
        OrderInfo orderInfo = orderInfoMapper.selectOne(new LambdaQueryWrapper<OrderInfo>().eq(OrderInfo::getOrderNo, orderNo).select(OrderInfo::getId, OrderInfo::getOrderStatus));
        //未支付
        /** 订单状态，1为待付款、2为待发货、3为待收货、4为待评价、5为已完成、6为已取消 */
        if(orderInfo.getOrderStatus().intValue() == 1) {
            orderInfo.setOrderStatus(2);
            orderInfo.setPaymentTime(new Date());
            orderInfoMapper.updateById(orderInfo);
        }
    }

    @Override
    public TradeVo getOrderPreTradeData() {
        Long userId = SecurityContextHolder.getUserId();

        R<List<CartInfo>> cartInfoListResult = remoteCartService.getCartCheckedList(userId, SecurityConstants.INNER);

        if (R.FAIL == cartInfoListResult.getCode()) {
            throw new ServiceException(cartInfoListResult.getMsg());
        }
        List<CartInfo> cartInfoList = cartInfoListResult.getData();

        if (CollectionUtils.isEmpty(cartInfoList)) {
            throw new ServiceException("There is no selected item in shopping cart");
        }

        List<OrderItemVo> orderItemVoList = null;

        BigDecimal totalAmount = new BigDecimal(0);
        Integer goodsCount = 0;
        BigDecimal totalOriginalPrice = new BigDecimal(0);
        BigDecimal discountPrice = new BigDecimal(0);
        BigDecimal postFee = new BigDecimal("0.00");

        if(!CollectionUtils.isEmpty(cartInfoList)){
            orderItemVoList = cartInfoList.stream().map(cartInfo -> {
                OrderItemVo orderItemVo = new OrderItemVo();
                BeanUtils.copyProperties(cartInfo, orderItemVo);
                orderItemVo.setId(null);
                orderItemVo.setSkuNum(cartInfo.getCount());
                orderItemVo.setOriginalPrice(cartInfo.getMarketPrice());
                orderItemVo.setTotalOriginalPrice(cartInfo.getMarketPrice().multiply(new BigDecimal(cartInfo.getCount())));
                orderItemVo.setTotalSkuPrice(cartInfo.getSkuPrice().multiply(new BigDecimal(cartInfo.getCount())));
                //orderItem.setSkuPrice(cartInfo.getSkuPrice());
                return orderItemVo;
            }).collect(Collectors.toList());
        }

        for (OrderItemVo orderItemVo : orderItemVoList){
            totalAmount = totalAmount.add(orderItemVo.getSkuPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
            goodsCount += orderItemVo.getSkuNum();
            totalOriginalPrice = totalOriginalPrice.add(orderItemVo.getTotalOriginalPrice());
            discountPrice = discountPrice.add(orderItemVo.getTotalOriginalPrice().subtract(orderItemVo.getTotalSkuPrice()));
            BigDecimal feePerItem = new BigDecimal("5.00");
            postFee = postFee.add(feePerItem.multiply(BigDecimal.valueOf(orderItemVo.getSkuNum())));
        }

        R<List<UserAddress>> userAddressResult = remoteUserAddressService.userAddressList(SecurityConstants.INNER);
        if(R.FAIL == userAddressResult.getCode()){
            throw new ServiceException(userAddressResult.getMsg());
        }

        String tradeNo = this.generateTradeNo(userId);

        TradeVo tradeVo = new TradeVo();
        tradeVo.setTotalAmount(totalAmount.add(postFee));
        tradeVo.setOrderItemVoList(orderItemVoList);
        tradeVo.setUserAddressList(userAddressResult.getData());
        tradeVo.setTradeNo(tradeNo);
        tradeVo.setGoodsCount(goodsCount);
        tradeVo.setTotalOriginalPrice(totalOriginalPrice);
        tradeVo.setDiscountPrice(discountPrice);
        tradeVo.setPostFee(postFee);

        return tradeVo;
    }

    @Override
    public TradeVo getOrderPreTradeFromProduct(Long skuId,  Integer count, String addressId) {
        Long userId = SecurityContextHolder.getUserId();
        String tradeNo = this.generateTradeNo(userId);

        R<ProductSku> productSkuResult = remoteProductService.getProductSku(skuId, SecurityConstants.INNER);
        if(R.FAIL == productSkuResult.getCode()){
            throw new ServiceException(productSkuResult.getMsg());
        }
        List<OrderItemVo> orderItemVoList = new ArrayList<>();

        OrderItemVo orderItemVo = new OrderItemVo();
        BeanUtils.copyProperties(productSkuResult.getData(), orderItemVo);
        orderItemVo.setId(null);
        orderItemVo.setSkuPrice(productSkuResult.getData().getSalePrice());
        orderItemVo.setSpuId(productSkuResult.getData().getProductId());
        orderItemVo.setSkuId(productSkuResult.getData().getId());
        orderItemVo.setAttrsText(productSkuResult.getData().getSkuSpec());
        orderItemVo.setOriginalPrice(productSkuResult.getData().getMarketPrice());
        orderItemVo.setTotalOriginalPrice(productSkuResult.getData().getMarketPrice().multiply(new BigDecimal(count)));
        orderItemVo.setTotalSkuPrice(productSkuResult.getData().getSalePrice().multiply(new BigDecimal(count)));
        orderItemVo.setSkuNum(count);

        orderItemVoList.add(orderItemVo);

        BigDecimal totalAmount = new BigDecimal(0);
        Integer goodsCount = 0;
        BigDecimal totalOriginalPrice = new BigDecimal(0);
        BigDecimal discountPrice = new BigDecimal(0);
        BigDecimal postFee = new BigDecimal("0.00");

        totalAmount = orderItemVo.getSkuPrice().multiply(new BigDecimal(orderItemVo.getSkuNum()));
        goodsCount = orderItemVo.getSkuNum();
        totalOriginalPrice = orderItemVo.getOriginalPrice().multiply(new BigDecimal(orderItemVo.getSkuNum()));
        discountPrice = orderItemVo.getTotalOriginalPrice().subtract(orderItemVo.getTotalSkuPrice());
        BigDecimal feePerItem = new BigDecimal("5.00");
        postFee = feePerItem.multiply(BigDecimal.valueOf(orderItemVo.getSkuNum()));

        List<UserAddress> userAddressList = new ArrayList<>();
        if(addressId != null && !addressId.equals("undefined")){
            UserAddress userAddress = remoteUserAddressService.getUserAddress(Long.parseLong(addressId), SecurityConstants.INNER).getData();
            userAddressList.add(userAddress);
        }

        TradeVo tradeVo = new TradeVo();
        tradeVo.setTradeNo(tradeNo);

        tradeVo.setTotalAmount(totalAmount.add(postFee));
        tradeVo.setOrderItemVoList(orderItemVoList);
        tradeVo.setUserAddressList(userAddressList);
        tradeVo.setTradeNo(tradeNo);
        tradeVo.setGoodsCount(goodsCount);
        tradeVo.setTotalOriginalPrice(totalOriginalPrice);
        tradeVo.setDiscountPrice(discountPrice);
        tradeVo.setPostFee(postFee);

        remoteCartService.updateAllUnchecked(userId, SecurityConstants.INNER);

        return tradeVo;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long newSubmitOrder(OrderFormVo orderFormVo) {
        Long userId = SecurityContextHolder.getUserId();

        //1 采用Lua脚本保证判断删除流水号原子性 KEYS[1]:流水号Key    ARGV[1]：用户流水号
        String userTradeKey = "user:tradeNo:" + userId;
        String scriptText = "if redis.call(\"get\",KEYS[1]) == ARGV[1]\n" +
                "then\n" +
                "    return redis.call(\"del\",KEYS[1])\n" +
                "else\n" +
                "    return 0\n" +
                "end";
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();

        redisScript.setScriptText(scriptText);
        redisScript.setResultType(Long.class);

        Long flag = (Long) redisTemplate.execute(redisScript, Arrays.asList(userTradeKey), orderFormVo.getTradeNo());
        if (flag == 0) {
            throw new ServiceException("Do not submit the order repeatedly, please try again");
        }

        //2. Assert the validity of the order
        List<OrderItemVo> orderItemVoList = orderFormVo.getOrderItemVoList();
        if (CollectionUtils.isEmpty(orderItemVoList)) {
            throw new ServiceException("Request parameter error");
        }

        //3.订单校验
        //3.1.校验价格
        List<Long> skuIdList = orderItemVoList.stream().map(OrderItemVo::getSkuId).collect(Collectors.toList());

        R<List<SkuPrice>> skuPriceListResult = remoteProductService.getSkuPriceList(skuIdList, SecurityConstants.INNER);

        if (R.FAIL == skuPriceListResult.getCode()) {
            throw new ServiceException(skuPriceListResult.getMsg());
        }

        List<SkuPrice> skuPriceList = skuPriceListResult.getData();
        Map<Long, BigDecimal> skuIdskuPriceMap = skuPriceList.stream().collect(Collectors.toMap(SkuPrice::getSkuId, SkuPrice::getSalePrice));

        String priceCheckResult = "";
        for(OrderItemVo orderItemVo : orderItemVoList){
            if(orderItemVo.getSkuPrice().compareTo(skuIdskuPriceMap.get(orderItemVo.getSkuId())) != 0){
                priceCheckResult += orderItemVo.getSkuName() + "price changed; ";
            }
        }

        if(!StringUtils.isEmpty(priceCheckResult)){
            remoteCartService.updateCartPrice(userId, SecurityConstants.INNER);
            throw new ServiceException(priceCheckResult);
        }

        //3.2.校验库存并锁定库存
        List<SkuLockVo> skuLockVoList = orderItemVoList.stream().map(orderItemVo -> {
            SkuLockVo skuLockVo = new SkuLockVo();
            skuLockVo.setSkuId(orderItemVo.getSkuId());
            skuLockVo.setSkuNum(orderItemVo.getSkuNum());
            return skuLockVo;
        }).collect(Collectors.toList());

        String orderNo = this.newGetOrderNo(userId);

        R<String> checkAndLockResult = remoteProductService.checkAndLock(orderNo, skuLockVoList, SecurityConstants.INNER);
        if (R.FAIL == checkAndLockResult.getCode()) {
            throw new ServiceException(checkAndLockResult.getMsg());
        }

        if(!StringUtils.isEmpty(checkAndLockResult.getData())){
            throw new ServiceException(checkAndLockResult.getData());
        }

        Long orderId = null;

        try {
            //4 下单

            orderId = this.newSaveOrder(orderFormVo, orderNo);
        } catch (Exception e) {
            e.printStackTrace();
            //4.1 下单失败，解锁库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_UNLOCK, orderNo);
            throw new ServiceException("Submit Order Failed");
        }

        //5 删除购物车选项
        remoteCartService.deleteCartCheckedList(userId, SecurityConstants.INNER);

        //6 发送延迟消息，取消订单
        rabbitService.sendDelayMessage(MessageQueueConstant.EXCHANGE_CANCEL_ORDER, MessageQueueConstant.ROUTING_CANCEL_ORDER,
                orderNo, MessageQueueConstant.CANCEL_ORDER_DELAY_TIME);

        return orderId;
    }


    @Transactional(rollbackFor = Exception.class)
    public Long newSaveOrder(OrderFormVo orderFormVo, String orderNo) {

        Long userId = SecurityContextHolder.getUserId();
        String userName = SecurityContextHolder.getUserName();

        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setOrderNo(orderNo);
        orderInfo.setUserId(userId);
        orderInfo.setNickName(userName);

        R<UserAddress> userAddressResult = remoteUserAddressService.getUserAddress(Long.parseLong(orderFormVo.getAddressId()), SecurityConstants.INNER);
        if(R.FAIL == userAddressResult.getCode()){
            throw new ServiceException(userAddressResult.getMsg());
        }
        UserAddress userAddress = userAddressResult.getData();

        orderInfo.setReceiverName(userAddress.getReceiver());
        orderInfo.setReceiverPhone(userAddress.getContact());
        orderInfo.setReceiverTagName(userAddress.getTagName());
        orderInfo.setReceiverProvince(userAddress.getProvinceCode());
        orderInfo.setReceiverCity(userAddress.getCityCode());
        orderInfo.setReceiverDistrict(userAddress.getCountyCode());
        orderInfo.setReceiverAddress(userAddress.getFullLocation() + userAddress.getAddress());
        LocalDateTime localDateTime = LocalDateTime.now();
        // 将 LocalDateTime 转换为 java.util.Date
        Date currentDate = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
        orderInfo.setCreateTime(currentDate);

        List<OrderItemVo> orderItemVoList = orderFormVo.getOrderItemVoList();
        BigDecimal totalAmount = new BigDecimal(0);
        BigDecimal originalTotalAmount = new BigDecimal(0);
        for (OrderItemVo orderItemVo : orderItemVoList) {
            totalAmount = totalAmount.add(orderItemVo.getSkuPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
            originalTotalAmount = originalTotalAmount.add(orderItemVo.getOriginalPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
        }

        orderInfo.setTotalAmount(totalAmount);
        orderInfo.setCouponAmount(new BigDecimal(0));
        orderInfo.setOriginalTotalAmount(totalAmount);
        orderInfo.setFreightFee(orderFormVo.getFreightFee());
        //OrderInfo类的orderStatus属性的类型改为Integer
        //1 待付款 2 待发货 3 待收货 4 待评价 5 已完成 6	已取消
        orderInfo.setOrderStatus(1);
        orderInfo.setDeliveryTimeType(1);
        orderInfo.setBuyerMessage(orderFormVo.getBuyerMessage());
        orderInfo.setPayType(orderFormVo.getPayType());
        orderInfo.setPayChannel(orderFormVo.getPayChannel());
        orderInfoMapper.insert(orderInfo);

        //Save order details
        for (OrderItem orderItem : orderItemVoList) {
            orderItem.setOrderId(orderInfo.getId());
            orderItem.setSpuId(orderItem.getSpuId());
            orderItem.setAttrsText(orderItem.getAttrsText());
            orderItemMapper.insert(orderItem);
        }

        //记录日志
        OrderLog orderLog = new OrderLog();
        orderLog.setOrderId(orderInfo.getId());
        //订单状态
        orderLog.setProcessStatus(1);
        orderLog.setNote("submit order");
        orderLogMapper.insert(orderLog);

        return orderInfo.getId();
    }

    private String newGetOrderNo(Long userId) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");

        String currentTime = LocalDateTime.now().format(formatter);
        String orderNo = "pocket" + userId +currentTime;
        return orderNo;
    }

    @Override
    public OrderDetailVo selectOrderDetailByOrderId(Long orderId) {
        OrderDetailVo orderDetailVo = new OrderDetailVo();

        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
        List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderInfo.getId()));
        orderInfo.setOrderItemList(orderItemList);

        List<Long> skuIdList = orderItemList.stream().map(orderItem -> orderItem.getSkuId()).collect(Collectors.toList());
        R<List<ProductSku>> productSkuListResult = remoteProductService.getProductSkuList(skuIdList, SecurityConstants.INNER);
        if(R.FAIL == productSkuListResult.getCode()){
            throw new ServiceException(productSkuListResult.getMsg());
        }
        List<ProductSku> productSkuList = productSkuListResult.getData();

        List<OrderItemVo> orderItemVoList = new ArrayList<>();

        BigDecimal totalAmount = new BigDecimal(0);
        BigDecimal totalOriginalPrice = new BigDecimal(0);
        BigDecimal discountPrice = new BigDecimal(0);
        BigDecimal postFee = new BigDecimal("0.00");

        for(OrderItem orderItem : orderItemList){
            OrderItemVo orderItemVo = new OrderItemVo();
            BeanUtils.copyProperties(orderItem, orderItemVo);
            for(ProductSku productSku : productSkuList){
                if(productSku.getId().equals(orderItemVo.getSkuId())){
                    orderItemVo.setSpuId(productSku.getProductId());
                    orderItemVo.setAttrsText(productSku.getSkuSpec());
                    orderItemVo.setOriginalPrice(productSku.getMarketPrice());
                    orderItemVo.setTotalOriginalPrice(productSku.getMarketPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
                    orderItemVo.setTotalSkuPrice(productSku.getSalePrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
                }
            }
            orderItemVoList.add(orderItemVo);

            totalAmount = totalAmount.add(orderItemVo.getSkuPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
            totalOriginalPrice = totalOriginalPrice.add(orderItemVo.getTotalOriginalPrice());
            BigDecimal feePerItem = new BigDecimal("5.00");
            postFee = postFee.add(feePerItem.multiply(BigDecimal.valueOf(orderItemVo.getSkuNum())));
        }

        orderDetailVo.setOrderId(String.valueOf(orderInfo.getId()));
        orderDetailVo.setOrderNo(orderInfo.getOrderNo());
        orderDetailVo.setPayType(orderInfo.getPayType());
        orderDetailVo.setOrderState(orderInfo.getOrderStatus());
        long time = System.currentTimeMillis()-orderInfo.getCreateTime().getTime();
        long remainTime = MessageQueueConstant.CANCEL_ORDER_DELAY_TIME - time / 1000;
        long countdown = Math.max(0, remainTime);
        orderDetailVo.setCountdown(countdown);
        orderDetailVo.setOrderItemVoList(orderItemVoList);
        orderDetailVo.setReceiverContact(orderInfo.getReceiverName());
        orderDetailVo.setReceiverMobile(orderInfo.getReceiverPhone());
        orderDetailVo.setReceiverAddress(orderInfo.getReceiverAddress());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        orderDetailVo.setCreateTime(simpleDateFormat.format(orderInfo.getCreateTime()));
        orderDetailVo.setTotalMoney(totalAmount);
        orderDetailVo.setPayMoney(totalAmount.add(postFee));
        orderDetailVo.setPostFee(postFee);
        if(orderInfo.getPaymentTime()!= null){
            orderDetailVo.setPayTime(simpleDateFormat.format(orderInfo.getPaymentTime()));
        }

        return orderDetailVo;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void newCancelOrder(Long orderId, OrderRequest orderRequest) {
        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);

         //1 待付款 2 待发货 3 待收货 4 待评价 5 已完成 6	已取消
        if(orderInfo != null && orderInfo.getOrderStatus().intValue() == 1){
            orderInfo.setOrderStatus(6);
            orderInfo.setCancelTime(new Date());
            if(orderRequest.getCancelReason() != null){
                orderInfo.setCancelReason(orderRequest.getCancelReason());
            }
            orderInfoMapper.updateById(orderInfo);

            //记录日志
            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderInfo.getId());
            orderLog.setProcessStatus(6);
            orderLog.setNote("User cancel order");
            orderLogMapper.insert(orderLog);

            //发送MQ消息通知商品系统解锁库存
            rabbitService.sendMessage(MessageQueueConstant.EXCHANGE_PRODUCT, MessageQueueConstant.ROUTING_UNLOCK, orderInfo.getOrderNo());
        }else {
            throw new ServiceException("Order status error");
        }
    }

    @Override
    public void newDeleteOrder(OrderRequest orderRequest) {
        //仅在订单状态为待评价，已完成，已取消时，可删除订单。
        //1 待付款 2 待发货 3 待收货 4 待评价 5 已完成 6	已取消
        if(orderRequest.getIds() != null && orderRequest.getIds().size() > 0) {

            for (Long orderId : orderRequest.getIds()) {
                OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
                if(orderInfo != null && orderInfo.getOrderStatus() >= 4){
                    orderInfoMapper.deleteById(orderId);
                    orderItemMapper.delete(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderId));
                    orderLogMapper.delete(new LambdaQueryWrapper<OrderLog>().eq(OrderLog::getOrderId, orderId));
                }else {
                    throw new ServiceException("Order status error");
                }
            }
        }
    }

    @Override
    public List<OrderDetailVo> newUserOrderInfoList(Integer orderState) {
        List<OrderDetailVo> orderDetailVoList = new ArrayList<>();
        Long userId = SecurityContextHolder.getUserId();

        List<OrderInfo> orderInfoList = null;
        if(orderState == null || orderState == 0){
            orderInfoList = orderInfoMapper.selectList(new LambdaQueryWrapper<OrderInfo>().eq(OrderInfo::getUserId, userId));
        }else {
            orderInfoList = orderInfoMapper.selectList(new LambdaQueryWrapper<OrderInfo>().eq(OrderInfo::getUserId, userId).eq(OrderInfo::getOrderStatus, orderState));
        }

        if(orderInfoList != null){
            for(OrderInfo orderInfo : orderInfoList){
                List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderInfo.getId()));
                OrderDetailVo orderDetailVo = new OrderDetailVo();
                orderDetailVo.setOrderItemList(orderItemList);
                orderDetailVo.setOrderId(String.valueOf(orderInfo.getId()));
                orderDetailVo.setOrderNo(orderInfo.getOrderNo());
                orderDetailVo.setPayType(orderInfo.getPayType());
                orderDetailVo.setOrderState(orderInfo.getOrderStatus());
                long time = System.currentTimeMillis()-orderInfo.getCreateTime().getTime();
                long remainTime = MessageQueueConstant.CANCEL_ORDER_DELAY_TIME - time / 1000;
                long countdown = Math.max(0, remainTime);
                orderDetailVo.setCountdown(countdown);
                orderDetailVo.setReceiverContact(orderInfo.getReceiverName());
                orderDetailVo.setReceiverMobile(orderInfo.getReceiverPhone());
                orderDetailVo.setReceiverAddress(orderInfo.getReceiverAddress());
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                orderDetailVo.setCreateTime(simpleDateFormat.format(orderInfo.getCreateTime()));
                orderDetailVo.setTotalMoney(orderInfo.getTotalAmount());
                orderDetailVo.setPayMoney(orderInfo.getTotalAmount().add(orderInfo.getFreightFee()));
                orderDetailVo.setPostFee(orderInfo.getFreightFee());

                Integer totalNum = orderItemList.stream().mapToInt(OrderItem::getSkuNum).sum();
                orderDetailVo.setTotalNum(totalNum);


                orderDetailVoList.add(orderDetailVo);
            }
            return orderDetailVoList;
        }
        return new ArrayList<>();
    }

    @Override
    public TradeVo newRepurchase(Long orderId) {
        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
        if(orderInfo == null){
            throw new ServiceException("Order does not exist");
        }
        List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderId));
        List<Long> skuIdList = orderItemList.stream().map(OrderItem::getSkuId).collect(Collectors.toList());

        R<List<ProductSku>> productSkuListResult = remoteProductService.getProductSkuList(skuIdList, SecurityConstants.INNER);
        if(R.FAIL == productSkuListResult.getCode()){
            throw new ServiceException(productSkuListResult.getMsg());
        }
        List<ProductSku> productSkuList = productSkuListResult.getData();
        List<OrderItemVo> orderItemVoList = new ArrayList<>();

        Long userId = SecurityContextHolder.getUserId();
        String tradeNo = this.generateTradeNo(userId);

        for (OrderItem orderItem : orderItemList) {

            OrderItemVo orderItemVo = new OrderItemVo();

            BeanUtils.copyProperties(orderItem, orderItemVo);

            orderItemVo.setId(null);
            orderItemVo.setSkuNum(orderItem.getSkuNum());
            orderItemVo.setSpuId(orderItem.getSpuId());

            for (ProductSku productSku : productSkuList) {
                if(orderItem.getSkuId().equals(productSku.getId())){
                    orderItemVo.setSkuPrice(productSku.getSalePrice());
                    orderItemVo.setOriginalPrice(productSku.getMarketPrice());
                    orderItemVo.setAttrsText(productSku.getSkuSpec());

                    orderItemVo.setTotalOriginalPrice(productSku.getMarketPrice().multiply(new BigDecimal(orderItem.getSkuNum())));
                    orderItemVo.setTotalSkuPrice(productSku.getSalePrice().multiply(new BigDecimal(orderItem.getSkuNum())));

                }
            }
            orderItemVoList.add(orderItemVo);
        }

        BigDecimal totalAmount = new BigDecimal(0);
        Integer goodsCount = 0;
        BigDecimal totalOriginalPrice = new BigDecimal(0);
        BigDecimal discountPrice = new BigDecimal(0);
        BigDecimal postFee = new BigDecimal("0.00");

        for (OrderItemVo orderItemVo : orderItemVoList){
            totalAmount = totalAmount.add(orderItemVo.getSkuPrice().multiply(new BigDecimal(orderItemVo.getSkuNum())));
            goodsCount += orderItemVo.getSkuNum();
            totalOriginalPrice = totalOriginalPrice.add(orderItemVo.getTotalOriginalPrice());
            discountPrice = discountPrice.add(orderItemVo.getTotalOriginalPrice().subtract(orderItemVo.getTotalSkuPrice()));
            BigDecimal feePerItem = new BigDecimal("5.00");
            postFee = postFee.add(feePerItem.multiply(BigDecimal.valueOf(orderItemVo.getSkuNum())));
        }

        R<List<UserAddress>> userAddressResult = remoteUserAddressService.userAddressList(SecurityConstants.INNER);
        if(R.FAIL == userAddressResult.getCode()){
            throw new ServiceException(userAddressResult.getMsg());
        }

        TradeVo tradeVo = new TradeVo();
        tradeVo.setTotalAmount(totalAmount.add(postFee));
        tradeVo.setOrderItemVoList(orderItemVoList);
        tradeVo.setUserAddressList(userAddressResult.getData());
        tradeVo.setTradeNo(tradeNo);
        tradeVo.setGoodsCount(goodsCount);
        tradeVo.setTotalOriginalPrice(totalOriginalPrice);
        tradeVo.setDiscountPrice(discountPrice);
        tradeVo.setPostFee(postFee);

        remoteCartService.updateAllUnchecked(userId, SecurityConstants.INNER);

        return tradeVo;
    }

    @Override
    public Page<OrderDetailVo> newUserOrderInfoListFromBackstage(Integer pageNum, Integer pageSize) {
        String userName = SecurityContextHolder.getUserName();
        R<LoginUser> userResult = remoteUserService.getUserInfo(userName, SecurityConstants.INNER);
        if(R.FAIL == userResult.getCode()){
            throw new ServiceException(userResult.getMsg());
        }
        if(userResult.getData() == null){
            throw new ServiceException("User does not exist");
        }

        // 创建分页对象
        Page<OrderInfo> page = new Page<>(pageNum, pageSize);
        // 使用 MyBatis-Plus 分页查询
        Page<OrderInfo> orderInfoPage = orderInfoMapper.selectPage(page, null);
        List<OrderDetailVo> orderDetailVoList = new ArrayList<>();
        List<OrderInfo> orderInfoList = orderInfoPage.getRecords();
        if(orderInfoList != null){
            for(OrderInfo orderInfo : orderInfoList){
                List<OrderItem> orderItemList = orderItemMapper.selectList(new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderInfo.getId()));
                OrderDetailVo orderDetailVo = new OrderDetailVo();
                orderDetailVo.setOrderItemList(orderItemList);
                orderDetailVo.setOrderId(String.valueOf(orderInfo.getId()));
                orderDetailVo.setOrderNo(orderInfo.getOrderNo());
                orderDetailVo.setPayType(orderInfo.getPayType());
                orderDetailVo.setOrderState(orderInfo.getOrderStatus());
                long time = System.currentTimeMillis()-orderInfo.getCreateTime().getTime();
                long remainTime = MessageQueueConstant.CANCEL_ORDER_DELAY_TIME - time / 1000;
                long countdown = Math.max(0, remainTime);
                orderDetailVo.setCountdown(countdown);
                orderDetailVo.setReceiverContact(orderInfo.getReceiverName());
                orderDetailVo.setReceiverMobile(orderInfo.getReceiverPhone());
                orderDetailVo.setReceiverAddress(orderInfo.getReceiverAddress());
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                orderDetailVo.setCreateTime(simpleDateFormat.format(orderInfo.getCreateTime()));
                orderDetailVo.setTotalMoney(orderInfo.getTotalAmount());
                orderDetailVo.setPayMoney(orderInfo.getTotalAmount().add(orderInfo.getFreightFee()));
                orderDetailVo.setPostFee(orderInfo.getFreightFee());
                if(orderInfo.getPaymentTime() != null){
                    orderDetailVo.setPayTime(simpleDateFormat.format(orderInfo.getPaymentTime()));
                }


                Integer totalNum = orderItemList.stream().mapToInt(OrderItem::getSkuNum).sum();
                orderDetailVo.setTotalNum(totalNum);

                orderDetailVoList.add(orderDetailVo);
            }

            // 创建新的 Page 对象存储 OrderDetailVo 数据
            Page<OrderDetailVo> resultPage = new Page<>(
                    orderInfoPage.getCurrent(),
                    orderInfoPage.getSize(),
                    orderInfoPage.getTotal()
            );
            resultPage.setRecords(orderDetailVoList);
            return resultPage;
        }
        return null;
    }


    @Override
    public OrderSalesVo getSalesData(String startTime, String endTime){
        OrderSalesVo orderSalesVo = orderInfoMapper.selectOrderSalesData(startTime, endTime);

        List<TopSalesVo> topSalesVos = orderInfoMapper.selectTopThreeBestSellingProducts(startTime, endTime);

        if(topSalesVos == null || topSalesVos.size() == 0){
            return orderSalesVo;
        }

        orderSalesVo.setTopSalesVosList(topSalesVos);

        return orderSalesVo;

    }

    @Override
    public OrderSalesVo getOrderData(Long userId, String startTime, String endTime) {

        OrderSalesVo orderSalesVo = orderInfoMapper.selectOrderData(userId, startTime, endTime);

        return orderSalesVo;
    }


}
