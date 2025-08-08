import request from '@/utils/request'

// 查询地区信息列表
export function listRegion(query) {
  return request({
    url: '/user/region/list',
    method: 'get',
    params: query
  })
}

// 查询地区信息详细
export function getRegion(id) {
  return request({
    url: '/user/region/' + id,
    method: 'get'
  })
}

// 新增地区信息
export function addRegion(data) {
  return request({
    url: '/user/region',
    method: 'post',
    data: data
  })
}

// 修改地区信息
export function updateRegion(data) {
  return request({
    url: '/user/region',
    method: 'put',
    data: data
  })
}

// 删除地区信息
export function delRegion(id) {
  return request({
    url: '/user/region/' + id,
    method: 'delete'
  })
}
