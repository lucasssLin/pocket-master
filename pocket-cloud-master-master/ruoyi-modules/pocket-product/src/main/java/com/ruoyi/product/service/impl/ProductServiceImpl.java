package com.ruoyi.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.redis.cache.PocketCache;
import com.ruoyi.order.api.domain.OrderDetailVo;
import com.ruoyi.product.api.domain.*;
import com.ruoyi.product.api.domain.vo.ProductVo;
import com.ruoyi.product.api.domain.vo.SkuLockVo;
import com.ruoyi.product.api.domain.RecommendType;
import com.ruoyi.product.domain.SkuStock;
import com.ruoyi.product.mapper.*;
import com.ruoyi.product.service.IProductService;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RBloomFilter;
import org.redisson.api.RedissonClient;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements IProductService {

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductSkuMapper productSkuMapper;
    @Autowired
    private SkuStockMapper skuStockMapper;
    @Autowired
    private ProductDetailsMapper productDetailsMapper;
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private ProductSpecsMapper productSpecsMapper;
//    @Autowired
//    private RabbitService rabbitService;
    @Autowired
    private ProductSpecValuesMapper productSpecValuesMapper;
    @Autowired
    private RecommendTypeMapper recommendTypeMapper;


    @Override
    public List<Product> selectPageList(Product product) {
        return productMapper.selectPageList(product);
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insertProduct(Product product) {
        //spu
        productMapper.insert(product);

        //sku
        List<ProductSku> productSkuList = product.getProductSkuList();

        for (int i = 0; i < productSkuList.size(); i++) {
            ProductSku productSku = productSkuList.get(i);
            productSku.setSkuCode(product.getId() + "_" + i);
            productSku.setSkuName(product.getName() + " " + productSku.getSkuSpec());
            productSku.setProductId(product.getId());

            productSkuMapper.insert(productSku);

            //stock
            SkuStock skuStock = new SkuStock();
            skuStock.setSkuId(productSku.getId());
            skuStock.setStatus(1);
            skuStock.setAvailableNum(productSku.getStockNum());
            skuStock.setTotalNum(productSku.getStockNum());
            skuStock.setSaleNum(0);
            skuStock.setLockNum(0);

            skuStockMapper.insert(skuStock);
        }

        //details
        ProductDetails productDetails = new ProductDetails();
        productDetails.setProductId(product.getId());
        String imageUrl = String.join(",", product.getProductDetails().getImageUrls());
        productDetails.setImageUrls(imageUrl);

        productDetailsMapper.insert(productDetails);

        return product.getId().intValue();
    }

    //获取商品详细信息
    @Override
    public Product selectProductInfo(Long id) {
        //spu商品信息
        Product product = productMapper.selectById(id);

        //sku列表
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, product.getId()));

        //查询sku库存
        List<Long> skuIds = productSkuList.stream().map(ProductSku::getId).collect(Collectors.toList());

        List<SkuStock> skuStockList = skuStockMapper.selectList(new LambdaQueryWrapper<SkuStock>().in(SkuStock::getSkuId, skuIds));

        Map<Long, Integer> skuIdToStockNumMap =  skuStockList.stream().collect(Collectors.toMap(SkuStock::getSkuId, SkuStock::getTotalNum));

        productSkuList.forEach(productSku ->{
            productSku.setStockNum(skuIdToStockNumMap.get(productSku.getId()));
        });

        product.setProductSkuList(productSkuList);

        //商品详情
        ProductDetails productDetails = productDetailsMapper.selectOne(new LambdaQueryWrapper<ProductDetails>().eq(ProductDetails::getProductId,product.getId()));

        List<String> urlList =Arrays.asList(productDetails.getImageUrls().split(","));

        //product.setDetailsImageUrlList(urlList);

        return product;
    }

    //修改商品
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateProduct(Product product) {
        //spu
        productMapper.updateById(product);

        //sku
        List<ProductSku> productSkuList = product.getProductSkuList();

        productSkuList.forEach(productSku -> {
            //修改商品SKU信息
            productSkuMapper.updateById(productSku);

            //修改商品库存
            SkuStock skuStock = skuStockMapper.selectOne(new LambdaQueryWrapper<SkuStock>().eq(SkuStock::getSkuId, productSku.getId()));

            skuStock.setTotalNum(productSku.getStockNum());

            int availableStockNum = skuStock.getTotalNum() - skuStock.getLockNum();

            skuStock.setAvailableNum(availableStockNum);

            skuStockMapper.updateById(skuStock);

        });

        //修改商品详细信息
        ProductDetails productDetails = productDetailsMapper.selectOne(new LambdaQueryWrapper<ProductDetails>().eq(ProductDetails::getProductId, product.getId()));

        productDetails.setImageUrls(String.join(",", product.getProductDetails().getImageUrls()));

        productDetailsMapper.updateById(productDetails);

        return 1;
    }

    //删除商品
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteProductsByProductIds(Long[] ids) {
        //spu
        productMapper.deleteBatchIds(Arrays.asList(ids));

        //sku
        //获取sku列表
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().in(ProductSku::getProductId, ids));
        //获取skuID列表
        List<Long> skuIds = productSkuList.stream().map(ProductSku::getId).collect(Collectors.toList());

        productSkuMapper.delete(new LambdaQueryWrapper<ProductSku>().in(ProductSku::getProductId,ids));

        skuStockMapper.delete(new LambdaQueryWrapper<SkuStock>().in(SkuStock::getSkuId,skuIds));

        //details
        productDetailsMapper.delete(new LambdaQueryWrapper<ProductDetails>().in(ProductDetails::getProductId,ids));

        return 1;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateAuditStatus(Long id, int auditStatus) {

        Product product = productMapper.selectById(id);

        if(auditStatus == 1){
            product.setAuditStatus(1);
            product.setAuditMessage("Audit Pass");
        }else{
            product.setAuditStatus(-1);
            product.setAuditMessage("Audit Failed");
        }
        productMapper.updateById(product);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateStatus(Long id, Integer status) {
        Product product = productMapper.selectById(id);

        if(status == 1){
            product.setStatus(1);

            //sku加入布隆过滤器
            RBloomFilter<Object> bloomFilter = redissonClient.getBloomFilter("sku:bloom:filter");

            List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, id));

            productSkuList.forEach(productSku -> {
                bloomFilter.add(productSku.getId());
            });

        }else {
            product.setStatus(-1);
        }
        productMapper.updateById(product);
    }

    @Override
    public List<ProductSku> getTopSale() {
        List<ProductSku> skuList = productSkuMapper.selectTopSale();
        return skuList;
    }


    //条件搜索商品sku列表
    @Override
    public List<ProductSku> selectSkuList(SkuQuery skuQuery) {
        return productSkuMapper.selectSkuList(skuQuery);

    }

    @Override
    public List<ProductVo> selectSpuList(SkuQuery skuQuery) {

        List<ProductVo> productVoList = productMapper.selectSpuList(skuQuery);
        return productVoList;
    }


    //=======================================
    @PocketCache(prefix = "productSKU:")
    @Override
    public ProductSku getProductSku(Long skuId) {
        return productSkuMapper.selectById(skuId);
    }

    @PocketCache(prefix = "product:")
    @Override
    public ProductVo getProductByProductId(Long id) {
        Product product = productMapper.selectById(id);
        ProductVo productVo = new ProductVo();
        productVo.setProduct(product);
        List<ProductSpecs> productSpecsList = productSpecsMapper.selectProductSpecList(id);
        productVo.setSpecsList(productSpecsList);
        return productVo;
    }

    @PocketCache(prefix = "skuPrice:")
    @Override
    public SkuPrice getSkuPrice(Long skuId) {
        ProductSku productSku = productSkuMapper.selectOne(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getId, skuId).select(ProductSku::getSalePrice, ProductSku::getMarketPrice));
        SkuPrice skuPrice = new SkuPrice();
        BeanUtils.copyProperties(productSku, skuPrice);
        return skuPrice;
    }

    @PocketCache(prefix = "productDetails:")
    @Override
    public ProductDetails getProductDetails(Long id) {
        return productDetailsMapper.selectOne(new LambdaQueryWrapper<ProductDetails>().eq(ProductDetails::getProductId, id));
    }

    @PocketCache(prefix = "skuSpecValue:")
    @Override
    public Map<String, Long> getSkuSpecValue(Long id) {
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, id).select(ProductSku::getId, ProductSku::getSkuSpec));
        Map<String,Long> skuSpecValueMap = new HashMap<>();
        productSkuList.forEach(item -> {
            skuSpecValueMap.put(item.getSkuSpec(), item.getId());
        });
        return skuSpecValueMap;
    }


    @PocketCache(prefix = "skuStock:")
    @Override
    public SkuStockVo getSkuStock(Long skuId) {
        SkuStock skuStock = skuStockMapper.selectOne(new LambdaQueryWrapper<SkuStock>().eq(SkuStock::getSkuId, skuId));
        SkuStockVo skuStockVo = new SkuStockVo();
        BeanUtils.copyProperties(skuStock, skuStockVo);
        return skuStockVo;
    }

    @PocketCache(prefix = "skuStock:")
    @Override
    public List<SkuStockVo> getSkuStockListBySpuId(List<Long> skuIdList) {
        List<SkuStockVo> skuStockVoList = new ArrayList<>();
        for (Long skuId : skuIdList) {
            SkuStock skuStock = skuStockMapper.selectOne(new LambdaQueryWrapper<SkuStock>().eq(SkuStock::getSkuId, skuId));
            SkuStockVo skuStockVo = new SkuStockVo();
            BeanUtils.copyProperties(skuStock, skuStockVo);
            skuStockVoList.add(skuStockVo);
        }
        return skuStockVoList;
    }




    //============================================
//    //获取商品详情
//
//    //获取商品sku信息(分布式锁)
//    @Override
//    public ProductSku getProductSku(Long skuId) {
//        try {
//            //1.优先从缓存中获取数据
//            //1.1 构建业务数据Key 形式：前缀+业务唯一标识
//            String dataKey = "product:sku:" + skuId;
//            //1.2 查询Redis获取业务数据
//            ProductSku productSku = (ProductSku) redisTemplate.opsForValue().get(dataKey);
//            if (productSku != null) {
//                log.info("命中缓存，直接返回，线程ID：{}，线程名称：{}", Thread.currentThread().getId(), Thread.currentThread().getName());
//                return productSku;
//            }
//
//            //2.尝试获取分布式锁（set k v ex nx可能获取锁失败）
//            //2.1 构建锁key
//            String lockKey = "product:sku:" + skuId;
//            //2.2 采用UUID作为线程标识
//            String lockVal = UUID.randomUUID().toString().replaceAll("-","");
//
//            //2.3 利用Redis提供set nx ex 获取分布式锁
//            Boolean flag = redisTemplate.opsForValue().setIfAbsent(lockKey, lockVal, 5, TimeUnit.SECONDS);
//
//            if (flag) {
//                //3.获取锁成功执行业务,将查询业务数据放入缓存Redis
//                log.info("获取锁成功：{}，线程名称：{}", Thread.currentThread().getId(), Thread.currentThread().getName());
//
//                try {
//                    productSku = this.getProductSkuFromDB(skuId);
//                    long ttl = productSku == null ? 1 * 60 : 10 * 60;
//                    redisTemplate.opsForValue().set(dataKey, productSku, ttl, TimeUnit.SECONDS);
//                    return productSku;
//                } finally {
//                    //4.业务执行完毕释放锁
//                    String scriptText = "if redis.call(\"get\",KEYS[1])== ARGV[1]\n" +
//                            "then\n" +
//                            "   return redis.call(\"del\", KEYS[1])\n" +
//                            "else\n" +
//                            "   return 0\n" +
//                            "end";
//
//                    DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
//                    redisScript.setScriptText(scriptText);
//                    redisScript.setResultType(Long.class);
//                    redisTemplate.execute(redisScript, Arrays.asList(lockKey), lockVal);
//                }
//            } else {
//                //5.获取锁失败则自旋（业务要求必须执行）
//                try {
//                    Thread.sleep(200);
//                } catch (InterruptedException e) {
//                    throw new RuntimeException(e);
//                }
//                log.error("获取锁失败，自旋：{}，线程名称：{}", Thread.currentThread().getId(), Thread.currentThread().getName());
//
//                return this.getProductSku(skuId);
//            }
//        } catch (Exception e) {
//            //兜底处理方案：Redis服务有问题，将业务数据获取自动从数据库获取
//            log.error("[商品服务]查询商品信息异常：{}", e);
//            return this.getProductSkuFromDB(skuId);
//        }
//    }
//        public ProductSku getProductSkuFromDB(Long skuId){
//            return productSkuMapper.selectById(skuId);
//        }
//
//    //获取商品信息
//    @Override
//    @SpzxCache(prefix = "product:")
//    public Product getProductByProductId(Long id) {
//        Product product = productMapper.selectById(id);
//        return product;
//    }
//    //获取商品sku最新价格信息
//    @Override
//    @SpzxCache(prefix = "skuPrice:")
//    public SkuPrice getSkuPrice(Long skuId) {
//        ProductSku productSku = productSkuMapper.selectOne(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getId, skuId)
//                .select(ProductSku::getSalePrice, ProductSku::getMarketPrice));
//
//        SkuPrice skuPrice = new SkuPrice();
//        BeanUtils.copyProperties(productSku, skuPrice);
//        return skuPrice;
//    }
//    //获取商品详细信息(海报)
//    @Override
//    @SpzxCache(prefix = "productDetails:")
//    public ProductDetails getProductDetails(Long id) {
//        ProductDetails productDetails = productDetailsMapper.selectOne(new LambdaQueryWrapper<ProductDetails>().eq(ProductDetails::getProductId, id));
//        return productDetails;
//    }
//    //获取商品sku规格详细信息
//    @Override
//    @SpzxCache(prefix = "skuSpecValue:")
//    public Map<String, Long> getSkuSpecValue(Long id) {
//
//        HashMap<String, Long> skuSpecValueMap = new HashMap<>();
//
//        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, id).select(ProductSku::getSkuSpec, ProductSku::getId));
//
//        productSkuList.forEach(productSku -> {
//            skuSpecValueMap.put(productSku.getSkuSpec(), productSku.getId());
//        });
//        return skuSpecValueMap;
//    }
//    //获取商品sku库存信息
//    @Override
//    @SpzxCache(prefix = "skuStock:")
//    public SkuStockVo getSkuStock(Long skuId) {
//        SkuStock skuStock = skuStockMapper.selectOne(new LambdaQueryWrapper<SkuStock>().eq(SkuStock::getSkuId, skuId));
//
//        SkuStockVo skuStockVo = new SkuStockVo();
//        BeanUtils.copyProperties(skuStock,skuStockVo);
//
//        return skuStockVo;
//    }
//

    //Inquiry cart list current price
    @Override
    public List<SkuPrice> getSkuPriceList(List<Long> skuIdList) {
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().in(ProductSku::getId, skuIdList));

        List<SkuPrice> skuPriceList = productSkuList.stream().map(productSku -> {
            SkuPrice skuPrice = new SkuPrice();
            skuPrice.setSkuId(productSku.getId());
            skuPrice.setSalePrice(productSku.getSalePrice());
            skuPrice.setMarketPrice(productSku.getMarketPrice());
            return skuPrice;
        }).collect(Collectors.toList());

        return skuPriceList;
    }




    @Transactional(rollbackFor = {Exception.class})
    //下单检查与锁定库存
    @Override
    public String checkAndLock(String orderNo, List<SkuLockVo> skuLockVoList) {

        //用于分布式锁的键，确保同一订单号的库存检查和锁定操作不会被重复执行。
        String checkAndLockKey = "sku:checkAndLock:" + orderNo;
        String deleteCheckAndLockValue = UUID.randomUUID().toString();

        String dataKey = "sku:lock:data:" + orderNo;

        try {
            //防止重复提交，保证库存检查和锁定操作不会被重复执行
            Boolean flag = redisTemplate.opsForValue().setIfAbsent(checkAndLockKey, deleteCheckAndLockValue, 30, TimeUnit.MINUTES);
            if (!flag) {
                //如果存在，则表示已执行过库存锁定
                if (redisTemplate.hasKey(dataKey)) {
                    return "";
                } else {
                    return "Repeatedly submit";
                }
            }

            // 遍历所有商品，验库存并锁库存，要具备原子性
            for (SkuLockVo skuLockVo : skuLockVoList){
                // 验库存：查询，返回的是满足要求的库存列表
                SkuStock skuStock = skuStockMapper.check(skuLockVo.getSkuId(), skuLockVo.getSkuNum());
                // 如果没有一个商品满足要求，这里就验库存失败
                if (skuStock == null) {
                    skuLockVo.setIsHaveStock(false);
                } else {
                    skuLockVo.setIsHaveStock(true);
                }
            };

            // 只要有一个商品锁定失败，所有锁定成功的商品要解锁库存
            if (skuLockVoList.stream().anyMatch(skuLockVo -> !skuLockVo.getIsHaveStock())) {
                List<SkuLockVo> noStockskuLockVoList = skuLockVoList.stream().filter(skuLockVo -> !skuLockVo.getIsHaveStock()).collect(Collectors.toList());
                StringBuffer result = new StringBuffer();
                for (SkuLockVo noStockskuLockVo : noStockskuLockVoList) {
                    this.redisTemplate.delete(checkAndLockKey);
                    result.append("Product" + noStockskuLockVo.getSkuId() + "Inventory not enough;");
                }
                //锁定失败，解除
                this.redisTemplate.delete(checkAndLockKey);
                return result.toString();
            } else {
                //所有下单商品都有库存
                //锁定库存
                for (SkuLockVo skuLockVo : skuLockVoList) {
                    int row = skuStockMapper.lock(skuLockVo.getSkuId(), skuLockVo.getSkuNum());
                    if (row == 0) {
                        this.redisTemplate.delete(checkAndLockKey);
                        throw new ServiceException("Lock inventory failed");
                    }
                }
            }
            // 如果所有商品都锁定成功的情况下，需要缓存锁定信息到redis。以方便将来解锁库存 或者 减库存
            redisTemplate.opsForValue().set(dataKey, skuLockVoList, 30, TimeUnit.MINUTES);
            boolean keyExists = redisTemplate.hasKey(dataKey);
            if (keyExists) {
                System.out.println("Key exists in Redis.");
            } else {
                System.out.println("Key does not exist in Redis.");
            }

        }finally {
            // 释放分布式锁
            String delLua = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
            DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
            redisScript.setScriptText(delLua);
            redisScript.setResultType(Long.class);
            Long delFlag = (Long)redisTemplate.execute(redisScript, Arrays.asList(checkAndLockKey), deleteCheckAndLockValue);
            Assert.isTrue(delFlag!=0L,"The order has been submitted or an exception has occurred");
        }
        return "";
    }



    @Transactional(rollbackFor = {Exception.class})
    @Override
    public void unlock(String orderNo) {
        String securityUnLockKey = "sku:unlock:" + orderNo;
        String securityUnLockValue = UUID.randomUUID().toString();

        String dataKey = "sku:lock:data:" + orderNo;

        Boolean flag = redisTemplate.opsForValue().setIfAbsent(securityUnLockKey, securityUnLockValue, 30, TimeUnit.SECONDS);
        if(!flag){
            log.info("Lock already exists for order: {}. Another process is handling the unlock operation.", orderNo);
            return;
        }
        try {
            // 获取锁定库存的缓存信息
            Object redisData = redisTemplate.opsForValue().get(dataKey);
            if (redisData == null) {
                log.info("No locked inventory data found for order: {}. The data may have been already processed.", orderNo);
                return;
            }
            List<SkuLockVo> skuLockVoList;

            try {
                skuLockVoList = (List<SkuLockVo>) redisData;
            } catch (ClassCastException e) {
                log.error("Failed to cast Redis data to List<SkuLockVo> for order: {}", orderNo, e);
                throw new ServiceException("Data format error when unlocking inventory");
            }

            if (CollectionUtils.isEmpty(skuLockVoList)) {
                log.info("Empty sku lock list for order: {}. Nothing to unlock.", orderNo);
                return;
            }


            if(CollectionUtils.isEmpty(skuLockVoList)){
                return;  // 如果分布式锁已存在，说明当前订单的解锁操作已被执行过，直接返回
            }

            skuLockVoList.forEach(skuLockVo -> {
                log.info("Attempting to unlock SKU ID: {}, Quantity: {}", skuLockVo.getSkuId(), skuLockVo.getSkuNum());

                int maxRetries = 3;
                int retries = 0;
                boolean unlockFlag = false;
                while(retries < maxRetries){
                    try{
                        int row = skuStockMapper.unlock(skuLockVo.getSkuId(), skuLockVo.getSkuNum());
                        if(row == 1){
                            log.info("Successfully unlocked SKU ID: {}, Quantity: {}", skuLockVo.getSkuId(), skuLockVo.getSkuNum());
                            unlockFlag = true;
                            break;
                        }else {
                            log.warn("Failed to unlock SKU ID: {}, affected rows: {}", skuLockVo.getSkuId(), row);
                            retries++;
                        }
                    }catch (Exception e){
                        retries++;
                        log.error("unlock failed，retries {} times: {}", retries, e.getMessage(), e);
                        try {
                            Thread.sleep(500);
                        } catch (InterruptedException exception) {
                            throw new RuntimeException(exception);
                        }
                    }
                }
                if(unlockFlag == false){
                     // 解锁失败时删除分布式锁
                    throw new ServiceException("Unlock inventory failed");
                }
            });
            // 解锁库存之后，删除锁定库存的缓存。以防止重复解锁库存
            redisTemplate.delete(dataKey);
            log.info("Successfully unlocked all inventory for order: {}", orderNo);

        }finally {
            String delLua = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
            DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
            redisScript.setScriptText(delLua);
            redisScript.setResultType(Long.class);

            try {
                Long delFlag = (Long) redisTemplate.execute(redisScript, Arrays.asList(securityUnLockKey), securityUnLockValue);
                if (delFlag == 0L) {
                    log.warn("Failed to release lock or lock already released for order: {}", orderNo);
                }
            } catch (Exception e) {
                log.error("Failed to execute Lua script to release lock for order: {}", orderNo, e);
            }
        }
    }



    @Transactional(rollbackFor = {Exception.class})
    @Override
    public void minusStock(String orderNo) {
        String securityMinusStockKey = "sku:minusStock:" + orderNo;
        String securityMinusStockValue = UUID.randomUUID().toString();

        String dataKey = "sku:lock:data:" + orderNo;
        //业务去重，防止重复消费
        Boolean flag = redisTemplate.opsForValue().setIfAbsent(securityMinusStockKey, securityMinusStockValue, 30, TimeUnit.SECONDS);

        if(!flag){
            return;
        }

        try {
            // 获取锁定库存的缓存信息
            List<SkuLockVo> skuLockVoList =(List<SkuLockVo>) redisTemplate.opsForValue().get(dataKey);
            if(CollectionUtils.isEmpty(skuLockVoList)){
                return;
            }
            // 减库存
            skuLockVoList.forEach(skuLockVo -> {

                int row = skuStockMapper.minusStock(skuLockVo.getSkuId(), skuLockVo.getSkuNum());
                if(row == 0){
                    //解除去重
                    redisTemplate.delete(securityMinusStockKey);
                    throw new ServiceException("Minus stock failed");
                }
            });
            //若该缓存已被删除，后续请求在调用minusStock方法时，尝试从缓存中获取锁定库存信息就会得到null，然后直接返回，不会执行减库存操作
            redisTemplate.delete(dataKey);

        }finally {
            String delLua = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
            DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
            redisScript.setScriptText(delLua);
            redisScript.setResultType(Long.class);
            Long delFlag = (Long)redisTemplate.execute(redisScript, Arrays.asList(securityMinusStockKey), securityMinusStockValue);
            Assert.isTrue(delFlag!=0L,"submited or an exception occurred");
        }
    }



    @Override
    public List<ProductSku> getProductSkuList(List<Long> skuIdList) {
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().in(ProductSku::getId, skuIdList));
        return productSkuList;
    }

    @PocketCache(prefix = "productSKUList:")
    @Override
    public List<ProductSku> getProductSkuListBySpuId(Long spuId) {
        List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, spuId));
        return productSkuList;
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public int newInsertProduct(Product product) {
        //spu
        productMapper.insert(product);

        //sku
        List<ProductSku> productSkuList = product.getProductSkuList();

        for (int i = 0; i < productSkuList.size(); i++) {
            ProductSku productSku = productSkuList.get(i);
            productSku.setSkuCode(product.getId() + "_" + i);
            productSku.setSkuName(product.getName() + " " + productSku.getSkuSpec());
            productSku.setProductId(product.getId());
            productSku.setDiscount(productSku.getMarketPrice().subtract(productSku.getSalePrice()));

            productSkuMapper.insert(productSku);

            //stock
            SkuStock skuStock = new SkuStock();
            skuStock.setSkuId(productSku.getId());
            skuStock.setStatus(1);
            skuStock.setAvailableNum(productSku.getStockNum());
            skuStock.setTotalNum(productSku.getStockNum());
            skuStock.setSaleNum(0);
            skuStock.setLockNum(0);

            skuStockMapper.insert(skuStock);
        }

        //details
        ProductDetails productDetails = new ProductDetails();
        productDetails.setProductId(product.getId());
        String imageUrl = String.join(",", product.getProductDetails().getImageUrls());
        productDetails.setImageUrls(imageUrl);
        String properties = product.getProductDetails().getProperties();
        productDetails.setProperties(properties);
        productDetailsMapper.insert(productDetails);

        //product spec
        List<ProductSpecs> specsList = product.getSpecsList();
        for (ProductSpecs specs : specsList) {
            specs.setProductId(product.getId());
            specs.setCategoryId(product.getCategory2Id());
            productSpecsMapper.insert(specs);

            List<ProductSpecValues> productSpecValuesList = specs.getValues();
            for (ProductSpecValues productSpecValues : productSpecValuesList) {
                productSpecValues.setSpecId(specs.getId());
                productSpecValues.setIsAvailable(true);
                for(ProductSku productSku : productSkuList){
                    if(productSku.getProductId().equals(specs.getProductId())){
                        productSpecValues.setPicture(productSku.getThumbImg());
                    }
                }
                productSpecValuesMapper.insert(productSpecValues);
            }
        }

        return product.getId().intValue();
    }

    @Override
    public List<Product> selectRelevantGoodsBySpuId(Long spuId) {
        List<Product> productList = productMapper.selectRelevantGoodsBySpuId(spuId);
        return productList;
    }

    @Override
    public List<Product> getProductListBySpuIdList(List<Long> spuIdList) {
        if (!spuIdList.isEmpty()) {
            List<Product> productList = new ArrayList<>();
            for (Long spuId : spuIdList) {
                Product product = productMapper.selectById(spuId);
                if (product != null) {
                    List<ProductSku> productSkuList = productSkuMapper.selectList(new LambdaQueryWrapper<ProductSku>().eq(ProductSku::getProductId, spuId));
                    product.setProductSkuList(productSkuList);
                    productList.add(product);
                }

            }
            return productList;
        }
        return null;
    }

    @Override
    public int updateProductPrice(Long skuId, Double salePrice) {
        return productSkuMapper.updateSalePrice(skuId,salePrice);
    }

    @Override
    public List<RecommendType> getHotRecommendType() {
        List<RecommendType> recommendTypes = recommendTypeMapper.selectList(null);
        return recommendTypes;
    }

    @Override
    public List<ProductVo> selectProductListPageBySpuIdList(List<Long> spuIdList) {
        List<ProductVo> productVoList = new ArrayList<>();
        List<Product> productList = this.getProductListBySpuIdList(spuIdList);
        for (Product product : productList) {
            ProductVo productVo = new ProductVo();
            productVo.setProduct(product);
            if (product.getProductSkuList() != null && !product.getProductSkuList().isEmpty()) {
                ProductSku lowestPriceSku = product.getProductSkuList().stream()
                        .min(Comparator.comparing(ProductSku::getSalePrice))
                        .orElse(null);

                if (lowestPriceSku != null) {
                    productVo.setPrice(lowestPriceSku.getSalePrice());
                }
                List<ProductSku> productSkuList = product.getProductSkuList();
                List<SkuStock> skuStocks = skuStockMapper.selectList(new LambdaQueryWrapper<SkuStock>().in(SkuStock::getSkuId, productSkuList.stream().map(ProductSku::getId).collect(Collectors.toList())));
                Integer totalSaleNum = skuStocks.stream()
                        .mapToInt(SkuStock::getSaleNum)
                        .sum();

                productVo.setOrderNum(totalSaleNum);
            }
            productVoList.add(productVo);
        }
        return productVoList;
    }


}
