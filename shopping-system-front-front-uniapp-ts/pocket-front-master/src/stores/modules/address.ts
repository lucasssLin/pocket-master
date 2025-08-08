import type { AddressItem } from "@/types/address";
import { defineStore } from "pinia";
import { ref } from "vue";


export const useAddressStore = defineStore('address', () => {
    const selectedAddress = ref<AddressItem | undefined>()
    const changeSelectedAddress = (value: AddressItem) => {
        selectedAddress.value = value
    }
    // 添加清除 selectedAddress 的方法
    const clearSelectedAddress = () => {
        selectedAddress.value = undefined;
    };

    return {
        selectedAddress,
        changeSelectedAddress,
        clearSelectedAddress
    }
})