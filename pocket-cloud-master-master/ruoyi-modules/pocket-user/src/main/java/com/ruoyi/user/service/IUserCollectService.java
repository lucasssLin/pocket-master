package com.ruoyi.user.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.user.domain.UserCollect;

/**
 * 用户收藏Service接口
 *
 * @author atguigu
 * @date 2024-08-20
 */
public interface IUserCollectService extends IService<UserCollect> {

    /**
     * 查询用户收藏列表
     *
     * @param userCollect 用户收藏
     * @return 用户收藏集合
     */
    public List<UserCollect> selectUserCollectList(UserCollect userCollect);

    Boolean isCollect(Long spuId);

    Boolean collect(Long spuId);

    Boolean cancelCollect(Long spuId);

    List<UserCollect> userCollectList();
}