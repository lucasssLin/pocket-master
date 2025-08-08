package com.ruoyi.user.controller;


import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.user.domain.Region;
import com.ruoyi.user.service.IRegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/region")
public class RegionController extends BaseController {

    @Autowired
    private IRegionService regionService;

    @GetMapping("/treeSelect/{parentCode}")
    public AjaxResult treeSelect(@PathVariable String parentCode) {
        List<Region> regions = regionService.selectRegionsByParentCode(parentCode);
        return AjaxResult.success(regions);
    }
}
