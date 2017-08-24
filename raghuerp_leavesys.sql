-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 24, 2017 at 02:25 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raghuerp_leavesys`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `college_leaves_summary` (IN `fromdate` DATETIME, IN `todate` DATETIME, IN `college` VARCHAR(10))  NO SQL
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS temp_colglvs_table(   
  `college` varchar(30) NOT NULL,
  `department` varchar(30) NOT NULL,
  `y` int(4)
) ENGINE=memory;

insert into temp_colglvs_table (SELECT c.college, d.department, 0 as y FROM raghuerp_db.departments d inner join raghuerp_db.colleges c on c.id = d.college);

SET @query = CONCAT("update temp_colglvs_table t1,(select c.college, d.department, count(*) as y from raghuerp.leave_issues lv inner join raghuerp_db.staff s on s.reg_no = lv.reg_no inner join raghuerp_db.colleges c on s.college = c.id inner join raghuerp_db.departments d on s.department = d.id where lv.from_date <= '", fromdate, "' and lv.to_date >= '", todate, "' and lv.status='Accepted' group by d.department) t2 set t1.y = t2.y where t1.college = t2.college and t1.department = t2.department");

 PREPARE stat FROM @query;
 EXECUTE stat;

if college = "" then
 select college, department as name, y from temp_colglvs_table order by college asc;
else
 SET @q2 = CONCAT("select college, department as name, y from temp_colglvs_table where college='", college,  "'");
 PREPARE stat FROM @q2;
 EXECUTE stat;
end if;

drop table temp_colglvs_table;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `findSundays` ()  NO SQL
BEGIN

DECLARE flag smallint;
  DECLARE c    smallint;
  DECLARE firstsunday date;
  DECLARE thisdate date;
  DECLARE Sundays varchar(500);
  DECLARE start_date date;
  DECLARE end_date date;
  
  set start_date = concat(year(now()),'-01-01');
  set end_date = concat(year(now()),'-12-31');

#CREATE TEMPORARY TABLE IF NOT EXISTS sundays_table(   
#  `dt` date
#) ENGINE=memory;
  
  
  SET flag := 1;
#  SET c    := 0;
  SET thisdate := start_date;
  SET Sundays := "";

  IF dayofweek(thisdate) <> 1 THEN

  WHILE flag > 0 DO
    SET thisdate := date_add(thisdate, interval 1 day);
    #select thisdate;
    IF dayofweek(thisdate) = 1 THEN
      SET flag := 0;
      SET firstsunday := thisdate;
    END IF;
#    SET c := c+1;
#    if c = 5 then set flag := 0; end if;
  END WHILE;

  ELSE
    SET firstsunday := thisdate;
  END IF;

#  select firstsunday;
  SET Sundays := firstsunday;
#  insert into sundays_table(dt) values (firstsunday);

  SET flag := 1;
  WHILE flag > 0 DO
    IF date_add(firstsunday, INTERVAL 7 day) <= end_date THEN
      SET Sundays := concat(Sundays, ", ", date_add(firstsunday, INTERVAL 7 day));
	  insert into holidays(holdate,holname,holtype) values (firstsunday, 'Sunday','Public Holiday');
      SET firstsunday := date_add(firstsunday, INTERVAL 7 day);
    ELSE
      SET flag := 0;
    END IF;
  END WHILE;
  
  INSERT INTO `raghuerp`.`lmscron`(`cid`, `cname`, `cyear`) VALUES (NULL,'holidays',year(now()));

END$$

DELIMITER ;

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
(1, 'admin', 'Admin', 'admin@raghueducational.org', '8500373704', '', 'admin', 1, '2017-06-12 20:30:00', '2017-06-29 10:37:30'),
(2, 'management', 'management', '', '', '', 'Management', 1, '2017-06-14 01:30:00', '2017-06-29 10:37:36'),
(3, 'admin2', 'leaveadmin', 'leaveadmin@raghuerp.com', '235', '', 'admin', 1, '2017-05-08 02:58:28', '2017-06-11 03:47:11');

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
-- Table structure for table `allroles`
--

CREATE TABLE `allroles` (
  `rid` int(11) NOT NULL,
  `rname` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `allroles`
--

INSERT INTO `allroles` (`rid`, `rname`) VALUES
(1, 'admin'),
(2, 'Management'),
(3, 'HOD'),
(4, 'Principal'),
(5, 'Dean');

-- --------------------------------------------------------

--
-- Table structure for table `coff`
--

CREATE TABLE `coff` (
  `cid` int(11) NOT NULL,
  `reg_no` varchar(15) NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `reason` varchar(50) NOT NULL,
  `reject_reason` varchar(50) NOT NULL,
  `rejectedby` varchar(25) NOT NULL,
  `status` varchar(15) NOT NULL,
  `days` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coff`
--

INSERT INTO `coff` (`cid`, `reg_no`, `from_date`, `to_date`, `reason`, `reject_reason`, `rejectedby`, `status`, `days`) VALUES
(14, 'rec0008', '2017-07-19 09:00:00', '2017-07-19 12:00:00', 'testing coff', '', '', 'Accepted', 0.5),
(15, 'rec0008', '2017-07-19 12:00:00', '2017-07-19 17:00:00', 'testing', '', 'HOD', 'Rejected', 0.5),
(16, 'rec0008', '2017-07-20 09:00:00', '2017-07-20 12:00:00', 'testing', '', '', 'Accepted', 0.5),
(17, 'rec0008', '2017-07-20 12:00:00', '2017-07-20 17:00:00', 'testing', '', '', 'Accepted', 0.5);

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `college` varchar(5) NOT NULL,
  `full_name` varchar(30) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`college`, `full_name`, `status`) VALUES
('REC', 'Raghu Engineering College', 1),
('RIT', 'Raghu Institute of Technology', 1);

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `sno` int(11) NOT NULL,
  `designation` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` (`sno`, `designation`, `email`) VALUES
(1, 'Director', 'manojvarma132@gmail.com'),
(2, 'Chairman', 'allurinani.007@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department` varchar(10) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `college` varchar(10) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department`, `full_name`, `college`, `status`) VALUES
('CSE', 'Computer Science and Engineering', 'REC', 1),
('ECE', 'Electronics and Communication Engineering', 'RIT', 1),
('EEE', 'Electrical and Electronics Engineering', 'RIT', 1),
('MECH', 'Mechanical Engineering', 'REC', 1);

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
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `eid` int(11) NOT NULL,
  `emails` varchar(500) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `sno` int(11) NOT NULL,
  `holdate` date NOT NULL,
  `holname` varchar(30) NOT NULL,
  `holtype` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`sno`, `holdate`, `holname`, `holtype`) VALUES
(1, '2017-08-15', 'Independence Day', 'Public Holiday'),
(2, '2017-01-01', 'Sunday', 'Public Holiday'),
(3, '2017-01-08', 'Sunday', 'Public Holiday'),
(4, '2017-01-15', 'Sunday', 'Public Holiday'),
(5, '2017-01-22', 'Sunday', 'Public Holiday'),
(6, '2017-01-29', 'Sunday', 'Public Holiday'),
(7, '2017-02-05', 'Sunday', 'Public Holiday'),
(8, '2017-02-12', 'Sunday', 'Public Holiday'),
(9, '2017-02-19', 'Sunday', 'Public Holiday'),
(10, '2017-02-26', 'Sunday', 'Public Holiday'),
(11, '2017-03-05', 'Sunday', 'Public Holiday'),
(12, '2017-03-12', 'Sunday', 'Public Holiday'),
(13, '2017-03-19', 'Sunday', 'Public Holiday'),
(14, '2017-03-26', 'Sunday', 'Public Holiday'),
(15, '2017-04-02', 'Sunday', 'Public Holiday'),
(16, '2017-04-09', 'Sunday', 'Public Holiday'),
(17, '2017-04-16', 'Sunday', 'Public Holiday'),
(18, '2017-04-23', 'Sunday', 'Public Holiday'),
(19, '2017-04-30', 'Sunday', 'Public Holiday'),
(20, '2017-05-07', 'Sunday', 'Public Holiday'),
(21, '2017-05-14', 'Sunday', 'Public Holiday'),
(22, '2017-05-21', 'Sunday', 'Public Holiday'),
(23, '2017-05-28', 'Sunday', 'Public Holiday'),
(24, '2017-06-04', 'Sunday', 'Public Holiday'),
(25, '2017-06-11', 'Sunday', 'Public Holiday'),
(26, '2017-06-18', 'Sunday', 'Public Holiday'),
(27, '2017-06-25', 'Sunday', 'Public Holiday'),
(28, '2017-07-02', 'Sunday', 'Public Holiday'),
(29, '2017-07-09', 'Sunday', 'Public Holiday'),
(30, '2017-07-16', 'Sunday', 'Public Holiday'),
(31, '2017-07-23', 'Sunday', 'Public Holiday'),
(32, '2017-07-30', 'Sunday', 'Public Holiday'),
(33, '2017-08-06', 'Sunday', 'Public Holiday'),
(34, '2017-08-13', 'Sunday', 'Public Holiday'),
(35, '2017-08-20', 'Sunday', 'Public Holiday'),
(36, '2017-08-27', 'Sunday', 'Public Holiday'),
(37, '2017-09-03', 'Sunday', 'Public Holiday'),
(38, '2017-09-10', 'Sunday', 'Public Holiday'),
(39, '2017-09-17', 'Sunday', 'Public Holiday'),
(40, '2017-09-24', 'Sunday', 'Public Holiday'),
(41, '2017-10-01', 'Sunday', 'Public Holiday'),
(42, '2017-10-08', 'Sunday', 'Public Holiday'),
(43, '2017-10-15', 'Sunday', 'Public Holiday'),
(44, '2017-10-22', 'Sunday', 'Public Holiday'),
(45, '2017-10-29', 'Sunday', 'Public Holiday'),
(46, '2017-11-05', 'Sunday', 'Public Holiday'),
(47, '2017-11-12', 'Sunday', 'Public Holiday'),
(48, '2017-11-19', 'Sunday', 'Public Holiday'),
(49, '2017-11-26', 'Sunday', 'Public Holiday'),
(50, '2017-12-03', 'Sunday', 'Public Holiday'),
(51, '2017-12-10', 'Sunday', 'Public Holiday'),
(52, '2017-12-17', 'Sunday', 'Public Holiday'),
(53, '2017-12-24', 'Sunday', 'Public Holiday'),
(54, '2017-12-31', 'Sunday', 'Public Holiday'),
(59, '2017-08-28', 'ganesh chaturthi', 'Public Holiday'),
(60, '2017-09-30', 'Dasara', 'Public Holiday'),
(61, '2016-12-04', 'Sunday', 'Public Holiday'),
(62, '2016-12-11', 'Sunday', 'Public Holiday'),
(63, '2016-12-18', 'Sunday', 'Public Holiday');

-- --------------------------------------------------------

--
-- Table structure for table `leavetypes`
--

CREATE TABLE `leavetypes` (
  `typeId` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `typename` varchar(20) NOT NULL,
  `totaldays` float NOT NULL,
  `lstatus` varchar(30) NOT NULL,
  `carryfwd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leavetypes`
--

INSERT INTO `leavetypes` (`typeId`, `type`, `typename`, `totaldays`, `lstatus`, `carryfwd`) VALUES
(1, 'Sick Leave', 'sick_leave', 0, 'disable', 0),
(2, 'Prevelege Leave', 'prevelege_leave', 0, 'disable', 0),
(3, 'Compensatory Off', 'compensatory_leave', 0, 'enable', 1),
(4, 'Study Leave', 'study_leave', 0, 'disable', 0),
(5, 'Casual Leave', 'casual_leave', 12, 'enable', 0),
(6, 'LOP', 'LOP', 0, 'enable', 0),
(8, 'Maternaty Leave', 'maternaty_leave', 0, 'enable', 0);

-- --------------------------------------------------------

--
-- Table structure for table `leave_issues`
--

CREATE TABLE `leave_issues` (
  `leave_id` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `type_of_leave` varchar(25) NOT NULL,
  `previous` float NOT NULL,
  `duration` float NOT NULL,
  `alternateId` varchar(20) NOT NULL,
  `alternateStatus` varchar(15) NOT NULL,
  `delegatedreason` varchar(64) NOT NULL,
  `lop` float NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `reason` varchar(30) NOT NULL,
  `reject_reason` varchar(50) NOT NULL,
  `alter_reason` varchar(50) NOT NULL,
  `rejectedby` varchar(30) NOT NULL,
  `status` varchar(25) NOT NULL,
  `remarks` varchar(30) NOT NULL,
  `days` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leave_issues`
--

INSERT INTO `leave_issues` (`leave_id`, `reg_no`, `type_of_leave`, `previous`, `duration`, `alternateId`, `alternateStatus`, `delegatedreason`, `lop`, `from_date`, `to_date`, `reason`, `reject_reason`, `alter_reason`, `rejectedby`, `status`, `remarks`, `days`) VALUES
(86, 'rec0008', 'Casual Leave', 1, 0, 'rec0117', 'Pending', '', 0, '2017-07-25 12:00:00', '2017-07-26 12:00:00', 'testing', '', '', '', 'Accepted', '', 1),
(87, 'rec0008', 'Compensatory Off', 0, 0, 'rec0187', 'Pending', '', 0.5, '2017-07-26 12:00:00', '2017-07-26 17:00:00', 'testing', 'testing', '', 'HOD', 'Rejected', '', 0.5),
(88, 'rec0132', 'Casual Leave', 0.5, 0, 'rec0026', 'Pending', '', 0, '2017-07-26 09:00:00', '2017-07-26 12:00:00', 'testing mail', '', '', '', 'Accepted', '', 0.5),
(89, 'rec0115', 'Casual Leave', 0.5, 0, 'rec0039', 'Pending', '', 0, '2017-07-27 09:00:00', '2017-07-27 12:00:00', 'testing', '', '', '', 'Accepted', '', 0.5),
(90, 'rec0013', 'Casual Leave', 0.5, 0, 'rec0010', 'Pending', '', 0, '2017-07-27 09:00:00', '2017-07-27 12:00:00', 'testing', '', '', '', 'Accepted', '', 0.5),
(91, 'rec0032', 'Casual Leave', 0.5, 0, 'rec0134', 'Pending', '', 0, '2017-07-27 09:00:00', '2017-07-27 12:00:00', 'testing', '', '', '', 'Accepted', '', 0.5);

-- --------------------------------------------------------

--
-- Table structure for table `lmscron`
--

CREATE TABLE `lmscron` (
  `cid` int(11) NOT NULL,
  `cname` varchar(20) NOT NULL,
  `cyear` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lmscron`
--

INSERT INTO `lmscron` (`cid`, `cname`, `cyear`) VALUES
(1, 'holidays', '2017'),
(18, 'carryfwd', '2017');

-- --------------------------------------------------------

--
-- Table structure for table `Role`
--

CREATE TABLE `Role` (
  `role_id` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `role` varchar(15) NOT NULL,
  `type` varchar(15) NOT NULL,
  `upto` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Role`
--

INSERT INTO `Role` (`role_id`, `reg_no`, `role`, `type`, `upto`) VALUES
(1, 'management', 'Management', 'Permanent', ''),
(9, 'admin', 'admin', 'Permanent', ''),
(14, 'rec0067', 'HOD', 'Permanent', ''),
(15, 'rec0080', 'HOD', 'Permanent', ''),
(16, 'rec0028', 'HOD', 'Permanent', ''),
(17, 'rec0143', 'HOD', 'Permanent', ''),
(18, 'rec0005', 'HOD', 'Permanent', ''),
(19, 'rec0175', 'HOD', 'Permanent', ''),
(20, 'rec0050', 'Principal', 'Permanent', ''),
(21, 'rec0152', 'Dean', 'Permanent', ''),
(24, 'rit0001', 'HOD', 'Permanent', ''),
(25, 'rit0004', 'HOD', 'Permanent', ''),
(26, 'rit0011', 'HOD', 'Permanent', ''),
(27, 'rit0082', 'HOD', 'Permanent', ''),
(28, 'rit0098', 'HOD', 'Permanent', ''),
(29, 'rit0103', 'HOD', 'Permanent', '');

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
  `aadhar` varchar(20) DEFAULT NULL,
  `passport` varchar(25) DEFAULT NULL,
  `dateob` date NOT NULL,
  `placeob` varchar(255) DEFAULT NULL,
  `stateob` varchar(50) DEFAULT NULL,
  `countryob` varchar(50) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `caste` varchar(30) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `roleid` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `reg_no`, `title`, `firstname`, `lastname`, `dispname`, `college`, `department`, `designation`, `qualification`, `email`, `mobile`, `dp`, `present_address`, `permanent_address`, `employment_type`, `pan`, `aadhar`, `passport`, `dateob`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `roleid`, `status`, `created_at`, `updated_at`) VALUES
(1, 'RECCSE001', '', 'Cse Hod', 'Faculty', 'CseHod', 'REC', 'CSE', 'Professor', 'Ph.D.', 'krishna.krishnachandra.chandra@gmail.com', '9859852589', '', 'Raghu Engineering College', 'madhurawada', '', '', '', '', '1975-06-05', '', '', '', '', '', '', '', 'HOD', 3, 1, '2017-06-13 20:30:00', '2017-07-03 04:21:21'),
(2, 'REC410', 's', NULL, NULL, 'poorna', 'REC', 'CSE', 'Proffessor', 'B.Tech', 'rajarohit.in@gmail.com', 's', NULL, NULL, NULL, 's', NULL, NULL, NULL, '2017-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Staff', 5, 1, '2017-06-15 01:42:00', '2017-07-03 07:02:49'),
(3, 'RECPRI001', '', NULL, NULL, 'principal', 'REC', '', 'Proffessor', 'Ph.D.', 'poornachand046@gmail.com', '', NULL, NULL, NULL, '', NULL, NULL, NULL, '1987-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Principal', 2, 1, '2017-06-14 05:30:00', '2017-07-03 07:02:45'),
(7, 'RECCSE002', '', NULL, NULL, 'csedean', 'REC', 'CSE', 'Professor', 'Ph.D.', 'dd', '26578', NULL, NULL, NULL, '', NULL, NULL, NULL, '1965-06-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Dean', 0, 0, '2017-06-11 23:30:00', '2017-07-03 04:21:17'),
(11, 'management', 'management', 'management', 'management', 'management', 'RIT', 'ECE', 'management', '', 'asdds', 'as', NULL, NULL, NULL, 'permanent', 'dsa', 'sda', 'asa', '0000-00-00', 'sad', NULL, NULL, NULL, NULL, NULL, NULL, 'Management', 0, 0, '2017-06-28 23:30:00', '2017-07-07 09:53:05'),
(12, '235', '43', 'er', 'dsaf', 'safd', 'RCP', 'B.Pharmacy', 'asf', 'af', 'afs', 'af', 'af', NULL, NULL, 'permanent', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'af', 1, 0, '2017-07-20 02:30:00', '2017-07-06 09:31:57');

--
-- Triggers `staff`
--
DELIMITER $$
CREATE TRIGGER `update_staff_timestamp` BEFORE UPDATE ON `staff` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

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

INSERT INTO `students` (`id`, `firstname`, `lastname`, `dispname`, `reg_no`, `fathername`, `mothername`, `email`, `mobile`, `dp`, `present_address`, `permanent_address`, `aadhar`, `dob`, `placeob`, `stateob`, `countryob`, `gender`, `nationality`, `religion`, `caste`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Vinay', 'Kumar', 'Vinay', '125CSE895', '', '', 'cse_student@raghuenggcollege.com', '9879875850', '', 'Raghu Engineering College', 'NAD Kotha Road', '', '1999-08-05', '', '', '', 'M', '', '', '', '', 1, '2017-06-15 00:00:00', '2017-06-15 00:00:00');

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
-- Table structure for table `Type_of_leave`
--

CREATE TABLE `Type_of_leave` (
  `reg_no` varchar(20) NOT NULL,
  `emp_name` varchar(35) NOT NULL,
  `sick_leave` float NOT NULL,
  `prevelege_leave` float NOT NULL,
  `compensatory_leave` float NOT NULL,
  `study_leave` float NOT NULL,
  `casual_leave` float NOT NULL,
  `Total` float NOT NULL,
  `Remaining` float NOT NULL,
  `LOP` float NOT NULL,
  `maternaty_leave` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Type_of_leave`
--

INSERT INTO `Type_of_leave` (`reg_no`, `emp_name`, `sick_leave`, `prevelege_leave`, `compensatory_leave`, `study_leave`, `casual_leave`, `Total`, `Remaining`, `LOP`, `maternaty_leave`) VALUES
('rec0001', 'Dr G CH S N RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0002', 'A VIJAY KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0003', '', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0004', 'B.UMAMAHESWAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0005', 'U SARAT', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0006', '', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0007', '', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0008', 'SK.DARYABI', 0, 0, 0, 0, 5, 6, 5, 0, 0),
('rec0009', ' K ARUN KUMAR ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0010', 'N.ANIL CHAKRAVARTHY', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0011', '', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0012', 'Dr. P MALLIKARJUNA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0013', 'B.G.MADHURI', 0, 0, 0, 0, 5.5, 6, 5.5, 0, 0),
('rec0014', 'Dr R.V.BHASKAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0015', 'B.MADHU BABU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0016', 'M MEENA KUMARI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0018', 'G.SRIDEVI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0019', 'TVS SRIRAM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0020', 'G V SIVA PRASAD', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0021', 'A.J.SIRISHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0022', 'A.DURGA PRAVEEN KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0023', 'R.NAVEEN KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0024', 'S.KRANTHI KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0025', 'K.BHANU KUMARI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0026', 'K.SATHIRAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0027', 'T P R VITAL', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0028', 'K.PHANINDER VINAY', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0029', 'M.V.SURESH KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0030', 'S.APPALA RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0031', 'M.ANIL KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0032', 'I. KRISHNA CHAITANYA', 0, 0, 0, 0, 5.5, 6, 5.5, 0, 0),
('rec0033', 'S.PRASADA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0034', 'K. TRINADHA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0035', 'J.RENUKESWARA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0036', 'D V S RAVI VARMA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0037', 'Dr A.S.PRAKASH RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0038', 'T.ANURADHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0039', 'V.TATA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0040', 'S.RAMANA BABU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0041', 'LAL BABUPRASAD', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0042', 'K.MADHAVI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0043', 'V S SUBRAHMANYAM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0044', 'V.SOMASEKHARAM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0045', 'N.MARKANDEYA GUPTA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0046', 'P.SRINIVAS', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0047', 'S.SRINADH RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0048', 'B.RAMESH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0049', 'P.RAJESH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0050', 'R KAMESWARA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0051', 'S A ANICIA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0052', 'V PARTHA SARADHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0053', 'Y.RAGHAVENDRA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0054', 'P.ANIL KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0055', 'VVN SURYANARAYANA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0056', 'Y.V.SRI CHARAN', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0057', 'YLV SANTOSH KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0058', 'P SEKHARA BABU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0059', 'N.ADILAKSHMI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0060', 'BH.V.S.NARAYANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0061', 'P.SURENDRA VARMA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0062', 'N V S S PRABHAKAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0063', 'A.SUKANYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0064', 'B SIVA RAMA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0065', 'PKVS SUBRAMANYESWARA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0066', 'P.E.SATYANARAYANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0067', 'R. SRINIVASA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0068', 'L.SATISH KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0069', 'M.VENKATA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0070', 'K.SWATHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0071', 'B.L.GANESWARA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0072', 'SHAHAZADI BEGUM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0073', 'M.RUPALI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0074', 'Dr K.SUBRAMANYAM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0075', 'P NARESH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0076', 'N.SAHADEVA RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0077', 'NIKHIL BHAT', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0078', 'N.SREELEKHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0079', 'CH LAVANYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0080', 'safd', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0081', 'Dr.T.VENKATA SWAMY', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0082', 'Y.VENKATA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0083', 'S.SANTOSH KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0085', 'M. SATYANARAYANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0086', 'P.CHNADRA SEKHAR PILLI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0087', 'Y. SATYANARAYANA RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0088', 'Dr T.RAMU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0089', 'P.VENUGOPAL', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0090', 'Dr R SRINIVASU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0091', 'A.NAGESWARA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0092', 'S S PRAKASH RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0093', 'K.SHANMUKHA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0094', 'G.SANYASI RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0095', 'Dr PANCHANAND JHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0096', 'B.SREEVIDYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0097', '', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0098', 'P. SIDDHARTHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0099', 'S.SUDHIRVARMA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0100', 'P P N G PHANI KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0101', ' Dr. V.PRAMILA MURTHY ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0102', 'P.RAJA NAVEEN', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0103', 'N S C  CHAITANYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0104', 'K.V. VARA LAKSHMI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0105', 'K PRANEETH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0106', 'DVR VASU PAVANI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0107', 'M.SURYA RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0108', 'P.SANKAR RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0109', 'SVV RAMA DEVI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0110', 'S. TEJESWAR REDDY', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0111', 'B VISALAKSHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0112', 'T.SANTHI PRIYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0113', 'S KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0114', 'MD. RAMEEZ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0115', 'Dr. PHANI RAMA KRISHNA CHUNDURY', 0, 0, 0, 0, 5.5, 6, 5.5, 0, 0),
('rec0116', 'RADHARANI NAYAK', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0117', 'VANDANA MAHANTHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0118', 'S SARALA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0119', 'D SIVA PRASAD VARMA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0120', 'L SREEDHAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0121', 'K SRINIVAS RAVI KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0122', 'K SULOCHANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0123', 'P S KRISHNAM RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0124', 'M SRIDHAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0125', 'MANISH YADAV', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0126', 'V PRAMADHA RANI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0127', 'M SHOBHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0128', 'Y E VASANTH KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0129', 'K CHINABABU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0130', 'B SUDEEPTHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0131', ' GUPTESWAR SAHU ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0132', 'D BHASKARA RAO', 0, 0, 0, 0, 5.5, 6, 5.5, 0, 0),
('rec0133', 'NETHALA RAJU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0134', 'P NAGABHUSHANAM', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0135', 'A SWETHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0136', 'BLESSY NAVARA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0137', 'K MAHESWAR RAO', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0138', 'T SURESH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0139', 'P REVATHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0141', 'Y SWAPNA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0142', 'P RAMESH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0143', 'Dr S SATYANARAYANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0144', 'P RAVI KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0145', 'AMIT KUMAR MEHAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0146', 'D SANDHYA RANI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0147', 'R SIRI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0148', 'R VIJAY SAGAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0149', 'RAJ KISHOR DAS', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0150', ' K JYOTHSNA ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0151', 'N B L V PRASAD', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0152', 'Dr T GANAPATHY', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0153', 'Dr.S RAVI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0154', 'R GOVINDA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0155', ' Dr VIVEK PANDEY ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0157', 'S P APARANJI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0158', 'T HIMA BINDU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0159', 'T KALYANI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0160', 'R VINAY KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0161', 'K H K RAGHU VAMSI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0162', 'Y S G GOVIND BABU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0163', 'MD ARIF', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0164', 'MOHD MERAJ KHAN', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0165', 'T S KAVITHA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0166', 'A VAMSIDHAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0167', 'M SRIKANTH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0168', 'Dr. M MURALI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0169', 'Y SUDHAVANI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0170', ' G RAJA KUMARI ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0171', 'P BEERSHEBA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0172', 'T. SATYANARAYANA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0173', ' Dr. B SRINIVAS ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0174', 'P.V.V. RAJAGOPAL', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0175', ' Dr. R VAIKUNTA RAO ', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0176', 'JASMINE VINCENT', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0177', 'SAI SRIKANTH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0178', 'J RAMESH NAIDU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0179', 'D UMA SANKAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0180', 'D MOUNIKA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0182', 'MUNAGAPATI MURALI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0183', 'R. SUPRIYA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0184', 'A. Rutwik', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0185', 'G. SANTOSH KUMAR VARMA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0186', 'G. SAROJA', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0187', 'M. HARISH', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0188', 'P. TEJASWI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0189', 'V. MOHANA GANDHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0190', 'D. KEERTHI', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0191', 'M. ANIL KUMAR', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('rec0192', 'M MADHU', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('REC410', 'poorna', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('RECCSE001', 'cseHOD', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('RECCSE002', 'csedean', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('RECEEE01', 'Sivarama rao', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('RECMECH001', 'Nikhil', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('RECPRI001', 'principal', 0, 0, 0, 0, 6, 6, 6, 0, 0),
('xyz123', 'apparo', 0, 0, 0, 0, 6, 6, 6, 0, 0);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `reg_no`, `password`, `utype`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'b1a5b64256e27fa5ae76d62b95209ab3', 'adm', '1234', '2017-06-12 20:30:00', '2017-06-12 20:30:00'),
(2, 'CseHod', 'RECCSE001', 'd0c65fddac5b54f5f81acd72df8f4e20', 'stf', '1235', '2017-06-14 06:59:29', '2017-06-26 03:51:46'),
(3, 'Vinay Kumar', '125CSE895', 'fedb93a39e3d11f452fb953b9ca01944', 'std', '1236', '2017-06-14 07:57:30', '2017-06-29 10:38:42'),
(4, 'poorna', 'REC410', 'bdd9a2881764e666a7f3a5abfb0e7031', 'stf', '1237', '2017-06-13 02:42:00', '2017-06-23 12:15:27'),
(5, 'principal', 'RECPRI001', 'c22396348411bfdd2ca55f92b8c676ed', 'stf', '1238', '2017-06-21 02:42:00', '2017-06-28 11:19:34'),
(6, 'Dean', 'RECCSE002', 'ff13581a6b160192e6f35f5cfc136b3f', 'stf', '1239', '2017-06-21 01:30:00', '2017-06-29 06:07:53'),
(7, 'management', 'management', 'd10af457daa1deed54e2c36b5f295e7e', 'adm', '1240', '2017-06-14 00:30:00', '2017-06-29 06:31:57'),
(8, 'leaveadmin', 'admin2', 'c84258e9c39059a89ab77d846ddab909', 'adm', '1321', '2017-05-02 01:30:00', '2017-07-04 05:15:37');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `update_users_timestamp` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
Set New.updated_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

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
-- Indexes for table `allroles`
--
ALTER TABLE `allroles`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `coff`
--
ALTER TABLE `coff`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD UNIQUE KEY `college` (`college`);

--
-- Indexes for table `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`sno`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD UNIQUE KEY `department` (`department`,`college`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD UNIQUE KEY `designation` (`designation`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`sno`),
  ADD UNIQUE KEY `holdate` (`holdate`);

--
-- Indexes for table `leavetypes`
--
ALTER TABLE `leavetypes`
  ADD PRIMARY KEY (`typeId`);

--
-- Indexes for table `leave_issues`
--
ALTER TABLE `leave_issues`
  ADD PRIMARY KEY (`leave_id`);

--
-- Indexes for table `lmscron`
--
ALTER TABLE `lmscron`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `Role`
--
ALTER TABLE `Role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `reg_no` (`reg_no`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_empid_unique` (`reg_no`),
  ADD UNIQUE KEY `staff_mobile_unique` (`mobile`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reg_no` (`reg_no`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `Type_of_leave`
--
ALTER TABLE `Type_of_leave`
  ADD UNIQUE KEY `reg_no` (`reg_no`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`reg_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `allroles`
--
ALTER TABLE `allroles`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `coff`
--
ALTER TABLE `coff`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `configuration`
--
ALTER TABLE `configuration`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT for table `leavetypes`
--
ALTER TABLE `leavetypes`
  MODIFY `typeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `leave_issues`
--
ALTER TABLE `leave_issues`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;
--
-- AUTO_INCREMENT for table `lmscron`
--
ALTER TABLE `lmscron`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `Role`
--
ALTER TABLE `Role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `sundays` ON SCHEDULE EVERY 1 YEAR STARTS '2017-01-01 01:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

call findSundays();

END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
