package com.ruoyi.common.rabbit.constant;

public class MessageQueueConstant {

	/**
     * 测试
     */
    //测试相关的交换机名称
    public static final String EXCHANGE_TEST = "pocket.test";
    //测试相关的路由键
    public static final String ROUTING_TEST = "pocket.test";
    //测试确认相关的路由键
    public static final String ROUTING_CONFIRM = "pocket.confirm";
    //队列
    //测试相关的队列名称
    public static final String QUEUE_TEST  = "pocket.test";
    //测试确认相关的队列名称
    public static final String QUEUE_CONFIRM  = "pocket.confirm";

    /**
     * 库存
     */
    //库存相关的交换机名称
    public static final String EXCHANGE_PRODUCT = "pocket.product";
    //库存解锁相关的路由键
    public static final String ROUTING_UNLOCK = "pocket.unlock";
    //库存减少相关的路由键
    public static final String ROUTING_MINUS = "pocket.minus";
    //队列
    //库存解锁相关的队列名称
    public static final String QUEUE_UNLOCK  = "pocket.unlock";
    //库存减少相关的队列名称
    public static final String QUEUE_MINUS  = "pocket.minus";

    /**
     * 支付
     */
    public static final String EXCHANGE_PAYMENT_PAY = "pocket.payment";
    public static final String ROUTING_PAYMENT_PAY = "pocket.payment.pay";
    public static final String ROUTING_PAYMENT_CLOSE = "pocket.payment.close";;
    public static final String QUEUE_PAYMENT_PAY = "pocket.payment.pay";
    public static final String QUEUE_PAYMENT_CLOSE  = "queue.payment.close";


    /**
     * 取消订单延迟消息
     */
    public static final String EXCHANGE_CANCEL_ORDER = "pocket.cancel.order";
    public static final String ROUTING_CANCEL_ORDER = "pocket.cancel.order";
    public static final String QUEUE_CANCEL_ORDER = "pocket.cancel.order";
    public static final Integer CANCEL_ORDER_DELAY_TIME = 10*60; //1*60;

    /**
     * 直播模块消息
     */
    // 直播相关的交换机名称
    public static final String EXCHANGE_LIVE = "pocket.live";
    // 直播间状态变更路由键
    public static final String ROUTING_LIVE_STATUS = "pocket.live.status";
    // 直播间观看人数变更路由键
    public static final String ROUTING_LIVE_VIEWER = "pocket.live.viewer";
    // 直播间聊天消息路由键
    public static final String ROUTING_LIVE_CHAT = "pocket.live.chat";
    // 直播间礼物消息路由键
    public static final String ROUTING_LIVE_GIFT = "pocket.live.gift";
    
    // 队列
    // 直播间状态变更队列
    public static final String QUEUE_LIVE_STATUS = "pocket.live.status";
    // 直播间观看人数变更队列
    public static final String QUEUE_LIVE_VIEWER = "pocket.live.viewer";
    // 直播间聊天消息队列
    public static final String QUEUE_LIVE_CHAT = "pocket.live.chat";
    // 直播间礼物消息队列
    public static final String QUEUE_LIVE_GIFT = "pocket.live.gift";

    /**
     * 商品浏览记录
     */
    public static final String EXCHANGE_BROWSE_HISTORY = "pocket.browse";
    public static final String QUEUE_BROWSE_HISTORY = "pocket.browse.product";
    public static final String ROUTING_BROWSE_HISTORY = "pocket.browse.product";

}