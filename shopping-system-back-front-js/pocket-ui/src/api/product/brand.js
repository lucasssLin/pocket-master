import request from '@/utils/request'

//分页请求
export const listBrand=(query)=>{
    return request({
        url: '/product/brand/list',
        method: 'get',
        params: query
    })
}

export const addBrand=(brand)=>{
    return request({
        url: '/product/brand',
        method: 'post',
        data: brand
    })
}


export const getBrand=(id)=>{
    return request({
        url: `/product/brand/${id}`,
        method: 'get',
    })
}

export const updateBrand=(brand)=>{
    return request({
        url: '/product/brand',
        method: 'put',
        data: brand
    })
}

// 删除品牌
export function delBrand(id) {
    return request({
      url: `/product/brand/${id}`,
      method: 'delete',
    })
}

export const getBrandAll=()=>{
    return request({
        url: `/product/brand/list`,
        method: 'get',
    })
}

export const getBrandAllBrand=()=>{
    return request({
        url: `/product/brand/getBrandAll`,
        method: 'get',
    })
}