// 浏览历史单项数据类型
export type BrowseHistoryItem = {
    id: number;
    createBy: string;
    createTime: string;
    updateBy: string;
    updateTime: string;
    remark: string;
    delFlag: number;
    userId: number;
    spuId: number;
    productName: string;
    thumbImg: string;
    salePrice: number;
};