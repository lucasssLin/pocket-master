/*
 Navicat Premium Data Transfer

 Source Server         : linux-105
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.1.12:5781
 Source Schema         : pocket-order

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/08/2025 23:43:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'element-plus' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (3, 'order_info', '订单', NULL, NULL, 'OrderInfo', 'crud', 'element-plus', 'com.ruoyi.order', 'order', 'info', '订单', 'pocket', '0', '/', NULL, 'admin', '2025-01-25 16:05:04', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (4, 'order_item', '订单项信息', NULL, NULL, 'OrderItem', 'crud', 'element-plus', 'com.ruoyi.order', 'order', 'item', '订单项信息', 'pocket', '0', '/', NULL, 'admin', '2025-01-25 16:05:05', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (42, 3, 'id', 'id', 'bigint', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, 3, 'user_id', '会员_id', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, 3, 'nick_name', '昵称', 'varchar(200)', 'String', 'nickName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, 3, 'order_no', '订单号', 'char(64)', 'String', 'orderNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, 3, 'coupon_id', '使用的优惠券', 'bigint', 'Long', 'couponId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (47, 3, 'total_amount', '订单总额', 'decimal(10,2)', 'BigDecimal', 'totalAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (48, 3, 'coupon_amount', '优惠券', 'decimal(10,2)', 'BigDecimal', 'couponAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (49, 3, 'original_total_amount', '原价金额', 'decimal(10,2)', 'BigDecimal', 'originalTotalAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (50, 3, 'feight_fee', '运费', 'decimal(10,2)', 'BigDecimal', 'feightFee', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (51, 3, 'order_status', '订单状态【0->待付款；1->待发货；2->已发货；3->待用户收货，已完成；-1->已取消】', 'tinyint', 'Long', 'orderStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, 3, 'receiver_name', '收货人姓名', 'varchar(100)', 'String', 'receiverName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 11, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, 3, 'receiver_phone', '收货人电话', 'varchar(32)', 'String', 'receiverPhone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, 3, 'receiver_tag_name', '收货人地址标签', 'varchar(32)', 'String', 'receiverTagName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 13, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 3, 'receiver_province', '省份/直辖市', 'varchar(10)', 'String', 'receiverProvince', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 3, 'receiver_city', '城市', 'varchar(10)', 'String', 'receiverCity', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 3, 'receiver_district', '区', 'varchar(10)', 'String', 'receiverDistrict', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (58, 3, 'receiver_address', '详细地址', 'varchar(200)', 'String', 'receiverAddress', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 17, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (59, 3, 'payment_time', '支付时间', 'datetime', 'Date', 'paymentTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 18, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (60, 3, 'delivery_time', '发货时间', 'datetime', 'Date', 'deliveryTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 19, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (61, 3, 'receive_time', '确认收货时间', 'datetime', 'Date', 'receiveTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 20, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 3, 'cancel_time', '取消订单时间', 'datetime', 'Date', 'cancelTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 21, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 3, 'cancel_reason', '取消订单原因', 'varchar(255)', 'String', 'cancelReason', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 22, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, 3, 'create_time', '创建时间', 'timestamp', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 23, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, 3, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 24, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, 3, 'update_time', '更新时间', 'timestamp', 'Date', 'updateTime', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 25, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, 3, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 26, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, 3, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 27, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, 3, 'remark', '订单备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 28, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, 4, 'id', 'id', 'bigint', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (71, 4, 'order_id', 'order_id', 'bigint', 'Long', 'orderId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (72, 4, 'sku_id', '商品sku编号', 'bigint', 'Long', 'skuId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (73, 4, 'sku_name', '商品sku名字', 'varchar(255)', 'String', 'skuName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (74, 4, 'thumb_img', '商品sku图片', 'varchar(500)', 'String', 'thumbImg', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (75, 4, 'sku_price', '商品sku价格', 'decimal(10,2)', 'BigDecimal', 'skuPrice', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (76, 4, 'sku_num', '商品购买的数量', 'int', 'Long', 'skuNum', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (77, 4, 'create_time', '创建时间', 'timestamp', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (78, 4, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (79, 4, 'update_time', '更新时间', 'timestamp', 'Date', 'updateTime', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (80, 4, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (81, 4, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2025-01-25 16:05:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (82, 4, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2025-01-25 16:05:05', '', NULL);

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '会员_id',
  `nick_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `order_no` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `coupon_id` bigint NULL DEFAULT NULL COMMENT '使用的优惠券',
  `total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订单总额',
  `coupon_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠券',
  `original_total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '原价金额',
  `freight_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '运费',
  `order_status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态【//1 待付款 2 待发货 3 待收货 4 待评价 5 已完成 6	已取消】',
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `receiver_tag_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人地址标签',
  `receiver_province` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市',
  `receiver_district` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '确认收货时间',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '取消订单时间',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取消订单原因',
  `delivery_time_type` tinyint NULL DEFAULT NULL COMMENT '配送时间类型，1为不限，2为工作日，3为双休或假日',
  `buyer_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家留言',
  `pay_type` tinyint NULL DEFAULT NULL COMMENT '支付方式，1为在线支付，2为货到付款',
  `pay_channel` tinyint NULL DEFAULT NULL COMMENT '支付渠道：支付渠道，1支付宝、2微信--支付方式为在线支付时，传值',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES (117, 3, '17722863834', 'pocket320250516001538799', NULL, 7999.00, 0.00, 7999.00, 5.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-05-16 00:16:59', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-04-16 00:15:39', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (118, 3, '17722863834', 'pocket320250516001841798', NULL, 16148.00, 0.00, 16148.00, 45.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-05-16 00:18:51', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 00:18:42', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (119, 3, '17722863834', 'pocket320250516002655300', NULL, 4797.00, 0.00, 4797.00, 15.00, 2, '张三', '15045635284', '公司', '110000', '110100', '110102', '北京市东城区西直门2号', '2025-05-16 00:27:06', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 00:26:55', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (120, 3, '17722863834', 'pocket320250516003626185', NULL, 31996.00, 0.00, 31996.00, 20.00, 2, '张三', '15045635284', '公司', '110000', '110100', '110102', '北京市东城区西直门2号', '2025-05-16 00:36:35', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 00:36:26', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (121, 3, '17722863834', 'pocket320250516003650368', NULL, 15998.00, 0.00, 15998.00, 10.00, 2, '张三', '15045635284', '公司', '110000', '110100', '110102', '北京市东城区西直门2号', '2025-05-16 00:36:58', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 00:36:50', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (122, 3, '17722863834', 'pocket320250516005148696', NULL, 556.00, 0.00, 556.00, 20.00, 2, '张三', '15045635284', '公司', '110000', '110100', '110102', '北京市东城区西直门2号', '2025-05-16 00:52:36', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 00:51:49', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (123, 3, '17722863834', 'pocket320250516010100954', NULL, 12041.00, 0.00, 12041.00, 55.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-05-16 01:01:40', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 01:01:01', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (124, 3, '17722863834', 'pocket320250516010931085', NULL, 210.00, 0.00, 210.00, 15.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-05-16 01:09:40', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 01:09:31', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (125, 3, '17722863834', 'pocket320250516011505643', NULL, 96.00, 0.00, 96.00, 10.00, 2, '张三', '15045635284', '公司', '110000', '110100', '110102', '北京市东城区西直门2号', '2025-05-16 01:15:14', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 01:15:06', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (126, 3, '17722863834', 'pocket320250516011704020', NULL, 556.00, 0.00, 556.00, 20.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-05-16 01:17:12', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-16 01:17:04', NULL, '2025-05-27 10:56:54', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (127, 3, '17722863834', 'pocket320250529010559605', NULL, 657.00, 0.00, 657.00, 25.00, 2, 'Jack', '17722863834', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', '2025-05-29 01:12:12', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-29 01:06:00', NULL, '2025-05-28 17:12:11', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (128, 3, '17722863834', 'pocket320250529014758632', NULL, 1316.00, 0.00, 1316.00, 30.00, 2, 'Jack', '17722863834', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', '2025-05-29 01:48:22', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-29 01:47:59', NULL, '2025-05-28 17:48:21', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (129, 3, '17722863834', 'pocket320250529115312942', NULL, 974.00, 0.00, 974.00, 30.00, 2, 'Jack', '17722863834', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', '2025-05-29 11:56:30', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-29 11:53:13', NULL, '2025-05-29 03:56:30', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (130, 3, '17722863834', 'pocket320250529151514230', NULL, 18773.00, 0.00, 18773.00, 30.00, 2, 'Lucas', '17722863843', NULL, '440000', '440100', '440103', '广东省 广州市 荔湾区1111', '2025-05-29 15:15:44', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-05-29 15:15:14', NULL, '2025-05-29 07:15:44', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (131, 3, '17722863834', 'pocket320250702175147640', NULL, 7999.00, 0.00, 7999.00, 5.00, 2, 'Lucas', '17722863843', NULL, '440000', '440100', '440103', '广东省 广州市 荔湾区1111', '2025-07-02 17:52:03', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-06-02 17:51:48', NULL, '2025-07-30 12:52:58', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (132, 3, '17722863834', 'pocket320250721022212290', NULL, 6720.00, 0.00, 6720.00, 25.00, 6, 'Jack', '17722863836', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', NULL, NULL, NULL, '2025-07-21 02:32:13', 'Non-payment is automatically cancelled', 1, '', 1, 0, '2025-07-21 02:22:12', NULL, '2025-07-20 18:22:12', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (133, 3, '17722863834', 'pocket320250729012727397', NULL, 35.00, 0.00, 35.00, 5.00, 6, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', NULL, NULL, NULL, '2025-07-29 01:49:22', 'Non-payment is automatically cancelled', 1, '', 1, 0, '2025-07-29 01:27:28', NULL, '2025-07-28 17:27:27', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (134, 3, '17722863834', 'pocket320250730204057936', NULL, 35.00, 0.00, 35.00, 5.00, 6, 'Jack', '17722863836', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', NULL, NULL, NULL, '2025-07-30 20:50:58', 'Non-payment is automatically cancelled', 1, '', 1, 0, '2025-07-30 20:40:58', NULL, '2025-07-30 12:40:56', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (135, 3, '17722863834', 'pocket320250730204533504', NULL, 624.00, 0.00, 624.00, 40.00, 6, 'Lucas', '17722863843', NULL, '440000', '440100', '440103', '广东省 广州市 荔湾区1111', NULL, NULL, NULL, '2025-07-30 20:45:41', '商品信息填错了', 1, '', 1, 0, '2025-07-30 20:45:34', NULL, '2025-07-30 12:45:32', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (136, 3, '17722863834', 'pocket320250730204716373', NULL, 14372.00, 0.00, 14372.00, 30.00, 2, 'Lucas', '17722863843', NULL, '440000', '440100', '440103', '广东省 广州市 荔湾区1111', '2025-07-30 20:48:17', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-07-30 20:47:16', NULL, '2025-07-30 12:48:15', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (137, 3, '17722863833', 'pocket320250730224853932', NULL, 1554.00, 0.00, 1554.00, 15.00, 2, 'Jack', '17722863836', NULL, '810000', '810100', '810103', '香港特别行政区 香港特别行政区 九龙城区何文田', '2025-07-30 22:49:44', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-07-30 22:48:54', NULL, '2025-07-30 14:49:42', NULL, '0', NULL);
INSERT INTO `order_info` VALUES (138, 3, '17722863833', 'pocket320250731151549090', NULL, 1162.00, 0.00, 1162.00, 45.00, 2, 'tom', '13442333333', NULL, '140000', '140200', '140215', '山西省 大同市 云州区11号', '2025-07-31 15:16:23', NULL, NULL, NULL, NULL, 1, '', 1, 0, '2025-07-31 15:15:49', NULL, '2025-07-31 07:16:23', NULL, '0', NULL);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'order_id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品sku编号',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品sku名字',
  `thumb_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品sku图片',
  `sku_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品sku价格',
  `sku_num` int NULL DEFAULT NULL COMMENT '商品购买的数量',
  `spu_id` bigint NULL DEFAULT NULL,
  `attrs_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单项信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 9, '华为笔记本 32G', 'http://139.198.127.41:9000/spzx/20230525/c8f2eae0d36b6270.jpg.avif', 5999.00, 1, NULL, NULL, '2024-02-26 16:30:28', NULL, '2024-02-26 16:30:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (2, 1, 4, '小米 红米Note10 5G手机 红色 + 18G', 'http://139.198.127.41:9000/spzx/20230525/665832167-5_u_1%20(1).jpg', 2999.00, 1, NULL, NULL, '2024-02-26 16:30:25', NULL, '2024-02-26 16:30:25', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (3, 2, 5, '小米 红米Note10 5G手机 黑色 + 8G', 'http://139.198.127.41:9000/spzx/20230525/665832167-1_u_1.jpg', 1999.00, 1, NULL, NULL, '2024-02-28 08:27:41', NULL, '2024-02-28 08:27:41', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (4, 2, 7, '华为笔记本 8G', 'http://139.198.127.41:9000/spzx/20230525/4b5a68a9bfbd0795.jpg.avif', 3999.00, 2, NULL, NULL, '2024-02-28 08:27:48', NULL, '2024-02-28 08:27:48', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (156, 117, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 1, 36, '白色 + 512G', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (157, 118, 52, '若羌红枣脆片138克 138克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg', 18.00, 4, 13, '138克', '2025-05-16 00:17:49', NULL, '2025-05-16 00:17:49', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (158, 118, 59, '川味牛肉辣椒酱190克 川味果蔬辣椒酱190克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e3cccdd9f7f980e8276ddf82d99ec60_20250507013220A072.png', 26.00, 3, 16, '川味果蔬辣椒酱190克', '2025-05-16 00:18:00', NULL, '2025-05-16 00:18:00', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (159, 118, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 2, 36, '白色 + 512G', '2025-05-16 00:18:08', NULL, '2025-05-16 00:18:08', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (160, 119, 74, '麦瑞克家用轻音椭圆机 电磁控T6I款 + 1.6米', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1599.00, 3, 23, '电磁控T6I款 + 1.6米', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (161, 120, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 4, 36, '白色 + 512G', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (162, 121, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 2, 36, '白色 + 512G', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (163, 122, 82, '智能自动回弹健腹滚轮 经典款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 139.00, 4, 26, '经典款', '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (164, 123, 70, '野小兽磁阻划船机健身器材家用室内运动训练 米白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bf53d2a4459f58a41a9e96cad735a742_20250514154524A004.jpg', 2188.00, 5, 22, '米白色', '2025-05-16 01:00:47', NULL, '2025-05-16 01:00:47', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (165, 123, 94, '小方盒智能插线板-Pro版 白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a0d701292c4ca153e1800be83c4a7178_20250514170906A087.png', 109.00, 3, 31, '白色', '2025-05-16 01:00:38', NULL, '2025-05-16 01:00:38', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (166, 123, 105, '平台智造轻薄无线充电器 快充款(60W)', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 258.00, 3, 35, '快充款(60W)', '2025-05-16 01:00:26', NULL, '2025-05-16 01:00:26', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (167, 124, 64, '富到流油的高邮咸鸭蛋 75克*20枚', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014325A085.png', 70.00, 3, 18, '75克*20枚', '2025-05-06 17:45:29', NULL, '2025-05-09 09:37:43', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (168, 125, 100, '编织纹手机壳iPhone13型号 深海蓝 + iPhone13', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d83a869ac7ca083fe3e1902167f243cf_20250514174726A113.png', 48.00, 2, 34, '深海蓝 + iPhone13', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (169, 126, 82, '智能自动回弹健腹滚轮 经典款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 139.00, 4, 26, '经典款', '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (170, 127, 95, '平台有道口袋打印机GT1 口袋打印机', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0f6f0d72692274e53bc13d5c23c7b6a2_20250514171537A094.jpg', 288.00, 2, 32, '口袋打印机', '2025-05-29 01:05:36', NULL, '2025-05-29 01:05:36', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (171, 127, 56, '香菇肉燥酱375克（75克*5袋） 香菇肉燥酱375克（75克*5袋）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/aada32c857b5e6137969352cbb0ce8f4_20250507012736A062.png', 27.00, 3, 15, '香菇肉燥酱375克（75克*5袋）', '2025-05-29 01:05:25', NULL, '2025-05-29 01:05:25', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (172, 128, 171, '简约山形纹全棉提花毛巾 绿色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/b0d48553d094d81eb716e902e206b63a_20250527174119A005.png', 35.00, 4, 52, '绿色', '2025-05-29 01:46:54', NULL, '2025-05-29 01:46:54', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (173, 128, 92, 'Airline真无线耳机，空气感佩戴，全新升级 白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/80a3ec5c68f474b1c12720461b7fca10_20250514165300A067.png', 588.00, 2, 29, '白色', '2025-05-29 01:47:32', NULL, '2025-05-29 01:47:32', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (174, 129, 158, '软糯治愈系擦手，雪尼尔擦手球 3只/包', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png', 19.00, 4, 47, '3只/包', '2025-05-29 11:52:57', NULL, '2025-05-29 11:52:57', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (175, 129, 166, '源自澳洲进口羊毛，儿童奢暖羊毛被升级款 200x230cm', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png', 449.00, 2, 50, '200x230cm', '2025-05-29 11:52:42', NULL, '2025-05-29 11:52:42', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (176, 130, 163, '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪 硫光白（Air）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/8f945c11e702f84bffc14416c3e51c43_20250524002144A134.png', 799.00, 3, 49, '硫光白（Air）', '2025-05-24 00:24:54', NULL, '2025-05-24 00:24:54', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (177, 130, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 1, 36, '白色 + 512G', '2025-05-24 23:41:32', NULL, '2025-05-24 23:41:32', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (178, 130, 107, 'iPhone 16 Pro 星光色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/3283cf8419f0580adbaa667978b9aa3b_20250515025039A005.png', 7999.00, 1, 36, '星光色 + 512G', '2025-05-29 15:13:28', NULL, '2025-05-29 15:13:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (179, 130, 143, '男式零感无压加厚保暖羽绒服 涩柿色 + M（170/92A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233432A077.png', 378.00, 1, 42, '涩柿色 + M（170/92A）', '2025-05-25 00:18:13', NULL, '2025-05-25 00:18:13', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (180, 131, 109, 'iPhone 16 Pro 白色 + 512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 1, 36, '白色 + 512G', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (181, 132, 70, '野小兽磁阻划船机健身器材家用室内运动训练 米白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bf53d2a4459f58a41a9e96cad735a742_20250514154524A004.jpg', 2188.00, 3, 22, '米白色', '2025-07-21 02:19:00', NULL, '2025-07-21 02:19:00', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (182, 132, 99, 'MFi认证苹果快充编织数据线 升级加固加长版（1.6米） + 夜黑', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 78.00, 2, 33, '升级加固加长版（1.6米） + 夜黑', '2025-07-21 02:19:10', NULL, '2025-07-21 02:19:10', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (183, 133, 54, '无芯软糯的萌妹子，建宁莲子228克 118克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 35.00, 1, 14, '118克', '2025-05-06 17:24:06', NULL, '2025-05-09 09:36:16', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (184, 134, 54, '无芯软糯的萌妹子，建宁莲子228克 118克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 35.00, 1, 14, '118克', '2025-05-06 17:24:06', NULL, '2025-05-09 09:36:16', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (185, 135, 50, '爆款明星好物，抽屉式透明储物柜 M400*500*235mm47L两只装', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/51d2923b578d8721f2beeb5709398a5e_20250507005827A025.png', 138.00, 2, 12, 'M400*500*235mm47L两只装', '2025-05-16 00:17:44', NULL, '2025-05-16 00:17:44', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (186, 135, 101, '编织纹手机壳iPhone13型号 深海蓝 + iPhone13Pro', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d83a869ac7ca083fe3e1902167f243cf_20250514174735A114.png', 58.00, 6, 34, '深海蓝 + iPhone13Pro', '2025-05-14 23:08:39', NULL, '2025-05-14 23:08:39', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (187, 136, 77, '麦瑞克家用轻音智能多功能彩屏跑步机S450 多功能 + 10.1寸彩屏', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160036A019.png', 3499.00, 4, 24, '多功能 + 10.1寸彩屏', '2025-07-30 20:46:14', NULL, '2025-07-30 20:46:14', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (188, 136, 104, '平台智造轻薄无线充电器 基础款(30W)', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 188.00, 2, 35, '基础款(30W)', '2025-07-30 20:46:53', NULL, '2025-07-30 20:46:53', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (189, 137, 144, '男式零感无压加厚保暖羽绒服 涩柿色 + L（175/96A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233435A078.png', 378.00, 1, 42, '涩柿色 + L（175/96A）', '2025-07-30 20:46:59', NULL, '2025-07-30 20:46:59', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (190, 137, 91, 'Airline真无线耳机，空气感佩戴，全新升级 黑色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/877a4c7f92d560dd6f34176be997f3b5_20250514165500A069.png', 588.00, 2, 29, '黑色', '2025-07-30 20:48:50', NULL, '2025-07-30 20:48:50', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (191, 138, 145, '男式零感无压加厚保暖羽绒服 涩柿色 + XL（180/100A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 378.00, 1, 42, '涩柿色 + XL（180/100A）', '2025-07-31 14:13:36', NULL, '2025-07-31 14:13:36', NULL, '0', NULL);
INSERT INTO `order_item` VALUES (192, 138, 96, 'MFi认证苹果快充编织数据线 升级加固加长版（1.2米） + 夜黑/银白（两件装）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 98.00, 8, 33, '升级加固加长版（1.2米） + 夜黑/银白（两件装）', '2025-07-31 15:14:33', NULL, '2025-07-31 15:14:33', NULL, '0', NULL);

-- ----------------------------
-- Table structure for order_log
-- ----------------------------
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `operate_user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人：用户；系统；后台管理员',
  `process_status` int NULL DEFAULT NULL COMMENT '订单状态',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_log
-- ----------------------------
INSERT INTO `order_log` VALUES (1, 1, NULL, 0, '提交订单', '2024-02-27 11:00:44', NULL, '2024-02-27 11:00:44', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (2, 2, NULL, 0, '提交订单', '2024-02-28 08:29:36', NULL, '2024-02-28 08:29:36', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (192, 117, NULL, 1, 'submit order', '2025-05-15 16:15:39', NULL, '2025-05-15 16:15:39', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (193, 118, NULL, 1, 'submit order', '2025-05-15 16:18:42', NULL, '2025-05-15 16:18:42', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (194, 119, NULL, 1, 'submit order', '2025-05-15 16:26:55', NULL, '2025-05-15 16:26:55', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (195, 120, NULL, 1, 'submit order', '2025-05-15 16:36:26', NULL, '2025-05-15 16:36:26', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (196, 121, NULL, 1, 'submit order', '2025-05-15 16:36:50', NULL, '2025-05-15 16:36:50', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (197, 122, NULL, 1, 'submit order', '2025-05-15 16:51:49', NULL, '2025-05-15 16:51:49', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (198, 123, NULL, 1, 'submit order', '2025-05-15 17:01:01', NULL, '2025-05-15 17:01:01', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (199, 124, NULL, 1, 'submit order', '2025-05-15 17:09:31', NULL, '2025-05-15 17:09:31', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (200, 125, NULL, 1, 'submit order', '2025-05-15 17:15:06', NULL, '2025-05-15 17:15:06', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (201, 126, NULL, 1, 'submit order', '2025-05-15 17:17:04', NULL, '2025-05-15 17:17:04', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (202, 127, NULL, 1, 'submit order', '2025-05-28 17:05:59', NULL, '2025-05-28 17:05:59', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (203, 128, NULL, 1, 'submit order', '2025-05-28 17:47:58', NULL, '2025-05-28 17:47:58', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (204, 129, NULL, 1, 'submit order', '2025-05-29 03:53:12', NULL, '2025-05-29 03:53:12', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (205, 130, NULL, 1, 'submit order', '2025-05-29 07:15:15', NULL, '2025-05-29 07:15:15', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (206, 131, NULL, 1, 'submit order', '2025-07-02 09:51:48', NULL, '2025-07-02 09:51:48', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (207, 132, NULL, 1, 'submit order', '2025-07-20 18:22:12', NULL, '2025-07-20 18:22:12', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (208, 132, NULL, 6, 'System cancel order', '2025-07-20 18:32:12', NULL, '2025-07-20 18:32:12', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (209, 133, NULL, 1, 'submit order', '2025-07-28 17:27:27', NULL, '2025-07-28 17:27:27', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (210, 133, NULL, 6, 'System cancel order', '2025-07-28 17:49:22', NULL, '2025-07-28 17:49:22', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (211, 134, NULL, 1, 'submit order', '2025-07-30 12:40:56', NULL, '2025-07-30 12:40:56', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (212, 135, NULL, 1, 'submit order', '2025-07-30 12:45:32', NULL, '2025-07-30 12:45:32', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (213, 135, NULL, 6, 'User cancel order', '2025-07-30 12:45:39', NULL, '2025-07-30 12:45:39', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (214, 136, NULL, 1, 'submit order', '2025-07-30 12:47:14', NULL, '2025-07-30 12:47:14', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (215, 134, NULL, 6, 'System cancel order', '2025-07-30 12:50:56', NULL, '2025-07-30 12:50:56', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (216, 137, NULL, 1, 'submit order', '2025-07-30 14:48:52', NULL, '2025-07-30 14:48:52', NULL, '0', NULL);
INSERT INTO `order_log` VALUES (217, 138, NULL, 1, 'submit order', '2025-07-31 07:15:49', NULL, '2025-07-31 07:15:49', NULL, '0', NULL);

SET FOREIGN_KEY_CHECKS = 1;
