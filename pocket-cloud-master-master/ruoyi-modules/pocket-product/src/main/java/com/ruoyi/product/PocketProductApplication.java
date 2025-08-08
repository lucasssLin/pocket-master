package com.ruoyi.product;
import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.ruoyi.product.api.domain.ProductSku;
import com.ruoyi.product.mapper.ProductSkuMapper;
import org.redisson.api.RBloomFilter;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;


@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication
public class PocketProductApplication implements CommandLineRunner {
    public static void main(String[] args)
    {
        SpringApplication.run(PocketProductApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  系统模块启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");

    }

    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private ProductSkuMapper productSkuMapper;


    @Override
    public void run(String... args) throws Exception {
        //初始化布隆过滤器
        RBloomFilter<Object> bloomFilter = redissonClient.getBloomFilter("sku:bloom:filter");
        //设置数据规模 误判率 预计统计元素数量为100000，期望误差率为0.01
        bloomFilter.tryInit(100000, 0.01);

//        List<ProductSku> productSkuList = productSkuMapper.selectList(null);
//
//        productSkuList.forEach(productSku -> bloomFilter.add(productSku.getId()));
    }
}
