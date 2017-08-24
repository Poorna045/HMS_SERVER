-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 24, 2017 at 02:23 PM
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
  `hosteltype` varchar(30) NOT NULL,
  `description` varchar(300) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bid`, `startdate`, `enddate`, `semstartdate`, `semenddate`, `hosteltype`, `description`, `status`) VALUES
(4, '2017-07-17', '2017-07-25', '2017-07-04', '2017-12-27', 'Boys', 'Bookings are open Please apply for Rooms', 'disable'),
(5, '2017-08-02', '2017-08-04', '2017-08-07', '2017-12-02', 'Girls', 'Bookings opened', 'enable'),
(7, '2017-08-01', '2017-08-02', '2017-08-22', '2018-01-01', 'Boys', 'testing', 'enable'),
(8, '2017-08-23', '2017-08-16', '2017-08-15', '2017-08-23', 'Girls', 'Bookings Opened', 'enable'),
(9, '2017-08-08', '2017-08-17', '2017-08-11', '2017-08-17', 'Boys', 'fdsss', 'enable');

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
(14, 'admin', 'Issue', 'High', 'Hostel', 'fdsgf');

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
(7, 'admin', 'Electrician Services', '2017-08-24 18:30:00', 4320, '2351', 'Hostel', 'fdsa'),
(8, 'admin', 'Elevator Services', '2017-08-30 18:30:00', 50, '234', 'Mess', 'fds'),
(12, 'admin', 'Electrician Services', '2017-08-01 14:54:06', 23452, '324', 'Mess', 'fda'),
(13, 'admin', 'Carpentry Services', '2017-08-23 16:37:06', 23342, '2341', 'Mess', 'sdaf'),
(14, 'admin', 'Electrician Services', '2017-08-23 16:38:02', 1232, '1234', 'Mess', 'asd');

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
(2, '2017-08-03', '2017-08-21 16:08:55', 'This account development manager sample job description can assist in your creating a job application that will attract job candidates who are qualified for the job. Feel free to revise this job description to meet your specific job duties and job requirements.'),
(3, '2017-08-09', '2017-08-21 16:10:26', 'The process of writing a job description requires having a clear understanding of the job’s duties and responsibilities. The job posting should also include a concise picture of the skills required for the position to attract qualified job candidates. Organize the job description into five sections: Company Information, Job Description, Job Requirements, Benefits and a Call to Action. Be sure to include keywords that will help make your job posting searchable. A well-defined job description will help attract qualified candidates as well as help reduce employee turnover  in the long run.'),
(4, '2017-08-02', '2017-08-21 16:50:43', 'These notifications alert your individual app users when something specific to them has happened. Transactional push notifications are not designed to overtly market your app – they are designed to be intrinsically useful.'),
(5, '0000-00-00', '2017-08-22 10:13:52', 'hi'),
(6, '2017-08-10', '2017-08-23 12:00:04', 'new notification testing'),
(7, '2017-08-24', '2017-08-23 12:14:36', 'form testing');

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
(1, 1, 'CSE2CR', 'AC', 'Non-AC', '0000-00-00 00:00:00', 'venkat Sai', '1989-08-02', 'M', '1', 150, 'all', 'T.A.Achari', '', 2147483647, 'venkatasait336@gmail.com', 'RTCCOMPLEX', 'RTCCOMPLEX', 'venkat', 'brother', 2147483647, 'venkat@gmail.com', 'RTCCOMPLEX', 'RTCCOMPLEX', 'Allocated'),
(2, 0, 'CSE1CR', 'AC', 'all', '0000-00-00 00:00:00', 'Pravalika', '1990-12-29', 'F', '0', 100, 'all', 'Achari', 'business', 2147483647, 'chari@gmail.com', 'vskp', 'vskp', 'ram', 'Brother', 2147483647, 'ram@gmail.com', 'vskp', 'vskp', 'Waiting'),
(3, 1, 'RECECE2ACR', 'AC', 'AC', '0000-00-00 00:00:00', 'Poorna Chand', '1991-08-01', 'M', '1', 150, 'AC', 'Ramarao', 'Employe', 2147483647, 'ramarao@gmail.com', 'pendurthi', 'pendurthi', 'kalyan', 'Brother', 2147483647, 'kalyan@gmail.com', 'vskp', 'vskp', 'Accepted'),
(4, 0, 'recmech002', 'AC', 'AC', '2017-08-02 10:38:46', 'suresh', '1988-12-12', 'M', '0', 10, 'AC', 'Laxmana', 'business', 2147483647, 'laxman@gmail.com', 'vskp', 'vskp', 'babu', 'Brother', 2147483647, 'babu@gmail.com', 'vskp', 'vskp', 'Pending'),
(5, 0, 'reccse002', 'Non-AC', 'AC', '2017-08-02 11:02:11', 'Praveen', '1991-09-02', 'M', '1', 500, 'all', 'Appalaswami', 'farmer', 2147483647, 'appalaswami@gmail.com', 'vijayawada', 'vijayawada', 'Sravan', 'Uncle', 897456231, 'sravan123@gmail.com', 'vijayanagaram', 'vijayanagaram', 'Allocated'),
(6, 2, 'recmech001', 'Non-AC', 'AC', '2017-08-02 11:05:12', 'Jogesh kumar', '1995-10-10', 'M', '1', 500, 'all', 'Durga Prasad', 'Employe', 896325417, 'durgaprasad@gmail.com', 'vijayawada', 'vijayawada', 'sagar', 'Uncle', 897456231, 'sagar123@gmail.com', 'vijayanagaram', 'vijayanagaram', 'Waiting'),
(7, 0, 'RECECE4ACR', 'Non-AC', 'Non-AC', '2017-08-02 11:12:26', 'Mehar', '1990-09-25', 'M', '0', 200, 'Non-AC', 'Pawan Kalyan', 'Employe', 897456321, 'pawankalyan@gmail.com', 'Bhimavaram', 'Bhimavaram', 'bhaskar Raja', 'uncle', 789456321, 'bhaskar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(8, 0, 'reccse003', 'Non-AC', 'Non-AC', '2017-08-02 11:42:33', 'shrija', '1991-10-13', 'F', '1', 250, 'Non-AC', 'Kalyan srinivas', 'business', 2147483647, 'kalyansrinivasn@gmail.com', 'Bhimavaram', 'Bhimavaram', 'Harish', 'Brother', 874589632, 'Harish123@gmail.com', 'vskp', 'vskp', 'Pending'),
(9, 0, 'RECECE3ACR', 'AC', 'AC', '2017-08-02 11:44:45', 'admin', '1990-05-13', 'M', '0', 250, 'AC', 'srinivas', 'business', 2147483647, 'srinivas@gmail.com', 'vijayawada', 'vijayawada', 'Harikumar', 'Brother', 2147483647, 'Harikumar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(10, 0, 'ritmech003', 'AC', 'AC', '2017-08-02 11:46:10', 'susmitha', '1990-05-13', 'F', '0', 250, 'AC', 'anilkumar', 'Farmer', 2147483647, 'anil@gmail.com', 'vijayawada', 'vijayawada', 'akhil', 'Brother', 2147483647, 'akhil123@gmail.com', 'vskp', 'vskp', 'Pending'),
(11, 0, 'ritcse3a', 'Non-AC', 'Non-AC', '2017-08-02 11:49:35', 'Rithika', '1989-06-13', 'F', '0', 250, 'Non-AC', 'Naidu', 'Farmer', 2147483647, 'naidu@gmail.com', 'vijayawada', 'vijayawada', 'rajashekar', 'Brother', 2147483647, 'rajashekar123@gmail.com', 'vskp', 'vskp', 'Pending'),
(12, 0, '12', 'Non-AC', 'Non-AC', '2017-08-02 11:51:01', 'admin', '1990-01-13', 'M', '0', 250, 'Non-AC', 'Murali', 'Farmer', 2147483647, 'murali1523@gmail.com', 'vijayawada', 'vijayawada', 'krishna', 'uncle', 2147483647, 'krishna143@gmail.com', 'vskp', 'vskp', 'Pending'),
(14, 0, 'rceccse012', 'AC', 'all', '2017-08-23 10:21:44', 'Rakul', '1994-04-15', 'F', '0', 146, 'all', 'Surya Prakash', 'Bank Manager', 2147483647, 'surya23@gmail.com', 'delhi', 'delhi', 'Shankar Prasad', 'Uncle', 2147483647, 'shankarp89@yahoo.com', 'vizag', 'vizag', 'Pending'),
(15, 0, 'reccse012', 'Non-AC', 'Non-AC', '2017-08-23 11:15:02', 'harsha', '2017-08-09', 'M', '1', 126, 'Non-AC', 'Ram Prasad', 'Driver', 2147483647, 'ram2@gmail.com', 'Chodavaram', 'Chodavaram', 'ramesh', 'uncle', 2147483647, 'ramesh222@yahoo.com', 'Vizayanagaram', 'Vizayanagaram', 'Pending');

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
(1, 'CSE2CR', 105, 3, 'Boys'),
(2, 'RECECE2ACR', 101, 3, 'Boys'),
(3, 'RECECE3ACR', 106, 1, 'Boys'),
(4, 'CSE1CR', 106, 3, 'Girls'),
(5, 'RECECE4ACR', 105, 2, 'Boys'),
(6, 'ritcse3a', 103, 3, 'Girls'),
(7, 'reccse002', 101, 1, 'Boys');

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
  `hosteltype` varchar(20) NOT NULL,
  `hostelid` int(11) NOT NULL,
  `blockid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomsconfig`
--

INSERT INTO `roomsconfig` (`rcid`, `roomno`, `avlbeds`, `totbeds`, `rcstatus`, `roomtype`, `roomrent`, `hosteltype`, `hostelid`, `blockid`) VALUES
(1, '101', 3, 5, 'available', 'AC', 35000, 'Boys', 12, 4),
(2, '102', 4, 4, 'available', 'Non-AC', 28000, 'Girls', 12, 4),
(3, '103', 4, 5, 'available', 'AC', 32000, 'Girls', 11, 6),
(4, '104', 5, 5, 'available', 'Non-AC', 30000, 'Boys', 14, 2),
(5, '105', 3, 5, 'available', 'AC', 35000, 'Boys', 12, 5),
(6, '106', 3, 4, 'available', 'AC', 32000, 'Girls', 14, 2),
(7, '106', 3, 4, 'available', 'Non-AC', 30000, 'Boys', 12, 4),
(8, '112', 6, 6, 'available', 'Non-AC', 28000, 'Girls', 23, 4);

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
  `status` varchar(20) NOT NULL DEFAULT 'enable',
  `hostelid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`typeid`, `type`, `totalcount`, `cost`, `totaldues`, `amt_perdue`, `status`, `hostelid`) VALUES
(1, 'AC', 50, '18000', 3, 6000, 'enable', 0),
(2, 'Non-AC', 100, '15000', 3, 5000, 'enable', 0);

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
(1, 'freshers party', '2017-08-31', '10:30:00', '2017-08-22 11:02:16', 'The 29th of July was marked as a memorable day in the life of every Fresher at Birla Institute of Management Technology (BIMTECH). The Freshers’ Party was a night filled with talent, music, excitement and enthusiasm. Every year on Freshers’ Party a boy and a girl from each stream is nominated for the prestigious title of Mr. & Ms. Fresher and for that they have to go through 3 rounds of different competitions, i.e. Intro Round, Talent Round and Q & A Round. This year the Titles were grabbed by Akshay Baxi (PGDM) and Swati Suyal (PGDM – RM).'),
(2, 'Black Friday : A Holiday for Champions', '2017-11-23', '05:00:00', '2017-08-22 11:05:07', 'Union Square, San Francise in San Francisco, California'),
(3, 'Funchep''s "Food Social" DJs & Street Food Eats Party', '2017-11-23', '06:00:00', '2017-08-22 11:05:52', 'The New Parish in oakland, California'),
(4, 'hi', '2017-08-23', '6:45 AM', '2017-08-22 14:18:51', 'hi'),
(5, 'hi', '2017-08-23', '6:45 AM', '2017-08-22 14:18:56', 'hi'),
(6, 'event test', '2017-08-09', '6:30 PM', '2017-08-23 12:17:26', 'testing');

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
  ADD PRIMARY KEY (`id`);

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
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `categorytypes`
--
ALTER TABLE `categorytypes`
  MODIFY `ctid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
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
-- AUTO_INCREMENT for table `instructions`
--
ALTER TABLE `instructions`
  MODIFY `i_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `maintenancedata`
--
ALTER TABLE `maintenancedata`
  MODIFY `mdid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `maintenanceservices`
--
ALTER TABLE `maintenanceservices`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `registrationdetails`
--
ALTER TABLE `registrationdetails`
  MODIFY `registrationid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `roomdetails`
--
ALTER TABLE `roomdetails`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `roomsconfig`
--
ALTER TABLE `roomsconfig`
  MODIFY `rcid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `roomtype`
--
ALTER TABLE `roomtype`
  MODIFY `typeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `upcomingevents`
--
ALTER TABLE `upcomingevents`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
