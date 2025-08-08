package com.ruoyi.live.domain.message;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;


// WebRTC信令消息实体

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignalingMessage {
    

    //消息类型: offer, answer, ice-candidate, chat, user-joined, user-left, heart-beat, etc.
    private String type;
    


    private String fromUserId;
    

    private String targetUserId;
    

    //消息负载 (SDP描述、ICE候选者、聊天内容等)
    private Object data;
    

    private long timestamp;
    

    public SignalingMessage(String type, String fromUserId, Object data) {
        this.type = type;
        this.fromUserId = fromUserId;
        this.data = data;
        this.timestamp = System.currentTimeMillis();
    }

    public SignalingMessage(String type, String fromUserId, String targetUserId, Object data) {
        this.type = type;
        this.fromUserId = fromUserId;
        this.targetUserId = targetUserId;
        this.data = data;
        this.timestamp = System.currentTimeMillis();
    }
} 