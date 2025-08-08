package com.ruoyi.user.controller;

import java.util.List;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.security.annotation.InnerAuth;
import com.ruoyi.common.security.annotation.RequiresLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.user.api.domain.UserAddress;
import com.ruoyi.user.service.IUserAddressService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;

/**
 * 用户地址Controller
 * 
 * @author pocket
 * @date 2025-01-25
 */
@RestController
@RequestMapping("/userAddress")
public class UserAddressController extends BaseController {
    @Autowired
    private IUserAddressService userAddressService;

    /**
     * 查询用户地址列表
     */
    @RequiresLogin
    @GetMapping("/list")
    public AjaxResult list() {
        List<UserAddress> list = userAddressService.selectUserAddressList();
        return success(list);
    }


    @InnerAuth
    @GetMapping("/userAddressList")
    public R<List<UserAddress>> userAddressList() {
        List<UserAddress> list = userAddressService.selectUserAddressList();
        return R.ok(list);
    }


    /**
     * 新增用户地址
     */
    @RequiresLogin
    @PostMapping(value = "/addAddress")
    public AjaxResult addAddress(@RequestBody UserAddress userAddress) {
        return toAjax(userAddressService.insertUserAddress(userAddress));
    }

    /**
     * 修改用户地址
     */
    @RequiresLogin
    @PutMapping(value = "/editAddress/{id}")
    public AjaxResult editAddress(@RequestBody UserAddress userAddress, @PathVariable("id") Long id) {
        userAddress.setId(id);
        return toAjax(userAddressService.updateUserAddress(userAddress));
    }

    @GetMapping(value = "/getUserAddressToEdit/{id}")
    public R<UserAddress> getUserAddressToEdit(@PathVariable("id") Long id) {
        return R.ok(userAddressService.getById(id));
    }

    /**
     * 删除用户地址
     */
    @RequiresLogin
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) {
        return toAjax(userAddressService.removeById(id));
    }


    @InnerAuth
    @GetMapping(value = "/getUserAddress/{id}")
    public R<UserAddress> getUserAddress(@PathVariable("id") Long id) {
        return R.ok(userAddressService.getById(id));
    }
}
