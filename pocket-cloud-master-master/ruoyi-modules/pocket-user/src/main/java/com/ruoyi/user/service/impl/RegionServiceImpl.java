package com.ruoyi.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.user.domain.Region;
import com.ruoyi.user.mapper.RegionMapper;
import com.ruoyi.user.service.IRegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegionServiceImpl extends ServiceImpl<RegionMapper, Region> implements IRegionService {

    @Autowired
    private RegionMapper regionMapper;

    @Override
    public String getNameByCode(String code) {
        if (StringUtils.isEmpty(code)){
            return "";
        }

        Region region = regionMapper.selectOne(new LambdaQueryWrapper<Region>().eq(Region::getCode, code).select(Region::getName));

        if(null != region) {
            return region.getName();
        }
        return "";
    }

    @Override
    public List<Region> selectRegionsByParentCode(String parentCode) {
        return baseMapper.selectList(new LambdaQueryWrapper<Region>().eq(Region::getParentCode, parentCode));
    }
}
