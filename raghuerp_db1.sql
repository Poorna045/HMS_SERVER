-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 24, 2017 at 02:24 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raghuerp_db1`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `reg_no` varchar(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `dp` varchar(30) NOT NULL,
  `role` varchar(20) NOT NULL COMMENT 'admin, management',
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `reg_no`, `name`, `email`, `mobile`, `dp`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 'admin@raghueducational.org', '8500373704', 'admin.jpg', 'admin', 1, '2017-06-13 02:00:00', '2017-07-17 04:09:26');

--
-- Triggers `admins`
--
DELIMITER $$
CREATE TRIGGER `update_admins_timestamp` BEFORE UPDATE ON `admins` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `branch` varchar(15) NOT NULL,
  `course` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch`, `course`, `fullname`, `status`) VALUES
(1, 'CAD/CAM', 2, 'Computer Aided Design', 1),
(2, 'CIVIL', 1, 'Civil Engineering', 1),
(3, 'CIVIL ', 4, 'Civil Engineering', 1),
(4, 'CSE', 1, 'Computer Science and Engineering', 1),
(5, 'CSE', 4, 'Computer Science and Engineering College', 1),
(6, 'CSE', 2, 'Computer Science and Engineering', 1),
(7, 'CSE', 3, 'Computer Science and Engineering', 1),
(8, 'ECE', 1, 'Electronics and Communication Engineering', 1),
(9, 'ECE', 4, 'Electronics and Communication Engineering', 1),
(10, 'EEE', 1, 'Electrical and Electronical Engineering', 1),
(11, 'EEE', 4, 'Electrical and Electronical Engineering', 1),
(12, 'Embd Sys & VLSI', 3, 'Embedded System and Very-large-scale integration', 1),
(13, 'Embd.Sys', 2, 'Embedded Systems', 1),
(14, 'M.D', 3, 'Machine Design', 1),
(15, 'MECH', 1, 'Mechanical Engineering', 1),
(16, 'MECH', 4, 'Mechanical Engineering', 1),
(17, 'P.E', 2, 'Power Electronics', 1),
(18, 'P.E', 3, 'Power Electronics', 1),
(19, 'S.E', 2, 'Software Engineering', 1);

-- --------------------------------------------------------

--
-- Table structure for table `certificate_ctype`
--

CREATE TABLE `certificate_ctype` (
  `cname` varchar(60) NOT NULL,
  `disporder` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `certificate_ctype`
--

INSERT INTO `certificate_ctype` (`cname`, `disporder`) VALUES
('Certification Course', 7),
('Diploma', 3),
('Graduation', 4),
('Intermediate', 2),
('Ph.D.', 6),
('Post Graduation', 5),
('SSC', 1);

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `id` int(11) NOT NULL,
  `college` varchar(5) NOT NULL,
  `full_name` varchar(30) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`id`, `college`, `full_name`, `status`) VALUES
(1, 'REC', 'Raghu Engineering College', 1),
(2, 'RIT', 'Raghu Institute of Technology', 1),
(3, 'RCP', 'Raghu College of Pharmacy', 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `course` varchar(10) NOT NULL,
  `college` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `course`, `college`, `fullname`, `status`) VALUES
(1, 'B.Tech', 1, 'Bachelor of Technology', 1),
(2, 'M.Tech', 1, 'Master of Technology', 1),
(3, 'M.Tech', 2, 'Master of Technology', 1),
(4, 'B.Tech', 2, 'B.Tech', 1);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `department` varchar(10) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `college` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `department`, `full_name`, `college`, `status`) VALUES
(1, 'CIVIL', 'Civil Engineering', 1, 1),
(2, 'CIVIL', 'Civil Engineering', 2, 1),
(3, 'CSE', 'Computer Science and Engineering', 1, 1),
(4, 'CSE', 'Computer Science and Engineering', 2, 1),
(5, 'ECE', 'Electronics and Communication Engineering', 1, 1),
(6, 'ECE', 'Electronics and Communication Engineering', 2, 1),
(7, 'EEE', 'Electrical and Electronics Engineering', 1, 1),
(8, 'EEE', 'Electrical and Electronics Engineering', 2, 1),
(9, 'MECH', 'Mechanical Engineering', 1, 1),
(10, 'MECH', 'Mechanical Engineering', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `designation` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`designation`, `status`) VALUES
('Assistant Professor', 1),
('Associate Professor', 1),
('Office Assistant', 1),
('Principal', 1),
('Professor', 1),
('System Administrator', 1),
('Technician', 1);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2017_06_12_104039_create_personal_data_table', 1),
(4, '2017_06_13_051023_create_admins_table', 1),
(5, '2017_06_13_051146_create_staff_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` int(11) NOT NULL,
  `section` varchar(8) NOT NULL,
  `year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `section`, `year`) VALUES
(1, 'A', 3),
(2, 'A', 4),
(3, 'A', 5),
(4, 'A', 6),
(5, 'A', 7),
(6, 'A', 8),
(7, 'A', 9),
(8, 'A', 10),
(9, 'A', 11),
(10, 'A', 12),
(11, 'A', 13),
(12, 'A', 14),
(13, 'A', 15),
(14, 'A', 16),
(15, 'A', 17),
(16, 'A', 18),
(17, 'A', 23),
(18, 'A', 24),
(19, 'A', 25),
(20, 'A', 26),
(21, 'A', 27),
(22, 'A', 28),
(23, 'A', 29),
(24, 'A', 30),
(25, 'A', 31),
(26, 'A', 32),
(27, 'A', 33),
(28, 'A', 34),
(29, 'A', 35),
(30, 'A', 36),
(31, 'A', 37),
(32, 'A', 38),
(33, 'A', 45),
(34, 'A', 46),
(35, 'A', 47),
(36, 'A', 48),
(37, 'A', 49),
(38, 'A', 50),
(39, 'A', 51),
(40, 'A', 52),
(41, 'B', 3),
(42, 'B', 4),
(43, 'B', 5),
(44, 'B', 6),
(45, 'B', 7),
(46, 'B', 8),
(47, 'B', 9),
(48, 'B', 10),
(49, 'B', 11),
(50, 'B', 12),
(51, 'B', 13),
(52, 'B', 14),
(53, 'B', 15),
(54, 'B', 16),
(55, 'B', 17),
(56, 'B', 18),
(57, 'B', 23),
(58, 'B', 24),
(59, 'B', 25),
(60, 'B', 26),
(61, 'B', 27),
(62, 'B', 28),
(63, 'B', 29),
(64, 'B', 30),
(65, 'B', 31),
(66, 'B', 32),
(67, 'B', 33),
(68, 'B', 34),
(69, 'B', 35),
(70, 'B', 36),
(71, 'B', 37),
(72, 'B', 38),
(73, 'B', 45),
(74, 'B', 46),
(75, 'B', 47),
(76, 'B', 48),
(77, 'B', 49),
(78, 'B', 50),
(79, 'B', 51),
(80, 'B', 52),
(81, 'A', 1),
(82, 'A', 2),
(83, 'A', 19),
(84, 'A', 20),
(85, 'A', 21),
(86, 'A', 22),
(87, 'A', 39),
(88, 'A', 40),
(89, 'A', 41),
(90, 'A', 42),
(91, 'A', 43),
(92, 'A', 44),
(93, 'A', 53),
(94, 'A', 54),
(95, 'A', 55),
(96, 'A', 56),
(97, 'A', 57),
(98, 'A', 58);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `reg_no` varchar(12) NOT NULL,
  `title` varchar(10) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `dispname` varchar(15) DEFAULT NULL,
  `college` varchar(15) NOT NULL,
  `department` varchar(30) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `qualification` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `dp` varchar(30) DEFAULT NULL,
  `present_address` text,
  `permanent_address` text,
  `employment_type` varchar(20) NOT NULL,
  `pan` varchar(20) DEFAULT NULL,
  `pan_file` varchar(30) NOT NULL,
  `aadhar` varchar(20) DEFAULT NULL,
  `aadhar_file` varchar(30) DEFAULT NULL,
  `passport` varchar(25) DEFAULT NULL,
  `passport_file` varchar(30) NOT NULL,
  `dateob` date DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `placeob` varchar(255) DEFAULT NULL,
  `stateob` varchar(50) DEFAULT NULL,
  `countryob` varchar(50) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `caste` varchar(30) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `reg_no`, `title`, `firstname`, `lastname`, `dispname`, `college`, `department`, `designation`, `qualification`, `email`, `mobile`, `dp`, `present_address`, `permanent_address`, `employment_type`, `pan`, `pan_file`, `aadhar`, `aadhar_file`, `passport`, `passport_file`, `dateob`, `doj`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'RECMECH001', 'Mr.', 'Nikhil', 'Kumar', NULL, '1', '9', 'Associate Professor', 'M.Tech', 'i.nikhil@akrivia.in', '9866898768', 'RECMECH001_dp.png', 'City Office', 'College', 'Permanent', 'ABDFGT45RE', 'RECMECH001_pan.jpg', '1234 5678 9012', 'RECMECH001_aadhar.jpg', 'ASDF67VSKP123', 'RECMECH001_passport.png', '1986-07-11', '2015-07-25', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 0, '2017-06-30 07:13:03', '2017-07-17 03:59:26'),
(2, 'RECCSE548', 'Mr.', 'Sravan', 'Kumar', NULL, '1', '3', 'System Administrator', 'B.Tech', 'system.admin@gmail.com', '9849197874', NULL, 'city office', 'vizianagaram', 'Permanent', NULL, '', NULL, '', NULL, '', NULL, '2015-05-15', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 0, '2017-06-30 10:58:30', '2017-07-14 11:50:31'),
(3, 'RECEEE01', 'Mr.', 'Sivarama rao', 'Ch', NULL, '1', '7', 'Associate Professor', 'M.E.', 'techlead.it@raghues.com', '9492534735', 'RECEEE01_dp.jpg', 'College', 'PM Palem', 'Permanent', NULL, '', NULL, '', NULL, '', '1980-07-02', '2017-07-03', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-07-03 03:48:14', '2017-07-14 11:50:58'),
(4, 'xyz123', 'mr.', 'apparo', 'aoj', 'testing', '1', '5', 'Principal', 'Ph.D.', 'testmail@test.com', '1234569879', NULL, NULL, NULL, '', NULL, '', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 0, '2017-07-07 07:15:40', '2017-07-14 11:51:01');

--
-- Triggers `staff`
--
DELIMITER $$
CREATE TRIGGER `create_users_data` AFTER INSERT ON `staff` FOR EACH ROW BEGIN
	INSERT INTO users (name,reg_no,password,utype) values (New.firstname,New.reg_no,md5(New.reg_no),'stf');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_staff_timestamp` BEFORE UPDATE ON `staff` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `staff_certificate`
--

CREATE TABLE `staff_certificate` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `course` varchar(50) NOT NULL,
  `board` varchar(50) NOT NULL,
  `passyear` varchar(10) NOT NULL,
  `grade` varchar(5) NOT NULL,
  `certificate` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(6) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dispname` varchar(15) NOT NULL,
  `reg_no` varchar(12) NOT NULL,
  `fathername` varchar(255) DEFAULT NULL,
  `mothername` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `dp` varchar(30) DEFAULT NULL,
  `present_address` text NOT NULL,
  `permanent_address` text,
  `aadhar` varchar(20) DEFAULT NULL,
  `dob` date NOT NULL,
  `college` int(11) NOT NULL,
  `course` int(11) NOT NULL,
  `branch` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `section` int(11) NOT NULL,
  `placeob` varchar(255) DEFAULT NULL,
  `stateob` varchar(255) DEFAULT NULL,
  `countryob` varchar(255) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `caste` varchar(30) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `firstname`, `lastname`, `dispname`, `reg_no`, `fathername`, `mothername`, `email`, `mobile`, `dp`, `present_address`, `permanent_address`, `aadhar`, `dob`, `college`, `course`, `branch`, `year`, `section`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CSE2YR', 'Kumar', 'Vinay', 'CSE2CR', '', '', 'cse_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 1, 1, 4, 12, 10, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-07-27 16:45:55'),
(3, 'CSE 1YR', 'A Sec', 'CSE_CR', 'CSE1CR', '', '', 'cse_cr_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 1, 1, 4, 11, 9, '', '', '', 'F', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-04 10:30:26'),
(5, 'ECE 2 YR A Sec.', 'A Sec', 'ECE_CR_2YR_A', 'RECECE2ACR', '', '', 'cse_cecefsdr_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 1, 1, 8, 24, 18, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:24'),
(6, 'ECE 4 YR A Sec.', 'A Sec', 'ECE_CR_4YR_A', 'RECECE4ACR', '', '', 'cse_cedfsadfsacefsdr_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 1, 1, 8, 26, 20, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:33'),
(7, 'ECE 3 YR A Sec.', 'A Sec', 'ECE_CR_3YR_A', 'RECECE3ACR', '', '', 'cse_cedfsadfsacefdfsadfsasdr_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 1, 1, 8, 25, 19, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:44'),
(8, 'RIT CSE 3A', 'A Sec', 'RIT CSE 3A', 'ritcse3a', '', '', 'cse_cedfsadfsadfscefdfsadfsasdr_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', 2, 4, 5, 17, 15, '', '', '', 'F', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-04 10:30:22'),
(9, 'karthik', 'A Sec', 'RIT CSE 3A', 'reccse001', '', '', 'karthik@raghuenggcollege.com', '9879875855', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-09', 2, 4, 5, 17, 15, '', '', '', 'F', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-04 10:30:22'),
(10, 'jogesh', 'A Sec', 'ECE_CR_4YR_A', 'recmech001', '', '', 'jogesh@raghuenggcollege.com', '9879875856', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-22', 1, 1, 8, 26, 20, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:33'),
(11, 'suresh', 'A Sec', 'ECE_CR_4YR_A', 'recmech002', '', '', 'suresh@raghuenggcollege.com', '9879875256', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-16', 1, 1, 8, 26, 20, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:33'),
(18, 'praveen', 'Kumar', 'Vinay', 'reccse002', '', '', 'cse_student54@raghuenggcollege.com', '9879175850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-08', 1, 1, 4, 12, 10, '', '', '', 'M', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-07-27 16:45:55'),
(19, 'shrija', 'A Sec', 'ECE_CR_4YR_A', 'reccse003', '', '', 'csestudent3@raghuenggcollege.com', '9779875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-08', 1, 1, 8, 26, 20, '', '', '', 'F', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-01 09:53:33'),
(20, 'susmitha', 'A Sec', 'RIT CSE 3A', 'ritmech003', '', '', 'cse_student4@raghuenggcollege.com', '9869875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-15', 2, 4, 5, 17, 15, '', '', '', 'F', '', '', '', 'cr', 1, '2017-06-15 00:00:00', '2017-08-04 10:30:22');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `update_students_timestamp` BEFORE UPDATE ON `students` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reg_no` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `utype` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `reg_no`, `password`, `utype`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', '50c2472801ba5f5158b71047563521ef', 'adm', '1234', '2017-06-13 02:00:00', '2017-07-13 08:46:01'),
(2, 'CseHod', 'RECCSE001', 'b1a5b64256e27fa5ae76d62b95209ab3', 'stf', '1235', '2017-06-14 12:29:29', '2017-06-14 12:29:29'),
(3, 'Vinay Kumar', '125CSE895', 'b1a5b64256e27fa5ae76d62b95209ab3', 'std', '1236', '2017-06-14 13:27:30', '2017-07-05 05:27:56'),
(11, 'Nikhil', 'RECMECH001', '50c2472801ba5f5158b71047563521ef', 'stf', NULL, NULL, '2017-07-13 08:28:46'),
(12, 'Sravan', 'RECCSE548', 'bd03b85c14862dbad8f4ea0ebf08c3a3', 'adm', NULL, NULL, '2017-07-05 09:02:31'),
(13, 'Sivarama rao', 'RECEEE01', 'd7792ea01be12978c51f26450979310f', 'adm', NULL, NULL, NULL),
(14, 'apparo', 'xyz123', '613d3b9c91e9445abaeca02f2342e5a6', 'stf', NULL, NULL, NULL);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `update_users_timestamp` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `year`
--

CREATE TABLE `year` (
  `id` int(11) NOT NULL,
  `year` varchar(8) NOT NULL,
  `branch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `year`
--

INSERT INTO `year` (`id`, `year`, `branch`) VALUES
(1, '1', 1),
(2, '2', 1),
(3, '1', 2),
(4, '2', 2),
(5, '3', 2),
(6, '4', 2),
(7, '1', 3),
(8, '2', 3),
(9, '3', 3),
(10, '4', 3),
(11, '1', 4),
(12, '2', 4),
(13, '3', 4),
(14, '4', 4),
(15, '1', 5),
(16, '2', 5),
(17, '3', 5),
(18, '4', 5),
(19, '1', 6),
(20, '2', 6),
(21, '1', 7),
(22, '2', 7),
(23, '1', 8),
(24, '2', 8),
(25, '3', 8),
(26, '4', 8),
(27, '1', 9),
(28, '2', 9),
(29, '3', 9),
(30, '4', 9),
(31, '1', 10),
(32, '2', 10),
(33, '3', 10),
(34, '4', 10),
(35, '1', 11),
(36, '2', 11),
(37, '3', 11),
(38, '4', 11),
(39, '1', 12),
(40, '2', 12),
(41, '1', 13),
(42, '2', 13),
(43, '1', 14),
(44, '2', 14),
(45, '1', 15),
(46, '2', 15),
(47, '3', 15),
(48, '4', 15),
(49, '1', 16),
(50, '2', 16),
(51, '3', 16),
(52, '4', 16),
(53, '1', 17),
(54, '2', 17),
(55, '1', 18),
(56, '2', 18),
(57, '1', 19),
(58, '2', 19);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`reg_no`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branch` (`branch`,`course`);

--
-- Indexes for table `certificate_ctype`
--
ALTER TABLE `certificate_ctype`
  ADD UNIQUE KEY `cname` (`cname`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `college` (`college`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department` (`department`,`college`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD UNIQUE KEY `designation` (`designation`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_empid_unique` (`reg_no`),
  ADD UNIQUE KEY `staff_mobile_unique` (`mobile`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `staff_certificate`
--
ALTER TABLE `staff_certificate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reg_no` (`reg_no`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`reg_no`);

--
-- Indexes for table `year`
--
ALTER TABLE `year`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `staff_certificate`
--
ALTER TABLE `staff_certificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `year`
--
ALTER TABLE `year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
