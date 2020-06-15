/*
Navicat MySQL Data Transfer

Source Server         : MYSQL
Source Server Version : 50519
Source Host           : 127.0.0.1:3306
Source Database       : java1903

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2020-06-07 23:25:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp` (
  `empno` int(4) NOT NULL AUTO_INCREMENT,
  `ename` varchar(32) NOT NULL,
  `job` varchar(16) DEFAULT NULL,
  `sal` double(7,2) DEFAULT NULL,
  `comm` double(7,2) DEFAULT NULL,
  PRIMARY KEY (`empno`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES ('1', '张三', '大老板', '13000.00', '1400.00');
INSERT INTO `emp` VALUES ('2', '张琳', '秘书', '3000.00', '1300.00');
INSERT INTO `emp` VALUES ('3', '李四', '总经理', '4000.00', '1200.00');
INSERT INTO `emp` VALUES ('4', '王五', '主管', '3500.00', '1000.00');
INSERT INTO `emp` VALUES ('5', '李军', '传菜员', '2600.00', '1000.00');
INSERT INTO `emp` VALUES ('6', '许雅', '服务员', '2500.00', '1100.00');
INSERT INTO `emp` VALUES ('7', '刘军', '服务员', '2400.00', '1200.00');
INSERT INTO `emp` VALUES ('8', '马琴', '服务员', '3000.00', '490.00');
INSERT INTO `emp` VALUES ('9', '赵娟', '财务员', '3100.00', '510.00');
INSERT INTO `emp` VALUES ('10', '李山', '副经理', '3400.00', '900.00');
INSERT INTO `emp` VALUES ('11', '杜玉', '服务员', '2000.00', '1800.00');
INSERT INTO `emp` VALUES ('12', '许飞', '传菜员', '2000.00', '1700.00');
INSERT INTO `emp` VALUES ('13', '任坤', '采购员', '3000.00', '1000.00');
INSERT INTO `emp` VALUES ('15', '余欣', '配菜员', '1000.00', '2800.00');
INSERT INTO `emp` VALUES ('16', '马飘', '后厨', '4000.00', '300.00');
INSERT INTO `emp` VALUES ('17', '周琳', '财务员', '2000.00', '1700.00');
INSERT INTO `emp` VALUES ('18', '毛峰易', '服务员', '3000.00', '650.00');
INSERT INTO `emp` VALUES ('19', '孙耀', '配菜员', '3000.00', '700.00');
INSERT INTO `emp` VALUES ('31', '陈萱', '财务员', '3000.45', '1800.00');
