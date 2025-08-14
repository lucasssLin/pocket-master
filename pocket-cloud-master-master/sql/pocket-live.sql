/*
 Navicat Premium Data Transfer

 Source Server         : linux-105
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.1.12:5781
 Source Schema         : pocket-live

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/08/2025 23:43:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for live_gift
-- ----------------------------
DROP TABLE IF EXISTS `live_gift`;
CREATE TABLE `live_gift`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '礼物名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '礼物图标',
  `animation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '礼物动画',
  `price` decimal(10, 2) NOT NULL COMMENT '礼物价格',
  `sort_order` int NOT NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '礼物配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live_gift
-- ----------------------------
INSERT INTO `live_gift` VALUES (1, '鲜花', '/static/images/gifts/flower.png', NULL, 1.00, 1, 1, 'system', '2025-07-18 18:58:21', '', '2025-07-18 18:58:21', '表达喜爱的鲜花', '0');
INSERT INTO `live_gift` VALUES (2, '掌声', '/static/images/gifts/applause.png', NULL, 2.00, 2, 1, 'system', '2025-07-18 18:58:21', '', '2025-07-18 18:58:21', '热烈的掌声', '0');
INSERT INTO `live_gift` VALUES (3, '咖啡', '/static/images/gifts/coffee.png', NULL, 5.00, 3, 1, 'system', '2025-07-18 18:58:21', '', '2025-07-18 18:58:21', '提神醒脑的咖啡', '0');

-- ----------------------------
-- Table structure for live_room
-- ----------------------------
DROP TABLE IF EXISTS `live_room`;
CREATE TABLE `live_room`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '直播间唯一标识',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '直播间标题',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '直播间描述',
  `streamer_id` bigint NOT NULL COMMENT '主播用户ID',
  `streamer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主播用户名',
  `product_id` bigint NULL DEFAULT NULL COMMENT '关联商品ID（可选，用于商品直播）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '直播间状态: 0-未开始, 1-直播中, 2-已结束, 3-已暂停',
  `viewer_count` int NOT NULL DEFAULT 0 COMMENT '当前观看人数',
  `total_viewers` int NOT NULL DEFAULT 0 COMMENT '总观看人数',
  `like_count` int NOT NULL DEFAULT 0 COMMENT '点赞数',
  `start_time` datetime NULL DEFAULT NULL COMMENT '直播开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '直播结束时间',
  `cover_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '直播间封面图',
  `replay_enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否支持回放: 0-不支持, 1-支持',
  `replay_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回放视频URL',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_streamer_id`(`streamer_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '直播间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live_room
-- ----------------------------
INSERT INTO `live_room` VALUES (1, 'demo_room_001', 'test', NULL, 1, 'streamer_117', NULL, 2, 0, 0, 0, '2025-07-22 20:52:36', '2025-07-22 20:53:11', NULL, 1, NULL, '', '2025-07-19 16:22:57', '', '2025-07-23 14:43:02', NULL, '0');
INSERT INTO `live_room` VALUES (2, 'live_1753266487408_67e824bd', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 2, 0, 0, 0, '2025-07-23 10:28:12', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 10:28:08', '', '2025-07-25 18:42:41', NULL, '0');
INSERT INTO `live_room` VALUES (3, 'live_1753274008384_21bc059c', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 2, 0, 0, 0, '2025-07-23 12:33:30', '2025-07-23 13:02:41', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 12:33:29', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (4, 'live_1753276871929_23c34fce', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 2, 0, 0, 0, '2025-07-23 13:21:15', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 13:21:12', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (5, 'live_1753277452819_1c2ae777', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 2, 0, 0, 0, '2025-07-23 13:30:56', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 13:30:53', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (6, 'live_1753281809161_c9e92805', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 1, 0, 0, 0, '2025-07-23 14:43:32', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 14:43:30', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (7, 'live_1753285446108_3cb1447a', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 1, 0, 0, 0, '2025-07-23 15:44:08', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 15:44:07', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (8, 'live_1753301565023_1bdd11ba', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 1, 0, 0, 0, '2025-07-23 20:12:47', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-23 20:12:46', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (9, 'live_1753462012628_e21829fb', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 2, 0, 0, 0, '2025-07-25 16:46:55', '2025-07-25 16:47:02', 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-25 16:46:53', '', '2025-07-25 18:42:52', NULL, '0');
INSERT INTO `live_room` VALUES (31, 'live_1753486784991_f1fbf6c3', 'admin的直播间', '欢迎来到我的直播间！', 1, '', NULL, 1, 0, 0, 0, '2025-07-25 23:39:47', NULL, 'https://pocketapp.mynatapp.cc/minio/pocket/2025/05/29/unnamed.png', 1, NULL, '', '2025-07-25 23:39:45', '', '2025-07-25 23:40:57', NULL, '0');

-- ----------------------------
-- Table structure for live_room_chat
-- ----------------------------
DROP TABLE IF EXISTS `live_room_chat`;
CREATE TABLE `live_room_chat`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '直播间ID',
  `user_id` bigint NOT NULL COMMENT '发送用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发送用户名',
  `message_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'text' COMMENT '消息类型: text-文本, image-图片, gift-礼物',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `send_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除: 0-未删除, 1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_send_time`(`send_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '直播间聊天记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live_room_chat
-- ----------------------------

-- ----------------------------
-- Table structure for live_room_gift
-- ----------------------------
DROP TABLE IF EXISTS `live_room_gift`;
CREATE TABLE `live_room_gift`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '直播间ID',
  `sender_id` bigint NOT NULL COMMENT '送礼用户ID',
  `sender_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '送礼用户名',
  `receiver_id` bigint NOT NULL COMMENT '接收者ID（主播）',
  `receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接收者用户名',
  `gift_id` bigint NOT NULL COMMENT '礼物ID',
  `gift_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '礼物名称',
  `gift_count` int NOT NULL DEFAULT 1 COMMENT '礼物数量',
  `gift_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '礼物单价',
  `total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '总金额',
  `send_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '送礼时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_receiver_id`(`receiver_id` ASC) USING BTREE,
  INDEX `idx_send_time`(`send_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '直播间礼物记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live_room_gift
-- ----------------------------

-- ----------------------------
-- Table structure for live_room_viewer
-- ----------------------------
DROP TABLE IF EXISTS `live_room_viewer`;
CREATE TABLE `live_room_viewer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '直播间ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `join_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `leave_time` datetime NULL DEFAULT NULL COMMENT '离开时间',
  `duration` int NULL DEFAULT 0 COMMENT '观看时长（秒）',
  `is_online` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否在线: 0-离线, 1-在线',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_room_user`(`room_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_join_time`(`join_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '直播间观看记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live_room_viewer
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
