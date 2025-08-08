package com.ruoyi.user.controller;

import java.time.LocalDateTime;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.pagehelper.PageHelper;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresLogin;
import com.ruoyi.user.api.domain.*;
import com.ruoyi.user.domain.UserBrowseHistory;
import com.ruoyi.user.domain.UserInfoVo;
import com.ruoyi.user.mapper.UserBehaviorMapper;
import com.ruoyi.user.service.IUserBrowseHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;

import com.ruoyi.user.service.IUserInfoService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 会员Controller
 * 
 * @author pocket
 * @date 2025-01-25
 */
@RestController
@RequestMapping("/userInfo")
public class UserInfoController extends BaseController
{
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IUserBrowseHistoryService userBrowseHistoryService;
    @Autowired
    private UserBehaviorMapper userBehaviorMapper;

    /**
     * 查询会员列表
     */
    @RequiresPermissions("user:info:list")
    @GetMapping("/list")
    public TableDataInfo list(UserInfo userInfo)
    {
        startPage();
        List<UserInfo> list = userInfoService.selectUserInfoList(userInfo);
        return getDataTable(list);
    }

    /**
     * 导出会员列表
     */
    @RequiresPermissions("user:info:export")
    @Log(title = "会员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserInfo userInfo)
    {
        List<UserInfo> list = userInfoService.selectUserInfoList(userInfo);
        ExcelUtil<UserInfo> util = new ExcelUtil<UserInfo>(UserInfo.class);
        util.exportExcel(response, list, "会员数据");
    }

    /**
     * 获取会员详细信息
     */
    @RequiresPermissions("user:info:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(userInfoService.selectUserInfoById(id));
    }

    /**
     * 新增会员
     */
    @RequiresPermissions("user:info:add")
    @Log(title = "会员", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserInfo userInfo)
    {
        return toAjax(userInfoService.insertUserInfo(userInfo));
    }

    /**
     * 修改会员
     */
    @RequiresPermissions("user:info:edit")
    @Log(title = "会员", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserInfo userInfo)
    {
        return toAjax(userInfoService.updateUserInfo(userInfo));
    }

    /**
     * 删除会员
     */
    @RequiresPermissions("user:info:remove")
    @Log(title = "会员", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(userInfoService.deleteUserInfoByIds(ids));
    }




    @Operation(summary = "Get User Address")
    @RequiresPermissions("user:info:query")
    @GetMapping("getUserAddress/{userId}")
    public AjaxResult getUserAddress(@PathVariable Long userId) {
        List<UserAddress> userAddressList = userInfoService.selectUserAddressList(userId);
        return success(userAddressList);
    }


    @InnerAuth
    @PostMapping("/register")
    public R<Boolean> register(@RequestBody UserInfo userInfo)
    {
        userInfoService.register(userInfo);
        return R.ok();
    }

    @Operation(summary = "Get userinfo by username")
    @InnerAuth
    @GetMapping("/info/{username}")
    public R<UserInfo> getUserInfo(@PathVariable("username") String username)
    {
        UserInfo userInfo = userInfoService.selectUserByUserName(username);
        return R.ok(userInfo);
    }

    @Operation(summary = "update user login info")
    @InnerAuth
    @PutMapping("/updateUserLogin")
    public R<Boolean> updateUserLogin(@RequestBody UpdateUserLogin updateUserLogin)
    {
        return R.ok(userInfoService.updateUserLogin(updateUserLogin));
    }


    @Operation(summary = "Get current login user info")
    @RequiresLogin
    @GetMapping("/getLoginUserInfo")
    public AjaxResult getLoginUserInfo(HttpServletRequest request) {
        Long userId = SecurityContextHolder.getUserId();
        UserInfo userInfo = userInfoService.getById(userId);
        userInfo.setPassword(null);

//        UserInfoVo userInfoVo = new UserInfoVo();
//        BeanUtils.copyProperties(userInfo, userInfoVo);
        return success(userInfo);
    }

    @Operation(summary = "Update current login user info")
    @RequiresLogin
    @PutMapping("/updateLoginUserInfo")
    public R<Boolean> updateLoginUserInfo(@RequestBody UserInfo userInfo) {
        Long userId = SecurityContextHolder.getUserId();
        userInfo.setId(userId);
        return R.ok(userInfoService.updateById(userInfo));
    }


    @Operation(summary = "获取当前登录用户浏览记录")
    @RequiresLogin
    @GetMapping("/userBrowseHistoryList/{pageNum}/{pageSize}")
    public TableDataInfo userBrowseHistoryList(@PathVariable("pageNum")Integer pageNum, @PathVariable("pageSize")Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<UserBrowseHistory> list = userBrowseHistoryService.selectUserBrowseHistoryList();
        return getDataTable(list);
    }

    @Operation(summary = "删除当前登录用户浏览记录")
    @RequiresLogin
    @DeleteMapping("/DeleteUserBrowseHistory/{id}")
    public AjaxResult DeleteUserBrowseHistory(@PathVariable("id")Long id) {
        Boolean flag =  userBrowseHistoryService.deleteUserBrowseHistory(id);
        return success(flag);
    }


    @Operation(summary = "Get UserBehavior by time")
    @InnerAuth
    @PostMapping("/selectUserBehavior")
    public R<List<UserBehavior>> selectUserBehavior(@RequestBody LocalDateTime startTime)
    {
        List<UserBehavior> userBehaviors = userBehaviorMapper.selectList(new LambdaQueryWrapper<UserBehavior>().gt(UserBehavior::getCreateTime, startTime));
        return R.ok(userBehaviors);
    }

    @Operation(summary = "Get UserBehavior by userId")
    @InnerAuth
    @GetMapping("/selectUserBehaviorByUserId/{userId}")
    R<List<UserBehavior>> selectUserBehaviorByUserId(@PathVariable("userId") Long userId)
    {
        List<UserBehavior> userBehaviors = userBehaviorMapper.selectList(new LambdaQueryWrapper<UserBehavior>().eq(UserBehavior::getUserId, userId));
        return R.ok(userBehaviors);
    }

}
