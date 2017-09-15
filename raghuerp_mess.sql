-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 15, 2017 at 02:36 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raghuerp_mess`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` int(11) NOT NULL,
  `billno` varchar(16) DEFAULT NULL,
  `bill_name` varchar(36) DEFAULT NULL,
  `bill_type` varchar(16) DEFAULT NULL,
  `bill_upload_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `billno`, `bill_name`, `bill_type`, `bill_upload_date`) VALUES
(1, '[object Object]', '123.jpg', 'image/jpeg', '2017-09-04'),
(2, '324', 'electrical.jpg', 'image/jpeg', '2017-09-04'),
(3, '11536', 'download (2).jpg', 'image/jpeg', '2017-09-04'),
(4, '9', '71PMWlQ7HgL._SX355_.jpg', 'image/jpeg', '2017-09-04'),
(5, 'T56Y', 'images.jpg', 'image/jpeg', '2017-09-04'),
(6, 'temp', 'images (1).jpg', 'image/jpeg', '2017-09-04'),
(7, 'temp', 'electron_lab.jpg', 'image/jpeg', '2017-09-04'),
(8, 'temp', 'images (2).jpg', 'image/jpeg', '2017-09-04'),
(9, '4356', 'garbages.jpg', 'image/jpeg', '2017-09-04'),
(10, '136', 'GROCERY-BILL_2674813b.jpg', 'image/jpeg', '2017-09-06'),
(11, '1453', 'GROCERY-BILL_2674813b.jpg', 'image/jpeg', '2017-09-06'),
(12, '43567', 'ac1.jpg', 'image/jpeg', '2017-09-06'),
(13, '7878', 'ac1.jpg', 'image/jpeg', '2017-09-06'),
(14, '1278', 'garbage.jpg', 'image/jpeg', '2017-09-06'),
(15, '1278', 'garbage.jpg', 'image/jpeg', '2017-09-06'),
(16, '5689', 'download (1)d.jpg', 'image/jpeg', '2017-09-06');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) NOT NULL,
  `item_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `item_type`) VALUES
(8, 'Kitchen'),
(9, 'Miscelleneous'),
(5, 'OtherIngredients'),
(7, 'PoojaItems'),
(12, 'PowdersandOils'),
(2, 'PulsesandDals'),
(4, 'SpicseandNuts'),
(6, 'Toiletries'),
(1, 'Vegetables');

-- --------------------------------------------------------

--
-- Table structure for table `discount`
--

CREATE TABLE `discount` (
  `id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL,
  `receipt_no` varchar(16) NOT NULL,
  `discount` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `discount`
--

INSERT INTO `discount` (`id`, `purchase_date`, `receipt_no`, `discount`) VALUES
(1, '2017-09-02 02:35:14', '23', 5),
(2, '2017-09-03 03:34:00', '653', 100),
(3, '2017-09-04 04:06:55', '324', 40),
(4, '2017-09-04 04:19:33', '11536', 200),
(5, '2017-09-04 04:47:57', '14', 0),
(6, '2017-09-04 06:18:25', '9', 0),
(7, '2017-09-04 08:19:09', '', 30),
(8, '2017-09-04 08:23:41', '963', 0),
(9, '2017-09-04 08:32:59', '1965', 20),
(10, '2017-09-04 08:36:50', '785RE', 20),
(11, '2017-09-04 08:41:14', 'T56Y', 15),
(12, '2017-09-04 08:52:27', '', 50),
(13, '2017-09-04 09:12:42', '2463', 20),
(14, '2017-09-04 09:35:55', '1256', 40),
(15, '2017-09-04 09:41:31', '1269', 0),
(16, '2017-09-04 09:45:12', '4356', 20),
(17, '2017-09-06 10:05:20', '136', 0),
(18, '2017-09-06 10:14:12', '1453', 0),
(19, '2017-09-06 11:55:06', '1453', 0),
(20, '2017-09-06 03:38:42', '123', 0),
(21, '2017-09-06 05:07:25', '1212', 0),
(22, '2017-09-06 05:07:57', '121', 0),
(23, '2017-09-06 05:08:53', '12', 0),
(24, '2017-09-06 05:49:29', '1213', 0),
(25, '2017-09-06 05:54:05', '323', 0),
(26, '2017-09-06 05:56:16', '235', 0),
(27, '2017-09-06 06:00:26', '124', 0),
(28, '2017-09-06 06:03:14', '5632', 0),
(29, '2017-09-06 06:10:46', '1255', 0),
(30, '2017-09-06 06:14:34', '43567', 0),
(31, '2017-09-06 06:15:11', '7878', 0),
(32, '2017-09-06 06:16:38', '1278', 0),
(33, '2017-09-06 06:17:44', '5689', 0);

-- --------------------------------------------------------

--
-- Table structure for table `material`
--

CREATE TABLE `material` (
  `mid` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `item_type` varchar(24) DEFAULT NULL,
  `units` varchar(32) NOT NULL,
  `minvalue` int(8) NOT NULL,
  `latest_in` int(8) NOT NULL,
  `latest_out` int(8) NOT NULL,
  `total_balance` int(8) NOT NULL,
  `last_in_updated` datetime DEFAULT NULL,
  `last_out_updated` date DEFAULT NULL,
  `status` tinyint(2) NOT NULL COMMENT '0-inactive, 1-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `material`
--

INSERT INTO `material` (`mid`, `item`, `item_type`, `units`, `minvalue`, `latest_in`, `latest_out`, `total_balance`, `last_in_updated`, `last_out_updated`, `status`) VALUES
(1, 'Turmeric powder', 'Kitchen', 'kgs', 6, 3, 2, 625, '2017-09-01 09:25:42', '2017-09-02', 1),
(2, 'Sugar', 'Kitchen', 'kgs', 6, 45, 2, 3, '2017-09-07 03:38:42', '2017-09-08', 0),
(3, 'Jaggery', 'Kitchen', 'kgs', 6, 2, 3, 56, '2017-09-07 06:00:26', '2017-09-08', 1),
(4, 'Idli rice/Boiled rice/Salem rice', 'Kitchen', 'kgs', 6, 1, 1, 123, '2017-09-07 05:07:57', '2017-08-23', 1),
(6, 'Steamed rice or Raw rice/Sona masoori', 'Kitchen', 'kgs', 10, 25, 8, 59, '2017-09-06 09:18:12', '2017-08-28', 1),
(7, 'Basmati rice', 'Kitchen', 'kgs', 6, 25, 2, 163, '2017-09-07 05:54:05', '2017-08-31', 0),
(8, 'Wheat flour', 'Kitchen', 'kgs', 6, 1, 5, 11, '2017-09-07 06:17:44', '2017-09-02', 0),
(12, 'Maida', 'Kitchen', 'kgs', 6, 1, 0, 21, '2017-09-07 05:56:16', NULL, 0),
(13, 'Ragi flour', 'Kitchen', 'kgs', 6, 2, 0, 2, '2017-09-07 10:14:12', NULL, 0),
(14, 'Millets varieties', 'Kitchen', 'kgs', 6, 10, 0, 10, '2017-09-07 10:05:20', NULL, 0),
(16, 'Rava or Chiroti rava', 'Kitchen', 'kgs', 10, 0, 0, 0, NULL, NULL, 0),
(18, 'Toor dal ', 'PulsesandDals', 'kgs', 5, 4, 2, 53, '2017-09-07 10:14:12', '2017-08-28', 0),
(19, 'Round urad dal', 'PulsesandDals', 'kgs', 12, 2, 0, 63, '2017-09-07 06:03:14', NULL, 0),
(23, 'Yellow moong dal', 'PulsesandDals', 'kgs', 1, 2, 0, 12, '2017-09-04 04:03:58', NULL, 0),
(24, 'Chana dal', 'PulsesandDals', 'kgs', 1, 1, 0, 6, '2017-09-07 06:14:34', NULL, 0),
(26, 'Split urad dal', 'PulsesandDals', 'kgs', 2, 15, 140, 5, '2017-09-04 06:18:25', '2017-09-07', 0),
(27, 'Rajma,peas,brown/white chana,green gram', 'PulsesandDals', 'kgs', 3, 0, 0, 0, NULL, NULL, 0),
(35, 'Powder salt', 'PowdersandOils', 'kgs', 1, 12, 0, 12, '2017-08-31 02:32:56', NULL, 0),
(36, 'Crystal salt', 'PowdersandOils', 'kgs', 1, 2, 0, 2, '2017-08-30 05:28:57', NULL, 0),
(37, 'Red chilli powder', 'PowdersandOils', 'kgs', 1, 0, 0, 0, NULL, NULL, 0),
(38, 'Dhania powder', 'PowdersandOils', 'kgs', 1, 2, 4, 0, '2017-09-05 02:56:33', '2017-09-08', 0),
(39, 'Garam masala powder', 'PowdersandOils', 'kgs', 1, 0, 0, 0, NULL, NULL, 0),
(40, 'Chat masala powder', 'PowdersandOils', 'kgs', 1, 1, 0, 6, '2017-09-07 05:07:25', NULL, 0),
(41, 'Biryani masala powder', 'PowdersandOils', 'kgs', 5, 1, 0, 2, '2017-09-05 08:41:14', NULL, 0),
(42, 'Instant coffee powder', 'PowdersandOils', 'kgs', 1, 2, 0, 3, '2017-09-05 09:12:42', NULL, 0),
(44, 'Tea powder', 'PowdersandOils', 'kgs', 1, 0, 0, 0, NULL, NULL, 0),
(45, 'Cooking oil', 'PowdersandOils', 'ltrs', 1, 4, 3, 83, '2017-09-05 02:31:14', '2017-08-31', 0),
(46, 'Gingely oil/Sesame oil', 'PowdersandOils', 'ltrs', 1, 15, 3, 44, '2017-09-01 09:21:15', '2017-08-31', 0),
(47, 'Coconut oil', 'PowdersandOils', 'ltrs', 1, 1, 0, 18, '2017-09-07 06:16:38', NULL, 0),
(48, 'Ghee or butter', 'PowdersandOils', 'kgs', 1, 2, 0, 2, '2017-09-05 09:45:12', NULL, 0),
(49, 'Black or white sesame seeds', 'SpicseandNuts', 'gms', 1, 200, 0, 200, '2017-09-02 11:34:44', NULL, 0),
(50, 'Dry ginger piece or powder', 'SpicseandNuts', 'gms', 1, 500, 200, 300, '2017-09-05 08:11:42', '2017-09-05', 0),
(51, 'Fennel seeds', 'SpicseandNuts', 'gms', 1, 50, 0, 50, '2017-08-31 02:32:56', NULL, 0),
(52, 'Coriander seeds/Dhania', 'SpicseandNuts', 'gms', 1, 31, 0, 22, '2017-08-31 09:31:27', NULL, 0),
(53, 'Cumin seeds/jeera', 'SpicseandNuts', 'gms', 1, 200, 0, 200, '2017-09-06 09:05:37', NULL, 0),
(54, 'Pepper', 'SpicseandNuts', 'gms', 1, 500, 0, 500, '2017-09-01 09:27:34', NULL, 0),
(55, 'Mustard seeds', 'SpicseandNuts', 'gms', 1, 0, 0, 0, NULL, NULL, 0),
(56, 'Dates', 'SpicseandNuts', 'gms', 1, 1002, 0, 1200, '2017-09-04 02:35:14', NULL, 0),
(57, 'Medicines/bandages', 'Miscelleneous', 'Nos', 1, 500, 0, 522, '2017-09-05 12:26:46', NULL, 0),
(58, 'Light bulbs', 'Miscelleneous', 'Nos', 1, 10, 5, 19, '2017-09-02 11:29:59', '2017-09-02', 0),
(59, 'Batteries', 'Miscelleneous', 'Nos', 1, 1, 13, 27, '2017-09-07 02:14:18', '2017-09-08', 0),
(60, 'Candles', 'Miscelleneous', 'Nos', 1, 48, 0, 82, '2017-09-05 02:51:03', NULL, 0),
(61, 'Snacks', 'Miscelleneous', 'Nos', 1, 6, 0, 6, '2017-09-07 06:10:46', NULL, 0),
(62, 'Gas', 'Miscelleneous', 'Cylinder(s)', 1, 3, 1, 6, '2017-09-05 12:29:52', '2017-09-05', 0);

-- --------------------------------------------------------

--
-- Table structure for table `meals_subscription`
--

CREATE TABLE `meals_subscription` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(12) NOT NULL,
  `token` varchar(22) DEFAULT NULL,
  `from_month` varchar(10) NOT NULL,
  `from_year` varchar(10) NOT NULL,
  `to_month` varchar(10) NOT NULL,
  `to_year` varchar(10) NOT NULL,
  `utype` varchar(8) NOT NULL,
  `meals_type` varchar(8) NOT NULL,
  `subscription_type` int(10) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `mstatus` varchar(20) NOT NULL DEFAULT 'pending',
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meals_subscription`
--

INSERT INTO `meals_subscription` (`id`, `reg_no`, `token`, `from_month`, `from_year`, `to_month`, `to_year`, `utype`, `meals_type`, `subscription_type`, `reason`, `mstatus`, `insert_date`) VALUES
(7, 'RECMECH001', 'RECMECH001-01-2-stf-7', '01', '2017', '2', '2017', 'stf', 'non-veg', 2, '', 'accepted', '2017-09-13 16:10:12'),
(15, 'rec507', NULL, '01', '2017', '4', '2017', 'std', 'Lunch', 4, '', 'accepted', '2017-09-13 16:10:12'),
(16, 'rec0091', 'rec0091-03-6-stf-16', '03', '2017', '6', '2017', 'stf', 'Lunch', 4, '', 'accepted', '2017-09-13 16:10:12'),
(17, '125CSE895', '125CSE895-01-3-std-17', '01', '2017', '3', '2017', 'std', 'Lunch', 3, '', 'accepted', '2017-09-13 16:14:07'),
(18, 'rec034', NULL, '12', '2017', '4', '2018', 'std', 'Lunch', 5, '', 'closed', '2017-09-13 16:15:53'),
(19, '125CSE895', '125CSE895-01-3-std-19', '01', '2017', '3', '2017', 'std', 'Lunch', 3, '', 'accepted', '2017-09-13 16:54:48'),
(20, 'rec034', NULL, '01', '2017', '4', '2017', 'std', 'Lunch', 4, '', 'accepted', '2017-09-13 17:56:55'),
(21, 'RECEEE01', 'xyz123-04-7-stf-21', '04', '2017', '7', '2017', 'stf', 'Lunch', 4, '', 'accepted', '2017-09-14 09:16:26'),
(22, 'rec0038', NULL, '12', '2017', '3', '2018', 'stf', 'Lunch', 4, '', 'accepted', '2017-09-14 10:28:41'),
(24, 'rec0044', 'rec0044-01-2-stf-24', '01', '2017', '2', '2017', 'stf', 'lunch', 2, '', 'accepted', '2017-09-14 18:21:55'),
(31, 'rec0045', 'rec0045-01-2-stf-31', '01', '2017', '2', '2017', 'stf', 'lunch', 2, 'due o heavy rush', 'accepted', '2017-09-15 10:27:29'),
(33, 'RECECE22', NULL, '02', '2017', '4', '2017', 'std', 'lunch', 3, '', 'accepted', '2017-09-15 11:55:58'),
(35, 'RECECE4ACR', 'RECECE4ACR-01-4-std-35', '01', '2017', '4', '2017', 'std', 'lunch', 4, '', 'accepted', '2017-09-15 12:52:52'),
(36, 'RECECE4ACR', 'RECECE4ACR-01-4-std-35', '11', '2018', '12', '2018', 'std', 'lunch', 4, '', 'accepted', '2017-09-15 12:52:52');

-- --------------------------------------------------------

--
-- Table structure for table `menu_list`
--

CREATE TABLE `menu_list` (
  `id` int(10) NOT NULL,
  `mday` varchar(20) NOT NULL,
  `breakfast` varchar(50) NOT NULL,
  `lunch` varchar(100) NOT NULL,
  `snacks` varchar(50) NOT NULL,
  `dinner` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_list`
--

INSERT INTO `menu_list` (`id`, `mday`, `breakfast`, `lunch`, `snacks`, `dinner`) VALUES
(1, 'Sunday', 'idly and onion dosa', 'Tindoora fry,rice,dal,sambar', 'biscuits & bajji', 'curd rice'),
(2, 'Monday', 'puri and dosa', 'potato fry,sambar,rice,chutney', 'samosa ,tea', 'curd rice ,sambar rice & fry'),
(3, 'Tuesday', ' upma  and bajji', 'tomato dal, brinjal curry,sambar,rice', 'bajji and groundnuts', 'curd rice and chapathi'),
(6, 'wednesday', 'vada and pongal', 'fry.tomato pappu, and sambar', 'samosa', 'curd rice and  potato fry'),
(7, 'Thursday', ' dosa and idly', 'lady''s finger curry,sambar,rice  and curd', 'mirchi bajji and tea', 'Fried rice'),
(8, 'Friday', 'pesarattu dosa and upma', 'carrot curry,sambar,mango pappu and rice', 'biscuits and milk', 'curd rice and chapathi'),
(9, 'Saturday', 'pesarattu', 'rice, sambar', 'samosa', 'rice, veg biryani');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `pid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `pdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `quantity` int(8) NOT NULL,
  `units` varchar(10) NOT NULL,
  `purchaser` int(16) DEFAULT NULL,
  `status` tinyint(2) NOT NULL COMMENT '0-inactive, 1-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`pid`, `mid`, `item`, `pdate`, `quantity`, `units`, `purchaser`, `status`) VALUES
(9, 14, 'green peas', '2017-08-24 04:18:55', 56, 'kgs', NULL, 0),
(10, 5, 'bringals', '2017-08-24 04:18:55', 36, 'kgs', NULL, 0),
(11, 6, 'dall', '2017-08-24 04:18:55', 21, 'kgs', NULL, 0),
(12, 0, 'test', '2017-08-24 04:18:55', 2, 'kgs', NULL, 0),
(13, 5, 'bringals', '2017-08-24 04:41:11', 0, 'kgs', NULL, 0),
(14, 6, 'dall', '2017-08-24 04:41:11', 0, 'kgs', NULL, 0),
(15, 14, 'green peas', '2017-08-24 04:41:11', 0, 'kgs', NULL, 0),
(16, 2, 'Oil', '2017-08-24 04:41:11', 0, 'ltrs', NULL, 0),
(18, 5, 'bringals', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(19, 6, 'dall', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(20, 14, 'green peas', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(21, 2, 'Oil', '2017-08-24 04:41:12', 0, 'ltrs', NULL, 0),
(24, 5, 'bringals', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(25, 6, 'dall', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(26, 14, 'green peas', '2017-08-24 04:41:12', 0, 'kgs', NULL, 0),
(27, 2, 'Oil', '2017-08-24 04:41:12', 0, 'ltrs', NULL, 0),
(31, 5, 'bringals', '2017-08-24 04:46:53', 0, 'kgs', NULL, 0),
(32, 6, 'dall', '2017-08-24 04:46:53', 0, 'kgs', NULL, 0),
(33, 14, 'green peas', '2017-08-24 04:46:53', 0, 'kgs', NULL, 0),
(35, 5, 'bringals', '2017-08-24 06:49:56', 12, 'kgs', NULL, 0),
(36, 6, 'dall', '2017-08-24 06:49:56', 44, 'kgs', NULL, 0),
(37, 5, 'bringals', '2017-08-24 06:55:18', 15, 'kgs', NULL, 0),
(38, 6, 'dall', '2017-08-28 06:46:56', 16, 'kgs', NULL, 1),
(39, 14, 'green peas', '2017-08-28 06:46:56', 17, 'kgs', NULL, 1),
(40, 5, 'bringals', '2017-08-28 06:46:56', 12, 'kgs', NULL, 1),
(41, 0, 'salt', '2017-08-24 06:58:28', 12, 'kgs', NULL, 0),
(42, 24, 'garlic', '2017-08-28 02:33:33', 15, 'kgs', NULL, 0),
(43, 23, 'ginger', '2017-08-28 02:33:33', 15, 'kgs', NULL, 0),
(44, 14, 'green peas', '2017-08-28 02:33:33', 15, 'kgs', NULL, 0),
(45, 18, 'curd', '2017-08-28 06:43:27', 1, 'litres', NULL, 1),
(46, 6, 'dall', '2017-08-28 06:43:26', 2, 'kgs', NULL, 1),
(47, 18, 'curd', '2017-08-28 06:57:11', 2, 'litres', NULL, 0),
(48, 6, 'dall', '2017-08-28 06:57:11', 1, 'kgs', NULL, 0),
(49, 24, 'garlic', '2017-08-28 07:00:56', 4, 'kgs', NULL, 0),
(50, 23, 'ginger', '2017-08-28 07:00:56', 2, 'kgs', NULL, 0),
(51, 24, 'garlic', '2017-08-28 07:02:05', 2, 'kgs', NULL, 0),
(52, 23, 'ginger', '2017-08-28 07:02:05', 5, 'kgs', NULL, 0),
(53, 24, 'garlic', '2017-08-28 07:10:37', 6, 'kgs', NULL, 0),
(54, 23, 'ginger', '2017-08-28 07:10:37', 5, 'kgs', NULL, 0),
(55, 24, 'garlic', '2017-08-28 07:11:24', 9, 'kgs', NULL, 0),
(56, 23, 'ginger', '2017-08-28 07:11:24', 3, 'kgs', NULL, 0),
(57, 23, 'ginger', '2017-08-28 07:13:20', 21, 'kgs', NULL, 0),
(58, 14, 'green peas', '2017-08-28 07:13:20', 1, 'kgs', NULL, 0),
(59, 16, 'milk', '2017-08-28 07:14:01', 2, 'litres', NULL, 0),
(60, 6, 'dall', '2017-08-28 07:14:56', 33, 'kgs', NULL, 0),
(61, 2, 'Oil', '2017-08-28 07:15:55', 3, 'ltrs', NULL, 0),
(62, 23, 'ginger', '2017-08-28 07:16:22', 2, 'kgs', NULL, 0),
(63, 14, 'green peas', '2017-08-28 07:16:50', 5, 'kgs', NULL, 0),
(64, 26, 'idly', '2017-08-28 07:16:50', 3, 'kgs', NULL, 0),
(65, 16, 'milk', '2017-08-28 07:16:50', 5, 'litres', NULL, 0),
(66, 16, 'milk', '2017-08-31 00:28:50', 21, 'litres', 2, 1),
(67, 2, 'Oil', '2017-08-31 00:28:15', 1, 'ltrs', 3, 0),
(68, 49, 'Black or white sesame seeds', '2017-08-31 00:28:12', 5, 'gms', 3, 0),
(69, 61, 'Snacks', '2017-08-31 04:05:18', 10, '', 1, 1),
(70, 43, 'Instant coffee powder', '2017-08-31 04:08:31', 1, 'kgs', NULL, 0),
(71, 60, 'Candles', '2017-08-31 04:08:31', 20, '', NULL, 0),
(72, 56, 'Dates', '2017-08-31 04:08:31', 2000, 'gms', NULL, 0),
(73, 62, 'Gas', '2017-08-31 04:08:31', 2, '', NULL, 0),
(74, 19, 'Round urad dal', '2017-08-31 04:08:31', 2, 'kgs', NULL, 0),
(75, 48, 'Ghee or butter', '2017-09-07 04:09:01', 1, 'kgs', 2, 1),
(76, 47, 'Coconut oil', '2017-09-07 04:09:01', 3, 'ltrs', 2, 1),
(77, 61, 'Snacks', '2017-09-07 04:09:01', 1, '', 2, 1),
(78, 16, 'Rava or Chiroti rava', '2017-09-01 23:52:44', 5, 'litres', 2, 0),
(79, 27, 'Rajma,peas,brown/white chana,green gram', '2017-09-01 23:52:44', 3, 'kgs', 2, 0),
(80, 40, 'Chat masala powder', '2017-09-01 23:52:44', 2, 'kgs', 2, 0),
(81, 38, 'Dhania powder', '2017-09-01 23:52:44', 4, 'kgs', 2, 0),
(82, 16, 'Rava or Chiroti rava', '2017-09-07 04:08:42', 1, 'kgs', 2, 0),
(83, 41, 'Biryani masala powder', '2017-09-07 04:08:42', 1, 'kgs', 2, 0),
(84, 16, 'Rava or Chiroti rava', '2017-09-07 04:56:01', 20, 'kgs', 5, 1),
(85, 41, 'Biryani masala powder', '2017-09-07 04:56:01', 2, 'kgs', 5, 1),
(86, 39, 'Garam masala powder', '2017-09-07 04:56:01', 1, 'kgs', 5, 1),
(87, 55, 'Mustard seeds', '2017-09-07 04:56:01', 100, 'gms', 5, 1),
(88, 13, 'Ragi flour', '2017-09-07 04:56:01', 1, 'kgs', 5, 1),
(89, 62, 'Gas', '2017-09-07 04:56:01', 1, 'Cylinder(s', 5, 1),
(90, 47, 'Coconut oil', '2017-09-07 04:56:01', 40, 'ltrs', 5, 1),
(93, 2, 'Sugar', '2017-09-07 04:56:42', 295, 'kgs', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `purchasers_list`
--

CREATE TABLE `purchasers_list` (
  `id` int(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `location` varchar(30) NOT NULL,
  `mobile_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchasers_list`
--

INSERT INTO `purchasers_list` (`id`, `name`, `location`, `mobile_no`) VALUES
(1, 'raju', 'visakhapatnam', '8988562314'),
(2, 'ramu', 'tagarpuvalasa', '9848829185'),
(3, 'uday', 'vizianagram', '8785864523'),
(4, 'Bhaskar', 'maharani pet', '9858565634'),
(5, 'poorna', 'vizag', '9191919191');

-- --------------------------------------------------------

--
-- Table structure for table `stock_register`
--

CREATE TABLE `stock_register` (
  `srid` int(50) NOT NULL,
  `reg_no` varchar(16) NOT NULL,
  `item` varchar(11) NOT NULL,
  `brand` varchar(32) DEFAULT NULL,
  `quantity` int(10) NOT NULL,
  `discount` int(8) NOT NULL,
  `price` float(10,2) NOT NULL,
  `receipt_no` varchar(16) NOT NULL,
  `edate` datetime NOT NULL,
  `slot_type` varchar(10) NOT NULL,
  `from_to` varchar(32) DEFAULT NULL,
  `trans_type` varchar(3) NOT NULL COMMENT 'IN, OUT',
  `insert_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `balance` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_register`
--

INSERT INTO `stock_register` (`srid`, `reg_no`, `item`, `brand`, `quantity`, `discount`, `price`, `receipt_no`, `edate`, `slot_type`, `from_to`, `trans_type`, `insert_dt`, `balance`) VALUES
(1, '', '1', 'ATA', 15, 10, 500.00, '', '2017-09-01 00:00:00', '', '', 'IN', '2017-08-08 10:54:06', 0),
(2, 'admin', '19', 'tata', 2, 15, 200.00, '23', '2017-09-02 00:00:00', '', '1', 'IN', '2017-09-04 14:35:14', 17),
(3, 'admin', '56', 'lion', 1000, 10, 180.00, '23', '2017-09-02 00:00:00', '', '1', 'IN', '2017-09-04 14:35:15', 1200),
(4, 'admin', '7', 'sdf', 30, 250, 2500.00, '653', '2017-09-03 00:00:00', '', '2', 'IN', '2017-09-04 15:34:00', 58),
(5, 'admin', '23', 'ATA', 2, 0, 350.00, '', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-04 16:03:58', 12),
(6, 'admin', '47', 'Parachute', 10, 0, 780.00, '324', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-04 16:06:55', 16),
(7, 'admin', '2', 'ata', 20, 0, 1800.00, '11536', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-04 16:19:33', 60),
(8, 'admin', '19', 'TATA', 15, 0, 1500.00, '11536', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-04 16:19:33', 32),
(9, 'admin', '4', 'Sunflower', 20, 0, 1100.00, '11536', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-04 16:19:33', 75),
(10, 'admin', '7', '2', 2, 0, 121.00, '14', '2017-09-04 00:00:00', '', '1', 'IN', '2017-09-04 16:47:57', 60),
(11, 'admin', '42', 'Nescaffe', 1, 0, 480.00, '', '2017-09-04 00:00:00', '', '1', 'IN', '2017-09-04 17:05:03', 1),
(12, 'admin', '26', 'utc', 15, 0, 530.00, '9', '2017-09-04 00:00:00', '', '1', 'IN', '2017-09-04 18:18:25', 25),
(13, 'admin', '50', 'ITC', 500, 0, 420.00, '', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 08:11:42', 500),
(14, 'admin', '50', NULL, 200, 0, 0.00, '', '2017-09-04 00:00:00', 'Breakfast', 'Boys Mess', 'Out', '2017-09-05 08:14:23', 300),
(15, 'admin', '19', 'LIMA', 10, 0, 630.00, '', '2017-09-04 00:00:00', '', '3', 'IN', '2017-09-05 08:19:09', 42),
(16, 'admin', '19', 'Aditi', 12, 0, 250.00, '963', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 08:23:41', 54),
(17, 'admin', '62', 'hp', 1, 0, 530.00, '1965', '2017-09-04 00:00:00', '', '1', 'IN', '2017-09-05 08:32:59', 4),
(18, 'admin', '59', 'Nippo', 20, 0, 300.00, '785RE', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 08:36:50', 30),
(19, 'admin', '41', 'Organic', 1, 0, 300.00, 'T56Y', '2017-09-04 00:00:00', '', '1', 'IN', '2017-09-05 08:41:14', 2),
(20, 'admin', '45', 'Palm', 20, 0, 480.00, '', '2017-09-04 00:00:00', '', '4', 'IN', '2017-09-05 08:52:27', 69),
(21, 'admin', '12', 'ATA', 10, 0, 280.00, '', '2017-09-04 00:00:00', '', '4', 'IN', '2017-09-05 08:52:27', 20),
(22, 'admin', '60', 'KISAN', 24, 0, 240.00, '', '2017-09-04 00:00:00', '', '4', 'IN', '2017-09-05 08:52:27', 34),
(23, 'admin', '24', 'ITC', 5, 60, 200.00, '', '2017-09-04 00:00:00', '', '4', 'IN', '2017-09-05 08:52:27', 5),
(24, 'admin', '42', 'ITC', 2, 60, 280.00, '2463', '2017-09-04 00:00:00', '', '4', 'IN', '2017-09-05 09:12:42', 3),
(25, 'admin', '45', 'Sunflower', 10, 0, 800.00, '1256', '2017-09-04 00:00:00', '', '3', 'IN', '2017-09-05 09:35:55', 79),
(26, 'admin', '19', 'star', 1, 0, 160.00, '1269', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 09:41:31', 55),
(27, 'admin', '48', 'durga', 2, 0, 460.00, '4356', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 09:45:12', 2),
(28, 'admin', '4', 'ds', 2, 0, 360.00, '', '2017-09-05 00:00:00', '', '1', 'IN', '2017-09-05 10:44:59', 77),
(29, 'admin', '7', 'bell', 50, 200, 3800.00, '', '2017-09-05 00:00:00', '', '1', 'IN', '2017-09-05 12:25:36', 110),
(30, 'admin', '18', 'ata', 20, 0, 2000.00, '', '2017-09-05 00:00:00', '', '1', 'IN', '2017-09-05 12:25:36', 49),
(31, 'admin', '57', 'REDDYS', 500, 500, 8000.00, '', '2017-09-05 00:00:00', '', '2', 'IN', '2017-09-05 12:26:46', 522),
(32, 'admin', '62', 'tata', 3, 0, 2400.00, '', '2017-09-05 00:00:00', '', '1', 'IN', '2017-09-05 12:29:52', 7),
(33, 'admin', '62', NULL, 1, 0, 0.00, '', '2017-09-04 00:00:00', 'Lunch', 'Boys Mess', 'Out', '2017-09-05 13:51:44', 6),
(34, 'admin', '40', '2234', 5, 0, 460.00, '', '2017-09-04 00:00:00', '', '2', 'IN', '2017-09-05 14:30:30', 5),
(38, 'admin', '19', 'wer', 3, 0, 350.00, '', '2017-09-05 00:00:00', '', '2', 'IN', '2017-09-05 15:01:59', 58),
(39, 'admin', '53', 'meghana', 200, 0, 420.00, '', '2017-09-05 00:00:00', '', '3', 'IN', '2017-09-06 09:05:37', 200),
(41, 'admin', '4', 'ATA', 20, 0, 1500.00, '', '2017-09-05 00:00:00', '', '1', 'IN', '2017-09-06 09:09:21', 97),
(42, 'admin', '6', 'Lalitha', 25, 0, 1250.00, '', '2017-09-06 00:00:00', '', '2', 'IN', '2017-09-06 09:18:12', 59),
(43, 'admin', '14', 'ITC', 10, 50, 650.00, '136', '2017-09-06 10:05:20', '', '2', 'IN', '2017-09-07 10:05:20', 10),
(44, 'admin', '59', 'nippo', 12, 0, 150.00, '', '2017-09-06 10:10:58', '', '2', 'IN', '2017-09-07 10:10:58', 52),
(47, 'admin', '7', 'itc', 25, 350, 1500.00, '', '2017-09-06 10:36:36', '', '1', 'IN', '2017-09-07 10:36:37', 135),
(48, 'admin', '4', 'itc', 25, 0, 1500.00, '', '2017-09-06 10:36:36', '', '1', 'IN', '2017-09-07 10:36:37', 122),
(49, 'admin', '7', 'itc', 1, 10, 150.00, '', '2017-09-06 10:38:25', '', '1', 'IN', '2017-09-07 10:38:25', 136),
(50, 'admin', '59', 'fdg', 4, 140, 1200.00, '', '2017-09-06 10:59:18', '', '1', 'IN', '2017-09-07 10:59:18', 56),
(51, 'admin', '7', 'bell', 1, 12, 15.00, '1453', '2017-09-06 11:55:06', '', '2', 'IN', '2017-09-07 11:55:06', 137),
(52, 'admin', '19', 'nippo', 3, 100, 100.00, '', '2017-09-06 12:40:00', '', '3', 'IN', '2017-09-07 12:40:00', 61),
(53, 'admin', '59', 'nippo', 1, 1, 10.00, '', '2017-09-06 02:14:18', '', '2', 'IN', '2017-09-07 14:14:18', 57),
(54, 'admin', '2', 'TATA', 45, 200, 1800.00, '123', '2017-09-06 03:38:42', '', '1', 'IN', '2017-09-07 15:38:42', 105),
(55, 'admin', '2', NULL, 100, 0, 0.00, '', '2017-09-06 03:41:13', 'Breakfast', 'Boys Mess', 'Out', '2017-09-07 15:41:13', 5),
(56, 'admin', '59', NULL, 20, 0, 0.00, '', '2017-09-06 03:41:13', 'Breakfast', 'Boys Mess', 'Out', '2017-09-07 15:41:14', 37),
(57, 'admin', '26', NULL, 20, 0, 0.00, '', '2017-09-06 03:41:13', 'Breakfast', 'Boys Mess', 'Out', '2017-09-07 15:41:14', 5),
(58, 'admin', '40', 'temp', 1, 10, 350.00, '1212', '2017-09-06 05:07:25', '', '1', 'IN', '2017-09-07 17:07:25', 6),
(59, 'admin', '4', 'ata', 1, 10, 120.00, '121', '2017-09-06 05:07:57', '', '2', 'IN', '2017-09-07 17:07:57', 123),
(60, 'admin', '3', 'tea', 1, 12, 120.00, '12', '2017-09-06 05:08:53', '', '1', 'IN', '2017-09-07 17:08:53', 57),
(61, 'admin', '7', 'bell', 1, 0, 1000.00, '1213', '2017-09-06 05:49:29', '', '1', 'IN', '2017-09-07 17:49:29', 138),
(62, 'admin', '7', 'bell', 25, 0, 1000.00, '323', '2017-09-06 05:54:05', '', '1', 'IN', '2017-09-07 17:54:05', 163),
(63, 'admin', '12', 'ata', 1, 0, 60.00, '235', '2017-09-06 05:56:16', '', '2', 'IN', '2017-09-07 17:56:16', 21),
(64, 'admin', '3', 'ATA', 2, 0, 230.00, '124', '2017-09-06 06:00:26', '', '1', 'IN', '2017-09-07 18:00:27', 59),
(65, 'admin', '19', 'Tar', 2, 0, 250.00, '5632', '2017-09-06 06:03:14', '', '1', 'IN', '2017-09-07 18:03:14', 63),
(66, 'admin', '61', '', 6, 0, 120.00, '1255', '2017-09-06 06:10:46', '', '2', 'IN', '2017-09-07 18:10:46', 6),
(67, 'admin', '24', 'Rty', 1, 0, 50.00, '43567', '2017-09-06 06:14:34', '', '2', 'IN', '2017-09-07 18:14:34', 6),
(68, 'admin', '47', 'parachut', 1, 0, 230.00, '7878', '2017-09-06 06:15:11', '', '2', 'IN', '2017-09-07 18:15:11', 17),
(69, 'admin', '47', 'parachut', 1, 0, 230.00, '1278', '2017-09-06 06:16:38', '', '2', 'IN', '2017-09-07 18:16:38', 18),
(70, 'admin', '8', 'Ashrwad', 1, 5, 115.00, '5689', '2017-09-06 06:17:44', '', '2', 'IN', '2017-09-07 18:17:44', 11),
(71, 'admin', '2', NULL, 2, 0, 0.00, '', '2017-09-06 09:09:13', 'Breakfast', 'Boys Mess', 'Out', '2017-09-08 09:09:13', 3),
(72, 'admin', '38', NULL, 2, 0, 0.00, '', '2017-09-06 09:09:13', 'Breakfast', 'Boys Mess', 'Out', '2017-09-08 09:09:13', 0),
(73, 'admin', '3', NULL, 3, 0, 0.00, '', '2017-09-07 09:15:06', 'Lunch', 'Boys Mess', 'Out', '2017-09-08 09:15:06', 56),
(74, 'admin', '59', NULL, 10, 0, 0.00, '', '2017-09-07 09:15:06', 'Lunch', 'Boys Mess', 'Out', '2017-09-08 09:15:06', 27);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_type` (`item_type`);

--
-- Indexes for table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `meals_subscription`
--
ALTER TABLE `meals_subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_list`
--
ALTER TABLE `menu_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `purchasers_list`
--
ALTER TABLE `purchasers_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_register`
--
ALTER TABLE `stock_register`
  ADD PRIMARY KEY (`srid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `discount`
--
ALTER TABLE `discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `material`
--
ALTER TABLE `material`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `meals_subscription`
--
ALTER TABLE `meals_subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `menu_list`
--
ALTER TABLE `menu_list`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `purchasers_list`
--
ALTER TABLE `purchasers_list`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `stock_register`
--
ALTER TABLE `stock_register`
  MODIFY `srid` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
