package com.ruoyi.live.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.net.URI;
import java.util.Map;


@Slf4j
public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        
        URI uri = request.getURI();
        String query = uri.getQuery();
        
        log.debug("WebSocket握手请求: {}", uri);
        
        if (query != null) {
            String[] params = query.split("&");
            for (String param : params) {
                String[] keyValue = param.split("=");
                if (keyValue.length == 2) {
                    String key = keyValue[0];
                    String value = keyValue[1];
                    
                    // 将查询参数设置到attributes中
                    attributes.put(key, value);
                    log.debug("设置WebSocket属性: {} = {}", key, value);
                }
            }
        }
        
        // 从路径中提取房间ID
        String path = uri.getPath();
        String[] segments = path.split("/");
        if (segments.length > 0) {
            String roomId = segments[segments.length - 1];
            attributes.put("roomId", roomId);
            log.debug("设置房间ID: {}", roomId);
        }
        
        return true; // 继续握手
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        if (exception != null) {
            log.error("WebSocket握手后发生异常", exception);
        } else {
            log.debug("WebSocket握手完成: {}", request.getURI());
        }
    }
} 