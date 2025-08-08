package com.ruoyi.user.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.user.api.domain.UserAddress;


public interface IUserAddressService extends IService<UserAddress>
{
    public List<UserAddress> selectUserAddressList();

    public int insertUserAddress(UserAddress userAddress);

    public int updateUserAddress(UserAddress userAddress);

}
