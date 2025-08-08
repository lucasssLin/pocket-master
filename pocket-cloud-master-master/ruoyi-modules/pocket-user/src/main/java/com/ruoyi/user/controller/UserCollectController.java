package com.ruoyi.user.controller;

import com.github.pagehelper.PageHelper;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresLogin;
import com.ruoyi.product.api.domain.SkuPrice;
import com.ruoyi.user.domain.UserCollect;
import com.ruoyi.user.service.IUserCollectService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/userInfo")
public class UserCollectController extends BaseController {
    @Autowired
    private IUserCollectService userCollectService;

    @Operation(summary = "判断商品是否收藏")
    @RequiresLogin
    @GetMapping("/isCollect/{spuId}")
    public AjaxResult isCollect(@PathVariable("spuId")Long spuId){
        Boolean flag = userCollectService.isCollect(spuId);
        return AjaxResult.success(flag);
    }

    @Operation(summary = "当前用户收藏商品")
    @RequiresLogin
    @GetMapping("/collect/{spuId}")
    public AjaxResult collect(@PathVariable("spuId")Long spuId){
        Boolean flag = userCollectService.collect(spuId);
        return AjaxResult.success(flag);
    }

    @Operation(summary = "当前用户取消收藏商品")
    @RequiresLogin
    @GetMapping("/cancelCollect/{spuId}")
    public AjaxResult cancelCollect(@PathVariable("spuId")Long spuId){
        Boolean flag = userCollectService.cancelCollect(spuId);
        return AjaxResult.success(flag);
    }

    @Operation(summary = "获取当前登录用户收藏商品")
    @RequiresLogin
    @GetMapping("/userCollectList/{pageNum}/{pageSize}")
    public TableDataInfo userCollectList(@PathVariable("pageNum")Integer pageNum, @PathVariable("pageSize")Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<UserCollect> list = userCollectService.userCollectList();
        return getDataTable(list);
    }
}
