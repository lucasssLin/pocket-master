package com.ruoyi.live.config;

import com.ruoyi.live.handler.LiveWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.reactive.socket.client.TomcatWebSocketClient;
import org.springframework.web.reactive.socket.client.WebSocketClient;
import org.springframework.web.reactive.socket.server.RequestUpgradeStrategy;
import org.springframework.web.reactive.socket.server.upgrade.TomcatRequestUpgradeStrategy;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private LiveWebSocketHandler liveWebSocketHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        WebSocketHandshakeInterceptor interceptor = new WebSocketHandshakeInterceptor();
        
        // 注册直播WebSocket处理器，支持跨域
        registry.addHandler(liveWebSocketHandler, "/live/ws/{roomId}")
                .setAllowedOriginPatterns("*") // 使用Pattern支持更好的跨域配置
                .addInterceptors(interceptor) // 添加握手拦截器
                .withSockJS(); // 启用SockJS支持，兼容不支持WebSocket的浏览器
        
        // 注册WebRTC信令处理器
        registry.addHandler(liveWebSocketHandler, "/live/signaling/{roomId}")
                .setAllowedOriginPatterns("*")
                .addInterceptors(interceptor);// 添加握手拦截器
                //withSockJS();

        
        // 注册原始WebSocket连接（不使用SockJS）
        registry.addHandler(liveWebSocketHandler, "/ws/{roomId}")
                .setAllowedOriginPatterns("*")
                .addInterceptors(interceptor)// 添加握手拦截器
                .withSockJS();
    }

} 