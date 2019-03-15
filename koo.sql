/*
Navicat MySQL Data Transfer

Source Server         : MOS
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : koo

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-03-15 14:55:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(2) NOT NULL,
  `account` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '123456');

-- ----------------------------
-- Table structure for `bill`
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `m_list` varchar(255) NOT NULL,
  `m_price` varchar(255) NOT NULL,
  `m_table` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill
-- ----------------------------
INSERT INTO `bill` VALUES ('菜', '100', '');
INSERT INTO `bill` VALUES ('麦乐鸡5块 ×1 经典麦辣鸡腿汉堡 ×1 原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 ', '76', '6');
INSERT INTO `bill` VALUES ('麦乐鸡5块 ×1 经典麦辣鸡腿汉堡 ×1 原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 薯条（大） ×1 优品豆浆（大） ×1 金馒头 ×1 脆薯饼 ×1 脆香油条 ×1 板烧鸡腿早晨全餐配鲜煮咖啡 ×1 栗子风味优品豆浆（大） ×1 火腿扒蛋麦煎饼配脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 霆锋酷辣鸡腿堡 ×1 ', '116.5', '4');
INSERT INTO `bill` VALUES ('麦乐鸡5块 ×1 麦辣鸡翅4块 ×1 麦乐鸡5块 ×1 麦辣鸡翅4块 ×3 ', '77', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡中薯套餐 ×1 ', '30', '2');
INSERT INTO `bill` VALUES ('脆香油条 ×1 经典麦辣鸡腿汉堡中薯套餐 ×1 ', '34.5', '6');
INSERT INTO `bill` VALUES ('香骨鸡腿 ×1 优品豆浆（大） ×1 原味板烧鸡腿堡 ×5 ', '90', '5');
INSERT INTO `bill` VALUES ('脆香油条 ×1 ', '5.5', '5');
INSERT INTO `bill` VALUES ('经典麦辣鸡腿汉堡中薯套餐 ×1 麦辣鸡翅2块 ×1 ', '11', '6');
INSERT INTO `bill` VALUES ('薯条（大） ×1 香骨鸡腿 ×1 ', '24', '6');
INSERT INTO `bill` VALUES ('脆香油条 ×1 经典麦辣鸡腿汉堡中薯套餐 ×1 ', '34.5', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡小玉套餐 ×20 ', '600', '5');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡小玉套餐 ×20 麦辣鸡翅2块 ×1 麦辣鸡翅2块 ×1 ', '11', '5');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 香骨鸡腿 ×1 ', '60', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 香骨鸡腿 ×1 脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 ', '22', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 香骨鸡腿 ×1 脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 汉堡包 ×1 汉堡包 ×1 ', '7.5', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡中薯套餐 ×1 原味板烧鸡腿堡 ×1 香骨鸡腿 ×1 脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 油条培根蛋麦煎饼配脆薯饼 ×1 汉堡包 ×1 汉堡包 ×1 汉堡包 ×1 ', '7.5', '6');
INSERT INTO `bill` VALUES ('麦辣鸡翅2块 ×1 经典麦辣鸡腿汉堡中薯套餐 ×1 ', '40', '6');
INSERT INTO `bill` VALUES ('经典麦辣鸡腿汉堡中薯套餐 ×1 ', '29', '5');
INSERT INTO `bill` VALUES ('经典麦辣鸡腿汉堡 ×1 ', '17', '5');
INSERT INTO `bill` VALUES ('经典麦辣鸡腿汉堡 ×1 ', '17', '6');
INSERT INTO `bill` VALUES ('经典麦辣鸡腿汉堡 ×1 ', '17', '6');
INSERT INTO `bill` VALUES ('原味板烧鸡腿堡 ×1 ', '18', '6');
INSERT INTO `bill` VALUES ('脆香油条 ×1 ', '5.5', '2');
INSERT INTO `bill` VALUES ('脆香油条 ×1 脆香油条 ×1 麦辣鸡翅2块 ×1 经典麦辣鸡腿汉堡中薯套餐 ×1 ', '45.5', '2');
INSERT INTO `bill` VALUES ('脆香油条 1,麦辣鸡翅2块 1,经典麦辣鸡腿汉堡中薯套餐 1,', '45.5', '5');
INSERT INTO `bill` VALUES ('脆香油条 1,麦辣鸡翅2块 1,经典麦辣鸡腿汉堡中薯套餐 1,', '45.5', '4');

-- ----------------------------
-- Table structure for `dish`
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `name` varchar(8) NOT NULL,
  `id` int(8) NOT NULL,
  `price` double(5,0) NOT NULL,
  `cook` varchar(10) NOT NULL,
  `time` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dish
-- ----------------------------

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `name` varchar(10) NOT NULL,
  `cook` varchar(20) DEFAULT NULL,
  `permission` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('张三', null, '无');

-- ----------------------------
-- Table structure for `waiter`
-- ----------------------------
DROP TABLE IF EXISTS `waiter`;
CREATE TABLE `waiter` (
  `account` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waiter
-- ----------------------------
INSERT INTO `waiter` VALUES ('asd', '123');
INSERT INTO `waiter` VALUES ('123', '123');
INSERT INTO `waiter` VALUES ('hjkj13', 'asd');
INSERT INTO `waiter` VALUES ('阿萨德', 'asd');
