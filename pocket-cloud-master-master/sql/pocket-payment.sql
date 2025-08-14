/*
 Navicat Premium Data Transfer

 Source Server         : linux-105
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.1.12:5781
 Source Schema         : pocket-payment

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/08/2025 23:43:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for payment_info
-- ----------------------------
DROP TABLE IF EXISTS `payment_info`;
CREATE TABLE `payment_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `pay_type` tinyint NOT NULL DEFAULT 0 COMMENT '付款方式：1-微信 2-支付宝',
  `trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易编号（微信或支付）',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易内容',
  `payment_status` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付状态：0-未支付 1-已支付 -1-关闭',
  `callback_time` datetime NULL DEFAULT NULL COMMENT '回调时间',
  `callback_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '回调信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '付款信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_info
-- ----------------------------
INSERT INTO `payment_info` VALUES (1, 3, '4d045c3825d9496d85b588a80c618a45', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB +  Green ', '0', NULL, NULL, '2025-04-06 11:36:21', NULL, '2025-04-06 11:36:21', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (2, 3, '64dbcb0fc6724fb180b4fa5cc2880162', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB +  Green ', '0', NULL, NULL, '2025-04-06 11:44:42', NULL, '2025-04-06 11:44:42', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (3, 3, '2fe0f262e594414288d5f346da634553', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB +  Green ', '0', NULL, NULL, '2025-04-06 11:51:15', NULL, '2025-04-06 11:51:15', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (4, 3, '290350dfc2a74676a60073e7d983c8df', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 15:44:27', NULL, '2025-04-06 15:44:27', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (5, 3, '83d94cc58ad84140a563f390d1e33c76', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB + White ', '-1', NULL, NULL, '2025-04-06 15:51:20', NULL, '2025-04-06 15:51:20', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (6, 3, 'd9a2ef83260f4ebebeb46d06de6be140', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 15:56:43', NULL, '2025-04-06 15:56:43', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (7, 3, '2d65f30f84d24f8c99b42ec180845cd4', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 16:07:18', NULL, '2025-04-06 16:07:18', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (8, 3, '250e51b288284436bdaede9461be4fef', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 16:09:46', NULL, '2025-04-06 16:09:46', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (9, 3, 'ef7ade3b628146d0bfac53858197faac', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB + White ', '-1', NULL, NULL, '2025-04-06 16:15:15', NULL, '2025-04-06 16:15:15', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (10, 3, '7f4a0dbecfb741e4b49f97a20e96a11c', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 16:25:50', NULL, '2025-04-06 16:25:50', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (11, 3, '8797e48203074b72abc1f18bf5d02e52', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '-1', NULL, NULL, '2025-04-06 16:27:32', NULL, '2025-04-06 16:27:32', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (12, 3, 'd9635cf990d74da98bb1fcd1afdada17', 2, '2025040722001479130506047518', 4599.00, 'Xiaomi 15 Pro 32GB +  Black ', '1', '2025-04-07 00:29:53', '{\"gmt_create\":\"2025-04-07 00:29:28\",\"charset\":\"utf-8\",\"seller_email\":\"jhusyu1494@sandbox.com\",\"subject\":\"Xiaomi 15 Pro 32GB    Black \",\"buyer_id\":\"2088722041879134\",\"invoice_amount\":\"4599.00\",\"notify_id\":\"2025040701222002930179130506199824\",\"fund_bill_list\":\"[{\\\"amount\\\":\\\"4599.00\\\",\\\"fundChannel\\\":\\\"ALIPAYACCOUNT\\\"}]\",\"notify_type\":\"trade_status_sync\",\"trade_status\":\"TRADE_SUCCESS\",\"receipt_amount\":\"4599.00\",\"buyer_pay_amount\":\"4599.00\",\"app_id\":\"9021000140612644\",\"seller_id\":\"2088721041908855\",\"gmt_payment\":\"2025-04-07 00:29:29\",\"notify_time\":\"2025-04-07 00:29:30\",\"version\":\"1.0\",\"out_trade_no\":\"d9635cf990d74da98bb1fcd1afdada17\",\"total_amount\":\"4599.00\",\"trade_no\":\"2025040722001479130506047518\",\"auth_app_id\":\"9021000140612644\",\"buyer_logon_id\":\"bsfbtf9630@sandbox.com\",\"point_amount\":\"0.00\"}', '2025-04-06 16:29:18', NULL, '2025-04-06 16:29:18', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (13, 3, '01612109e72f40fb86a0e86266e08fc8', 0, NULL, 3999.00, 'Xiaomi 15 Pro 16GB +  Green ', '-1', NULL, NULL, '2025-04-06 18:32:10', NULL, '2025-04-06 18:32:10', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (14, 3, 'cb2d8963da91426fb3e1a81bd646a2fd', 0, NULL, 4599.00, 'Xiaomi 15 Pro 32GB + White ', '-1', NULL, NULL, '2025-04-07 01:12:45', NULL, '2025-04-07 01:12:45', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (15, 3, 'pocket320250506034347413', 0, NULL, 150.00, '极光限定 珠光蓝珐琅锅 ', '0', NULL, NULL, '2025-05-05 19:49:00', NULL, '2025-05-05 19:49:00', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (16, 3, 'pocket320250506041749509', 0, NULL, 150.00, '极光限定 珠光蓝珐琅锅 ', '0', NULL, NULL, '2025-05-05 20:17:52', NULL, '2025-05-05 20:17:52', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (17, 3, 'pocket320250506125101978', 0, NULL, 150.00, '极光限定 珠光蓝珐琅锅 ', '0', NULL, NULL, '2025-05-06 04:51:08', NULL, '2025-05-06 04:51:08', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (18, 3, 'pocket320250506130701096', 0, NULL, 150.00, '极光限定 珠光蓝珐琅锅 ', '0', NULL, NULL, '2025-05-06 05:07:06', NULL, '2025-05-06 05:07:06', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (19, 3, 'pocket320250506141700387', 3, 'pocket320250506141700387', 180.00, '钻石陶瓷涂层多用锅18cm 小奶锅 ', '1', '2025-05-06 14:25:15', '{\"out_trade_no\":\"pocket320250506141700387\",\"trade_no\":\"pocket320250506141700387\"}', '2025-05-06 06:17:15', NULL, '2025-05-06 06:17:15', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (20, 3, 'pocket320250507010632194', 3, 'pocket320250507010632194', 150.00, '极光限定 珠光蓝珐琅锅 ', '1', '2025-05-07 01:06:55', '{\"out_trade_no\":\"pocket320250507010632194\",\"trade_no\":\"pocket320250507010632194\"}', '2025-05-06 17:06:49', NULL, '2025-05-06 17:06:49', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (21, 3, 'pocket320250507010749915', 3, 'pocket320250507010749915', 100.00, '全面助力发育，全价幼猫粮（阶段）1.8千克 5.4千克/袋 ', '1', '2025-05-07 01:07:57', '{\"out_trade_no\":\"pocket320250507010749915\",\"trade_no\":\"pocket320250507010749915\"}', '2025-05-06 17:07:52', NULL, '2025-05-06 17:07:52', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (22, 3, 'pocket320250507011118184', 3, 'pocket320250507011118184', 138.00, '爆款明星好物，抽屉式透明储物柜 M400*500*235mm47L两只装 ', '1', '2025-05-07 01:11:33', '{\"out_trade_no\":\"pocket320250507011118184\",\"trade_no\":\"pocket320250507011118184\"}', '2025-05-06 17:11:26', NULL, '2025-05-06 17:11:26', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (23, 3, 'pocket320250509213748052', 3, 'pocket320250509213748052', 305.00, '香菇肉燥酱375克（75克*5袋） 香菇肉燥酱375克（75克*5袋） 现泡免煮，螺蛳粉370克*6盒 370克*6盒 若羌红枣脆片138克 138克 ', '1', '2025-05-09 21:38:36', '{\"out_trade_no\":\"pocket320250509213748052\",\"trade_no\":\"pocket320250509213748052\"}', '2025-05-09 13:38:32', NULL, '2025-05-09 13:38:32', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (24, 3, 'pocket320250516001538799', 3, 'pocket320250516001538799', 7999.00, 'iPhone 16 Pro 白色 + 512G ', '1', '2025-05-16 00:16:59', '{\"out_trade_no\":\"pocket320250516001538799\",\"trade_no\":\"pocket320250516001538799\"}', '2025-05-15 16:16:48', NULL, '2025-05-15 16:16:48', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (25, 3, 'pocket320250516001841798', 3, 'pocket320250516001841798', 16148.00, '若羌红枣脆片138克 138克 川味牛肉辣椒酱190克 川味果蔬辣椒酱190克 iPhone 16 Pro 白色 + 512G ', '1', '2025-05-16 00:18:50', '{\"out_trade_no\":\"pocket320250516001841798\",\"trade_no\":\"pocket320250516001841798\"}', '2025-05-15 16:18:47', NULL, '2025-05-15 16:18:47', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (26, 3, 'pocket320250516002655300', 3, 'pocket320250516002655300', 4797.00, '麦瑞克家用轻音椭圆机 电磁控T6I款 + 1.6米 ', '1', '2025-05-16 00:27:06', '{\"out_trade_no\":\"pocket320250516002655300\",\"trade_no\":\"pocket320250516002655300\"}', '2025-05-15 16:27:02', NULL, '2025-05-15 16:27:02', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (27, 3, 'pocket320250516003626185', 3, 'pocket320250516003626185', 31996.00, 'iPhone 16 Pro 白色 + 512G ', '1', '2025-05-16 00:36:35', '{\"out_trade_no\":\"pocket320250516003626185\",\"trade_no\":\"pocket320250516003626185\"}', '2025-05-15 16:36:31', NULL, '2025-05-15 16:36:31', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (28, 3, 'pocket320250516003650368', 3, 'pocket320250516003650368', 15998.00, 'iPhone 16 Pro 白色 + 512G ', '1', '2025-05-16 00:36:58', '{\"out_trade_no\":\"pocket320250516003650368\",\"trade_no\":\"pocket320250516003650368\"}', '2025-05-15 16:36:55', NULL, '2025-05-15 16:36:55', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (29, 3, 'pocket320250516005148696', 3, 'pocket320250516005148696', 556.00, '智能自动回弹健腹滚轮 经典款 ', '1', '2025-05-16 00:52:36', '{\"out_trade_no\":\"pocket320250516005148696\",\"trade_no\":\"pocket320250516005148696\"}', '2025-05-15 16:52:32', NULL, '2025-05-15 16:52:32', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (30, 3, 'pocket320250516010100954', 3, 'pocket320250516010100954', 12041.00, '野小兽磁阻划船机健身器材家用室内运动训练 米白色 小方盒智能插线板-Pro版 白色 平台智造轻薄无线充电器 快充款(60W) ', '1', '2025-05-16 01:01:40', '{\"out_trade_no\":\"pocket320250516010100954\",\"trade_no\":\"pocket320250516010100954\"}', '2025-05-15 17:01:36', NULL, '2025-05-15 17:01:36', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (31, 3, 'pocket320250516010931085', 3, 'pocket320250516010931085', 210.00, '富到流油的高邮咸鸭蛋 75克*20枚 ', '1', '2025-05-16 01:09:40', '{\"out_trade_no\":\"pocket320250516010931085\",\"trade_no\":\"pocket320250516010931085\"}', '2025-05-15 17:09:37', NULL, '2025-05-15 17:09:37', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (32, 3, 'pocket320250516011505643', 3, 'pocket320250516011505643', 96.00, '编织纹手机壳iPhone13型号 深海蓝 + iPhone13 ', '1', '2025-05-16 01:15:14', '{\"out_trade_no\":\"pocket320250516011505643\",\"trade_no\":\"pocket320250516011505643\"}', '2025-05-15 17:15:11', NULL, '2025-05-15 17:15:11', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (33, 3, 'pocket320250516011704020', 3, 'pocket320250516011704020', 556.00, '智能自动回弹健腹滚轮 经典款 ', '1', '2025-05-16 01:17:12', '{\"out_trade_no\":\"pocket320250516011704020\",\"trade_no\":\"pocket320250516011704020\"}', '2025-05-15 17:17:09', NULL, '2025-05-15 17:17:09', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (34, 3, 'pocket320250529010559605', 3, 'pocket320250529010559605', 657.00, '平台有道口袋打印机GT1 口袋打印机 香菇肉燥酱375克（75克*5袋） 香菇肉燥酱375克（75克*5袋） ', '1', '2025-05-29 01:12:12', '{\"out_trade_no\":\"pocket320250529010559605\",\"trade_no\":\"pocket320250529010559605\"}', '2025-05-28 17:12:04', NULL, '2025-05-28 17:12:04', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (35, 3, 'pocket320250529014758632', 3, 'pocket320250529014758632', 1316.00, '简约山形纹全棉提花毛巾 绿色 Airline真无线耳机，空气感佩戴，全新升级 白色 ', '1', '2025-05-29 01:48:22', '{\"out_trade_no\":\"pocket320250529014758632\",\"trade_no\":\"pocket320250529014758632\"}', '2025-05-28 17:48:12', NULL, '2025-05-28 17:48:12', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (36, 3, 'pocket320250529115312942', 3, 'pocket320250529115312942', 974.00, '软糯治愈系擦手，雪尼尔擦手球 3只/包 源自澳洲进口羊毛，儿童奢暖羊毛被升级款 200x230cm ', '1', '2025-05-29 11:56:30', '{\"out_trade_no\":\"pocket320250529115312942\",\"trade_no\":\"pocket320250529115312942\"}', '2025-05-29 03:53:49', NULL, '2025-05-29 03:53:49', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (37, 3, 'pocket320250529151514230', 3, 'pocket320250529151514230', 18773.00, '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪 硫光白（Air） iPhone 16 Pro 白色 + 512G iPhone 16 Pro 星光色 + 512G 男式零感无压加厚保暖羽绒服 涩柿色 + M（170/92A） ', '1', '2025-05-29 15:15:43', '{\"out_trade_no\":\"pocket320250529151514230\",\"trade_no\":\"pocket320250529151514230\"}', '2025-05-29 07:15:40', NULL, '2025-05-29 07:15:40', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (38, 3, 'pocket320250702175147640', 3, 'pocket320250702175147640', 7999.00, 'iPhone 16 Pro 白色 + 512G ', '1', '2025-07-02 17:52:02', '{\"out_trade_no\":\"pocket320250702175147640\",\"trade_no\":\"pocket320250702175147640\"}', '2025-07-02 09:51:58', NULL, '2025-07-02 09:51:58', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (39, 3, 'pocket320250721022212290', 0, NULL, 6720.00, '野小兽磁阻划船机健身器材家用室内运动训练 米白色 MFi认证苹果快充编织数据线 升级加固加长版（1.6米） + 夜黑 ', '-1', NULL, NULL, '2025-07-20 18:24:53', NULL, '2025-07-20 18:24:53', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (40, 3, 'pocket320250730204716373', 3, 'pocket320250730204716373', 14372.00, '麦瑞克家用轻音智能多功能彩屏跑步机S450 多功能 + 10.1寸彩屏 平台智造轻薄无线充电器 基础款(30W) ', '1', '2025-07-30 20:48:17', '{\"out_trade_no\":\"pocket320250730204716373\",\"trade_no\":\"pocket320250730204716373\"}', '2025-07-30 12:48:08', NULL, '2025-07-30 12:48:08', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (41, 3, 'pocket320250730224853932', 3, 'pocket320250730224853932', 1554.00, '男式零感无压加厚保暖羽绒服 涩柿色 + L（175/96A） Airline真无线耳机，空气感佩戴，全新升级 黑色 ', '1', '2025-07-30 22:49:44', '{\"out_trade_no\":\"pocket320250730224853932\",\"trade_no\":\"pocket320250730224853932\"}', '2025-07-30 14:49:10', NULL, '2025-07-30 14:49:10', NULL, '0', NULL);
INSERT INTO `payment_info` VALUES (42, 3, 'pocket320250731151549090', 3, 'pocket320250731151549090', 1162.00, '男式零感无压加厚保暖羽绒服 涩柿色 + XL（180/100A） MFi认证苹果快充编织数据线 升级加固加长版（1.2米） + 夜黑/银白（两件装） ', '1', '2025-07-31 15:16:23', '{\"out_trade_no\":\"pocket320250731151549090\",\"trade_no\":\"pocket320250731151549090\"}', '2025-07-31 07:16:15', NULL, '2025-07-31 07:16:15', NULL, '0', NULL);

SET FOREIGN_KEY_CHECKS = 1;
