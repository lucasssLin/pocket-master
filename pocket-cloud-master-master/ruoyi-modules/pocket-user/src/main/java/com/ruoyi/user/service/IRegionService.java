package com.ruoyi.user.service;

import java.util.List;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.user.domain.Region;


public interface IRegionService extends IService<Region> {

    List<Region> selectRegionsByParentCode(String parentCode);
    String getNameByCode(String code);
}