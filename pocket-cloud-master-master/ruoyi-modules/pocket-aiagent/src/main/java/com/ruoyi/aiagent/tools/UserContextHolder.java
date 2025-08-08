package com.ruoyi.aiagent.tools;

/**
 * 用户上下文持有者 - 使用ThreadLocal传递用户ID到函数调用中
 */
public class UserContextHolder {
    
    private static final ThreadLocal<Long> userIdHolder = new ThreadLocal<>();
    
    /**
     * 设置当前线程的用户ID
     */
    public static void setUserId(Long userId) {
        userIdHolder.set(userId);
    }
    
    /**
     * 获取当前线程的用户ID
     */
    public static Long getUserId() {
        return userIdHolder.get();
    }
    
    /**
     * 清除当前线程的用户ID
     */
    public static void clear() {
        userIdHolder.remove();
    }
}