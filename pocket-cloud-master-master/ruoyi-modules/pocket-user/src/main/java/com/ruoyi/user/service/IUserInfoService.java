package com.ruoyi.user.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.user.api.domain.UpdateUserLogin;
import com.ruoyi.user.api.domain.UserInfo;
import com.ruoyi.user.api.domain.UserAddress;


/**
 * 会员Service接口
 * 
 * @author pocket
 * @date 2025-01-25
 */
public interface IUserInfoService extends IService<UserInfo>
{
    /**
     * 查询会员
     * 
     * @param id 会员主键
     * @return 会员
     */
    public UserInfo selectUserInfoById(Long id);

    /**
     * 查询会员列表
     * 
     * @param userInfo 会员
     * @return 会员集合
     */
    public List<UserInfo> selectUserInfoList(UserInfo userInfo);

    /**
     * 新增会员
     * 
     * @param userInfo 会员
     * @return 结果
     */
    public int insertUserInfo(UserInfo userInfo);

    /**
     * 修改会员
     * 
     * @param userInfo 会员
     * @return 结果
     */
    public int updateUserInfo(UserInfo userInfo);

    /**
     * 批量删除会员
     * 
     * @param ids 需要删除的会员主键集合
     * @return 结果
     */
    public int deleteUserInfoByIds(Long[] ids);

    /**
     * 删除会员信息
     * 
     * @param id 会员主键
     * @return 结果
     */
    public int deleteUserInfoById(Long id);

    public List<UserAddress> selectUserAddressList(Long userId);

    void register(UserInfo userInfo);

    UserInfo selectUserByUserName(String username);

    Boolean updateUserLogin(UpdateUserLogin updateUserLogin);
}
