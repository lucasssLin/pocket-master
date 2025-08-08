package com.ruoyi.common.redis.cache;


import com.ruoyi.common.core.utils.uuid.UUID;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Aspect
@Component
public class PocketCacheAspect {

    @Autowired
    private RedisTemplate redisTemplate;

    @SneakyThrows
    @Around("@annotation(pocketCache)")
    public Object pocketCacheAspect(ProceedingJoinPoint pjp, PocketCache pocketCache){


        String prefix = pocketCache.prefix();
        String paramValue = "";
        Object[] args = pjp.getArgs();
        if(args != null && args.length > 0){
            paramValue = Arrays.asList(args).stream().map(arg -> arg.toString()).collect(Collectors.joining(":"));
        }
        String dataKey = prefix + paramValue;

        Integer retryCount = 0;
        Integer maxRetryCount = 100;

        Object resultObject = null;

        while(retryCount < maxRetryCount){
            resultObject = redisTemplate.opsForValue().get(dataKey);
            if (resultObject != null) {
                return resultObject;

            }else {
                //2.获取分布式锁
                //2.1 构建锁key
                String lockKey = dataKey + ":lock";
                //2.2 采用UUID作为线程标识
                String lockValue = UUID.randomUUID().toString().replaceAll("-", "");
                //2.3 利用Redis提供set nx ex 获取分布式锁
                Boolean flag = redisTemplate.opsForValue().setIfAbsent(lockKey, lockValue, 5, TimeUnit.SECONDS);
                if(flag){
                    //3.执行目标方法（查询数据库业务数据）将业务数据放入缓存
                    try{
                        //3.1 再次查询一次缓存:处于阻塞等待获取线程（终将获取锁成功）避免获取锁线程再次查库，这里再查一次缓存
                        resultObject = redisTemplate.opsForValue().get(dataKey);
                        if (resultObject != null) {
                            return resultObject;
                        }
                        //3.2 未命中缓存，执行查询数据库(目标方法)
                        resultObject = pjp.proceed();
                        //3.3 将查询数据库结果放入缓存
                        long ttl = resultObject == null ? 1 * 60 : 10 * 60;
                        redisTemplate.opsForValue().set(dataKey, resultObject, ttl, TimeUnit.SECONDS);
                        return resultObject;
                    }finally {
                        //4.业务执行完毕释放锁
                        String scriptText = "if redis.call(\"get\",KEYS[1]) == ARGV[1]\n" +
                                "then\n" +
                                "    return redis.call(\"del\",KEYS[1])\n" +
                                "else\n" +
                                "    return 0\n" +
                                "end";
                        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
                        redisScript.setResultType(Long.class);
                        redisScript.setScriptText(scriptText);
                        redisTemplate.execute(redisScript, Arrays.asList(lockKey), lockValue);
                    }
                }else {
                    waitFormRelease(100);
                    retryCount++;
                }
            }
        }
        return resultObject;
    }

    private void waitFormRelease(int time){
        try {
            Thread.sleep(time);
        }catch (InterruptedException e){
            Thread.currentThread().interrupt();
            throw new RuntimeException(e);
        }
    }


}
