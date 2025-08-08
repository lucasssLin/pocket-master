/**
 * declare module '@vue/runtime-core'
 *   现调整为
 * declare module 'vue'
 */
import 'vue'
import PocketSwiper from '@/components/PocketSwiper.vue'
import PocketCustomerRec from '@/components/PocketCustomerRec.vue'



declare module 'vue' {
  export interface GlobalComponents {
    PocketSwiper: typeof PocketSwiper
    PocketCustomerRec: typeof PocketCustomerRec
  }
}

// 组件实例类型
export type PocketCustomerRecInstance = InstanceType<typeof PocketCustomerRec>