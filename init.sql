/*
Navicat Premium Data Transfer
Source Server : localhost
Source Server Type : MySQL
Source Server Version : 80040 (8.0.40)
Source Host : localhost:3306
Source Schema : db_order
Target Server Type : MySQL
Target Server Version : 80040 (8.0.40)
File Encoding : 65001
Date: 24/06/2026 10:00:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `balance` decimal(8,2) NOT NULL DEFAULT 0.00,
  `status` int NOT NULL DEFAULT 1,
  `role` int NOT NULL DEFAULT 1,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_username` (`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', 5000.00, 1, 0, NOW(), NOW());
INSERT INTO `user` VALUES (2, 'xiao', '123456', 800.00, 1, 1, NOW(), NOW());

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `specs` varchar(20) NOT NULL,
  `status` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES (1, '青椒炒肉', 15.00, '份', 1);
INSERT INTO `food` VALUES (2, '香辣鱼片', 23.00, '份', 1);
INSERT INTO `food` VALUES (3, '红焖羊肉', 58.00, '份', 1);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `food_id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`food_id`, `user_id`) USING BTREE,
  INDEX `idx_cart_food` (`food_id` ASC) USING BTREE,
  INDEX `idx_cart_user` (`user_id` ASC) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_no` varchar(10) NOT NULL,
  `user_id` int NOT NULL,
  `order_person` varchar(50) DEFAULT NULL,
  `order_phone` varchar(50) DEFAULT NULL,
  `order_address` text,
  `sum_price` decimal(8,2) DEFAULT 0.00,
  `status` int DEFAULT 0,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_no`) USING BTREE,
  INDEX `idx_order_user` (`user_id` ASC) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `order_no` varchar(10) NOT NULL,
  `food_id` int NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`order_no`, `food_id`) USING BTREE,
  INDEX `idx_orderdetail_food` (`food_id` ASC) USING BTREE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------

-- ----------------------------
-- Table structure for refund_application
-- ----------------------------
DROP TABLE IF EXISTS `refund_application`;
CREATE TABLE `refund_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(10) NOT NULL,
  `user_id` int NOT NULL,
  `refund_reason` text,
  `refund_response` text,
  `refund_amount` decimal(8,2) NOT NULL,
  `status` int NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_refund_user` (`user_id` ASC) USING BTREE,
  INDEX `idx_refund_order` (`order_no` ASC) USING BTREE,
  CONSTRAINT `refund_application_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `refund_application_ibfk_2` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of refund_application
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;