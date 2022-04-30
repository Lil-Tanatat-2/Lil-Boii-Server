-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.18-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for fivem
CREATE DATABASE IF NOT EXISTS `fivem` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `fivem`;

-- Dumping structure for table fivem.addon_account
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.addon_account: ~10 rows (approximately)
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('bank_savings', 'Bank Savings', 0),
	('caution', 'caution', 0),
	('property_black_money', 'Money Sale Property', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_banker', 'Banker', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('society_realestateagent', 'Agent immobilier', 1),
	('society_taxi', 'Taxi', 1);
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dumping structure for table fivem.addon_account_data
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` double NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`(191)) USING BTREE,
  KEY `money` (`money`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.addon_account_data: ~10 rows (approximately)
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(5258, 'society_ambulance', 0, NULL),
	(5259, 'society_banker', 0, NULL),
	(5260, 'society_cardealer', 0, NULL),
	(5261, 'society_mechanic', 0, NULL),
	(5262, 'society_police', 0, NULL),
	(5263, 'society_realestateagent', 0, NULL),
	(5264, 'society_taxi', 0, NULL),
	(5265, 'bank_savings', 0, 'steam:110000136ba6d5a'),
	(5266, 'caution', 0, 'steam:110000136ba6d5a'),
	(5267, 'property_black_money', 0, 'steam:110000136ba6d5a');
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dumping structure for table fivem.addon_inventory
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.addon_inventory: ~6 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.addon_inventory_items
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.addon_inventory_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dumping structure for table fivem.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `sender` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.billing: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dumping structure for table fivem.cardealer_vehicles
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.cardealer_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `cardealer_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cardealer_vehicles` ENABLE KEYS */;

-- Dumping structure for table fivem.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `dateofbirth` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `sex` varchar(1) COLLATE utf8mb4_bin NOT NULL DEFAULT 'M',
  `height` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`(191)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1762 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.characters: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` (`id`, `identifier`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`) VALUES
	(1761, 'steam:110000136ba6d5a', 'ASKY', 'DEV', '12-12-1998', 'm', '185');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table fivem.datastore
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.datastore: ~8 rows (approximately)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1),
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dumping structure for table fivem.datastore_data
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `data` longtext CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_datastore_owner_name` (`owner`,`name`) USING BTREE,
  KEY `index_datastore_name` (`name`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8728 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.datastore_data: ~8 rows (approximately)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(8720, 'society_ambulance', NULL, '{}'),
	(8721, 'society_police', NULL, '{}'),
	(8722, 'society_taxi', NULL, '{}'),
	(8723, 'property', 'steam:110000136ba6d5a', '{}'),
	(8724, 'user_ears', 'steam:110000136ba6d5a', '{}'),
	(8725, 'user_glasses', 'steam:110000136ba6d5a', '{}'),
	(8726, 'user_helmet', 'steam:110000136ba6d5a', '{}'),
	(8727, 'user_mask', 'steam:110000136ba6d5a', '{}');
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dumping structure for table fivem.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fivem.dpkeybinds: ~1 rows (approximately)
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:110000136ba6d5a', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table fivem.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.fine_types: ~52 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(1, 'การใช้แตรในทางที่ผิด', 30, 0),
	(2, 'การข้ามเส้นต่อเนื่องอย่างผิดกฎหมาย', 40, 0),
	(3, 'การขับขี่บนถนนผิดด้าน', 250, 0),
	(4, 'ผิดกฎหมายกลับรถ', 250, 0),
	(5, 'ขับรถออฟโรดอย่างผิดกฎหมาย', 170, 0),
	(6, 'ปฏิเสธคำสั่งที่ชอบด้วยกฎหมาย', 30, 0),
	(7, 'การหยุดยานพาหนะโดยมิชอบด้วยกฎหมาย', 150, 0),
	(8, 'ที่จอดรถผิดกฎหมาย', 70, 0),
	(9, 'ล้มเหลวในการให้ผลผลิตทางด้านขวา', 70, 0),
	(10, 'ความล้มเหลวในการปฏิบัติตามข้อมูลยานพาหนะ', 90, 0),
	(11, 'ไม่สามารถหยุดที่ป้ายหยุด', 105, 0),
	(12, 'ไม่สามารถหยุดได้ที่ไฟแดง', 130, 0),
	(13, 'การผ่านที่ผิดกฎหมาย', 100, 0),
	(14, 'ขับรถผิดกฎหมาย', 100, 0),
	(15, 'ขับรถโดยไม่มีใบอนุญาต', 1500, 0),
	(16, 'ชนแล้วหนี', 800, 0),
	(17, 'เกินความเร็วเกิน <5 mph', 90, 0),
	(18, 'ความเร็วที่เกินเกินกว่า 5-15 ไมล์ต่อชั่วโมง', 120, 0),
	(19, 'ความเร็วที่มากกว่า 15-30 ไมล์ต่อชั่วโมง', 180, 0),
	(20, 'เกินความเร็วมากกว่า> 30 ไมล์ต่อชั่วโมง', 300, 0),
	(21, 'ขัดขวางการไหลของการจราจร', 110, 1),
	(22, 'ความมัวเมาสาธารณะ', 90, 1),
	(23, 'ความประพฤติไม่เป็นระเบียบ', 90, 1),
	(24, 'การขัดขวางกระบวนการยุติธรรม', 130, 1),
	(25, 'ด่าต่อพลเรือน', 75, 1),
	(26, 'ไม่เคารพเจ้าพนักงาน', 110, 1),
	(27, 'การคุกคามทางวาจาต่อพลเรือน', 90, 1),
	(28, 'ภัยคุกคามทางวาจาต่อเจ้าพนักงาน', 150, 1),
	(29, 'การให้ข้อมูลเท็จ', 250, 1),
	(30, 'ความพยายามในการทุจริต', 1500, 1),
	(31, 'ควงอาวุธในเขตเมือง', 120, 2),
	(32, 'ควงอาวุธร้ายในเมืองขีด จำกัด', 300, 2),
	(33, 'ไม่มีอาวุธปืน', 600, 2),
	(34, 'การครอบครองอาวุธที่ผิดกฎหมาย', 700, 2),
	(35, 'การครอบครองเครื่องมือย่องเบา', 300, 2),
	(36, 'โจรกรรมรถ', 1800, 2),
	(37, 'ตั้งใจที่จะขายสารที่ผิดกฎหมาย', 1500, 2),
	(38, 'การสร้างสารที่ผิดกฎหมาย', 1500, 2),
	(39, 'การครอบครองสารที่ผิดกฎหมาย', 650, 2),
	(40, 'การลักพาตัวของพลเรือน', 1500, 2),
	(41, 'ลักพาตัวเจ้าพนักงาน', 2000, 2),
	(42, 'โจรกรรม', 650, 2),
	(43, 'การปล้นอาวุธของร้านค้า', 650, 2),
	(44, 'การปล้นอาวุธของธนาคาร', 1500, 2),
	(45, 'โจมตีพลเรือน', 2000, 3),
	(46, 'ทำร้ายเจ้าพนักงาน', 2500, 3),
	(47, 'ความพยายามในการสังหารพลเรือน', 3000, 3),
	(48, 'พยายามฆ่าเจ้าพนักงาน', 5000, 3),
	(49, 'การสังหารพลเรือน', 10000, 3),
	(50, 'คดีฆาตกรรมลีโอ', 30000, 3),
	(51, 'การฆาตกรรมโดยไม่สมัครใจ', 1800, 3),
	(52, 'การหลอกลวง', 2000, 2);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table fivem.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `can_remove` (`can_remove`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.items: ~106 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ammo_pistol', 'Ammo Pistol x24', 10, 0, 1),
	('ammo_pistol50', 'Ammo Pistol .50 x18', 10, 0, 1),
	('anesthetic1', 'ยาสลบ', 5, 0, 1),
	('anesthetic2', 'น้ำเกลือ', 5, 0, 1),
	('armor', 'เกราะกันกระสุน', 1, 0, 1),
	('bandage', 'ผ้าพันแผล', 3, 0, 1),
	('beer', 'เบียร์', 10, 0, 1),
	('bikersuit', 'Gucci Belt เข็มขัดหนัง', 8, 0, 1),
	('bottle', 'Empty Bottle', -1, 0, 1),
	('bread', 'ขนมปัง', 20, 0, 1),
	('broken_gun', 'ซากปืนที่แตกหัก ', 3, 0, 1),
	('burger', 'เบอเกอร์เนื้อดับเบิ้ลชีส', 2, 0, 1),
	('cannabis', 'ใบกัญชา', 20, 0, 1),
	('catfish', 'ปลาดุก', 50, 0, 1),
	('catfishfood', 'ยำปลาดุฟู', 20, 0, 1),
	('coffee', 'กาแฟ', 2, 0, 1),
	('coke', 'Coke', 1, 0, 1),
	('coke_pooch', 'โคเคน', 20, 0, 1),
	('cola', 'โคล่า', 10, 0, 1),
	('cook_corn', 'ข้าวโพด', 250, 0, 1),
	('cook_cornflour', 'แป้งข้าวโพด', 50, 0, 1),
	('cook_lettuce', 'ผักกาด', 250, 0, 1),
	('cook_lettuce_process', 'ผักกาดหั่น', 250, 0, 1),
	('cook_ride_plant', 'ต้นข้าว', 1000, 0, 1),
	('cook_ride_plant_process', 'ข้าว', 500, 0, 1),
	('cook_tomato', 'มะเขือเทศ', 250, 0, 1),
	('copper_bar', 'แท่งทองแดง', 50, 0, 1),
	('copper_nugget', 'นักเก็ตทองแดง', 50, 0, 1),
	('croquettes', 'อาหารสัตว์', 20, 0, 1),
	('defibrillator', 'Defibrillator', 2, 0, 1),
	('diamond', 'เพชร', 300, 0, 1),
	('donut1', 'โดนัท', 5, 0, 1),
	('donut2', 'โดนัท ช็อกโกแลต', 5, 0, 1),
	('energy_drink', 'เครื่องดื่มชูกำลัง', 10, 0, 1),
	('firstaid', 'ชุดปฐมพยาบาล', 1, 0, 1),
	('fish2', 'ปลา', 100, 0, 1),
	('fishbait', 'เหยื่อปลา', 30, 0, 1),
	('fishingrod', 'เบ็ดตกปลา', 5, 0, 1),
	('fixkit', 'ชุดซ่อมรถ', 5, 0, 1),
	('gauze', 'Gauze', 25, 0, 1),
	('glass', 'ปูไข่ดอง', 30, 0, 1),
	('gold_bar', 'ทองคำแท่ง', 300, 0, 1),
	('gold_nugget', 'ก้อนทองคำ', 300, 0, 1),
	('grass', 'ขี้วัว', 1000, 0, 1),
	('grass_pack', 'กาแฟขี้วัว', 1000, 0, 1),
	('grill', 'ชุดร้านค้า', 1, 0, 1),
	('gun_barrel', 'ลำกล้องปืน', 5, 0, 1),
	('handcuffs', 'กุญแจมือ', 1, 0, 1),
	('handcuffs_key', 'กุญแจ', 1, 0, 1),
	('hatchet_lj', 'มีดกรีดยาง', 1, 0, 1),
	('hookah', 'บ้อง', 1, 0, 1),
	('hotdog', 'ฮอทด็อก', 2, 0, 1),
	('hydrocodone', 'Hydrocodone', 5, 0, 1),
	('juice', 'น้ำผลไม้', 2, 0, 1),
	('jumelles', 'กล้องส่องทางไกล', 1, 0, 1),
	('lEbait', 'เหยื่อระดับเทพ', -1, 0, 1),
	('lUbait', 'เหยื่อปานหลาง', -1, 0, 1),
	('lbait', 'เหยื่อหนอนตกปลา', -1, 0, 1),
	('leather', 'หนังวัว', 40, 0, 1),
	('leather_gun', 'ด้ามปืนหนังวัว', 5, 0, 1),
	('lfish', 'ปลา', -1, 0, 1),
	('license_doctor', 'License Doctor', 1, 0, 1),
	('lrod', 'เบ็ดตกปลา', -1, 0, 1),
	('marijuana', 'กัญชาขวด', 20, 0, 1),
	('meat', 'เนื้อวากิว A5', 80, 0, 1),
	('meatfood', 'สเต็กเซอร์ลอยน์ A5', 20, 0, 1),
	('medikit', 'Medikit', 2, 0, 1),
	('metal_scrap', 'Metal Scrap', 300, 0, 1),
	('milk', 'นมวัว', -1, 0, 1),
	('mining_lease', 'ใบอนุญาติขุดเหมือง', 1, 0, 1),
	('morphine', 'Morphine', 5, 0, 1),
	('news_bmic', 'ไมค์บูม', 1, 0, 1),
	('news_cam', 'กล้องนักข่าว', 1, 0, 1),
	('news_mic', 'ไมค์นักข่าว', 1, 0, 1),
	('paper_bag', 'ถุงกระดาษ', 5, 0, 1),
	('pie', 'พายเนื้อ', 2, 0, 1),
	('plasticbag', 'ถุงพลาสติก', -1, 0, 1),
	('plongee1', 'Diving Suit', -1, 0, 1),
	('pro_wood', 'ยางรถยนต์', 10, 0, 1),
	('radio', 'วิทยุ', 1, 0, 1),
	('rag', 'ผ้า', 1, 0, 1),
	('raw_ore', 'แร่ดิบ', 300, 0, 1),
	('rough_diamond', 'Rough Diamond', 1, 0, 1),
	('sand', 'ปูม้า', 60, 0, 1),
	('sanwich', 'แซนวิสปลา', 2, 0, 1),
	('shark', 'Shark', 10, 0, 1),
	('shell', 'เปลือกหอย', -1, 0, 1),
	('shovel', 'พลั่วขุดทราย', 1, 0, 1),
	('skateboard', 'Skateboard', 1, 0, 1),
	('snakefishfood', 'ปลาช่อนเผา', 10, 0, 1),
	('snakeheadfish', 'ปลาช่อน', 20, 0, 1),
	('spring', 'สปริง', 5, 0, 1),
	('steel_bar', 'Steel Bar', 20, 0, 1),
	('stone', 'หิน', -1, 0, 1),
	('taco', 'ทาโก้', 2, 0, 1),
	('turtle', 'เต่าทะเล', 20, 0, 1),
	('turtlebait', 'เหยื่อเต่า', 10, 0, 1),
	('vicodin', 'Vicodin', 5, 0, 1),
	('wash', 'น้ำยาล้างรถ', 20, 0, 1),
	('water', 'น้ำเปล่า', 20, 0, 1),
	('weed', 'กัญชายำ', 20, 0, 1),
	('wetshit', 'ขยะเปียก ไร้ค่า', -1, 0, 1),
	('wood', 'ยางไม้', 50, 0, 1),
	('wood_rag', 'เปลือกไม้', -1, 0, 1),
	('wool', 'ขนสัตว์', 40, 0, 1),
	('zap_oil', 'น้ำมันสน', 5, 0, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table fivem.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.jobs: ~19 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('ambulance', 'หมอ', 1),
	('banker', 'Banker', 1),
	('cardealer', 'Cardealer', 1),
	('fueler', 'ขนน้ำมัน', 1),
	('garbage', 'คนเก็บขยะ', 0),
	('hunting', 'นายพราน', 1),
	('journalist', 'นักข่าว', 0),
	('lumberjack', 'ตัดไม้', 1),
	('mechanic', 'นายช่าง', 1),
	('offambulance', 'Off-Duty', 1),
	('offpolice', 'Off-Duty', 1),
	('plowman', 'ทำกาแฟ', 0),
	('police', 'Police', 1),
	('realestateagent', 'Agent immobilier', 1),
	('reporter', 'Reporter', 1),
	('slaughterer', 'ฆ่าไก่', 1),
	('tailor', 'ตัดผ้า', 1),
	('taxi', 'Taxi', 1),
	('unemployed', 'ว่างงาน', 0);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table fivem.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_bin NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.job_grades: ~51 rows (approximately)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 0, '{}', '{}'),
	(2, 'ambulance', 0, 'ambulance', 'Ambulancier', 3000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(3, 'ambulance', 1, 'doctor', 'Medecin', 3000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(4, 'ambulance', 2, 'chief_doctor', 'Medecin-chef', 3000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(5, 'ambulance', 3, 'boss', 'Chirurgien', 3000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(6, 'banker', 0, 'advisor', 'Advisor', 10, '{}', '{}'),
	(7, 'banker', 1, 'banker', 'Banker', 20, '{}', '{}'),
	(8, 'banker', 2, 'business_banker', 'Business Banker', 30, '{}', '{}'),
	(9, 'banker', 3, 'trader', 'Trader', 40, '{}', '{}'),
	(10, 'banker', 4, 'boss', 'Boss', 0, '{}', '{}'),
	(11, 'lumberjack', 0, 'employee', 'Employee', 0, '{}', '{}'),
	(13, 'fueler', 0, 'employee', 'Employee', 0, '{}', '{}'),
	(14, 'reporter', 0, 'employee', 'Employee', 0, '{}', '{}'),
	(15, 'tailor', 0, 'employee', 'Employee', 0, '{"mask_1":0,"arms":1,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":24,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":36,"tshirt_2":0,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":48,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":5,"glasses_1":5,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":52,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":1,"lipstick_2":0,"chain_1":0,"tshirt_1":23,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":42,"tshirt_2":4,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":36,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(17, 'slaughterer', 0, 'employee', 'Employee', 0, '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":67,"pants_1":36,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":0,"torso_1":56,"beard_2":6,"shoes_1":12,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":15,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":0,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":72,"pants_1":45,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":1,"torso_1":49,"beard_2":6,"shoes_1":24,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":9,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":5,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}'),
	(18, 'police', 0, 'recruit', 'Recruit', 3000, '{}', '{}'),
	(19, 'police', 1, 'officer', 'Officer', 3000, '{}', '{}'),
	(20, 'police', 2, 'sergeant', 'Sergeant', 3000, '{}', '{}'),
	(21, 'police', 3, 'lieutenant', 'Lieutenant', 3000, '{}', '{}'),
	(22, 'police', 4, 'boss', 'Chief', 3000, '{}', '{}'),
	(23, 'realestateagent', 0, 'location', 'Location', 10, '{}', '{}'),
	(24, 'realestateagent', 1, 'vendeur', 'Vendeur', 25, '{}', '{}'),
	(25, 'realestateagent', 2, 'gestion', 'Gestion', 40, '{}', '{}'),
	(26, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}'),
	(27, 'taxi', 0, 'recrue', 'Recrue', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(28, 'taxi', 1, 'novice', 'Novice', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(29, 'taxi', 2, 'experimente', 'Experimente', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(30, 'taxi', 3, 'uber', 'Uber', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(31, 'taxi', 4, 'boss', 'Patron', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(32, 'cardealer', 0, 'recruit', 'Recruit', 10, '{}', '{}'),
	(33, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
	(34, 'cardealer', 2, 'experienced', 'Experienced', 40, '{}', '{}'),
	(35, 'cardealer', 3, 'boss', 'Boss', 0, '{}', '{}'),
	(36, 'mechanic', 0, 'recrue', 'Recruit', 500, '{"mask_1":0,"arms":15,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":28,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":238,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":53,"tshirt_2":0,"beard_3":0,"hair_1":68,"hair_color_1":0,"pants_1":83,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":15,"glasses_1":1,"hair_color_2":4,"makeup_1":0,"face":31,"glasses":0,"mask_2":0,"makeup_3":0,"skin":0,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":105,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":15,"eyebrows_3":0,"pants_2":1,"beard_4":0,"torso_2":0,"beard_2":0,"ears_2":0,"hair_2":0,"shoes_1":8,"tshirt_2":0,"beard_3":0,"hair_1":17,"hair_color_1":0,"pants_1":62,"helmet_1":0,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":0,"shoes":8,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(37, 'mechanic', 1, 'novice', 'Novice', 500, '{"mask_1":0,"arms":15,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":28,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":238,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":53,"tshirt_2":0,"beard_3":0,"hair_1":68,"hair_color_1":0,"pants_1":83,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":15,"glasses_1":1,"hair_color_2":4,"makeup_1":0,"face":31,"glasses":0,"mask_2":0,"makeup_3":0,"skin":0,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":105,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":15,"eyebrows_3":0,"pants_2":1,"beard_4":0,"torso_2":0,"beard_2":0,"ears_2":0,"hair_2":0,"shoes_1":8,"tshirt_2":0,"beard_3":0,"hair_1":17,"hair_color_1":0,"pants_1":62,"helmet_1":0,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":0,"shoes":8,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(38, 'mechanic', 2, 'experimente', 'Experienced', 500, '{"mask_1":0,"arms":15,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":28,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":238,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":53,"tshirt_2":0,"beard_3":0,"hair_1":68,"hair_color_1":0,"pants_1":83,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":15,"glasses_1":1,"hair_color_2":4,"makeup_1":0,"face":31,"glasses":0,"mask_2":0,"makeup_3":0,"skin":0,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":105,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":15,"eyebrows_3":0,"pants_2":1,"beard_4":0,"torso_2":0,"beard_2":0,"ears_2":0,"hair_2":0,"shoes_1":8,"tshirt_2":0,"beard_3":0,"hair_1":17,"hair_color_1":0,"pants_1":62,"helmet_1":0,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":0,"shoes":8,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(39, 'mechanic', 3, 'chief', 'Leader', 500, '{"mask_1":0,"arms":15,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":28,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":238,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":53,"tshirt_2":0,"beard_3":0,"hair_1":68,"hair_color_1":0,"pants_1":83,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":15,"glasses_1":1,"hair_color_2":4,"makeup_1":0,"face":31,"glasses":0,"mask_2":0,"makeup_3":0,"skin":0,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":105,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":15,"eyebrows_3":0,"pants_2":1,"beard_4":0,"torso_2":0,"beard_2":0,"ears_2":0,"hair_2":0,"shoes_1":8,"tshirt_2":0,"beard_3":0,"hair_1":17,"hair_color_1":0,"pants_1":62,"helmet_1":0,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":0,"shoes":8,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(40, 'mechanic', 4, 'boss', 'Boss', 500, '{"mask_1":0,"arms":15,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":28,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":238,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":53,"tshirt_2":0,"beard_3":0,"hair_1":68,"hair_color_1":0,"pants_1":83,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":15,"glasses_1":1,"hair_color_2":4,"makeup_1":0,"face":31,"glasses":0,"mask_2":0,"makeup_3":0,"skin":0,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":105,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":15,"eyebrows_3":0,"pants_2":1,"beard_4":0,"torso_2":0,"beard_2":0,"ears_2":0,"hair_2":0,"shoes_1":8,"tshirt_2":0,"beard_3":0,"hair_1":17,"hair_color_1":0,"pants_1":62,"helmet_1":0,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":0,"shoes":8,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(41, 'hunting', 0, 'employee', 'Employee', 0, '{}', '{}'),
	(42, 'plowman', 0, 'employee', 'ไถนา', 0, '{}', '{}'),
	(43, 'offpolice', 0, 'recruit', 'Recruit', 12, '{}', '{}'),
	(44, 'offpolice', 1, 'officer', 'Officer', 24, '{}', '{}'),
	(45, 'offpolice', 2, 'sergeant', 'Sergeant', 36, '{}', '{}'),
	(46, 'offpolice', 3, 'lieutenant', 'Lieutenant', 48, '{}', '{}'),
	(47, 'offpolice', 4, 'boss', 'Boss', 0, '{}', '{}'),
	(48, 'offambulance', 0, 'ambulance', 'Ambulance', 12, '{}', '{}'),
	(49, 'offambulance', 1, 'doctor', 'Doctor', 24, '{}', '{}'),
	(50, 'offambulance', 2, 'chief_doctor', 'Chef', 36, '{}', '{}'),
	(51, 'offambulance', 3, 'boss', 'Boss', 48, '{}', '{}'),
	(52, 'garbage', 0, 'employee', 'Employee', 0, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"glasses_1":19,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"glasses_2":0,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"glasses_1":19,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"glasses_1":15,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"glasses_2":0,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"glasses_1":15,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}'),
	(53, 'journalist', 0, 'journalist', 'Journalist', 0, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dumping structure for table fivem.licenses
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.licenses: ~7 rows (approximately)
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('boat', 'ใบอนุญาติขับขี่เรือ'),
	('dmv', 'กฎหมายจราจร'),
	('drive', 'ใบอนุญาติขับขี่รถยนต์'),
	('drive_bike', 'ใบอนุญาติขับขี่รถจักรยานยนต์'),
	('drive_truck', 'ใบอนุญาติขับขี่รถบรรทุก'),
	('weapon', 'ใบอนุญาติพกอาวุธ'),
	('weed_processing', 'ใบอนุญาติผลิตกัญชา');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dumping structure for table fivem.meeta_accessory_inventory
CREATE TABLE IF NOT EXISTS `meeta_accessory_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.meeta_accessory_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `meeta_accessory_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeta_accessory_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.meeta_economy
CREATE TABLE IF NOT EXISTS `meeta_economy` (
  `label` varchar(255) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `price` int(11) DEFAULT NULL,
  `price2` int(11) DEFAULT NULL,
  `difference` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.meeta_economy: ~7 rows (approximately)
/*!40000 ALTER TABLE `meeta_economy` DISABLE KEYS */;
INSERT INTO `meeta_economy` (`label`, `item`, `count`, `price`, `price2`, `difference`) VALUES
	('Gucci Belt เข็มขัดหนัง', 'bikersuit', 0, 218, 218, 245),
	('แท่งทองแดง', 'copper_bar', 0, 141, 141, 139),
	('เพชร', 'diamond', 0, 2428, 4825, 2400),
	('ปูไข่ดอง', 'glass', 0, 127, 127, 138),
	('แท่งทองคำ', 'gold_bar', 0, 809, 809, 838),
	('กาแฟขี้วัว', 'grass_pack', 0, 2, 2, 4),
	('ยางรถยนต์', 'pro_wood', 0, 207, 207, 215);
/*!40000 ALTER TABLE `meeta_economy` ENABLE KEYS */;

-- Dumping structure for table fivem.meeta_market
CREATE TABLE IF NOT EXISTS `meeta_market` (
  `item` varchar(50) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`item`) USING BTREE,
  KEY `item` (`item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.meeta_market: ~6 rows (approximately)
/*!40000 ALTER TABLE `meeta_market` DISABLE KEYS */;
INSERT INTO `meeta_market` (`item`, `label`, `count`, `price`) VALUES
	('cook_corn', 'ข้าวโพด', 0, 3),
	('cook_cornflour', 'แป้งข้าวโพด', 0, 3),
	('cook_lettuce', 'ผักกาด', 0, 3),
	('cook_ride_plant', 'ต้นข้าว', 0, 3),
	('cook_ride_plant_process', 'ข้าว', 0, 3),
	('cook_tomato', 'เมือเขือเทศ', 0, 3);
/*!40000 ALTER TABLE `meeta_market` ENABLE KEYS */;

-- Dumping structure for table fivem.meeta_vehicle_trunk
CREATE TABLE IF NOT EXISTS `meeta_vehicle_trunk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  `label_weapon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plate` (`plate`) USING BTREE,
  KEY `isweapon` (`isweapon`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4423 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.meeta_vehicle_trunk: ~0 rows (approximately)
/*!40000 ALTER TABLE `meeta_vehicle_trunk` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeta_vehicle_trunk` ENABLE KEYS */;

-- Dumping structure for table fivem.owned_properties
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `properties` int(11) NOT NULL DEFAULT 0,
  `islock` int(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.owned_properties: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_properties` ENABLE KEYS */;

-- Dumping structure for table fivem.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) COLLATE utf8mb4_bin NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Etat de la voiture',
  `plate` varchar(12) COLLATE utf8mb4_bin NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 1,
  `model` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `car` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `fourrieremecano` tinyint(1) DEFAULT NULL,
  `vehiclename` varchar(50) COLLATE utf8mb4_bin DEFAULT 'voiture',
  `buyer` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `properties` int(255) NOT NULL DEFAULT 0,
  `police` int(11) NOT NULL DEFAULT 0,
  `police_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp(),
  `health_engine` int(11) NOT NULL DEFAULT 1000,
  `health_body` int(11) NOT NULL DEFAULT 1000,
  `health_tank` int(11) NOT NULL DEFAULT 1000,
  PRIMARY KEY (`plate`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `stored` (`stored`) USING BTREE,
  KEY `properties` (`properties`) USING BTREE,
  KEY `police` (`police`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.owned_vehicles: ~1 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
INSERT INTO `owned_vehicles` (`owner`, `state`, `plate`, `vehicle`, `type`, `job`, `stored`, `model`, `car`, `fourrieremecano`, `vehiclename`, `buyer`, `properties`, `police`, `police_by`, `time`, `health_engine`, `health_body`, `health_tank`) VALUES
	('steam:110000136ba6d5a', 0, 'IMD 202', '{"dirtLevel":12.911657333374,"modRoof":-1,"modAPlate":-1,"modDial":-1,"modHood":-1,"modXenon":false,"modBackWheels":-1,"modAerials":-1,"modOrnaments":-1,"modDashboard":-1,"modExhaust":-1,"modDoorSpeaker":-1,"modSuspension":-1,"windowTint":-1,"modVanityPlate":-1,"modTank":-1,"modEngine":-1,"modEngineBlock":-1,"modSeats":-1,"wheels":5,"modTrimA":-1,"neonColor":[255,0,255],"modSideSkirt":-1,"model":1549126457,"modArmor":-1,"health":938,"plateIndex":0,"modTrunk":-1,"color1":64,"modShifterLeavers":-1,"modStruts":-1,"modSpeakers":-1,"tyreSmokeColor":[255,255,255],"modBrakes":-1,"modFender":-1,"modSmokeEnabled":1,"modTurbo":false,"modAirFilter":-1,"modLivery":-1,"modHorns":-1,"modFrontWheels":-1,"modHydrolic":-1,"modFrontBumper":-1,"modTransmission":-1,"modFrame":-1,"modWindows":-1,"modRearBumper":-1,"pearlescentColor":70,"modPlateHolder":-1,"plate":"IMD 202","color2":2,"wheelColor":112,"modGrille":-1,"modRightFender":-1,"modSteeringWheel":-1,"extras":[],"modArchCover":-1,"modSpoilers":-1,"modTrimB":-1,"neonEnabled":[false,false,false,false]}', 'car', NULL, 1, '', NULL, NULL, 'voiture', NULL, 0, 0, NULL, '2021-05-30 13:33:37', 1000, 1000, 1000);
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dumping structure for table fivem.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `channel` (`channel`) USING BTREE,
  KEY `message` (`message`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14142 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.phone_app_chat: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Dumping structure for table fivem.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `num` (`num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17629 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.phone_calls: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dumping structure for table fivem.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transmitter` (`transmitter`) USING BTREE,
  KEY `receiver` (`receiver`) USING BTREE,
  KEY `message` (`message`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=92805 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table fivem.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE,
  KEY `number` (`number`) USING BTREE,
  KEY `display` (`display`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15040 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Dumping structure for table fivem.properties_inventory
CREATE TABLE IF NOT EXISTS `properties_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propertie_id` int(11) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  `label_weapon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `propertie_id` (`propertie_id`) USING BTREE,
  KEY `item` (`item`) USING BTREE,
  KEY `count` (`count`) USING BTREE,
  KEY `is_weapon` (`isweapon`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3976 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.properties_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `properties_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `properties_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.rented_vehicles
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_bin NOT NULL,
  `player_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.rented_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `rented_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `rented_vehicles` ENABLE KEYS */;

-- Dumping structure for table fivem.shops_new
CREATE TABLE IF NOT EXISTS `shops_new` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.shops_new: ~39 rows (approximately)
/*!40000 ALTER TABLE `shops_new` DISABLE KEYS */;
INSERT INTO `shops_new` (`id`, `item`, `price`, `category`) VALUES
	(1, 'bread', 200, 'Normal'),
	(2, 'water', 15, 'Normal'),
	(21, 'mining_lease', 1000, 'Mining'),
	(23, 'hookah', 1000, 'Weed'),
	(24, 'croquettes', 100, 'Normal'),
	(25, 'jumelles', 1500, 'Normal'),
	(26, 'fishingrod', 250, 'Fish'),
	(27, 'fishbait', 5, 'Fish'),
	(28, 'turtlebait', 50, 'Fish'),
	(29, 'plongee1', 100, 'Police'),
	(30, 'hatchet_lj', 1000, 'Normal'),
	(31, 'shovel', 1000, 'Normal'),
	(32, 'fixkit', 400, 'Car'),
	(33, 'beer', 100, 'Normal'),
	(34, 'rag', 1000, 'Car'),
	(35, 'wash', 200, 'Car'),
	(36, 'energy_drink', 200, 'Normal'),
	(37, 'handcuffs', 40000, 'Hand'),
	(38, 'handcuffs_key', 5000, 'Hand'),
	(40, 'paper_bag', 4000, 'Hand'),
	(41, 'radio', 20000, 'Normal'),
	(42, 'beer', 100, 'Weed1'),
	(43, 'hookah', 1000, 'Weed1'),
	(44, 'license_doctor', 10000, 'Ambulance'),
	(45, 'medikit', 0, 'Ambulance'),
	(46, 'bandage', 0, 'Ambulance'),
	(47, 'defibrillator', 15000, 'Ambulance'),
	(48, 'news_cam', 1000, 'Journalist'),
	(49, 'news_mic', 1000, 'Journalist'),
	(50, 'news_bmic', 1000, 'Journalist'),
	(51, 'cola', 20, 'Normal'),
	(56, 'anesthetic1', 0, 'Ambulance'),
	(57, 'anesthetic2', 0, 'Ambulance'),
	(58, 'firstaid', 0, 'Ambulance'),
	(59, 'donut1', 20, 'Prison'),
	(60, 'donut2', 20, 'Prison'),
	(61, 'water', 20, 'Prison'),
	(62, 'juice', 100, 'Normal'),
	(63, 'coffee', 50, 'Normal');
/*!40000 ALTER TABLE `shops_new` ENABLE KEYS */;

-- Dumping structure for table fivem.spam
CREATE TABLE IF NOT EXISTS `spam` (
  `identifier` varchar(255) DEFAULT NULL,
  `IsBan` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table fivem.spam: ~0 rows (approximately)
/*!40000 ALTER TABLE `spam` DISABLE KEYS */;
/*!40000 ALTER TABLE `spam` ENABLE KEYS */;

-- Dumping structure for table fivem.truck_inventory
CREATE TABLE IF NOT EXISTS `truck_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `owned` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `item` (`item`,`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.truck_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `truck_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `truck_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.trunk_inventory
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `plate` (`plate`) USING BTREE,
  FULLTEXT KEY `data` (`data`)
) ENGINE=InnoDB AUTO_INCREMENT=8297 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.trunk_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.twitter_accounts
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1430 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.twitter_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
INSERT INTO `twitter_accounts` (`id`, `username`, `password`, `avatar_url`) VALUES
	(1429, 'asky', '123456', NULL);
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Dumping structure for table fivem.twitter_likes
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`) USING BTREE,
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`) USING BTREE,
  CONSTRAINT `twitter_likes_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `twitter_likes_ibfk_2` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1718 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.twitter_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Dumping structure for table fivem.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`) USING BTREE,
  KEY `realUser` (`realUser`) USING BTREE,
  CONSTRAINT `twitter_tweets_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.twitter_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
INSERT INTO `twitter_tweets` (`id`, `authorId`, `realUser`, `message`, `time`, `likes`) VALUES
	(1139, 1429, 'steam:110000136ba6d5a', 'asd', '2021-05-30 13:05:56', 0);
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Dumping structure for table fivem.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `last_property` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `pet` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `index_users_phone_number` (`phone_number`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE,
  KEY `license` (`license`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `money` (`money`) USING BTREE,
  KEY `bank` (`bank`) USING BTREE,
  KEY `permission_level` (`permission_level`) USING BTREE,
  KEY `group` (`group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1813 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `identifier`, `license`, `money`, `name`, `skin`, `job`, `job_grade`, `loadout`, `position`, `bank`, `permission_level`, `group`, `is_dead`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `phone_number`, `last_property`, `status`, `jail`, `tattoos`, `pet`) VALUES
	(1812, 'steam:110000136ba6d5a', 'license:2d894be3a50d0bd62a71dcedb025c08f6cdb7adb', 913750, 'ASKY', '{"blemishes_2":0,"eyebrows_3":0,"hair_1":2,"age_1":0,"chest_3":0,"chain_1":0,"lipstick_4":0,"eyebrows_1":0,"blemishes_1":0,"shoes_2":0,"bags_2":0,"pants_2":0,"watches_2":0,"arms":0,"glasses_1":0,"helmet_2":0,"eye_color":0,"tshirt_2":0,"watches_1":-1,"torso_2":0,"chest_1":0,"makeup_4":0,"blush_2":0,"bproof_1":0,"decals_2":0,"chain_2":0,"bags_1":0,"sun_2":0,"beard_2":0,"bracelets_2":0,"torso_1":0,"hair_color_1":6,"makeup_3":0,"blush_3":0,"face":0,"shoes_1":26,"ears_2":0,"beard_3":0,"beard_4":0,"arms_2":0,"lipstick_2":0,"moles_1":0,"glasses_2":0,"sun_1":0,"sex":0,"eyebrows_4":0,"makeup_1":0,"bodyb_1":0,"mask_1":0,"lipstick_1":0,"hair_color_2":0,"helmet_1":-1,"mask_2":0,"skin":0,"decals_1":0,"complexion_2":0,"pants_1":24,"blush_1":0,"moles_2":0,"bproof_2":0,"eyebrows_2":0,"lipstick_3":0,"bracelets_1":-1,"complexion_1":0,"makeup_2":0,"ears_1":-1,"beard_1":0,"chest_2":0,"hair_2":0,"bodyb_2":0,"age_2":0,"tshirt_1":0}', 'plowman', 0, '[]', '{"x":2067.0,"z":41.2,"y":4916.4}', 0, 0, 'superadmin', 0, 'ASKY', 'DEV', '12-12-1998', 'm', '185', '840-7465', NULL, '[{"val":430400,"percent":43.04,"name":"hunger"},{"val":572800,"percent":57.28,"name":"thirst"}]', 0, NULL, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table fivem.user_accounts
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `money` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `money` (`money`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1690 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
INSERT INTO `user_accounts` (`id`, `identifier`, `name`, `money`) VALUES
	(1689, 'steam:110000136ba6d5a', 'black_money', 0);
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;

-- Dumping structure for table fivem.user_contacts
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_user_contacts_identifier_name_number` (`identifier`,`name`,`number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contacts` ENABLE KEYS */;

-- Dumping structure for table fivem.user_inventory
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `item` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE,
  KEY `item` (`item`) USING BTREE,
  KEY `count` (`count`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_inventory: ~106 rows (approximately)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` (`id`, `identifier`, `item`, `count`) VALUES
	(42057, 'steam:110000136ba6d5a', 'hatchet_lj', 0),
	(42058, 'steam:110000136ba6d5a', 'cook_lettuce', 16),
	(42059, 'steam:110000136ba6d5a', 'raw_ore', 7),
	(42060, 'steam:110000136ba6d5a', 'bandage', 0),
	(42061, 'steam:110000136ba6d5a', 'coke_pooch', 0),
	(42062, 'steam:110000136ba6d5a', 'turtlebait', 0),
	(42063, 'steam:110000136ba6d5a', 'fishingrod', 0),
	(42064, 'steam:110000136ba6d5a', 'steel_bar', 0),
	(42065, 'steam:110000136ba6d5a', 'milk', 12),
	(42066, 'steam:110000136ba6d5a', 'copper_bar', 0),
	(42067, 'steam:110000136ba6d5a', 'news_bmic', 0),
	(42068, 'steam:110000136ba6d5a', 'lEbait', 0),
	(42069, 'steam:110000136ba6d5a', 'beer', 0),
	(42070, 'steam:110000136ba6d5a', 'gun_barrel', 0),
	(42071, 'steam:110000136ba6d5a', 'radio', 0),
	(42072, 'steam:110000136ba6d5a', 'paper_bag', 0),
	(42073, 'steam:110000136ba6d5a', 'burger', 0),
	(42074, 'steam:110000136ba6d5a', 'leather', 14),
	(42075, 'steam:110000136ba6d5a', 'handcuffs', 0),
	(42076, 'steam:110000136ba6d5a', 'cook_cornflour', 0),
	(42077, 'steam:110000136ba6d5a', 'license_doctor', 0),
	(42078, 'steam:110000136ba6d5a', 'cannabis', 0),
	(42079, 'steam:110000136ba6d5a', 'glass', 0),
	(42080, 'steam:110000136ba6d5a', 'metal_scrap', 1),
	(42081, 'steam:110000136ba6d5a', 'leather_gun', 1),
	(42082, 'steam:110000136ba6d5a', 'donut1', 0),
	(42083, 'steam:110000136ba6d5a', 'ammo_pistol50', 0),
	(42084, 'steam:110000136ba6d5a', 'cook_lettuce_process', 0),
	(42085, 'steam:110000136ba6d5a', 'hotdog', 0),
	(42086, 'steam:110000136ba6d5a', 'diamond', 0),
	(42087, 'steam:110000136ba6d5a', 'cook_corn', 0),
	(42088, 'steam:110000136ba6d5a', 'water', 100),
	(42089, 'steam:110000136ba6d5a', 'croquettes', 0),
	(42090, 'steam:110000136ba6d5a', 'bottle', 0),
	(42091, 'steam:110000136ba6d5a', 'hydrocodone', 0),
	(42092, 'steam:110000136ba6d5a', 'cook_ride_plant', 0),
	(42093, 'steam:110000136ba6d5a', 'coke', 0),
	(42094, 'steam:110000136ba6d5a', 'zap_oil', 0),
	(42095, 'steam:110000136ba6d5a', 'plasticbag', 0),
	(42096, 'steam:110000136ba6d5a', 'wool', 0),
	(42097, 'steam:110000136ba6d5a', 'wood_rag', 0),
	(42098, 'steam:110000136ba6d5a', 'sanwich', 0),
	(42099, 'steam:110000136ba6d5a', 'coffee', 0),
	(42100, 'steam:110000136ba6d5a', 'grass', 0),
	(42101, 'steam:110000136ba6d5a', 'wood', 0),
	(42102, 'steam:110000136ba6d5a', 'weed', 0),
	(42103, 'steam:110000136ba6d5a', 'news_mic', 0),
	(42104, 'steam:110000136ba6d5a', 'fish2', 0),
	(42105, 'steam:110000136ba6d5a', 'wash', 0),
	(42106, 'steam:110000136ba6d5a', 'gold_bar', 0),
	(42107, 'steam:110000136ba6d5a', 'vicodin', 0),
	(42108, 'steam:110000136ba6d5a', 'cola', 0),
	(42109, 'steam:110000136ba6d5a', 'sand', 0),
	(42110, 'steam:110000136ba6d5a', 'rough_diamond', 0),
	(42111, 'steam:110000136ba6d5a', 'taco', 0),
	(42112, 'steam:110000136ba6d5a', 'gauze', 0),
	(42113, 'steam:110000136ba6d5a', 'stone', 120),
	(42114, 'steam:110000136ba6d5a', 'spring', 0),
	(42115, 'steam:110000136ba6d5a', 'catfishfood', 0),
	(42116, 'steam:110000136ba6d5a', 'snakeheadfish', 0),
	(42117, 'steam:110000136ba6d5a', 'ammo_pistol', 0),
	(42118, 'steam:110000136ba6d5a', 'lfish', 0),
	(42119, 'steam:110000136ba6d5a', 'jumelles', 0),
	(42120, 'steam:110000136ba6d5a', 'snakefishfood', 0),
	(42121, 'steam:110000136ba6d5a', 'fishbait', 0),
	(42122, 'steam:110000136ba6d5a', 'grass_pack', 0),
	(42123, 'steam:110000136ba6d5a', 'plongee1', 0),
	(42124, 'steam:110000136ba6d5a', 'lbait', 0),
	(42125, 'steam:110000136ba6d5a', 'shovel', 1),
	(42126, 'steam:110000136ba6d5a', 'donut2', 0),
	(42127, 'steam:110000136ba6d5a', 'juice', 0),
	(42128, 'steam:110000136ba6d5a', 'armor', 0),
	(42129, 'steam:110000136ba6d5a', 'shell', 0),
	(42130, 'steam:110000136ba6d5a', 'shark', 0),
	(42131, 'steam:110000136ba6d5a', 'gold_nugget', 0),
	(42132, 'steam:110000136ba6d5a', 'rag', 0),
	(42133, 'steam:110000136ba6d5a', 'pro_wood', 0),
	(42134, 'steam:110000136ba6d5a', 'skateboard', 0),
	(42135, 'steam:110000136ba6d5a', 'pie', 0),
	(42136, 'steam:110000136ba6d5a', 'bread', 100),
	(42137, 'steam:110000136ba6d5a', 'anesthetic2', 0),
	(42138, 'steam:110000136ba6d5a', 'morphine', 0),
	(42139, 'steam:110000136ba6d5a', 'news_cam', 0),
	(42140, 'steam:110000136ba6d5a', 'meat', 5),
	(42141, 'steam:110000136ba6d5a', 'mining_lease', 1),
	(42142, 'steam:110000136ba6d5a', 'broken_gun', 0),
	(42143, 'steam:110000136ba6d5a', 'energy_drink', 0),
	(42144, 'steam:110000136ba6d5a', 'medikit', 99),
	(42145, 'steam:110000136ba6d5a', 'meatfood', 0),
	(42146, 'steam:110000136ba6d5a', 'turtle', 0),
	(42147, 'steam:110000136ba6d5a', 'marijuana', 0),
	(42148, 'steam:110000136ba6d5a', 'lrod', 0),
	(42149, 'steam:110000136ba6d5a', 'lUbait', 0),
	(42150, 'steam:110000136ba6d5a', 'catfish', 0),
	(42151, 'steam:110000136ba6d5a', 'wetshit', 0),
	(42152, 'steam:110000136ba6d5a', 'bikersuit', 0),
	(42153, 'steam:110000136ba6d5a', 'cook_ride_plant_process', 0),
	(42154, 'steam:110000136ba6d5a', 'grill', 0),
	(42155, 'steam:110000136ba6d5a', 'copper_nugget', 0),
	(42156, 'steam:110000136ba6d5a', 'cook_tomato', 20),
	(42157, 'steam:110000136ba6d5a', 'fixkit', 0),
	(42158, 'steam:110000136ba6d5a', 'hookah', 0),
	(42159, 'steam:110000136ba6d5a', 'handcuffs_key', 0),
	(42160, 'steam:110000136ba6d5a', 'defibrillator', 0),
	(42161, 'steam:110000136ba6d5a', 'firstaid', 0),
	(42162, 'steam:110000136ba6d5a', 'anesthetic1', 0);
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Dumping structure for table fivem.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_licenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table fivem.user_parkings
CREATE TABLE IF NOT EXISTS `user_parkings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `garage` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone` int(11) NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_parkings: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_parkings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_parkings` ENABLE KEYS */;

-- Dumping structure for table fivem.user_whitelist
CREATE TABLE IF NOT EXISTS `user_whitelist` (
  `identifier` varchar(70) COLLATE utf8mb4_bin NOT NULL,
  `last_connection` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ban_reason` text COLLATE utf8mb4_bin DEFAULT NULL,
  `ban_until` timestamp NULL DEFAULT NULL,
  `vip` int(11) NOT NULL DEFAULT 0,
  `whitelisted` tinyint(1) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `whitelisted` (`whitelisted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.user_whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_whitelist` ENABLE KEYS */;

-- Dumping structure for table fivem.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.vehicles: ~49 rows (approximately)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
	('\r\nlynx', 'Lynx', 300000, 'super'),
	('panto', 'Panto', 55000, 'compacts'),
	('Asea', 'asea', 70000, 'sedans'),
	('Baller', 'baller2', 90000, 'suvs'),
	('Z4', 'banshee', 270000, 'super'),
	('Bison', 'bison', 100000, 'vans'),
	('Beejay XL', 'bjxl', 200000, 'suvs'),
	('Blista', 'blista', 80000, 'compacts'),
	('BMX (velo)', 'bmx', 5000, 'motorcycles'),
	('Brawler', 'brawler', 200000, 'offroad'),
	('Brio', 'brioso', 85000, 'sportsclassics'),
	('Burrito', 'burrito3', 60000, 'vans'),
	('Carbon Izzare', 'carbonizzare', 320000, 'super'),
	('Casco', 'casco', 230000, 'sportsclassics'),
	('Cog55', 'cog55', 220000, 'compacts'),
	('Cruiser', 'cruiser', 5000, 'motorcycles'),
	('Dominator', 'dominator', 250000, 'muscle'),
	('Dominator GTX', 'dominator3', 300000, 'muscle'),
	('Emperor', 'emperor', 100000, 'sedans'),
	('F620', 'f620', 220000, 'super'),
	('Faggio', 'faggio', 10000, 'motorcycles'),
	('Vespa', 'faggio2', 10000, 'motorcycles'),
	('Fixter', 'fixter', 5000, 'motorcycles'),
	('Fuigitive', 'fuigitive', 150000, 'compacts'),
	('Guardian', 'guardian', 270000, 'super'),
	('Intruder', 'intruder', 75000, 'compacts'),
	('Issi', 'issi2', 60000, 'compacts'),
	('Issi Classic', 'issi3', 55000, 'compacts'),
	('Kamacho', 'kamacho', 90000, 'compacts'),
	('Kuruma', 'kuruma', 180000, 'super'),
	('Michelli GT', 'michelli', 75000, 'sportsclassics'),
	('Mini Van', 'minivan', 80000, 'suvs'),
	('Pigalle', 'pigalle', 100000, 'sportsclassics'),
	('Premier', 'premier', 80000, 'compacts'),
	('Primo', 'primo', 85000, 'sedans'),
	('Rebel', 'rebel2', 80000, 'offroad'),
	('Rhapsody', 'rhapsody', 70000, 'compacts'),
	('Schafter2', 'schafter2', 90000, 'compacts'),
	('Scorcher', 'scorcher', 5000, 'motorcycles'),
	('serrano', 'serrano', 100000, 'suvs'),
	('Stafford', 'stafford', 100000, 'compacts'),
	('Superd ', 'superd', 280000, 'compacts'),
	('Terbyte', 'terbyte', 10000000, 'vans'),
	('Whippet Race Bike', 'tribike', 6000, 'motorcycles'),
	('Endurex Race Bike', 'tribike2', 6000, 'motorcycles'),
	('Tri-Cycles Race Bike', 'tribike3', 6000, 'motorcycles'),
	('Warrener', 'warrener', 60000, 'sedans'),
	('Z190', 'z190', 230000, 'super'),
	('Zion', 'zion2', 200000, 'sportsclassics');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table fivem.vehicles_for_sale
CREATE TABLE IF NOT EXISTS `vehicles_for_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) NOT NULL,
  `vehicleProps` longtext NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.vehicles_for_sale: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles_for_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_for_sale` ENABLE KEYS */;

-- Dumping structure for table fivem.vehicle_categories
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.vehicle_categories: ~11 rows (approximately)
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('compacts', 'Compacts'),
	('coupes', 'Coupes'),
	('motorcycles', 'Motos'),
	('muscle', 'Muscle'),
	('offroad', 'Off Road'),
	('sedans', 'Sedans'),
	('sports', 'Sports'),
	('sportsclassics', 'Sports Classics'),
	('super', 'Super'),
	('suvs', 'SUVs'),
	('vans', 'Vans');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- Dumping structure for table fivem.vehicle_sold
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `client` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `soldby` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `date` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.vehicle_sold: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_sold` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_sold` ENABLE KEYS */;

-- Dumping structure for table fivem.vehicle_soldout
CREATE TABLE IF NOT EXISTS `vehicle_soldout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL,
  `vehicle` longtext NOT NULL,
  `plate` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`,`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.vehicle_soldout: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_soldout` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_soldout` ENABLE KEYS */;

-- Dumping structure for table fivem.weashops
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `item` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- Dumping data for table fivem.weashops: ~0 rows (approximately)
/*!40000 ALTER TABLE `weashops` DISABLE KEYS */;
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(1, 'BlackWeashop', 'WEAPON_PISTOL50', 13000);
/*!40000 ALTER TABLE `weashops` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
