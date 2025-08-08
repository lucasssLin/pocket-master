import type { PocketCustomerRecInstance } from '@/types/component';

import { ref } from 'vue'

/**
 * 猜你喜欢组合式函数
 */
export const customerRecList = () => {
    //猜你喜欢组件实例
    const guessRef = ref<PocketCustomerRecInstance>()

    // 滚动到底部加载更多
    const onScrollToLower = () => {
        guessRef.value?.getHomeCustomerRecData()
    }

    // 返回 ref 和事件处理函数
    return { guessRef, onScrollToLower }
}