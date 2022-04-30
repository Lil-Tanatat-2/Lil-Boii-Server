/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : fivem_1

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 28/09/2019 19:03:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addon_account
-- ----------------------------
DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE `addon_account`  (
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of addon_account
-- ----------------------------
INSERT INTO `addon_account` VALUES ('bank_savings', 'Bank Savings', 0);
INSERT INTO `addon_account` VALUES ('caution', 'caution', 0);
INSERT INTO `addon_account` VALUES ('property_black_money', 'Money Sale Property', 0);
INSERT INTO `addon_account` VALUES ('society_ambulance', 'Ambulance', 1);
INSERT INTO `addon_account` VALUES ('society_banker', 'Banker', 1);
INSERT INTO `addon_account` VALUES ('society_cardealer', 'Cardealer', 1);
INSERT INTO `addon_account` VALUES ('society_mechanic', 'Mechanic', 1);
INSERT INTO `addon_account` VALUES ('society_police', 'Police', 1);
INSERT INTO `addon_account` VALUES ('society_realestateagent', 'Agent immobilier', 1);
INSERT INTO `addon_account` VALUES ('society_taxi', 'Taxi', 1);

-- ----------------------------
-- Table structure for addon_account_data
-- ----------------------------
DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE `addon_account_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `money` double NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`(191)) USING BTREE,
  INDEX `money`(`money`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5258 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for addon_inventory
-- ----------------------------
DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE `addon_inventory`  (
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of addon_inventory
-- ----------------------------
INSERT INTO `addon_inventory` VALUES ('property', 'Property', 0);
INSERT INTO `addon_inventory` VALUES ('society_ambulance', 'Ambulance', 1);
INSERT INTO `addon_inventory` VALUES ('society_cardealer', 'Cardealer', 1);
INSERT INTO `addon_inventory` VALUES ('society_mechanic', 'Mechanic', 1);
INSERT INTO `addon_inventory` VALUES ('society_police', 'Police', 1);
INSERT INTO `addon_inventory` VALUES ('society_taxi', 'Taxi', 1);

-- ----------------------------
-- Table structure for addon_inventory_items
-- ----------------------------
DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE `addon_inventory_items`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for billing
-- ----------------------------
DROP TABLE IF EXISTS `billing`;
CREATE TABLE `billing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `target_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL,
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6193 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for cardealer_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `cardealer_vehicles`;
CREATE TABLE `cardealer_vehicles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dateofbirth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'M',
  `height` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier`(`identifier`(191)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1761 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for datastore
-- ----------------------------
DROP TABLE IF EXISTS `datastore`;
CREATE TABLE `datastore`  (
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of datastore
-- ----------------------------
INSERT INTO `datastore` VALUES ('property', 'Property', 0);
INSERT INTO `datastore` VALUES ('society_ambulance', 'Ambulance', 1);
INSERT INTO `datastore` VALUES ('society_police', 'Police', 1);
INSERT INTO `datastore` VALUES ('society_taxi', 'Taxi', 1);
INSERT INTO `datastore` VALUES ('user_ears', 'Ears', 0);
INSERT INTO `datastore` VALUES ('user_glasses', 'Glasses', 0);
INSERT INTO `datastore` VALUES ('user_helmet', 'Helmet', 0);
INSERT INTO `datastore` VALUES ('user_mask', 'Mask', 0);

-- ----------------------------
-- Table structure for datastore_data
-- ----------------------------
DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE `datastore_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `data` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_datastore_owner_name`(`owner`, `name`) USING BTREE,
  INDEX `index_datastore_name`(`name`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8720 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for fine_types
-- ----------------------------
DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE `fine_types`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `amount` int(11) NULL DEFAULT NULL,
  `category` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of fine_types
-- ----------------------------
INSERT INTO `fine_types` VALUES (1, 'การใช้แตรในทางที่ผิด', 30, 0);
INSERT INTO `fine_types` VALUES (2, 'การข้ามเส้นต่อเนื่องอย่างผิดกฎหมาย', 40, 0);
INSERT INTO `fine_types` VALUES (3, 'การขับขี่บนถนนผิดด้าน', 250, 0);
INSERT INTO `fine_types` VALUES (4, 'ผิดกฎหมายกลับรถ', 250, 0);
INSERT INTO `fine_types` VALUES (5, 'ขับรถออฟโรดอย่างผิดกฎหมาย', 170, 0);
INSERT INTO `fine_types` VALUES (6, 'ปฏิเสธคำสั่งที่ชอบด้วยกฎหมาย', 30, 0);
INSERT INTO `fine_types` VALUES (7, 'การหยุดยานพาหนะโดยมิชอบด้วยกฎหมาย', 150, 0);
INSERT INTO `fine_types` VALUES (8, 'ที่จอดรถผิดกฎหมาย', 70, 0);
INSERT INTO `fine_types` VALUES (9, 'ล้มเหลวในการให้ผลผลิตทางด้านขวา', 70, 0);
INSERT INTO `fine_types` VALUES (10, 'ความล้มเหลวในการปฏิบัติตามข้อมูลยานพาหนะ', 90, 0);
INSERT INTO `fine_types` VALUES (11, 'ไม่สามารถหยุดที่ป้ายหยุด', 105, 0);
INSERT INTO `fine_types` VALUES (12, 'ไม่สามารถหยุดได้ที่ไฟแดง', 130, 0);
INSERT INTO `fine_types` VALUES (13, 'การผ่านที่ผิดกฎหมาย', 100, 0);
INSERT INTO `fine_types` VALUES (14, 'ขับรถผิดกฎหมาย', 100, 0);
INSERT INTO `fine_types` VALUES (15, 'ขับรถโดยไม่มีใบอนุญาต', 1500, 0);
INSERT INTO `fine_types` VALUES (16, 'ชนแล้วหนี', 800, 0);
INSERT INTO `fine_types` VALUES (17, 'เกินความเร็วเกิน <5 mph', 90, 0);
INSERT INTO `fine_types` VALUES (18, 'ความเร็วที่เกินเกินกว่า 5-15 ไมล์ต่อชั่วโมง', 120, 0);
INSERT INTO `fine_types` VALUES (19, 'ความเร็วที่มากกว่า 15-30 ไมล์ต่อชั่วโมง', 180, 0);
INSERT INTO `fine_types` VALUES (20, 'เกินความเร็วมากกว่า> 30 ไมล์ต่อชั่วโมง', 300, 0);
INSERT INTO `fine_types` VALUES (21, 'ขัดขวางการไหลของการจราจร', 110, 1);
INSERT INTO `fine_types` VALUES (22, 'ความมัวเมาสาธารณะ', 90, 1);
INSERT INTO `fine_types` VALUES (23, 'ความประพฤติไม่เป็นระเบียบ', 90, 1);
INSERT INTO `fine_types` VALUES (24, 'การขัดขวางกระบวนการยุติธรรม', 130, 1);
INSERT INTO `fine_types` VALUES (25, 'ด่าต่อพลเรือน', 75, 1);
INSERT INTO `fine_types` VALUES (26, 'ไม่เคารพเจ้าพนักงาน', 110, 1);
INSERT INTO `fine_types` VALUES (27, 'การคุกคามทางวาจาต่อพลเรือน', 90, 1);
INSERT INTO `fine_types` VALUES (28, 'ภัยคุกคามทางวาจาต่อเจ้าพนักงาน', 150, 1);
INSERT INTO `fine_types` VALUES (29, 'การให้ข้อมูลเท็จ', 250, 1);
INSERT INTO `fine_types` VALUES (30, 'ความพยายามในการทุจริต', 1500, 1);
INSERT INTO `fine_types` VALUES (31, 'ควงอาวุธในเขตเมือง', 120, 2);
INSERT INTO `fine_types` VALUES (32, 'ควงอาวุธร้ายในเมืองขีด จำกัด', 300, 2);
INSERT INTO `fine_types` VALUES (33, 'ไม่มีอาวุธปืน', 600, 2);
INSERT INTO `fine_types` VALUES (34, 'การครอบครองอาวุธที่ผิดกฎหมาย', 700, 2);
INSERT INTO `fine_types` VALUES (35, 'การครอบครองเครื่องมือย่องเบา', 300, 2);
INSERT INTO `fine_types` VALUES (36, 'โจรกรรมรถ', 1800, 2);
INSERT INTO `fine_types` VALUES (37, 'ตั้งใจที่จะขายสารที่ผิดกฎหมาย', 1500, 2);
INSERT INTO `fine_types` VALUES (38, 'การสร้างสารที่ผิดกฎหมาย', 1500, 2);
INSERT INTO `fine_types` VALUES (39, 'การครอบครองสารที่ผิดกฎหมาย', 650, 2);
INSERT INTO `fine_types` VALUES (40, 'การลักพาตัวของพลเรือน', 1500, 2);
INSERT INTO `fine_types` VALUES (41, 'ลักพาตัวเจ้าพนักงาน', 2000, 2);
INSERT INTO `fine_types` VALUES (42, 'โจรกรรม', 650, 2);
INSERT INTO `fine_types` VALUES (43, 'การปล้นอาวุธของร้านค้า', 650, 2);
INSERT INTO `fine_types` VALUES (44, 'การปล้นอาวุธของธนาคาร', 1500, 2);
INSERT INTO `fine_types` VALUES (45, 'โจมตีพลเรือน', 2000, 3);
INSERT INTO `fine_types` VALUES (46, 'ทำร้ายเจ้าพนักงาน', 2500, 3);
INSERT INTO `fine_types` VALUES (47, 'ความพยายามในการสังหารพลเรือน', 3000, 3);
INSERT INTO `fine_types` VALUES (48, 'พยายามฆ่าเจ้าพนักงาน', 5000, 3);
INSERT INTO `fine_types` VALUES (49, 'การสังหารพลเรือน', 10000, 3);
INSERT INTO `fine_types` VALUES (50, 'คดีฆาตกรรมลีโอ', 30000, 3);
INSERT INTO `fine_types` VALUES (51, 'การฆาตกรรมโดยไม่สมัครใจ', 1800, 3);
INSERT INTO `fine_types` VALUES (52, 'การหลอกลวง', 2000, 2);

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items`  (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `can_remove`(`can_remove`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of items
-- ----------------------------
INSERT INTO `items` VALUES ('ammo_pistol', 'Ammo Pistol x24', 10, 0, 1);
INSERT INTO `items` VALUES ('ammo_pistol50', 'Ammo Pistol .50 x18', 10, 0, 1);
INSERT INTO `items` VALUES ('anesthetic1', 'ยาสลบ', 5, 0, 1);
INSERT INTO `items` VALUES ('anesthetic2', 'น้ำเกลือ', 5, 0, 1);
INSERT INTO `items` VALUES ('armor', 'เกราะกันกระสุน', 1, 0, 1);
INSERT INTO `items` VALUES ('bandage', 'ผ้าพันแผล', 3, 0, 1);
INSERT INTO `items` VALUES ('beer', 'เบียร์', 10, 0, 1);
INSERT INTO `items` VALUES ('bikersuit', 'Gucci Belt เข็มขัดหนัง', 8, 0, 1);
INSERT INTO `items` VALUES ('bottle', 'Empty Bottle', -1, 0, 1);
INSERT INTO `items` VALUES ('bread', 'ขนมปัง', 2, 0, 1);
INSERT INTO `items` VALUES ('broken_gun', 'ซากปืนที่แตกหัก ', 3, 0, 1);
INSERT INTO `items` VALUES ('burger', 'เบอเกอร์เนื้อดับเบิ้ลชีส', 2, 0, 1);
INSERT INTO `items` VALUES ('cannabis', 'ใบกัญชา', 20, 0, 1);
INSERT INTO `items` VALUES ('catfish', 'ปลาดุก', 50, 0, 1);
INSERT INTO `items` VALUES ('catfishfood', 'ยำปลาดุฟู', 20, 0, 1);
INSERT INTO `items` VALUES ('coffee', 'กาแฟ', 2, 0, 1);
INSERT INTO `items` VALUES ('coke', 'Coke', 1, 0, 1);
INSERT INTO `items` VALUES ('coke_pooch', 'โคเคน', 20, 0, 1);
INSERT INTO `items` VALUES ('cola', 'โคล่า', 10, 0, 1);
INSERT INTO `items` VALUES ('cook_corn', 'ข้าวโพด', 250, 0, 1);
INSERT INTO `items` VALUES ('cook_cornflour', 'แป้งข้าวโพด', 50, 0, 1);
INSERT INTO `items` VALUES ('cook_lettuce', 'ผักกาด', 250, 0, 1);
INSERT INTO `items` VALUES ('cook_lettuce_process', 'ผักกาดหั่น', 250, 0, 1);
INSERT INTO `items` VALUES ('cook_ride_plant', 'ต้นข้าว', 1000, 0, 1);
INSERT INTO `items` VALUES ('cook_ride_plant_process', 'ข้าว', 500, 0, 1);
INSERT INTO `items` VALUES ('cook_tomato', 'มะเขือเทศ', 250, 0, 1);
INSERT INTO `items` VALUES ('copper_bar', 'แท่งทองแดง', 50, 0, 1);
INSERT INTO `items` VALUES ('copper_nugget', 'นักเก็ตทองแดง', 50, 0, 1);
INSERT INTO `items` VALUES ('croquettes', 'อาหารสัตว์', 20, 0, 1);
INSERT INTO `items` VALUES ('defibrillator', 'Defibrillator', 2, 0, 1);
INSERT INTO `items` VALUES ('diamond', 'เพชร', 300, 0, 1);
INSERT INTO `items` VALUES ('donut1', 'โดนัท', 5, 0, 1);
INSERT INTO `items` VALUES ('donut2', 'โดนัท ช็อกโกแลต', 5, 0, 1);
INSERT INTO `items` VALUES ('energy_drink', 'เครื่องดื่มชูกำลัง', 10, 0, 1);
INSERT INTO `items` VALUES ('firstaid', 'ชุดปฐมพยาบาล', 1, 0, 1);
INSERT INTO `items` VALUES ('fish2', 'ปลา', 100, 0, 1);
INSERT INTO `items` VALUES ('fishbait', 'เหยื่อปลา', 30, 0, 1);
INSERT INTO `items` VALUES ('fishingrod', 'เบ็ดตกปลา', 5, 0, 1);
INSERT INTO `items` VALUES ('fixkit', 'ชุดซ่อมรถ', 5, 0, 1);
INSERT INTO `items` VALUES ('gauze', 'Gauze', 25, 0, 1);
INSERT INTO `items` VALUES ('glass', 'ปูไข่ดอง', 30, 0, 1);
INSERT INTO `items` VALUES ('gold_bar', 'ทองคำแท่ง', 300, 0, 1);
INSERT INTO `items` VALUES ('gold_nugget', 'ก้อนทองคำ', 300, 0, 1);
INSERT INTO `items` VALUES ('grass', 'ขี้วัว', 1000, 0, 1);
INSERT INTO `items` VALUES ('grass_pack', 'กาแฟขี้วัว', 1000, 0, 1);
INSERT INTO `items` VALUES ('grill', 'ชุดร้านค้า', 1, 0, 1);
INSERT INTO `items` VALUES ('gun_barrel', 'ลำกล้องปืน', 5, 0, 1);
INSERT INTO `items` VALUES ('handcuffs', 'กุญแจมือ', 1, 0, 1);
INSERT INTO `items` VALUES ('handcuffs_key', 'กุญแจ', 1, 0, 1);
INSERT INTO `items` VALUES ('hatchet_lj', 'มีดกรีดยาง', 1, 0, 1);
INSERT INTO `items` VALUES ('hookah', 'บ้อง', 1, 0, 1);
INSERT INTO `items` VALUES ('hotdog', 'ฮอทด็อก', 2, 0, 1);
INSERT INTO `items` VALUES ('hydrocodone', 'Hydrocodone', 5, 0, 1);
INSERT INTO `items` VALUES ('juice', 'น้ำผลไม้', 2, 0, 1);
INSERT INTO `items` VALUES ('jumelles', 'กล้องส่องทางไกล', 1, 0, 1);
INSERT INTO `items` VALUES ('lEbait', 'เหยื่อระดับเทพ', -1, 0, 1);
INSERT INTO `items` VALUES ('lUbait', 'เหยื่อปานหลาง', -1, 0, 1);
INSERT INTO `items` VALUES ('lbait', 'เหยื่อหนอนตกปลา', -1, 0, 1);
INSERT INTO `items` VALUES ('leather', 'หนังวัว', 40, 0, 1);
INSERT INTO `items` VALUES ('leather_gun', 'ด้ามปืนหนังวัว', 5, 0, 1);
INSERT INTO `items` VALUES ('lfish', 'ปลา', -1, 0, 1);
INSERT INTO `items` VALUES ('license_doctor', 'License Doctor', 1, 0, 1);
INSERT INTO `items` VALUES ('lrod', 'เบ็ดตกปลา', -1, 0, 1);
INSERT INTO `items` VALUES ('marijuana', 'กัญชาขวด', 20, 0, 1);
INSERT INTO `items` VALUES ('meat', 'เนื้อวากิว A5', 80, 0, 1);
INSERT INTO `items` VALUES ('meatfood', 'สเต็กเซอร์ลอยน์ A5', 20, 0, 1);
INSERT INTO `items` VALUES ('medikit', 'Medikit', 2, 0, 1);
INSERT INTO `items` VALUES ('metal_scrap', 'Metal Scrap', 300, 0, 1);
INSERT INTO `items` VALUES ('milk', 'นมวัว', -1, 0, 1);
INSERT INTO `items` VALUES ('mining_lease', 'ใบอนุญาติขุดเหมือง', 1, 0, 1);
INSERT INTO `items` VALUES ('morphine', 'Morphine', 5, 0, 1);
INSERT INTO `items` VALUES ('news_bmic', 'ไมค์บูม', 1, 0, 1);
INSERT INTO `items` VALUES ('news_cam', 'กล้องนักข่าว', 1, 0, 1);
INSERT INTO `items` VALUES ('news_mic', 'ไมค์นักข่าว', 1, 0, 1);
INSERT INTO `items` VALUES ('paper_bag', 'ถุงกระดาษ', 5, 0, 1);
INSERT INTO `items` VALUES ('pie', 'พายเนื้อ', 2, 0, 1);
INSERT INTO `items` VALUES ('plasticbag', 'ถุงพลาสติก', -1, 0, 1);
INSERT INTO `items` VALUES ('plongee1', 'Diving Suit', -1, 0, 1);
INSERT INTO `items` VALUES ('pro_wood', 'ยางรถยนต์', 10, 0, 1);
INSERT INTO `items` VALUES ('radio', 'วิทยุ', 1, 0, 1);
INSERT INTO `items` VALUES ('rag', 'ผ้า', 1, 0, 1);
INSERT INTO `items` VALUES ('raw_ore', 'แร่ดิบ', 300, 0, 1);
INSERT INTO `items` VALUES ('rough_diamond', 'Rough Diamond', 1, 0, 1);
INSERT INTO `items` VALUES ('sand', 'ปูม้า', 60, 0, 1);
INSERT INTO `items` VALUES ('sanwich', 'แซนวิสปลา', 2, 0, 1);
INSERT INTO `items` VALUES ('shark', 'Shark', 10, 0, 1);
INSERT INTO `items` VALUES ('shell', 'เปลือกหอย', -1, 0, 1);
INSERT INTO `items` VALUES ('shovel', 'พลั่วขุดทราย', 1, 0, 1);
INSERT INTO `items` VALUES ('skateboard', 'Skateboard', 1, 0, 1);
INSERT INTO `items` VALUES ('snakefishfood', 'ปลาช่อนเผา', 10, 0, 1);
INSERT INTO `items` VALUES ('snakeheadfish', 'ปลาช่อน', 20, 0, 1);
INSERT INTO `items` VALUES ('spring', 'สปริง', 5, 0, 1);
INSERT INTO `items` VALUES ('steel_bar', 'Steel Bar', 20, 0, 1);
INSERT INTO `items` VALUES ('stone', 'หิน', -1, 0, 1);
INSERT INTO `items` VALUES ('taco', 'ทาโก้', 2, 0, 1);
INSERT INTO `items` VALUES ('turtle', 'เต่าทะเล', 20, 0, 1);
INSERT INTO `items` VALUES ('turtlebait', 'เหยื่อเต่า', 10, 0, 1);
INSERT INTO `items` VALUES ('vicodin', 'Vicodin', 5, 0, 1);
INSERT INTO `items` VALUES ('wash', 'น้ำยาล้างรถ', 20, 0, 1);
INSERT INTO `items` VALUES ('water', 'น้ำเปล่า', 10, 0, 1);
INSERT INTO `items` VALUES ('weed', 'กัญชายำ', 20, 0, 1);
INSERT INTO `items` VALUES ('wetshit', 'ขยะเปียก ไร้ค่า', -1, 0, 1);
INSERT INTO `items` VALUES ('wood', 'ยางไม้', 50, 0, 1);
INSERT INTO `items` VALUES ('wood_rag', 'เปลือกไม้', -1, 0, 1);
INSERT INTO `items` VALUES ('wool', 'ขนสัตว์', 40, 0, 1);
INSERT INTO `items` VALUES ('zap_oil', 'น้ำมันสน', 5, 0, 1);

-- ----------------------------
-- Table structure for job_grades
-- ----------------------------
DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE `job_grades`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `skin_female` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of job_grades
-- ----------------------------
INSERT INTO `job_grades` VALUES (1, 'unemployed', 0, 'unemployed', 'Unemployed', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (2, 'ambulance', 0, 'ambulance', 'Ambulancier', 3000, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}');
INSERT INTO `job_grades` VALUES (3, 'ambulance', 1, 'doctor', 'Medecin', 3000, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}');
INSERT INTO `job_grades` VALUES (4, 'ambulance', 2, 'chief_doctor', 'Medecin-chef', 3000, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}');
INSERT INTO `job_grades` VALUES (5, 'ambulance', 3, 'boss', 'Chirurgien', 3000, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}');
INSERT INTO `job_grades` VALUES (6, 'banker', 0, 'advisor', 'Advisor', 10, '{}', '{}');
INSERT INTO `job_grades` VALUES (7, 'banker', 1, 'banker', 'Banker', 20, '{}', '{}');
INSERT INTO `job_grades` VALUES (8, 'banker', 2, 'business_banker', 'Business Banker', 30, '{}', '{}');
INSERT INTO `job_grades` VALUES (9, 'banker', 3, 'trader', 'Trader', 40, '{}', '{}');
INSERT INTO `job_grades` VALUES (10, 'banker', 4, 'boss', 'Boss', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (11, 'lumberjack', 0, 'employee', 'Employee', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (13, 'fueler', 0, 'employee', 'Employee', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (14, 'reporter', 0, 'employee', 'Employee', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (15, 'tailor', 0, 'employee', 'Employee', 0, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (17, 'slaughterer', 0, 'employee', 'Employee', 0, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}');
INSERT INTO `job_grades` VALUES (18, 'police', 0, 'recruit', 'Recruit', 3000, '{}', '{}');
INSERT INTO `job_grades` VALUES (19, 'police', 1, 'officer', 'Officer', 3000, '{}', '{}');
INSERT INTO `job_grades` VALUES (20, 'police', 2, 'sergeant', 'Sergeant', 3000, '{}', '{}');
INSERT INTO `job_grades` VALUES (21, 'police', 3, 'lieutenant', 'Lieutenant', 3000, '{}', '{}');
INSERT INTO `job_grades` VALUES (22, 'police', 4, 'boss', 'Chief', 3000, '{}', '{}');
INSERT INTO `job_grades` VALUES (23, 'realestateagent', 0, 'location', 'Location', 10, '{}', '{}');
INSERT INTO `job_grades` VALUES (24, 'realestateagent', 1, 'vendeur', 'Vendeur', 25, '{}', '{}');
INSERT INTO `job_grades` VALUES (25, 'realestateagent', 2, 'gestion', 'Gestion', 40, '{}', '{}');
INSERT INTO `job_grades` VALUES (26, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (27, 'taxi', 0, 'recrue', 'Recrue', 200, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}');
INSERT INTO `job_grades` VALUES (28, 'taxi', 1, 'novice', 'Novice', 200, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}');
INSERT INTO `job_grades` VALUES (29, 'taxi', 2, 'experimente', 'Experimente', 200, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}');
INSERT INTO `job_grades` VALUES (30, 'taxi', 3, 'uber', 'Uber', 200, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}');
INSERT INTO `job_grades` VALUES (31, 'taxi', 4, 'boss', 'Patron', 200, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}');
INSERT INTO `job_grades` VALUES (32, 'cardealer', 0, 'recruit', 'Recruit', 10, '{}', '{}');
INSERT INTO `job_grades` VALUES (33, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}');
INSERT INTO `job_grades` VALUES (34, 'cardealer', 2, 'experienced', 'Experienced', 40, '{}', '{}');
INSERT INTO `job_grades` VALUES (35, 'cardealer', 3, 'boss', 'Boss', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (36, 'mechanic', 0, 'recrue', 'Recruit', 500, '{\"mask_1\":0,\"arms\":15,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":28,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":238,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":53,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":68,\"hair_color_1\":0,\"pants_1\":83,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":15,\"glasses_1\":1,\"hair_color_2\":4,\"makeup_1\":0,\"face\":31,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":0,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":105,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":15,\"eyebrows_3\":0,\"pants_2\":1,\"beard_4\":0,\"torso_2\":0,\"beard_2\":0,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":8,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":17,\"hair_color_1\":0,\"pants_1\":62,\"helmet_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":0,\"shoes\":8,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (37, 'mechanic', 1, 'novice', 'Novice', 500, '{\"mask_1\":0,\"arms\":15,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":28,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":238,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":53,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":68,\"hair_color_1\":0,\"pants_1\":83,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":15,\"glasses_1\":1,\"hair_color_2\":4,\"makeup_1\":0,\"face\":31,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":0,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":105,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":15,\"eyebrows_3\":0,\"pants_2\":1,\"beard_4\":0,\"torso_2\":0,\"beard_2\":0,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":8,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":17,\"hair_color_1\":0,\"pants_1\":62,\"helmet_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":0,\"shoes\":8,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (38, 'mechanic', 2, 'experimente', 'Experienced', 500, '{\"mask_1\":0,\"arms\":15,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":28,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":238,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":53,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":68,\"hair_color_1\":0,\"pants_1\":83,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":15,\"glasses_1\":1,\"hair_color_2\":4,\"makeup_1\":0,\"face\":31,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":0,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":105,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":15,\"eyebrows_3\":0,\"pants_2\":1,\"beard_4\":0,\"torso_2\":0,\"beard_2\":0,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":8,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":17,\"hair_color_1\":0,\"pants_1\":62,\"helmet_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":0,\"shoes\":8,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (39, 'mechanic', 3, 'chief', 'Leader', 500, '{\"mask_1\":0,\"arms\":15,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":28,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":238,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":53,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":68,\"hair_color_1\":0,\"pants_1\":83,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":15,\"glasses_1\":1,\"hair_color_2\":4,\"makeup_1\":0,\"face\":31,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":0,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":105,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":15,\"eyebrows_3\":0,\"pants_2\":1,\"beard_4\":0,\"torso_2\":0,\"beard_2\":0,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":8,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":17,\"hair_color_1\":0,\"pants_1\":62,\"helmet_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":0,\"shoes\":8,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (40, 'mechanic', 4, 'boss', 'Boss', 500, '{\"mask_1\":0,\"arms\":15,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":28,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":238,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":53,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":68,\"hair_color_1\":0,\"pants_1\":83,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":15,\"glasses_1\":1,\"hair_color_2\":4,\"makeup_1\":0,\"face\":31,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":0,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":105,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":15,\"eyebrows_3\":0,\"pants_2\":1,\"beard_4\":0,\"torso_2\":0,\"beard_2\":0,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":8,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":17,\"hair_color_1\":0,\"pants_1\":62,\"helmet_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":0,\"shoes\":8,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}');
INSERT INTO `job_grades` VALUES (41, 'hunting', 0, 'employee', 'Employee', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (42, 'plowman', 0, 'employee', 'ไถนา', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (43, 'offpolice', 0, 'recruit', 'Recruit', 12, '{}', '{}');
INSERT INTO `job_grades` VALUES (44, 'offpolice', 1, 'officer', 'Officer', 24, '{}', '{}');
INSERT INTO `job_grades` VALUES (45, 'offpolice', 2, 'sergeant', 'Sergeant', 36, '{}', '{}');
INSERT INTO `job_grades` VALUES (46, 'offpolice', 3, 'lieutenant', 'Lieutenant', 48, '{}', '{}');
INSERT INTO `job_grades` VALUES (47, 'offpolice', 4, 'boss', 'Boss', 0, '{}', '{}');
INSERT INTO `job_grades` VALUES (48, 'offambulance', 0, 'ambulance', 'Ambulance', 12, '{}', '{}');
INSERT INTO `job_grades` VALUES (49, 'offambulance', 1, 'doctor', 'Doctor', 24, '{}', '{}');
INSERT INTO `job_grades` VALUES (50, 'offambulance', 2, 'chief_doctor', 'Chef', 36, '{}', '{}');
INSERT INTO `job_grades` VALUES (51, 'offambulance', 3, 'boss', 'Boss', 48, '{}', '{}');
INSERT INTO `job_grades` VALUES (52, 'garbage', 0, 'employee', 'Employee', 0, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}');
INSERT INTO `job_grades` VALUES (53, 'journalist', 0, 'journalist', 'Journalist', 0, '{}', '{}');

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES ('ambulance', 'หมอ', 1);
INSERT INTO `jobs` VALUES ('banker', 'Banker', 1);
INSERT INTO `jobs` VALUES ('cardealer', 'Cardealer', 1);
INSERT INTO `jobs` VALUES ('fueler', 'ขนน้ำมัน', 1);
INSERT INTO `jobs` VALUES ('garbage', 'คนเก็บขยะ', 0);
INSERT INTO `jobs` VALUES ('hunting', 'นายพราน', 1);
INSERT INTO `jobs` VALUES ('journalist', 'นักข่าว', 0);
INSERT INTO `jobs` VALUES ('lumberjack', 'ตัดไม้', 1);
INSERT INTO `jobs` VALUES ('mechanic', 'นายช่าง', 1);
INSERT INTO `jobs` VALUES ('offambulance', 'Off-Duty', 1);
INSERT INTO `jobs` VALUES ('offpolice', 'Off-Duty', 1);
INSERT INTO `jobs` VALUES ('plowman', 'ทำกาแฟ', 0);
INSERT INTO `jobs` VALUES ('police', 'Police', 1);
INSERT INTO `jobs` VALUES ('realestateagent', 'Agent immobilier', 1);
INSERT INTO `jobs` VALUES ('reporter', 'Reporter', 1);
INSERT INTO `jobs` VALUES ('slaughterer', 'ฆ่าไก่', 1);
INSERT INTO `jobs` VALUES ('tailor', 'ตัดผ้า', 1);
INSERT INTO `jobs` VALUES ('taxi', 'Taxi', 1);
INSERT INTO `jobs` VALUES ('unemployed', 'ว่างงาน', 0);

-- ----------------------------
-- Table structure for licenses
-- ----------------------------
DROP TABLE IF EXISTS `licenses`;
CREATE TABLE `licenses`  (
  `type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of licenses
-- ----------------------------
INSERT INTO `licenses` VALUES ('boat', 'ใบอนุญาติขับขี่เรือ');
INSERT INTO `licenses` VALUES ('dmv', 'กฎหมายจราจร');
INSERT INTO `licenses` VALUES ('drive', 'ใบอนุญาติขับขี่รถยนต์');
INSERT INTO `licenses` VALUES ('drive_bike', 'ใบอนุญาติขับขี่รถจักรยานยนต์');
INSERT INTO `licenses` VALUES ('drive_truck', 'ใบอนุญาติขับขี่รถบรรทุก');
INSERT INTO `licenses` VALUES ('weapon', 'ใบอนุญาติพกอาวุธ');
INSERT INTO `licenses` VALUES ('weed_processing', 'ใบอนุญาติผลิตกัญชา');

-- ----------------------------
-- Table structure for meeta_accessory_inventory
-- ----------------------------
DROP TABLE IF EXISTS `meeta_accessory_inventory`;
CREATE TABLE `meeta_accessory_inventory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skin` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1017 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for meeta_economy
-- ----------------------------
DROP TABLE IF EXISTS `meeta_economy`;
CREATE TABLE `meeta_economy`  (
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `item` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NULL DEFAULT NULL,
  `price2` int(11) NULL DEFAULT NULL,
  `difference` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`item`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeta_economy
-- ----------------------------
INSERT INTO `meeta_economy` VALUES ('Gucci Belt เข็มขัดหนัง', 'bikersuit', 0, 220, 220, 245);
INSERT INTO `meeta_economy` VALUES ('แท่งทองแดง', 'copper_bar', 0, 140, 140, 139);
INSERT INTO `meeta_economy` VALUES ('เพชร', 'diamond', 0, 2432, 4836, 2400);
INSERT INTO `meeta_economy` VALUES ('ปูไข่ดอง', 'glass', 0, 100, 100, 138);
INSERT INTO `meeta_economy` VALUES ('แท่งทองคำ', 'gold_bar', 0, 825, 825, 838);
INSERT INTO `meeta_economy` VALUES ('กาแฟขี้วัว', 'grass_pack', 0, 4, 4, 4);
INSERT INTO `meeta_economy` VALUES ('ยางรถยนต์', 'pro_wood', 0, 240, 240, 215);

-- ----------------------------
-- Table structure for meeta_market
-- ----------------------------
DROP TABLE IF EXISTS `meeta_market`;
CREATE TABLE `meeta_market`  (
  `item` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`item`) USING BTREE,
  INDEX `item`(`item`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeta_market
-- ----------------------------
INSERT INTO `meeta_market` VALUES ('cook_corn', 'ข้าวโพด', 0, 3);
INSERT INTO `meeta_market` VALUES ('cook_cornflour', 'แป้งข้าวโพด', 0, 3);
INSERT INTO `meeta_market` VALUES ('cook_lettuce', 'ผักกาด', 0, 3);
INSERT INTO `meeta_market` VALUES ('cook_ride_plant', 'ต้นข้าว', 0, 3);
INSERT INTO `meeta_market` VALUES ('cook_ride_plant_process', 'ข้าว', 0, 3);
INSERT INTO `meeta_market` VALUES ('cook_tomato', 'เมือเขือเทศ', 0, 3);

-- ----------------------------
-- Table structure for meeta_vehicle_trunk
-- ----------------------------
DROP TABLE IF EXISTS `meeta_vehicle_trunk`;
CREATE TABLE `meeta_vehicle_trunk`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `item` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label_weapon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `plate`(`plate`) USING BTREE,
  INDEX `isweapon`(`isweapon`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4412 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for owned_properties
-- ----------------------------
DROP TABLE IF EXISTS `owned_properties`;
CREATE TABLE `owned_properties`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `properties` int(11) NOT NULL DEFAULT 0,
  `islock` int(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for owned_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE `owned_vehicles`  (
  `owner` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Etat de la voiture',
  `plate` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `vehicle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'car',
  `job` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 1,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `car` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `fourrieremecano` tinyint(1) NULL DEFAULT NULL,
  `vehiclename` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'voiture',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `properties` int(255) NOT NULL DEFAULT 0,
  `police` int(11) NOT NULL DEFAULT 0,
  `police_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `health_engine` int(11) NOT NULL DEFAULT 1000,
  `health_body` int(11) NOT NULL DEFAULT 1000,
  `health_tank` int(11) NOT NULL DEFAULT 1000,
  PRIMARY KEY (`plate`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE,
  INDEX `stored`(`stored`) USING BTREE,
  INDEX `properties`(`properties`) USING BTREE,
  INDEX `police`(`police`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for phone_app_chat
-- ----------------------------
DROP TABLE IF EXISTS `phone_app_chat`;
CREATE TABLE `phone_app_chat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel`(`channel`) USING BTREE,
  INDEX `message`(`message`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14142 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for phone_calls
-- ----------------------------
DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE `phone_calls`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l\'origine de l\'appels',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE,
  INDEX `num`(`num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17629 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for phone_messages
-- ----------------------------
DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE `phone_messages`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiver` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transmitter`(`transmitter`) USING BTREE,
  INDEX `receiver`(`receiver`) USING BTREE,
  INDEX `message`(`message`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 92805 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for phone_users_contacts
-- ----------------------------
DROP TABLE IF EXISTS `phone_users_contacts`;
CREATE TABLE `phone_users_contacts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier`(`identifier`) USING BTREE,
  INDEX `number`(`number`) USING BTREE,
  INDEX `display`(`display`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15040 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `propertie_id`(`propertie_id`) USING BTREE,
  INDEX `item`(`item`) USING BTREE,
  INDEX `count`(`count`) USING BTREE,
  INDEX `is_weapon`(`isweapon`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3976 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rented_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `rented_vehicles`;
CREATE TABLE `rented_vehicles`  (
  `vehicle` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `player_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for shops_new
-- ----------------------------
DROP TABLE IF EXISTS `shops_new`;
CREATE TABLE `shops_new`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shops_new
-- ----------------------------
INSERT INTO `shops_new` VALUES (1, 'bread', 200, 'Normal');
INSERT INTO `shops_new` VALUES (2, 'water', 15, 'Normal');
INSERT INTO `shops_new` VALUES (21, 'mining_lease', 1000, 'Mining');
INSERT INTO `shops_new` VALUES (23, 'hookah', 1000, 'Weed');
INSERT INTO `shops_new` VALUES (24, 'croquettes', 100, 'Normal');
INSERT INTO `shops_new` VALUES (25, 'jumelles', 1500, 'Normal');
INSERT INTO `shops_new` VALUES (26, 'fishingrod', 250, 'Fish');
INSERT INTO `shops_new` VALUES (27, 'fishbait', 5, 'Fish');
INSERT INTO `shops_new` VALUES (28, 'turtlebait', 50, 'Fish');
INSERT INTO `shops_new` VALUES (29, 'plongee1', 100, 'Police');
INSERT INTO `shops_new` VALUES (30, 'hatchet_lj', 1000, 'Normal');
INSERT INTO `shops_new` VALUES (31, 'shovel', 1000, 'Normal');
INSERT INTO `shops_new` VALUES (32, 'fixkit', 400, 'Car');
INSERT INTO `shops_new` VALUES (33, 'beer', 100, 'Normal');
INSERT INTO `shops_new` VALUES (34, 'rag', 1000, 'Car');
INSERT INTO `shops_new` VALUES (35, 'wash', 200, 'Car');
INSERT INTO `shops_new` VALUES (36, 'energy_drink', 200, 'Normal');
INSERT INTO `shops_new` VALUES (37, 'handcuffs', 40000, 'Hand');
INSERT INTO `shops_new` VALUES (38, 'handcuffs_key', 5000, 'Hand');
INSERT INTO `shops_new` VALUES (40, 'paper_bag', 4000, 'Hand');
INSERT INTO `shops_new` VALUES (41, 'radio', 20000, 'Normal');
INSERT INTO `shops_new` VALUES (42, 'beer', 100, 'Weed1');
INSERT INTO `shops_new` VALUES (43, 'hookah', 1000, 'Weed1');
INSERT INTO `shops_new` VALUES (44, 'license_doctor', 10000, 'Ambulance');
INSERT INTO `shops_new` VALUES (45, 'medikit', 0, 'Ambulance');
INSERT INTO `shops_new` VALUES (46, 'bandage', 0, 'Ambulance');
INSERT INTO `shops_new` VALUES (47, 'defibrillator', 15000, 'Ambulance');
INSERT INTO `shops_new` VALUES (48, 'news_cam', 1000, 'Journalist');
INSERT INTO `shops_new` VALUES (49, 'news_mic', 1000, 'Journalist');
INSERT INTO `shops_new` VALUES (50, 'news_bmic', 1000, 'Journalist');
INSERT INTO `shops_new` VALUES (51, 'cola', 20, 'Normal');
INSERT INTO `shops_new` VALUES (56, 'anesthetic1', 0, 'Ambulance');
INSERT INTO `shops_new` VALUES (57, 'anesthetic2', 0, 'Ambulance');
INSERT INTO `shops_new` VALUES (58, 'firstaid', 0, 'Ambulance');
INSERT INTO `shops_new` VALUES (59, 'donut1', 20, 'Prison');
INSERT INTO `shops_new` VALUES (60, 'donut2', 20, 'Prison');
INSERT INTO `shops_new` VALUES (61, 'water', 20, 'Prison');
INSERT INTO `shops_new` VALUES (62, 'juice', 100, 'Normal');
INSERT INTO `shops_new` VALUES (63, 'coffee', 50, 'Normal');

-- ----------------------------
-- Table structure for spam
-- ----------------------------
DROP TABLE IF EXISTS `spam`;
CREATE TABLE `spam`  (
  `identifier` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `IsBan` tinyint(1) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for truck_inventory
-- ----------------------------
DROP TABLE IF EXISTS `truck_inventory`;
CREATE TABLE `truck_inventory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `count` int(11) NOT NULL,
  `plate` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `owned` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `item`(`item`, `plate`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trunk_inventory
-- ----------------------------
DROP TABLE IF EXISTS `trunk_inventory`;
CREATE TABLE `trunk_inventory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plate`(`plate`) USING BTREE,
  FULLTEXT INDEX `data`(`data`)
) ENGINE = InnoDB AUTO_INCREMENT = 8297 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for twitter_accounts
-- ----------------------------
DROP TABLE IF EXISTS `twitter_accounts`;
CREATE TABLE `twitter_accounts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1429 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for twitter_likes
-- ----------------------------
DROP TABLE IF EXISTS `twitter_likes`;
CREATE TABLE `twitter_likes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NULL DEFAULT NULL,
  `tweetId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_twitter_likes_twitter_accounts`(`authorId`) USING BTREE,
  INDEX `FK_twitter_likes_twitter_tweets`(`tweetId`) USING BTREE,
  CONSTRAINT `twitter_likes_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `twitter_likes_ibfk_2` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1718 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for twitter_tweets
-- ----------------------------
DROP TABLE IF EXISTS `twitter_tweets`;
CREATE TABLE `twitter_tweets`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_twitter_tweets_twitter_accounts`(`authorId`) USING BTREE,
  INDEX `realUser`(`realUser`) USING BTREE,
  CONSTRAINT `twitter_tweets_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_accounts
-- ----------------------------
DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE `user_accounts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `money` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier`(`identifier`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `money`(`money`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1689 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_contacts
-- ----------------------------
DROP TABLE IF EXISTS `user_contacts`;
CREATE TABLE `user_contacts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_user_contacts_identifier_name_number`(`identifier`, `name`, `number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_inventory
-- ----------------------------
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE `user_inventory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `item` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier`(`identifier`) USING BTREE,
  INDEX `item`(`item`) USING BTREE,
  INDEX `count`(`count`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42057 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_licenses
-- ----------------------------
DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE `user_licenses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1218 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_parkings
-- ----------------------------
DROP TABLE IF EXISTS `user_parkings`;
CREATE TABLE `user_parkings`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `garage` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `zone` int(11) NOT NULL,
  `vehicle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_whitelist
-- ----------------------------
DROP TABLE IF EXISTS `user_whitelist`;
CREATE TABLE `user_whitelist`  (
  `identifier` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_connection` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `ban_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `ban_until` timestamp(0) NULL DEFAULT NULL,
  `vip` int(11) NOT NULL DEFAULT 0,
  `whitelisted` tinyint(1) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  INDEX `whitelisted`(`whitelisted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `license` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `money` int(11) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `skin` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `job` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'unemployed',
  `job_grade` int(11) NULL DEFAULT 0,
  `loadout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `bank` int(11) NULL DEFAULT NULL,
  `permission_level` int(11) NULL DEFAULT NULL,
  `group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `is_dead` tinyint(1) NULL DEFAULT 0,
  `firstname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `lastname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `dateofbirth` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `height` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `phone_number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `last_property` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `pet` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `index_users_phone_number`(`phone_number`) USING BTREE,
  INDEX `identifier`(`identifier`) USING BTREE,
  INDEX `license`(`license`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `money`(`money`) USING BTREE,
  INDEX `bank`(`bank`) USING BTREE,
  INDEX `permission_level`(`permission_level`) USING BTREE,
  INDEX `group`(`group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1812 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vehicle_categories
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE `vehicle_categories`  (
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vehicle_categories
-- ----------------------------
INSERT INTO `vehicle_categories` VALUES ('compacts', 'Compacts');
INSERT INTO `vehicle_categories` VALUES ('coupes', 'Coupes');
INSERT INTO `vehicle_categories` VALUES ('motorcycles', 'Motos');
INSERT INTO `vehicle_categories` VALUES ('muscle', 'Muscle');
INSERT INTO `vehicle_categories` VALUES ('offroad', 'Off Road');
INSERT INTO `vehicle_categories` VALUES ('sedans', 'Sedans');
INSERT INTO `vehicle_categories` VALUES ('sports', 'Sports');
INSERT INTO `vehicle_categories` VALUES ('sportsclassics', 'Sports Classics');
INSERT INTO `vehicle_categories` VALUES ('super', 'Super');
INSERT INTO `vehicle_categories` VALUES ('suvs', 'SUVs');
INSERT INTO `vehicle_categories` VALUES ('vans', 'Vans');

-- ----------------------------
-- Table structure for vehicle_sold
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_sold`;
CREATE TABLE `vehicle_sold`  (
  `client` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `soldby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vehicle_soldout
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_soldout`;
CREATE TABLE `vehicle_soldout`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vehicle` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`, `plate`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vehicles
-- ----------------------------
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE `vehicles`  (
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`model`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vehicles
-- ----------------------------
INSERT INTO `vehicles` VALUES ('\r\nlynx', 'Lynx', 300000, 'super');
INSERT INTO `vehicles` VALUES ('panto', 'Panto', 55000, 'compacts');
INSERT INTO `vehicles` VALUES ('Asea', 'asea', 70000, 'sedans');
INSERT INTO `vehicles` VALUES ('Baller', 'baller2', 90000, 'suvs');
INSERT INTO `vehicles` VALUES ('Z4', 'banshee', 270000, 'super');
INSERT INTO `vehicles` VALUES ('Bison', 'bison', 100000, 'vans');
INSERT INTO `vehicles` VALUES ('Beejay XL', 'bjxl', 200000, 'suvs');
INSERT INTO `vehicles` VALUES ('Blista', 'blista', 80000, 'compacts');
INSERT INTO `vehicles` VALUES ('BMX (velo)', 'bmx', 5000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Brawler', 'brawler', 200000, 'offroad');
INSERT INTO `vehicles` VALUES ('Brio', 'brioso', 85000, 'sportsclassics');
INSERT INTO `vehicles` VALUES ('Burrito', 'burrito3', 60000, 'vans');
INSERT INTO `vehicles` VALUES ('Carbon Izzare', 'carbonizzare', 320000, 'super');
INSERT INTO `vehicles` VALUES ('Casco', 'casco', 230000, 'sportsclassics');
INSERT INTO `vehicles` VALUES ('Cog55', 'cog55', 220000, 'compacts');
INSERT INTO `vehicles` VALUES ('Cruiser', 'cruiser', 5000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Dominator', 'dominator', 250000, 'muscle');
INSERT INTO `vehicles` VALUES ('Dominator GTX', 'dominator3', 300000, 'muscle');
INSERT INTO `vehicles` VALUES ('Emperor', 'emperor', 100000, 'sedans');
INSERT INTO `vehicles` VALUES ('F620', 'f620', 220000, 'super');
INSERT INTO `vehicles` VALUES ('Faggio', 'faggio', 10000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Vespa', 'faggio2', 10000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Fixter', 'fixter', 5000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Fuigitive', 'fuigitive', 150000, 'compacts');
INSERT INTO `vehicles` VALUES ('Guardian', 'guardian', 270000, 'super');
INSERT INTO `vehicles` VALUES ('Intruder', 'intruder', 75000, 'compacts');
INSERT INTO `vehicles` VALUES ('Issi', 'issi2', 60000, 'compacts');
INSERT INTO `vehicles` VALUES ('Issi Classic', 'issi3', 55000, 'compacts');
INSERT INTO `vehicles` VALUES ('Kamacho', 'kamacho', 90000, 'compacts');
INSERT INTO `vehicles` VALUES ('Kuruma', 'kuruma', 180000, 'super');
INSERT INTO `vehicles` VALUES ('Michelli GT', 'michelli', 75000, 'sportsclassics');
INSERT INTO `vehicles` VALUES ('Mini Van', 'minivan', 80000, 'suvs');
INSERT INTO `vehicles` VALUES ('Pigalle', 'pigalle', 100000, 'sportsclassics');
INSERT INTO `vehicles` VALUES ('Premier', 'premier', 80000, 'compacts');
INSERT INTO `vehicles` VALUES ('Primo', 'primo', 85000, 'sedans');
INSERT INTO `vehicles` VALUES ('Rebel', 'rebel2', 80000, 'offroad');
INSERT INTO `vehicles` VALUES ('Rhapsody', 'rhapsody', 70000, 'compacts');
INSERT INTO `vehicles` VALUES ('Schafter2', 'schafter2', 90000, 'compacts');
INSERT INTO `vehicles` VALUES ('Scorcher', 'scorcher', 5000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('serrano', 'serrano', 100000, 'suvs');
INSERT INTO `vehicles` VALUES ('Stafford', 'stafford', 100000, 'compacts');
INSERT INTO `vehicles` VALUES ('Superd ', 'superd', 280000, 'compacts');
INSERT INTO `vehicles` VALUES ('Terbyte', 'terbyte', 10000000, 'vans');
INSERT INTO `vehicles` VALUES ('Whippet Race Bike', 'tribike', 6000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Endurex Race Bike', 'tribike2', 6000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Tri-Cycles Race Bike', 'tribike3', 6000, 'motorcycles');
INSERT INTO `vehicles` VALUES ('Warrener', 'warrener', 60000, 'sedans');
INSERT INTO `vehicles` VALUES ('Z190', 'z190', 230000, 'super');
INSERT INTO `vehicles` VALUES ('Zion', 'zion2', 200000, 'sportsclassics');

-- ----------------------------
-- Table structure for vehicles_for_sale
-- ----------------------------
DROP TABLE IF EXISTS `vehicles_for_sale`;
CREATE TABLE `vehicles_for_sale`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vehicleProps` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for weashops
-- ----------------------------
DROP TABLE IF EXISTS `weashops`;
CREATE TABLE `weashops`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of weashops
-- ----------------------------
INSERT INTO `weashops` VALUES (1, 'BlackWeashop', 'WEAPON_PISTOL50', 13000);

SET FOREIGN_KEY_CHECKS = 1;
