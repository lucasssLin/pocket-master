package com.ruoyi.user.service;

import java.util.Map;

public interface ISmsService {
    void send(String phone, String templateCode, Map<String, Object> map);
}
