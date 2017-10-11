/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : shuahaer

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-10-11 09:45:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for g_agency
-- ----------------------------
DROP TABLE IF EXISTS `g_agency`;
CREATE TABLE `g_agency` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT '0' COMMENT '上级代理的ID',
  `phone` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(64) DEFAULT NULL COMMENT '代理商密码',
  `name` varchar(32) DEFAULT NULL COMMENT '代理商姓名',
  `reg_time` int(11) unsigned DEFAULT NULL COMMENT '注册时间',
  `gold` decimal(11,2) unsigned DEFAULT NULL COMMENT '剩余金币',
  `gold_all` int(11) unsigned DEFAULT NULL COMMENT '消费总金币',
  `identity` varchar(32) DEFAULT NULL COMMENT '身份证号码',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '状态1:正常2:封停3:审核中4：审核未通过',
  `code` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推荐码',
  `manage_id` int(11) DEFAULT NULL COMMENT '添加人id',
  `manage_name` varchar(32) DEFAULT NULL COMMENT '添加人姓名',
  `rebate` int(11) DEFAULT '0' COMMENT '返佣总计',
  `place_grade` varchar(20) DEFAULT '1' COMMENT '代理等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='代理商表';

-- ----------------------------
-- Records of g_agency
-- ----------------------------
INSERT INTO `g_agency` VALUES ('1', '0', '平台', '平台', '平台', null, null, null, null, '1', '0', null, null, '0', null);
INSERT INTO `g_agency` VALUES ('2', '0', '13219890986', 'admin', '代理', '1507598752', '0.00', '0', '510322199508223818', '1', '161029', '1', 'liuyuxin', '1111', '1');
INSERT INTO `g_agency` VALUES ('3', '2', '13219890980', 'admin', '代理的下级', '1507614102', '0.00', '0', '510322199508223818', '1', '457824', null, null, '0', '2');

-- ----------------------------
-- Table structure for g_agency_deduct
-- ----------------------------
DROP TABLE IF EXISTS `g_agency_deduct`;
CREATE TABLE `g_agency_deduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned DEFAULT NULL COMMENT '代理商ID',
  `name` varchar(32) DEFAULT NULL COMMENT '代理商姓名',
  `time` int(11) unsigned DEFAULT NULL COMMENT '添加时间',
  `gold` decimal(11,2) unsigned DEFAULT NULL COMMENT '扣除金额',
  `money` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '收款人民币',
  `notes` text COMMENT '备注',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '状态1:代审核2:已完成3:拒绝',
  `manage_id` int(11) DEFAULT NULL COMMENT '添加人id',
  `manage_name` varchar(32) DEFAULT NULL COMMENT '添加人姓名',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '消费类型',
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `g_agency_deduct_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代理商购买记录表';

-- ----------------------------
-- Records of g_agency_deduct
-- ----------------------------
INSERT INTO `g_agency_deduct` VALUES ('1', '2', '代理', '1507604274', '0.00', '0.00', '1', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('2', '2', '代理', '1507604317', '0.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('3', '2', '代理', '1507604871', '0.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('4', '2', '代理', '1507604963', '0.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('5', '2', '代理', '1507605030', '0.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('6', '2', '代理', '1507605164', '0.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('7', '2', '代理', '1507605173', '1.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('8', '2', '代理', '1507605503', '1.00', '0.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_deduct` VALUES ('9', '2', '代理', '1507605558', '1.00', '1.00', '', '2', '1', 'liuyuxin', '金币');

-- ----------------------------
-- Table structure for g_agency_gold
-- ----------------------------
DROP TABLE IF EXISTS `g_agency_gold`;
CREATE TABLE `g_agency_gold` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '充值类型',
  `gold` decimal(12,2) DEFAULT NULL COMMENT '充值金额',
  `sum_gold` decimal(10,2) DEFAULT NULL COMMENT '总计消费',
  PRIMARY KEY (`id`),
  KEY `users_id` (`agency_id`),
  KEY `gold_config` (`gold_config`),
  CONSTRAINT `g_agency_gold_ibfk_2` FOREIGN KEY (`gold_config`) REFERENCES `g_gold_config` (`name`),
  CONSTRAINT `g_agency_gold_ibfk_3` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_agency_gold
-- ----------------------------
INSERT INTO `g_agency_gold` VALUES ('1', '2', '金币', '0.00', '0.00');
INSERT INTO `g_agency_gold` VALUES ('2', '3', '金币', '0.00', '0.00');

-- ----------------------------
-- Table structure for g_agency_pay
-- ----------------------------
DROP TABLE IF EXISTS `g_agency_pay`;
CREATE TABLE `g_agency_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned DEFAULT NULL COMMENT '代理商ID',
  `name` varchar(32) DEFAULT NULL COMMENT '代理商姓名',
  `time` int(11) unsigned DEFAULT NULL COMMENT '添加时间',
  `gold` int(11) unsigned DEFAULT NULL COMMENT '充值金币数量',
  `money` decimal(10,2) unsigned DEFAULT NULL COMMENT '收款人民币',
  `notes` text COMMENT '备注',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '状态1:代充值2:已完成3:拒绝',
  `manage_id` int(11) DEFAULT NULL COMMENT '添加人id',
  `manage_name` varchar(32) DEFAULT NULL COMMENT '添加人姓名',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '充值类型',
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `g_agency_pay_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代理商购买记录表';

-- ----------------------------
-- Records of g_agency_pay
-- ----------------------------
INSERT INTO `g_agency_pay` VALUES ('1', '2', '代理', '1507603972', '100', '10.00', '收款人民币10元', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('2', '2', '代理', '1507604047', '200', '20.00', '收款人民币20元', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('3', '2', '代理', '1507605440', '100', '0.00', '', '2', '1', 'liuyuxin', '金币');

-- ----------------------------
-- Table structure for g_agency_user_temp
-- ----------------------------
DROP TABLE IF EXISTS `g_agency_user_temp`;
CREATE TABLE `g_agency_user_temp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unionid` varchar(64) NOT NULL COMMENT '微信unionid',
  `agent_id` int(11) NOT NULL COMMENT '代理商的ID',
  `code` int(11) DEFAULT NULL COMMENT '代理的推荐码',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `status` int(3) DEFAULT NULL COMMENT '1未使用2使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of g_agency_user_temp
-- ----------------------------

-- ----------------------------
-- Table structure for g_draw_water
-- ----------------------------
DROP TABLE IF EXISTS `g_draw_water`;
CREATE TABLE `g_draw_water` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '抽水 记录',
  `game_id` int(11) DEFAULT NULL COMMENT '玩家ID',
  `nickname` varchar(30) DEFAULT NULL COMMENT '玩家昵称',
  `pay_out_money` varchar(11) DEFAULT NULL,
  `winner` varchar(20) DEFAULT NULL COMMENT '是否是赢家',
  `num` varchar(11) DEFAULT NULL COMMENT '数量',
  `created_at` int(11) DEFAULT NULL COMMENT '时间',
  `type` int(11) DEFAULT NULL COMMENT '1: 转账抽水    2: 游戏抽水',
  `roll_in_game_id` int(11) DEFAULT NULL COMMENT '转入ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_draw_water
-- ----------------------------
INSERT INTO `g_draw_water` VALUES ('1', '100002', '13', '0.16', '是', '0.04', '1507599704', '2', null);
INSERT INTO `g_draw_water` VALUES ('2', '100003', '1', '0.08', '是', '0.02', '1507600939', '2', null);
INSERT INTO `g_draw_water` VALUES ('3', '100005', '3', '0.16', '是', '0.04', '1507601139', '2', null);
INSERT INTO `g_draw_water` VALUES ('4', '100005', '3', '10', null, '1.10', '1507601220', '1', null);
INSERT INTO `g_draw_water` VALUES ('5', '100006', '4', '1', null, '0.11', '1507601402', '1', null);
INSERT INTO `g_draw_water` VALUES ('6', '100006', '4', '1', null, '0.11', '1507601514', '1', null);
INSERT INTO `g_draw_water` VALUES ('7', '100006', '4', '1', null, '0.11', '1507601520', '1', null);
INSERT INTO `g_draw_water` VALUES ('8', '100006', '4', '1', null, '0.11', '1507601707', '1', null);
INSERT INTO `g_draw_water` VALUES ('9', '100006', '4', '1', null, '0.11', '1507601724', '1', null);
INSERT INTO `g_draw_water` VALUES ('10', '100008', '6', '0.18', '是', '0.02', '1507601894', '2', null);
INSERT INTO `g_draw_water` VALUES ('11', '100008', '6', '10', null, '1.1', '1507602054', '1', null);
INSERT INTO `g_draw_water` VALUES ('12', '100008', '6', '5', null, '0.55', '1507602337', '1', null);
INSERT INTO `g_draw_water` VALUES ('13', '100005', '3', '0.26', '是', '0.04', '1507604787', '2', null);
INSERT INTO `g_draw_water` VALUES ('14', '100003', '1', '0.70', '是', '0.10', '1507604854', '2', null);
INSERT INTO `g_draw_water` VALUES ('15', '100004', '2', '0.53', '是', '0.07', '1507605466', '2', null);
INSERT INTO `g_draw_water` VALUES ('16', '100004', '2', '0.18', '是', '0.02', '1507605509', '2', null);
INSERT INTO `g_draw_water` VALUES ('17', '100004', '2', '0.62', '是', '0.08', '1507605575', '2', null);
INSERT INTO `g_draw_water` VALUES ('18', '100005', '3', '0.09', '是', '0.01', '1507605863', '2', null);
INSERT INTO `g_draw_water` VALUES ('19', '100005', '3', '0.79', '是', '0.11', '1507605917', '2', null);
INSERT INTO `g_draw_water` VALUES ('20', '100005', '3', '0.18', '是', '0.02', '1507605976', '2', null);
INSERT INTO `g_draw_water` VALUES ('21', '100005', '3', '0.70', '是', '0.10', '1507606047', '2', null);
INSERT INTO `g_draw_water` VALUES ('22', '100004', '2', '0.09', '是', '0.01', '1507606066', '2', null);
INSERT INTO `g_draw_water` VALUES ('23', '100003', '1', '0.53', '是', '0.07', '1507606112', '2', null);
INSERT INTO `g_draw_water` VALUES ('24', '100003', '1', '0.53', '是', '0.07', '1507606176', '2', null);
INSERT INTO `g_draw_water` VALUES ('25', '100004', '2', '0.09', '是', '0.01', '1507614148', '2', null);
INSERT INTO `g_draw_water` VALUES ('26', '100003', '1', '0.44', '是', '0.06', '1507614220', '2', null);
INSERT INTO `g_draw_water` VALUES ('27', '100003', '1', '0.35', '是', '0.05', '1507614251', '2', null);
INSERT INTO `g_draw_water` VALUES ('28', '100011', 'lucky', '0.44', '是', '0.06', '1507614300', '2', null);
INSERT INTO `g_draw_water` VALUES ('29', '100004', '2', '0.26', '是', '0.04', '1507614387', '2', null);
INSERT INTO `g_draw_water` VALUES ('30', '100014', '16', '0.17', '是', '0.03', '1507617275', '2', null);
INSERT INTO `g_draw_water` VALUES ('31', '100014', '16', '0.09', '是', '0.01', '1507617364', '2', null);
INSERT INTO `g_draw_water` VALUES ('32', '100014', '16', '10', null, '8', '1507617546', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('33', '100014', '16', '1', null, '0.8', '1507617661', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('34', '100014', '16', '1', null, '0.8', '1507617708', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('35', '100014', '16', '10', null, '0.5', '1507617934', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('36', '100014', '16', '10', null, '0.5', '1507618094', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('37', '100014', '16', '10', null, '0.5', '1507618136', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('38', '100014', '16', '10', null, '0.5', '1507618323', '1', '100015');
INSERT INTO `g_draw_water` VALUES ('39', '100021', '2000000', '10', null, '0.5', '1507619241', '1', '100021');
INSERT INTO `g_draw_water` VALUES ('40', '100021', '2000000', '5', null, '0.25', '1507619454', '1', '100020');
INSERT INTO `g_draw_water` VALUES ('41', '100021', '2000000', '106', null, '5.3', '1507619542', '1', '100020');
INSERT INTO `g_draw_water` VALUES ('42', '100021', '2000000', '106', null, '5.3', '1507619630', '1', '100020');
INSERT INTO `g_draw_water` VALUES ('43', '100020', '10000000', '100', null, '5', '1507619842', '1', '100021');
INSERT INTO `g_draw_water` VALUES ('44', '100020', '10000000', '100', null, '5', '1507620131', '1', '100022');
INSERT INTO `g_draw_water` VALUES ('45', '100022', '200000', '100', null, '5', '1507620289', '1', '100020');
INSERT INTO `g_draw_water` VALUES ('46', '100019', '昂恪', '0.10', '是', '0.01', '1507620484', '2', null);
INSERT INTO `g_draw_water` VALUES ('47', '100022', '200000', '0.10', '是', '0.01', '1507620534', '2', null);
INSERT INTO `g_draw_water` VALUES ('48', '100015', '17', '0.09', '是', '0.01', '1507620765', '2', null);
INSERT INTO `g_draw_water` VALUES ('49', '100016', '18', '0.10', '是', '0.00', '1507620952', '2', null);
INSERT INTO `g_draw_water` VALUES ('50', '100016', '18', '0.10', '是', '0.01', '1507621166', '2', null);
INSERT INTO `g_draw_water` VALUES ('51', '100018', 'kqo xuig', '0.76', '是', '0.04', '1507621257', '2', null);
INSERT INTO `g_draw_water` VALUES ('52', '100023', '潇雨', '0.76', '是', '0.04', '1507621317', '2', null);
INSERT INTO `g_draw_water` VALUES ('53', '100018', 'kqo xuig', '0.57', '是', '0.03', '1507621361', '2', null);
INSERT INTO `g_draw_water` VALUES ('54', '100018', 'kqo xuig', '0.95', '是', '0.05', '1507621386', '2', null);
INSERT INTO `g_draw_water` VALUES ('55', '100017', '赵壮', '0.10', '是', '0.01', '1507621417', '2', null);
INSERT INTO `g_draw_water` VALUES ('56', '100018', 'kqo xuig', '0.19', '是', '0.01', '1507621437', '2', null);
INSERT INTO `g_draw_water` VALUES ('57', '100018', 'kqo xuig', '0.19', '是', '0.01', '1507621449', '2', null);
INSERT INTO `g_draw_water` VALUES ('58', '100023', '潇雨', '0.19', '是', '0.01', '1507621531', '2', null);
INSERT INTO `g_draw_water` VALUES ('59', '100019', '昂恪', '0.19', '是', '0.01', '1507621545', '2', null);
INSERT INTO `g_draw_water` VALUES ('60', '100017', '赵壮', '0.19', '是', '0.01', '1507621579', '2', null);
INSERT INTO `g_draw_water` VALUES ('61', '100019', '昂恪', '0.10', '是', '0.01', '1507621613', '2', null);
INSERT INTO `g_draw_water` VALUES ('62', '100016', '18', '0.09', '是', '0.01', '1507621658', '2', null);
INSERT INTO `g_draw_water` VALUES ('63', '100024', '100000', '47.50', '是', '2.50', '1507621719', '2', null);
INSERT INTO `g_draw_water` VALUES ('64', '100024', '100000', '0.09', '是', '0.01', '1507621788', '2', null);

-- ----------------------------
-- Table structure for g_draw_water_ratio
-- ----------------------------
DROP TABLE IF EXISTS `g_draw_water_ratio`;
CREATE TABLE `g_draw_water_ratio` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ratio` varchar(11) DEFAULT NULL COMMENT '抽水比例',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `type` int(11) DEFAULT NULL COMMENT 'type: 1抽水   2:转账  3:  支付开关',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_draw_water_ratio
-- ----------------------------
INSERT INTO `g_draw_water_ratio` VALUES ('1', '5', '1507617797', '1');
INSERT INTO `g_draw_water_ratio` VALUES ('2', '5', '1507617788', '2');
INSERT INTO `g_draw_water_ratio` VALUES ('3', '1', null, '3');

-- ----------------------------
-- Table structure for g_game_exploits
-- ----------------------------
DROP TABLE IF EXISTS `g_game_exploits`;
CREATE TABLE `g_game_exploits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '玩家用户ID',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏数据库ID',
  `nickname` varchar(32) DEFAULT NULL COMMENT '玩家昵称',
  `time` int(11) unsigned DEFAULT '0' COMMENT '充值时间',
  `gold` varchar(11) DEFAULT '0' COMMENT '获得的积分',
  `game_class` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '状态1:成功 0:失败',
  `notes` varchar(255) DEFAULT NULL COMMENT '战绩详情',
  `draw_water` varchar(255) DEFAULT NULL COMMENT '每局游戏抽水',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `game_class` (`game_class`),
  CONSTRAINT `g_game_exploits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `g_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='玩家战绩表';

-- ----------------------------
-- Records of g_game_exploits
-- ----------------------------
INSERT INTO `g_game_exploits` VALUES ('1', '1', '100001', '12', '1507599650', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('2', '2', '100002', '13', '1507599650', '0.40', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('3', '2', '100002', '13', '1507599703', '0.16', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('4', '1', '100001', '12', '1507599703', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('5', '3', '100003', '1', '1507600431', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('6', '4', '100004', '2', '1507600432', '0.40', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('7', '3', '100003', '1', '1507600938', '0.08', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('8', '4', '100004', '2', '1507600939', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('9', '5', '100005', '3', '1507601138', '0.16', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('10', '6', '100006', '4', '1507601138', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('11', '8', '100008', '6', '1507601805', '0.20', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('12', '7', '100007', '5', '1507601805', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('13', '7', '100007', '5', '1507601892', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('14', '8', '100008', '6', '1507601894', '0.18', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('15', '3', '100003', '1', '1507604785', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('16', '4', '100004', '2', '1507604787', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('17', '5', '100005', '3', '1507604787', '0.26', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('18', '3', '100003', '1', '1507604854', '0.70', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('19', '4', '100004', '2', '1507604854', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('20', '5', '100005', '3', '1507604855', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('21', '5', '100005', '3', '1507605465', '-0.60', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('22', '4', '100004', '2', '1507605466', '0.53', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('23', '4', '100004', '2', '1507605508', '0.18', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('24', '5', '100005', '3', '1507605508', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('25', '5', '100005', '3', '1507605574', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('26', '4', '100004', '2', '1507605574', '0.62', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('27', '3', '100003', '1', '1507605575', '-0.30', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('28', '5', '100005', '3', '1507605863', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('29', '4', '100004', '2', '1507605863', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('30', '5', '100005', '3', '1507605915', '0.79', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('31', '4', '100004', '2', '1507605917', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('32', '3', '100003', '1', '1507605917', '-0.50', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('33', '5', '100005', '3', '1507605976', '0.18', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('34', '4', '100004', '2', '1507605976', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('35', '4', '100004', '2', '1507606047', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('36', '5', '100005', '3', '1507606048', '0.70', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('37', '3', '100003', '1', '1507606048', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('38', '5', '100005', '3', '1507606066', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('39', '4', '100004', '2', '1507606066', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('40', '3', '100003', '1', '1507606111', '0.53', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('41', '5', '100005', '3', '1507606111', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('42', '4', '100004', '2', '1507606112', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('43', '3', '100003', '1', '1507606176', '0.53', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('44', '4', '100004', '2', '1507606176', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('45', '5', '100005', '3', '1507606177', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('46', '3', '100003', '1', '1507614147', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('47', '4', '100004', '2', '1507614148', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('48', '4', '100004', '2', '1507614158', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('49', '11', '100011', 'lucky', '1507614220', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('50', '3', '100003', '1', '1507614220', '0.44', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('51', '11', '100011', 'lucky', '1507614250', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('52', '3', '100003', '1', '1507614250', '0.35', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('53', '4', '100004', '2', '1507614270', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('54', '11', '100011', 'lucky', '1507614299', '0.44', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('55', '3', '100003', '1', '1507614299', '-0.40', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('56', '3', '100003', '1', '1507614362', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('57', '4', '100004', '2', '1507614386', '0.26', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('58', '11', '100011', 'lucky', '1507614387', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('59', '14', '100014', '16', '1507617275', '0.17', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('60', '16', '100016', '18', '1507617276', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('61', '14', '100014', '16', '1507617364', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('62', '15', '100015', '17', '1507617365', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('63', '18', '100018', 'kqo xuig', '1507620484', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('64', '19', '100019', '昂恪', '1507620484', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('65', '20', '100020', '10000000', '1507620534', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('66', '22', '100022', '200000', '1507620534', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('67', '15', '100015', '17', '1507620766', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('68', '16', '100016', '18', '1507620766', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('69', '15', '100015', '17', '1507620951', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('70', '16', '100016', '18', '1507620952', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('71', '14', '100014', '16', '1507621166', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('72', '16', '100016', '18', '1507621166', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('73', '23', '100023', '潇雨', '1507621257', '-0.40', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('74', '17', '100017', '赵壮', '1507621257', '-0.40', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('75', '18', '100018', 'kqo xuig', '1507621258', '0.76', '扎金花亲友房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('76', '17', '100017', '赵壮', '1507621317', '-0.30', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('77', '23', '100023', '潇雨', '1507621317', '0.76', '扎金花亲友房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('78', '18', '100018', 'kqo xuig', '1507621317', '-0.50', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('79', '23', '100023', '潇雨', '1507621360', '-0.40', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('80', '17', '100017', '赵壮', '1507621361', '-0.20', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('81', '18', '100018', 'kqo xuig', '1507621361', '0.57', '扎金花亲友房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('82', '19', '100019', '昂恪', '1507621386', '-0.40', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('83', '18', '100018', 'kqo xuig', '1507621386', '0.95', '扎金花亲友房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('84', '17', '100017', '赵壮', '1507621386', '-0.40', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('85', '23', '100023', '潇雨', '1507621386', '-0.20', '扎金花亲友房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('86', '17', '100017', '赵壮', '1507621417', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('87', '19', '100019', '昂恪', '1507621417', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('88', '17', '100017', '赵壮', '1507621437', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('89', '18', '100018', 'kqo xuig', '1507621437', '0.19', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('90', '19', '100019', '昂恪', '1507621437', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('91', '18', '100018', 'kqo xuig', '1507621449', '0.19', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('92', '17', '100017', '赵壮', '1507621449', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('93', '19', '100019', '昂恪', '1507621449', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('94', '17', '100017', '赵壮', '1507621531', '-0.20', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('95', '23', '100023', '潇雨', '1507621531', '0.19', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('96', '23', '100023', '潇雨', '1507621545', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('97', '19', '100019', '昂恪', '1507621545', '0.19', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('98', '17', '100017', '赵壮', '1507621545', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('99', '23', '100023', '潇雨', '1507621564', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('100', '19', '100019', '昂恪', '1507621579', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('101', '17', '100017', '赵壮', '1507621579', '0.19', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('102', '17', '100017', '赵壮', '1507621613', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('103', '19', '100019', '昂恪', '1507621613', '0.10', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('104', '14', '100014', '16', '1507621658', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('105', '16', '100016', '18', '1507621658', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('106', '24', '100024', '100000', '1507621719', '47.50', '扎金花匹配房,底分5', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('107', '25', '100025', '121212112', '1507621719', '-50.00', '扎金花匹配房,底分5', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('108', '24', '100024', '100000', '1507621788', '0.09', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('109', '25', '100025', '121212112', '1507621788', '-0.10', '扎金花匹配房,底分0.1', '1', '输', null);

-- ----------------------------
-- Table structure for g_gold_config
-- ----------------------------
DROP TABLE IF EXISTS `g_gold_config`;
CREATE TABLE `g_gold_config` (
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '支付类型',
  `type` int(11) DEFAULT NULL COMMENT '1:数值2:时间',
  `num_code` int(11) DEFAULT NULL COMMENT 'APICode使用',
  `en_code` varchar(32) DEFAULT NULL COMMENT 'APICODE使用',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户支付类型表';

-- ----------------------------
-- Records of g_gold_config
-- ----------------------------
INSERT INTO `g_gold_config` VALUES ('金币', '1', '102', 'gold');

-- ----------------------------
-- Table structure for g_manage
-- ----------------------------
DROP TABLE IF EXISTS `g_manage`;
CREATE TABLE `g_manage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '管理员姓名',
  `password` varchar(64) DEFAULT NULL COMMENT '管理员密码',
  `phone` varchar(12) DEFAULT NULL COMMENT '管理员手机号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of g_manage
-- ----------------------------
INSERT INTO `g_manage` VALUES ('1', 'liuyuxin', '21232f297a57a5a743894a0e4a801fc3', null);

-- ----------------------------
-- Table structure for g_notice
-- ----------------------------
DROP TABLE IF EXISTS `g_notice`;
CREATE TABLE `g_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manage_id` int(11) DEFAULT NULL COMMENT '添加人id',
  `manage_name` varchar(32) DEFAULT NULL COMMENT '添加人姓名',
  `title` varchar(64) DEFAULT NULL COMMENT '通知标题',
  `content` text COMMENT '通知内容',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '1显示 2隐藏',
  `time` int(11) unsigned DEFAULT NULL COMMENT '添加时间',
  `notes` varchar(255) DEFAULT NULL COMMENT '添加的备注',
  `location` varchar(255) DEFAULT NULL COMMENT '显示位置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='公告通知数据库';

-- ----------------------------
-- Records of g_notice
-- ----------------------------
INSERT INTO `g_notice` VALUES ('1', '1', 'liuyuxin', '我添加的公告', '测试公告', '1', '1507601989', '备注', '首页公告');

-- ----------------------------
-- Table structure for g_rebate
-- ----------------------------
DROP TABLE IF EXISTS `g_rebate`;
CREATE TABLE `g_rebate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_pay_id` int(11) NOT NULL DEFAULT '0' COMMENT '充值记录的ID',
  `agency_pay_name` varchar(32) DEFAULT NULL COMMENT '充值代理人名称',
  `agency_pay_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '充值用户的ID',
  `agency_id` int(11) unsigned DEFAULT NULL COMMENT '受利益人ID',
  `agency_name` varchar(32) DEFAULT NULL COMMENT '受利益人',
  `gold_num` decimal(11,2) DEFAULT NULL COMMENT '返钻数量',
  `notes` varchar(255) DEFAULT NULL COMMENT '备注',
  `time` int(11) unsigned DEFAULT NULL COMMENT '操作时间',
  `rebate_conf` varchar(11) DEFAULT NULL COMMENT '返回佣金登记',
  `proportion` int(11) DEFAULT NULL COMMENT '返佣比例',
  `type` varchar(20) DEFAULT NULL,
  `pay_name` varchar(60) DEFAULT NULL COMMENT '充值人,名字',
  PRIMARY KEY (`id`),
  KEY `rebate_conf` (`rebate_conf`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `g_rebate_ibfk_2` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='返利表';

-- ----------------------------
-- Records of g_rebate
-- ----------------------------

-- ----------------------------
-- Table structure for g_rebate_conf
-- ----------------------------
DROP TABLE IF EXISTS `g_rebate_conf`;
CREATE TABLE `g_rebate_conf` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `one` int(11) unsigned NOT NULL COMMENT '返利比例',
  `two` int(11) NOT NULL,
  `three` int(11) NOT NULL,
  `sum` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='返利配置表';

-- ----------------------------
-- Records of g_rebate_conf
-- ----------------------------
INSERT INTO `g_rebate_conf` VALUES ('1', '5', '3', '2', '100');

-- ----------------------------
-- Table structure for g_rebate_ratio
-- ----------------------------
DROP TABLE IF EXISTS `g_rebate_ratio`;
CREATE TABLE `g_rebate_ratio` (
  `id` int(11) NOT NULL,
  `agency_one` varchar(11) DEFAULT NULL COMMENT '代理一级',
  `agency_two` varchar(11) DEFAULT NULL COMMENT '代理二级',
  `users_one` varchar(11) DEFAULT NULL COMMENT '玩家一级',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_rebate_ratio
-- ----------------------------
INSERT INTO `g_rebate_ratio` VALUES ('1', '0.1', '0.5', '0.02');

-- ----------------------------
-- Table structure for g_users
-- ----------------------------
DROP TABLE IF EXISTS `g_users`;
CREATE TABLE `g_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL COMMENT '游戏数据的ＩＤ',
  `nickname` varchar(32) DEFAULT NULL COMMENT '玩家昵称',
  `autograph` varchar(255) DEFAULT NULL COMMENT '备注',
  `phone` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `gold` int(10) unsigned DEFAULT NULL COMMENT '剩余房卡数量',
  `gold_all` int(11) unsigned DEFAULT NULL COMMENT '总计消费房卡数量',
  `reg_time` int(11) unsigned DEFAULT NULL COMMENT '注册时间',
  `game_count` int(11) unsigned DEFAULT '0' COMMENT '游戏总局数',
  `head` varchar(255) DEFAULT NULL COMMENT '用户头像地址http://www.badiu.com/1.jpg',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '状态 1:启用中 0:已封停',
  `superior_id` int(11) DEFAULT NULL COMMENT '代理ID',
  `superior_name` varchar(30) DEFAULT NULL COMMENT '上级姓名',
  `rebate` int(11) DEFAULT '0' COMMENT '返利总额',
  `agency_code` int(11) unsigned DEFAULT NULL COMMENT '代理推荐码',
  `unionid` varchar(64) DEFAULT NULL COMMENT '微信的unionid',
  `place_grade` varchar(20) DEFAULT '1' COMMENT '分销等级',
  `num` int(11) DEFAULT '0' COMMENT '转账次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `111` (`game_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='玩家表';

-- ----------------------------
-- Records of g_users
-- ----------------------------
INSERT INTO `g_users` VALUES ('1', '100001', '12', null, null, '6', '6', '1507599127', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', null);
INSERT INTO `g_users` VALUES ('2', '100002', '13', null, null, '6', '6', '1507599215', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', null);
INSERT INTO `g_users` VALUES ('3', '100003', '1', null, null, '6', '6', '1507600415', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', null);
INSERT INTO `g_users` VALUES ('4', '100004', '2', null, null, '6', '6', '1507600416', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', null);
INSERT INTO `g_users` VALUES ('5', '100005', '3', null, null, '6', '6', '1507601036', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '1');
INSERT INTO `g_users` VALUES ('6', '100006', '4', null, null, '6', '6', '1507601102', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '5');
INSERT INTO `g_users` VALUES ('7', '100007', '5', null, null, '6', '6', '1507601768', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', null);
INSERT INTO `g_users` VALUES ('8', '100008', '6', null, null, '6', '6', '1507601785', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '2');
INSERT INTO `g_users` VALUES ('9', '100009', '8', null, null, '6', '6', '1507603126', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('10', '100010', '11', null, null, '6', '6', '1507604060', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('11', '100011', 'lucky', null, null, '6', '6', '1507613911', '0', 'http://wx.qlogo.cn/mmopen/vi_32/MxXpDuNtp3IicKs8hMTpVU22mNaTjXJuCx8ek4YB2QZpdlZeQMt7uJaBGjxibqSRjUOVzAMI0DadNN2ujuKmq1ag/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('12', '100012', 'as', null, null, '6', '6', '1507614408', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('13', '100013', '安吉', null, null, '6', '6', '1507617088', '0', 'http://wx.qlogo.cn/mmopen/vi_32/eiafb2fCfhYawRkGZPuLibt55elX3OjKDwmrNgkibOiadBkbufhv8Y2ud4OTxTU3LjCzgXy9UIv7ZdBCgrpuag5bWA/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('14', '100014', '16', null, null, '6', '6', '1507617230', '2', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '7');
INSERT INTO `g_users` VALUES ('15', '100015', '17', null, null, '6', '6', '1507617232', '2', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('16', '100016', '18', null, null, '6', '6', '1507617233', '4', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('17', '100017', '赵壮', null, null, '6', '6', '1507618368', '11', 'http://wx.qlogo.cn/mmopen/vi_32/7sXzJ22BCNooCCMP4xhKvQricyKrdqMRusACVK9zGvploKEUXX5iaLfeeHF8mGKDzYicL3EmrqK1CSKxbx4BANglA/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('18', '100018', 'kqo xuig', null, null, '6', '6', '1507618379', '7', 'http://wx.qlogo.cn/mmopen/vi_32/CGJ2ptYXgQ5sv1Ckiaj9k3yl9fmdoMZ6FwbVveQnoVMtiaNVaofRmibPStdpoVOpApY5HsALWb90MOBfRSOoBLjvA/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('19', '100019', '昂恪', null, null, '6', '6', '1507618380', '8', 'http://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLVZbOrTHSY6IibK4x2pE9xiarsVOTNvE9lFjVLkrrL4rW2K290BXibia1fxyoxgZKZnicic8BccDTMfYicA/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('20', '100020', '10000000', null, null, '6', '6', '1507618647', '1', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '2');
INSERT INTO `g_users` VALUES ('21', '100021', '2000000', null, null, '6', '6', '1507619082', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '4');
INSERT INTO `g_users` VALUES ('22', '100022', '200000', null, null, '6', '6', '1507620032', '1', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '1');
INSERT INTO `g_users` VALUES ('23', '100023', '潇雨', null, null, '6', '6', '1507620916', '7', 'http://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJM2fJaXaicYdTHibkTMibibh7BtRHvqHS9Ip5Vx7UWic7VLwywC2I0giccouO9tktlTB4icquLFUEg725Iw/0', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('24', '100024', '100000', null, null, '6', '6', '1507621456', '2', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');
INSERT INTO `g_users` VALUES ('25', '100025', '121212112', null, null, '6', '6', '1507621526', '2', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null, '0', null, null, '1', '0');

-- ----------------------------
-- Table structure for g_users_gold
-- ----------------------------
DROP TABLE IF EXISTS `g_users_gold`;
CREATE TABLE `g_users_gold` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '充值类型',
  `gold` decimal(12,2) DEFAULT NULL COMMENT '充值金额',
  `sum_gold` decimal(10,2) DEFAULT NULL COMMENT '总计消费',
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `gold_config` (`gold_config`),
  KEY `gold_config_2` (`gold_config`),
  CONSTRAINT `g_users_gold_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `g_users` (`id`),
  CONSTRAINT `g_users_gold_ibfk_2` FOREIGN KEY (`gold_config`) REFERENCES `g_gold_config` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_users_gold
-- ----------------------------
INSERT INTO `g_users_gold` VALUES ('1', '1', '金币', '10.00', '110.00');
INSERT INTO `g_users_gold` VALUES ('2', '2', '金币', '5.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('3', '3', '金币', '6.73', '6.00');
INSERT INTO `g_users_gold` VALUES ('4', '4', '金币', '5.17', '6.00');
INSERT INTO `g_users_gold` VALUES ('5', '5', '金币', '-74.94', '26.00');
INSERT INTO `g_users_gold` VALUES ('6', '6', '金币', '0.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('7', '7', '金币', '10.60', '6.00');
INSERT INTO `g_users_gold` VALUES ('8', '8', '金币', '309.73', '326.00');
INSERT INTO `g_users_gold` VALUES ('9', '9', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('10', '10', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('11', '11', '金币', '5.44', '6.00');
INSERT INTO `g_users_gold` VALUES ('12', '12', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('13', '13', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('14', '14', '金币', '12.46', '76.00');
INSERT INTO `g_users_gold` VALUES ('15', '15', '金币', '7.89', '6.00');
INSERT INTO `g_users_gold` VALUES ('16', '16', '金币', '5.99', '6.00');
INSERT INTO `g_users_gold` VALUES ('17', '17', '金币', '4.39', '6.00');
INSERT INTO `g_users_gold` VALUES ('18', '18', '金币', '108.06', '106.00');
INSERT INTO `g_users_gold` VALUES ('19', '19', '金币', '105.59', '106.00');
INSERT INTO `g_users_gold` VALUES ('20', '20', '金币', '1210.90', '1110.00');
INSERT INTO `g_users_gold` VALUES ('21', '21', '金币', '177.65', '306.00');
INSERT INTO `g_users_gold` VALUES ('22', '22', '金币', '1007.10', '1014.00');
INSERT INTO `g_users_gold` VALUES ('23', '23', '金币', '105.75', '106.00');
INSERT INTO `g_users_gold` VALUES ('24', '24', '金币', '1047.59', '1000.00');
INSERT INTO `g_users_gold` VALUES ('25', '25', '金币', '1047.90', '1098.00');

-- ----------------------------
-- Table structure for g_user_dedict
-- ----------------------------
DROP TABLE IF EXISTS `g_user_dedict`;
CREATE TABLE `g_user_dedict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned DEFAULT NULL COMMENT '代理商ID',
  `agency_name` varchar(32) DEFAULT NULL COMMENT '代理商名称',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '玩家用户ID',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏数据库ID',
  `nickname` varchar(32) DEFAULT NULL COMMENT '玩家昵称',
  `time` int(11) unsigned DEFAULT '0' COMMENT '充值时间',
  `gold` int(11) unsigned DEFAULT NULL COMMENT '充值金币数量',
  `money` decimal(10,2) unsigned DEFAULT NULL COMMENT '收款人民币',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '状态1:成功 0:失败',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '充值类型',
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `g_user_dedict_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`),
  CONSTRAINT `g_user_dedict_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `g_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='玩家充值表';

-- ----------------------------
-- Records of g_user_dedict
-- ----------------------------

-- ----------------------------
-- Table structure for g_user_out
-- ----------------------------
DROP TABLE IF EXISTS `g_user_out`;
CREATE TABLE `g_user_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '玩家用户ID',
  `game_id` int(11) unsigned DEFAULT NULL COMMENT '游戏数据库ID',
  `nickname` varchar(32) DEFAULT NULL COMMENT '玩家昵称',
  `time` int(11) unsigned DEFAULT '0' COMMENT '消费时间',
  `gold` varchar(11) DEFAULT NULL COMMENT '消费金币数量',
  `game_class` varchar(32) DEFAULT NULL COMMENT '消费类型',
  `notes` varchar(255) DEFAULT NULL COMMENT '消费详情',
  `gold_config` varchar(32) NOT NULL DEFAULT '' COMMENT '消费类型',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `game_class` (`game_class`),
  CONSTRAINT `g_user_out_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `g_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='玩家消费表';

-- ----------------------------
-- Records of g_user_out
-- ----------------------------
INSERT INTO `g_user_out` VALUES ('1', '3', '100003', '1', '1507600938', '0.08', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('2', '4', '100004', '2', '1507600939', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('3', '5', '100005', '3', '1507601138', '0.16', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('4', '6', '100006', '4', '1507601139', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('5', '5', '100005', '3', '1507601220', '-101.1', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('6', '6', '100006', '4', '1507601402', '-10.11', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('7', '6', '100006', '4', '1507601514', '-10.11', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('8', '6', '100006', '4', '1507601520', '-10.11', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('9', '6', '100006', '4', '1507601707', '-10.11', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('10', '6', '100006', '4', '1507601725', '-1.11', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('11', '8', '100008', '6', '1507601805', '0.20', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('12', '7', '100007', '5', '1507601806', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('13', '7', '100007', '5', '1507601893', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('14', '8', '100008', '6', '1507601894', '0.18', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('15', '8', '100008', '6', '1507602054', '-11.1', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('16', '7', '100007', '5', '1507602337', '5', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('17', '8', '100008', '6', '1507602337', '-5.55', '金币', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('18', '3', '100003', '1', '1507604787', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('19', '4', '100004', '2', '1507604787', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('20', '3', '100003', '1', '1507604854', '0.70', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('21', '4', '100004', '2', '1507604854', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('22', '4', '100004', '2', '1507605466', '0.53', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('23', '4', '100004', '2', '1507605508', '0.18', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('24', '4', '100004', '2', '1507605575', '0.62', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('25', '3', '100003', '1', '1507605575', '-0.30', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('26', '4', '100004', '2', '1507605864', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('27', '4', '100004', '2', '1507605917', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('28', '3', '100003', '1', '1507605917', '-0.50', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('29', '4', '100004', '2', '1507605976', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('30', '4', '100004', '2', '1507606048', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('31', '3', '100003', '1', '1507606048', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('32', '4', '100004', '2', '1507606066', '0.09', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('33', '3', '100003', '1', '1507606111', '0.53', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('34', '4', '100004', '2', '1507606111', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('35', '3', '100003', '1', '1507606176', '0.53', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('36', '4', '100004', '2', '1507606177', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('37', '3', '100003', '1', '1507614148', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('38', '4', '100004', '2', '1507614148', '0.09', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('39', '4', '100004', '2', '1507614158', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('40', '3', '100003', '1', '1507614220', '0.44', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('41', '11', '100011', 'lucky', '1507614221', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('42', '3', '100003', '1', '1507614250', '0.35', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('43', '11', '100011', 'lucky', '1507614251', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('44', '4', '100004', '2', '1507614270', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('45', '11', '100011', 'lucky', '1507614300', '0.44', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('46', '3', '100003', '1', '1507614301', '-0.40', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('47', '3', '100003', '1', '1507614362', '-0.10', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('48', '4', '100004', '2', '1507614386', '0.26', '金币', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('49', '11', '100011', 'lucky', '1507614386', '-0.20', '金币', '输', '金币');
INSERT INTO `g_user_out` VALUES ('50', '16', '100016', '18', '1507617276', '-0.20', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('51', '14', '100014', '16', '1507617276', '0.17', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('52', '14', '100014', '16', '1507617364', '0.09', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('53', '15', '100015', '17', '1507617365', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('54', '14', '100014', '16', '1507617546', '-18', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('55', '15', '100015', '17', '1507617661', '1', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('56', '14', '100014', '16', '1507617662', '-1.8', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('57', '15', '100015', '17', '1507617709', '1', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('58', '14', '100014', '16', '1507617709', '-1.8', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('59', '14', '100014', '16', '1507617935', '-10.5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('60', '14', '100014', '16', '1507618094', '-10.5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('61', '14', '100014', '16', '1507618136', '-10.5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('62', '14', '100014', '16', '1507618323', '-10.5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('63', '21', '100021', '2000000', '1507619242', '10', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('64', '21', '100021', '2000000', '1507619243', '-10.5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('65', '20', '100020', '10000000', '1507619455', '5', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('66', '21', '100021', '2000000', '1507619455', '-5.25', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('67', '21', '100021', '2000000', '1507619541', '-111.3', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('68', '20', '100020', '10000000', '1507619631', '106', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('69', '21', '100021', '2000000', '1507619631', '-111.3', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('70', '20', '100020', '10000000', '1507619842', '-105', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('71', '21', '100021', '2000000', '1507619843', '100', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('72', '20', '100020', '10000000', '1507620131', '-105', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('73', '22', '100022', '200000', '1507620131', '100', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('74', '20', '100020', '10000000', '1507620289', '100', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('75', '22', '100022', '200000', '1507620289', '-105', '转账', '转账', '金币');
INSERT INTO `g_user_out` VALUES ('76', '18', '100018', 'kqo xuig', '1507620484', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('77', '19', '100019', '昂恪', '1507620484', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('78', '20', '100020', '10000000', '1507620534', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('79', '22', '100022', '200000', '1507620534', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('80', '15', '100015', '17', '1507620766', '0.09', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('81', '16', '100016', '18', '1507620766', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('82', '15', '100015', '17', '1507620952', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('83', '16', '100016', '18', '1507620952', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('84', '16', '100016', '18', '1507621166', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('85', '14', '100014', '16', '1507621167', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('86', '18', '100018', 'kqo xuig', '1507621257', '0.76', '扎金花亲友房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('87', '23', '100023', '潇雨', '1507621258', '-0.40', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('88', '17', '100017', '赵壮', '1507621258', '-0.40', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('89', '23', '100023', '潇雨', '1507621317', '0.76', '扎金花亲友房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('90', '17', '100017', '赵壮', '1507621317', '-0.30', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('91', '18', '100018', 'kqo xuig', '1507621317', '-0.50', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('92', '17', '100017', '赵壮', '1507621361', '-0.20', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('93', '23', '100023', '潇雨', '1507621361', '-0.40', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('94', '18', '100018', 'kqo xuig', '1507621361', '0.57', '扎金花亲友房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('95', '23', '100023', '潇雨', '1507621386', '-0.20', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('96', '18', '100018', 'kqo xuig', '1507621386', '0.95', '扎金花亲友房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('97', '17', '100017', '赵壮', '1507621386', '-0.40', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('98', '19', '100019', '昂恪', '1507621386', '-0.40', '扎金花亲友房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('99', '19', '100019', '昂恪', '1507621417', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('100', '17', '100017', '赵壮', '1507621417', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('101', '17', '100017', '赵壮', '1507621437', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('102', '19', '100019', '昂恪', '1507621437', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('103', '18', '100018', 'kqo xuig', '1507621437', '0.19', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('104', '17', '100017', '赵壮', '1507621449', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('105', '19', '100019', '昂恪', '1507621449', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('106', '18', '100018', 'kqo xuig', '1507621449', '0.19', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('107', '23', '100023', '潇雨', '1507621531', '0.19', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('108', '17', '100017', '赵壮', '1507621531', '-0.20', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('109', '19', '100019', '昂恪', '1507621545', '0.19', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('110', '23', '100023', '潇雨', '1507621545', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('111', '17', '100017', '赵壮', '1507621545', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('112', '23', '100023', '潇雨', '1507621564', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('113', '19', '100019', '昂恪', '1507621579', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('114', '17', '100017', '赵壮', '1507621579', '0.19', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('115', '19', '100019', '昂恪', '1507621613', '0.10', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('116', '17', '100017', '赵壮', '1507621613', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('117', '14', '100014', '16', '1507621658', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('118', '16', '100016', '18', '1507621658', '0.09', '扎金花匹配房,底分0.1', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('119', '24', '100024', '100000', '1507621719', '47.50', '扎金花匹配房,底分5', '赢', '金币');
INSERT INTO `g_user_out` VALUES ('120', '25', '100025', '121212112', '1507621719', '-50.00', '扎金花匹配房,底分5', '输', '金币');
INSERT INTO `g_user_out` VALUES ('121', '25', '100025', '121212112', '1507621788', '-0.10', '扎金花匹配房,底分0.1', '输', '金币');
INSERT INTO `g_user_out` VALUES ('122', '24', '100024', '100000', '1507621788', '0.09', '扎金花匹配房,底分0.1', '赢', '金币');

-- ----------------------------
-- Table structure for g_user_pay
-- ----------------------------
DROP TABLE IF EXISTS `g_user_pay`;
CREATE TABLE `g_user_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned DEFAULT NULL COMMENT '代理商ID',
  `agency_name` varchar(32) DEFAULT NULL COMMENT '代理商名称',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '玩家用户ID',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏数据库ID',
  `nickname` varchar(32) DEFAULT NULL COMMENT '玩家昵称',
  `time` int(11) unsigned DEFAULT '0' COMMENT '充值时间',
  `gold` int(11) unsigned DEFAULT NULL COMMENT '充值金币数量',
  `money` decimal(10,2) unsigned DEFAULT NULL COMMENT '收款人民币',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '状态1:成功 0:失败',
  `gold_config` varchar(32) DEFAULT NULL COMMENT '充值类型',
  `type` int(11) DEFAULT NULL COMMENT '1：充值  2： 扣除',
  `notes` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `g_user_pay_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`),
  CONSTRAINT `g_user_pay_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `g_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='玩家充值表';

-- ----------------------------
-- Records of g_user_pay
-- ----------------------------
INSERT INTO `g_user_pay` VALUES ('1', '1', '平台', '1', '100001', '12', '1507599234', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('2', '1', '平台', '1', '100001', '12', '1507599425', '100', '0.00', '1', '金币', '2', '我想扣你的');
INSERT INTO `g_user_pay` VALUES ('3', '1', '平台', '2', '100002', '13', '1507599537', '1', '0.00', '1', '金币', '2', '测试');
INSERT INTO `g_user_pay` VALUES ('4', '1', '平台', '1', '100001', '12', '1507599980', '4', '0.00', '1', '金币', '1', '我给你充了哈');
INSERT INTO `g_user_pay` VALUES ('5', '1', '平台', '5', '100005', '3', '1507601192', '20', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('6', '1', '平台', '8', '100008', '6', '1507602027', '20', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('7', '2', '代理', '8', '100008', '6', '1507604140', '300', '10.00', '1', '金币', '1', '我是代理');
INSERT INTO `g_user_pay` VALUES ('8', '1', '平台', '14', '100014', '16', '1507617472', '20', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('9', '1', '平台', '14', '100014', '16', '1507617686', '10', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('10', '1', '平台', '14', '100014', '16', '1507617909', '10', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('11', '1', '平台', '14', '100014', '16', '1507618068', '10', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('12', '1', '平台', '14', '100014', '16', '1507618123', '10', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('13', '1', '平台', '14', '100014', '16', '1507618316', '10', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('14', '1', '平台', '20', '100020', '10000000', '1507618809', '100', '0.00', '1', '金币', '1', '我pc端测试的');
INSERT INTO `g_user_pay` VALUES ('15', '1', '平台', '20', '100020', '10000000', '1507618840', '6', '0.00', '1', '金币', '2', '我测试扣除');
INSERT INTO `g_user_pay` VALUES ('16', '1', '平台', '21', '100021', '2000000', '1507619226', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('17', '1', '平台', '21', '100021', '2000000', '1507619509', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('18', '1', '平台', '21', '100021', '2000000', '1507619622', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('19', '1', '平台', '22', '100022', '200000', '1507620235', '5', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('20', '1', '平台', '22', '100022', '200000', '1507620271', '1', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('21', '1', '平台', '22', '100022', '200000', '1507621121', '1', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('22', '1', '平台', '22', '100022', '200000', '1507621374', '1', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('23', '1', '平台', '22', '100022', '200000', '1507621397', '1000', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('24', '1', '平台', '20', '100020', '10000000', '1507621411', '1000', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('25', '1', '平台', '24', '100024', '100000', '1507621566', '94', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('26', '1', '平台', '25', '100025', '121212112', '1507621574', '94', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('27', '1', '平台', '25', '100025', '121212112', '1507621610', '900', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('28', '1', '平台', '24', '100024', '100000', '1507621618', '900', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('29', '1', '财富榜', '20', '100020', '10000000', '1507621892', '4', '0.00', '1', '金币', '1', '财富榜充值');
INSERT INTO `g_user_pay` VALUES ('30', '1', '充值榜', '22', '100022', '200000', '1507622144', '2', '0.00', '1', '金币', '1', '交易榜');
INSERT INTO `g_user_pay` VALUES ('31', '2', '代理', '25', '100025', '121212112', '1507623022', '98', '100.00', '1', '金币', '1', '我是代理商');
INSERT INTO `g_user_pay` VALUES ('32', '1', '平台', '19', '100019', '昂恪', '1507628183', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('33', '1', '平台', '18', '100018', 'kqo xuig', '1507628194', '100', '0.00', '1', '金币', '1', '');
INSERT INTO `g_user_pay` VALUES ('34', '1', '平台', '23', '100023', '潇雨', '1507628299', '100', '0.00', '1', '金币', '1', '');
