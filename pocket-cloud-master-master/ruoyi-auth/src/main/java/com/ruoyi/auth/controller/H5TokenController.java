package com.ruoyi.auth.controller;

import com.ruoyi.auth.form.LoginBody;
import com.ruoyi.auth.form.RegisterBody;
import com.ruoyi.auth.service.H5LoginService;
import com.ruoyi.auth.service.SysLoginService;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.JwtUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.bean.BeanUtils;
import com.ruoyi.common.security.auth.AuthUtil;
import com.ruoyi.common.security.service.TokenService;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.system.api.model.LoginUser;
import com.ruoyi.user.api.domain.UserInfo;
import com.ruoyi.user.api.domain.UserInfoLoginVo;
import com.ruoyi.user.api.service.RemoteUserInfoService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class H5TokenController {

    @Autowired
    private H5LoginService h5LoginService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private SysLoginService sysLoginService;
    @Autowired
    private RemoteUserInfoService remoteUserInfoService;

    @PostMapping("/h5/register")
    public R<?> register(@RequestBody RegisterBody registerBody)
    {

        h5LoginService.register(registerBody);
        return R.ok();
    }

    @PostMapping("/h5/login")
    public R<?> login(@RequestBody LoginBody loginBody)
    {
        // 用户登录
        LoginUser loginUser = h5LoginService.login(loginBody.getUsername(), loginBody.getPassword());
        // 获取登录token
        String token = String.valueOf(tokenService.createToken(loginUser).get("access_token"));
        R<UserInfo> userInfoResult = remoteUserInfoService.getUserInfo(loginUser.getUsername(), SecurityConstants.INNER);
        if(userInfoResult.getCode() == R.FAIL){
            throw new ServiceException(userInfoResult.getMsg());
        }
        UserInfo userInfo = userInfoResult.getData();
        UserInfoLoginVo userInfoLoginVo = new UserInfoLoginVo();
        BeanUtils.copyProperties(userInfo, userInfoLoginVo);
        userInfoLoginVo.setToken(token);
        userInfoLoginVo.setPassword(null);

        return R.ok(userInfoLoginVo);
    }


    @DeleteMapping("/h5/logout")
    public R<?> logout(HttpServletRequest request) {
        String token = SecurityUtils.getToken(request);
        if (StringUtils.isNotEmpty(token))
        {
            String username = JwtUtils.getUserName(token);
            // delete cache by token
            AuthUtil.logoutByToken(token);
            // save logout log
            sysLoginService.logout(username);
        }
        return R.ok();
    }



}
