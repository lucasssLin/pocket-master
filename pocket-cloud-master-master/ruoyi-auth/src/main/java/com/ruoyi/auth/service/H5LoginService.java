package com.ruoyi.auth.service;

import com.ruoyi.auth.form.RegisterBody;
import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.constant.Constants;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.enums.UserStatus;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.text.Convert;

import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.ip.IpUtils;
import com.ruoyi.common.redis.service.RedisService;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.system.api.domain.SysUser;
import com.ruoyi.system.api.model.LoginUser;
import com.ruoyi.user.api.domain.UpdateUserLogin;
import com.ruoyi.user.api.domain.UserInfo;
import com.ruoyi.user.api.service.RemoteUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class H5LoginService {

    @Autowired
    private RemoteUserInfoService remoteUserInfoService;

    @Autowired
    private SysRecordLogService recordLogService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private SysPasswordService passwordService;

    @Autowired
    private RedisService redisService;


    public void register(RegisterBody registerBody) {

        String username = registerBody.getUsername();
        String password = registerBody.getPassword();
        //String code = registerBody.getCode();
        String nickName = registerBody.getNickName();

        if (StringUtils.isAnyBlank(username, password)) {
            throw new ServiceException("Username/Password must be entered");
        }
        if (username.length() != 11) {
            throw new ServiceException("Username length must be 11 characters");
        }

        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH || password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
            throw new ServiceException("The password must be between 5 and 20 characters long");
        }

//        if (StringUtils.isEmpty(code)) {
//            throw new ServiceException("Verification code must be entered");
//        }



        UserInfo userInfo = new UserInfo();
        userInfo.setUsername(username);
        nickName = StringUtils.isEmpty(nickName) ? username : nickName;
        userInfo.setNickName(nickName);
        userInfo.setPassword(SecurityUtils.encryptPassword(password));
        userInfo.setPhone(username);

        R<?> registerResult = remoteUserInfoService.register(userInfo, SecurityConstants.INNER);

        if (R.FAIL == registerResult.getCode()){
            throw new ServiceException(registerResult.getMsg());
        }
        recordLogService.recordLogininfor(username, Constants.REGISTER, "Register success");
    }


    public LoginUser login(String username, String password){
        if (StringUtils.isAnyBlank(username, password)) {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "Username/Password must be entered");
            throw new ServiceException("Username/Password must be entered");
        }

        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH || password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "User password is not within the specified range");
            throw new ServiceException("User password is not within the specified range");
        }

        if (username.length() < UserConstants.USERNAME_MIN_LENGTH || username.length() > UserConstants.USERNAME_MAX_LENGTH) {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "Username is not within the specified range");
            throw new ServiceException("Username is not within the specified range");
        }

        String blackStr = Convert.toStr(redisService.getCacheObject(CacheConstants.SYS_LOGIN_BLACKIPLIST));
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr())) {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "IP is blacklisted from the system");
            throw new ServiceException("IP is blacklisted from the system");
        }

        R<UserInfo> userInfoResult = remoteUserInfoService.getUserInfo(username, SecurityConstants.INNER);

        if(StringUtils.isNull(userInfoResult) || StringUtils.isNull(userInfoResult.getData())){
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "Login user is not existed");
            throw new ServiceException("Login user：" + username + " is not existed");
        }
        if(R.FAIL == userInfoResult.getCode()){
            throw new ServiceException(userInfoResult.getMsg());
        }

        UserInfo userInfo = userInfoResult.getData();
        LoginUser loginUser = new LoginUser();
        SysUser sysUser = new SysUser();

        loginUser.setUserid(userInfo.getId());
        loginUser.setUsername(userInfo.getUsername());

        sysUser.setPassword(userInfo.getPassword());
        sysUser.setStatus(userInfo.getStatus()+"");
        sysUser.setUserId(userInfo.getId());
        sysUser.setUserName(userInfo.getUsername());
        loginUser.setSysUser(sysUser);

        if(UserStatus.DISABLE.getCode().equals(userInfo.getStatus())){
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "User is disabled. Please contact the administrator");
            throw new ServiceException("Sorry, your account：" + username + " is disabled");
        }

        passwordService.validate(loginUser.getSysUser(), password);

        recordLogService.recordLogininfor(username, Constants.LOGIN_SUCCESS, "Login success");

        //更新登录信息
        UpdateUserLogin updateUserLogin = new UpdateUserLogin();
        updateUserLogin.setUserId(userInfo.getId());
        updateUserLogin.setLastLoginIp(IpUtils.getIpAddr());
        updateUserLogin.setLastLoginTime(new Date());
        remoteUserInfoService.updateUserLogin(updateUserLogin, SecurityConstants.INNER);

        return loginUser;
    }







}
