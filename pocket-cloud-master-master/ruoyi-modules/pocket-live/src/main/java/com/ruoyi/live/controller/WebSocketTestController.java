package com.ruoyi.live.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Tag(name = "WebSocket测试", description = "WebSocket和WebRTC测试页面")
@Controller
@RequestMapping("/live/test")
public class WebSocketTestController {

    @Operation(summary = "WebSocket测试页面")
    @GetMapping("/websocket")
    public String websocketTest() {
        return "websocket-test";
    }

    @Operation(summary = "WebRTC测试页面")
    @GetMapping("/webrtc/{roomId}")
    public String webrtcTest(@PathVariable String roomId, Model model) {
        model.addAttribute("roomId", roomId);
        return "webrtc-test";
    }

    @Operation(summary = "直播间演示页面")
    @GetMapping("/live-room/{roomId}")
    public String liveRoomDemo(@PathVariable String roomId, Model model) {
        model.addAttribute("roomId", roomId);
        return "live-room-demo";
    }


    @GetMapping("/ws")
    public String websocketConnectionTest() {
        return "websocket-test";
    }



    @GetMapping("/quick")
    public String quickTest() {
        return "quick-test";
    }



    @GetMapping("/webrtc-simple")
    public String webrtcSimpleTest() {
        return "webrtc-simple";
    }
} 