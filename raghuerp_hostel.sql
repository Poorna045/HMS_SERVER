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
-- Database: `raghuerp_hostel`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `bid` int(11) NOT NULL,
  `n_id` int(11) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `semstartdate` date NOT NULL,
  `semenddate` date NOT NULL,
  `hosteltype` varchar(30) NOT NULL,
  `description` varchar(300) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bid`, `n_id`, `startdate`, `enddate`, `semstartdate`, `semenddate`, `hosteltype`, `description`, `status`) VALUES
(4, 0, '2017-07-17', '2017-07-25', '2017-07-04', '2017-12-27', 'Boys', 'Bookings are open Please apply for Rooms', 'disable'),
(10, 0, '2017-08-22', '2017-09-04', '2017-09-01', '2018-01-01', 'Girls', 'Only Four AC and Three Non-AC seats Remaining For Girls', 'disable'),
(12, 11, '2017-08-28', '2017-08-30', '2017-08-01', '2017-09-30', 'Girls', 'New Bookings For Girls 5 AC and 10 Non-AC Seats are available', 'disable'),
(14, 13, '2017-09-06', '2017-09-14', '2017-09-13', '2017-11-30', 'Boys', 'Please register for Rooms', 'enable'),
(15, 14, '2017-09-05', '2017-09-15', '2017-09-13', '2017-11-30', 'Boys', 'please register for hostel rooms', 'disable'),
(16, 15, '2017-09-06', '2017-09-16', '2017-09-26', '2017-12-28', 'Girls', 'testing', 'enable');

-- --------------------------------------------------------

--
-- Table structure for table `categorytypes`
--

CREATE TABLE `categorytypes` (
  `ctid` int(11) NOT NULL,
  `categorytype` varchar(30) NOT NULL,
  `cstatus` varchar(20) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categorytypes`
--

INSERT INTO `categorytypes` (`ctid`, `categorytype`, `cstatus`) VALUES
(1, 'Hostel', 'enable'),
(2, 'Mess', 'enable');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(15) NOT NULL,
  `reg_no` varchar(30) NOT NULL,
  `complaint_type` varchar(30) NOT NULL,
  `complaint_priority` varchar(30) NOT NULL,
  `complaint_category_type` varchar(30) NOT NULL,
  `feedback` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `reg_no`, `complaint_type`, `complaint_priority`, `complaint_category_type`, `feedback`) VALUES
(1, 'admin', 'Complaint', 'High', 'Mess', 'hi'),
(2, 'rec0026', 'Complaint', 'Medium', 'Mess', 'dsad'),
(3, 'admin', 'Complaint', 'High', 'Mess', 'Rice is not good'),
(4, 'admin', 'Issue', 'High', 'Mess', 'chef  working not good'),
(5, 'rec0026', 'Complaint', 'High', 'Hostel', 'bathroom is very smell'),
(6, 'admin', 'Issue', 'High', 'Hostel', 'fan not working'),
(7, 'admin', 'Complaint', 'Medium', 'Hostel', 'Please Change My Room'),
(8, 'admin', 'Complaint', 'Medium', 'Mess', 'testing'),
(9, 'admin', 'Complaint', 'High', 'Mess', 'testing'),
(10, 'admin', 'Complaint', 'Medium', 'Mess', 'xzcg'),
(11, 'admin', 'Issue', 'High', 'Mess', 'popup testing'),
(12, 'admin', 'Issue', 'Medium', 'Hostel', 'sadf;lnfoasdl'),
(13, 'admin', 'Issue', 'High', 'Mess', 'adsfdsa'),
(14, 'admin', 'Issue', 'High', 'Hostel', 'fdsgf'),
(15, 'admin', 'Complaint', 'High', 'Hostel', 'repair fan in room no 101 Boys hostel'),
(16, 'rec0094', 'Complaint', 'Medium', 'Mess', 'No Chicken...need chiken biriyani'),
(17, 'rec0094', 'Issue', 'High', 'Hostel', 'Smell..worest condition of thw bed and frustation with roommates.'),
(18, 'rec0094', 'Complaint', 'Medium', 'Hostel', 'Washroom water');

-- --------------------------------------------------------

--
-- Table structure for table `feeconfig`
--

CREATE TABLE `feeconfig` (
  `fid` int(11) NOT NULL,
  `roomtype` varchar(30) NOT NULL,
  `totaldues` int(11) NOT NULL,
  `totalamount` int(11) NOT NULL,
  `amt_perdue` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feeconfig`
--

INSERT INTO `feeconfig` (`fid`, `roomtype`, `totaldues`, `totalamount`, `amt_perdue`) VALUES
(1, 'AC', 3, 18000, 6000),
(2, 'Non-AC', 3, 15000, 5000);

-- --------------------------------------------------------

--
-- Table structure for table `hostelconfig`
--

CREATE TABLE `hostelconfig` (
  `hid` int(11) NOT NULL,
  `hostelname` varchar(50) NOT NULL,
  `hosteltype` varchar(20) NOT NULL,
  `floors` int(11) NOT NULL,
  `hlocation` text NOT NULL,
  `hstatus` varchar(30) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hostelconfig`
--

INSERT INTO `hostelconfig` (`hid`, `hostelname`, `hosteltype`, `floors`, `hlocation`, `hstatus`) VALUES
(1, 'Boys Delux 1', 'Boys', 4, 'Raghu Engineering College,Boys', 'enable'),
(2, 'Girls Delux 1', 'Girls', 3, 'Raghu Engineering College,Girls', 'enable'),
(3, 'Boys Delux 3', 'Boys', 6, 'Maddilapalem,Boys', 'enable'),
(4, 'Girls Delux 3', 'Girls', 6, 'Maddilapalem,Girls', 'enable');

-- --------------------------------------------------------

--
-- Table structure for table `instructions`
--

CREATE TABLE `instructions` (
  `i_id` int(11) NOT NULL,
  `instructiondate` date NOT NULL,
  `i_created_at` datetime NOT NULL,
  `instructiondescription` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instructions`
--

INSERT INTO `instructions` (`i_id`, `instructiondate`, `i_created_at`, `instructiondescription`) VALUES
(1, '2017-08-01', '2017-08-22 09:17:59', 'Welcome to my personal campaign for Heart of Missouri United Way, and thank you for taking a minute to check it out. When you support United Way, you do more than reach out to people in urgent need right now. You also support meaningful, lasting change that impacts everyone in our mid-Missouri community. Please help me make a difference by giving from your heart and making a donation to Heart of Missouri United Way. Together, we can achieve so much more than we ever could alone. '),
(2, '2017-08-23', '2017-08-22 09:55:51', 'In business writing, technical writing, and other forms of composition, instructions are written or spoken directions for carrying out a procedure or performing a task. Also called instructive writing.'),
(3, '2017-08-22', '2017-08-22 09:58:29', 'I used these examples of instructions when starting a block of literacy focusing on instruction writing.'),
(4, '2017-08-24', '2017-08-23 12:23:11', 'asadaf');

-- --------------------------------------------------------

--
-- Table structure for table `maintenancedata`
--

CREATE TABLE `maintenancedata` (
  `mdid` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `billtype` varchar(30) NOT NULL,
  `paymentdate` datetime NOT NULL,
  `cost` float NOT NULL,
  `receipt_no` varchar(20) NOT NULL,
  `ctype` varchar(30) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maintenancedata`
--

INSERT INTO `maintenancedata` (`mdid`, `reg_no`, `billtype`, `paymentdate`, `cost`, `receipt_no`, `ctype`, `description`) VALUES
(7, 'admin', 'Electrician Services', '2017-08-24 18:30:00', 4320, '2351', 'Hostel', 'repaired fans in Boys hostel'),
(8, 'admin', 'Elevator Services', '2017-08-30 18:30:00', 50, '234', 'Mess', 'Fixed Elevator Problem in Mess'),
(12, 'admin', 'Electrician Services', '2017-08-01 14:54:06', 23452, '324', 'Mess', 'Repaired Boards in Mess '),
(13, 'admin', 'Carpentry Services', '2017-08-23 16:37:06', 23342, '2341', 'Mess', 'Done Carpentry works in Kitchen'),
(14, 'admin', 'Electrician Services', '2017-08-23 16:38:02', 1232, '1234', 'Mess', 'Repaired Kitchen Items'),
(15, 'rec0154', 'Plumbing Services', '2017-08-28 10:12:12', 15000.5, '1231', 'Hostel', 'Done Plumbing Works in Boys Wash Room ');

-- --------------------------------------------------------

--
-- Table structure for table `maintenanceservices`
--

CREATE TABLE `maintenanceservices` (
  `bid` int(11) NOT NULL,
  `billtype` varchar(40) NOT NULL,
  `bstatus` varchar(15) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maintenanceservices`
--

INSERT INTO `maintenanceservices` (`bid`, `billtype`, `bstatus`) VALUES
(7, 'Carpentry Services', 'enable'),
(8, 'Electrician Services', 'enable'),
(9, 'Elevator Services', 'enable'),
(10, 'Grounds Services', 'enable'),
(11, 'Light bulbs', 'enable'),
(12, 'Pest Control', 'enable'),
(13, 'Plumbing Services', 'enable');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `n_id` int(11) NOT NULL,
  `notificationdate` date NOT NULL,
  `created_at` datetime NOT NULL,
  `noticedescription` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`n_id`, `notificationdate`, `created_at`, `noticedescription`) VALUES
(8, '2017-08-28', '2017-08-28 09:39:38', '05-sep-2017 is the Last Date for 4-1 Advance Supply Fee Payment'),
(9, '2017-08-29', '2017-08-28 17:17:35', 'Bookings are open for Boys'),
(11, '2017-08-28', '2017-08-28 17:30:11', 'New Bookings For Girls 5 AC and 10 Non-AC Seats are available , Last Date : 2017-08-30'),
(12, '2017-09-05', '2017-09-07 11:20:09', 'tyry  Last Date : 2017-09-13'),
(13, '2017-09-06', '2017-09-08 11:35:08', 'Please register for Rooms  Last Date : 2017-09-14'),
(14, '2017-09-08', '2017-09-08 15:34:42', 'please register for hostel rooms , Last Date : 2017-09-10'),
(15, '2017-09-14', '2017-09-13 10:47:19', 'testing  Last Date : 2017-09-16');

-- --------------------------------------------------------

--
-- Table structure for table `registereddetails`
--

CREATE TABLE `registereddetails` (
  `registerid` int(11) NOT NULL,
  `reg_no` varchar(15) NOT NULL,
  `registereddate` datetime NOT NULL,
  `roomtype` varchar(20) NOT NULL,
  `typepriority` varchar(20) NOT NULL,
  `selectedtype` varchar(20) NOT NULL,
  `hostellocation` text NOT NULL,
  `locationpriority` text NOT NULL,
  `selectedlocation` text NOT NULL,
  `distance` varchar(10) NOT NULL,
  `utype` varchar(10) NOT NULL,
  `rstatus` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `registereddetails`
--

INSERT INTO `registereddetails` (`registerid`, `reg_no`, `registereddate`, `roomtype`, `typepriority`, `selectedtype`, `hostellocation`, `locationpriority`, `selectedlocation`, `distance`, `utype`, `rstatus`) VALUES
(1, '125CSE895', '2017-09-08 04:17:06', '1', '1', '1', '2', '2', '', '150', 'std', 'selected'),
(2, 'rec539', '2017-09-07 06:09:00', '2', '2', '2', '2', '2', '', '100', 'std', 'selected'),
(4, '123987', '2017-08-29 06:09:00', 'all', '6', '', '1', '1', '', '100', 'std', 'pending'),
(5, 'rec0092', '2017-08-22 04:17:06', '1', '1', '', 'all', '2', '', '150', 'stf', 'pending'),
(7, 'rec0091', '2017-08-22 04:17:06', '6', '6', '6', 'all', '1', '', '150', 'stf', 'deallocated'),
(8, 'CSE2CR', '2017-08-29 06:09:00', 'all', '2', '', '1', '1', '', '100', 'stf', 'pending'),
(9, '13981A0507', '2017-09-04 11:55:34', 'all', '2', '', '3', '3', '', '', 'stf', 'pending'),
(10, 'rec0050', '2017-09-04 11:57:14', '2', '2', '', 'all', '2', '', '', 'stf', 'pending'),
(11, 'rec00082', '2017-09-10 13:18:14', '2', '2', '', 'all', '2', '', '', 'std', 'pending'),
(12, 'rec0123', '2017-09-05 11:48:16', 'all', '6', '', '3', '3', '', '', 'stf', 'pending'),
(14, 'rec9977', '2017-09-06 14:20:44', '1', '1', '6', '1', '1', '', '', 'stf', 'deallocated'),
(16, 'rec034', '2017-09-06 14:24:44', '1', '1', '', '2', '2', '', '', 'std', 'waiting'),
(17, 'rec0080', '2017-09-06 14:27:59', '2', '2', '', '3', '3', '', '', 'stf', 'pending'),
(18, 'RECCSE548', '2017-09-14 16:39:48', '1', '1', '1', '1', '1', '1', '', 'stf', 'selected'),
(19, 'RECECE3ACR', '2017-09-14 16:49:39', 'all', '6', '', '3', '1', '', '', 'std', 'pending'),
(20, 'rec9998', '2017-09-14 09:13:19', 'all', '2', '2', '1', '1', '1', '', 'stf', 'selected'),
(21, 'rec507', '2017-09-15 09:21:17', 'all', '1', '1', '2', '2', '2', '', 'std', 'selected');

-- --------------------------------------------------------

--
-- Table structure for table `roomdetails`
--

CREATE TABLE `roomdetails` (
  `rid` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `roomno` int(11) NOT NULL,
  `bedno` int(11) NOT NULL,
  `utype` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomdetails`
--

INSERT INTO `roomdetails` (`rid`, `reg_no`, `roomno`, `bedno`, `utype`) VALUES
(2, 'RECECE2ACR', 1, 3, 'std'),
(4, 'rec539', 9, 3, 'std'),
(5, 'RECECE4ACR', 5, 2, 'std'),
(7, 'reccse002', 1, 1, 'std'),
(8, 'CSE2CR', 1, 4, 'std'),
(9, '2018ca1', 13, 1, 'std');

-- --------------------------------------------------------

--
-- Table structure for table `roomsconfig`
--

CREATE TABLE `roomsconfig` (
  `rcid` int(11) NOT NULL,
  `roomno` varchar(20) NOT NULL,
  `avlbeds` int(11) NOT NULL,
  `totbeds` int(11) NOT NULL,
  `rcstatus` varchar(20) NOT NULL DEFAULT 'available',
  `roomtype` varchar(20) NOT NULL,
  `roomrent` float NOT NULL,
  `hostelid` int(11) NOT NULL,
  `floorno` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomsconfig`
--

INSERT INTO `roomsconfig` (`rcid`, `roomno`, `avlbeds`, `totbeds`, `rcstatus`, `roomtype`, `roomrent`, `hostelid`, `floorno`) VALUES
(1, '101', 3, 6, 'available', '1', 35000, 1, 'g'),
(2, '102', 4, 4, 'available', '2', 28000, 2, 'g'),
(3, '103', 5, 5, 'available', '1', 32000, 2, '1'),
(4, '104', 5, 5, 'available', '2', 30000, 3, '1'),
(5, '105', 5, 5, 'available', '1', 35000, 3, '2'),
(6, '106', 4, 4, 'available', '1', 32000, 2, '2'),
(7, '106', 5, 5, 'available', '2', 30000, 3, '2'),
(8, '112', 6, 6, 'available', '2', 28000, 2, '3'),
(9, '109', 4, 5, 'available', '6', 31900, 1, '3'),
(10, '134', 5, 5, 'available', '2', 30000, 2, '3'),
(11, '1034', 6, 6, 'available', '6', 35000, 2, '3'),
(12, '13212', 2, 2, 'available', '2', 25000, 3, '2'),
(13, '1034', 2, 3, 'available', '1', 19999, 1, '4'),
(14, '21122', 4, 4, 'available', '2', 25900, 4, '2'),
(16, '23443', 3, 3, 'available', '6', 231213, 3, '3');

-- --------------------------------------------------------

--
-- Table structure for table `roomtype`
--

CREATE TABLE `roomtype` (
  `typeid` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'enable',
  `hostels` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`typeid`, `type`, `status`, `hostels`) VALUES
(1, 'AC', '', '2,1'),
(2, 'Non-AC', '', '1,3,4,2'),
(6, 'AC Delux', '', '1,3');

-- --------------------------------------------------------

--
-- Table structure for table `upcomingevents`
--

CREATE TABLE `upcomingevents` (
  `e_id` int(11) NOT NULL,
  `eventtype` varchar(500) NOT NULL,
  `eventdate` date NOT NULL,
  `eventtime` varchar(16) NOT NULL,
  `event_created_at` datetime NOT NULL,
  `eventdescription` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `upcomingevents`
--

INSERT INTO `upcomingevents` (`e_id`, `eventtype`, `eventdate`, `eventtime`, `event_created_at`, `eventdescription`) VALUES
(1, 'freshers party', '2017-07-03', '10:30 AM', '2017-08-22 11:02:16', 'REC CSE 1st Year Freshers Party in Indoor Stadium'),
(7, 'NAAC ', '2017-09-21', '11:00 AM', '2017-08-28 09:41:58', 'Naac for RIT ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `categorytypes`
--
ALTER TABLE `categorytypes`
  ADD PRIMARY KEY (`ctid`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feeconfig`
--
ALTER TABLE `feeconfig`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `hostelconfig`
--
ALTER TABLE `hostelconfig`
  ADD PRIMARY KEY (`hid`);

--
-- Indexes for table `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`i_id`);

--
-- Indexes for table `maintenancedata`
--
ALTER TABLE `maintenancedata`
  ADD PRIMARY KEY (`mdid`);

--
-- Indexes for table `maintenanceservices`
--
ALTER TABLE `maintenanceservices`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`n_id`);

--
-- Indexes for table `registereddetails`
--
ALTER TABLE `registereddetails`
  ADD PRIMARY KEY (`registerid`),
  ADD UNIQUE KEY `reg_no` (`reg_no`);

--
-- Indexes for table `roomdetails`
--
ALTER TABLE `roomdetails`
  ADD PRIMARY KEY (`rid`),
  ADD UNIQUE KEY `reg_no` (`reg_no`);

--
-- Indexes for table `roomsconfig`
--
ALTER TABLE `roomsconfig`
  ADD PRIMARY KEY (`rcid`);

--
-- Indexes for table `roomtype`
--
ALTER TABLE `roomtype`
  ADD PRIMARY KEY (`typeid`);

--
-- Indexes for table `upcomingevents`
--
ALTER TABLE `upcomingevents`
  ADD PRIMARY KEY (`e_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `categorytypes`
--
ALTER TABLE `categorytypes`
  MODIFY `ctid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `feeconfig`
--
ALTER TABLE `feeconfig`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hostelconfig`
--
ALTER TABLE `hostelconfig`
  MODIFY `hid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `instructions`
--
ALTER TABLE `instructions`
  MODIFY `i_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `maintenancedata`
--
ALTER TABLE `maintenancedata`
  MODIFY `mdid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `maintenanceservices`
--
ALTER TABLE `maintenanceservices`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `registereddetails`
--
ALTER TABLE `registereddetails`
  MODIFY `registerid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `roomdetails`
--
ALTER TABLE `roomdetails`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `roomsconfig`
--
ALTER TABLE `roomsconfig`
  MODIFY `rcid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `roomtype`
--
ALTER TABLE `roomtype`
  MODIFY `typeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `upcomingevents`
--
ALTER TABLE `upcomingevents`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
