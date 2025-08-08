package com.ruoyi.channel.service;

import com.ruoyi.channel.domain.ItemVo;
import com.ruoyi.channel.domain.RelevantVo;

import java.util.List;

public interface IItemService {
    ItemVo item(Long skuId);
    ItemVo selectGoodsBySpuId(Long spuId);

    List<RelevantVo> selectRelevantGoodsBySpuId(Long spuId, int limit);


}
