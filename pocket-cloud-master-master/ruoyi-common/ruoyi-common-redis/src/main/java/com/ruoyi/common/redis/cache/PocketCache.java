package com.ruoyi.common.redis.cache;

import java.lang.annotation.*;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface PocketCache {
    String prefix() default "data:";

}
