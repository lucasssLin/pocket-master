import request from '@/utils/request'

// 获取分类下拉树列表 数据
export const getTreeSelect=(id)=>{
    return request({
        url: `/product/category/${id}`,
        method: "get"
    })
}





