/*二维码临时管理关系*/
CREATE TABLE `g_agency_user_temp`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `unionid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信unionid',
  `agent_id` int(11) NOT NULL COMMENT '代理商的ID',
  `code` int(11) DEFAULT NULL COMMENT '代理的推荐码',
  `create_time` datetime(0) DEFAULT NULL COMMENT '添加时间',
  `status` int(3) DEFAULT NULL COMMENT '1未使用2使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

/*更新用户表的代理关系*/
ALTER TABLE `g_users` ADD `agency_code`  INT(11) UNSIGNED NULL COMMENT '代理推荐码';
ALTER TABLE `g_users` ADD `unionid`  VARCHAR (64) NULL COMMENT '微信的unionid';