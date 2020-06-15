/*
Navicat MySQL Data Transfer

Source Server         : MYSQL
Source Server Version : 50519
Source Host           : 127.0.0.1:3306
Source Database       : java1903

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2020-06-07 23:25:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_user1
-- ----------------------------
DROP TABLE IF EXISTS `t_user1`;
CREATE TABLE `t_user1` (
  `userid` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(16) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user1
-- ----------------------------
INSERT INTO `t_user1` VALUES ('11111@qq.com', '张宇', '222');
INSERT INTO `t_user1` VALUES ('12345@qq.com', '张三', '123');
INSERT INTO `t_user1` VALUES ('22222@qq.com', '王军', '111');
INSERT INTO `t_user1` VALUES ('23155@qq.com', '王五', '434');
INSERT INTO `t_user1` VALUES ('23455@qq.com', '李四', '234');
