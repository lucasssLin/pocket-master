package com.ruoyi.live;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;


@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication
public class PocketLiveApplication {
    public static void main(String[] args) {
        SpringApplication.run(PocketLiveApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  直播模块启动成功   ლ(´ڡ`ლ)ﾞ  ");
    }
} 