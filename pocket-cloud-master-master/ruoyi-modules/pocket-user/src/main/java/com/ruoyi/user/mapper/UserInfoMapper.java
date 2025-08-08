package com.ruoyi.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.user.api.domain.UserInfo;

import java.util.List;


/**
 * 会员Mapper接口
 * 
 * @author pocket
 * @date 2025-01-25
 */
public interface UserInfoMapper extends BaseMapper<UserInfo>
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
     * 删除会员
     * 
     * @param id 会员主键
     * @return 结果
     */
    public int deleteUserInfoById(Long id);

    /**
     * 批量删除会员
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserInfoByIds(Long[] ids);
}
