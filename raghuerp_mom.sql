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
-- Database: `raghuerp_mom`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE `actions` (
  `acid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `actdescription` longtext NOT NULL,
  `actresponsibleperson` longtext NOT NULL,
  `actexpectcompletion` date NOT NULL,
  `acstatus` varchar(20) NOT NULL DEFAULT 'pending',
  `actualcompdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`acid`, `mid`, `actdescription`, `actresponsibleperson`, `actexpectcompletion`, `acstatus`, `actualcompdate`) VALUES
(1, 1, 'sadf', 'rec0010', '2017-08-22', 'pending', '0000-00-00'),
(2, 1, 'sadf', 'rec0067', '2017-08-22', 'pending', '0000-00-00'),
(3, 1, 'sadf', 'rec0032', '2017-08-22', 'pending', '0000-00-00'),
(4, 1, 'dsfa', 'rec0067', '2017-08-24', 'pending', '0000-00-00'),
(5, 1, 'dsfa', 'rec0032', '2017-08-24', 'pending', '0000-00-00'),
(6, 1, 'dsfa', 'rec0018', '2017-08-24', 'pending', '0000-00-00'),
(7, 2, 'sadf', 'RECMECH001', '2017-08-15', 'completed', '2017-08-17'),
(8, 2, 'sadf', 'rec0153', '2017-08-15', 'pending', '0000-00-00'),
(9, 3, 'sdfa', 'rec0153', '2017-08-02', 'pending', '0000-00-00'),
(10, 3, 'sdfa', 'rec0148', '2017-08-02', 'pending', '0000-00-00'),
(11, 3, 'sfad', 'rit0069', '2017-08-30', 'pending', '0000-00-00'),
(12, 3, 'sfad', 'RECMECH001', '2017-08-30', 'pending', '0000-00-00'),
(13, 4, 'dfs', 'rec0134', '2017-08-16', 'pending', '0000-00-00'),
(14, 4, 'dfs', 'RECMECH001', '2017-08-16', 'pending', '0000-00-00'),
(15, 4, 'dsf', 'rec0134', '2017-08-15', 'pending', '0000-00-00'),
(16, 4, 'dsf', 'rec0072', '2017-08-15', 'pending', '0000-00-00'),
(17, 5, 'fd', 'rec0067', '2017-08-15', 'completed', '2017-08-25'),
(18, 5, 'fd', 'rec0176', '2017-08-15', 'pending', '0000-00-00'),
(19, 5, 'fd', 'rec0148', '2017-08-15', 'pending', '0000-00-00'),
(20, 6, 'Prepare Presentation', 'rit0206', '2017-08-18', 'pending', '0000-00-00'),
(21, 6, 'Prepare Schedule', 'rec0130', '2017-08-14', 'pending', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `agenda`
--

CREATE TABLE `agenda` (
  `agid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `agtopic` longtext NOT NULL,
  `agresponsibleperson` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `agenda`
--

INSERT INTO `agenda` (`agid`, `mid`, `agtopic`, `agresponsibleperson`) VALUES
(1, 1, 'hostel', 'rec0130'),
(2, 1, 'hostel', 'rec0072'),
(3, 1, 'hostel', 'rec0036'),
(4, 1, 'hostel', 'rec0017'),
(5, 1, 'sda', 'rec0130'),
(6, 1, 'sda', 'RECCSE001'),
(7, 2, 'dsfa', 'rec0130'),
(8, 2, 'dsfa', 'rec0153'),
(9, 2, 'sadf', 'rec0153'),
(10, 2, 'sadf', 'rec0130'),
(11, 3, 'sdaf', 'rit0083'),
(12, 3, 'sdaf', 'rit0118'),
(13, 4, 'sfda', 'rec0124'),
(14, 4, 'sfda', 'rec0072'),
(15, 4, 'safddsfa', 'rec0072'),
(16, 4, 'safddsfa', 'rec0134'),
(17, 5, 'dfsg', 'rec0148'),
(18, 5, 'dfsg', 'rec0060'),
(19, 6, 'NAAC-A', 'rec0124'),
(20, 6, 'NAAC-B', 'rec0016');

-- --------------------------------------------------------

--
-- Table structure for table `decisions`
--

CREATE TABLE `decisions` (
  `did` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `decisiontaken` longtext NOT NULL,
  `dedescription` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `decisions`
--

INSERT INTO `decisions` (`did`, `mid`, `decisiontaken`, `dedescription`) VALUES
(1, 1, 'rec0130', 'sdfa'),
(2, 1, 'rec0162', 'sdfa'),
(3, 1, 'rit0207', 'sdfa'),
(4, 1, 'rec0072', 'fsda'),
(5, 1, 'rec0010', 'fsda'),
(6, 1, 'rec0067', 'fsda'),
(7, 2, 'rec0006', 'sdaf'),
(8, 2, 'rit0207', 'sdaf'),
(9, 2, 'rec0148', 'sdaf'),
(10, 3, 'rit0118', 'safd'),
(11, 3, 'rit0083', 'safd'),
(12, 3, 'rec0153', 'sfda'),
(13, 3, 'rec0148', 'sfda'),
(14, 4, 'rec0134', 'fds'),
(15, 4, 'rec0072', 'fds'),
(16, 4, 'rec0134', 'sdf'),
(17, 4, 'rec0072', 'sdf'),
(18, 5, 'rec0148', 'gf'),
(19, 5, 'rec0130', 'gf'),
(20, 5, 'rec0176', 'gf'),
(21, 5, 'rec0067', 'dfsg'),
(22, 5, 'rec0080', 'dfsg'),
(23, 5, 'rec0153', 'dfsg'),
(24, 6, 'rit0001', 'No holiday on Sunday, 20th Aug'),
(25, 6, 'rec0124', 'Compensatory on Any other working day');

-- --------------------------------------------------------

--
-- Table structure for table `meetingdetails`
--

CREATE TABLE `meetingdetails` (
  `mid` int(11) NOT NULL,
  `meetingname` tinytext NOT NULL,
  `facilitator` longtext NOT NULL,
  `meetingdate` date NOT NULL,
  `meetingtime` varchar(20) NOT NULL,
  `meetingduration` varchar(20) NOT NULL,
  `location` text NOT NULL,
  `presences` longtext NOT NULL,
  `absences` longtext NOT NULL,
  `reg_no` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meetingdetails`
--

INSERT INTO `meetingdetails` (`mid`, `meetingname`, `facilitator`, `meetingdate`, `meetingtime`, `meetingduration`, `location`, `presences`, `absences`, `reg_no`) VALUES
(1, 'busses', 'rec0032,rec0067,rec0010', '2017-08-18', '09:45:00', '1 hr 30 min', 'conference hall', 'rec0032,rec0067,rec0010,rit0207,rit0202,RECCSE001,rit0198,rec0022,rec0019,rec0018,rec0017,rec0036,rec0031,rec0030,rec0060,rec0047,rec0099', 'rec0072,rec0130,rec0162', 'admin'),
(2, 'asdf', 'rec0032,rec0067,rec0130', '2017-08-08', '09:00:00', '6 hrs', 'sdfasdfa', 'rec0032,rec0067,rec0130,rec0006,rec0003,rit0202', 'rec0153,rec0148,rit0207', 'admin'),
(3, 'sadf', 'rit0118,rit0083,rit0069', '2017-08-09', '07:30:00', '4 hrs', 'sadf', 'rit0118,rit0083,rit0069', 'rec0148,rec0153', 'admin'),
(4, 'sdf', 'rec0124,rec0072', '2017-08-16', '07:00:00', '6 hrs 30 min', 'sdfa', 'rec0124,rec0072', 'rec0134,rec0130', 'rec0123'),
(5, 'fdsag', 'rec0067,rec0176,rec0010,rec0031,rec0080', '2017-08-24', '08:30:00', '6 hrs', 'sadg', 'rec0067,rec0176,rec0010,rec0031,rec0080,rec0022,rec0027,rec0061,rec0060', 'rec0153,rec0148,rec0134,rec0130', 'admin'),
(6, 'NAAC', 'rit0001', '2017-08-17', '7:00 AM', '1 hr 30 min', 'aaa', 'rit0001,rec0124,rec0130,rit0206,rec0016,rit0088,rit0082,rit0062', 'RECCSE001,rec0060,rec0154,rec0079,rec0089', 'RECMECH001');

-- --------------------------------------------------------

--
-- Table structure for table `nextmeeting`
--

CREATE TABLE `nextmeeting` (
  `nid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `nextagendadesc` longtext NOT NULL,
  `nextdate` date NOT NULL,
  `nexttime` varchar(20) NOT NULL,
  `nextvenue` text NOT NULL,
  `nextfacilitator` longtext NOT NULL,
  `attendeeslist` longtext NOT NULL,
  `nextexpmeetdate` text NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nextmeeting`
--

INSERT INTO `nextmeeting` (`nid`, `mid`, `nextagendadesc`, `nextdate`, `nexttime`, `nextvenue`, `nextfacilitator`, `attendeeslist`, `nextexpmeetdate`, `status`) VALUES
(1, 1, 'sdaf', '2017-08-09', '7:00 AM', 'dsfa', 'rec0134,rec0130,rec0124', 'rec0134,rec0130,rec0124,rit0207,rit0202,rit0198', '', 'Sure'),
(2, 2, 'sadf', '2017-08-29', '7:00 AM', 'sadf', 'rec0124,rec0072', 'rec0124,rec0072,rec0134', '', 'Sure'),
(3, 3, 'sadf', '0000-00-00', 's', '', 'rec0124,rec0072', 'rec0124,rec0072,rec0134', 'sadf', 'Expected'),
(4, 4, 'dfs', '2017-08-30', '7:45 AM', 'gsd', 'rec0067,rit0202', 'rec0067,rit0202,rec0153', '', 'Sure'),
(5, 5, 'ds', '2017-08-30', '9:15 AM', 'dg', 'rec0124,rec0072', 'rec0124,rec0072,RECCSE001,rec0176', '', 'Sure'),
(6, 6, 'Review', '2017-08-19', '7:00 AM', 'BBB', 'rec0072', 'rec0072,rec0176,rec0007,rec0006,rec0027,rec0030,rec0060,rec0061', '', 'Sure');

-- --------------------------------------------------------

--
-- Table structure for table `objectives`
--

CREATE TABLE `objectives` (
  `oid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `objective` longtext NOT NULL,
  `objdescription` longtext NOT NULL,
  `objowner` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `objectives`
--

INSERT INTO `objectives` (`oid`, `mid`, `objective`, `objdescription`, `objowner`) VALUES
(1, 1, 'sdaf', 'dsfa', ''),
(2, 2, 'dsf', 'sfad', ''),
(3, 2, 'sadf', 'fsda', ''),
(4, 3, 'asdf', 'sdfa', ''),
(5, 4, 'sdaf', 'dfsa', ''),
(6, 4, 'sdag', 'gfd', ''),
(7, 5, 'gsd', 'g', 'rec0148'),
(8, 5, 'gsd', 'g', 'rec0153'),
(9, 5, 'gsd', 'g', 'rec0067'),
(10, 5, 'dsg', 'dfsfgh', 'rec0067'),
(11, 5, 'dsg', 'dfsfgh', 'rec0148'),
(12, 5, 'dsg', 'dfsfgh', 'rec0060'),
(13, 6, 'NAAC-AA', 'NAAC-AAA', 'rec0124'),
(14, 6, 'NAAC-BB', 'NAAC-BBB', 'rec0130');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`acid`);

--
-- Indexes for table `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`agid`);

--
-- Indexes for table `decisions`
--
ALTER TABLE `decisions`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `meetingdetails`
--
ALTER TABLE `meetingdetails`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `nextmeeting`
--
ALTER TABLE `nextmeeting`
  ADD PRIMARY KEY (`nid`);

--
-- Indexes for table `objectives`
--
ALTER TABLE `objectives`
  ADD PRIMARY KEY (`oid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actions`
--
ALTER TABLE `actions`
  MODIFY `acid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `agenda`
--
ALTER TABLE `agenda`
  MODIFY `agid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `decisions`
--
ALTER TABLE `decisions`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `meetingdetails`
--
ALTER TABLE `meetingdetails`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `nextmeeting`
--
ALTER TABLE `nextmeeting`
  MODIFY `nid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `objectives`
--
ALTER TABLE `objectives`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
