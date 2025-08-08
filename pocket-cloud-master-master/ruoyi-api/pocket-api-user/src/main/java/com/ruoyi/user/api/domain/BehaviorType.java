package com.ruoyi.user.api.domain;


import java.util.Arrays;

public enum BehaviorType {
    VIEW(1, "浏览"),
    CART(2, "加入购物车"),
    FAVORITE(3, "收藏"),
    PURCHASE(4, "购买");
    
    private final int weight;
    private final String description;
    
    BehaviorType(int weight, String description) {
        this.weight = weight;
        this.description = description;
    }

    public int getWeight() {
        return weight;
    }
    
    public String getDescription() {
        return description;
    }

}