/*
 Navicat Premium Data Transfer

 Source Server         : Work
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : 192.168.1.2:3306
 Source Schema         : essentialmode

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 09/07/2019 15:44:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for properties_inventory
-- ----------------------------
DROP TABLE IF EXISTS `properties_inventory`;
CREATE TABLE `properties_inventory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propertie_id` int(11) NULL DEFAULT NULL,
  `item` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label_weapon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
