/*
 Navicat Premium Data Transfer

 Source Server         : linux-105
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.1.12:5781
 Source Schema         : pocket-cloud

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/08/2025 23:41:48
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
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-01-21 12:46:52', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-01-21 12:46:52', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-01-21 12:46:52', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-01-21 12:46:52', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-01-21 12:46:52', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'Pocket', 0, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', 'Shenzhen', 1, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', 'Beijing', 2, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, 'Sam', '15888888888', '', '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-01-21 12:46:52', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-01-21 12:46:52', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-01-21 12:46:52', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-01-21 12:46:52', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示信息',
  `access_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`access_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 337 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-22 05:47:59');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-22 07:36:53');
INSERT INTO `sys_logininfor` VALUES (102, 'ry', '127.0.0.1', '0', '登录成功', '2025-01-22 07:37:12');
INSERT INTO `sys_logininfor` VALUES (103, 'ry', '127.0.0.1', '0', '退出成功', '2025-01-22 08:03:17');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-22 08:03:23');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-23 15:25:07');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-23 15:25:12');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-23 17:13:16');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-23 18:02:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-23 18:05:05');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-24 09:16:20');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-24 09:16:24');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 08:54:57');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 08:55:03');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 13:22:12');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 13:22:27');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 13:23:02');
INSERT INTO `sys_logininfor` VALUES (117, 'sam', '127.0.0.1', '0', '登录成功', '2025-01-25 13:23:08');
INSERT INTO `sys_logininfor` VALUES (118, 'sam', '127.0.0.1', '0', '退出成功', '2025-01-25 13:24:34');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 13:24:37');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 13:25:34');
INSERT INTO `sys_logininfor` VALUES (121, 'sam', '127.0.0.1', '0', '登录成功', '2025-01-25 13:25:44');
INSERT INTO `sys_logininfor` VALUES (122, 'sam', '127.0.0.1', '0', '退出成功', '2025-01-25 13:26:20');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 13:26:24');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 13:26:47');
INSERT INTO `sys_logininfor` VALUES (125, 'sam', '127.0.0.1', '0', '登录成功', '2025-01-25 13:26:54');
INSERT INTO `sys_logininfor` VALUES (126, 'sam', '127.0.0.1', '0', '退出成功', '2025-01-25 13:27:49');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 13:27:53');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 13:28:09');
INSERT INTO `sys_logininfor` VALUES (129, 'sam', '127.0.0.1', '0', '登录成功', '2025-01-25 13:28:15');
INSERT INTO `sys_logininfor` VALUES (130, 'sam', '127.0.0.1', '0', '退出成功', '2025-01-25 13:28:45');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 13:28:49');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 15:00:49');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 15:00:54');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-25 15:01:31');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-25 15:01:42');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '0', '退出成功', '2025-01-26 15:25:01');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '0', '登录成功', '2025-01-26 15:25:08');
INSERT INTO `sys_logininfor` VALUES (138, '17722863834', '127.0.0.1', '0', 'Register success', '2025-02-04 12:18:40');
INSERT INTO `sys_logininfor` VALUES (139, '17722863834', '127.0.0.1', '0', 'Login success', '2025-02-04 12:20:44');
INSERT INTO `sys_logininfor` VALUES (140, '13380286293', '127.0.0.1', '0', 'Register success', '2025-02-04 12:43:48');
INSERT INTO `sys_logininfor` VALUES (141, '17722863834', '127.0.0.1', '0', 'Login success', '2025-02-04 12:45:11');
INSERT INTO `sys_logininfor` VALUES (142, '17722863834', '127.0.0.1', '0', '退出成功', '2025-02-04 12:46:00');
INSERT INTO `sys_logininfor` VALUES (143, '17722863834', '127.0.0.1', '0', 'Login success', '2025-02-04 12:47:13');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '0', '登录成功', '2025-04-29 16:46:48');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '0', '退出成功', '2025-04-29 17:07:05');
INSERT INTO `sys_logininfor` VALUES (146, 'sam', '127.0.0.1', '0', '登录成功', '2025-04-29 17:07:10');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '0', '登录成功', '2025-04-30 03:52:29');
INSERT INTO `sys_logininfor` VALUES (148, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-01 04:32:18');
INSERT INTO `sys_logininfor` VALUES (149, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-01 04:32:18');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-01 16:00:50');
INSERT INTO `sys_logininfor` VALUES (151, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 08:00:27');
INSERT INTO `sys_logininfor` VALUES (152, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 08:02:34');
INSERT INTO `sys_logininfor` VALUES (153, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 08:03:55');
INSERT INTO `sys_logininfor` VALUES (154, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-05 08:04:13');
INSERT INTO `sys_logininfor` VALUES (155, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 08:59:46');
INSERT INTO `sys_logininfor` VALUES (156, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 10:33:44');
INSERT INTO `sys_logininfor` VALUES (157, '13700032456', '127.0.0.1', '1', '密码输入错误1次', '2025-05-05 10:33:47');
INSERT INTO `sys_logininfor` VALUES (158, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 10:34:08');
INSERT INTO `sys_logininfor` VALUES (159, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-05 10:34:47');
INSERT INTO `sys_logininfor` VALUES (160, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 10:34:55');
INSERT INTO `sys_logininfor` VALUES (161, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-05 10:35:32');
INSERT INTO `sys_logininfor` VALUES (162, '17722863834', '127.0.0.1', '1', '密码输入错误1次', '2025-05-06 04:50:41');
INSERT INTO `sys_logininfor` VALUES (163, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-06 04:50:44');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-06 06:37:55');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '0', '退出成功', '2025-05-06 06:38:11');
INSERT INTO `sys_logininfor` VALUES (166, 'sam', '127.0.0.1', '0', '登录成功', '2025-05-06 06:38:46');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-06 15:03:21');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '0', '退出成功', '2025-05-06 15:03:27');
INSERT INTO `sys_logininfor` VALUES (169, 'sam', '127.0.0.1', '0', '登录成功', '2025-05-06 15:03:32');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-06 15:04:33');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-06 16:16:47');
INSERT INTO `sys_logininfor` VALUES (172, '17722863834', '192.168.1.53', '1', '密码输入错误1次', '2025-05-06 17:06:10');
INSERT INTO `sys_logininfor` VALUES (173, '17722863834', '192.168.1.53', '0', 'Login success', '2025-05-06 17:06:17');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '0', '退出成功', '2025-05-07 04:41:44');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '192.168.1.55', '0', '登录成功', '2025-05-09 09:51:55');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '192.168.1.55', '0', '退出成功', '2025-05-09 09:51:59');
INSERT INTO `sys_logininfor` VALUES (177, 'sam', '192.168.1.55', '0', '登录成功', '2025-05-09 09:52:04');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-09 09:55:47');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-09 13:17:00');
INSERT INTO `sys_logininfor` VALUES (180, 'sam', '127.0.0.1', '0', '登录成功', '2025-05-10 08:14:44');
INSERT INTO `sys_logininfor` VALUES (181, 'sam', '127.0.0.1', '0', '退出成功', '2025-05-10 08:17:18');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '0', '登录成功', '2025-05-10 08:17:27');
INSERT INTO `sys_logininfor` VALUES (183, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-12 16:14:57');
INSERT INTO `sys_logininfor` VALUES (184, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-12 16:30:46');
INSERT INTO `sys_logininfor` VALUES (185, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-12 16:34:45');
INSERT INTO `sys_logininfor` VALUES (186, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-12 16:34:49');
INSERT INTO `sys_logininfor` VALUES (187, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-12 16:35:38');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '192.168.1.12', '0', '登录成功', '2025-05-12 16:35:42');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '192.168.1.12', '0', '退出成功', '2025-05-12 16:35:57');
INSERT INTO `sys_logininfor` VALUES (190, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-12 16:36:01');
INSERT INTO `sys_logininfor` VALUES (191, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-12 16:38:27');
INSERT INTO `sys_logininfor` VALUES (192, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-12 16:38:32');
INSERT INTO `sys_logininfor` VALUES (193, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-14 07:39:26');
INSERT INTO `sys_logininfor` VALUES (194, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 10:36:41');
INSERT INTO `sys_logininfor` VALUES (195, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-14 10:42:02');
INSERT INTO `sys_logininfor` VALUES (196, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 10:42:13');
INSERT INTO `sys_logininfor` VALUES (197, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 11:10:39');
INSERT INTO `sys_logininfor` VALUES (198, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-14 11:36:00');
INSERT INTO `sys_logininfor` VALUES (199, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 11:40:30');
INSERT INTO `sys_logininfor` VALUES (200, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-14 11:53:41');
INSERT INTO `sys_logininfor` VALUES (201, '17725863834', '127.0.0.1', '1', 'Login user is not existed', '2025-05-14 14:45:41');
INSERT INTO `sys_logininfor` VALUES (202, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 14:45:49');
INSERT INTO `sys_logininfor` VALUES (203, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-14 15:12:40');
INSERT INTO `sys_logininfor` VALUES (204, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 15:51:16');
INSERT INTO `sys_logininfor` VALUES (205, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-14 16:04:06');
INSERT INTO `sys_logininfor` VALUES (206, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 16:05:22');
INSERT INTO `sys_logininfor` VALUES (207, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-14 16:49:03');
INSERT INTO `sys_logininfor` VALUES (208, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-15 04:28:39');
INSERT INTO `sys_logininfor` VALUES (209, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-15 16:09:03');
INSERT INTO `sys_logininfor` VALUES (210, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-15 17:45:10');
INSERT INTO `sys_logininfor` VALUES (211, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-23 13:43:20');
INSERT INTO `sys_logininfor` VALUES (212, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-23 13:46:30');
INSERT INTO `sys_logininfor` VALUES (213, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-24 05:25:51');
INSERT INTO `sys_logininfor` VALUES (214, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-24 15:38:28');
INSERT INTO `sys_logininfor` VALUES (215, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-24 15:38:35');
INSERT INTO `sys_logininfor` VALUES (216, '17722863834', '127.0.0.1', '1', '密码输入错误1次', '2025-05-24 16:16:18');
INSERT INTO `sys_logininfor` VALUES (217, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-24 16:16:22');
INSERT INTO `sys_logininfor` VALUES (218, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-24 22:13:49');
INSERT INTO `sys_logininfor` VALUES (219, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-25 06:42:35');
INSERT INTO `sys_logininfor` VALUES (220, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-25 09:21:54');
INSERT INTO `sys_logininfor` VALUES (221, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-27 08:13:19');
INSERT INTO `sys_logininfor` VALUES (222, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-27 08:29:48');
INSERT INTO `sys_logininfor` VALUES (223, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-27 09:36:07');
INSERT INTO `sys_logininfor` VALUES (224, 'Peter', '192.168.1.12', '1', '密码输入错误1次', '2025-05-27 10:41:28');
INSERT INTO `sys_logininfor` VALUES (225, 'Sam', '192.168.1.12', '0', '登录成功', '2025-05-27 10:41:50');
INSERT INTO `sys_logininfor` VALUES (226, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-27 17:39:01');
INSERT INTO `sys_logininfor` VALUES (227, 'Sam', '192.168.1.12', '0', '登录成功', '2025-05-27 17:39:28');
INSERT INTO `sys_logininfor` VALUES (228, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-27 17:56:12');
INSERT INTO `sys_logininfor` VALUES (229, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-28 13:33:01');
INSERT INTO `sys_logininfor` VALUES (230, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-28 13:33:52');
INSERT INTO `sys_logininfor` VALUES (231, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-28 13:35:25');
INSERT INTO `sys_logininfor` VALUES (232, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-28 16:30:46');
INSERT INTO `sys_logininfor` VALUES (233, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-28 17:58:00');
INSERT INTO `sys_logininfor` VALUES (234, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-28 17:58:20');
INSERT INTO `sys_logininfor` VALUES (235, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-29 03:52:35');
INSERT INTO `sys_logininfor` VALUES (236, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-29 06:53:16');
INSERT INTO `sys_logininfor` VALUES (237, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-29 06:53:22');
INSERT INTO `sys_logininfor` VALUES (238, 'sam', '192.168.1.12', '0', '退出成功', '2025-05-29 06:53:27');
INSERT INTO `sys_logininfor` VALUES (239, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-29 06:59:39');
INSERT INTO `sys_logininfor` VALUES (240, '17722863834', '127.0.0.1', '0', '退出成功', '2025-05-29 07:10:36');
INSERT INTO `sys_logininfor` VALUES (241, '17722863833', '127.0.0.1', '0', 'Register success', '2025-05-29 07:11:14');
INSERT INTO `sys_logininfor` VALUES (242, '17722863833', '127.0.0.1', '1', '密码输入错误1次', '2025-05-29 07:11:23');
INSERT INTO `sys_logininfor` VALUES (243, '17722863833', '127.0.0.1', '1', '密码输入错误2次', '2025-05-29 07:11:26');
INSERT INTO `sys_logininfor` VALUES (244, '17722863834', '127.0.0.1', '1', '密码输入错误1次', '2025-05-29 07:11:33');
INSERT INTO `sys_logininfor` VALUES (245, '17722863834', '127.0.0.1', '0', 'Login success', '2025-05-29 07:11:37');
INSERT INTO `sys_logininfor` VALUES (246, 'sam', '192.168.1.12', '0', '登录成功', '2025-05-30 05:38:21');
INSERT INTO `sys_logininfor` VALUES (247, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-02 09:45:43');
INSERT INTO `sys_logininfor` VALUES (248, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-04 18:49:07');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '192.168.1.12', '0', '登录成功', '2025-07-19 09:31:45');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '192.168.1.12', '0', '登录成功', '2025-07-19 11:57:19');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '192.168.1.12', '0', '退出成功', '2025-07-19 11:57:19');
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '192.168.1.12', '0', '登录成功', '2025-07-19 11:57:30');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '192.168.1.55', '0', '登录成功', '2025-07-19 14:52:28');
INSERT INTO `sys_logininfor` VALUES (254, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-20 18:02:09');
INSERT INTO `sys_logininfor` VALUES (255, '17722863834', '127.0.0.1', '0', '退出成功', '2025-07-20 18:12:20');
INSERT INTO `sys_logininfor` VALUES (256, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-20 18:13:24');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '192.168.1.12', '0', '登录成功', '2025-07-20 18:32:31');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '192.168.1.55', '0', '登录成功', '2025-07-22 20:10:35');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '192.168.1.55', '0', '登录成功', '2025-07-22 20:47:38');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '192.168.1.55', '0', '退出成功', '2025-07-23 10:15:17');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '192.168.1.55', '0', '登录成功', '2025-07-23 10:15:20');
INSERT INTO `sys_logininfor` VALUES (262, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-23 12:31:54');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-23 13:21:33');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-23 13:21:37');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-25 16:41:42');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 16:41:47');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-25 16:44:50');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-25 16:46:04');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 16:46:10');
INSERT INTO `sys_logininfor` VALUES (270, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-25 18:38:42');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-25 19:53:30');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 19:53:36');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-25 19:58:45');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 19:58:49');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 20:00:25');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 20:05:03');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-26 19:55:28');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-27 15:40:27');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-27 15:40:31');
INSERT INTO `sys_logininfor` VALUES (280, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-27 17:00:19');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 09:53:13');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 09:53:40');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 09:59:09');
INSERT INTO `sys_logininfor` VALUES (284, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-30 11:51:08');
INSERT INTO `sys_logininfor` VALUES (285, '17722863834', '127.0.0.1', '0', '退出成功', '2025-07-30 12:00:33');
INSERT INTO `sys_logininfor` VALUES (286, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 12:01:32');
INSERT INTO `sys_logininfor` VALUES (287, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 12:02:14');
INSERT INTO `sys_logininfor` VALUES (288, '17722863834', '127.0.0.1', '0', 'Login success', '2025-07-30 12:02:24');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 12:12:04');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 12:22:18');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 12:22:35');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 12:24:32');
INSERT INTO `sys_logininfor` VALUES (293, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 12:24:47');
INSERT INTO `sys_logininfor` VALUES (294, '17722863834', '127.0.0.1', '0', '退出成功', '2025-07-30 12:57:39');
INSERT INTO `sys_logininfor` VALUES (295, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 12:58:08');
INSERT INTO `sys_logininfor` VALUES (296, '17722863833', '127.0.0.1', '0', '退出成功', '2025-07-30 12:59:32');
INSERT INTO `sys_logininfor` VALUES (297, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 12:59:41');
INSERT INTO `sys_logininfor` VALUES (298, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 13:01:09');
INSERT INTO `sys_logininfor` VALUES (299, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 13:01:20');
INSERT INTO `sys_logininfor` VALUES (300, '17722863833', '127.0.0.1', '0', '退出成功', '2025-07-30 13:05:27');
INSERT INTO `sys_logininfor` VALUES (301, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 13:05:41');
INSERT INTO `sys_logininfor` VALUES (302, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 13:10:04');
INSERT INTO `sys_logininfor` VALUES (303, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 13:10:21');
INSERT INTO `sys_logininfor` VALUES (304, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 13:11:11');
INSERT INTO `sys_logininfor` VALUES (305, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 13:11:21');
INSERT INTO `sys_logininfor` VALUES (306, '17722863833', '127.0.0.1', '0', '退出成功', '2025-07-30 13:13:22');
INSERT INTO `sys_logininfor` VALUES (307, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 13:14:52');
INSERT INTO `sys_logininfor` VALUES (308, '17722863833', '127.0.0.1', '0', '退出成功', '2025-07-30 13:22:07');
INSERT INTO `sys_logininfor` VALUES (309, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 13:22:18');
INSERT INTO `sys_logininfor` VALUES (310, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 13:26:53');
INSERT INTO `sys_logininfor` VALUES (311, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 13:27:53');
INSERT INTO `sys_logininfor` VALUES (312, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 13:31:05');
INSERT INTO `sys_logininfor` VALUES (313, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 13:31:15');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 17:17:29');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 17:17:39');
INSERT INTO `sys_logininfor` VALUES (316, '17722863833', '127.0.0.1', '0', '退出成功', '2025-07-30 17:35:26');
INSERT INTO `sys_logininfor` VALUES (317, '12345678901', '127.0.0.1', '0', 'Login success', '2025-07-30 17:35:37');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 18:08:26');
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 18:08:39');
INSERT INTO `sys_logininfor` VALUES (320, '12345678901', '127.0.0.1', '0', '退出成功', '2025-07-30 18:19:48');
INSERT INTO `sys_logininfor` VALUES (321, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-30 18:20:03');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-30 18:40:36');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-30 18:40:45');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 00:50:09');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-31 01:24:37');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 01:24:48');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-31 05:09:00');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 05:09:06');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-31 07:08:06');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 07:09:22');
INSERT INTO `sys_logininfor` VALUES (331, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 17:54:44');
INSERT INTO `sys_logininfor` VALUES (332, '17722863834', '127.0.0.1', '1', 'Login user is not existed', '2025-07-31 18:05:23');
INSERT INTO `sys_logininfor` VALUES (333, '17722863833', '127.0.0.1', '0', 'Login success', '2025-07-31 18:05:28');
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '0', '退出成功', '2025-07-31 18:06:55');
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-31 18:07:08');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '0', '退出成功', '2025-08-13 07:13:57');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '0', '登录成功', '2025-08-13 07:14:00');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2028 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 'System Mgmt', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-01-21 12:46:51', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, 'System Monitor', 0, 5, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-25 14:40:49', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, 'System Tools', 0, 6, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-25 14:40:53', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, 'User Mgmt', 1, 1, 'systemUser', 'system/systemUser/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-01-21 12:46:51', 'sam', '2025-05-12 16:57:26', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, 'Role Mgmt', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-01-21 12:46:51', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, 'Menu Mgmt', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-01-21 12:46:51', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '1', '0', 'system:dept:list', 'tree', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:44:26', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:44:31', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:42:46', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:41:38', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '1', '0', 'system:notice:list', 'message', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:41:29', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '1', '0', '', 'log', 'admin', '2025-01-21 12:46:51', 'admin', '2025-01-22 08:42:34', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-01-21 12:46:51', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-01-21 12:46:51', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, 'Sentinel控制台', 2, 3, 'http://localhost:8718', '', '', '', 0, 0, 'C', '0', '0', 'monitor:sentinel:list', 'sentinel', 'admin', '2025-01-21 12:46:51', '', NULL, '流量控制菜单');
INSERT INTO `sys_menu` VALUES (112, 'Nacos控制台', 2, 4, 'http://localhost:8848/nacos', '', '', '', 0, 0, 'C', '0', '0', 'monitor:nacos:list', 'nacos', 'admin', '2025-01-21 12:46:51', '', NULL, '服务治理菜单');
INSERT INTO `sys_menu` VALUES (113, 'Admin控制台', 2, 5, 'http://localhost:9100/login', '', '', '', 0, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-01-21 12:46:51', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-01-21 12:46:51', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-01-21 12:46:51', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', '', 0, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-01-21 12:46:51', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'system/operlog/index', '', '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2025-01-21 12:46:51', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'system/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2025-01-21 12:46:51', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:unlock', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, 'Product Mgmt', 0, 2, 'product', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'server', 'admin', '2025-01-23 15:27:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2001, 'Brand Mgmt', 2000, 1, 'brand', 'product/brand/index', NULL, '', 1, 0, 'C', '0', '0', 'product:brand:list', 'row', 'admin', '2025-01-23 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, 'Base Data', 0, 3, 'base', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'checkbox', 'admin', '2025-01-24 10:28:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, 'Product Unit', 2002, 1, 'productUnit', 'base/productUnit/index', NULL, '', 1, 0, 'C', '0', '0', 'base:productUnit:list', 'client', 'admin', '2025-01-24 10:29:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, 'Category', 2000, 2, 'category', 'product/category/index', NULL, '', 1, 0, 'C', '0', '0', 'product:category:list', 'excel', 'admin', '2025-01-24 10:37:34', 'admin', '2025-01-24 10:41:11', '');
INSERT INTO `sys_menu` VALUES (2005, 'Category Brand', 2000, 3, 'categoryBrand', 'product/categoryBrand/index', NULL, '', 1, 0, 'C', '0', '0', 'product:categoryBrand:list', 'cascader', 'admin', '2025-01-24 10:42:01', 'admin', '2025-01-24 11:58:05', '');
INSERT INTO `sys_menu` VALUES (2006, 'Product Spec', 2000, 4, 'productSpec', 'product/productSpec/index', NULL, '', 1, 0, 'C', '0', '0', 'product:productSpec:list', 'icon', 'admin', '2025-01-24 11:59:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, 'Product List', 2000, 5, 'product', 'product/product/index', NULL, '', 1, 0, 'C', '0', '0', 'product:product:list', 'tab', 'admin', '2025-01-24 12:21:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, 'list', 2001, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'product:brand:list', '#', 'admin', '2025-01-25 13:18:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, 'query', 2001, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'product:brand:query', '#', 'admin', '2025-01-25 13:19:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, 'add', 2001, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'product:brand:add', '#', 'admin', '2025-01-25 13:19:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, 'edit', 2001, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'product:brand:edit', '#', 'admin', '2025-01-25 13:19:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, 'remove', 2001, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'product:brand:remove', '#', 'admin', '2025-01-25 13:20:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, 'User Mgmt', 0, 7, 'user', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'user', 'admin', '2025-01-25 14:40:43', 'admin', '2025-07-19 11:59:34', '');
INSERT INTO `sys_menu` VALUES (2014, 'User List', 2013, 1, 'userInfo', 'user/userInfo/index', NULL, '', 1, 0, 'C', '0', '0', 'user:info:list', '#', 'admin', '2025-01-25 14:47:17', 'admin', '2025-01-25 14:59:33', '会员菜单');
INSERT INTO `sys_menu` VALUES (2015, '会员查询', 2014, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'user:info:query', '#', 'admin', '2025-01-25 14:47:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '会员新增', 2014, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'user:info:add', '#', 'admin', '2025-01-25 14:47:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '会员修改', 2014, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'user:info:edit', '#', 'admin', '2025-01-25 14:47:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '会员删除', 2014, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'user:info:remove', '#', 'admin', '2025-01-25 14:47:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '会员导出', 2014, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'user:info:export', '#', 'admin', '2025-01-25 14:47:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, 'Order Mgmt', 0, 3, 'order', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'date-range', 'admin', '2025-01-25 16:10:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, 'Order List', 2020, 1, 'info', 'order/orderInfo/index', NULL, '', 1, 0, 'C', '0', '0', 'order:info:list', 'dashboard', 'admin', '2025-01-25 16:13:47', 'admin', '2025-05-10 12:55:39', '订单菜单');
INSERT INTO `sys_menu` VALUES (2022, '订单查询', 2021, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:info:query', '#', 'admin', '2025-01-25 16:13:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '订单新增', 2021, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:info:add', '#', 'admin', '2025-01-25 16:13:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '订单修改', 2021, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:info:edit', '#', 'admin', '2025-01-25 16:13:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '订单删除', 2021, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:info:remove', '#', 'admin', '2025-01-25 16:13:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '订单导出', 2021, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:info:export', '#', 'admin', '2025-01-25 16:13:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, 'Live Stream', 0, 4, 'live', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'nested', 'admin', '2025-07-19 11:59:00', 'admin', '2025-07-19 11:59:25', '');
INSERT INTO `sys_menu` VALUES (2028, 'Live List', 2027, 1, 'liveList', 'live/liveList/index', NULL, '', 1, 0, 'C', '0', '0', 'live:liveList:list', 'dashboard', 'admin', '2025-07-19 12:02:39', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-01-21 12:46:52', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-01-21 12:46:52', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户头像', 2, 'com.ruoyi.system.controller.SysProfileController.avatar()', 'POST', 1, 'ry', NULL, '/user/profile/avatar', '127.0.0.1', '', '', '{\"msg\":\"文件服务异常，请联系管理员\",\"code\":500}', 0, NULL, '2025-01-22 07:37:22', 119);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:41:23', 46);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:41:29', 18);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:41:38', 31);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:42:07', 24);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:42:34', 27);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:42:46', 18);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:44:26', 19);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-22 08:44:31', 20);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Product Mgmt\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"product\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-23 15:27:04', 32);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"System Monitor\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-23 15:27:17', 21);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"System Tools\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-23 15:27:22', 21);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/brand/index\",\"createBy\":\"admin\",\"icon\":\"row\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Brand Mgmt\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"brand\",\"perms\":\"product:brand:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-23 15:29:21', 19);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Base Data\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"base\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:28:05', 34);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"System Monitor\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:28:18', 21);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"System Tools\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:28:22', 21);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"base/productUnit/index\",\"createBy\":\"admin\",\"icon\":\"client\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Product Unit\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"productUnit\",\"perms\":\"base:productUnit:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:29:39', 19);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/category/index\",\"createBy\":\"admin\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Product Category\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"category\",\"perms\":\"product:category:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:37:34', 17);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/category/index\",\"createTime\":\"2025-01-24 10:37:34\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"Category\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"category\",\"perms\":\"product:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:41:11', 18);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/CategoryBrand/index\",\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Category Brand\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"CategoryBrand\",\"perms\":\"product:CategoryBrand:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:42:01', 20);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/categoryBrand/index\",\"createTime\":\"2025-01-24 10:42:01\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"Category Brand\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"CategoryBrand\",\"perms\":\"product:categoryBrand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 10:43:11', 23);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/categoryBrand/index\",\"createTime\":\"2025-01-24 10:42:01\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"Category Brand\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"categoryBrand\",\"perms\":\"product:categoryBrand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 11:58:05', 37);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/productSpec/index\",\"createBy\":\"admin\",\"icon\":\"icon\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Product Spec\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"productSpec\",\"perms\":\"product:productSpec:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 11:59:15', 19);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"product/product/index\",\"createBy\":\"admin\",\"icon\":\"tab\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Product List\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"product\",\"perms\":\"product:product:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-24 12:21:52', 26);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"list\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"perms\":\"product:brand:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:18:55', 43);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"query\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"perms\":\"product:brand:query\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:19:24', 20);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"add\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"perms\":\"product:brand:add\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:19:40', 20);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"edit\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2001,\"perms\":\"product:brand:edit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:19:54', 21);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"remove\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2001,\"perms\":\"product:brand:remove\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:20:13', 20);
INSERT INTO `sys_oper_log` VALUES (129, '角色管理', 2, 'com.ruoyi.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/role', '127.0.0.1', '', '{\"admin\":false,\"createTime\":\"2025-01-21 12:46:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2000,2001,2008,2009,2010,2011,2012,2004,2005,2006,2007,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:26:44', 88);
INSERT INTO `sys_oper_log` VALUES (130, '角色管理', 2, 'com.ruoyi.system.controller.SysRoleController.edit()', 'PUT', 1, 'sam', NULL, '/role', '127.0.0.1', '', '{\"admin\":false,\"createTime\":\"2025-01-21 12:46:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2008,2009,2010,2004,2005,2006,2007,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1058,1056,1057,1059,1060,116],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"sam\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:27:11', 54);
INSERT INTO `sys_oper_log` VALUES (131, '角色管理', 2, 'com.ruoyi.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/role', '127.0.0.1', '', '{\"admin\":false,\"createTime\":\"2025-01-21 12:46:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2008,2009,2010,2004,2005,2006,2007,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 13:28:06', 55);
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"user_address,user_info\"}', NULL, 0, NULL, '2025-01-25 14:33:29', 463);
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 3, 'com.ruoyi.gen.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/gen/1,2', '127.0.0.1', '', '[1,2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:35:00', 54);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"user_address,user_info\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:35:07', 440);
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"user_address,user_info\"}', NULL, 0, NULL, '2025-01-25 14:35:21', 130);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"User Management\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"user\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:40:43', 29);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"System Monitor\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:40:49', 29);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"System Tools\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:40:53', 21);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"user/info/index\",\"createTime\":\"2025-01-25 14:47:17\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"User List\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2013,\"path\":\"info\",\"perms\":\"user:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:48:46', 25);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"user/userInfo/index\",\"createTime\":\"2025-01-25 14:47:17\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"User List\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2013,\"path\":\"userInfo\",\"perms\":\"user:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 14:59:33', 28);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 3, 'com.ruoyi.gen.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/gen/1,2', '127.0.0.1', '', '[1,2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 16:04:50', 105);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"order_info,order_item\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 16:05:05', 566);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"order_info,order_item\"}', NULL, 0, NULL, '2025-01-25 16:05:10', 251);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Order Mgmt\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 16:10:37', 27);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"order/orderInfo/index\",\"createTime\":\"2025-01-25 16:13:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"订单\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2020,\"path\":\"info\",\"perms\":\"order:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 16:15:47', 21);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"order/orderInfo/index\",\"createTime\":\"2025-01-25 16:13:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"Order List\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2020,\"path\":\"info\",\"perms\":\"order:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-01-25 16:16:31', 34);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/systemUser/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"User Mgmt\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-29 17:04:00', 262);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"system/systemUser/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"User Mgmt\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-29 17:04:30', 108);
INSERT INTO `sys_oper_log` VALUES (149, '角色管理', 2, 'com.ruoyi.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/role', '127.0.0.1', '', '{\"admin\":false,\"createTime\":\"2025-01-21 12:46:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2008,2009,2010,2004,2005,2006,2007,2002,2003,2020,2021,2022,2023,2024,2025,2026,2013,2014,2015,2016,2017,2018,2019,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-10 08:18:00', 60);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"order/orderInfo/index\",\"createTime\":\"2025-01-25 16:13:47\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"Order List\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2020,\"path\":\"info\",\"perms\":\"order:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-10 12:55:40', 29);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'sam', NULL, '/menu', '192.168.1.12', '', '{\"children\":[],\"component\":\"system/systemUser/index\",\"createTime\":\"2025-01-21 12:46:51\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"User Mgmt\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"systemUser\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"sam\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-12 16:57:26', 16);
INSERT INTO `sys_oper_log` VALUES (152, '用户管理', 1, 'com.ruoyi.system.controller.SysUserController.add()', 'POST', 1, 'sam', NULL, '/user', '192.168.1.12', '', '{\"admin\":false,\"createBy\":\"sam\",\"nickName\":\"Peter\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":100,\"userName\":\"Peter\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-27 10:19:25', 86);
INSERT INTO `sys_oper_log` VALUES (153, '用户管理', 1, 'com.ruoyi.system.controller.SysUserController.add()', 'POST', 1, 'sam', NULL, '/user', '192.168.1.12', '', '{\"admin\":false,\"createBy\":\"sam\",\"deptId\":105,\"nickName\":\"Peter\",\"params\":{},\"phonenumber\":\"17722863833\",\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":101,\"userName\":\"Peter\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-27 10:20:49', 67);
INSERT INTO `sys_oper_log` VALUES (154, '用户管理', 4, 'com.ruoyi.system.controller.SysUserController.insertAuthRole()', 'PUT', 1, 'sam', NULL, '/user/authRole', '192.168.1.12', '', '{\"roleIds\":\"\",\"userId\":\"101\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-27 10:21:06', 7);
INSERT INTO `sys_oper_log` VALUES (155, '用户管理', 4, 'com.ruoyi.system.controller.SysUserController.insertAuthRole()', 'PUT', 1, 'sam', NULL, '/user/authRole', '192.168.1.12', '', '{\"roleIds\":\"2\",\"userId\":\"101\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-27 10:21:55', 13);
INSERT INTO `sys_oper_log` VALUES (156, '用户管理', 1, 'com.ruoyi.system.controller.SysUserController.add()', 'POST', 1, 'sam', NULL, '/user', '192.168.1.12', '', '{\"admin\":false,\"createBy\":\"sam\",\"deptId\":101,\"nickName\":\"Jimmy\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":102,\"userName\":\"Jimmy\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-29 07:00:33', 82);
INSERT INTO `sys_oper_log` VALUES (157, '用户管理', 4, 'com.ruoyi.system.controller.SysUserController.insertAuthRole()', 'PUT', 1, 'sam', NULL, '/user/authRole', '192.168.1.12', '', '{\"roleIds\":\"2\",\"userId\":\"102\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-29 07:00:52', 13);
INSERT INTO `sys_oper_log` VALUES (158, '角色管理', 1, 'com.ruoyi.system.controller.SysRoleController.add()', 'POST', 1, 'sam', NULL, '/role', '192.168.1.12', '', '{\"admin\":false,\"createBy\":\"sam\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2002,2003,2020,2021,2022,2023,2024,2025,2026,2013,2014,2015,2016,2017,2018,2019,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116],\"params\":{},\"roleId\":100,\"roleKey\":\"Merchants\",\"roleName\":\"Merchants\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-29 07:24:09', 17);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '192.168.1.12', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"nested\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Live Stream\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"live\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 11:59:00', 19);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '192.168.1.12', '', '{\"children\":[],\"createTime\":\"2025-07-19 11:59:00\",\"icon\":\"nested\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2027,\"menuName\":\"Live Stream\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"live\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 11:59:25', 32);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '192.168.1.12', '', '{\"children\":[],\"createTime\":\"2025-01-25 14:40:43\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"User Mgmt\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"user\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 11:59:34', 8);
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '192.168.1.12', '', '{\"children\":[],\"component\":\"live/liveList/index\",\"createBy\":\"admin\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Live List\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2027,\"path\":\"liveList\",\"perms\":\"live:liveList:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 12:02:39', 7);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-01-21 12:46:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-01-21 12:46:51', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-01-21 12:46:51', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-01-21 12:46:51', 'admin', '2025-05-10 08:18:00', '普通角色');
INSERT INTO `sys_role` VALUES (100, 'Merchants', 'Merchants', 0, '1', 1, 1, '0', '0', 'sam', '2025-05-29 07:24:09', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);
INSERT INTO `sys_role_menu` VALUES (2, 2019);
INSERT INTO `sys_role_menu` VALUES (2, 2020);
INSERT INTO `sys_role_menu` VALUES (2, 2021);
INSERT INTO `sys_role_menu` VALUES (2, 2022);
INSERT INTO `sys_role_menu` VALUES (2, 2023);
INSERT INTO `sys_role_menu` VALUES (2, 2024);
INSERT INTO `sys_role_menu` VALUES (2, 2025);
INSERT INTO `sys_role_menu` VALUES (2, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 111);
INSERT INTO `sys_role_menu` VALUES (100, 112);
INSERT INTO `sys_role_menu` VALUES (100, 113);
INSERT INTO `sys_role_menu` VALUES (100, 114);
INSERT INTO `sys_role_menu` VALUES (100, 115);
INSERT INTO `sys_role_menu` VALUES (100, 116);
INSERT INTO `sys_role_menu` VALUES (100, 1046);
INSERT INTO `sys_role_menu` VALUES (100, 1047);
INSERT INTO `sys_role_menu` VALUES (100, 1048);
INSERT INTO `sys_role_menu` VALUES (100, 1049);
INSERT INTO `sys_role_menu` VALUES (100, 1050);
INSERT INTO `sys_role_menu` VALUES (100, 1051);
INSERT INTO `sys_role_menu` VALUES (100, 1052);
INSERT INTO `sys_role_menu` VALUES (100, 1053);
INSERT INTO `sys_role_menu` VALUES (100, 1054);
INSERT INTO `sys_role_menu` VALUES (100, 1055);
INSERT INTO `sys_role_menu` VALUES (100, 1056);
INSERT INTO `sys_role_menu` VALUES (100, 1057);
INSERT INTO `sys_role_menu` VALUES (100, 1058);
INSERT INTO `sys_role_menu` VALUES (100, 1059);
INSERT INTO `sys_role_menu` VALUES (100, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '管理员', '00', 'admin@qq.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-08-13 15:14:02', 'admin', '2025-01-21 12:46:51', '', '2025-08-13 07:14:00', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'sam', '山姆', '00', 'sam@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '192.168.1.12', '2025-05-30 13:38:21', 'admin', '2025-01-21 12:46:51', '', '2025-05-30 05:38:21', '测试员');
INSERT INTO `sys_user` VALUES (101, 105, 'Peter', 'Peter', '00', '', '17722863833', '0', '', '$2a$10$XQy2JT1lC7bIqLJx0oXFKOP5c1ZeLlXg3ZCPumelgSEYYW0Hp2bKa', '0', '0', '', NULL, 'sam', '2025-05-27 10:20:49', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, 101, 'Jimmy', 'Jimmy', '00', '', '', '0', '', '$2a$10$CSlMGd6mlTu.ThvPkiGCOeIzyx1R7VDfBGCqyJ.A4GlbwON9A2dFO', '0', '0', '', NULL, 'sam', '2025-05-29 07:00:33', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (101, 2);
INSERT INTO `sys_user_role` VALUES (102, 2);

SET FOREIGN_KEY_CHECKS = 1;
