/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : shuahaer

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-09-30 15:06:54
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
  `rebate` decimal(10,2) DEFAULT '0.00' COMMENT '返佣总计',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='代理商表';

-- ----------------------------
-- Records of g_agency
-- ----------------------------
INSERT INTO `g_agency` VALUES ('1', '0', '平台', '平台', '平台', null, null, null, null, '1', '0', null, null, '0.00');
INSERT INTO `g_agency` VALUES ('30', '0', '15982707139', '123456789', '曹双', '1493092913', '0.00', '0', '513722199702046123', '1', '686616', '1', 'lrdouble', '0.00');
INSERT INTO `g_agency` VALUES ('31', '30', '13219890986', 'admin', 'admin', '1506739636', '0.00', '0', '510322199508223818', '1', '251776', '1', 'liuyuxin', '0.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代理商购买记录表';

-- ----------------------------
-- Records of g_agency_deduct
-- ----------------------------
INSERT INTO `g_agency_deduct` VALUES ('9', '30', '曹双', '1493096347', '9000.00', null, '0', '2', '1', 'lrdouble', '房卡');
INSERT INTO `g_agency_deduct` VALUES ('10', '30', '曹双', '1493096431', '100000.00', null, '0', '2', '1', 'lrdouble', '房卡');
INSERT INTO `g_agency_deduct` VALUES ('11', '31', 'admin', '1506743346', '10.00', null, '12', '2', '1', 'liuyuxin', '金币');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_agency_gold
-- ----------------------------
INSERT INTO `g_agency_gold` VALUES ('1', '31', '金币', '1203.00', '1203.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代理商购买记录表';

-- ----------------------------
-- Records of g_agency_pay
-- ----------------------------
INSERT INTO `g_agency_pay` VALUES ('35', '30', '曹双', '1493092941', '10', '0.00', '', '2', '1', 'lrdouble', '房卡');
INSERT INTO `g_agency_pay` VALUES ('36', '30', '曹双', '1493096234', '10000', '0.00', '', '2', '1', 'lrdouble', '房卡');
INSERT INTO `g_agency_pay` VALUES ('37', '30', '曹双', '1493096249', '10000', '0.00', '', '2', '1', 'lrdouble', '金币');
INSERT INTO `g_agency_pay` VALUES ('38', '30', '曹双', '1493096391', '100000', '0.00', '', '2', '1', 'lrdouble', '房卡');
INSERT INTO `g_agency_pay` VALUES ('67', '31', 'admin', '1506742259', '1', '1.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('68', '31', 'admin', '1506742262', '1', '1.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('69', '31', 'admin', '1506742279', '111', '111.00', '', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('70', '31', 'admin', '1506742448', '100', '1000.00', '我充值的', '2', '1', 'liuyuxin', '金币');
INSERT INTO `g_agency_pay` VALUES ('71', '31', 'admin', '1506742676', '1000', '2.00', '充值1000金币', '2', '1', 'liuyuxin', '金币');

-- ----------------------------
-- Table structure for g_draw_water
-- ----------------------------
DROP TABLE IF EXISTS `g_draw_water`;
CREATE TABLE `g_draw_water` (
  `id` int(11) NOT NULL COMMENT '抽水 记录',
  `game_id` int(11) DEFAULT NULL COMMENT '玩家ID',
  `nickname` varchar(30) DEFAULT NULL COMMENT '玩家昵称',
  `pay_out_money` int(11) DEFAULT NULL,
  `winner` varchar(20) DEFAULT NULL COMMENT '是否是赢家',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  `created_at` int(11) DEFAULT NULL COMMENT '时间',
  `type` int(11) DEFAULT NULL COMMENT '1: 转账抽水    2: 游戏抽水',
  `roll_in_game_id` int(11) DEFAULT NULL COMMENT '转入ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_draw_water
-- ----------------------------
INSERT INTO `g_draw_water` VALUES ('0', '100075', '古典风格 大大的', '1', '1', '1', '1506681139', '1', '1212');

-- ----------------------------
-- Table structure for g_draw_water_ratio
-- ----------------------------
DROP TABLE IF EXISTS `g_draw_water_ratio`;
CREATE TABLE `g_draw_water_ratio` (
  `id` int(11) NOT NULL,
  `ratio` int(11) DEFAULT NULL COMMENT '抽水比例',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_draw_water_ratio
-- ----------------------------
INSERT INTO `g_draw_water_ratio` VALUES ('1', '23', '1506684190');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='玩家战绩表';

-- ----------------------------
-- Records of g_game_exploits
-- ----------------------------
INSERT INTO `g_game_exploits` VALUES ('1', '76', '100072', '下次v想吃v是的v是的v是的', '1506680100', '0', '扎金花匹配房,底分0.1', '1', '输', null);
INSERT INTO `g_game_exploits` VALUES ('2', '77', '100074', '吃v不是等等', '1506680394', '0', '扎金花匹配房,底分0.1', '1', '赢', null);
INSERT INTO `g_game_exploits` VALUES ('3', '78', '100075', '古典风格 大大的', '1506680394', '0', '扎金花匹配房,底分0.1', '1', '输', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公告通知数据库';

-- ----------------------------
-- Records of g_notice
-- ----------------------------
INSERT INTO `g_notice` VALUES ('4', '1', 'lrdouble', '通知通知', '	欢迎来到XXX麻将。做代理请联系微信15982707139。买卡请联系1210783098。祝大家玩的愉快。', '1', '1492067668', '没备注', '首页公告');
INSERT INTO `g_notice` VALUES ('5', '1', 'lrdouble', '首页滚动公告', '首页滚动公告首页滚动公告首页滚动公告首页滚动公告首页滚动公告', '1', '1493102442', '首页滚动公告', '首页滚动公告');
INSERT INTO `g_notice` VALUES ('6', '1', 'lrdouble', '房间滚动公告', '房间滚动公告房间滚动公告房间滚动公告', '1', '1493102458', '房间滚动公告', '房间滚动公告');

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
  PRIMARY KEY (`id`),
  KEY `rebate_conf` (`rebate_conf`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `g_rebate_ibfk_2` FOREIGN KEY (`agency_id`) REFERENCES `g_agency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='返利表';

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
  `agency_one` int(11) DEFAULT NULL COMMENT '代理一级',
  `agency_two` int(11) DEFAULT NULL COMMENT '代理二级',
  `users_one` int(11) DEFAULT NULL COMMENT '玩家一级',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_rebate_ratio
-- ----------------------------
INSERT INTO `g_rebate_ratio` VALUES ('1', '1', '2', '12');

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
  `superior` int(11) DEFAULT NULL COMMENT '商家ID',
  `superior_name` varchar(30) DEFAULT NULL COMMENT '上级姓名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `111` (`game_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='玩家表';

-- ----------------------------
-- Records of g_users
-- ----------------------------
INSERT INTO `g_users` VALUES ('67', '100049', '水电费人温柔温柔', null, null, '6', '6', '1506416009', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('68', '100050', '宣传宣传', null, null, '6', '6', '1506419816', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('69', '100051', '日去', null, null, '6', '6', '1506575572', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('70', '100052', '请求', null, null, '6', '6', '1506575815', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('71', '100053', '问问', null, null, '6', '6', '1506575829', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('72', '100054', '11去', null, null, '6', '6', '1506576456', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('73', '100055', '自去', null, null, '6', '6', '1506576501', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('74', '100056', '11请求', null, null, '6', '6', '1506577244', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('75', '100057', '431', null, null, '6', '6', '1506577448', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('76', '100072', '下次v想吃v是的v是的v是的', null, null, '6', '6', '1506680011', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('77', '100074', '吃v不是等等', null, null, '6', '6', '1506680289', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('78', '100075', '古典风格 大大的', null, null, '1', '1', '1506680363', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);
INSERT INTO `g_users` VALUES ('79', '100076', '44554方法', null, null, '6', '6', '1506751269', '0', 'http://g.hiphotos.baidu.com/image/pic/item/08f790529822720eb25fa86479cb0a46f31fab9f.jpg', '1', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of g_users_gold
-- ----------------------------
INSERT INTO `g_users_gold` VALUES ('36', '68', '金币', '1000.00', '21100.00');
INSERT INTO `g_users_gold` VALUES ('37', '69', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('38', '70', '金币', '1213333.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('39', '71', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('40', '72', '金币', '6.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('41', '73', '金币', '121212.00', '6.00');
INSERT INTO `g_users_gold` VALUES ('42', '79', '金币', '6.00', '6.00');

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
INSERT INTO `g_user_dedict` VALUES ('89', '1', '平台', '67', '100049', '水电费人温柔温柔', '1506418658', '100', '0.00', '1', '金币');

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
  `gold` int(11) unsigned DEFAULT NULL COMMENT '消费金币数量',
  `game_class` varchar(32) DEFAULT NULL COMMENT '消费类型',
  `notes` varchar(255) DEFAULT NULL COMMENT '消费详情',
  `gold_config` varchar(32) NOT NULL DEFAULT '' COMMENT '消费类型',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `game_class` (`game_class`),
  CONSTRAINT `g_user_out_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `g_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家消费表';

-- ----------------------------
-- Records of g_user_out
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='玩家充值表';

-- ----------------------------
-- Records of g_user_pay
-- ----------------------------
INSERT INTO `g_user_pay` VALUES ('89', '1', '平台', '67', '100049', '水电费人温柔温柔', '1506418658', '100', '0.00', '1', '金币', null, null);
INSERT INTO `g_user_pay` VALUES ('90', '1', '平台', '68', '100050', '宣传宣传', '1506419893', '10', '0.00', '1', '金币', '1', null);
INSERT INTO `g_user_pay` VALUES ('91', '1', '平台', '68', '100050', '宣传宣传', '1506419898', '10', '0.00', '1', '金币', '1', null);
INSERT INTO `g_user_pay` VALUES ('92', '1', '平台', '68', '100050', '宣传宣传', '1506421003', '16', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('93', '1', '平台', '68', '100050', '宣传宣传', '1506421079', '100', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('94', '1', '平台', '68', '100050', '宣传宣传', '1506422555', '2', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('95', '1', '平台', '68', '100050', '宣传宣传', '1506422579', '1000', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('96', '1', '平台', '68', '100050', '宣传宣传', '1506422585', '2', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('97', '1', '平台', '68', '100050', '宣传宣传', '1506422655', '1000', '0.00', '1', '金币', '1', '我给你充值的');
INSERT INTO `g_user_pay` VALUES ('98', '1', '平台', '68', '100050', '宣传宣传', '1506423514', '20000', '0.00', '1', '金币', '1', '我给');
INSERT INTO `g_user_pay` VALUES ('99', '1', '平台', '68', '100050', '宣传宣传', '1506423530', '20000', '0.00', '1', '金币', '2', '');
INSERT INTO `g_user_pay` VALUES ('100', '1', '平台', '75', '100057', '431', '1506678013', '111', '0.00', '1', '金币', '1', '我充值的');
