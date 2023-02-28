-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 26, 2021 at 02:28 AM
-- Server version: 8.0.22
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ifp_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `CustomerAddresses`
--

CREATE TABLE `CustomerAddresses` (
  `id` int NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `streetAddress` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerAddresses`
--

INSERT INTO `CustomerAddresses` (`id`, `fullName`, `streetAddress`, `district`, `province`, `zipCode`, `phoneNumber`, `createdAt`, `updatedAt`, `CustomerId`) VALUES
(1, 'Patcharapong Rattanakhammon', '102/1 m.5 luangnuea', 'Ngao', 'Lampang', '52110', '054329195', '2020-12-15 02:52:03', '2020-12-15 02:52:03', 1),
(2, 'Patcharapong Rattanakhammon', '102/1 m.5 luangnuea', 'Ngao', 'Lampang', '52110', '054329195', '2020-12-16 03:48:55', '2020-12-16 03:48:55', 1),
(3, 'test', 'abcdefghijklmnopqrstuvwxyz', 'เมืองเชียงใหม่', 'เชียงใหม่', '50300', '0123456789', '2021-02-28 20:17:00', '2021-02-28 20:17:00', 3),
(4, 'Patcharapong Rattanakhammon', '102/1 m.5 luangnuea', 'Ngao', 'Lampang', '52110', '054329195', '2021-03-05 04:21:44', '2021-03-05 04:21:44', 1);

-- --------------------------------------------------------

--
-- Table structure for table `CustomerDeliveries`
--

CREATE TABLE `CustomerDeliveries` (
  `id` int NOT NULL,
  `deliveryProvider` varchar(255) DEFAULT NULL,
  `orderStatus` varchar(255) DEFAULT NULL,
  `estimatedDelivery` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerOrderId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerDeliveries`
--

INSERT INTO `CustomerDeliveries` (`id`, `deliveryProvider`, `orderStatus`, `estimatedDelivery`, `createdAt`, `updatedAt`, `CustomerOrderId`) VALUES
(1, 'normal', 'Order', 'Sunday December 20th', '2020-12-15 02:52:10', '2020-12-15 02:52:20', 1),
(2, 'normal', 'Pending', 'Sunday December 20th', '2020-12-15 04:08:22', '2020-12-15 04:08:22', 2),
(3, 'express', 'Order', 'Friday December 18th', '2020-12-15 06:02:35', '2020-12-15 06:02:43', 3),
(4, 'express', 'Order', 'Friday December 18th', '2020-12-15 06:02:35', '2020-12-15 06:02:43', 3),
(5, 'express', 'Order', 'Friday December 18th', '2020-12-15 06:31:42', '2020-12-15 06:32:12', 4),
(6, 'normal', 'Order', 'Monday December 21st', '2020-12-16 03:49:01', '2020-12-16 03:49:16', 5),
(7, 'express', 'Order', 'Saturday December 19th', '2020-12-16 05:57:53', '2020-12-16 05:58:43', 6),
(8, 'normal', 'Pending', 'Friday March 5th', '2021-02-28 20:23:09', '2021-02-28 20:23:09', 7),
(9, 'express', 'Order', 'Monday March 8th', '2021-03-05 04:21:51', '2021-03-05 04:22:22', 8),
(10, 'express', 'Order', 'Friday March 26th', '2021-03-23 03:36:06', '2021-03-23 03:36:54', 9);

-- --------------------------------------------------------

--
-- Table structure for table `CustomerOrderItems`
--

CREATE TABLE `CustomerOrderItems` (
  `id` int NOT NULL,
  `cartItem` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerOrderId` int DEFAULT NULL,
  `SellerId` int NOT NULL,
  `ProductId` int NOT NULL,
  `DeliveryId` int NOT NULL,
  `AddressId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerOrderItems`
--

INSERT INTO `CustomerOrderItems` (`id`, `cartItem`, `quantity`, `price`, `createdAt`, `updatedAt`, `CustomerOrderId`, `SellerId`, `ProductId`, `DeliveryId`, `AddressId`) VALUES
(1, '1', 6, 100, '2020-12-15 02:52:10', '2020-12-15 02:52:10', 1, 3, 1, 1, 1),
(3, '1', 2, 100, '2020-12-15 06:02:35', '2020-12-15 06:02:35', 3, 3, 1, 1, 1),
(4, '1', 2, 100, '2020-12-15 06:02:35', '2020-12-15 06:02:35', 3, 3, 1, 1, 1),
(5, '2', 3, 100, '2020-12-15 06:31:42', '2020-12-15 06:31:42', 4, 1, 2, 1, 1),
(6, '2', 5, 100, '2020-12-16 03:49:01', '2020-12-16 03:49:01', 5, 1, 2, 2, 2),
(7, '2', 10, 100, '2020-12-16 05:57:53', '2020-12-16 05:57:53', 6, 1, 2, 1, 1),
(8, '2', 2, 100, '2021-02-28 20:23:09', '2021-02-28 20:23:09', 7, 1, 2, 3, 3),
(10, '2', 5, 100, '2021-03-23 03:36:06', '2021-03-23 03:36:06', 9, 1, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `CustomerOrders`
--

CREATE TABLE `CustomerOrders` (
  `id` int NOT NULL,
  `totalQuantity` int DEFAULT NULL,
  `totalPrice` int DEFAULT NULL,
  `deliveryAddress` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerOrders`
--

INSERT INTO `CustomerOrders` (`id`, `totalQuantity`, `totalPrice`, `deliveryAddress`, `createdAt`, `updatedAt`, `CustomerId`) VALUES
(1, 1, 625, 1, '2020-12-15 02:52:10', '2020-12-15 02:52:10', 1),
(2, 1, 225, 0, '2020-12-15 04:08:22', '2020-12-15 04:08:22', 2),
(3, 2, 1140, 1, '2020-12-15 06:02:35', '2020-12-15 06:02:35', 1),
(4, 1, 340, 1, '2020-12-15 06:31:42', '2020-12-15 06:31:42', 1),
(5, 1, 525, 2, '2020-12-16 03:49:01', '2020-12-16 03:49:01', 1),
(6, 1, 1040, 1, '2020-12-16 05:57:53', '2020-12-16 05:57:53', 1),
(7, 1, 225, 3, '2021-02-28 20:23:09', '2021-02-28 20:23:09', 3),
(8, 1, 340, 4, '2021-03-05 04:21:51', '2021-03-05 04:21:51', 1),
(9, 1, 540, 1, '2021-03-23 03:36:06', '2021-03-23 03:36:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `CustomerProfiles`
--

CREATE TABLE `CustomerProfiles` (
  `id` int NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `sex` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerProfiles`
--

INSERT INTO `CustomerProfiles` (`id`, `displayName`, `fullName`, `phoneNumber`, `sex`, `createdAt`, `updatedAt`, `CustomerId`) VALUES
(1, 'ichigozcloud', 'พัชรพงศ์  รัตนคำมน', '054329195', 1, '2020-12-14 22:19:46', '2021-03-05 04:23:45', 1),
(2, 'Emily Chang', NULL, NULL, NULL, '2020-12-15 04:07:30', '2020-12-15 04:07:30', 2),
(3, 'zxcasd123', NULL, NULL, NULL, '2021-02-22 19:52:28', '2021-02-22 19:52:28', 3),
(4, 'test01', NULL, NULL, NULL, '2021-03-12 12:18:35', '2021-03-12 12:18:35', 4);

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `id` int NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status_level` varchar(255) NOT NULL,
  `defaultAddress` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`id`, `userName`, `password`, `email`, `status_level`, `defaultAddress`, `createdAt`, `updatedAt`) VALUES
(1, 'ichigozcloud', '$2a$10$D6CXdTf85iHZwQZtvweOdeR0akHZZhmsPX1NN2hYTQh/KnSbVnINm', 'ichigozcloud@gmail.com', 'member', NULL, '2020-12-14 22:19:45', '2020-12-14 22:19:45'),
(2, 'Emily Chang', '$2a$10$c3BjtQhDaBaIsGIak.3U5uZgw3Cn46n8QCrxhrGyqR0esyQuyv2YC', 'EmilyRoseChang@hotmail.com', 'member', NULL, '2020-12-15 04:07:29', '2020-12-15 04:07:29'),
(3, 'zxcasd123', '$2a$10$GFYi2BuXIb5dBrKw1cIH7O5OTymQCGGJwUQ2v/e3GluM2FgP3BruC', 'zxcasd123@gmail.com', 'member', NULL, '2021-02-22 19:52:28', '2021-02-22 19:52:28'),
(4, 'test01', '$2a$10$KTIwab36rb4eVNIeDkBBLeCo2B0R.pGbakp75UdXhDIzE0aXQrJ.q', 'test1234@gmail.com', 'member', NULL, '2021-03-12 12:18:34', '2021-03-12 12:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `CustomerTransactions`
--

CREATE TABLE `CustomerTransactions` (
  `id` int NOT NULL,
  `paymentToken` longtext,
  `orderNo` longtext,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CustomerOrderId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CustomerTransactions`
--

INSERT INTO `CustomerTransactions` (`id`, `paymentToken`, `orderNo`, `createdAt`, `updatedAt`, `CustomerOrderId`) VALUES
(1, 'chrg_test_5m7enahvgwkn6063173', 'IFP_ddf59df2', '2020-12-15 02:52:10', '2020-12-15 02:52:20', 1),
(2, NULL, 'IFP_6f7fbc3d', '2020-12-15 04:08:22', '2020-12-15 04:08:22', 2),
(3, 'chrg_test_5m7gib63n4r9b1gqjx8', 'IFP_1fa285a7', '2020-12-15 06:02:35', '2020-12-15 06:02:43', 3),
(4, 'chrg_test_5m7gsorz0g0vu1u6nlx', 'IFP_33694f50', '2020-12-15 06:31:42', '2020-12-15 06:32:12', 4),
(5, 'chrg_test_5m7ta8kmj9q3tpxeqy8', 'IFP_0943ba1f', '2020-12-16 03:49:01', '2020-12-16 03:49:16', 5),
(6, 'chrg_test_5m7ujt1pautowruni3c', 'IFP_80438a02', '2020-12-16 05:57:53', '2020-12-16 05:58:43', 6),
(7, NULL, 'IFP_b9966561', '2021-02-28 20:23:09', '2021-02-28 20:23:09', 7),
(8, 'chrg_test_5n2pzk6umtc1a7k5x7q', 'IFP_5051c52f', '2021-03-05 04:21:51', '2021-03-05 04:22:22', 8),
(9, 'chrg_test_5n9qzvumcj19hw2uhab', 'IFP_02a1a144', '2021-03-23 03:36:06', '2021-03-23 03:36:54', 9);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dbLists`
--

CREATE TABLE `tbl_dbLists` (
  `id` int NOT NULL,
  `temp` double DEFAULT NULL,
  `humi` int DEFAULT NULL,
  `light_int` int DEFAULT NULL,
  `ec` double DEFAULT NULL,
  `ph` double DEFAULT NULL,
  `water_level` double DEFAULT NULL,
  `pump_a` tinyint(1) DEFAULT NULL,
  `pump_b` tinyint(1) DEFAULT NULL,
  `pump_c` tinyint(1) DEFAULT NULL,
  `pump_d` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `serial_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_dbLists`
--

INSERT INTO `tbl_dbLists` (`id`, `temp`, `humi`, `light_int`, `ec`, `ph`, `water_level`, `pump_a`, `pump_b`, `pump_c`, `pump_d`, `createdAt`, `updatedAt`, `serial_id`, `user_id`) VALUES
(1, 25, 72, 0, 45, 7.6, 10, 0, 0, 0, 0, '2020-12-15 10:57:04', '2020-12-15 10:57:04', 1, 1),
(2, 24.8, 71, 0, 44, 7.6, 10, 1, 0, 1, 0, '2020-12-15 10:57:04', '2020-12-15 12:22:44', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dbRealtimes`
--

CREATE TABLE `tbl_dbRealtimes` (
  `id` int NOT NULL,
  `temp` double DEFAULT NULL,
  `humi` int DEFAULT NULL,
  `light_int` int DEFAULT NULL,
  `ec` double DEFAULT NULL,
  `ph` double DEFAULT NULL,
  `water_level` float DEFAULT NULL,
  `pump_a` tinyint(1) DEFAULT NULL,
  `pump_b` tinyint(1) DEFAULT NULL,
  `pump_c` tinyint(1) DEFAULT NULL,
  `pump_d` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `serial_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_dbRealtimes`
--

INSERT INTO `tbl_dbRealtimes` (`id`, `temp`, `humi`, `light_int`, `ec`, `ph`, `water_level`, `pump_a`, `pump_b`, `pump_c`, `pump_d`, `createdAt`, `updatedAt`, `serial_id`, `user_id`) VALUES
(1, 30.1, 77, 116, 75.7141, 7.40015, 86.2069, 0, 0, 0, 0, '2020-12-14 22:08:14', '2021-02-04 05:48:49', 1, 1),
(3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2020-12-14 22:33:27', '2020-12-14 22:33:27', 3, 3),
(4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2020-12-15 04:30:08', '2020-12-15 04:30:08', 4, 1),
(5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-01-31 18:56:50', '2021-01-31 18:56:50', 5, 4),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-02-21 18:02:21', '2021-02-21 18:02:21', 6, 5),
(7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-03-05 04:19:11', '2021-03-05 04:19:11', 7, 6),
(8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-03-09 03:34:18', '2021-03-09 03:34:18', 8, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `id` int NOT NULL,
  `nameuser` varchar(255) DEFAULT NULL,
  `addressuser` varchar(255) DEFAULT NULL,
  `teluser` varchar(255) DEFAULT NULL,
  `lists_order` varchar(255) DEFAULT NULL,
  `totalpice_order` int DEFAULT NULL,
  `status_order` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sellproducts`
--

CREATE TABLE `tbl_sellproducts` (
  `id` int NOT NULL,
  `productname` varchar(255) DEFAULT NULL,
  `productdetail` text,
  `productprice` int DEFAULT NULL,
  `productnumber` int DEFAULT NULL,
  `producttab` varchar(255) DEFAULT NULL,
  `productimg` varchar(255) DEFAULT NULL,
  `productstatus` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `SellerId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_sellproducts`
--

INSERT INTO `tbl_sellproducts` (`id`, `productname`, `productdetail`, `productprice`, `productnumber`, `producttab`, `productimg`, `productstatus`, `createdAt`, `updatedAt`, `SellerId`) VALUES
(1, 'สลัดกรีนโอค', 'ผักสลัด ปัจจุบันเมีความนิยมเป็นอย่างมาก เนื่องจากความนิยมบริโภคสลัดผักเพิ่มขึ้นมาก คนรักสุขภาพ ผู้ที่ต้องการลดน้ำหนักและคนรักการรับประทานผักเป็นชีวิตจิตใจ หลายท่านนิยมทานเป็นอาหารเช้าหรืออาหารเย็น ผักสลัดนั้นนิยมทำเป็นเมนูสลัดราดน้ำสลัด หรือจะรับประทานคู่กับอาหาร สเต็ก หมูย่าง หรือเนื้อย่าง ก็สามารถอร่อยได้ทันที', 100, 100, NULL, 'photo_1.jpeg', '1', '2020-12-14 22:37:32', '2020-12-14 22:37:32', 3),
(2, 'ผักกาดขาวsd;lsf;sdlk;', 'ผักสลัด ปัจจุบันเมีความนิยมเป็นอย่างมาก เนื่องจากความนิยมบริโภคสลัดผักเพิ่มขึ้นมาก คนรักสุขภาพ ผู้ที่ต้องการลดน้ำหนักและคนรักการรับประทานผักเป็นชีวิตจิตใจ หลายท่านนิยมทานเป็นอาหารเช้าหรืออาหารเย็น ผักสลัดนั้นนิยมทำเป็นเมนูสลัดราดน้ำสลัด หรือจะรับประทานคู่กับอาหาร สเต็ก หมูย่าง หรือเนื้อย่าง ก็สามารถอร่อยได้ทันที', 100, 55555, NULL, 'photo_2.jpg', '1', '2020-12-15 04:48:50', '2021-03-11 03:16:42', 1),
(5, 'ผักอร่อยดี', 'อร่อยดีผักผักอร่อยดีอร่อยดีจริงๆอร่อยมากกๆชอบกินผักมากๆเพราะผักอร่อยดีผักอร่อยดีจริงๆอร่อยมากๆชอบกินผักมากๆ', 10, 10, NULL, 'photo_5.jpg', '1', '2021-02-21 18:04:17', '2021-02-21 18:04:18', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_Serials`
--

CREATE TABLE `tbl_Serials` (
  `id` int NOT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_Serials`
--

INSERT INTO `tbl_Serials` (`id`, `serial`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'Ad_ifp2020', 1, '2020-10-05 23:38:30', '2020-12-14 22:10:55'),
(2, 'mai_9d83caf8', 1, '2020-12-14 22:32:35', '2020-12-14 22:33:27'),
(3, 'ifp_5cc37d55', 1, '2020-12-15 04:28:04', '2020-12-15 04:30:08'),
(4, 'ifp_31cc05df', 1, '2020-12-15 04:28:04', '2021-01-31 18:56:50'),
(5, 'ifp_41560be7', 1, '2020-12-15 04:28:04', '2021-02-21 18:02:21'),
(6, 'ifp_20c5c044', 1, '2020-12-15 04:28:04', '2021-03-05 04:19:11'),
(7, 'ifp_446248a4', 1, '2020-12-15 04:28:04', '2021-03-09 03:34:18'),
(8, 'BAl_2355cb1c', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(9, 'BAl_cea84ee9', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(10, 'BAl_0436cbd6', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(11, 'BAl_eb96566f', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(12, 'BAl_9cbbac08', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(13, 'BAl_c79de98e', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(14, 'BAl_de7cdb40', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(15, 'BAl_5cf9b333', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(16, 'BAl_656efb27', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(17, 'BAl_ac75b739', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(18, 'BAl_869d9164', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(19, 'BAl_76ea7724', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(20, 'BAl_0bd8e997', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(21, 'BAl_80e30c42', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(22, 'BAl_396a966c', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(23, 'BAl_2b669e36', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(24, 'BAl_bf714514', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(25, 'BAl_bf83df10', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(26, 'BAl_4b40dd50', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(27, 'BAl_1208cd9b', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(28, 'BAl_bec60459', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(29, 'BAl_1cc31b1b', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(30, 'BAl_a30e7866', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(31, 'BAl_e04b900c', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40'),
(32, 'BAl_1f050311', 0, '2021-02-19 02:50:40', '2021-02-19 02:50:40');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_settingpumps`
--

CREATE TABLE `tbl_settingpumps` (
  `id` int NOT NULL,
  `temp` double DEFAULT NULL,
  `humi` int DEFAULT NULL,
  `ec` double DEFAULT NULL,
  `water_level` double DEFAULT NULL,
  `pump_a` tinyint(1) DEFAULT NULL,
  `pump_b` tinyint(1) DEFAULT NULL,
  `pump_c` tinyint(1) DEFAULT NULL,
  `pump_d` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `serial_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_settingpumps`
--

INSERT INTO `tbl_settingpumps` (`id`, `temp`, `humi`, `ec`, `water_level`, `pump_a`, `pump_b`, `pump_c`, `pump_d`, `createdAt`, `updatedAt`, `serial_id`, `user_id`) VALUES
(1, 54.8, 32, 0, 0, 0, 0, 0, 0, '2020-12-14 22:08:14', '2021-03-23 04:30:59', 1, 1),
(3, 0, 0, 40, 0, 0, 0, 0, 0, '2020-12-14 22:33:27', '2020-12-15 03:36:53', 3, 3),
(4, 0, 0, 0, 0, 0, 0, 0, 0, '2020-12-15 04:30:08', '2020-12-15 04:30:08', 4, 1),
(5, 0, 0, 0, 0, 0, 0, 0, 0, '2021-01-31 18:56:50', '2021-01-31 18:56:50', 5, 4),
(6, 0, 0, 0, 0, 0, 0, 0, 0, '2021-02-21 18:02:21', '2021-02-21 18:02:21', 6, 5),
(7, 0, 0, 0, 0, 0, 0, 0, 0, '2021-03-05 04:19:11', '2021-03-05 04:19:11', 7, 6),
(8, 0, 0, 0, 0, 0, 0, 0, 0, '2021-03-09 03:34:18', '2021-03-09 03:34:18', 8, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_useraccountbanks`
--

CREATE TABLE `tbl_useraccountbanks` (
  `id` int NOT NULL,
  `namebank` varchar(255) DEFAULT NULL,
  `nameaccountTH` varchar(255) DEFAULT NULL,
  `nameaccountEN` varchar(255) DEFAULT NULL,
  `numberaccount` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_userdetails`
--

CREATE TABLE `tbl_userdetails` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `status_level` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_userdetails`
--

INSERT INTO `tbl_userdetails` (`id`, `name`, `email`, `address`, `detail`, `img`, `status_level`, `createdAt`, `updatedAt`, `UserId`) VALUES
(1, 'm1test😍🤷‍♀️', '', '1332323', '🤣', 'Default.png', 'members', '2020-12-14 22:08:14', '2020-12-16 12:16:03', 1),
(2, 'myadmin', '', '', '', 'Default.png', 'Admin', '2020-12-14 22:10:55', '2020-12-14 22:10:55', 2),
(3, 'maims@2020', '', '', '', 'Default.png', 'members', '2020-12-14 22:33:27', '2020-12-14 22:33:27', 3),
(4, 'test01', '', '', '', 'Default.png', 'members', '2021-01-31 18:56:50', '2021-01-31 18:56:50', 4),
(5, 'faiyfaiy', '', '', '', 'Default.png', 'members', '2021-02-21 18:02:21', '2021-02-21 18:02:21', 5),
(6, 'ichigoz', '', '', '', 'Default.png', 'members', '2021-03-05 04:19:11', '2021-03-05 04:19:11', 6),
(7, 'piyadanai', '', '', '', 'Default.png', 'members', '2021-03-09 03:34:18', '2021-03-09 03:34:18', 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_userserials`
--

CREATE TABLE `tbl_userserials` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_userserials`
--

INSERT INTO `tbl_userserials` (`id`, `name`, `serial`, `createdAt`, `updatedAt`, `UserId`) VALUES
(1, 'ฟาร์มสลัด 1 ', 'Ad_ifp2020', '2020-12-14 22:08:14', '2020-12-15 03:51:45', 1),
(3, 'ฟาร์มสลัด 1', 'mai_9d83caf8', '2020-12-14 22:33:27', '2020-12-14 22:34:22', 3),
(4, 'ฟาร์มสลัด 2', 'ifp_5cc37d55', '2020-12-15 04:30:08', '2020-12-15 04:30:08', 1),
(5, 'กรุณาเปลี่ยนชื่อ', 'ifp_31cc05df', '2021-01-31 18:56:50', '2021-01-31 18:56:50', 4),
(6, 'กรุณาเปลี่ยนชื่อ', 'ifp_41560be7', '2021-02-21 18:02:21', '2021-02-21 18:02:21', 5),
(7, 'กรุณาเปลี่ยนชื่อ', 'ifp_20c5c044', '2021-03-05 04:19:11', '2021-03-05 04:19:11', 6),
(8, 'กรุณาเปลี่ยนชื่อ', 'ifp_446248a4', '2021-03-09 03:34:18', '2021-03-09 03:34:18', 7);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `userName`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'mytest', '$2a$10$8L7NVyl47o90vNQrxmD2Z.ERsjXWWIpdfhTzZXfcTU5NJRUjjZFZq', '2020-12-14 22:08:14', '2020-12-14 22:08:14'),
(2, 'myadmin', '$2a$10$Sb4JJqr0uXvR/qtBLrUdx.1sVRhRGwqOHlQzWNABkSIhQyjT47BYm', '2020-12-14 22:10:55', '2020-12-14 22:10:55'),
(3, 'maims@2020', '$2a$10$/9mudHBh9SIgqm07e8nPRuGaFeIEBUsy9QAR.kALGnt0kpefnoVNO', '2020-12-14 22:33:27', '2020-12-14 22:33:27'),
(4, 'test01', '$2a$10$nnNLB6T9BVDMo1g.uWEFV.wF28A473qHGYID9TfFMxJNfmDCfhj.W', '2021-01-31 18:56:50', '2021-01-31 18:56:50'),
(5, 'faiyfaiy', '$2a$10$pcxPBypkPtCRcC4ioe68EOF2RQqmKj8YZPoDxtvArSGi0v3NyR59q', '2021-02-21 18:02:21', '2021-02-21 18:02:21'),
(6, 'ichigoz', '$2a$10$0adrNssa64Zw0Gv./3RV7uIMa0tuIyXOhFehJuyttIEpk2uA8925G', '2021-03-05 04:19:11', '2021-03-05 04:19:11'),
(7, 'piyadanai', '$2a$10$5wj0gqW/6O8aAxxfhQbT8eylh22LsO86ocDvoe6eIzfAwdniOngb6', '2021-03-09 03:34:18', '2021-03-09 03:34:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CustomerAddresses`
--
ALTER TABLE `CustomerAddresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerId` (`CustomerId`);

--
-- Indexes for table `CustomerDeliveries`
--
ALTER TABLE `CustomerDeliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerOrderId` (`CustomerOrderId`);

--
-- Indexes for table `CustomerOrderItems`
--
ALTER TABLE `CustomerOrderItems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerOrderId` (`CustomerOrderId`),
  ADD KEY `SellerId` (`SellerId`),
  ADD KEY `ProductId` (`ProductId`),
  ADD KEY `DeliveryId` (`DeliveryId`),
  ADD KEY `AddressId` (`AddressId`);

--
-- Indexes for table `CustomerOrders`
--
ALTER TABLE `CustomerOrders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerId` (`CustomerId`);

--
-- Indexes for table `CustomerProfiles`
--
ALTER TABLE `CustomerProfiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerId` (`CustomerId`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `CustomerTransactions`
--
ALTER TABLE `CustomerTransactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustomerOrderId` (`CustomerOrderId`);

--
-- Indexes for table `tbl_dbLists`
--
ALTER TABLE `tbl_dbLists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serial_id` (`serial_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_dbRealtimes`
--
ALTER TABLE `tbl_dbRealtimes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serial_id` (`serial_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_sellproducts`
--
ALTER TABLE `tbl_sellproducts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SellerId` (`SellerId`);

--
-- Indexes for table `tbl_Serials`
--
ALTER TABLE `tbl_Serials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_settingpumps`
--
ALTER TABLE `tbl_settingpumps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serial_id` (`serial_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_useraccountbanks`
--
ALTER TABLE `tbl_useraccountbanks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `tbl_userdetails`
--
ALTER TABLE `tbl_userdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `tbl_userserials`
--
ALTER TABLE `tbl_userserials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CustomerAddresses`
--
ALTER TABLE `CustomerAddresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `CustomerDeliveries`
--
ALTER TABLE `CustomerDeliveries`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `CustomerOrderItems`
--
ALTER TABLE `CustomerOrderItems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `CustomerOrders`
--
ALTER TABLE `CustomerOrders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `CustomerProfiles`
--
ALTER TABLE `CustomerProfiles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `CustomerTransactions`
--
ALTER TABLE `CustomerTransactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_dbLists`
--
ALTER TABLE `tbl_dbLists`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_dbRealtimes`
--
ALTER TABLE `tbl_dbRealtimes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_sellproducts`
--
ALTER TABLE `tbl_sellproducts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_Serials`
--
ALTER TABLE `tbl_Serials`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tbl_settingpumps`
--
ALTER TABLE `tbl_settingpumps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_useraccountbanks`
--
ALTER TABLE `tbl_useraccountbanks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_userdetails`
--
ALTER TABLE `tbl_userdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_userserials`
--
ALTER TABLE `tbl_userserials`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CustomerAddresses`
--
ALTER TABLE `CustomerAddresses`
  ADD CONSTRAINT `CustomerAddresses_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `CustomerDeliveries`
--
ALTER TABLE `CustomerDeliveries`
  ADD CONSTRAINT `CustomerDeliveries_ibfk_1` FOREIGN KEY (`CustomerOrderId`) REFERENCES `CustomerOrders` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `CustomerOrderItems`
--
ALTER TABLE `CustomerOrderItems`
  ADD CONSTRAINT `CustomerOrderItems_ibfk_1` FOREIGN KEY (`CustomerOrderId`) REFERENCES `CustomerOrders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `CustomerOrderItems_ibfk_2` FOREIGN KEY (`SellerId`) REFERENCES `tbl_userdetails` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CustomerOrderItems_ibfk_3` FOREIGN KEY (`ProductId`) REFERENCES `tbl_sellproducts` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CustomerOrderItems_ibfk_4` FOREIGN KEY (`DeliveryId`) REFERENCES `CustomerDeliveries` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CustomerOrderItems_ibfk_5` FOREIGN KEY (`AddressId`) REFERENCES `CustomerAddresses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `CustomerOrders`
--
ALTER TABLE `CustomerOrders`
  ADD CONSTRAINT `CustomerOrders_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `CustomerProfiles`
--
ALTER TABLE `CustomerProfiles`
  ADD CONSTRAINT `CustomerProfiles_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `CustomerTransactions`
--
ALTER TABLE `CustomerTransactions`
  ADD CONSTRAINT `CustomerTransactions_ibfk_1` FOREIGN KEY (`CustomerOrderId`) REFERENCES `CustomerOrders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_dbLists`
--
ALTER TABLE `tbl_dbLists`
  ADD CONSTRAINT `tbl_dbLists_ibfk_1` FOREIGN KEY (`serial_id`) REFERENCES `tbl_userserials` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_dbLists_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tbl_dbRealtimes`
--
ALTER TABLE `tbl_dbRealtimes`
  ADD CONSTRAINT `tbl_dbRealtimes_ibfk_1` FOREIGN KEY (`serial_id`) REFERENCES `tbl_userserials` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_dbRealtimes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tbl_sellproducts`
--
ALTER TABLE `tbl_sellproducts`
  ADD CONSTRAINT `tbl_sellproducts_ibfk_1` FOREIGN KEY (`SellerId`) REFERENCES `tbl_userdetails` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tbl_settingpumps`
--
ALTER TABLE `tbl_settingpumps`
  ADD CONSTRAINT `tbl_settingpumps_ibfk_1` FOREIGN KEY (`serial_id`) REFERENCES `tbl_userserials` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_settingpumps_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tbl_useraccountbanks`
--
ALTER TABLE `tbl_useraccountbanks`
  ADD CONSTRAINT `tbl_useraccountbanks_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_userdetails`
--
ALTER TABLE `tbl_userdetails`
  ADD CONSTRAINT `tbl_userdetails_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_userserials`
--
ALTER TABLE `tbl_userserials`
  ADD CONSTRAINT `tbl_userserials_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
