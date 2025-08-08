package com.ruoyi.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.user.domain.UserBrowseHistory;

import java.util.List;

public interface IUserBrowseHistoryService extends IService<UserBrowseHistory>
{
    List<UserBrowseHistory> selectUserBrowseHistoryList();

    void createBrowseHistory(Long spuId, Long userId);

    Boolean deleteUserBrowseHistory(Long id);
}