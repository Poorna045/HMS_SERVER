-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 04, 2017 at 02:29 PM
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
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `semstartdate` date NOT NULL,
  `semenddate` date NOT NULL,
  `description` varchar(300) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bid`, `startdate`, `enddate`, `semstartdate`, `semenddate`, `description`, `status`) VALUES
(4, '2017-07-17', '2017-07-25', '2017-07-04', '2017-12-27', 'Bookings are open Please apply for Rooms', 'disable'),
(5, '2017-08-02', '2017-08-04', '2017-08-07', '2017-12-02', 'hello', 'enable'),
(7, '1970-01-01', '1970-01-01', '2017-08-22', '1970-01-01', 'testing', 'enable');

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
  `id` int(11) NOT NULL,
  `hostels` int(11) NOT NULL,
  `rooms` int(11) NOT NULL,
  `beds` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `registrationdetails`
--

CREATE TABLE `registrationdetails` (
  `registrationid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `reg_no` varchar(30) NOT NULL,
  `priority` varchar(15) NOT NULL,
  `type` varchar(15) NOT NULL,
  `registerdate` datetime NOT NULL,
  `studentname` varchar(30) NOT NULL,
  `dateofbirth` date NOT NULL,
  `genderT` varchar(20) NOT NULL,
  `pwd` varchar(10) NOT NULL DEFAULT '0',
  `distance` int(11) NOT NULL,
  `roomtype` varchar(15) NOT NULL,
  `fathername` varchar(35) NOT NULL,
  `occupation` varchar(35) NOT NULL,
  `parentmobile` int(20) NOT NULL,
  `parentemail` varchar(50) NOT NULL,
  `permanentaddress` varchar(150) NOT NULL,
  `parentaddress` varchar(150) NOT NULL,
  `guardianname` varchar(35) NOT NULL,
  `guardianrelation` varchar(30) NOT NULL,
  `guardianmobile` int(20) NOT NULL,
  `guardianemail` varchar(50) NOT NULL,
  `guardianaddress` varchar(150) NOT NULL,
  `guardianpermanentaddress` varchar(150) NOT NULL,
  `rstatus` varchar(15) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `registrationdetails`
--

INSERT INTO `registrationdetails` (`registrationid`, `pid`, `reg_no`, `priority`, `type`, `registerdate`, `studentname`, `dateofbirth`, `genderT`, `pwd`, `distance`, `roomtype`, `fathername`, `occupation`, `parentmobile`, `parentemail`, `permanentaddress`, `parentaddress`, `guardianname`, `guardianrelation`, `guardianmobile`, `guardianemail`, `guardianaddress`, `guardianpermanentaddress`, `rstatus`) VALUES
(1, 1, 'CSE2CR', 'AC', 'Non-AC', '0000-00-00 00:00:00', 'venkat', '1989-08-02', 'M', '0', 50, 'all', 'T.A.Achari', 'Goldsmith', 2147483647, 'venkatasait336@gmail.com', 'RTCCOMPLEX', 'RTCCOMPLEX', 'venkat', 'brother', 2147483647, 'venkat@gmail.com', 'RTCCOMPLEX', 'RTCCOMPLEX', 'Accepted'),
(2, 0, 'CSE1CR', 'AC', 'all', '0000-00-00 00:00:00', 'Pravalika', '1990-12-29', 'F', '0', 100, 'all', 'Achari', 'business', 2147483647, 'chari@gmail.com', 'vskp', 'vskp', 'ram', 'Brother', 2147483647, 'ram@gmail.com', 'vskp', 'vskp', 'Pending'),
(3, 0, 'RECECE2ACR', 'AC', 'AC', '0000-00-00 00:00:00', 'Poorna Chand', '1991-08-01', 'M', '1', 150, 'AC', 'Ramarao', 'Employee', 2147483647, 'ramarao@gmail.com', 'pendurthi', 'pendurthi', 'kalyan', 'Brother', 2147483647, 'kalyan@gmail.com', 'vskp', 'vskp', 'Pending'),
(4, 0, '4', 'AC', 'AC', '2017-08-02 10:38:46', 'Rambabu', '1988-12-12', 'M', '0', 10, 'AC', 'Laxmana', 'business', 2147483647, 'laxman@gmail.com', 'vskp', 'vskp', 'babu', 'Brother', 2147483647, 'babu@gmail.com', 'vskp', 'vskp', 'Pending'),
(5, 0, '5', 'Non-AC', 'all', '2017-08-02 11:02:11', 'Ravi', '1991-09-02', 'M', '1', 500, 'all', 'Appalaswami', 'farmer', 2147483647, 'appalaswami@gmail.com', 'vijayawada', 'vijayawada', 'Sravan', 'Uncle', 897456231, 'sravan123@gmail.com', 'vijayanagaram', 'vijayanagaram', 'Pending'),
(6, 0, '6', 'Non-AC', 'all', '2017-08-02 11:05:12', 'Praveen', '1989-12-12', 'M', '1', 500, 'all', 'Durga Prasad', 'Employee', 896325417, 'durgaprasad@gmail.com', 'vijayawada', 'vijayawada', 'sagar', 'Uncle', 897456231, 'sagar123@gmail.com', 'vijayanagaram', 'vijayanagaram', 'Pending'),
(7, 0, 'RECECE4ACR', 'Non-AC', 'Non-AC', '2017-08-02 11:12:26', 'Mehar', '1990-10-12', 'M', '0', 200, 'Non-AC', 'Pawan Kalyan', 'Employee', 897456321, 'pawankalyan@gmail.com', 'Bhimavaram', 'Bhimavaram', 'bhaskar', 'uncle', 789456321, 'bhaskar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(8, 0, '8', 'Non-AC', 'Non-AC', '2017-08-02 11:42:33', 'Ganesh', '1991-10-13', 'M', '1', 250, 'Non-AC', 'Kalyan srinivas', 'business', 2147483647, 'kalyansrinivasn@gmail.com', 'Bhimavaram', 'Bhimavaram', 'Harish', 'Brother', 874589632, 'Harish123@gmail.com', 'vskp', 'vskp', 'Pending'),
(9, 0, 'RECECE3ACR', 'AC', 'AC', '2017-08-02 11:44:45', 'admin', '1990-05-13', 'M', '0', 250, 'AC', 'srinivas', 'business', 2147483647, 'srinivas@gmail.com', 'vijayawada', 'vijayawada', 'Harikumar', 'Brother', 2147483647, 'Harikumar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(10, 0, '10', 'AC', 'AC', '2017-08-02 11:46:10', 'admin', '1990-05-13', 'M', '0', 250, 'AC', 'anilkumar', 'Farmer', 2147483647, 'anil@gmail.com', 'vijayawada', 'vijayawada', 'akhil', 'Brother', 2147483647, 'akhil123@gmail.com', 'vskp', 'vskp', 'Pending'),
(11, 0, 'ritcse3a', 'Non-AC', 'Non-AC', '2017-08-02 11:49:35', 'Rithika', '1989-06-13', 'F', '0', 250, 'Non-AC', 'Naidu', 'Farmer', 2147483647, 'naidu@gmail.com', 'vijayawada', 'vijayawada', 'rajashekar', 'Brother', 2147483647, 'rajashekar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(12, 0, '12', 'Non-AC', 'Non-AC', '2017-08-02 11:51:01', 'admin', '1990-01-13', 'M', '0', 250, 'Non-AC', 'Murali', 'Farmer', 2147483647, 'murali1523@gmail.com', 'vijayawada', 'vijayawada', 'krishna', 'uncle', 2147483647, 'krishna143@gmail.com', 'vskp', 'vskp', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `roomdetails`
--

CREATE TABLE `roomdetails` (
  `rid` int(11) NOT NULL,
  `reg_no` varchar(20) NOT NULL,
  `roomno` int(11) NOT NULL,
  `bedno` int(11) NOT NULL,
  `hsttype` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomdetails`
--

INSERT INTO `roomdetails` (`rid`, `reg_no`, `roomno`, `bedno`, `hsttype`) VALUES
(1, 'CSE2CR', 101, 1, 'Boys'),
(2, 'RECECE2ACR', 101, 3, 'Boys'),
(3, 'RECECE3ACR', 106, 1, 'Boys'),
(4, 'CSE1CR', 106, 3, 'Girls'),
(5, 'RECECE4ACR', 105, 2, 'Boys'),
(6, 'ritcse3a', 103, 3, 'Girls');

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
  `hosteltype` varchar(20) NOT NULL,
  `hostelid` int(11) NOT NULL,
  `blockid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomsconfig`
--

INSERT INTO `roomsconfig` (`rcid`, `roomno`, `avlbeds`, `totbeds`, `rcstatus`, `roomtype`, `hosteltype`, `hostelid`, `blockid`) VALUES
(1, '101', 3, 5, 'available', 'AC', 'Boys', 12, 1),
(2, '102', 4, 4, 'available', 'Non-AC', 'Girls', 12, 4),
(3, '103', 4, 5, 'available', 'AC', 'Girls', 11, 6),
(4, '104', 5, 5, 'available', 'Non-AC', 'Boys', 14, 2),
(5, '105', 4, 5, 'available', 'AC', 'Boys', 12, 5),
(6, '106', 3, 4, 'available', 'AC', 'Girls', 14, 2),
(7, '106', 3, 4, 'available', 'Non-AC', 'Boys', 12, 2);

-- --------------------------------------------------------

--
-- Table structure for table `roomtype`
--

CREATE TABLE `roomtype` (
  `typeid` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `totalcount` int(11) NOT NULL,
  `cost` varchar(20) NOT NULL,
  `totaldues` int(11) NOT NULL,
  `amt_perdue` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`typeid`, `type`, `totalcount`, `cost`, `totaldues`, `amt_perdue`, `status`) VALUES
(1, 'AC', 50, '18000', 3, 6000, 'enable'),
(2, 'Non-AC', 100, '15000', 3, 5000, 'enable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `feeconfig`
--
ALTER TABLE `feeconfig`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `hostelconfig`
--
ALTER TABLE `hostelconfig`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registrationdetails`
--
ALTER TABLE `registrationdetails`
  ADD PRIMARY KEY (`registrationid`),
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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `feeconfig`
--
ALTER TABLE `feeconfig`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hostelconfig`
--
ALTER TABLE `hostelconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `registrationdetails`
--
ALTER TABLE `registrationdetails`
  MODIFY `registrationid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `roomdetails`
--
ALTER TABLE `roomdetails`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `roomsconfig`
--
ALTER TABLE `roomsconfig`
  MODIFY `rcid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `roomtype`
--
ALTER TABLE `roomtype`
  MODIFY `typeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
