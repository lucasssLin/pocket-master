package com.ruoyi.user.controller;

import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.user.service.ISmsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Slf4j
@Tag(name = "SMS API")
@RestController
@RequestMapping("/sms")
public class SmsController extends BaseController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private ISmsService iSmsService;

    @Operation(summary = "获取图片验证码")
    @GetMapping(value = "sendCode/{phone}")
    public AjaxResult sendCode(@Parameter(name = "phone", description = "手机", required = true) @PathVariable String phone) {
        String code = new DecimalFormat("0000").format(new Random().nextInt(10000));

        stringRedisTemplate.opsForValue().set("phone:code:"+phone, code, 5, TimeUnit.MINUTES);
        log.info(phone + ": " + code);

        Map<String, Object> map = new HashMap<>();
        map.put("code", "**code**:"+code+",**minute**:5");
        iSmsService.send(phone, "", map);

        return success();

    }

}
