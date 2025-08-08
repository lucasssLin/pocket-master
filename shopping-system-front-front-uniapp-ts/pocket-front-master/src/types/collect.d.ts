// 定义收藏项的类型
export type CollectedItem = {
    id: number;
    createBy: null | string;
    createTime: string;
    updateBy: null | string;
    updateTime: string;
    remark: null | string;
    delFlag: string;
    userId: number;
    spuId: number;
    isCollect: number;
    spuName: string;
    thumbImg: string;
    salePrice: number;
}