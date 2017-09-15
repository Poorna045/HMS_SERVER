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
-- Database: `raghuerp_dbnew`
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
-- Table structure for table `attended`
--

CREATE TABLE `attended` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `atinstitutionname` varchar(255) NOT NULL,
  `atinstitutionaddress` varchar(255) NOT NULL,
  `frominstitutionname` varchar(255) NOT NULL,
  `frominstitutionaddress` varchar(255) NOT NULL,
  `area_field` varchar(255) NOT NULL,
  `title_details` varchar(255) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attended`
--

INSERT INTO `attended` (`id`, `reg_no`, `atinstitutionname`, `atinstitutionaddress`, `frominstitutionname`, `frominstitutionaddress`, `area_field`, `title_details`, `duration`, `awards_remarks`, `certificate`) VALUES
(1, 'RECMECH001', 'dsfsaf', 'sdfasd', '123', '2313', '13123', '12312', '23123', '1', 'RECMECH001_dsfsaf_13123'),
(3, '13981A0507', 'RIT', 'vsk', 'REC', 'vsk', 'testing', 'testing tools are not enough', '2 weeks', '112', '13981A0507_RIT_testing.jpg.jpg.jpg');

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
(19, 'S.E', 2, 'Software Engineering', 1),
(20, 's/w', 5, 'S/w', 1);

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
('PostDoc', 8),
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
(3, 'RCP', 'Raghu College of Pharmacy', 1),
(4, 'RES', 'Raghu Engineering College(Akv)', 1);

-- --------------------------------------------------------

--
-- Table structure for table `consultancy_projects`
--

CREATE TABLE `consultancy_projects` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `frominstitutionname` varchar(255) NOT NULL,
  `frominstitutionaddress` varchar(255) NOT NULL,
  `area_field` varchar(255) NOT NULL,
  `title_details` varchar(255) NOT NULL,
  `value` float(10,2) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `teamsize` varchar(255) NOT NULL,
  `responsibilities` varchar(255) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL,
  `forinstitutionname` varchar(255) NOT NULL,
  `forinstitutionaddress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `consultancy_projects`
--

INSERT INTO `consultancy_projects` (`id`, `reg_no`, `frominstitutionname`, `frominstitutionaddress`, `area_field`, `title_details`, `value`, `duration`, `teamsize`, `responsibilities`, `awards_remarks`, `certificate`, `forinstitutionname`, `forinstitutionaddress`) VALUES
(4, 'RECMECH001', '12', '12', '12', '12', 12.00, '121', '2', '121', '122', 'RECMECH001_12_12.png.png', '12', '12'),
(6, 'RECMECH001', 'abcd', 'abcd', 'abcd', 'abcd', 0.00, 'abcd', 'abcd', 'abcd', 'abcd', 'RECMECH001_abcd_abcd.png', 'abcd', 'abcd'),
(7, '125CSE895', 'REC', 'visakhapatnam', 'facilities', 'lack of facilities', 210.00, '2 days', '10', 'manager', '2', '', 'RIT', 'visakhapatnam'),
(10, '13981A0507', 'REC', 'vsk', 'testing', 'testing tools are not sufficient', 254100.00, '1 month', '12', 'Manager', '1', '13981A0507_REC_testing.jpg', 'RIT', 'vsk'),
(11, '125CSE895', '123', '123', '312', '123', 123.00, '123', '123', '123', '7557', '', '123', '12');

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
(4, 'B.Tech', 2, 'B.Tech', 1),
(5, 'software', 4, 'S/W', 1);

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
(10, 'MECH', 'Mechanical Engineering', 2, 1),
(11, 'HNS', 'Human Science', 2, 1),
(12, 'sw', 'S/w', 4, 1);

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
('123', 0),
('456', 1),
('Assistant Professor', 1),
('Associate Professor', 1),
('Office Assistant', 1),
('Principal', 1),
('Professor', 1),
('System Administrator', 1),
('Technician', 1),
('tester', 1);

-- --------------------------------------------------------

--
-- Table structure for table `emergency_details`
--

CREATE TABLE `emergency_details` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `bloodgroup` varchar(16) NOT NULL,
  `weight` varchar(30) NOT NULL,
  `height` float(10,2) NOT NULL,
  `disability` varchar(100) NOT NULL,
  `eye_color` varchar(100) NOT NULL,
  `mark1` varchar(255) NOT NULL,
  `mark2` varchar(255) NOT NULL,
  `allergies` varchar(255) NOT NULL,
  `doctorname` varchar(255) NOT NULL,
  `doctor_no` int(30) NOT NULL,
  `medical_insurance` varchar(255) NOT NULL,
  `donateblood` varchar(16) NOT NULL,
  `w_donate` varchar(16) NOT NULL,
  `donateddate` date NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `firstrelation` varchar(255) NOT NULL,
  `c_no1` int(30) NOT NULL,
  `secondname` varchar(255) NOT NULL,
  `secondrelation` varchar(255) NOT NULL,
  `c_no2` int(30) NOT NULL,
  `sponsorship` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emergency_details`
--

INSERT INTO `emergency_details` (`id`, `reg_no`, `bloodgroup`, `weight`, `height`, `disability`, `eye_color`, `mark1`, `mark2`, `allergies`, `doctorname`, `doctor_no`, `medical_insurance`, `donateblood`, `w_donate`, `donateddate`, `remarks`, `firstname`, `firstrelation`, `c_no1`, `secondname`, `secondrelation`, `c_no2`, `sponsorship`) VALUES
(1, 'RECMECH001', 'B+', '75kg', 6.20, 'Yes', 'blaCK', 'test1', 'test2', 'no', 'me', 123, 'null', 'No', 'No', '0000-00-00', '321', 'person1', 'test1', 11111, 'person2', 'test2', 2147483647, 'null'),
(2, 'rec507', 'B+', '76', 6.20, 'No', 'Brown', 'Mole on left hand.', 'Mole on center of neck.', 'no', 'Rajsekhar', 2147483647, 'Null', 'No', 'No', '0000-00-00', 'null', 'Ramana', 'Father', 2147483647, 'Swarana', 'Mother', 123, 'no'),
(3, 'rec0091', 'AB-', '120', 7.00, 'Yes', 'Black', '-', '-', 'no', 'mea', 0, 'no', 'No', 'No', '0000-00-00', 'no', 'no', 'no', 0, 'no', 'on', 0, 'no'),
(4, 'rec539', 'A+', '78 kg', 5.10, 'No', 'Black', 'Size fat', 'Akayapalam property', 'no', 'no', 0, 'no', 'No', 'No', '2017-08-01', 'no', 'no', 'n', 0, 'on', 'ononon', 0, 'no'),
(5, 'rec9998s', 'B+', '75kgs', 5.10, 'No', 'Black', '-', '-', 'No', 'Vasavi', 2147483647, 'No', 'Yes', 'Yes', '2016-12-14', 'No Remarks', 'Rohith', 'Friend', 2147483647, 'Poorna', 'Friend', 2147483647, 'NO'),
(6, '13981A0509', 'B+', '75kgs', 5.10, 'No', 'Black', '-', '-', 'No', 'Vasavi', 2147483647, 'No', 'Yes', 'Yes', '2016-12-14', 'No Remarks', 'Rohith', 'Friend', 2147483647, 'Poorna', 'Friend', 2147483647, 'NO'),
(7, '13981A0502', 'B+', '75kgs', 5.10, 'No', 'Black', '-', '-', 'No', 'Vasavi', 2147483647, 'No', 'Yes', 'Yes', '2016-12-14', 'No Remarks', 'Rohith', 'Friend', 2147483647, 'Poorna', 'Friend', 2147483647, 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `extraactivites`
--

CREATE TABLE `extraactivites` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `details` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `extraactivites`
--

INSERT INTO `extraactivites` (`id`, `reg_no`, `details`, `description`, `certificate`) VALUES
(1, '125CSE895', 'NCC', 'Got C certificate', '125CSE895_NCC'),
(2, 'RECMECH001', 'fasdfsad', 'fafasdfasdfasdfasdfsdf\nadsfasdf\nf\nasdfasf', 'RECMECH001_fasdfsad.jpg'),
(3, 'RECMECH001', 'NCC', '123456', 'RECMECH001_NCC'),
(5, '13981A0507', 'testing', 'testing -1,testing -2,testing -3123', '13981A0507_testing.jpg.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `fdps_conducted`
--

CREATE TABLE `fdps_conducted` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `frominstitutionname` varchar(255) NOT NULL,
  `frominstitutionaddress` varchar(255) NOT NULL,
  `forinstitutionaddress` varchar(255) NOT NULL,
  `forinstitutionname` varchar(255) NOT NULL,
  `area_field` varchar(255) NOT NULL,
  `title_details` varchar(255) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fdps_conducted`
--

INSERT INTO `fdps_conducted` (`id`, `reg_no`, `frominstitutionname`, `frominstitutionaddress`, `forinstitutionaddress`, `forinstitutionname`, `area_field`, `title_details`, `duration`, `awards_remarks`, `certificate`) VALUES
(6, 'RECMECH001', '25', '2', '2', '2', '2', '2', '2', '2', 'RECMECH001_2_2.png'),
(7, 'RECCSE548', '2', '2', '2', '2', '2', '2', '2', '2', 'RECCSE548_2_2'),
(12, '13981A0539', 'fudk', 'dghj', 'jdghj', 'dhgjkdgh', 'dgkj', 'dghjk', 'ghkd', 'hkgd', '13981A0539_dgkj_dghjk.png'),
(13, 'RECMECH001', '123', '213', '1321', '23', '321', '321321321231', '231321', '231', 'RECMECH001_321_321321321231.png'),
(14, 'RECMECH001', 'Gmr', 'Rajam', 'Sontayam', 'NSRIT', 'Basket Ball', 'Capten', ' 4 days', 'Best Playes', 'RECMECH001_Gmr_Basket Ball');

-- --------------------------------------------------------

--
-- Table structure for table `left_table`
--

CREATE TABLE `left_table` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `left_date` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `left_table`
--

INSERT INTO `left_table` (`id`, `reg_no`, `left_date`, `reason`) VALUES
(1, '132', '2017-08-12', 'fh'),
(2, '13981A0539', '2017-08-16', 'Health Issue.'),
(3, 'rec539', '2017-08-18', 'Health Issue'),
(4, '125CSE895', '2017-08-22', 'testing');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `mid` int(11) NOT NULL,
  `mtype` varchar(10) NOT NULL,
  `mailtype` varchar(10) NOT NULL,
  `application_type` varchar(30) NOT NULL,
  `mto` varchar(255) NOT NULL,
  `cc` varchar(255) NOT NULL,
  `bcc` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `processed` bit(1) NOT NULL DEFAULT b'0',
  `processed_return` text NOT NULL,
  `insert_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`mid`, `mtype`, `mailtype`, `application_type`, `mto`, `cc`, `bcc`, `subject`, `message`, `processed`, `processed_return`, `insert_dt`) VALUES
(0, 'mail', 'd', 'd', 'd', 'd', '', 'd', 'd', b'0', '', '2017-08-23 06:11:08'),
(0, 'mail', 'm', 'm', 'm', 'm', '', 'm', 'm', b'0', '', '2017-08-23 06:12:00'),
(0, 'mail', 'r', 'r', 'r', 'r', '', 'r', 'r', b'0', '', '2017-08-23 06:28:22'),
(0, 'mail', '5', '5', '5', '5', '', '5', '5', b'0', '', '2017-08-23 09:21:23');

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
-- Table structure for table `patents`
--

CREATE TABLE `patents` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `details` varchar(500) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patents`
--

INSERT INTO `patents` (`id`, `reg_no`, `title`, `details`, `certificate`) VALUES
(2, 'RECMECH001', 'The Manoj test', 'Great Person Manoj doing test', 'RECMECH001_Manoj test.png'),
(5, '13981A0507', 'testing', 'testing -1,\ntesting -2,\ntesting -3', '13981A0507_testing');

-- --------------------------------------------------------

--
-- Table structure for table `preffered_teaching`
--

CREATE TABLE `preffered_teaching` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `semester` varchar(255) NOT NULL,
  `experience` varchar(255) NOT NULL,
  `no_years` int(30) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `preffered_teaching`
--

INSERT INTO `preffered_teaching` (`id`, `reg_no`, `subject`, `semester`, `experience`, `no_years`, `awards_remarks`) VALUES
(1, 'recmech001', 'Maths', '1', '2 years', 2, 'Yes'),
(2, 'admin', 'test', 'test', 'test', 0, 'test'),
(3, 'RECMECH001', '789', '879', '789', 897, '2222'),
(5, '125CSE895', 'Science', '12', '2', 2, '2'),
(6, '125CSE895', 'Maths', '4', '2', 2, 'More'),
(8, 'RECMECH001', '12', '12', '12', 12, '123'),
(9, 'RECMECH001', '45', '45', '54', 54, '54'),
(14, 'RECMECH001', 'chem', '12', '12', 12, '12'),
(15, 'RECMECH001', '66', '666', '666', 666, '66');

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `forinstitutionname` varchar(255) NOT NULL,
  `forinstitutionaddress` varchar(255) NOT NULL,
  `frominstitutionname` varchar(255) NOT NULL,
  `frominstitutionaddress` varchar(255) NOT NULL,
  `area_field` varchar(255) NOT NULL,
  `title_details` varchar(255) NOT NULL,
  `value` float(10,2) NOT NULL,
  `duration` varchar(100) NOT NULL,
  `outcome` varchar(100) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`id`, `reg_no`, `forinstitutionname`, `forinstitutionaddress`, `frominstitutionname`, `frominstitutionaddress`, `area_field`, `title_details`, `value`, `duration`, `outcome`, `awards_remarks`, `certificate`) VALUES
(8, 'RECMECH001', '12', '12', '12', '12', '121', '21', 21.00, '21', 'Awarded', '2', 'RECMECH001_12_121.png.jpg'),
(9, '125CSE895', 'rec', 'rec', 'rec', 'rec', 'rec', 'rec', 0.00, 'rec', 'Not Awarded', '123', ''),
(12, '125CSE895', 'sdasdf', 'dfadsfasa', 'dsfasd', 'fdasfa', 'dsfadsf', 'dasf', 0.00, 'fasdfasdf', 'Not Awarded', 'sdfdasf', '125CSE895_dsfasd_dsfadsf.jpg'),
(14, 'RECMECH001', '123', '123', 'Gmr', '123', '123', '123', 123.00, '123', 'Awarded', '123', 'RECMECH001_Gmr_123.png');

-- --------------------------------------------------------

--
-- Table structure for table `research_work`
--

CREATE TABLE `research_work` (
  `id` int(11) NOT NULL,
  `reg_no` varchar(100) NOT NULL,
  `frominstitutionname` varchar(255) NOT NULL,
  `frominstitutionaddress` varchar(255) NOT NULL,
  `area_field` varchar(255) NOT NULL,
  `title_details` varchar(255) NOT NULL,
  `awards_remarks` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL,
  `value` float(10,2) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `outcome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `research_work`
--

INSERT INTO `research_work` (`id`, `reg_no`, `frominstitutionname`, `frominstitutionaddress`, `area_field`, `title_details`, `awards_remarks`, `certificate`, `value`, `duration`, `outcome`) VALUES
(6, 'RECMECH001', '12', '12', '121', '21', '1', 'RECMECH001_121_21.png.png', 21.00, '21', 'UnSuccessfull'),
(8, '13981A0507', 'REC', 'vsk', 'testing', 'testing tools were not sufficient', 'No remarks', '13981A0507_REC_testing.jpg.jpg', 250000.00, '2 months', 'Partially Successful ');

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
(4, 'A', 6),
(5, 'A', 7),
(6, 'B', 1),
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
(98, 'A', 58),
(99, 'D', 4),
(100, '00000000', 3);

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
  `father_name` varchar(255) NOT NULL,
  `mother_name` varchar(255) NOT NULL,
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
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `personal_email` varchar(255) NOT NULL,
  `personal_phone_no` varchar(255) NOT NULL,
  `spouce_name` varchar(255) NOT NULL,
  `spouce_age` varchar(255) NOT NULL,
  `spouce_employment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `reg_no`, `title`, `firstname`, `lastname`, `dispname`, `college`, `department`, `designation`, `qualification`, `email`, `mobile`, `dp`, `father_name`, `mother_name`, `present_address`, `permanent_address`, `employment_type`, `pan`, `pan_file`, `aadhar`, `aadhar_file`, `passport`, `passport_file`, `dateob`, `doj`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `status`, `created_at`, `updated_at`, `personal_email`, `personal_phone_no`, `spouce_name`, `spouce_age`, `spouce_employment`) VALUES
(1, 'RECMECH001', 'Mr.', 'Nikhil', ' Kumar', 'Nikhil', '1', '9', 'Associate Professor', 'Ph.D', 'i.nikhil@akrivia.in', '1234567890', 'RECMECH001_dp.png', 'father', 'mother', 'Visakhapatnam.1258', 'vizinagaram111', 'Permanent', 'ABDFGT45RE', 'RECMECH001_pan.png', '1212 2524 3321', 'RECMECH001_aadhar.png', 'ASDF67VSKP123', 'RECMECH001_passport.png', '1996-08-20', '2017-08-02', 'palce of birth', 'birth state', 'country ', 'M', 'nationality', 'religion', 'caste', 'ps', 1, '2017-06-30 07:13:03', '2017-08-23 11:57:31', 'personal_id', 'personal no', 'nukl', '12', 'no'),
(2, 'RECCSE548', 'Mr.', 'Sravan', 'Kumar', NULL, '1', '3', 'System Administrator', 'B.Tech', 'system.admin@gmail.com', '9849197874', NULL, 'father', 'mother', 'city office', 'vizianagaram', 'Permanent', NULL, '', NULL, '', NULL, '', '2017-08-02', '2017-08-02', 'palce', 'birth state', 'country', 'M', 'nationality', 'religion', 'caste', '', 0, '2017-06-30 10:58:30', '2017-08-23 10:23:19', 'pr_is', 'pr_no', 'sp_name_test', 'sp_age_test', 'sp_emp_test'),
(3, 'RECEEE01', 'Mr.', 'Sivarama rao', 'Ch', NULL, '1', '7', 'Associate Professor', 'M.E.', '12345@gmail.com', '9492534735', 'RECEEE01_dp.jpg', '', '', 'College', 'PM Palem', 'Permanent', NULL, '', NULL, '', NULL, '', NULL, '2017-07-03', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-07-03 03:48:14', '2017-08-21 03:51:28', '', '', '', '', '0'),
(4, 'xyz123', 'Mr.', 'apparo', 'aoj', 'testing', '1', '5', 'Principal', 'Ph.D.', 'testmail@test.com', '1234569879', NULL, '', '', '132', '132', 'Contract', NULL, '', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, 'F', NULL, NULL, NULL, '', 2, '2017-07-07 07:15:40', '2017-09-05 06:35:28', '', '', '', '', '0'),
(12, 'rec9998', 'Mr.', '123456', '123456', NULL, '1', '1', 'Assistant Professor', 'mtech', '9998@gmail.com', '9998999854', NULL, '', '', 'sg', 'gsf', 'Probation', NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-08-16 09:33:55', '2017-08-16 09:33:55', '', '', '', '', ''),
(13, 'rec9977', 'Mrs.', '9977', '9977', NULL, '1', '3', 'Associate Professor', '9977', '9977@gmail.com', '9977997765', NULL, '', '', '9977', '9977', 'Contract', NULL, '', NULL, NULL, NULL, '', '2017-08-16', '2017-08-16', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-08-16 09:35:31', '2017-08-16 09:35:31', '', '', '', '', ''),
(20, 'rec0091', 'Mr.', 'Raju', 'Sanayasi', NULL, '1', '3', 'Associate Professor', 'M.Tech', '123@gmail.com', '123456789', NULL, '', '', NULL, NULL, 'Probation', NULL, '', NULL, NULL, NULL, '', NULL, '0000-00-00', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 0, '2017-08-21 04:04:33', '2017-08-23 10:23:26', '', '', '', '', ''),
(23, 'rec0093', 'Mr.', 'Rajesh', '', NULL, '1', '5', 'Associate Professor', 'mtech', 'rajesh@gmail.com', '7412589630', NULL, '', '', NULL, NULL, 'Probation', NULL, '', NULL, NULL, NULL, '', '0000-00-00', '2017-08-19', NULL, NULL, NULL, 'F', NULL, NULL, NULL, '', 1, '2017-08-21 09:17:51', '2017-09-05 06:35:24', '', '', '', '', ''),
(24, 'rec0008', 'Mr.', 'Rajesh', '', NULL, '1', '5', 'Associate Professor', 'mtech', 'rajesh2@gmail.com', '74125896302', NULL, '', '', NULL, NULL, 'Probation', NULL, '', NULL, NULL, NULL, '', '0000-00-00', '2017-08-19', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-08-21 09:18:18', '2017-09-02 07:27:57', '', '', '', '', ''),
(31, '13981A0507', 'Mr.', 'Rohith', 'A', NULL, '1', '5', 'Assistant Professor', 'M tech', 'raja@gmail.com', '12345678900', '13981A0507_dp.png', 'Asina Ramana', 'Asina Swarna', 'Vsk', 'CSk', 'Permanent', '2145 2563 1452', '13981A0507_pan.jpg', '2561 4521 6523', '13981A0507_aadhar.jpg', '2145 2563 5623', '13981A0507_passport.jpg', NULL, '2017-08-23', 'Vizag', 'Andhra Pradesh', 'India', 'M', 'Indian', 'Hindu', 'General', '', 1, '2017-08-23 06:28:22', '2017-08-23 09:30:39', 'rajarohit.in@gmail.com', '8596452563', 'Hema Asina', '19yrs', 'No');

--
-- Triggers `staff`
--
DELIMITER $$
CREATE TRIGGER `create_users_data` AFTER INSERT ON `staff` FOR EACH ROW BEGIN
	
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
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff_certificate`
--

INSERT INTO `staff_certificate` (`id`, `reg_no`, `course`, `board`, `passyear`, `grade`, `certificate`) VALUES
(62, 'RECMECH001', 'Post Graduation', '2', '2', '1', 'RECMECH001_Post Graduation.png'),
(63, 'RECMECH001', 'Intermediate', 'dsg', 'gsd', 'gsf', 'RECMECH001_Intermediate.png.png.png'),
(65, 'rec507', 'SSC', 'State Board', '2011', 'A+', 'rec507_SSC'),
(67, '125CSE895', 'Diploma', '12', '123', '312', '125CSE895_Diploma.jpg'),
(71, 'RECEEE01', 'Intermediate', 'APIED', '2011', 'A+', 'RECEEE01_Intermediate'),
(73, '13981A0507', 'Graduation', 'JNTUK', '2017', 'A+', '13981A0507_Graduation.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `staff_children_info`
--

CREATE TABLE `staff_children_info` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `child_name` varchar(255) NOT NULL,
  `child_age` varchar(255) NOT NULL,
  `child_gender` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_children_info`
--

INSERT INTO `staff_children_info` (`id`, `reg_no`, `child_name`, `child_age`, `child_gender`) VALUES
(1, 'RECMECH001', '123', '123', 'male'),
(2, 'RECMECH001', 'Manoj', '22', 'male');

-- --------------------------------------------------------

--
-- Table structure for table `staff_collegeaccount`
--

CREATE TABLE `staff_collegeaccount` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `pf_number` varchar(255) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `name_in_bank` varchar(255) NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `bank_address` varchar(500) NOT NULL,
  `ifc_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_collegeaccount`
--

INSERT INTO `staff_collegeaccount` (`id`, `reg_no`, `pf_number`, `bank_name`, `name_in_bank`, `account_no`, `bank_address`, `ifc_code`) VALUES
(1, 'rec539', '1234567890', 'Federal', 'Manoj', '7418529630', 'Green Park.', '74ABC'),
(2, 'RECMECH001', '4374673929903', 'Federal', 'Nikhil Kumar', '9999028263512', 'Near Green Park,\nSiripooram,\nvisakhapatnam.', '25413'),
(3, '125CSE895', '47373439792798', 'Federal', 'Vinay Kumar', '99901233437889', 'Near Green Park,\nSiripooram,\nVisakhapatnam', '25632'),
(4, 'rec539', '1234 5678 9632', 'FEderal', 'Manoj', 'APd56415684', 'Dabagardens, Visakhapatnam', '1254952'),
(5, '13981A0507', '123 456', 'HDFC', 'Manoj', 'HDFC741', 'Vsk', 'HDFC741');

-- --------------------------------------------------------

--
-- Table structure for table `staff_experience`
--

CREATE TABLE `staff_experience` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `from_date` varchar(255) NOT NULL,
  `to_date` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `teach_tech` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_experience`
--

INSERT INTO `staff_experience` (`id`, `reg_no`, `from_date`, `to_date`, `total`, `company_name`, `designation`, `teach_tech`, `certificate`) VALUES
(1, '13981A0525', '2017-08-01', '2017-08-02', '11', '11', '11', 'Teaching', '13981A0525_11'),
(10, '125CSE895', '2017-08-05', '2017-08-04', '2', 'Opentext123', 'demo', 'Teaching', '125CSE895_14_10.png'),
(11, 'rec539', '2017-08-31', '2017-09-22', '1 year', 'REC', 'Developer', 'Industry', 'rec539_REC.jpg'),
(16, 'rec9998', '2017-08-04', '2017-08-05', 'asd', 'acv', 'asd', 'Teaching', 'rec9998_sdqa.jpg'),
(17, 'RECMECH001', '2010-08-03', '2017-08-22', '7', 'Akrivia', 'Tech Manager', 'Industry', 'RECMECH001_Akrivia_17.jpg'),
(19, 'RECMECH001', '2017-08-12', '2017-08-18', '3', 'gfsdf', 'dsg', 'Industry', 'RECMECH001_gfsdf_19.jpg'),
(20, '13981A0507', '2017-01-05', '2017-08-23', '8 months', 'Akrivia', 'Application Developer', 'Industry', '13981A0507_Akrivia_20.jpg'),
(21, '13981A0507', '2017-08-04', '2017-08-03', '2 yrs', 'testing', 'testing', 'Industry', '13981A0507_undefined.jpg'),
(22, '125CSE895', '2017-08-06', '2017-08-04', '132', '132', '123', 'Teaching', '125CSE895_undefined.png');

-- --------------------------------------------------------

--
-- Table structure for table `staff_publications`
--

CREATE TABLE `staff_publications` (
  `id` int(255) NOT NULL,
  `reg_no` varchar(255) NOT NULL,
  `categoty` varchar(255) NOT NULL,
  `paper_title` varchar(255) NOT NULL,
  `authors` varchar(255) NOT NULL,
  `specialization` varchar(255) NOT NULL,
  `brief_description` varchar(255) NOT NULL,
  `publisher_type` varchar(255) NOT NULL,
  `publisher_name` varchar(255) NOT NULL,
  `scopus_index` varchar(255) NOT NULL,
  `impact_factor` varchar(255) NOT NULL,
  `publishing_date` varchar(255) NOT NULL,
  `page_no` varchar(255) NOT NULL,
  `awards` varchar(255) NOT NULL,
  `citations` varchar(255) NOT NULL,
  `certificate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_publications`
--

INSERT INTO `staff_publications` (`id`, `reg_no`, `categoty`, `paper_title`, `authors`, `specialization`, `brief_description`, `publisher_type`, `publisher_name`, `scopus_index`, `impact_factor`, `publishing_date`, `page_no`, `awards`, `citations`, `certificate`) VALUES
(1, '125CSE895', 'Article', 'Times of India', 'Rambabu', 'Nothing', 'Emo', 'National', 'Manoj', '123', 'nothing', '2017-08-02', '5', 'Null', '1324', '125CSE895_Times of India.png'),
(2, '125CSE895', 'Paper', 'Durga', '123', '1232', '123', 'International', '531', '456', '546', '2017-08-12', '56+', '465', '465654', '125CSE895_Durga.png'),
(3, 'RECMECH001', 'Paper', 'testing', 'testing', 'testing', 'testing', 'National', 'testing', 'testing', 'testing', '2017-08-17', '2101', 'testing', 'testing', 'RECMECH001_testing.jpg'),
(4, 'RECMECH001', 'Article', 'manoj', '123', '123', '123', 'National', '123', '123', '123', '', '13', '123', '255555555', 'RECMECH001_123.png.png.png'),
(5, '125CSE895', 'Article', '123', '123', '231', '1231', 'National', '231', '312', '32312', '2017-08-03', '1231', '231', '123', '125CSE895_123.jpg'),
(6, '13981A0507', 'Article', 'test', 'test', 'test', 'test', 'National', 'test', 'test', 'test', '2017-08-14', 'test', 'test', 'test', '13981A0507_test.jpg'),
(8, 'RECMECH001', 'Material', '123', '132', '132', '132', 'International', '321', '321', '321', '', '1325146', '54654', '657', 'RECMECH001_123.png');

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
  `college` varchar(20) NOT NULL,
  `course` varchar(20) NOT NULL,
  `branch` varchar(20) NOT NULL,
  `year` int(11) NOT NULL,
  `section` int(11) NOT NULL,
  `fathername` varchar(255) DEFAULT NULL,
  `mothername` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `dp` varchar(30) DEFAULT NULL,
  `present_address` text NOT NULL,
  `permanent_address` text,
  `aadhar` varchar(20) DEFAULT NULL,
  `aadhar_file` varchar(255) NOT NULL,
  `passport` varchar(255) NOT NULL,
  `passport_file` varchar(255) NOT NULL,
  `pan` varchar(255) NOT NULL,
  `pan_file` varchar(255) NOT NULL,
  `dob` date NOT NULL,
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
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admission_category` varchar(20) NOT NULL,
  `admission_no` varchar(255) NOT NULL,
  `enrollment_no` varchar(255) NOT NULL,
  `entry_passout` varchar(255) NOT NULL,
  `living_status` varchar(255) NOT NULL,
  `admission_type` varchar(255) NOT NULL,
  `admission_date` varchar(255) NOT NULL,
  `scholarship_status` varchar(255) NOT NULL,
  `staff_child` varchar(255) NOT NULL,
  `transport` varchar(255) NOT NULL,
  `aconomically_backword` varchar(255) NOT NULL,
  `father_income` varchar(255) NOT NULL,
  `mother_income` varchar(255) NOT NULL,
  `proposed_discount` varchar(255) NOT NULL,
  `personal_email` varchar(255) NOT NULL,
  `personal_phone_no` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `firstname`, `lastname`, `dispname`, `reg_no`, `college`, `course`, `branch`, `year`, `section`, `fathername`, `mothername`, `email`, `mobile`, `dp`, `present_address`, `permanent_address`, `aadhar`, `aadhar_file`, `passport`, `passport_file`, `pan`, `pan_file`, `dob`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `status`, `created_at`, `updated_at`, `admission_category`, `admission_no`, `enrollment_no`, `entry_passout`, `living_status`, `admission_type`, `admission_date`, `scholarship_status`, `staff_child`, `transport`, `aconomically_backword`, `father_income`, `mother_income`, `proposed_discount`, `personal_email`, `personal_phone_no`) VALUES
(1, 'Vinay', 'Kumar', 'Vinay', '125CSE895', '1', '1', '5', 2, 2, NULL, NULL, 'cse_student@raghuenggcollege.com', '9879875850', '125CSE895_dp.jpg', 'Raghu Engineering College', 'NAD Kotha Road', '', '', '', '', '', '', '2017-07-23', 'ap', 'ap', 'India', 'M', 'Indian', 'Hindu', 'Kshatriyas', '', 2, '2017-06-15 00:00:00', '2017-08-31 17:38:31', 'BC-A', '125CSE895', '125CSE895', '2013-2017', 'Day Scholar', 'Counciling (Convener)', '2017-07-23', 'No', 'No', 'No', 'No', '1,50,000', '75,000', 'No', 'vinay@gmail.com', '2563415263'),
(5, 'Manoj Varma', 'K', 'Maonoj', 'rec539', '1', '1', '7', 2, 2, 'Father', 'Mother', 'manoj539@gmail.com', '7895213640', NULL, 'Town kotha road', 'Akayapalam', '1234 5678 9512', 'rec539_aadhar.png', '', '', '', '', '2017-07-23', 'Kakinada', 'Ap', 'India', 'M', 'Indian', 'Hindhu', 'Oc', '', 1, '2017-08-17 14:33:05', '2017-08-31 17:38:34', 'General', '2541455722210', '13981A0539', '2013-2017', 'Day Scholar', 'Counciling (Convener)', '2017-07-07', 'Yes', 'No', 'No', 'Yes', '200000', '7000', 'Yes', 'manojvarama143@gmail.com', '90005060404010203'),
(6, 'Rohith', 'Asina', 'Rohith', 'rec507', '1', '1', '2', 2, 2, NULL, NULL, 'rajarohit.in@gmail.com', '8374384580', NULL, 'Visakhapatnam', 'Visakhapatnam', '1234 5678 9541', 'rec507_aadhar.png', '', '', '9845 6574 2654', 'rec507_pan.png', '2017-08-17', 'vsk', 'Ap', 'India', 'F', 'Indian', 'Christian', 'oc', '', 1, '2017-08-17 15:09:44', '2017-09-14 11:12:30', 'OBC', 'RECCS13981507', 'ENRRECCSE5', '2013-2017', 'Day Scholar', 'Counciling (Convener)', '2017-08-17', 'Yes', 'No', 'No', 'Yes', '70000', '30000', 'Yes', 'raja@gmail.com', '8374384580'),
(7, '123987', '123987', '123987', 'rec00082', '1', '1', '3', 2, 2, NULL, NULL, '123987@gmail.com', '123987', NULL, '123987', '123987', NULL, '', '', '', '', '', '2017-08-01', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-08-29 09:23:48', '2017-09-02 14:26:51', 'BC-D', '123987', '123987', '123987', 'Day Scholar', 'Counciling (Convener)', '2017-08-01', 'Yes', '', '', '', '', '', '', '', ''),
(8, 'ramesh', '123987', '123987', 'rec034', '1', '1', '3', 2, 2, NULL, NULL, '12398ss7@gmail.com', '1239387', NULL, '1239dfd 87', '1239asdf87', NULL, '', '', '', '', '', '2017-08-01', NULL, NULL, NULL, 'M', NULL, NULL, NULL, '', 1, '2017-08-29 09:23:48', '2017-09-13 17:40:15', 'BC-D', '123987', '123987', '123987', 'Day Scholar', 'Counciling (Convener)', '2017-08-01', 'Yes', '', '', '', '', '', '', '', '');

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
(1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'adm', '1234', '2017-06-13 02:00:00', '2017-08-29 05:26:53'),
(2, 'CseHod', 'RECCSE001', 'e10adc3949ba59abbe56e057f20f883e', 'stf', '1235', '2017-06-14 12:29:29', '2017-08-14 11:25:16'),
(3, 'Vinay', '125CSE895', '93ef7669244e75c9e1eda49d1a4c4a55', 'std', '1236', '2017-06-14 13:27:30', '2017-08-23 04:14:21'),
(11, 'Nikhil', 'RECMECH001', '2cc8d2ca1f0f369f6f3f3943d8064850', 'stf', NULL, NULL, '2017-08-23 10:45:47'),
(12, 'Sravan', 'RECCSE548', 'b1a5b64256e27fa5ae76d62b95209ab3', 'adm', NULL, NULL, '2017-08-17 11:42:24'),
(13, 'Sivarama rao', 'RECEEE01', 'd7792ea01be12978c51f26450979310f', 'adm', NULL, NULL, '2017-08-21 03:51:28'),
(14, 'apparo', 'xyz123', 'b1a5b64256e27fa5ae76d62b95209ab3', 'stf', NULL, NULL, '2017-08-24 11:56:09'),
(30, '123456', 'rec9998', 'b2d62796f3b6b183443db46f02d02939', 'stf', NULL, '2017-08-16 09:33:55', '2017-08-16 09:33:55'),
(32, '9977', 'rec9977', 'c1bbe1f7308b2d2e09460bef841aa0c5', 'stf', NULL, '2017-08-16 09:35:31', '2017-08-16 09:35:31'),
(36, 'Manoj Varma', 'rec539', '1e1fbd0f61c7390b5ba1d3676f3ff542', 'std', NULL, '2017-08-17 09:03:05', '2017-08-23 03:51:33'),
(37, 'Rohith', 'rec507', '39a8b8911b3e5d35c10f5d1807dc709a', 'std', NULL, '2017-08-17 09:39:45', '2017-08-18 05:32:37'),
(44, 'Raju', 'rec0091', 'be7d566123964adf2f8da9364073bce8', 'stf', NULL, '2017-08-21 04:04:33', '2017-08-21 04:04:33'),
(49, 'Rajesh', 'rec0093', 'b929fab56da43e1c721ce26d5ee7c699', 'stf', NULL, '2017-08-21 09:17:51', '2017-08-21 09:17:51'),
(51, 'Rajesh', 'rec0008', '3022508aa85171383cdc443303b413c9', 'stf', NULL, '2017-08-21 09:18:18', '2017-09-02 07:51:22'),
(61, 'Rohith', 'rec0060', 'e10adc3949ba59abbe56e057f20f883e', 'stf', NULL, '2017-08-23 06:28:22', '2017-09-02 07:50:52'),
(62, '546', '123', '4ccd80f4094469930f48433254b31d11', 'std', NULL, '2017-08-23 09:21:23', '2017-08-23 09:21:23'),
(63, '123987', 'rec00082', '15586ef14a4dba26707ce6a6bda3707b', 'std', NULL, '2017-08-29 03:53:48', '2017-09-02 07:51:11');

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
  `branch` int(11) NOT NULL,
  `department` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `year`
--

INSERT INTO `year` (`id`, `year`, `branch`, `department`) VALUES
(1, '1', 1, 9),
(2, '2', 1, 9),
(3, '1', 2, 1),
(4, '2', 2, 1),
(5, '3', 2, 1),
(6, '4', 2, 1),
(7, '1', 3, 12),
(8, '2', 3, 2),
(9, '3', 3, 2),
(10, '4', 3, 2),
(11, '1', 4, 11),
(12, '2', 4, 3),
(13, '3', 4, 3),
(14, '4', 4, 3),
(15, '1', 5, 12),
(16, '2', 5, 4),
(17, '3', 5, 4),
(18, '4', 5, 4),
(19, '1', 6, 3),
(20, '2', 6, 3),
(21, '1', 7, 4),
(22, '2', 7, 4),
(23, '1', 8, 11),
(24, '2', 8, 5),
(25, '3', 8, 5),
(26, '4', 8, 5),
(27, '1', 9, 12),
(28, '2', 9, 6),
(29, '3', 9, 6),
(30, '4', 9, 6),
(31, '1', 10, 11),
(32, '2', 10, 7),
(33, '3', 10, 7),
(34, '4', 10, 7),
(35, '1', 11, 12),
(36, '2', 11, 8),
(37, '3', 11, 8),
(38, '4', 11, 8),
(39, '1', 12, 6),
(40, '2', 12, 6),
(41, '1', 13, 5),
(42, '2', 13, 5),
(43, '1', 14, 10),
(44, '2', 14, 10),
(45, '1', 15, 11),
(46, '2', 15, 9),
(47, '3', 15, 9),
(48, '4', 15, 9),
(49, '1', 16, 12),
(50, '2', 16, 10),
(51, '3', 16, 10),
(52, '4', 16, 10),
(53, '1', 17, 7),
(54, '2', 17, 7),
(55, '1', 18, 8),
(56, '2', 18, 8),
(57, '1', 19, 3),
(58, '2', 19, 3),
(59, '5', 4, 1);

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
-- Indexes for table `attended`
--
ALTER TABLE `attended`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `consultancy_projects`
--
ALTER TABLE `consultancy_projects`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `emergency_details`
--
ALTER TABLE `emergency_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extraactivites`
--
ALTER TABLE `extraactivites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fdps_conducted`
--
ALTER TABLE `fdps_conducted`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `left_table`
--
ALTER TABLE `left_table`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `patents`
--
ALTER TABLE `patents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preffered_teaching`
--
ALTER TABLE `preffered_teaching`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `research_work`
--
ALTER TABLE `research_work`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `staff_children_info`
--
ALTER TABLE `staff_children_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_collegeaccount`
--
ALTER TABLE `staff_collegeaccount`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_experience`
--
ALTER TABLE `staff_experience`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_publications`
--
ALTER TABLE `staff_publications`
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
-- AUTO_INCREMENT for table `attended`
--
ALTER TABLE `attended`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `consultancy_projects`
--
ALTER TABLE `consultancy_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `emergency_details`
--
ALTER TABLE `emergency_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `extraactivites`
--
ALTER TABLE `extraactivites`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `fdps_conducted`
--
ALTER TABLE `fdps_conducted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `left_table`
--
ALTER TABLE `left_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `patents`
--
ALTER TABLE `patents`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `preffered_teaching`
--
ALTER TABLE `preffered_teaching`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `research_work`
--
ALTER TABLE `research_work`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `staff_certificate`
--
ALTER TABLE `staff_certificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `staff_children_info`
--
ALTER TABLE `staff_children_info`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `staff_collegeaccount`
--
ALTER TABLE `staff_collegeaccount`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `staff_experience`
--
ALTER TABLE `staff_experience`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `staff_publications`
--
ALTER TABLE `staff_publications`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT for table `year`
--
ALTER TABLE `year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
