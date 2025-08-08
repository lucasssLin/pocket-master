package com.ruoyi.channel.controller;

import com.github.pagehelper.PageHelper;
import com.ruoyi.channel.service.IListService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.product.api.domain.SkuQuery;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "Product List API Management")
@RestController
@RequestMapping("/list")
public class ListController extends BaseController {

    @Autowired
    private IListService listService;

    @GetMapping("/skuList/{pageNum}/{pageSize}")
    public TableDataInfo skuList(@Parameter(name = "pageNum", description = "pageNum", required = true)
                                 @PathVariable Integer pageNum,

                                 @Parameter(name = "pageSize", description = "pageSize", required = true)
                                 @PathVariable Integer pageSize,

                                 @Parameter(name = "productQuery", description = "productQuery", required = false)
                                 SkuQuery skuQuery) {
        return listService.selectProductSkuList(pageNum, pageSize, skuQuery);
    }

    @GetMapping("/spuList/{pageNum}/{pageSize}")
    public R<TableDataInfo> spuList(@Parameter(name = "pageNum", description = "pageNum", required = true)
                                 @PathVariable Integer pageNum,

                                 @Parameter(name = "pageSize", description = "pageSize", required = true)
                                 @PathVariable Integer pageSize,

                                 @Parameter(name = "productQuery", description = "productQuery", required = false)
                                 SkuQuery skuQuery) {
        return R.ok(listService.selectProductSpuList(pageNum, pageSize, skuQuery));

    }
}
