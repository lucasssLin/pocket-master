/*
 Navicat Premium Data Transfer

 Source Server         : linux-105
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.1.12:5781
 Source Schema         : pocket-product

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/08/2025 23:43:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banner_item
-- ----------------------------
DROP TABLE IF EXISTS `banner_item`;
CREATE TABLE `banner_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'banner链接',
  `href_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `type` tinyint NOT NULL COMMENT '跳转类型：1 页面，2 H5，3 小程序（小程序使用）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Banner 表，用于存储轮播图信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner_item
-- ----------------------------
INSERT INTO `banner_item` VALUES (1, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-15/dfc11bb0-4af5-4e9b-9458-99f615cc685a.jpg', '1005000', 1, '2025-05-01 11:13:50', NULL, '2025-05-01 11:13:50', NULL, '0', NULL);
INSERT INTO `banner_item` VALUES (2, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-15/4a79180a-1a5a-4042-8a77-4db0b9c800a8.jpg', '1019000', 1, '2025-05-01 11:13:50', NULL, '2025-05-01 11:13:50', NULL, '0', NULL);
INSERT INTO `banner_item` VALUES (3, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-15/6d202d8e-bb47-4f92-9523-f32ab65754f4.jpg', '1013001', 1, '2025-05-01 11:13:50', NULL, '2025-05-01 11:13:50', NULL, '0', NULL);
INSERT INTO `banner_item` VALUES (4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-15/e83efb1b-309c-46f7-98a3-f1fefa694338.jpg', '1005000', 1, '2025-05-01 11:13:50', NULL, '2025-05-01 11:13:50', NULL, '0', NULL);
INSERT INTO `banner_item` VALUES (5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-15/1ba86bcc-ae71-42a3-bc3e-37b662f7f07e.jpg', '1013001', 1, '2025-05-01 11:13:50', NULL, '2025-05-01 11:13:50', NULL, '0', NULL);

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌名称',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌图标',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分类品牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (1, 'Huawei', 'http://192.168.1.12:5787/pocket/2025/01/24/huawei_20250124025929A001.png', '2024-01-09 10:15:05', NULL, '2025-01-25 13:27:21', 'sam', '0', NULL);
INSERT INTO `brand` VALUES (2, 'Xiaomi', 'http://192.168.1.12:5787/pocket/2025/01/24/xiaomi_20250124172255A002.jpg', '2024-02-03 15:45:29', 'admin', '2025-01-24 10:44:09', 'admin', '0', NULL);
INSERT INTO `brand` VALUES (7, 'Apple', 'http://192.168.1.12:5787/pocket/2025/01/26/Apple-Logo_20250126232617A001.png', '2025-01-26 15:26:20', 'admin', '2025-01-26 15:26:20', NULL, '0', NULL);
INSERT INTO `brand` VALUES (8, 'Intel', 'http://192.168.1.12:5787/pocket/2025/01/26/Intel_20250126232905A004.png', '2025-01-26 15:29:07', 'admin', '2025-01-26 15:29:07', NULL, '0', NULL);
INSERT INTO `brand` VALUES (9, 'Philips', 'http://192.168.1.12:5787/pocket/2025/01/26/Philips_20250126232919A005.jpg', '2025-01-26 15:29:20', 'admin', '2025-01-26 15:29:20', NULL, '0', NULL);
INSERT INTO `brand` VALUES (10, 'Lenovo', 'http://192.168.1.12:5787/pocket/2025/01/26/Lenovo_20250126233115A007.png', '2025-01-26 15:31:16', 'admin', '2025-01-26 15:31:16', NULL, '0', NULL);
INSERT INTO `brand` VALUES (11, 'Dell', 'http://192.168.1.12:5787/pocket/2025/01/26/Dell_20250126233120A008.webp', '2025-01-26 15:31:25', 'admin', '2025-01-26 15:31:25', NULL, '0', NULL);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名称',
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父分类id',
  `status` tinyint NULL DEFAULT NULL COMMENT '是否显示[0-不显示，1显示]',
  `order_num` int NULL DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19999999003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (8, '单反相机', 'https://lilishop-oss.oss-cn-beijing.aliyuncs.com/1348576427264204949.png', 5, 1, 0, '2025-01-25 10:22:02', NULL, '2025-01-25 10:22:02', NULL, '0', NULL);
INSERT INTO `category` VALUES (999999, '品牌', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/d9ee4919-0d2c-4383-9916-2dd25f12610c.png?quality=95&imageView', 0, 1, 0, '2025-05-01 10:43:02', NULL, '2025-05-01 10:43:02', NULL, '0', NULL);
INSERT INTO `category` VALUES (1005000, '居家', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/201516e3-25d0-48f5-bcee-7f0cafb14176.png', 0, 1, 0, '2025-05-01 09:38:16', NULL, '2025-05-01 09:38:16', NULL, '0', NULL);
INSERT INTO `category` VALUES (1005002, '美食', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/cf82e5b4-bf1b-4c68-aa86-96f66e8e5282.png', 0, 1, 0, '2025-05-01 10:02:39', NULL, '2025-05-01 10:02:39', NULL, '0', NULL);
INSERT INTO `category` VALUES (1005012, '南北干货', 'https://yanxuan.nosdn.127.net/9af51a1090fd32f668b14451f06d6e72.png', 1005002, 1, 0, '2025-05-01 10:03:10', NULL, '2025-05-01 10:03:18', NULL, '0', NULL);
INSERT INTO `category` VALUES (1008006, '影音娱乐', 'https://yanxuan.nosdn.127.net/f5797ca77cfe413e7753ec69f9bd4bb1.png', 1043000, 1, 0, '2025-05-01 10:07:24', NULL, '2025-05-01 10:07:33', NULL, '0', NULL);
INSERT INTO `category` VALUES (1008017, '收纳', 'https://yanxuan.nosdn.127.net/366989e4d730594e86fcd60b5ab19acc.png', 1005000, 1, 0, '2025-05-01 09:41:28', NULL, '2025-05-01 09:41:35', NULL, '0', NULL);
INSERT INTO `category` VALUES (1009000, '家庭清洁', 'https://yanxuan.nosdn.127.net/718318c0d3b55d011fcb7c7c843902ce.png', 1013001, 1, 0, '2025-05-01 10:16:43', NULL, '2025-05-01 10:16:51', NULL, '0', NULL);
INSERT INTO `category` VALUES (1010000, '服饰', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/33e1f5de-0fdb-4cfa-9ba9-781233024b53.png', 0, 1, 0, '2025-05-01 10:09:43', NULL, '2025-05-01 10:09:43', NULL, '0', NULL);
INSERT INTO `category` VALUES (1011000, '母婴', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/b514a526-4010-4ce8-8cb9-757ed382f84a.png', 0, 1, 0, '2025-05-01 10:12:35', NULL, '2025-05-01 10:12:35', NULL, '0', NULL);
INSERT INTO `category` VALUES (1013001, '个护', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/d38a73b8-cd03-48aa-a60b-e7c4e16667ed.png', 0, 1, 0, '2025-05-01 10:15:53', NULL, '2025-05-01 10:15:53', NULL, '0', NULL);
INSERT INTO `category` VALUES (1017000, '宠物食品', 'https://yanxuan.nosdn.127.net/b42a85ef15f856081ea9f49e5f6893e2.png', 1005000, 1, 0, '2025-05-01 09:42:12', NULL, '2025-05-01 09:42:22', NULL, '0', NULL);
INSERT INTO `category` VALUES (1019000, '严选', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/4b02f01f-a365-4b6c-9f7a-8b0f591dda02.png', 0, 1, 0, '2025-05-01 10:18:27', NULL, '2025-05-01 10:18:27', NULL, '0', NULL);
INSERT INTO `category` VALUES (1020002, '浴室用品', 'https://yanxuan.nosdn.127.net/dfb6142de1bd2f59b251eb8f7c7ea2fb.png', 1013001, 1, 0, '2025-05-01 10:17:06', NULL, '2025-05-01 10:17:18', NULL, '0', NULL);
INSERT INTO `category` VALUES (1020003, 'T恤/polo/衬衫', 'https://yanxuan.nosdn.127.net/1f0089afcec911db7202fbcdae57d5f8.png', 1011000, 1, 0, '2025-05-01 10:13:11', NULL, '2025-05-01 10:13:38', NULL, '0', NULL);
INSERT INTO `category` VALUES (1022000, '3C数码', 'https://yanxuan.nosdn.127.net/99b8f97b2e5449606fd558574aa15982.png', 1043000, 1, 0, '2025-05-01 10:07:54', NULL, '2025-05-01 10:08:02', NULL, '0', NULL);
INSERT INTO `category` VALUES (1036003, '调味酱菜', 'https://yanxuan.nosdn.127.net/5fae33a840870b487cc903535383bf97.png', 1005002, 1, 0, '2025-05-01 10:03:43', NULL, '2025-05-01 10:03:49', NULL, '0', NULL);
INSERT INTO `category` VALUES (1037006, '儿童鞋', 'https://yanxuan.nosdn.127.net/7fd14a409302391da16970981cacd336.png', 1011000, 1, 0, '2025-05-01 10:14:31', NULL, '2025-05-01 10:14:36', NULL, '0', NULL);
INSERT INTO `category` VALUES (1043000, '数码', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/9660870d-6a59-4624-8064-b3a8cbf50d5c.png', 0, 1, 0, '2025-05-01 10:06:57', NULL, '2025-05-01 10:06:57', NULL, '0', NULL);
INSERT INTO `category` VALUES (1065004, '滋补保健', 'https://yanxuan.nosdn.127.net/1e619a2b22f40bf83070e6f8f6e0c8ff.png', 1019000, 1, 0, '2025-05-01 10:19:22', NULL, '2025-05-01 10:19:30', NULL, '0', NULL);
INSERT INTO `category` VALUES (19999999, '杂项', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/4ff20b9e-8150-4bd3-87a3-0cd6766938dd.png', 0, 1, 0, '2025-05-01 10:23:34', NULL, '2025-05-01 10:23:34', NULL, '0', NULL);
INSERT INTO `category` VALUES (109201001, '方便食品', 'https://yanxuan.nosdn.127.net/f9872b4aad6c0a943d45629ac96ee8d3.png', 1005002, 1, 0, '2025-05-01 10:04:11', NULL, '2025-05-01 10:04:15', NULL, '0', NULL);
INSERT INTO `category` VALUES (109206007, '米面粮油', 'https://yanxuan.nosdn.127.net/8578759aed2268f7aa8641273cac7cb3.png', 1005002, 1, 0, '2025-05-01 10:04:38', NULL, '2025-05-01 10:04:44', NULL, '0', NULL);
INSERT INTO `category` VALUES (109243003, '艺术藏品', 'https://yanxuan.nosdn.127.net/9544b81aaa14c26a8038c2365ff3c2bc.png', 1005000, 1, 0, '2025-05-01 09:42:56', NULL, '2025-05-01 09:43:03', NULL, '0', NULL);
INSERT INTO `category` VALUES (109243019, '裤子/裙装', 'https://yanxuan.nosdn.127.net/a8c52cea5f953019484a74883ad8f14b.png', 1011000, 1, 0, '2025-05-01 10:15:06', NULL, '2025-05-01 10:15:11', NULL, '0', NULL);
INSERT INTO `category` VALUES (109243029, '运动', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/7d19752c-baff-49b6-bd02-5ece1d729214.png', 0, 1, 0, '2025-05-01 10:21:01', NULL, '2025-05-01 10:21:01', NULL, '0', NULL);
INSERT INTO `category` VALUES (109243035, '手机配件', 'https://yanxuan.nosdn.127.net/0276d68f4b7a03bbd16675ada6e707ff.png', 1043000, 1, 0, '2025-05-01 10:08:42', NULL, '2025-05-01 10:08:48', NULL, '0', NULL);
INSERT INTO `category` VALUES (109248004, '宠物用品', 'https://yanxuan.nosdn.127.net/e766b09029ca00680d1e651b5cdc42bd.png', 1005000, 1, 0, '2025-05-01 09:43:32', NULL, '2025-05-01 09:43:38', NULL, '0', NULL);
INSERT INTO `category` VALUES (109256013, '干湿巾', 'https://yanxuan.nosdn.127.net/985897ea31fdfc159e12696f4dbb4c13.png', 1013001, 1, 0, '2025-05-01 10:17:55', NULL, '2025-05-01 10:18:01', NULL, '0', NULL);
INSERT INTO `category` VALUES (109256014, '床品家纺', 'https://yanxuan.nosdn.127.net/e6580910c1f98ed61bda867aeaf07929.png', 1019000, 1, 0, '2025-05-01 10:19:55', NULL, '2025-05-01 10:20:00', NULL, '0', NULL);
INSERT INTO `category` VALUES (109264007, '名酒馆', 'https://yanxuan.nosdn.127.net/91413b1476a0697bb0592609a42d4498.png', 1005002, 1, 0, '2025-05-01 10:05:15', NULL, '2025-05-01 10:05:21', NULL, '0', NULL);
INSERT INTO `category` VALUES (109285003, '进口酒', 'https://yanxuan.nosdn.127.net/bf705060f01b60fe9c11c345931b1891.png', 1005002, 1, 0, '2025-05-01 10:05:39', NULL, '2025-05-01 10:05:45', NULL, '0', NULL);
INSERT INTO `category` VALUES (109293000, '家庭医疗', 'https://yanxuan.nosdn.127.net/3f34039fa8c26e18e2f4fc96ed8cb6de.png', 1005000, 1, 0, '2025-05-01 09:44:13', NULL, '2025-05-01 09:44:21', NULL, '0', NULL);
INSERT INTO `category` VALUES (109303000, '钱包/胸包', 'https://yanxuan.nosdn.127.net/237613bc9c22eb422dade63e3ed7c61a.png', 1010000, 1, 0, '2025-05-01 10:10:19', NULL, '2025-05-01 10:10:33', NULL, '0', NULL);
INSERT INTO `category` VALUES (109308000, '中医保健', 'https://yanxuan.nosdn.127.net/2bfba997fd031317caecc4f0bad17569.png', 1005000, 1, 0, '2025-05-01 09:44:49', NULL, '2025-05-01 09:44:56', NULL, '0', NULL);
INSERT INTO `category` VALUES (109309012, '个护电器', 'https://yanxuan.nosdn.127.net/7a0eea3c515ad247c092749bcdd29855.png', 1019000, 1, 0, '2025-05-01 10:20:22', NULL, '2025-05-01 10:20:28', NULL, '0', NULL);
INSERT INTO `category` VALUES (109311005, '女式靴子', 'https://yanxuan.nosdn.127.net/62c5dacf3e0cbe8e4188ccd263358d1a.png', 1010000, 1, 0, '2025-05-01 10:11:01', NULL, '2025-05-01 10:11:06', NULL, '0', NULL);
INSERT INTO `category` VALUES (109311006, '女式休闲鞋', 'https://yanxuan.nosdn.127.net/8cd3a76ffffb14e9fe92ad2369117af0.png', 1010000, 1, 0, '2025-05-01 10:11:28', NULL, '2025-05-01 10:11:35', NULL, '0', NULL);
INSERT INTO `category` VALUES (109312000, '健身大器械', 'https://yanxuan.nosdn.127.net/6a1d37ffb2e28622a71e3c4415eaee35.png', 109243029, 1, 0, '2025-05-01 10:21:30', NULL, '2025-05-01 10:21:36', NULL, '0', NULL);
INSERT INTO `category` VALUES (109312001, '健身小器械', 'https://yanxuan.nosdn.127.net/8c9f060e6fddb2b75af851a9a2c60087.png', 109243029, 1, 0, '2025-05-01 10:21:56', NULL, '2025-05-01 10:22:25', NULL, '0', NULL);
INSERT INTO `category` VALUES (109313003, '户外装备', 'https://yanxuan.nosdn.127.net/6bbd92c68741c857d842f0afd1c7bdd5.png', 109243029, 1, 0, '2025-05-01 10:23:02', NULL, '2025-05-01 10:23:08', NULL, '0', NULL);
INSERT INTO `category` VALUES (1005999003, '居家生活用品', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-22/7f6a7b20-7902-4b43-b9c5-f33151ef1334.jpg', 1005000, 1, 0, '2025-05-01 09:39:01', NULL, '2025-05-01 09:39:22', NULL, '0', NULL);
INSERT INTO `category` VALUES (19999999001, '家庭清洁杂项', 'https://yanxuan.nosdn.127.net/718318c0d3b55d011fcb7c7c843902ce.png', 19999999, 1, 0, '2025-05-01 10:23:59', NULL, '2025-05-01 10:24:08', NULL, '0', NULL);
INSERT INTO `category` VALUES (19999999002, '品牌', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/d9ee4919-0d2c-4383-9916-2dd25f12610c.png?quality=95&imageView', 999999, 1, 0, '2025-05-06 16:52:28', NULL, '2025-05-06 16:52:51', NULL, '0', NULL);

-- ----------------------------
-- Table structure for category_brand
-- ----------------------------
DROP TABLE IF EXISTS `category_brand`;
CREATE TABLE `category_brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `brand_id` bigint NULL DEFAULT NULL COMMENT '品牌ID',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分类品牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category_brand
-- ----------------------------
INSERT INTO `category_brand` VALUES (1, 1, 3, '2024-01-09 15:41:40', NULL, '2024-02-28 17:19:21', 'admin', '0', NULL);
INSERT INTO `category_brand` VALUES (2, 2, 3, '2024-02-20 08:59:31', 'admin', '2024-02-28 17:19:23', 'admin', '0', NULL);

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
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `brand_id` bigint NULL DEFAULT NULL COMMENT '品牌ID',
  `category1_id` bigint NULL DEFAULT NULL COMMENT '一级分类id',
  `category2_id` bigint NULL DEFAULT NULL COMMENT '二级分类id',
  `category3_id` bigint NULL DEFAULT NULL COMMENT '三级分类id',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `unit_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计量单位',
  `slider_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '轮播图',
  `spec_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品规格json',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '线上状态：0-初始值，1-上架，-1-自主下架',
  `audit_status` tinyint NOT NULL DEFAULT 0 COMMENT '审核状态：0-初始值，1-通过，-1-未通过',
  `audit_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '小米 红米Note10 5G手机', 2, 1, 2, 3, NULL, '个', 'http://139.198.127.41:9000/spzx/20230525/665832167-5_u_1.jpg,http://139.198.127.41:9000/spzx/20230525/665832167-6_u_1.jpg,http://139.198.127.41:9000/spzx/20230525/665832167-4_u_1.jpg,http://139.198.127.41:9000/spzx/20230525/665832167-1_u_1.jpg,http://139.198.127.41:9000/spzx/20230525/665832167-5_u_1 (1).jpg,http://139.198.127.41:9000/spzx/20230525/665832167-3_u_1.jpg\n', '[{\"key\":\"颜色\",\"valueList\":[\"白色\",\"红色\",\"黑色\"]},{\"key\":\"内存\",\"valueList\":[\"8G\",\"18G\"]}]', 0, 0, '审批通过', '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product` VALUES (2, '华为笔记本', 1, 1, 41, 42, NULL, '个', 'http://139.198.127.41:9000/spzx/20230525/f1d7433dbe88c25e.jpg.avif,http://139.198.127.41:9000/spzx/20230525/4b5a68a9bfbd0795.jpg.avif,http://139.198.127.41:9000/spzx/20230525/13beb824e9dcfc88.jpg.avif,http://139.198.127.41:9000/spzx/20230525/3976e9cfaf7c6ceb.jpg.avif,http://139.198.127.41:9000/spzx/20230525/35b3b7e2e67b98b2.jpg.avif,http://139.198.127.41:9000/spzx/20230525/c8f2eae0d36b6270.jpg.avif,http://139.198.127.41:9000/spzx/20230525/fd5c6bfa6f3c4d43.jpg.avif', '[{\"key\":\"内存\",\"valueList\":[\"8G\",\"16G\",\"32G\"]}]', 0, 0, '审批通过', '2023-05-25 15:18:28', NULL, '2025-01-24 12:37:53', NULL, '2', NULL);
INSERT INTO `product` VALUES (3, 'Xiaomi 15 Pro', 2, 1, 2, 3, NULL, 'Unit', 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698304648.62164143_20250124203346A009.png,http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.377145_20250124203348A010.png,http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.35678660_20250124203351A011.png,http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.32273950_20250124203353A012.png', '[{\"key\":\"RAM\",\"valueList\":[\"16GB\",\"32GB\"]},{\"key\":\"Color\",\"valueList\":[\"White\",\" Green\",\" Black\"]}]', 0, 0, 'Audit Pass', '2025-01-24 12:36:51', NULL, '2025-05-02 18:34:23', NULL, '2', NULL);
INSERT INTO `product` VALUES (4, '钻石陶瓷涂层多用锅18cm 小奶锅', NULL, 1005000, 1005999003, NULL, '安全耐用，易于清洗APP', NULL, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/6fdcac19-dd44-442c-9212-f7ec3cf3ed18.jpg,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/45fd1372-05d2-4ff8-8669-79463a1e589f.jpg,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/e5a9f569-accc-4006-9064-2180e7f2b691.jpg,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/81119a14-5311-4011-af4a-273894375c74.jpg', NULL, 1, 1, NULL, '2025-05-01 05:29:23', NULL, '2025-05-02 16:53:30', NULL, '0', NULL);
INSERT INTO `product` VALUES (5, '极光限定 珠光蓝珐琅锅', NULL, 1005000, 1005999003, NULL, NULL, NULL, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/7f483771-6831-4a7a-abdb-2625acb755f3.png,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/a725cfaf-2d25-4155-9a2d-fa67f2daacde.png,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/8f8d636f-87b8-4734-b579-c5abf1dd7084.png,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/c5c155da-53f0-44b5-bb28-91019863f02d.png,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/06dd4404-6af6-437d-a417-b4b78baf21a2.png', NULL, 1, 1, NULL, '2025-05-03 04:07:02', NULL, '2025-05-03 04:07:14', NULL, '0', NULL);
INSERT INTO `product` VALUES (11, '全面助力发育，全价幼猫粮（阶段）1.8千克', NULL, 1005000, 1017000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/395e781595f60b4e2c7aaab2420da3cd_20250507004009A009.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d2dae70fdfa31f6cadaac345e36042f4_20250507004012A010.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/643bc9f2a23a29c45372e6bfc8554ee8_20250507004014A011.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e0370f95974f0c78ddbeeda03a0bc600_20250507004017A012.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-06 16:44:38', NULL, '2025-05-09 08:46:37', NULL, '0', NULL);
INSERT INTO `product` VALUES (12, '爆款明星好物，抽屉式透明储物柜', NULL, 1005000, 1008017, NULL, '抽屉随意拉，东西随意拿，7款尺寸，随意叠加搭配app', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/76a5304c9d7378a83e63554f3077d98b_20250507005715A022.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f55880d22e083194c18801de48d96779_20250507005716A023.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/230f4b71e649522834c7305174195032_20250507005719A024.jpg', NULL, 1, 1, NULL, '2025-05-06 17:02:13', NULL, '2025-05-09 08:46:09', NULL, '0', NULL);
INSERT INTO `product` VALUES (13, '若羌红枣脆片138克', NULL, 1005002, 1005012, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/495c275568cf80a389357ea2c46b735f_20250507011455A036.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/495c275568cf80a389357ea2c46b735f_20250507011508A037.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/77c656d537e8c83ce75944e5e4844277_20250507011530A038.png', NULL, 1, 1, NULL, '2025-05-06 17:18:51', NULL, '2025-05-09 08:45:38', NULL, '0', NULL);
INSERT INTO `product` VALUES (14, '无芯软糯的萌妹子，建宁莲子228克', NULL, 1005002, 1005012, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/28b68f8d4c7fd34ff3763031a80bed00_20250507012005A045.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/03810d6578af20e90f79aba10c3708bc_20250507012007A046.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-06 17:24:06', NULL, '2025-05-09 08:43:31', NULL, '0', NULL);
INSERT INTO `product` VALUES (15, '香菇肉燥酱375克（75克*5袋）', NULL, 1005002, 1036003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/9184d83ef1f6641b7b7c56c6e9836285_20250507012525A057.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/b895b333776421e0cf52820755228bc5_20250507012527A058.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/33eb4038e264428ebd0550a0c17a7f4c_20250507012530A059.jpg', NULL, 1, 1, NULL, '2025-05-06 17:30:11', NULL, '2025-05-09 08:43:01', NULL, '0', NULL);
INSERT INTO `product` VALUES (16, '川味牛肉辣椒酱190克', NULL, 1005002, 1036003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e1681ab3a4a5aaf185f0bb123f07f99_20250507013111A069.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3bb3a6c613ab9458289311eb31dcd24a_20250507013114A070.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/58932f0ea2c6c1eccfc59d956edb6ae3_20250507013116A071.jpg', NULL, 1, 1, NULL, '2025-05-06 17:35:03', NULL, '2025-05-09 08:42:10', NULL, '0', NULL);
INSERT INTO `product` VALUES (17, '现泡免煮，螺蛳粉370克*6盒', NULL, 1005002, 109201001, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/65256152984021cfb766c4856f2307d8_20250507013829A076.jpg,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/da2309383b7f8c3de5d5e2a950b328d9_20250507013831A077.jpg,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/9bfc3d85635c676a12490f5128177b9b_20250507013833A078.jpg,', NULL, 1, 1, NULL, '2025-05-06 17:41:22', NULL, '2025-05-09 08:41:21', NULL, '0', NULL);
INSERT INTO `product` VALUES (18, '富到流油的高邮咸鸭蛋', NULL, 1005002, 109201001, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d97cd8558999713868afa029f338d0a4_20250507014229A081.png,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/c005d428913f63fddf07d483aeaadcd9_20250507014231A082.jpg,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014236A083.png,', NULL, 1, 1, NULL, '2025-05-06 17:45:29', NULL, '2025-05-09 08:39:34', NULL, '0', NULL);
INSERT INTO `product` VALUES (19, '黄金玉粟粥米', NULL, 1005002, 109206007, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014715A092.png,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d8080471f3ac8297697e387caa0f6063_20250507014740A093.jpg,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014909A094.png,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d8080471f3ac8297697e387caa0f6063%20(1)_20250507014915A095.jpg,', NULL, 1, 1, NULL, '2025-05-06 17:52:13', NULL, '2025-05-09 08:37:07', NULL, '0', NULL);
INSERT INTO `product` VALUES (20, '贵州兴仁薏仁米600克', NULL, 1005002, 109206007, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3e93790bba8db8aab54ee5ba72799567_20250507020547A104.png,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f9734d495d2ddcefe6b1ff2458d58020_20250507020549A105.jpg,\r\nhttps://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/dd0eef5b0c57fbbf648bfd5f5b10d0f0_20250507020616A106.png', NULL, 1, 1, NULL, '2025-05-06 18:08:50', NULL, '2025-05-09 08:23:54', NULL, '0', NULL);
INSERT INTO `product` VALUES (21, '品质在内格调在外头层真皮防消磁钥匙卡包', NULL, 1010000, 109303000, NULL, '优质牛皮面料鳄鱼压纹纹理app', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/163063c82dc7efa80dc8ab964a56ce49_20250509175937A005.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/3ac86597c1e0f8c9bc781c476c733299_20250509175727A002.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/23fd75b23f3b4bf175034ebea0dd9b88_20250509175757A003.jpg', NULL, 1, 1, NULL, '2025-05-09 10:00:43', NULL, '2025-05-09 10:03:07', NULL, '0', NULL);
INSERT INTO `product` VALUES (22, '野小兽磁阻划船机健身器材家用室内运动训练', NULL, 109243029, 109312000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/43aa62df27f8f3f4fb6ba042ad21d830_20250514154438A001.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/752510ba2f640aeb32cbe781bd3b5331_20250514154441A002.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bf53d2a4459f58a41a9e96cad735a742_20250514154443A003.jpg', NULL, 1, 1, NULL, '2025-05-14 07:47:16', NULL, '2025-05-14 07:47:54', NULL, '0', NULL);
INSERT INTO `product` VALUES (23, '麦瑞克家用轻音椭圆机', NULL, 109243029, 109312000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/cba18457da404b268bf6e132b6bac431_20250514155032A009.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5b14ce970997ccded41934c9e2c5e81f_20250514155035A010.png', NULL, 1, 1, NULL, '2025-05-14 07:55:54', NULL, '2025-05-14 07:56:01', NULL, '0', NULL);
INSERT INTO `product` VALUES (24, '麦瑞克家用轻音智能多功能彩屏跑步机S450', NULL, 109243029, 109312000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a5d745bbe067ca2468cdb2948f4f10ca_20250514155835A014.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/70faa07bb9e019c0b0809165e1162978_20250514155837A015.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514155840A016.png', NULL, 1, 1, NULL, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:44', NULL, '0', NULL);
INSERT INTO `product` VALUES (25, '门上单杠墙体免打孔引体向上器', NULL, 109243029, 109312001, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/02b31c535488c3d41e074e4bbb7e8c46_20250514160548A024.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5146cb2cbdd600c3998f98f50bb45664_20250514160550A025.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0a7cd982ce065edd6f950d731791c126_20250514160552A026.png', NULL, 1, 1, NULL, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:34', NULL, '0', NULL);
INSERT INTO `product` VALUES (26, '智能自动回弹健腹滚轮', NULL, 109243029, 109312001, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c38ca5e41560ee0e6ada49d0a2c2c5bf_20250514161129A034.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5ecfef888f58be38abdad9fbab3bdac1_20250514161132A035.png', NULL, 1, 1, NULL, '2025-05-14 08:13:56', NULL, '2025-05-14 08:14:02', NULL, '0', NULL);
INSERT INTO `product` VALUES (27, '冬日出行多功能防风保暖围脖', NULL, 109243029, 109313003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/25effebb31ea6fc58b92f5a6aecda8b9_20250514161632A039.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/eac0f7f296bde8ee28f86a588fb0a9b8_20250514161635A040.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1434c5d7ca4e24a6e8e95e3f925931a6_20250514161637A041.jpg', NULL, 1, 1, NULL, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:14', NULL, '0', NULL);
INSERT INTO `product` VALUES (28, '可触屏户外出行手套', NULL, 109243029, 109313003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/264df9f0faddb60e88a8b108058d25e6_20250514163634A049.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f576cbe048d33845868ec52993fe7b0_20250514163636A050.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d47dc274b8ccb4d0905ca01efeb5701c_20250514163639A051.png', NULL, 1, 1, 'Audit Pass', '2025-05-14 08:42:56', NULL, '2025-05-15 17:36:04', NULL, '0', NULL);
INSERT INTO `product` VALUES (29, 'Airline真无线耳机，空气感佩戴，全新升级', NULL, 1043000, 1008006, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/48c839eed5b1559636b15cc9b86aa06c_20250514165209A063.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/81c062992c262e60c260b7ebf13f88e0_20250514165212A064.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/877a4c7f92d560dd6f34176be997f3b5_20250514165214A065.png', NULL, 1, 1, 'Audit Pass', '2025-05-14 08:56:57', NULL, '2025-05-14 08:57:20', NULL, '0', NULL);
INSERT INTO `product` VALUES (30, '平台云音乐氧气立体声蓝牙头戴式触控耳机', NULL, 1043000, 1008006, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d8764ae4cca84f15628d4d13797fad6e_20250514170329A075.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/ac7c45595547332623778a0c08903253_20250514170331A076.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/97a837ff8c2adb18ab2866c9ab6988e6_20250514170333A077.jpg', NULL, 1, 1, NULL, '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:28', NULL, '0', NULL);
INSERT INTO `product` VALUES (31, '小方盒智能插线板-Pro版', NULL, 1043000, 1022000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a0d701292c4ca153e1800be83c4a7178_20250514170835A084.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a2a0e402d5aec7015c981fcf168b023f_20250514170838A085.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/67b9567cd5b8b2b14f709eca2867ecbb_20250514170840A086.jpg', NULL, 1, 1, NULL, '2025-05-14 09:11:06', NULL, '2025-05-14 09:11:12', NULL, '0', NULL);
INSERT INTO `product` VALUES (32, '平台有道口袋打印机GT1', NULL, 1043000, 1022000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5132df203926107422afc38bafe497fc_20250514171448A091.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/06c9b2cdd87daba8f79c0baa43a7f8d3_20250514171450A092.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0f6f0d72692274e53bc13d5c23c7b6a2_20250514171452A093.jpg', NULL, 1, 1, NULL, '2025-05-14 09:17:04', NULL, '2025-05-14 09:17:14', NULL, '0', NULL);
INSERT INTO `product` VALUES (33, 'MFi认证苹果快充编织数据线', NULL, 1043000, 109243035, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172008A098.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/f11fb95a2d7fff19c8de2f0f1e6ef017_20250514172011A099.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d751cc8ef4d09fcbbb4614af67a4ecae_20250514172022A100.jpg', NULL, 1, 1, NULL, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:41', NULL, '0', NULL);
INSERT INTO `product` VALUES (34, '编织纹手机壳iPhone13型号', NULL, 1043000, 109243035, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5336b359d30b57c3266a325951b19aff_20250514174616A109.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/b70c66c8bc719761b4a5b0eb1441efa6_20250514174618A110.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d83a869ac7ca083fe3e1902167f243cf_20250514174621A111.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174624A112.png', NULL, 1, 1, NULL, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:12', NULL, '0', NULL);
INSERT INTO `product` VALUES (35, '平台智造轻薄无线充电器', NULL, 1043000, 1022000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4a900e91aa877473382c51f05c1bb4aa_20250514175525A121.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/27db4ea8c0f94cb9bf64a1e258d4133d_20250514175527A122.png', NULL, 1, 1, NULL, '2025-05-14 09:58:57', NULL, '2025-05-14 09:59:06', NULL, '0', NULL);
INSERT INTO `product` VALUES (36, 'iPhone 16 Pro', NULL, 1043000, 1022000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/f02ebc247c6ff628ef7335a133b874aa_20250515024907A001.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/45c5c6c966bcd3975289dda6075ad365_20250515024911A002.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/95932aa395cda6b13c3474ef7a549e76_20250515024915A003.jpg', NULL, 1, 1, NULL, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:45', NULL, '0', NULL);
INSERT INTO `product` VALUES (37, 'ins风小碎花泡泡袖衬110-160cm', NULL, 1011000, 1020003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c07edde1047fa1bd0b795bed136c2bb2_20250523215015A001.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c883b9a86dfd70d360e33de402c520fc_20250523215018A002.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/9d1e7727ab4b1fe1a2c5bd617143b3a3_20250523215021A003.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product` VALUES (38, '经典格子元素，男童格子纯棉衬衫', NULL, 1011000, 1020003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/22cba953b8239943c6db9cd0715bc2d2_20250523215912A015.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ecdb540e124c28cbfd362d29a7d16d5e_20250523215914A016.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1a83d27811613c9721d300a229444d5c_20250523215916A017.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product` VALUES (39, '毛毛虫儿童运动鞋', NULL, 1011000, 1037006, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/b8f5434ff9a14bbf304d18527f8b2e07_20250523220714A026.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0be368b54e65771887560a501338d729_20250523220716A027.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/3ef1bfd0a82b459945373b008f434488_20250523220718A028.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product` VALUES (41, '人手必备，儿童轻薄透气防蚊裤', NULL, 1011000, 109243019, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/da7143e0103304f0f3230715003181ee_20250523225817A057.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/4f8f54366f3ebbb58240f80ed181df64_20250523225820A058.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c7737d939d54a565d412578089966ea2_20250523225822A059.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product` VALUES (42, '男式零感无压加厚保暖羽绒服', NULL, 999999, 19999999002, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ee3db25c674338a68c365c1cb6e6eea3_20250523233220A071.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0ff69c2099d98aa3cdddcb0edb9108a0_20250523233223A072.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/beac359ede3f6b4c6ab71c434f0e347d_20250523233243A073.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 15:37:06', NULL, '2025-05-23 15:38:24', NULL, '0', NULL);
INSERT INTO `product` VALUES (43, '趣玩奶酪纯PC拉链拉杆箱', NULL, 999999, 19999999002, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ee5ae3974a18a93f3f4704fe70075e10_20250523234051A084.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/2b48758a12c6646f57f296139347bbff_20250523234054A085.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/f72e17b8159ed509388656a5ebce1b56_20250523234111A086.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product` VALUES (44, '星云吉彩系列花器新年创意花瓶摆件朱炳仁', NULL, 1005000, 109243003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/f8f9de671ffb92d011ece1e97100cd47_20250523234822A098.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5143f496b0ff8230a0b55e55e14fe84c_20250523234826A099.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/4332cddfe9a26fa6854ef4fb304defb5_20250523234831A100.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 15:51:27', NULL, '2025-05-23 15:52:22', NULL, '0', NULL);
INSERT INTO `product` VALUES (45, '语音播报电子血压计', NULL, 1005000, 109293000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8f0c15f981c5cbcb1aa17215a259fa62_20250523235520A106.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1de05398deffe8095b7442f34c28c426_20250523235522A107.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/b1fa88523cc45e84ab2eb170c1153d63_20250523235524A108.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `product` VALUES (46, '女式舒软牛皮乐福鞋', NULL, 1010000, 109311005, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/a14da31cfaef44bc28a641f42c725c3f_20250523235952A113.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/29433a1a1114573cc30b0efd1fce2576_20250523235955A114.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product` VALUES (47, '软糯治愈系擦手，雪尼尔擦手球', NULL, 1013001, 1009000, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/b2ee874c5eb5e39c73bb3eae76550d47_20250524000908A119.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/0084520997d863cddd263cb10cd0c25a_20250524000910A120.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product` VALUES (48, '吸水力速干防潮天然硅藻土地垫', NULL, 1013001, 1020002, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/6d44c4f1543cfb7922840cdcae07f26a_20250524001525A125.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/0a6f0e793891ec1db4d524aa35ee167d_20250524001528A126.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product` VALUES (49, '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪', NULL, 1019000, 109309012, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/3567b2ac2526e6b89124f3fb62fd09d3_20250524002027A131.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/02dc92bae8ae03455fc277696b52566d_20250524002030A132.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2e7590b0cf91f313058a87710bee2cfc_20250524002033A133.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product` VALUES (50, '源自澳洲进口羊毛，儿童奢暖羊毛被升级款', NULL, 1019000, 109256014, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/62e38dce16f8c38c853837ca12b7d86e_20250524002615A142.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/5d1b476069935b81a584a342fc0e950a_20250524002617A143.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product` VALUES (51, '女式优雅蝴蝶结饰带浅口穆勒鞋', NULL, 1010000, 109311006, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/36cf7f601519a1c0f545d9e2a6123154_20250524003109A147.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/41a307975bd970fa9b8cba99731bc637_20250524003112A148.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/462f6762153c42ac1204b6ad394384d4_20250524003115A149.png', NULL, 1, 1, 'Audit Pass', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product` VALUES (52, '简约山形纹全棉提花毛巾', NULL, 19999999, 19999999001, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/e0cea368f41da1587b3b7fc523f169d7_20250527173924A001.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/03c70382fa9df97656cf82aa03aba065_20250527173927A002.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/05a6d60855eb61ee6b33a89e532de031_20250527173930A003.jpg', NULL, 1, 1, 'Audit Pass', '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product` VALUES (53, 'British long-handled automatic umbrella', NULL, 1005000, 1005999003, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/aa96b4e566868d70adf6f78f29301b7c_20250529150324A002.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/14f3f3973560fa442bf2e63783b3b3ac_20250529150329A003.png', NULL, 1, 1, 'Audit Pass', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product` VALUES (55, 'Nike Sport Shoes', NULL, 1010000, 109311005, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES_20250730202803A010.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202806A011.webp', NULL, 1, 1, 'Audit Pass', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product` VALUES (56, 'Nike Sport Shoes', NULL, 1010000, 109311005, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801015620A002.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-WHITE_20250801015623A003.webp', NULL, 1, 1, 'Audit Pass', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product` VALUES (57, 'Nike Sport Shoes', NULL, 1010000, 109311005, NULL, NULL, NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801020845A009.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020848A010.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-WHITE_20250801020850A011.webp', NULL, 1, 1, 'Audit Pass', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);

-- ----------------------------
-- Table structure for product_details
-- ----------------------------
DROP TABLE IF EXISTS `product_details`;
CREATE TABLE `product_details`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `image_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '详情图片地址',
  `commentCount` bigint NULL DEFAULT NULL COMMENT '评价数量',
  `collectCount` bigint NULL DEFAULT NULL COMMENT '收藏数量\r\n',
  `properties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品属性集合\r\n',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品sku属性表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_details
-- ----------------------------
INSERT INTO `product_details` VALUES (4, 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/e5a9f569-accc-4006-9064-2180e7f2b691.jpg,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/e5a9f569-accc-4006-9064-2180e7f2b691.jpg,http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/fcc3e819-87b7-4e3c-8717-4fa1eda492bf.jpg', NULL, NULL, '{\"执行标准\": \"GB4706.1 - 2005\", \"额定电压功率\": \"120V 50/60Hz 1200W\"}', '2025-05-01 11:34:27', NULL, '2025-05-09 14:44:56', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (5, 5, NULL, NULL, NULL, '{\"电压可变\":\"220V\", \"额定电压功率\":\"220V-240V 50/60Hz 1200W-1500W\", \"执行标准\":\"GB17625.1-2012\"}', '2025-05-03 04:10:27', NULL, '2025-05-03 04:10:27', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (10, 11, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/4a5c88cbe9cbca4e909e0acf9a65a00a_20250507004421A016.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5b56073d2e6a05b8f887541d9e28f6fd_20250507004426A017.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f2125fdc90fc3c03b92308fdbe3d04e2_20250507004429A018.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2977ba84b7a98207019b34e265bcef12_20250507004432A019.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/c4cb6da32cbb3e9656700dbf1673412d_20250507004434A020.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/bda5c3576b4bee8e961418d5d028ca83_20250507004437A021.jpg', NULL, NULL, '{\"适用猫龄\":\"幼猫（2个月-12个月）\",\"保质期\":\"12个月\",\"产地\":\"安徽省宣城市\"}', '2025-05-06 16:44:38', NULL, '2025-05-09 09:16:13', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (11, 12, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/cb0375fe7a637a5ac14c1749e9944276_20250507010040A027.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/40981a4f4957bb441a5c890b54ec1648_20250507010044A028.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/c58b6b7712d81578846ca1f1183376fc_20250507010047A029.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/c201b6c33c059b660a51e3cc763c5763_20250507010049A030.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f884d78f290be4a28c083de84ea56bd9_20250507010052A031.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e9b6d445e8b519fd79c4d0649f35b567_20250507010106A032.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/26c0a3c3aae541a23fa2e8f4cfb26504_20250507010118A033.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f062c58f7ff8654a4ea3ea0d3cd39b6b_20250507010131A034.jpg', NULL, NULL, '{\"材质\":\"塑料\",\"适用场景\":\"衣橱、桌面、客厅、卧室、居家、家居日用\"}', '2025-05-06 17:02:13', NULL, '2025-05-09 09:17:23', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (12, 13, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e552eef27662de3a63de087c3d0fda90_20250507011753A039.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/47e440b17ead084b4a35006b69913e2d_20250507011757A040.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/990dda997bd1545e47a16d5fb044da7a_20250507011759A041.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/05dd3e97ea7b6cee47744bc683227f51_20250507011802A042.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/ba5838920b02f616104fa2cf34282563_20250507011805A043.jpg', NULL, NULL, '{\"包装\":\"罐装\",\"保质期\":\"360天\",\"口味\":\"原味\"}', '2025-05-06 17:18:51', NULL, '2025-05-09 09:21:04', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (13, 14, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f826308518d86fa7b9b82bbb3283d2a5_20250507012141A047.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/a11618cfc41a3c8e23d814ead8ebb772_20250507012144A048.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/8d1a2ad71177468d3019beab5dc4d8e8_20250507012146A049.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/bb13adda79a09afc12fc6326e2542bbd_20250507012148A050.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/80552e4c90ee0b865f9b7baeeea89d65_20250507012151A051.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/c89248dee57d6586c9001f71171dfcb0_20250507012238A052.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/41dd91e80bee1a38d4a8a603cba2b76c_20250507012242A053.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0ccec64a70005984200d433100a893c5_20250507012258A054.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/a03c50ce860120151cfad7dcc789116b_20250507012308A055.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/67ce62df7ad3466e06e9dff74a090890_20250507012319A056.jpg', NULL, NULL, '{\"配料表\":\"通芯白莲\",\"贮存条件\":\"避光、阴凉、干燥处\",\"口味\":\"原味\"}', '2025-05-06 17:24:06', NULL, '2025-05-09 09:27:55', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (14, 15, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3f256fa58a450afd5451b3692d5d4900_20250507012900A063.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/757a43c3347b27944b995cab8ffabd66_20250507012904A064.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e71a55d4348f793e2a81801e39a081cd_20250507012907A065.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/15b537d0b3832f9c919948fc06d98a36_20250507012909A066.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/8d7b572575576843e5e814f7edebe490_20250507012913A067.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/b59e8f40511cb9d3e6824d91341437ce_20250507012924A068.jpg', NULL, NULL, '{\"固形物含量\":\"不低于70%\",\"贮存条件\":\"常温保存，避免高温和强光直射，开封后需冷藏\"}', '2025-05-06 17:30:11', NULL, '2025-05-09 09:30:01', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (15, 16, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/296239f0195e7809648c9983223fab74_20250507013403A074.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d83323945dfd3eb7af5a9484c20ae525_20250507013405A075.jpg', NULL, NULL, '{\"产地\":\"重庆\",\"贮存条件\":\"常温避光保存，开瓶后需冷藏\"}', '2025-05-06 17:35:03', NULL, '2025-05-09 09:31:05', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (16, 17, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5ed2d44dece206ee05fd0427769d3bf4_20250507014034A079.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3131aad664447f3bc79665424aa4e8a2_20250507014036A080.jpg', NULL, NULL, '{\"产地\":\"广西桂林\",\"种类\":\"米粉\",\"食用方法\":\"冲泡\"}', '2025-05-06 17:41:22', NULL, '2025-05-09 09:31:58', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (17, 18, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/f2d2f5e9303d1befa9f8b7cd606d1f17_20250507014437A086.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/110cd0fd0bae09e9d25f4eb619965f55_20250507014439A087.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e50f7b517b933c5fa1e45af6d2f49b84_20250507014442A088.png', NULL, NULL, '{\"食用建议\":\"1、建议搭配白粥、米饭、或烹煮菜肴食用；↵2、寒冷环境会导致咸鸭蛋部分脂肪凝固，建议在食用前加热3-5分钟。\",\"产地\":\"江苏扬州高邮\",\"配料表\":\"鲜鸭蛋、食用盐、饮用水\"}', '2025-05-06 17:45:29', NULL, '2025-05-09 09:32:19', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (18, 19, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d8080471f3ac8297697e387caa0f6063%20(1)_20250507015057A099.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507015100A100.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/878dccca13bfe11ad727d5ef6457ebb8_20250507015103A101.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/715f54319afc7a18bd3baefbc08e91e0_20250507015111A102.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/98dd17e466bcee6f90c11455c5a169da_20250507015119A103.jpg', NULL, NULL, '{\"包装\":\"袋装\",\"贮存条件\":\"阴凉干燥处，开袋后请尽快食用\",\"品名\":\"黄金玉粟粥米\"}', '2025-05-06 17:52:13', NULL, '2025-05-09 09:32:39', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (19, 20, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/e612e9f397c12b72766dcd68c46556fa_20250507020800A107.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5cfbc87a657c5b69586fb04606352aee_20250507020802A108.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/34fe2e6718c1817c09a47701499a4e29_20250507020804A109.png', NULL, NULL, '{\"原料产地\":\"贵州省黔西南州兴仁县\",\"包装\":\"袋装\"}', '2025-05-06 18:08:50', NULL, '2025-05-09 09:33:14', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (20, 21, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/163063c82dc7efa80dc8ab964a56ce49_20250509175937A005.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/bb7a440a6aedb8971bcc4b3c7a1faf14_20250509175952A006.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/c8b65a5794f83bfdf924e421b0a01d6d_20250509175954A007.jpg', NULL, NULL, '{\"功能\":\"收纳\",\"材质\":\"头层牛皮\",\"风格\":\"时尚\"}', '2025-05-09 10:00:44', NULL, '2025-05-09 10:00:44', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (21, 22, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/6c856dd324a48024bea9fcd59b7e08fb_20250514154624A005.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/81a87274c19901c1c4fdc955b0d2566d_20250514154626A006.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c862c1895af963d92d93af798624e726_20250514154629A007.png', NULL, NULL, '{\"适用人群\":\"通用\",\"适用场景\":\"综合练习\"}', '2025-05-14 07:47:16', NULL, '2025-05-14 07:47:16', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (22, 23, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/aa9f87f2e44f1e2a84b1ce24a97a8ab4_20250514155411A011.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/67224ced0de277474bf83444e7cc5427_20250514155413A012.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/cff9e046c1dede909aa4908da669c0ac_20250514155416A013.png', NULL, NULL, '{\"适用场景\":\"有氧\",\"温馨提示\":\"非质量问题退换货说明：产品、配件、说明书、包装应保持完好，产品未安装、未使用。\",\"适用人群\":\"通用\"}', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (23, 24, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/574703105b5231a0e8c112c50a62678f_20250514160242A021.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/45ecc08a016820a3b4e9ceac790a1721_20250514160244A022.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/13de842b6be03637549f1d82eafdfc75_20250514160247A023.jpg', NULL, NULL, '{\"适用场景\":\"力量练习、综合练习、有氧\",\"适用人群\":\"通用\"}', '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (24, 25, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/7379fb14ef1fdf6858ec9f61c3d6ef29_20250514160841A030.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5919ec7d886ecf3d3768210601d7309d_20250514160843A031.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1f38fb7094c06f392fc42c2d329cb72b_20250514160845A032.jpg', NULL, NULL, '{\"适用场景\":\"综合练习\",\"适用人群\":\"通用\"}', '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (25, 26, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5ecfef888f58be38abdad9fbab3bdac1_20250514161317A036.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/8ba0d65a6f4d1790f23d93d92d3cd0fa_20250514161320A037.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/ef6c63d736f6b8143af8d0c32eab7593_20250514161322A038.png', NULL, NULL, '{\"适用场景\":\"力量练习、腰腹练习、综合练习\",\"适用人群\":\"通用\"}', '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (26, 27, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/6ea4b26d971b510d5ca91b292524a473_20250514161923A045.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bbdf5c675106ebd4c6edc3fb3537794f_20250514161925A046.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bac289739c817cbe94dd0cd208e52219_20250514161927A047.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dee8db90cdb9f395f4821167e79a9b02_20250514161931A048.jpg', NULL, NULL, '{\"温馨提示\":\"本产品无法完全平铺，外观是扭曲的三维环状，此设计是属于多功能特殊设计，根据佩戴方法可以用作面罩、围脖、头巾使用。\"}', '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (27, 28, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/79b9c0f861c43fe919e274edf56e5fbd_20250514164221A060.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d8c7e112d893a0aa05f8da83c882a87d_20250514164224A061.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/52ab6ad07a46433cd9ef55512f981adb_20250514164226A062.png', NULL, NULL, '{\"关于触屏功能\":\"穿戴时手指要与触屏材料底部接触，滑屏幕时，手指触屏部位要与屏幕直接接触。触屏灵敏度在手机自身情况，天气，温度，以及个人体感上有不同差异。\"}', '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (28, 29, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/b93e26c24db25be60a15f5492eac9cac_20250514165537A070.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/cf729cca9b6bf4ee5d161697fb4ad098_20250514165539A071.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/29be4eba86aa7816e967475b782408bd_20250514165541A072.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/877a4c7f92d560dd6f34176be997f3b5_20250514165548A073.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/80a3ec5c68f474b1c12720461b7fca10_20250514165551A074.png', NULL, NULL, '{\"蓝牙版本\":\"蓝牙5.2\",\"连接距离\":\"10米（无障碍空旷环境）\",\"电池\":\"420mAh3.7V耳机仓\",\"续航时间（音乐）\":\"7小时（50%音量）35小时（带充电盒）\"}', '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (29, 30, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/97a837ff8c2adb18ab2866c9ab6988e6_20250514170442A080.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/f33f8281b619d7f5a01db2196615836f_20250514170508A081.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/9a0622d860f998d8b52d45363ba36c38_20250514170511A082.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1d4d1b74eeb49fa92fb189c7925c416a_20250514170516A083.png', NULL, NULL, '{\"额定功率\":\"1/3mW\",\"温馨提示\":\"该商品直接接触双耳，一经开封，如无质量问题不予退换\"}', '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:18', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (30, 31, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/67b9567cd5b8b2b14f709eca2867ecbb_20250514170946A088.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/f19041fbf2848f0e80f3b5899aaf90ab_20250514170949A089.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dd36407685af410bf25e1f6bc89a7f74_20250514170951A090.png', NULL, NULL, '{\"产品材质\":\"阻燃材料\",\"AC插孔数\":\"新国标5孔*2\",\"USB充电数\":\"USB充电接口*3\",\"产品尺寸\":\"105*86*30mm\",\"额定功率\":\"2500W\"}', '2025-05-14 09:11:06', NULL, '2025-05-14 09:11:06', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (31, 32, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0f6f0d72692274e53bc13d5c23c7b6a2_20250514171619A095.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/8c8addacd74fa0ecce4257ed8dcd20db_20250514171621A096.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/b9eb1f1e5e6b21ffd519c9880ffeaf4e_20250514171624A097.png', NULL, NULL, '{\"品牌\":\"本产品为有道品牌\"}', '2025-05-14 09:17:04', NULL, '2025-05-14 09:17:04', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (32, 33, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d751cc8ef4d09fcbbb4614af67a4ecae_20250514172439A106.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/8ce4c2d37fa77397244c5ad18a888ee2_20250514172442A107.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/18ce8eaea050b66fdc9ad8b07f48137f_20250514172444A108.png', NULL, NULL, '{\"商品清单\":\"数据线*1，包装吸塑*1；包装盒*1\",\"线身材质\":\"尼龙编织\",\"电流\":\"2.4A(Max)↵非PD快充数据线\"}', '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (33, 34, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/b70c66c8bc719761b4a5b0eb1441efa6_20250514174858A117.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5ce0d1060ecfa56c050e0c86ed993356_20250514174901A118.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/72a1a1e0443916825b593d950fe4b6c0_20250514174903A119.png', NULL, NULL, '{\"功能\":\"防摔\",\"厚度\":\"超薄\",\"商品清单\":\"手机壳*1，包装吸塑*1，包装盒*1\"}', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (34, 35, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/27db4ea8c0f94cb9bf64a1e258d4133d_20250514175739A123.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/acea02370170626d125cfe7ceb8c5fe6_20250514175741A124.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1ebc69ea40e6f67cb616d70799377467_20250514175743A125.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4a900e91aa877473382c51f05c1bb4aa_20250514175755A126.png', NULL, NULL, '{\"适用场景\":\"外出、家居\",\"适用机型\":\"苹果系列：iPhoneX/Xs/Xr/XsMax/11/11Pro/11ProMax/12mini/12/12pro/12promax\"}', '2025-05-14 09:58:57', NULL, '2025-05-14 09:58:57', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (35, 36, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/95932aa395cda6b13c3474ef7a549e76_20250515025449A008.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/45c5c6c966bcd3975289dda6075ad365_20250515025454A009.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025501A010.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/3283cf8419f0580adbaa667978b9aa3b_20250515025503A011.png', NULL, NULL, '{\"芯片\":\"A18Pro\", \"尺寸\":\"6.3英寸\",\"材质\":\"钛金属\"}', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (36, 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/9d1e7727ab4b1fe1a2c5bd617143b3a3_20250523215423A010.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c4b839724ea0c590948e27d6b5a62247_20250523215451A011.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ae9e8844d018e4c6db3964c2b1584dcd_20250523215453A012.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215456A013.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/178cfeab8e0ddff3c0511e3bafcdb5c4_20250523215459A014.png', NULL, NULL, '{\"适用年龄\":\"6-9岁、3-6岁、1-3岁\",\"适用季节\":\"夏\"}', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (37, 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1a83d27811613c9721d300a229444d5c_20250523220216A021.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/121c2e9978766dce2593489adf94c969_20250523220218A022.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8fea973176f18e95dafb56beb8c30ba9_20250523220222A023.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220225A024.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ecdb540e124c28cbfd362d29a7d16d5e_20250523220231A025.jpg', NULL, NULL, '{\"适用年龄\":\"6-9岁、3-6岁、1-3岁、0-1岁\",\"适用季节\": \"秋、春秋\",\"材质\":\"纯棉\"}', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (38, 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ead8e80fb30249179e46c8984b0a4e9b_20250523221112A035.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/3ef1bfd0a82b459945373b008f434488_20250523221115A036.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/17a67dcdc588738839032d930368bca8_20250523221117A037.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523221120A038.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/7b352bebd64535458903049fe84ab88d_20250523221122A039.png', NULL, NULL, '{\"适用年龄\":\"9-12岁、6-9岁、3-6岁、1-3岁\",\"适用季节\":\"春、秋\",\"安全类别\":\"GB30585-2014儿童鞋安全技术规范\"}', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (40, 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5736a17d90161535c89ce6462b1397f3_20250523230136A066.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/b4ee63ce5c5dcac182111ef3a1715a5d_20250523230138A067.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c7737d939d54a565d412578089966ea2_20250523230142A068.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230145A069.png', NULL, NULL, '{\"适用年龄\":\"9-12岁、6-9岁、3-6岁、1-3岁、0-1岁\",\"适用季节\":\"春、秋、夏\"}', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (41, 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/ee3db25c674338a68c365c1cb6e6eea3_20250523233555A080.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/6237a63e2036f70b8f5b691017237f4d_20250523233559A081.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233601A082.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/11f8eac1ad6c44a0ae8a3932257ab811_20250523233605A083.png', NULL, NULL, '{\"版型\":\"宽松型\",\"功能\":\"保暖、超轻\",\"充绒量\":\"S：171g，M：180g，L：190g，XL：199g，XXL：210g\",\"适用季节\":\"冬、秋\"}', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (42, 43, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/abf693b29b1ba9cb50211be4dc262c9a_20250523234401A091.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/540c9c4759ecae301c42b894ce1d8b42_20250523234405A092.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/2b48758a12c6646f57f296139347bbff_20250523234409A093.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234414A094.png', NULL, NULL, '{\"材质\":\"PC\",\"开合方式\":\"拉链开合\"}', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (43, 44, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/4332cddfe9a26fa6854ef4fb304defb5_20250523235042A103.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e727b40aa867db82ad01c5459d27183e_20250523235045A104.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8a124556234b6dcfe404be40d9e89fae_20250523235047A105.jpg', NULL, NULL, '{\"场景\":\"办公、客厅、餐厅、卧室、进户、阳台/庭院\",\"材质\":\"铜\"}', '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (44, 45, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33524344342b4b64998a912ab67774a5_20250523235617A109.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/43b4353ee813218179aea24e325bab93_20250523235620A110.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/b1fa88523cc45e84ab2eb170c1153d63_20250523235622A111.jpg', NULL, NULL, '{\"款式\":\"臂式\",\"医疗器械注册证\":\"津械注准20192070082\",\"生产企业生产许可证号\":\"津食药监械生产许20100115号\"}', '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (45, 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/12216e1160aeec6b73ff46d010c70981_20250524000212A115.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/848f1b64e63564c8b2b769019e1769a9_20250524000214A116.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/29433a1a1114573cc30b0efd1fce2576_20250524000216A117.png', NULL, NULL, '{\"适用人群\":\"女士\",\"跟高类型\":\"低跟\",\"材质\":\"头层真皮\"}', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (46, 47, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/a431753eadc479444c539ce50bc1fb72_20250524001032A121.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/0084520997d863cddd263cb10cd0c25a_20250524001118A122.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524001121A123.png', NULL, NULL, '{\"材质描述\":\"100%聚酯纤维\",\"安全类别\":\"GB18401-2010B类\"}', '2025-05-23 16:12:11', NULL, '2025-05-23 16:13:28', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (47, 48, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/301021db135ff1ed7d1c1df005c0b425_20250524001732A127.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2e82201587157ad4d271d0cf27adebda_20250524001734A128.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/0a6f0e793891ec1db4d524aa35ee167d_20250524001737A129.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/6d44c4f1543cfb7922840cdcae07f26a_20250524001741A130.png', NULL, NULL, '{\n\"材质\":\"硅藻土\",\"温馨提示\":\"本产品由天然材质制作而成，产品之间会有色差，敬请理解\"}', '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (48, 49, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/6591ff1177c696ca98d646df1733919b_20250524002309A136.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/caf310ac5e2a3db17cca3824e5a6eacc_20250524002311A137.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2e7590b0cf91f313058a87710bee2cfc_20250524002315A138.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/782611ae57b0dd10283f40f0f7d48be3_20250524002317A139.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/8f945c11e702f84bffc14416c3e51c43_20250524002320A140.png', NULL, NULL, '{\"产品净重\":\"284g\",\"除毛部位\":\"全身\",\"电源方式\":\"插电式\"}', '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (49, 50, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/9749ae80e9ba3d7da62f6574ce15acc2_20250524002743A144.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/e6bef68494c5ba85e5940e131202aa60_20250524002746A145.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/5d1b476069935b81a584a342fc0e950a_20250524002749A146.jpg', NULL, NULL, '{\"适用季节\":\"冬、秋\",\"安全技术\":\"GB31701-2015A类婴幼儿用品\"}', '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (50, 51, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/14dd00777290de576fc114a4c116198c_20250524003330A153.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be72b8f0f537081f085e4d672961df05_20250524003332A154.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003334A155.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/462f6762153c42ac1204b6ad394384d4_20250524003338A156.png', NULL, NULL, '{\"适用季节\":\"春季、夏季、秋季\",\"鞋头款式\":\"方头\",\"跟高类型\":\"低跟\"}', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (51, 52, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/a082d4d6aca7878ac98b5126315bcac5_20250527174211A006.jpg,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/777320cf094283725940c7b6b3395d3a_20250527174214A007.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/05a6d60855eb61ee6b33a89e532de031_20250527174217A008.jpg', NULL, NULL, '{\"功能\":\"其他\",\"风格\":\"北欧\",\"材质\":\"纯棉、长绒棉\"}', '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (52, 53, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/8bf0b8e3f3569373beb617f3157247c6_20250529150509A006.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/94ad509815e28a1685a105fc60b36731_20250529150512A007.png', NULL, NULL, '{\"Style\":\" Long Handle \",\"Functional Attribute\":\" Suitable for both sunny and rainy days \",\"Type\":\" Umbrella \"}\n', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (53, 54, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES_20250730201651A007.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730201657A008.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730201700A009.webp', NULL, NULL, '{\"Brand\":\"Nike\", \"Place of Origin\":\"Vietnam\", \"Size\":\"US 10 / EU 44\"}\n', '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (54, 55, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES_20250730202910A014.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202913A015.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730202916A016.webp', NULL, NULL, '{\"Brand\":\"Nike\", \"Place of Origin\":\"Vietnam\", \"Size\":\"US 10 / EU 44\"}\n', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (55, 56, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015735A006.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801015737A007.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-WHITE_20250801015740A008.webp', NULL, NULL, '{\"Brand\":\"Nike\", \"Place of Origin\":\"Vietnam\", \"Size\":\"US 10 / EU 44\"}\n', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_details` VALUES (56, 57, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801021004A014.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801021006A015.webp,https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-WHITE_20250801021011A016.webp', NULL, NULL, '{\"Brand\":\"Nike\", \"Place of Origin\":\"Vietnam\", \"Size\":\"US 10 / EU 44\"}\n', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);

-- ----------------------------
-- Table structure for product_sku
-- ----------------------------
DROP TABLE IF EXISTS `product_sku`;
CREATE TABLE `product_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sku_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编号',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品ID',
  `thumb_img` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '缩略图路径',
  `sale_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '售价',
  `market_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '市场价',
  `cost_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '成本价',
  `discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '折扣',
  `sku_spec` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'sku规格信息json',
  `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '重量',
  `volume` decimal(10, 2) NULL DEFAULT NULL COMMENT '体积',
  `status` tinyint NULL DEFAULT NULL COMMENT '线上状态：0-初始值，1-上架，-1-自主下架',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品sku' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_sku
-- ----------------------------
INSERT INTO `product_sku` VALUES (1, '1_0', '小米 红米Note10 5G手机 白色 + 8G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-5_u_1.jpg', 1990.00, 2019.00, 1599.00, NULL, '白色 + 8G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (2, '1_1', '小米 红米Note10 5G手机 白色 + 18G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-6_u_1.jpg', 2990.00, 3019.00, 2599.00, NULL, '白色 + 18G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (3, '1_2', '小米 红米Note10 5G手机 红色 + 8G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-4_u_1.jpg', 1999.00, 2019.00, 1599.00, NULL, '红色 + 8G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (4, '1_3', '小米 红米Note10 5G手机 红色 + 18G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-5_u_1%20(1).jpg', 2999.00, 3019.00, 2599.00, NULL, '红色 + 18G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (5, '1_4', '小米 红米Note10 5G手机 黑色 + 8G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-1_u_1.jpg', 1999.00, 2019.00, 1599.00, NULL, '黑色 + 8G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (6, '1_5', '小米 红米Note10 5G手机 黑色 + 18G', 1, 'http://139.198.127.41:9000/spzx/20230525/665832167-3_u_1.jpg', 2999.00, 3019.00, 2599.00, NULL, '黑色 + 18G', 1.00, 1.00, 1, '2023-05-25 14:21:07', NULL, '2025-01-24 12:32:18', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (7, '2_0', '华为笔记本 8G', 2, 'http://139.198.127.41:9000/spzx/20230525/4b5a68a9bfbd0795.jpg.avif', 3999.00, 3999.00, 3999.00, NULL, '8G', 1.00, 2.00, 1, '2023-05-25 15:18:28', NULL, '2025-01-24 12:37:53', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (8, '2_1', '华为笔记本 16G', 2, 'http://139.198.127.41:9000/spzx/20230525/35b3b7e2e67b98b2.jpg.avif', 4999.00, 4999.00, 4999.00, NULL, '16G', 1.00, 2.00, 1, '2023-05-25 15:18:28', NULL, '2025-01-24 12:37:53', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (9, '2_2', '华为笔记本 32G', 2, 'http://139.198.127.41:9000/spzx/20230525/c8f2eae0d36b6270.jpg.avif', 5999.00, 5999.00, 5999.00, NULL, '32G', 1.00, 2.00, 1, '2023-05-25 15:18:28', NULL, '2025-01-24 12:37:53', NULL, '2', NULL);
INSERT INTO `product_sku` VALUES (10, '3_0', 'Xiaomi 15 Pro 16GB + White', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.377145_20250124203433A015.png', 3999.00, 4599.00, 2000.00, NULL, '16GB + White', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:10:43', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (11, '3_1', 'Xiaomi 15 Pro 16GB +  Green', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.32273950_20250124203411A014.png', 3999.00, 4599.00, 2000.00, NULL, '16GB +  Green', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:10:43', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (12, '3_2', 'Xiaomi 15 Pro 16GB +  Black', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.35678660_20250124203440A016.png', 3999.00, 4599.00, 2000.00, NULL, '16GB +  Black', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:10:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (13, '3_3', 'Xiaomi 15 Pro 32GB + White', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.377145_20250124203447A017.png', 4599.00, 4999.00, 2500.00, NULL, '32GB + White', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:10:45', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (14, '3_4', 'Xiaomi 15 Pro 32GB +  Green', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.32273950_20250124203450A018.png', 4599.00, 4999.00, 2500.00, NULL, '32GB +  Green', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:10:46', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (15, '3_5', 'Xiaomi 15 Pro 32GB +  Black', 3, 'http://192.168.1.12:5787/pocket/2025/01/24/pms_1698307430.35678660_20250124203452A019.png', 4599.00, 4999.00, 2500.00, NULL, '32GB +  Black', 5.00, 10.00, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:11:07', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (16, '4_0', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 180.00, 200.00, 150.00, 20.00, '蓝色 + 20cm + 中国', 1.00, 1.00, 1, '2025-05-01 16:30:42', NULL, '2025-05-03 17:13:47', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (17, '4_1', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 180.00, 200.00, 150.00, 20.00, '黑色 + 20cm + 中国', 1.00, 1.00, 1, '2025-05-01 16:31:14', NULL, '2025-05-03 17:13:49', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (18, '4_2', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 150.00, 180.00, 120.00, 30.00, '蓝色 + 10cm + 中国', 1.00, 1.00, 1, '2025-05-01 16:35:09', NULL, '2025-05-03 19:24:19', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (19, '4_3', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 150.00, 180.00, 120.00, 30.00, '黑色 + 10cm + 中国', 1.00, 1.00, 1, '2025-05-01 16:36:00', NULL, '2025-05-03 17:13:51', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (20, '4_4', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 200.00, 220.00, 180.00, 20.00, '蓝色 + 10cm + 日本', 1.00, 1.00, 1, '2025-05-01 16:36:59', NULL, '2025-05-03 17:13:52', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (21, '4_5', '钻石陶瓷涂层多用锅18cm 小奶锅', 4, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 200.00, 220.00, 180.00, 20.00, '黑色 + 10cm + 日本', 1.00, 1.00, 1, '2025-05-01 16:38:56', NULL, '2025-05-03 17:13:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (22, '5_0', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 150.00, 180.00, 120.00, 30.00, '黑色 + 30cm + 日本', 1.00, 1.00, 1, '2025-05-03 04:12:08', NULL, '2025-05-03 17:14:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (23, '5_1', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 120.00, 150.00, 90.00, 30.00, '黑色 + 10cm + 日本', 1.00, 1.00, 1, '2025-05-03 04:13:41', NULL, '2025-05-03 17:14:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (24, '5_2', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 180.00, 200.00, 150.00, 20.00, '黑色 + 30cm + 中国', 1.00, 1.00, 1, '2025-05-03 04:14:57', NULL, '2025-05-03 17:14:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (25, '5_3', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png', 150.00, 180.00, 120.00, 30.00, '黑色 + 10cm + 中国', 1.00, 1.00, 1, '2025-05-03 04:16:24', NULL, '2025-05-03 17:14:10', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (26, '5_4', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 150.00, 180.00, 120.00, 30.00, '蓝色 + 30cm + 日本', 1.00, 1.00, 1, '2025-05-03 04:17:32', NULL, '2025-05-03 17:14:11', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (27, '5_5', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 120.00, 150.00, 90.00, 30.00, '蓝色 + 10cm + 日本', 1.00, 1.00, 1, '2025-05-03 04:18:03', NULL, '2025-05-03 17:14:12', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (28, '5_6', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 180.00, 200.00, 150.00, 20.00, '蓝色 + 30cm + 中国', 1.00, 1.00, 1, '2025-05-03 04:18:42', NULL, '2025-05-03 17:14:13', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (29, '5_7', '极光限定 珠光蓝珐琅锅', 5, 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png', 150.00, 180.00, 120.00, 30.00, '蓝色 + 10cm + 中国', 1.00, 1.00, 1, '2025-05-03 04:19:23', NULL, '2025-05-03 17:14:14', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (47, '11_0', '全面助力发育，全价幼猫粮（阶段）1.8千克 5.4千克/袋', 11, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004247A013.png', 100.00, 120.00, 80.00, 20.00, '5.4千克/袋', 1.00, 1.00, 0, '2025-05-06 16:44:38', NULL, '2025-05-09 09:34:35', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (48, '11_1', '全面助力发育，全价幼猫粮（阶段）1.8千克 1.8千克/袋', 11, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004307A014.png', 80.00, 100.00, 60.00, 20.00, '1.8千克/袋', 1.00, 1.00, 0, '2025-05-06 16:44:38', NULL, '2025-05-09 09:35:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (49, '11_2', '全面助力发育，全价幼猫粮（阶段）1.8千克 120克', 11, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004309A015.png', 30.00, 50.00, 20.00, 20.00, '120克', 1.00, 1.00, 0, '2025-05-06 16:44:38', NULL, '2025-05-09 09:35:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (50, '12_0', '爆款明星好物，抽屉式透明储物柜 M400*500*235mm47L两只装', 12, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/51d2923b578d8721f2beeb5709398a5e_20250507005827A025.png', 138.00, 158.00, 120.00, 20.00, 'M400*500*235mm47L两只装', 1.00, 1.00, 0, '2025-05-06 17:02:13', NULL, '2025-05-09 09:35:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (51, '12_1', '爆款明星好物，抽屉式透明储物柜 S400*500*180mm36L四只装', 12, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/4f7d7da492cf5c9241484a7525795fdf_20250507005841A026.png', 228.00, 248.00, 188.00, 20.00, 'S400*500*180mm36L四只装', 1.00, 1.00, 0, '2025-05-06 17:02:13', NULL, '2025-05-09 09:35:42', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (52, '13_0', '若羌红枣脆片138克 138克', 13, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg', 18.00, 28.00, 10.00, 10.00, '138克', 1.00, 1.00, 0, '2025-05-06 17:18:51', NULL, '2025-05-09 09:35:50', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (53, '13_1', '若羌红枣脆片138克 238克', 13, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg', 28.00, 38.00, 20.00, 10.00, '238克', 1.00, 1.00, 0, '2025-05-06 17:18:51', NULL, '2025-05-09 09:36:04', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (54, '14_0', '无芯软糯的萌妹子，建宁莲子228克 118克', 14, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 35.00, 45.00, 25.00, 10.00, '118克', 1.00, 1.00, 0, '2025-05-06 17:24:06', NULL, '2025-05-09 09:36:16', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (55, '14_1', '无芯软糯的萌妹子，建宁莲子228克 228克', 14, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 45.00, 55.00, 35.00, 10.00, '228克', 1.00, 1.00, 0, '2025-05-06 17:24:06', NULL, '2025-05-09 09:36:20', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (56, '15_0', '香菇肉燥酱375克（75克*5袋） 香菇肉燥酱375克（75克*5袋）', 15, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/aada32c857b5e6137969352cbb0ce8f4_20250507012736A062.png', 27.00, 37.00, 17.00, 10.00, '香菇肉燥酱375克（75克*5袋）', 1.00, 1.00, 0, '2025-05-06 17:30:11', NULL, '2025-05-09 09:36:38', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (57, '15_1', '香菇肉燥酱375克（75克*5袋） 微辣香菇酱375克（75克*5袋）', 15, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/8eef8bb7f562421f78c2ffe88ae0600f_20250507012717A061.png', 45.00, 45.00, 25.00, 10.00, '微辣香菇酱375克（75克*5袋）', 1.00, 1.00, 0, '2025-05-06 17:30:11', NULL, '2025-07-27 19:28:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (58, '15_2', '香菇肉燥酱375克（75克*5袋） 原味香菇酱375克（75克*5袋）', 15, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/980b1b3cb856ad0e148783208a256619_20250507012650A060.png', 39.00, 49.00, 29.00, 10.00, '原味香菇酱375克（75克*5袋）', 1.00, 1.00, 0, '2025-05-06 17:30:11', NULL, '2025-05-09 09:36:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (59, '16_0', '川味牛肉辣椒酱190克 川味果蔬辣椒酱190克', 16, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e3cccdd9f7f980e8276ddf82d99ec60_20250507013220A072.png', 26.00, 33.00, 18.00, 7.00, '川味果蔬辣椒酱190克', 1.00, 1.00, 0, '2025-05-06 17:35:03', NULL, '2025-05-09 09:37:01', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (60, '16_1', '川味牛肉辣椒酱190克 川味牛肉辣椒酱190克', 16, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/be9af2aed2387a44f0bafd5766948c52_20250507013237A073.png', 29.00, 36.00, 22.00, 7.00, '川味牛肉辣椒酱190克', 1.00, 1.00, 0, '2025-05-06 17:35:03', NULL, '2025-05-09 09:37:10', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (61, '17_0', '现泡免煮，螺蛳粉370克*6盒 370克*6盒', 17, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/65256152984021cfb766c4856f2307d8_20250507013829A076.jpg', 58.00, 65.00, 45.00, 7.00, '370克*6盒', 1.00, 1.00, 0, '2025-05-06 17:41:22', NULL, '2025-05-09 09:37:22', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (62, '17_1', '现泡免煮，螺蛳粉370克*6盒 570克*6盒', 17, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/65256152984021cfb766c4856f2307d8_20250507013829A076.jpg', 88.00, 85.00, 74.00, -3.00, '570克*6盒', 1.00, 1.00, 0, '2025-05-06 17:41:22', NULL, '2025-05-09 09:37:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (63, '18_0', '富到流油的高邮咸鸭蛋 75克*10枚', 18, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014323A084.png', 45.00, 58.00, 40.00, 13.00, '75克*10枚', 1.00, 1.00, 0, '2025-05-06 17:45:29', NULL, '2025-05-09 09:37:35', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (64, '18_1', '富到流油的高邮咸鸭蛋 75克*20枚', 18, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014325A085.png', 70.00, 88.00, 65.00, 18.00, '75克*20枚', 1.00, 1.00, 0, '2025-05-06 17:45:29', NULL, '2025-05-09 09:37:43', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (65, '19_0', '黄金玉粟粥米 500克', 19, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014923A097.png', 28.00, 35.00, 20.00, 7.00, '500克', 1.00, 1.00, 0, '2025-05-06 17:52:13', NULL, '2025-05-09 09:37:51', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (66, '19_1', '黄金玉粟粥米 1000克', 19, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014921A096.png', 43.00, 48.00, 30.00, 5.00, '1000克', 1.00, 1.00, 0, '2025-05-06 17:52:13', NULL, '2025-05-09 09:37:59', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (67, '20_0', '贵州兴仁薏仁米600克 600克', 20, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3e93790bba8db8aab54ee5ba72799567_20250507020547A104.png', 27.00, 35.00, 20.00, 8.00, '600克', 1.00, 1.00, 0, '2025-05-06 18:08:50', NULL, '2025-05-09 09:38:07', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (68, '20_1', '贵州兴仁薏仁米600克 1000克', 20, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3e93790bba8db8aab54ee5ba72799567_20250507020547A104.png', 42.00, 48.00, 35.00, 6.00, '1000克', 1.00, 1.00, 0, '2025-05-06 18:08:50', NULL, '2025-05-09 09:38:10', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (69, '21_0', '品质在内格调在外头层真皮防消磁钥匙卡包 黑鳄鱼纹', 21, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/163063c82dc7efa80dc8ab964a56ce49_20250509175854A004.png', 188.00, 225.00, 150.00, 37.00, '黑鳄鱼纹', 1.00, 1.00, 0, '2025-05-09 10:00:44', NULL, '2025-05-09 10:00:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (70, '22_0', '野小兽磁阻划船机健身器材家用室内运动训练 米白色', 22, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bf53d2a4459f58a41a9e96cad735a742_20250514154524A004.jpg', 2188.00, 2288.00, 1888.00, 100.00, '米白色', 1.00, 1.00, 0, '2025-05-14 07:47:16', NULL, '2025-05-14 07:47:16', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (71, '23_0', '麦瑞克家用轻音椭圆机 手动磁控T6款 + 1.3米', 23, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 899.00, 1099.00, 700.00, 200.00, '手动磁控T6款 + 1.3米', 1.00, 1.00, 0, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (72, '23_1', '麦瑞克家用轻音椭圆机 手动磁控T6款 + 1.6米', 23, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1099.00, 1399.00, 800.00, 300.00, '手动磁控T6款 + 1.6米', 1.00, 1.00, 0, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (73, '23_2', '麦瑞克家用轻音椭圆机 电磁控T6I款 + 1.3米', 23, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1399.00, 1599.00, 1000.00, 200.00, '电磁控T6I款 + 1.3米', 1.00, 1.00, 0, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (74, '23_3', '麦瑞克家用轻音椭圆机 电磁控T6I款 + 1.6米', 23, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1599.00, 1799.00, 1200.00, 200.00, '电磁控T6I款 + 1.6米', 1.00, 1.00, 0, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (75, '24_0', '麦瑞克家用轻音智能多功能彩屏跑步机S450 单功能 + 10.1寸彩屏', 24, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160016A017.png', 2599.00, 2800.00, 2200.00, 201.00, '单功能 + 10.1寸彩屏', 1.00, 1.00, 0, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (76, '24_1', '麦瑞克家用轻音智能多功能彩屏跑步机S450 单功能 + 15.6寸彩屏', 24, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160020A018.png', 2999.00, 3200.00, 2500.00, 201.00, '单功能 + 15.6寸彩屏', 1.00, 1.00, 0, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (77, '24_2', '麦瑞克家用轻音智能多功能彩屏跑步机S450 多功能 + 10.1寸彩屏', 24, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160036A019.png', 3499.00, 3600.00, 3000.00, 101.00, '多功能 + 10.1寸彩屏', 1.00, 1.00, 0, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (78, '24_3', '麦瑞克家用轻音智能多功能彩屏跑步机S450 多功能 + 15.6寸彩屏', 24, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160038A020.png', 3899.00, 4100.00, 3400.00, 201.00, '多功能 + 15.6寸彩屏', 1.00, 1.00, 0, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (79, '25_0', '门上单杠墙体免打孔引体向上器 引体向上（基础款-中号安装距离95-123cm）', 25, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0a7cd982ce065edd6f950d731791c126_20250514160649A027.png', 58.00, 78.00, 50.00, 20.00, '引体向上（基础款-中号安装距离95-123cm）', 1.00, 1.00, 0, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (80, '25_1', '门上单杠墙体免打孔引体向上器 引体向上（基础款-小号安装距离67-93cm）', 25, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0a7cd982ce065edd6f950d731791c126_20250514160652A028.png', 68.00, 88.00, 60.00, 20.00, '引体向上（基础款-小号安装距离67-93cm）', 1.00, 1.00, 0, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (81, '25_2', '门上单杠墙体免打孔引体向上器 引体向上（钻石款-小号）', 25, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0b306219e23c1112310faff4ce9540f9_20250514160723A029.png', 78.00, 98.00, 70.00, 20.00, '引体向上（钻石款-小号）', 1.00, 1.00, 0, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (82, '26_0', '智能自动回弹健腹滚轮 经典款', 26, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 139.00, 160.00, 100.00, 21.00, '经典款', 1.00, 1.00, 0, '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (83, '26_1', '智能自动回弹健腹滚轮 智能款', 26, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 199.00, 240.00, 160.00, 41.00, '智能款', 1.00, 1.00, 0, '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (84, '27_0', '冬日出行多功能防风保暖围脖 双层螺纹-山脉蓝', 27, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1434c5d7ca4e24a6e8e95e3f925931a6_20250514161730A042.jpg', 66.00, 78.00, 50.00, 12.00, '双层螺纹-山脉蓝', 1.00, 1.00, 0, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (85, '27_1', '冬日出行多功能防风保暖围脖 双层螺纹-山脉红', 27, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/15d436c8441a2072b8ee0e29cc68b020_20250514161749A043.jpg', 66.00, 78.00, 50.00, 12.00, '双层螺纹-山脉红', 1.00, 1.00, 0, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (86, '27_2', '冬日出行多功能防风保暖围脖 双层有绒毛-民俗红', 27, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dee8db90cdb9f395f4821167e79a9b02_20250514161802A044.jpg', 79.00, 89.00, 60.00, 10.00, '双层有绒毛-民俗红', 1.00, 1.00, 0, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (87, '28_0', '可触屏户外出行手套 经典款-灰色-M', 28, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d47dc274b8ccb4d0905ca01efeb5701c_20250514164054A059.png', 48.00, 58.00, 38.00, 10.00, '经典款-灰色-M', 1.00, 1.00, 0, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (88, '28_1', '可触屏户外出行手套 经典款-灰色-L', 28, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/72862bd6c89ae4d9e1b2756068c91a35_20250514163842A054.png', 48.00, 58.00, 38.00, 10.00, '经典款-灰色-L', 1.00, 1.00, 0, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (89, '28_2', '可触屏户外出行手套 运动款-玫红-M', 28, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514163908A055.png', 48.00, 58.00, 38.00, 10.00, '运动款-玫红-M', 1.00, 1.00, 0, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (90, '28_3', '可触屏户外出行手套 运动款-玫红-L', 28, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514164046A058.png', 48.00, 58.00, 38.00, 10.00, '运动款-玫红-L', 1.00, 1.00, 0, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (91, '29_0', 'Airline真无线耳机，空气感佩戴，全新升级 黑色', 29, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/877a4c7f92d560dd6f34176be997f3b5_20250514165500A069.png', 588.00, 658.00, 400.00, 70.00, '黑色', 1.00, 1.00, 0, '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (92, '29_1', 'Airline真无线耳机，空气感佩戴，全新升级 白色', 29, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/80a3ec5c68f474b1c12720461b7fca10_20250514165300A067.png', 588.00, 658.00, 400.00, 70.00, '白色', 1.00, 1.00, 0, '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (93, '30_0', '平台云音乐氧气立体声蓝牙头戴式触控耳机 曜岩灰', 30, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1d4d1b74eeb49fa92fb189c7925c416a_20250514170429A079.png', 799.00, 899.00, 699.00, 100.00, '曜岩灰', 1.00, 1.00, 0, '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (94, '31_0', '小方盒智能插线板-Pro版 白色', 31, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a0d701292c4ca153e1800be83c4a7178_20250514170906A087.png', 109.00, 130.00, 90.00, 21.00, '白色', 1.00, 1.00, 0, '2025-05-14 09:11:06', NULL, '2025-05-14 09:11:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (95, '32_0', '平台有道口袋打印机GT1 口袋打印机', 32, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0f6f0d72692274e53bc13d5c23c7b6a2_20250514171537A094.jpg', 288.00, 320.00, 230.00, 32.00, '口袋打印机', 1.00, 1.00, 0, '2025-05-14 09:17:04', NULL, '2025-05-14 09:17:04', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (96, '33_0', 'MFi认证苹果快充编织数据线 升级加固加长版（1.2米） + 夜黑/银白（两件装）', 33, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 98.00, 118.00, 78.00, 20.00, '升级加固加长版（1.2米） + 夜黑/银白（两件装）', 1.00, 1.00, 0, '2025-05-14 09:25:31', NULL, '2025-05-14 09:40:51', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (97, '33_1', 'MFi认证苹果快充编织数据线 升级加固加长版（1.2米） + 夜黑', 33, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 58.00, 78.00, 48.00, 20.00, '升级加固加长版（1.2米） + 夜黑', 1.00, 1.00, 0, '2025-05-14 09:25:31', NULL, '2025-05-14 09:35:18', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (98, '33_2', 'MFi认证苹果快充编织数据线 升级加固加长版（1.6米） + 夜黑/银白（两件装）', 33, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 118.00, 128.00, 88.00, 10.00, '升级加固加长版（1.6米） + 夜黑/银白（两件装）', 1.00, 1.00, 0, '2025-05-14 09:25:31', NULL, '2025-05-14 09:40:55', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (99, '33_3', 'MFi认证苹果快充编织数据线 升级加固加长版（1.6米） + 夜黑', 33, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 78.00, 88.00, 58.00, 10.00, '升级加固加长版（1.6米） + 夜黑', 1.00, 1.00, 0, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (100, '34_0', '编织纹手机壳iPhone13型号 深海蓝 + iPhone13', 34, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d83a869ac7ca083fe3e1902167f243cf_20250514174726A113.png', 48.00, 68.00, 30.00, 20.00, '深海蓝 + iPhone13', 1.00, 1.00, 0, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (101, '34_1', '编织纹手机壳iPhone13型号 深海蓝 + iPhone13Pro', 34, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d83a869ac7ca083fe3e1902167f243cf_20250514174735A114.png', 58.00, 78.00, 40.00, 20.00, '深海蓝 + iPhone13Pro', 1.00, 1.00, 0, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (102, '34_2', '编织纹手机壳iPhone13型号 曜石黑 + iPhone13', 34, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174737A115.png', 48.00, 68.00, 30.00, 20.00, '曜石黑 + iPhone13', 1.00, 1.00, 0, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (103, '34_3', '编织纹手机壳iPhone13型号 曜石黑 + iPhone13Pro', 34, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174740A116.png', 58.00, 78.00, 40.00, 20.00, '曜石黑 + iPhone13Pro', 1.00, 1.00, 0, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (104, '35_0', '平台智造轻薄无线充电器 基础款(30W)', 35, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 188.00, 230.00, 140.00, 42.00, '基础款(30W)', 1.00, 1.00, 0, '2025-05-14 09:58:57', NULL, '2025-05-14 09:58:57', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (105, '35_1', '平台智造轻薄无线充电器 快充款(60W)', 35, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 258.00, 300.00, 200.00, 42.00, '快充款(60W)', 1.00, 1.00, 0, '2025-05-14 09:58:57', NULL, '2025-05-14 10:00:42', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (106, '36_0', 'iPhone 16 Pro 星光色 + 256G', 36, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/3283cf8419f0580adbaa667978b9aa3b_20250515025035A004.png', 6999.00, 7599.00, 6500.00, 600.00, '星光色 + 256G', 1.00, 1.00, 0, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (107, '36_1', 'iPhone 16 Pro 星光色 + 512G', 36, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/3283cf8419f0580adbaa667978b9aa3b_20250515025039A005.png', 7999.00, 8599.00, 7500.00, 600.00, '星光色 + 512G', 1.00, 1.00, 0, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (108, '36_2', 'iPhone 16 Pro 白色 + 256G', 36, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025057A006.png', 6999.00, 7599.00, 6500.00, 600.00, '白色 + 256G', 1.00, 1.00, 0, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (109, '36_3', 'iPhone 16 Pro 白色 + 512G', 36, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 7999.00, 8599.00, 7500.00, 600.00, '白色 + 512G', 1.00, 1.00, 0, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (110, '37_0', 'ins风小碎花泡泡袖衬110-160cm 藏青小花 + 120CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/178cfeab8e0ddff3c0511e3bafcdb5c4_20250523215230A004.png', 138.00, 158.00, 100.00, 20.00, '藏青小花 + 120CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (111, '37_1', 'ins风小碎花泡泡袖衬110-160cm 藏青小花 + 130CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/178cfeab8e0ddff3c0511e3bafcdb5c4_20250523215233A005.png', 138.00, 158.00, 100.00, 20.00, '藏青小花 + 130CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (112, '37_2', 'ins风小碎花泡泡袖衬110-160cm 藏青小花 + 140CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/178cfeab8e0ddff3c0511e3bafcdb5c4_20250523215236A006.png', 138.00, 158.00, 100.00, 20.00, '藏青小花 + 140CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (113, '37_3', 'ins风小碎花泡泡袖衬110-160cm 米底碎花 + 120CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215254A007.png', 148.00, 168.00, 100.00, 20.00, '米底碎花 + 120CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (114, '37_4', 'ins风小碎花泡泡袖衬110-160cm 米底碎花 + 130CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215257A008.png', 148.00, 168.00, 100.00, 20.00, '米底碎花 + 130CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (115, '37_5', 'ins风小碎花泡泡袖衬110-160cm 米底碎花 + 140CM', 37, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 148.00, 168.00, 100.00, 20.00, '米底碎花 + 140CM', 1.00, 1.00, 0, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (116, '38_0', '经典格子元素，男童格子纯棉衬衫 绿桔白格 + 130CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/22cba953b8239943c6db9cd0715bc2d2_20250523215912A015.jpg', 150.00, 170.00, 110.00, 20.00, '绿桔白格 + 130CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (117, '38_1', '经典格子元素，男童格子纯棉衬衫 绿桔白格 + 140CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/22cba953b8239943c6db9cd0715bc2d2_20250523215912A015.jpg', 150.00, 170.00, 110.00, 20.00, '绿桔白格 + 140CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (118, '38_2', '经典格子元素，男童格子纯棉衬衫 绿桔白格 + 150CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/22cba953b8239943c6db9cd0715bc2d2_20250523215912A015.jpg', 150.00, 170.00, 110.00, 20.00, '绿桔白格 + 150CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (119, '38_3', '经典格子元素，男童格子纯棉衬衫 蓝桔格 + 130CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220039A018.png', 160.00, 180.00, 110.00, 20.00, '蓝桔格 + 130CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (120, '38_4', '经典格子元素，男童格子纯棉衬衫 蓝桔格 + 140CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220042A019.png', 160.00, 180.00, 110.00, 20.00, '蓝桔格 + 140CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (121, '38_5', '经典格子元素，男童格子纯棉衬衫 蓝桔格 + 150CM', 38, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 160.00, 180.00, 110.00, 20.00, '蓝桔格 + 150CM', 1.00, 1.00, 0, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (122, '39_0', '毛毛虫儿童运动鞋 海浪蓝 + 24码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/7b352bebd64535458903049fe84ab88d_20250523220922A029.png', 228.00, 288.00, 180.00, 60.00, '海浪蓝 + 24码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (123, '39_1', '毛毛虫儿童运动鞋 海浪蓝 + 25码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/7b352bebd64535458903049fe84ab88d_20250523220925A030.png', 228.00, 288.00, 180.00, 60.00, '海浪蓝 + 25码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (124, '39_2', '毛毛虫儿童运动鞋 海浪蓝 + 26码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/7b352bebd64535458903049fe84ab88d_20250523220928A031.png', 228.00, 288.00, 180.00, 60.00, '海浪蓝 + 26码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (125, '39_3', '毛毛虫儿童运动鞋 经典黑 + 24码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220930A032.png', 238.00, 298.00, 180.00, 60.00, '经典黑 + 24码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (126, '39_4', '毛毛虫儿童运动鞋 经典黑 + 25码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220933A033.png', 238.00, 298.00, 180.00, 60.00, '经典黑 + 25码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (127, '39_5', '毛毛虫儿童运动鞋 经典黑 + 26码', 39, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 238.00, 298.00, 180.00, 60.00, '经典黑 + 26码', 1.00, 1.00, 0, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (134, '41_0', '人手必备，儿童轻薄透气防蚊裤 黄色小象 + 120CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c6fcf5093c2958aad8c93914272efe83_20250523225954A060.png', 89.00, 109.00, 70.00, 20.00, '黄色小象 + 120CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (135, '41_1', '人手必备，儿童轻薄透气防蚊裤 黄色小象 + 130CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c6fcf5093c2958aad8c93914272efe83_20250523225957A061.png', 89.00, 109.00, 70.00, 20.00, '黄色小象 + 130CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (136, '41_2', '人手必备，儿童轻薄透气防蚊裤 黄色小象 + 140CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/c6fcf5093c2958aad8c93914272efe83_20250523230000A062.png', 89.00, 109.00, 70.00, 20.00, '黄色小象 + 140CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (137, '41_3', '人手必备，儿童轻薄透气防蚊裤 奇妙动物 + 120CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230003A063.png', 79.00, 99.00, 70.00, 20.00, '奇妙动物 + 120CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (138, '41_4', '人手必备，儿童轻薄透气防蚊裤 奇妙动物 + 130CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230006A064.png', 79.00, 99.00, 70.00, 20.00, '奇妙动物 + 130CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (139, '41_5', '人手必备，儿童轻薄透气防蚊裤 奇妙动物 + 140CM', 41, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 79.00, 99.00, 70.00, 20.00, '奇妙动物 + 140CM', 1.00, 1.00, 0, '2025-05-23 15:02:21', NULL, '2025-05-23 15:02:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (140, '42_0', '男式零感无压加厚保暖羽绒服 青霜色 + M（170/92A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/11f8eac1ad6c44a0ae8a3932257ab811_20250523233425A074.png', 388.00, 410.00, 320.00, 22.00, '青霜色 + M（170/92A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (141, '42_1', '男式零感无压加厚保暖羽绒服 青霜色 + L（175/96A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/11f8eac1ad6c44a0ae8a3932257ab811_20250523233428A075.png', 388.00, 410.00, 320.00, 22.00, '青霜色 + L（175/96A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (142, '42_2', '男式零感无压加厚保暖羽绒服 青霜色 + XL（180/100A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/11f8eac1ad6c44a0ae8a3932257ab811_20250523233430A076.png', 388.00, 410.00, 320.00, 22.00, '青霜色 + XL（180/100A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (143, '42_3', '男式零感无压加厚保暖羽绒服 涩柿色 + M（170/92A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233432A077.png', 378.00, 410.00, 320.00, 32.00, '涩柿色 + M（170/92A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (144, '42_4', '男式零感无压加厚保暖羽绒服 涩柿色 + L（175/96A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233435A078.png', 378.00, 410.00, 320.00, 32.00, '涩柿色 + L（175/96A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (145, '42_5', '男式零感无压加厚保暖羽绒服 涩柿色 + XL（180/100A）', 42, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 378.00, 410.00, 320.00, 32.00, '涩柿色 + XL（180/100A）', 1.00, 1.00, 0, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (146, '43_0', '趣玩奶酪纯PC拉链拉杆箱 三角黑巧 + 20寸', 43, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/d6c80a834dac93b1e4b7fa495cc57760_20250523234244A087.png', 299.00, 339.00, 250.00, 40.00, '三角黑巧 + 20寸', 1.00, 1.00, 0, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (147, '43_1', '趣玩奶酪纯PC拉链拉杆箱 三角黑巧 + 24寸', 43, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/d6c80a834dac93b1e4b7fa495cc57760_20250523234247A088.png', 299.00, 339.00, 250.00, 40.00, '三角黑巧 + 24寸', 1.00, 1.00, 0, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (148, '43_2', '趣玩奶酪纯PC拉链拉杆箱 圆点奶酪黄 + 20寸', 43, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234250A089.png', 329.00, 359.00, 250.00, 30.00, '圆点奶酪黄 + 20寸', 1.00, 1.00, 0, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (149, '43_3', '趣玩奶酪纯PC拉链拉杆箱 圆点奶酪黄 + 24寸', 43, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234252A090.png', 329.00, 359.00, 250.00, 30.00, '圆点奶酪黄 + 24寸', 1.00, 1.00, 0, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (150, '44_0', '星云吉彩系列花器新年创意花瓶摆件朱炳仁 新年红', 44, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8a124556234b6dcfe404be40d9e89fae_20250523234942A101.jpg', 599.00, 799.00, 300.00, 200.00, '新年红', 1.00, 1.00, 0, '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (151, '44_1', '星云吉彩系列花器新年创意花瓶摆件朱炳仁 陶朱青', 44, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e727b40aa867db82ad01c5459d27183e_20250523234959A102.jpg', 579.00, 799.00, 300.00, 220.00, '陶朱青', 1.00, 1.00, 0, '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (152, '45_0', '语音播报电子血压计 白色KD-5901', 45, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8f0c15f981c5cbcb1aa17215a259fa62_20250523235520A106.png', 99.00, 129.00, 89.00, 30.00, '白色KD-5901', 1.00, 1.00, 0, '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (153, '46_0', '女式舒软牛皮乐福鞋 37码', 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 299.00, 319.00, 250.00, 20.00, '37码', 1.00, 1.00, 0, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (154, '46_1', '女式舒软牛皮乐福鞋 38码', 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 299.00, 319.00, 250.00, 20.00, '38码', 1.00, 1.00, 0, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (155, '46_2', '女式舒软牛皮乐福鞋 39码', 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 299.00, 319.00, 250.00, 20.00, '39码', 1.00, 1.00, 0, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (156, '46_3', '女式舒软牛皮乐福鞋 40码', 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 299.00, 319.00, 250.00, 20.00, '40码', 1.00, 1.00, 0, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (157, '46_4', '女式舒软牛皮乐福鞋 41码', 46, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 299.00, 319.00, 250.00, 20.00, '41码', 1.00, 1.00, 0, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (158, '47_0', '软糯治愈系擦手，雪尼尔擦手球 3只/包', 47, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png', 19.00, 25.00, 10.00, 6.00, '3只/包', 1.00, 1.00, 0, '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (159, '47_1', '软糯治愈系擦手，雪尼尔擦手球 1只装', 47, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png', 8.00, 12.00, 5.00, 4.00, '1只装', 1.00, 1.00, 0, '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (160, '48_0', '吸水力速干防潮天然硅藻土地垫 30寸', 48, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 69.00, 80.00, 40.00, 11.00, '30寸', 1.00, 1.00, 0, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (161, '48_1', '吸水力速干防潮天然硅藻土地垫 40寸', 48, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 89.00, 110.00, 60.00, 21.00, '40寸', 1.00, 1.00, 0, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (162, '48_2', '吸水力速干防潮天然硅藻土地垫 50寸', 48, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 99.00, 120.00, 70.00, 21.00, '50寸', 1.00, 1.00, 0, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (163, '49_0', '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪 硫光白（Air）', 49, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/8f945c11e702f84bffc14416c3e51c43_20250524002144A134.png', 799.00, 860.00, 600.00, 61.00, '硫光白（Air）', 1.00, 1.00, 0, '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (164, '49_1', '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪 冰晶绿（Air）', 49, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/782611ae57b0dd10283f40f0f7d48be3_20250524002148A135.png', 789.00, 860.00, 600.00, 71.00, '冰晶绿（Air）', 1.00, 1.00, 0, '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (165, '50_0', '源自澳洲进口羊毛，儿童奢暖羊毛被升级款 150x200cm', 50, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png', 399.00, 459.00, 300.00, 60.00, '150x200cm', 1.00, 1.00, 0, '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (166, '50_1', '源自澳洲进口羊毛，儿童奢暖羊毛被升级款 200x230cm', 50, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png', 449.00, 509.00, 350.00, 60.00, '200x230cm', 1.00, 1.00, 0, '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (167, '51_0', '女式优雅蝴蝶结饰带浅口穆勒鞋 36码 + 豆沙红', 51, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003227A150.png', 169.00, 189.00, 150.00, 20.00, '36码 + 豆沙红', 1.00, 1.00, 0, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (168, '51_1', '女式优雅蝴蝶结饰带浅口穆勒鞋 37码 + 豆沙红', 51, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003230A151.png', 169.00, 189.00, 150.00, 20.00, '37码 + 豆沙红', 1.00, 1.00, 0, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (169, '51_2', '女式优雅蝴蝶结饰带浅口穆勒鞋 38码 + 豆沙红', 51, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003235A152.png', 169.00, 189.00, 150.00, 20.00, '38码 + 豆沙红', 1.00, 1.00, 0, '2025-05-23 16:34:35', NULL, '2025-05-27 09:34:37', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (170, '52_0', '简约山形纹全棉提花毛巾 灰色', 52, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/cefbe969ac6466258aca8416f808ad1a_20250527174116A004.png', 29.00, 39.00, 20.00, 10.00, '灰色', 1.00, 1.00, 0, '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (171, '52_1', '简约山形纹全棉提花毛巾 绿色', 52, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/b0d48553d094d81eb716e902e206b63a_20250527174119A005.png', 40.00, 39.00, 20.00, 4.00, '绿色', 1.00, 1.00, 0, '2025-05-27 09:43:55', NULL, '2025-05-28 18:06:53', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (172, '53_0', 'British long-handled automatic umbrella Green + Large', 53, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/a31b31f015d0e78b115af7e07f6ebb72_20250529150421A004.png', 40.00, 40.00, 40.00, 0.00, 'Green + Large', 1.00, 1.00, 0, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (173, '53_1', 'British long-handled automatic umbrella Green + Small', 53, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/a31b31f015d0e78b115af7e07f6ebb72_20250529150427A005.png', 40.00, 40.00, 40.00, 0.00, 'Green + Small', 1.00, 1.00, 0, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (174, '53_2', 'British long-handled automatic umbrella Blue + Large', 53, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 40.00, 40.00, 40.00, 0.00, 'Blue + Large', 1.00, 1.00, 0, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (175, '53_3', 'British long-handled automatic umbrella Blue + Small', 53, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 100.00, 40.00, 40.00, 0.00, 'Blue + Small', 1.00, 1.00, 0, '2025-05-29 07:05:30', NULL, '2025-05-29 07:07:25', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (180, '55_0', 'Nike Sport Shoes White + 39', 55, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES_20250730202803A010.webp', 900.00, 900.00, 900.00, 0.00, 'White + 39', NULL, NULL, 0, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (181, '55_1', 'Nike Sport Shoes White + 40', 55, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES_20250730202803A010.webp', 900.00, 900.00, 900.00, 0.00, 'White + 40', NULL, NULL, 0, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (182, '55_2', 'Nike Sport Shoes Black + 39', 55, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202839A012.webp', 1000.00, 1000.00, 1000.00, 0.00, 'Black + 39', NULL, NULL, 0, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (183, '55_3', 'Nike Sport Shoes Black + 40', 55, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202842A013.webp', 500.00, 1000.00, 1000.00, 0.00, 'Black + 40', NULL, NULL, 0, '2025-07-30 12:29:27', NULL, '2025-08-13 07:21:47', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (184, '56_0', 'Nike Sport Shoes Black + 39', 56, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801015702A004.webp', 300.00, 300.00, 300.00, 0.00, 'Black + 39', NULL, NULL, 0, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (185, '56_1', 'Nike Sport Shoes Black + 40', 56, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801015706A005.webp', 300.00, 300.00, 300.00, 0.00, 'Black + 40', NULL, NULL, 0, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (186, '56_2', 'Nike Sport Shoes White + 39', 56, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 400.00, 400.00, 400.00, 0.00, 'White + 39', NULL, NULL, 0, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (187, '56_3', 'Nike Sport Shoes White + 40', 56, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 1000.00, 400.00, 400.00, 0.00, 'White + 40', NULL, NULL, 0, '2025-07-31 17:58:09', NULL, '2025-07-31 17:59:53', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (188, '57_0', 'Nike Sport Shoes 40 + White', 57, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801020845A009.webp', 200.00, 200.00, 200.00, 0.00, '40 + White', NULL, NULL, 0, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (189, '57_1', 'Nike Sport Shoes 40 + Blace', 57, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020929A012.webp', 200.00, 200.00, 200.00, 0.00, '40 + Blace', NULL, NULL, 0, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (190, '57_2', 'Nike Sport Shoes 41 + White', 57, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801020845A009.webp', 300.00, 300.00, 300.00, 0.00, '41 + White', NULL, NULL, 0, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_sku` VALUES (191, '57_3', 'Nike Sport Shoes 41 + Blace', 57, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020931A013.webp', 1000.00, 300.00, 300.00, 0.00, '41 + Blace', NULL, NULL, 0, '2025-07-31 18:10:28', NULL, '2025-07-31 18:11:48', NULL, '0', NULL);

-- ----------------------------
-- Table structure for product_spec_values
-- ----------------------------
DROP TABLE IF EXISTS `product_spec_values`;
CREATE TABLE `product_spec_values`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '可选值id',
  `spec_id` bigint NOT NULL COMMENT '所属规格id，关联product_specs表的spec_id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '可选值名称',
  `picture` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '可选值图片链接',
  `is_available` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可售',
  `value_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '可选值备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `spec_id`(`spec_id` ASC) USING BTREE,
  CONSTRAINT `product_spec_values_ibfk_1` FOREIGN KEY (`spec_id`) REFERENCES `product_specs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 172 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_spec_values
-- ----------------------------
INSERT INTO `product_spec_values` VALUES (1, 1, '黑色', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png?quality=95&imageView', 1, NULL, '2025-05-01 11:50:46', NULL, '2025-05-01 11:50:46', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (2, 1, '蓝色', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png?quality=95&imageView', 1, NULL, '2025-05-01 11:51:00', NULL, '2025-05-01 11:51:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (3, 2, '30cm', NULL, 1, NULL, '2025-05-01 11:51:39', NULL, '2025-05-01 11:51:39', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (4, 2, '20cm', NULL, 1, NULL, '2025-05-01 11:51:54', NULL, '2025-05-01 11:51:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (5, 2, '10cm', NULL, 1, NULL, '2025-05-01 11:52:02', NULL, '2025-05-01 11:52:02', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (6, 3, '日本', NULL, 1, NULL, '2025-05-01 11:53:07', NULL, '2025-05-01 11:53:07', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (7, 3, '中国', NULL, 1, NULL, '2025-05-01 11:53:16', NULL, '2025-05-01 11:53:16', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (8, 4, '黑色', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/cd6c46b6-b944-4479-b547-cdee294568a1.png?quality=95&imageView', 1, NULL, '2025-05-01 11:50:46', NULL, '2025-05-01 11:50:46', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (9, 4, '蓝色', 'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/2d5ba800-1868-48c8-9213-1a5f8965a05b.png?quality=95&imageView', 1, NULL, '2025-05-01 11:51:00', NULL, '2025-05-01 11:51:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (10, 5, '30cm', NULL, 1, NULL, '2025-05-01 11:51:39', NULL, '2025-05-01 11:51:39', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (11, 5, '10cm', NULL, 1, NULL, '2025-05-01 11:52:02', NULL, '2025-05-03 04:24:24', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (12, 6, '日本', NULL, 1, NULL, '2025-05-01 11:53:07', NULL, '2025-05-03 04:24:24', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (13, 6, '中国', NULL, 1, NULL, '2025-05-01 11:53:16', NULL, '2025-05-03 04:24:24', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (33, 16, '5.4千克/袋', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004309A015.png', 1, '', '2025-05-06 16:44:38', NULL, '2025-05-09 09:39:33', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (34, 16, '1.8千克/袋', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004309A015.png', 1, '', '2025-05-06 16:44:38', NULL, '2025-05-09 09:39:36', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (35, 16, '120克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/504e62e44afc5f770fb756d83e704e77_20250507004309A015.png', 1, '', '2025-05-06 16:44:38', NULL, '2025-05-09 09:39:52', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (36, 17, 'M400*500*235mm47L两只装', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/4f7d7da492cf5c9241484a7525795fdf_20250507005841A026.png', 1, '', '2025-05-06 17:02:13', NULL, '2025-05-09 09:40:16', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (37, 17, 'S400*500*180mm36L四只装', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/4f7d7da492cf5c9241484a7525795fdf_20250507005841A026.png', 1, '', '2025-05-06 17:02:13', NULL, '2025-05-09 09:40:23', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (38, 18, '138克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg', 1, '', '2025-05-06 17:18:51', NULL, '2025-05-09 09:40:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (39, 18, '238克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/31c9dce053a746724413263c40b95360_20250507011453A035.jpg', 1, '', '2025-05-06 17:18:51', NULL, '2025-05-09 09:40:34', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (40, 19, '118克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 1, '', '2025-05-06 17:24:06', NULL, '2025-05-09 09:40:42', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (41, 19, '228克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/0e43fa53f61ddf37926fad3b7a3c2688_20250507012003A044.jpg', 1, '', '2025-05-06 17:24:06', NULL, '2025-05-09 09:40:43', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (42, 20, '香菇肉燥酱375克（75克*5袋）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/980b1b3cb856ad0e148783208a256619_20250507012650A060.png', 1, '', '2025-05-06 17:30:11', NULL, '2025-05-09 09:40:51', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (43, 20, '微辣香菇酱375克（75克*5袋）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/980b1b3cb856ad0e148783208a256619_20250507012650A060.png', 1, '', '2025-05-06 17:30:11', NULL, '2025-05-09 09:40:53', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (44, 20, '原味香菇酱375克（75克*5袋）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/980b1b3cb856ad0e148783208a256619_20250507012650A060.png', 1, '', '2025-05-06 17:30:11', NULL, '2025-05-09 09:40:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (45, 21, '川味果蔬辣椒酱190克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/be9af2aed2387a44f0bafd5766948c52_20250507013237A073.png', 1, '', '2025-05-06 17:35:03', NULL, '2025-05-09 09:41:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (46, 21, '川味牛肉辣椒酱190克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/be9af2aed2387a44f0bafd5766948c52_20250507013237A073.png', 1, '', '2025-05-06 17:35:03', NULL, '2025-05-09 09:41:02', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (47, 22, '370克*6盒', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/65256152984021cfb766c4856f2307d8_20250507013829A076.jpg', 1, '', '2025-05-06 17:41:22', NULL, '2025-05-09 09:41:08', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (48, 22, '570克*6盒', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/65256152984021cfb766c4856f2307d8_20250507013829A076.jpg', 1, '', '2025-05-06 17:41:22', NULL, '2025-05-09 09:41:10', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (49, 23, '75克*10枚', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014325A085.png', 1, '', '2025-05-06 17:45:29', NULL, '2025-05-09 09:41:16', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (50, 23, '75克*20枚', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/2e97f232711f191fb03f96774769fb45_20250507014325A085.png', 1, '', '2025-05-06 17:45:29', NULL, '2025-05-09 09:41:19', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (51, 24, '500克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014921A096.png', 1, '', '2025-05-06 17:52:13', NULL, '2025-05-09 09:41:26', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (52, 24, '1000克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/5f62c7ab543b1152383a0e9941c09bfd_20250507014921A096.png', 1, '', '2025-05-06 17:52:13', NULL, '2025-05-09 09:41:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (53, 25, '600克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3e93790bba8db8aab54ee5ba72799567_20250507020547A104.png', 1, '', '2025-05-06 18:08:50', NULL, '2025-05-09 09:41:34', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (54, 25, '1000克', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/3e93790bba8db8aab54ee5ba72799567_20250507020547A104.png', 1, '', '2025-05-06 18:08:50', NULL, '2025-05-09 09:41:37', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (55, 26, '黑鳄鱼纹', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/09/163063c82dc7efa80dc8ab964a56ce49_20250509175854A004.png', 1, '', '2025-05-09 10:00:44', NULL, '2025-05-09 10:00:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (56, 27, '米白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/bf53d2a4459f58a41a9e96cad735a742_20250514154524A004.jpg', 1, '', '2025-05-14 07:47:16', NULL, '2025-05-14 07:47:16', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (57, 28, '手动磁控T6款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1, '', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (58, 28, '电磁控T6I款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1, '', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (59, 29, '1.3米', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1, '', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (60, 29, '1.6米', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/5e1d7dab26415cd0d44dfb9645e01348_20250514155030A008.jpg', 1, '', '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (61, 30, '单功能', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160038A020.png', 1, '', '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (62, 30, '多功能', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160038A020.png', 1, '', '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (63, 31, '10.1寸彩屏', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160038A020.png', 1, '', '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (64, 31, '15.6寸彩屏', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/d2671d4df8ccea406d4db8ea75be23d0_20250514160038A020.png', 1, '', '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (65, 32, '引体向上（基础款-中号安装距离95-123cm）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0b306219e23c1112310faff4ce9540f9_20250514160723A029.png', 1, '', '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (66, 32, '引体向上（基础款-小号安装距离67-93cm）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0b306219e23c1112310faff4ce9540f9_20250514160723A029.png', 1, '', '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (67, 32, '引体向上（钻石款-小号）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0b306219e23c1112310faff4ce9540f9_20250514160723A029.png', 1, '', '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (68, 33, '经典款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 1, '', '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (69, 33, '智能款', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png', 1, '', '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (70, 34, '双层螺纹-山脉蓝', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dee8db90cdb9f395f4821167e79a9b02_20250514161802A044.jpg', 1, '', '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (71, 34, '双层螺纹-山脉红', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dee8db90cdb9f395f4821167e79a9b02_20250514161802A044.jpg', 1, '', '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (72, 34, '双层有绒毛-民俗红', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/dee8db90cdb9f395f4821167e79a9b02_20250514161802A044.jpg', 1, '', '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (73, 35, '经典款-灰色-M', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514164046A058.png', 1, '', '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (74, 35, '经典款-灰色-L', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514164046A058.png', 1, '', '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (75, 35, '运动款-玫红-M', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514164046A058.png', 1, '', '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (76, 35, '运动款-玫红-L', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/71f50eb0003f75dd5e4605ae6b56f7d9_20250514164046A058.png', 1, '', '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (77, 36, '黑色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/80a3ec5c68f474b1c12720461b7fca10_20250514165300A067.png', 1, '', '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (78, 36, '白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/80a3ec5c68f474b1c12720461b7fca10_20250514165300A067.png', 1, '', '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (79, 37, '曜岩灰', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/1d4d1b74eeb49fa92fb189c7925c416a_20250514170429A079.png', 1, '', '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:18', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (80, 38, '白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/a0d701292c4ca153e1800be83c4a7178_20250514170906A087.png', 1, '', '2025-05-14 09:11:06', NULL, '2025-05-14 09:11:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (81, 39, '口袋打印机', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/0f6f0d72692274e53bc13d5c23c7b6a2_20250514171537A094.jpg', 1, '', '2025-05-14 09:17:04', NULL, '2025-05-14 09:17:04', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (82, 40, '升级加固加长版（1.2米）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 1, '', '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (83, 40, '升级加固加长版（1.6米）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 1, '', '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (84, 41, '夜黑/银白（两件装）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 1, '', '2025-05-14 09:25:31', NULL, '2025-05-14 09:41:07', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (85, 41, '夜黑', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/c86961c7e22acb1b62c5493ccf6a4b03_20250514172157A104.png', 1, '', '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (86, 42, '深海蓝', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174740A116.png', 1, '', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (87, 42, '曜石黑', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174740A116.png', 1, '', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (88, 43, 'iPhone13', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174740A116.png', 1, '', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (89, 43, 'iPhone13Pro', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/4d9eb23922d72c288f9ff1d254b6f0b7_20250514174740A116.png', 1, '', '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (90, 44, '基础款(30W)', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 1, '', '2025-05-14 09:58:57', NULL, '2025-05-14 09:58:57', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (91, 44, '快充款(60W)', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/3f72b00417feb825694276224ff1d632_20250514175523A120.png', 1, '', '2025-05-14 09:58:57', NULL, '2025-05-14 10:00:54', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (92, 45, '星光色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 1, '', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (93, 45, '白色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 1, '', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (94, 46, '256G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 1, '', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (95, 46, '512G', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/15/6b26c8c708b21eb375cf33d5432fb2a4_20250515025100A007.png', 1, '', '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (96, 47, '藏青小花', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 1, '', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (97, 47, '米底碎花', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 1, '', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (98, 48, '120CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 1, '', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (99, 48, '130CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 1, '', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (100, 48, '140CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/fbba6ce360af55ccae3036e70ff339ac_20250523215300A009.png', 1, '', '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (101, 49, '绿桔白格', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 1, '', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (102, 49, '蓝桔格', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 1, '', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (103, 50, '130CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 1, '', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (104, 50, '140CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 1, '', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (105, 50, '150CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/33867d5e9bbb31072125a5efc289d177_20250523220045A020.png', 1, '', '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (106, 51, '海浪蓝', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 1, '', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (107, 51, '经典黑', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 1, '', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (108, 52, '24码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 1, '', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (109, 52, '25码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 1, '', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (110, 52, '26码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/5b6f8739fefe81ebf828bfbe5d6cb9bf_20250523220935A034.png', 1, '', '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (116, 55, '黄色小象', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 1, '', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (117, 55, '奇妙动物', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 1, '', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (118, 56, '120CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 1, '', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (119, 56, '130CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 1, '', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (120, 56, '140CM', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/197f4c6d75f0ff5b9df603dfa6a47443_20250523230008A065.png', 1, '', '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (121, 57, '青霜色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 1, '', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (122, 57, '涩柿色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 1, '', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (123, 58, 'M（170/92A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 1, '', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (124, 58, 'L（175/96A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 1, '', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (125, 58, 'XL（180/100A）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/1dfdb03cdaa13954fdcc3f8f44555937_20250523233438A079.png', 1, '', '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (126, 59, '三角黑巧', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234252A090.png', 1, '', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (127, 59, '圆点奶酪黄', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234252A090.png', 1, '', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (128, 60, '20寸', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234252A090.png', 1, '', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (129, 60, '24寸', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/0fec0539b3d5111d96f4d5ad9280556a_20250523234252A090.png', 1, '', '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (130, 61, '新年红', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e727b40aa867db82ad01c5459d27183e_20250523234959A102.jpg', 1, '', '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (131, 61, '陶朱青', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e727b40aa867db82ad01c5459d27183e_20250523234959A102.jpg', 1, '', '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (132, 62, '白色KD-5901', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/8f0c15f981c5cbcb1aa17215a259fa62_20250523235520A106.png', 1, '', '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (133, 63, '37码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 1, '', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (134, 63, '38码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 1, '', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (135, 63, '39码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 1, '', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (136, 63, '40码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 1, '', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (137, 63, '41码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/e99d5bb3a5bfe6a596b123e908b8b7ac_20250523235950A112.png', 1, '', '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (138, 64, '3只/包', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png', 1, '', '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (139, 64, '1只装', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/43d99e9b97cc55033b0f59b95a91ae49_20250524000906A118.png', 1, '', '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (140, 65, '30寸', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 1, '', '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (141, 65, '40寸', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 1, '', '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (142, 65, '50寸', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/2749544de4b0ce605f06daa396340d4b_20250524001523A124.png', 1, '', '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (143, 66, '硫光白（Air）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/782611ae57b0dd10283f40f0f7d48be3_20250524002148A135.png', 1, '', '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (144, 66, '冰晶绿（Air）', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/782611ae57b0dd10283f40f0f7d48be3_20250524002148A135.png', 1, '', '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (145, 67, '150x200cm', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png', 1, '', '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (146, 67, '200x230cm', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png', 1, '', '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (147, 68, '36码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003235A152.png', 1, '', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (148, 68, '37码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003235A152.png', 1, '', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (149, 68, '38码', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003235A152.png', 1, '', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (150, 69, '豆沙红', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/be3a60f02d92179fa57c805fee4986d1_20250524003235A152.png', 1, '', '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (151, 70, '灰色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/b0d48553d094d81eb716e902e206b63a_20250527174119A005.png', 1, '', '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (152, 70, '绿色', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/27/b0d48553d094d81eb716e902e206b63a_20250527174119A005.png', 1, '', '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (153, 71, 'Green', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 1, '', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (154, 71, 'Blue', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 1, '', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (155, 72, 'Large', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 1, '', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (156, 72, 'Small', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/e77b8f4a8ddd1e777394d84347859f7c_20250529150320A001.png', 1, '', '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (157, 73, 'Black', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730201510A001.webp', 1, '', '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (158, 73, 'White', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730201510A001.webp', 1, '', '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (159, 74, '39', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730201510A001.webp', 1, '', '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (160, 74, '40', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-WHITE_20250730201510A001.webp', 1, '', '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (161, 75, 'White', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202842A013.webp', 1, '', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (162, 75, 'Black', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202842A013.webp', 1, '', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (163, 76, '39', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202842A013.webp', 1, '', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (164, 76, '40', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/07/30/SHOES-BLACK_20250730202842A013.webp', 1, '', '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (165, 77, 'Black', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 1, '', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (166, 77, 'White', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 1, '', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (167, 78, '39', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 1, '', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (168, 78, '40', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES_20250801015617A001.webp', 1, '', '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (169, 79, '40', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020931A013.webp', 1, '', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (170, 79, '41', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020931A013.webp', 1, '', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (171, 80, 'White', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020931A013.webp', 1, '', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_spec_values` VALUES (172, 80, 'Blace', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/08/01/SHOES-BLACK_20250801020931A013.webp', 1, '', '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);

-- ----------------------------
-- Table structure for product_specs
-- ----------------------------
DROP TABLE IF EXISTS `product_specs`;
CREATE TABLE `product_specs`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品ID',
  `spec_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格名称',
  `category_id` bigint NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_specs
-- ----------------------------
INSERT INTO `product_specs` VALUES (1, 4, '颜色', 1005999003, '2025-05-01 11:47:44', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (2, 4, '尺寸', 1005999003, '2025-05-01 11:51:21', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (3, 4, '产地', 1005999003, '2025-05-01 11:52:49', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (4, 5, '颜色', 1005999003, '2025-05-01 11:47:44', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (5, 5, '尺寸', 1005999003, '2025-05-01 11:51:21', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (6, 5, '产地', 1005999003, '2025-05-01 11:52:49', NULL, '2025-05-06 06:49:37', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (16, 11, '规格', 1017000, '2025-05-06 16:44:38', NULL, '2025-05-06 16:44:38', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (17, 12, '规格', 1008017, '2025-05-06 17:02:13', NULL, '2025-05-06 17:02:13', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (18, 13, '规格', 1005012, '2025-05-06 17:18:51', NULL, '2025-05-06 17:18:51', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (19, 14, '规格', 1005012, '2025-05-06 17:24:06', NULL, '2025-05-06 17:24:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (20, 15, '规格', 1036003, '2025-05-06 17:30:11', NULL, '2025-05-06 17:30:11', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (21, 16, '规格', 1036003, '2025-05-06 17:35:03', NULL, '2025-05-06 17:35:03', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (22, 17, '规格', 109201001, '2025-05-06 17:41:22', NULL, '2025-05-06 17:41:22', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (23, 18, '规格', 109201001, '2025-05-06 17:45:29', NULL, '2025-05-06 17:45:29', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (24, 19, '规格', 109206007, '2025-05-06 17:52:13', NULL, '2025-05-06 17:52:13', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (25, 20, '规格', 109206007, '2025-05-06 18:08:50', NULL, '2025-05-06 18:08:50', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (26, 21, '颜色', 109303000, '2025-05-09 10:00:44', NULL, '2025-05-09 10:00:44', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (27, 22, '颜色', 109312000, '2025-05-14 07:47:16', NULL, '2025-05-14 07:47:16', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (28, 23, '规格', 109312000, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (29, 23, '尺寸', 109312000, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (30, 24, '规格', 109312000, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (31, 24, '款式', 109312000, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (32, 25, '款式', 109312001, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (33, 26, '款式', 109312001, '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (34, 27, '款式', 109313003, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (35, 28, '款式', 109313003, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (36, 29, '颜色', 1008006, '2025-05-14 08:56:57', NULL, '2025-05-14 08:56:57', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (37, 30, '颜色', 1008006, '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:18', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (38, 31, '颜色', 1022000, '2025-05-14 09:11:06', NULL, '2025-05-14 09:11:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (39, 32, '规格', 1022000, '2025-05-14 09:17:04', NULL, '2025-05-14 09:17:04', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (40, 33, '长度', 109243035, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (41, 33, '颜色', 109243035, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (42, 34, '颜色', 109243035, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (43, 34, '型号', 109243035, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (44, 35, '款式', 1022000, '2025-05-14 09:58:57', NULL, '2025-05-14 09:58:57', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (45, 36, '颜色', 1022000, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (46, 36, '规格', 1022000, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (47, 37, '颜色', 1020003, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (48, 37, '尺码', 1020003, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (49, 38, '颜色', 1020003, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (50, 38, '尺码', 1020003, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (51, 39, '颜色', 1037006, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (52, 39, '尺码', 1037006, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (55, 41, '颜色', 109243019, '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (56, 41, '尺码', 109243019, '2025-05-23 15:02:22', NULL, '2025-05-23 15:02:22', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (57, 42, '颜色', 19999999002, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (58, 42, '尺码', 19999999002, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (59, 43, '颜色', 19999999002, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (60, 43, '尺寸', 19999999002, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (61, 44, '颜色', 109243003, '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (62, 45, '规格', 109293000, '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (63, 46, '尺码', 109311005, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (64, 47, '规格', 1009000, '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (65, 48, '规格', 1020002, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (66, 49, '规格', 109309012, '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (67, 50, '尺寸', 109256014, '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (68, 51, '尺码', 109311006, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (69, 51, '颜色', 109311006, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (70, 52, '规格', 19999999001, '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (71, 53, 'Corlor', 1005999003, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (72, 53, 'Size', 1005999003, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (73, 54, 'Color', 109311006, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (74, 54, 'Size', 109311006, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (75, 55, 'Color', 109311005, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (76, 55, 'Size', 109311005, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (77, 56, 'Corlor', 109311005, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (78, 56, 'Size', 109311005, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (79, 57, 'Size', 109311005, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `product_specs` VALUES (80, 57, 'Corlor', 109311005, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);

-- ----------------------------
-- Table structure for product_unit
-- ----------------------------
DROP TABLE IF EXISTS `product_unit`;
CREATE TABLE `product_unit`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品单位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_unit
-- ----------------------------
INSERT INTO `product_unit` VALUES (1, 'Set', '2023-05-12 10:43:17', NULL, '2025-01-24 10:31:31', NULL, '0', NULL);
INSERT INTO `product_unit` VALUES (2, 'Package', '2023-06-06 09:47:17', NULL, '2025-01-24 10:31:48', NULL, '0', NULL);
INSERT INTO `product_unit` VALUES (3, 'Unit', '2023-06-06 09:47:21', NULL, '2025-01-24 10:31:54', NULL, '0', NULL);
INSERT INTO `product_unit` VALUES (4, 'Pieces', '2023-06-06 09:47:26', NULL, '2025-01-24 10:32:05', NULL, '0', NULL);
INSERT INTO `product_unit` VALUES (5, 'Dozen', '2023-06-06 09:47:43', NULL, '2025-01-24 10:32:16', NULL, '0', NULL);

-- ----------------------------
-- Table structure for recommend_type
-- ----------------------------
DROP TABLE IF EXISTS `recommend_type`;
CREATE TABLE `recommend_type`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  `pictures` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '图片集合[ 图片路径 ]',
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recommend_type
-- ----------------------------
INSERT INTO `recommend_type` VALUES ('1', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/24/31a81e6c7e4c173d1cf19d5abeb97550_20250524002612A141.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/23/22cba953b8239943c6db9cd0715bc2d2_20250523215912A015.jpg', NULL, '热门排名', '1');
INSERT INTO `recommend_type` VALUES ('2', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/14/746948bc036104aeaae51e3c11e43729_20250514161126A033.png,https://pocketapp.mynatapp.cc/minio/pocket/2025/05/07/d97cd8558999713868afa029f338d0a4_20250507014229A081.png', NULL, '个性化推荐', '2');

-- ----------------------------
-- Table structure for sku_stock
-- ----------------------------
DROP TABLE IF EXISTS `sku_stock`;
CREATE TABLE `sku_stock`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品ID',
  `total_num` int NULL DEFAULT NULL COMMENT '总库存数',
  `lock_num` int NULL DEFAULT NULL COMMENT '锁定库存',
  `available_num` int NULL DEFAULT NULL COMMENT '可用库存',
  `sale_num` int NULL DEFAULT NULL COMMENT '销量',
  `status` tinyint NULL DEFAULT NULL COMMENT '线上状态：0-初始值，1-上架，-1-自主下架',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_sku_id`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品sku库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_stock
-- ----------------------------
INSERT INTO `sku_stock` VALUES (1, 1, 100, 0, 100, 300, NULL, '2024-01-16 14:02:04', NULL, '2025-01-26 07:05:44', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (2, 2, 100, 0, 100, 246, NULL, '2024-01-16 14:02:08', NULL, '2025-01-26 07:05:49', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (3, 3, 100, 0, 100, 234, NULL, '2024-01-16 14:02:16', NULL, '2025-01-26 07:05:54', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (4, 4, 100, 0, 100, 112, NULL, '2024-01-16 14:02:17', NULL, '2025-01-26 07:05:56', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (5, 5, 100, 0, 100, 12, NULL, '2024-01-16 14:02:20', NULL, '2025-05-14 15:33:45', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (6, 6, 100, 0, 100, 129, NULL, '2024-01-16 14:02:21', NULL, '2025-01-26 07:06:08', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (7, 7, 100, 0, 100, 467, NULL, '2024-01-16 14:02:24', NULL, '2025-05-04 18:38:26', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (8, 8, 100, 0, 100, 244, NULL, '2024-01-16 14:02:26', NULL, '2025-01-26 07:06:15', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (9, 9, 100, 0, 100, 278, NULL, '2024-01-16 14:02:28', NULL, '2025-01-26 07:06:17', NULL, '2', NULL);
INSERT INTO `sku_stock` VALUES (10, 10, 255, 0, 255, 356, 1, '2025-01-24 12:36:51', NULL, '2025-05-04 18:38:20', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (11, 11, 255, 0, 255, 186, 1, '2025-01-24 12:36:51', NULL, '2025-04-06 18:42:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (12, 12, 255, 0, 255, 88, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:06:29', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (13, 13, 255, 0, 255, 65, 1, '2025-01-24 12:36:51', NULL, '2025-05-04 18:38:12', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (14, 14, 255, 0, 255, 188, 1, '2025-01-24 12:36:51', NULL, '2025-01-26 07:06:36', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (15, 15, 254, 0, 254, 224, 1, '2025-01-24 12:36:51', NULL, '2025-04-07 01:07:33', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (16, 16, 299, 4, 295, 101, 1, '2025-05-01 16:40:20', NULL, '2025-05-06 06:25:15', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (17, 17, 500, 0, 500, 123, 1, '2025-05-01 16:40:44', NULL, '2025-05-04 18:37:57', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (18, 18, 563, 0, 563, 432, 1, '2025-05-01 16:41:06', NULL, '2025-05-14 15:33:54', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (19, 19, 778, 0, 778, 126, 1, '2025-05-01 16:41:26', NULL, '2025-05-04 18:37:36', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (20, 20, 761, 2, 759, 456, 1, '2025-05-01 16:41:45', NULL, '2025-05-05 09:16:07', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (21, 21, 124, 0, 124, 567, 1, '2025-05-01 16:42:00', NULL, '2025-05-01 16:42:00', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (22, 22, 343, 0, 343, 123, 1, '2025-05-03 04:25:49', NULL, '2025-05-04 18:37:16', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (23, 23, 463, 0, 463, 461, 1, '2025-05-03 04:26:04', NULL, '2025-05-03 04:26:04', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (24, 24, 774, 0, 774, 231, 1, '2025-05-03 04:26:17', NULL, '2025-05-03 04:26:17', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (25, 25, 999, 0, 999, 1314, 1, '2025-05-03 04:26:32', NULL, '2025-05-03 04:26:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (26, 26, 111, 0, 111, 211, 1, '2025-05-03 04:26:45', NULL, '2025-05-03 04:26:45', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (27, 27, 136, 0, 136, 632, 1, '2025-05-03 04:26:58', NULL, '2025-05-03 04:26:58', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (28, 28, 354, 0, 354, 133, 1, '2025-05-03 04:27:14', NULL, '2025-05-03 04:27:14', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (29, 29, 233, 0, 233, 653, 1, '2025-05-03 04:27:29', NULL, '2025-05-14 15:34:00', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (47, 47, 999, 0, 999, 1, 1, '2025-05-06 16:44:38', NULL, '2025-05-12 16:35:33', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (48, 48, 1000, 0, 1000, 0, 1, '2025-05-06 16:44:38', NULL, '2025-05-06 16:44:38', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (49, 49, 1000, 0, 1000, 0, 1, '2025-05-06 16:44:38', NULL, '2025-05-06 16:44:38', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (50, 50, 999, 0, 999, 1, 1, '2025-05-06 17:02:13', NULL, '2025-07-30 12:45:39', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (51, 51, 1000, 0, 1000, 0, 1, '2025-05-06 17:02:13', NULL, '2025-05-06 17:02:13', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (52, 52, 993, 0, 993, 7, 1, '2025-05-06 17:18:51', NULL, '2025-05-15 16:18:51', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (53, 53, 1000, 0, 1000, 0, 1, '2025-05-06 17:18:51', NULL, '2025-05-06 17:18:51', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (54, 54, 1000, 0, 1000, 0, 1, '2025-05-06 17:24:06', NULL, '2025-07-30 12:50:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (55, 55, 1000, 0, 1000, 0, 1, '2025-05-06 17:24:06', NULL, '2025-05-06 17:24:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (56, 56, 992, 0, 992, 8, 1, '2025-05-06 17:30:11', NULL, '2025-05-28 17:12:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (57, 57, 1000, 0, 1000, 0, 1, '2025-05-06 17:30:11', NULL, '2025-05-06 17:30:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (58, 58, 1000, 0, 1000, 0, 1, '2025-05-06 17:30:11', NULL, '2025-05-06 17:30:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (59, 59, 2029, 0, 2029, 3, 1, '2025-05-06 17:35:03', NULL, '2025-05-15 16:18:51', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (60, 60, 2032, 0, 2032, 0, 1, '2025-05-06 17:35:03', NULL, '2025-05-06 17:35:03', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (61, 61, 3240, 0, 3240, 2, 1, '2025-05-06 17:41:22', NULL, '2025-05-09 13:38:35', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (62, 62, 3242, 0, 3242, 321, 1, '2025-05-06 17:41:22', NULL, '2025-05-14 09:30:47', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (63, 63, 1321, 0, 1321, 0, 1, '2025-05-06 17:45:29', NULL, '2025-05-06 17:45:29', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (64, 64, 1318, 0, 1318, 3, 1, '2025-05-06 17:45:29', NULL, '2025-05-15 17:09:40', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (65, 65, 2341, 0, 2341, 0, 1, '2025-05-06 17:52:13', NULL, '2025-05-06 17:52:13', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (66, 66, 2341, 0, 2341, 0, 1, '2025-05-06 17:52:13', NULL, '2025-05-06 17:52:13', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (67, 67, 6786, 0, 6786, 0, 1, '2025-05-06 18:08:50', NULL, '2025-05-06 18:08:50', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (68, 68, 6786, 0, 6786, 0, 1, '2025-05-06 18:08:50', NULL, '2025-05-06 18:08:50', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (69, 69, 1238, 0, 1238, 0, 1, '2025-05-09 10:00:44', NULL, '2025-05-09 10:00:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (70, 70, 2133, 0, 2133, 5, 1, '2025-05-14 07:47:16', NULL, '2025-07-20 18:32:12', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (71, 71, 3424, 0, 3424, 0, 1, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (72, 72, 668, 0, 668, 0, 1, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (73, 73, 4568, 0, 4568, 0, 1, '2025-05-14 07:55:54', NULL, '2025-05-14 07:55:54', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (74, 74, 225, 0, 225, 3, 1, '2025-05-14 07:55:54', NULL, '2025-05-15 16:27:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (75, 75, 383, 0, 383, 0, 1, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (76, 76, 1706, 0, 1706, 0, 1, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (77, 77, 6817, 0, 6817, 4, 1, '2025-05-14 08:03:31', NULL, '2025-07-30 12:48:15', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (78, 78, 1274, 0, 1274, 0, 1, '2025-05-14 08:03:31', NULL, '2025-05-14 08:03:31', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (79, 79, 591, 0, 591, 0, 1, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (80, 80, 1470, 0, 1470, 0, 1, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (81, 81, 1363, 0, 1363, 0, 1, '2025-05-14 08:09:18', NULL, '2025-05-14 08:09:18', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (82, 82, 223, 0, 223, 8, 1, '2025-05-14 08:13:56', NULL, '2025-05-15 17:17:12', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (83, 83, 731, 0, 731, 0, 1, '2025-05-14 08:13:56', NULL, '2025-05-14 08:13:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (84, 84, 4351, 0, 4351, 0, 1, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (85, 85, 1311, 0, 1311, 0, 1, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (86, 86, 1351, 0, 1351, 0, 1, '2025-05-14 08:20:08', NULL, '2025-05-14 08:20:08', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (87, 87, 242, 0, 242, 0, 1, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (88, 88, 4272, 0, 4272, 0, 1, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (89, 89, 1352, 0, 1352, 0, 1, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (90, 90, 2351, 0, 2351, 0, 1, '2025-05-14 08:42:56', NULL, '2025-05-14 08:42:56', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (91, 91, 312, 0, 312, 2, 1, '2025-05-14 08:56:57', NULL, '2025-07-30 14:49:42', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (92, 92, 1579, 0, 1579, 2, 1, '2025-05-14 08:56:57', NULL, '2025-05-28 17:48:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (93, 93, 972, 0, 972, 0, 1, '2025-05-14 09:06:18', NULL, '2025-05-14 09:06:18', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (94, 94, 276, 0, 276, 3, 1, '2025-05-14 09:11:06', NULL, '2025-05-15 17:01:40', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (95, 95, 729, 0, 729, 2, 1, '2025-05-14 09:17:04', NULL, '2025-05-28 17:12:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (96, 96, 363, 0, 363, 8, 1, '2025-05-14 09:25:31', NULL, '2025-07-31 07:16:23', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (97, 97, 831, 0, 831, 0, 1, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (98, 98, 472, 0, 472, 0, 1, '2025-05-14 09:25:31', NULL, '2025-05-14 09:25:31', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (99, 99, 358, 0, 358, 0, 1, '2025-05-14 09:25:31', NULL, '2025-07-20 18:32:12', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (100, 100, 409, 0, 409, 2, 1, '2025-05-14 09:50:00', NULL, '2025-05-15 17:15:14', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (101, 101, 900, 0, 900, 0, 1, '2025-05-14 09:50:00', NULL, '2025-07-30 12:45:39', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (102, 102, 900, 0, 900, 0, 1, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (103, 103, 765, 0, 765, 0, 1, '2025-05-14 09:50:00', NULL, '2025-05-14 09:50:00', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (104, 104, 780, 0, 780, 2, 1, '2025-05-14 09:58:57', NULL, '2025-07-30 12:48:15', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (105, 105, 638, 0, 638, 3, 1, '2025-05-14 09:58:57', NULL, '2025-05-15 17:01:40', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (106, 106, 2312, 0, 2312, 0, 1, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (107, 107, 3420, 0, 3420, 1, 1, '2025-05-14 19:00:28', NULL, '2025-05-29 07:15:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (108, 108, 2341, 0, 2341, 0, 1, '2025-05-14 19:00:28', NULL, '2025-05-14 19:00:28', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (109, 109, 678, 0, 678, 11, 1, '2025-05-14 19:00:28', NULL, '2025-07-02 09:52:03', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (110, 110, 1342, 0, 1342, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (111, 111, 2341, 0, 2341, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (112, 112, 731, 0, 731, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (113, 113, 952, 0, 952, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (114, 114, 987, 0, 987, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (115, 115, 679, 0, 679, 0, 1, '2025-05-23 13:56:09', NULL, '2025-05-23 13:56:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (116, 116, 1333, 0, 1333, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (117, 117, 2471, 0, 2471, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (118, 118, 1533, 0, 1533, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (119, 119, 622, 0, 622, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (120, 120, 1236, 0, 1236, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (121, 121, 1333, 0, 1333, 0, 1, '2025-05-23 14:03:44', NULL, '2025-05-23 14:03:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (122, 122, 1381, 0, 1381, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (123, 123, 4611, 0, 4611, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (124, 124, 3791, 0, 3791, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (125, 125, 3511, 0, 3511, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (126, 126, 3261, 0, 3261, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (127, 127, 742, 0, 742, 0, 1, '2025-05-23 14:12:32', NULL, '2025-05-23 14:12:32', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (134, 134, 322, 0, 322, 2, 1, '2025-05-23 15:02:21', NULL, '2025-05-23 15:09:22', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (135, 135, 1212, 0, 1212, 2, 1, '2025-05-23 15:02:21', NULL, '2025-05-23 15:09:22', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (136, 136, 4772, 0, 4772, 2, 1, '2025-05-23 15:02:21', NULL, '2025-05-23 15:09:14', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (137, 137, 2311, 0, 2311, 2, 1, '2025-05-23 15:02:21', NULL, '2025-05-23 15:09:22', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (138, 138, 1245, 0, 1245, 2, 1, '2025-05-23 15:02:21', NULL, '2025-05-23 15:09:16', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (139, 139, 3611, 0, 3611, 2, 1, '2025-05-23 15:02:22', NULL, '2025-05-23 15:09:22', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (140, 140, 431, 0, 431, 0, 1, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (141, 141, 2372, 0, 2372, 0, 1, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (142, 142, 342, 0, 342, 0, 1, '2025-05-23 15:37:06', NULL, '2025-05-23 15:37:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (143, 143, 1230, 0, 1230, 1, 1, '2025-05-23 15:37:06', NULL, '2025-05-29 07:15:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (144, 144, 6421, 0, 6421, 1, 1, '2025-05-23 15:37:06', NULL, '2025-07-30 14:49:42', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (145, 145, 2357, 0, 2357, 1, 1, '2025-05-23 15:37:06', NULL, '2025-07-31 07:16:23', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (146, 146, 2357, 0, 2357, 0, 1, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (147, 147, 792, 0, 792, 0, 1, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (148, 148, 952, 0, 952, 0, 1, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (149, 149, 2125, 0, 2125, 0, 1, '2025-05-23 15:45:06', NULL, '2025-05-23 15:45:06', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (150, 150, 127, 0, 127, 0, 1, '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (151, 151, 463, 0, 463, 0, 1, '2025-05-23 15:51:27', NULL, '2025-05-23 15:51:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (152, 152, 532, 0, 532, 0, 1, '2025-05-23 15:57:22', NULL, '2025-05-23 15:57:22', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (153, 153, 431, 0, 431, 0, 1, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (154, 154, 3222, 0, 3222, 0, 1, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (155, 155, 2131, 0, 2131, 0, 1, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (156, 156, 842, 0, 842, 0, 1, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (157, 157, 3572, 0, 3572, 0, 1, '2025-05-23 16:03:21', NULL, '2025-05-23 16:03:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (158, 158, 1248, 0, 1248, 4, 1, '2025-05-23 16:12:11', NULL, '2025-05-29 03:56:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (159, 159, 2351, 0, 2351, 0, 1, '2025-05-23 16:12:11', NULL, '2025-05-23 16:12:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (160, 160, 1463, 0, 1463, 0, 1, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (161, 161, 1245, 0, 1245, 0, 1, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (162, 162, 1864, 0, 1864, 0, 1, '2025-05-23 16:18:23', NULL, '2025-05-23 16:18:23', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (163, 163, 3618, 0, 3618, 3, 1, '2025-05-23 16:24:05', NULL, '2025-05-29 07:15:44', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (164, 164, 2316, 0, 2316, 0, 1, '2025-05-23 16:24:05', NULL, '2025-05-23 16:24:05', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (165, 165, 1595, 0, 1595, 0, 1, '2025-05-23 16:28:39', NULL, '2025-05-23 16:28:39', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (166, 166, 630, 0, 630, 2, 1, '2025-05-23 16:28:39', NULL, '2025-05-29 03:56:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (167, 167, 3794, 0, 3794, 0, 1, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (168, 168, 962, 0, 962, 0, 1, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (169, 169, 642, 0, 642, 0, 1, '2025-05-23 16:34:35', NULL, '2025-05-23 16:34:35', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (170, 170, 2691, 0, 2691, 0, 1, '2025-05-27 09:43:55', NULL, '2025-05-27 09:43:55', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (171, 171, 1233, 0, 1233, 4, 1, '2025-05-27 09:43:55', NULL, '2025-05-28 17:48:21', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (172, 172, 100, 0, 100, 0, 1, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (173, 173, 100, 0, 100, 0, 1, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (174, 174, 100, 0, 100, 0, 1, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (175, 175, 100, 0, 100, 0, 1, '2025-05-29 07:05:30', NULL, '2025-05-29 07:05:30', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (176, 176, 100, 0, 100, 0, 1, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (177, 177, 100, 0, 100, 0, 1, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (178, 178, 100, 0, 100, 0, 1, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (179, 179, 100, 0, 100, 0, 1, '2025-07-30 12:17:11', NULL, '2025-07-30 12:17:11', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (180, 180, 1000, 0, 1000, 0, 1, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (181, 181, 1000, 0, 1000, 0, 1, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (182, 182, 1000, 0, 1000, 0, 1, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (183, 183, 1000, 0, 1000, 0, 1, '2025-07-30 12:29:27', NULL, '2025-07-30 12:29:27', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (184, 184, 100, 0, 100, 0, 1, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (185, 185, 100, 0, 100, 0, 1, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (186, 186, 100, 0, 100, 0, 1, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (187, 187, 100, 0, 100, 0, 1, '2025-07-31 17:58:09', NULL, '2025-07-31 17:58:09', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (188, 188, 100, 0, 100, 0, 1, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (189, 189, 100, 0, 100, 0, 1, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (190, 190, 100, 0, 100, 0, 1, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);
INSERT INTO `sku_stock` VALUES (191, 191, 100, 0, 100, 0, 1, '2025-07-31 18:10:28', NULL, '2025-07-31 18:10:28', NULL, '0', NULL);

SET FOREIGN_KEY_CHECKS = 1;
