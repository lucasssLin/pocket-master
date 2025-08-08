package com.ruoyi.order.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class DeadLetterMqConfig {

    //（1）创建死信队列
    //（2）创建交换机
    //（3）建立交换器与队列之间的绑定
    //（4）创建队列

    //当有消息发送到 exchange.dead 交换机，并且路由键为 routing.dead.1 时，消息会被路由到队列一。
    //如果队列一中的消息在10秒内没有被消费，消息会过期并成为死信。由于队列一配置了死信交换机和路由键，死信会被转发到 exchange.dead 交换机，并使用 routing.dead.2 作为路由键。
    //最终，这些死信会被路由到队列二，开发者可以在队列二上监听这些死信消息，进行相应的处理，例如记录日志、重试消费等。


    public static final String exchange_dead = "exchange.dead";
    public static final String routing_dead_1 = "routing.dead.1";
    public static final String routing_dead_2 = "routing.dead.2";
    public static final String queue_dead_1 = "queue.dead.1";
    public static final String queue_dead_2 = "queue.dead.2";


    // 定义交换机
    @Bean
    public DirectExchange exchange() {
        //exchange_dead：使用预定义的交换机名称常量
        //true：表示交换机持久化，服务重启后不会丢失
        //false：表示不自动删除，即使没有队列绑定也不会自动移除
        return new DirectExchange(exchange_dead, true, false, null);
    }

    @Bean
    public Queue queue1(){
        // 设置如果队列一 出现问题，则通过参数转到exchange_dead，routing_dead_2 上！
        Map<String, Object> map = new HashMap<>();
        // 参数绑定 此处的key 固定值，不能随意写
        map.put("x-dead-letter-exchange", exchange_dead);
        map.put("x-dead-letter-routing-key", routing_dead_2);
        // 设置延迟时间
        map.put("x-message-ttl", 10 * 1000);
        // 队列名称，是否持久化，是否独享、排外的【true:只可以在本次连接中访问】，是否自动删除，队列的其他属性参数
        return new Queue(queue_dead_1, true, false, false, map);
    }

    @Bean
    public Binding binding() {
        // 将队列一 通过routing_dead_1 key 绑定到exchange_dead 交换机上
        return BindingBuilder.bind(queue1()).to(exchange()).with(routing_dead_1);
    }

    // 这个队列二就是一个普通队列
    @Bean
    public Queue queue2() {
        return new Queue(queue_dead_2, true, false, false, null);
    }

    // 设置队列二的绑定规则
    @Bean
    public Binding binding2() {
        // 将队列二通过routing_dead_2 key 绑定到exchange_dead交换机上！
        return BindingBuilder.bind(queue2()).to(exchange()).with(routing_dead_2);
    }

}
