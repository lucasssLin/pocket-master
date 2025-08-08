import type { GoodsItem } from "./global"
import type { AddressItem } from "./address"

// 商品数据
export type GoodsData = {
    productSku: null
    productSkuList: ProductSkuItem[]
    product: ProductItem
    skuPriceList: any[] // 假设为空数组，可按需调整
    sliderUrlList: string[]
    detailsImageUrlList: string[]
    specValueList: SpecValueListItem[]
    skuStockVo: null
    skuStockVoList: any[] // 假设为空数组，可按需调整
    skuSpecValueMap: Record<string, number>
    /** 用户地址列表[ 地址信息 ] */
    userAddresses: AddressItem[]
    /** 同类商品[ 商品信息 ] */
    similarProducts: RelevantVo[]
    properties: { name: string; value: string }[];
}

// 商品 SKU 信息
export type ProductSkuItem = {
    id: number
    createBy: null
    createTime: string
    updateBy: null
    updateTime: string
    remark: null
    delFlag: string
    skuCode: string
    skuName: null
    productId: number
    thumbImg: string
    salePrice: number
    marketPrice: number
    costPrice: number
    skuSpec: string
    weight: number
    volume: number
    status: number
    discount: number
    stockNum: null | number
    saleNum: null | number
}

// 商品基本信息
export type ProductItem = {
    id: number
    createBy: null
    createTime: string
    updateBy: null
    updateTime: string
    remark: null
    delFlag: string
    params: Record<string, any>
    name: string
    brandId: null
    category1Id: number
    category2Id: number
    category3Id: null
    unitName: null
    sliderUrls: string
    specValue: null
    status: number
    auditStatus: number
    auditMessage: null
    brandName: null
    category1Name: null
    category2Name: null
    category3Name: null
    productSkuList: null
    detailsImageUrlList: null
    description: string
}

// 商品规格值列表项
export type SpecValueListItem = {
    id: number
    createBy: null
    createTime: null | string
    updateBy: null
    updateTime: null | string
    remark: null
    delFlag: null | string
    params: Record<string, any>
    productId: number
    specName: string
    values: any[] // 假设为空数组，可按需调整
}

// 原 GoodsResult 类型可根据实际需求调整或保留
/** 商品信息 */
export type GoodsResult = {
    /** id */
    id: number
    /** 商品名称 */
    name: string
    /** 商品描述 */
    desc: string
    /** 当前价格 */
    price: number
    /** 原价 */
    oldPrice: number
    /** 商品详情: 包含详情属性 + 详情图片 */
    details: Details
    /** 主图图片集合[ 主图图片链接 ] */
    mainPictures: string[]
    /** 同类商品[ 商品信息 ] */
    similarProducts: GoodsItem[]
    /** sku集合[ sku信息 ] */
    skus: ProductSkuItem[]
    /** 可选规格集合备注[ 可选规格信息 ] */
    specs: SpecValueListItem[]
    /** 用户地址列表[ 地址信息 ] */
    userAddresses: AddressItem[]
}

/** 商品详情: 包含详情属性 + 详情图片 */
export type Details = {
    /** 商品属性集合[ 属性信息 ] */
    properties: DetailsPropertyItem[]
    /** 商品详情图片集合[ 图片链接 ] */
    pictures: string[]
}

/** 属性信息 */
export type DetailsPropertyItem = {
    /** 属性名称 */
    name: string
    /** 属性值 */
    value: string
}

// 原 SkuItem 类型可根据实际需求调整或保留
/** sku信息 */
export type SkuItem = {
    /** id */
    id: string
    /** 库存 */
    inventory: number
    /** 原价 */
    oldPrice: number
    /** sku图片 */
    picture: string
    /** 当前价格 */
    price: number
    /** sku编码 */
    skuCode: string
    /** 规格集合[ 规格信息 ] */
    specs: SkuSpecItem[]
}

/** 规格信息 */
export type SkuSpecItem = {
    /** 规格名称 */
    name: string
    /** 可选值名称 */
    valueName: string
}

/** 可选规格信息 */
export type SpecItem = {
    /** 规格名称 */
    name: string
    /** 可选值集合[ 可选值信息 ] */
    values: SpecValueItem[]
}

/** 可选值信息 */
export type SpecValueItem = {
    /** 是否可售 */
    available: boolean
    /** 可选值备注 */
    desc: string
    /** 可选值名称 */
    name: string
    /** 可选值图片链接 */
    picture: string
}

export type RelevantVo = {
    spuId: number; // 对应 Long 类型，使用 number 表示
    picture: string;
    name: string;
    price: number; // 对应 BigDecimal 类型，使用 number 表示
    desc: string;
    discount: number; // 对应 BigDecimal 类型，使用 number 表示
};


// /** 商品信息 */
// export type GoodsResult = {
//     /** id */
//     id: string
//     /** 商品名称 */
//     name: string
//     /** 商品描述 */
//     desc: string
//     /** 当前价格 */
//     price: number
//     /** 原价 */
//     oldPrice: number
//     /** 商品详情: 包含详情属性 + 详情图片 */
//     details: Details
//     /** 主图图片集合[ 主图图片链接 ] */
//     mainPictures: string[]
//     /** 同类商品[ 商品信息 ] */
//     similarProducts: GoodsItem[]
//     /** sku集合[ sku信息 ] */
//     skus: SkuItem[]
//     /** 可选规格集合备注[ 可选规格信息 ] */
//     specs: SpecItem[]
//     /** 用户地址列表[ 地址信息 ] */
//     userAddresses: AddressItem[]
// }

// /** 商品详情: 包含详情属性 + 详情图片 */
// export type Details = {
//     /** 商品属性集合[ 属性信息 ] */
//     properties: DetailsPropertyItem[]
//     /** 商品详情图片集合[ 图片链接 ] */
//     pictures: string[]
// }

// /** 属性信息 */
// export type DetailsPropertyItem = {
//     /** 属性名称 */
//     name: string
//     /** 属性值 */
//     value: string
// }

// /** sku信息 */
// export type SkuItem = {
//     /** id */
//     id: string
//     /** 库存 */
//     inventory: number
//     /** 原价 */
//     oldPrice: number
//     /** sku图片 */
//     picture: string
//     /** 当前价格 */
//     price: number
//     /** sku编码 */
//     skuCode: string
//     /** 规格集合[ 规格信息 ] */
//     specs: SkuSpecItem[]
// }

// /** 规格信息 */
// export type SkuSpecItem = {
//     /** 规格名称 */
//     name: string
//     /** 可选值名称 */
//     valueName: string
// }

// /** 可选规格信息 */
// export type SpecItem = {
//     /** 规格名称 */
//     name: string
//     /** 可选值集合[ 可选值信息 ] */
//     values: SpecValueItem[]
// }

// /** 可选值信息 */
// export type SpecValueItem = {
//     /** 是否可售 */
//     available: boolean
//     /** 可选值备注 */
//     desc: string
//     /** 可选值名称 */
//     name: string
//     /** 可选值图片链接 */
//     picture: string
// }

