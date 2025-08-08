package com.ruoyi.user.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.context.SecurityContextHolder;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.user.service.IRegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.UserAddressMapper;
import com.ruoyi.user.api.domain.UserAddress;
import com.ruoyi.user.service.IUserAddressService;


@Service
public class UserAddressServiceImpl extends ServiceImpl<UserAddressMapper, UserAddress> implements IUserAddressService
{
    @Autowired
    private UserAddressMapper userAddressMapper;

    @Autowired
    private IRegionService regionService;




    @Override
    public List<UserAddress> selectUserAddressList() {

        Long userId = SecurityContextHolder.getUserId();
        return userAddressMapper.selectList(new LambdaQueryWrapper<UserAddress>().eq(UserAddress::getUserId,userId));

    }


    @Override
    public int insertUserAddress(UserAddress userAddress)
    {
        userAddress.setUserId(SecurityContextHolder.getUserId());
        String provinceName = regionService.getNameByCode(userAddress.getProvinceCode());
        String cityName = regionService.getNameByCode(userAddress.getCityCode());
        String districtName = regionService.getNameByCode(userAddress.getCountyCode());
        String fullAddressName =  userAddress.getAddress();
        userAddress.setAddress(fullAddressName);
        userAddress.setCreateTime(DateUtils.getNowDate());

        if(userAddress.getIsDefault().intValue() == 1) {
            UserAddress updateUserAddress = new UserAddress();
            updateUserAddress.setIsDefault(0L);
            userAddressMapper.update(updateUserAddress, new LambdaQueryWrapper<UserAddress>().eq(UserAddress::getUserId, userAddress.getUserId()));
        }
        return userAddressMapper.insert(userAddress);


    }

    @Override
    public int updateUserAddress(UserAddress userAddress)
    {
        String provinceName = regionService.getNameByCode(userAddress.getProvinceCode());
        String cityName = regionService.getNameByCode(userAddress.getCityCode());
        String districtName = regionService.getNameByCode(userAddress.getCountyCode());
        String fullAddressName = userAddress.getAddress();

        userAddress.setAddress(fullAddressName);
        userAddress.setUpdateTime(DateUtils.getNowDate());

        if(userAddress.getIsDefault().intValue() == 1){
            UserAddress updateUserAddress = new UserAddress();
            updateUserAddress.setIsDefault(0L);
            userAddressMapper.update(updateUserAddress, new LambdaQueryWrapper<UserAddress>().eq(UserAddress::getUserId, userAddress.getUserId()));
        }
        return userAddressMapper.updateById(userAddress);

    }


}
