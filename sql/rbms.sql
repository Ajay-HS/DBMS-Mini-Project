-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 01, 2017 at 02:42 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rbms`
--
CREATE DATABASE IF NOT EXISTS `rbms` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rbms`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_purchase`(IN `c_id` INT, IN `e_id` INT, IN `p_id` INT, IN `pur_qty` INT)
begin
declare totalprice decimal(7,2);
declare ori_price decimal(6,2);
declare rate decimal(3,2);
declare old_qoh int;
declare old_plus_sold int;
select original_price,discnt_rate,qoh into ori_price,rate,old_qoh from products where pid = p_id;

set totalprice = (ori_price-rate)*pur_qty;


insert into purchases(cid,eid,pid,qty,ptime,total_price) values(c_id, e_id, p_id, pur_qty,CURRENT_TIMESTAMP,totalprice);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `del_product`(IN p_id int)
begin
delete from products where pid = p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_product`(IN prod_id int)
begin
		select * from products where pid = prod_id;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `new_product`(IN pname_ varchar(15), qoh_ int(5), qoh_threshold_ int(5), original_price_ decimal(6,2),discnt_rate_ decimal(3,2),sid_ int,imgname_ varchar(50) )
begin
insert into products(pname, qoh, qoh_threshold, original_price,discnt_rate,sid,imgname) values(pname_, qoh_, qoh_threshold_, original_price_,discnt_rate_,sid_,imgname_);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `report_monthly_sale`(IN prod_id int)
begin
		select pname,imgname,left( date_format(ptime,'%M'),3) as month,year(ptime) as year,sum(qty) as total_qty,sum(total_price) as total_dollar,sum(total_price)/sum(qty) as avg_price from purchases,products where purchases.pid = prod_id and purchases.pid = products.pid group by DATE_FORMAT(ptime,'%Y-%m');
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_customers`()
begin
select * from customers;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_employees`()
begin
		select * from employees;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logs`()
begin
		select * from logs;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_products`()
begin
		select * from products;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_purchases`()
begin
		select * from purchases;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_suppliers`()
begin
		select * from suppliers;
	end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `c_name` varchar(100) NOT NULL,
  `p_name` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `visits_made` int(5) NOT NULL DEFAULT '0',
  `last_visit_time` datetime DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`cid`, `cname`, `city`, `visits_made`, `last_visit_time`, `password`) VALUES
(1, 'latha', 'chennai', 60, '2017-11-27 13:19:35', '123'),
(0, 'Admin', 'chennai', 17, '2017-11-27 01:38:58', 'Admin'),
(6, 'roshan', 'Chennai', 10, '2017-11-27 12:03:05', 'micans'),
(7, 'gugu', 'Graveyard', 9, '2017-11-27 15:48:51', 'guguja'),
(8, 'ajayhs', 'BANGALORE', 0, NULL, 'ajay'),
(10, 'Abhilash', 'Mahadevapura', 0, NULL, '1234'),
(12, 'rekha', 'Mangalore', 0, NULL, '1234');

--
-- Triggers `customers`
--
DROP TRIGGER IF EXISTS `log_update_visit`;
DELIMITER //
CREATE TRIGGER `log_update_visit` AFTER UPDATE ON `customers`
 FOR EACH ROW begin
  if new.visits_made != old.visits_made then
    insert into logs(who,time,table_name,operation,key_value) values('root',CURRENT_TIMESTAMP,'customers','update',new.cid);
  end if;
  end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`eid`, `ename`, `city`) VALUES
(1, 'Rahul', 'Chennai'),
(2, 'Bob', 'Mailapur'),
(3, 'John', 'Bangalore'),
(4, 'Joel', 'Chennai'),
(5, 'Amy', 'Pondy');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `logid` int(5) NOT NULL AUTO_INCREMENT,
  `who` varchar(10) NOT NULL,
  `time` datetime NOT NULL,
  `table_name` varchar(20) NOT NULL,
  `operation` varchar(6) NOT NULL,
  `key_value` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=315 ;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`logid`, `who`, `time`, `table_name`, `operation`, `key_value`) VALUES
(33, 'root', '2017-11-25 02:19:39', 'purchases', 'insert', '16'),
(32, 'root', '2017-11-25 02:19:39', 'customers', 'update', '1'),
(31, 'root', '2017-11-25 02:19:39', 'products', 'update', '1'),
(30, 'root', '2017-11-25 02:19:03', 'purchases', 'insert', '15'),
(29, 'root', '2017-11-25 02:19:03', 'customers', 'update', '1'),
(28, 'root', '2017-11-25 02:19:03', 'products', 'update', '1'),
(27, 'root', '2017-11-25 02:18:51', 'products', 'update', '1'),
(26, 'root', '2017-11-25 02:17:06', 'purchases', 'insert', '14'),
(25, 'root', '2017-11-25 02:17:06', 'customers', 'update', '1'),
(24, 'root', '2017-11-25 02:17:06', 'products', 'update', '1'),
(23, 'root', '2017-11-25 02:13:06', 'purchases', 'insert', '13'),
(22, 'root', '2017-11-25 02:13:06', 'customers', 'update', '1'),
(21, 'root', '2017-11-25 02:13:06', 'products', 'update', '1'),
(20, 'root', '2017-11-25 02:11:13', 'purchases', 'insert', '12'),
(19, 'root', '2017-11-25 02:11:13', 'customers', 'update', '1'),
(18, 'root', '2017-11-25 02:11:13', 'products', 'update', '1'),
(17, 'root', '2017-11-24 23:09:49', 'purchases', 'insert', '11'),
(34, 'root', '2017-11-25 02:20:05', 'products', 'update', '1'),
(35, 'root', '2017-11-25 02:20:05', 'customers', 'update', '1'),
(36, 'root', '2017-11-25 02:20:05', 'purchases', 'insert', '17'),
(37, 'root', '2017-11-25 02:20:55', 'products', 'update', '2'),
(38, 'root', '2017-11-25 02:20:55', 'customers', 'update', '1'),
(39, 'root', '2017-11-25 02:20:55', 'purchases', 'insert', '18'),
(40, 'root', '2017-11-25 02:42:12', 'products', 'update', '1'),
(41, 'root', '2017-11-25 02:42:12', 'purchases', 'insert', '19'),
(42, 'root', '2017-11-25 02:44:14', 'products', 'update', '1'),
(43, 'root', '2017-11-25 02:44:14', 'purchases', 'insert', '20'),
(44, 'root', '2017-11-25 02:45:00', 'products', 'update', '1'),
(45, 'root', '2017-11-25 02:45:00', 'purchases', 'insert', '21'),
(46, 'root', '2017-11-25 02:47:20', 'products', 'update', '1'),
(47, 'root', '2017-11-25 02:47:20', 'purchases', 'insert', '22'),
(48, 'root', '2017-11-25 02:59:26', 'products', 'update', '1'),
(49, 'root', '2017-11-25 02:59:26', 'purchases', 'insert', '23'),
(50, 'root', '2017-11-25 03:31:37', 'products', 'update', '3'),
(51, 'root', '2017-11-25 03:31:37', 'purchases', 'insert', '24'),
(52, 'root', '2017-11-25 03:52:38', 'products', 'update', '1'),
(53, 'root', '2017-11-25 03:52:38', 'customers', 'update', '1'),
(54, 'root', '2017-11-25 03:52:38', 'purchases', 'insert', '25'),
(55, 'root', '2017-11-25 03:54:07', 'products', 'update', '1'),
(56, 'root', '2017-11-25 03:54:07', 'customers', 'update', '1'),
(57, 'root', '2017-11-25 03:54:07', 'purchases', 'insert', '26'),
(58, 'root', '2017-11-25 03:57:46', 'products', 'update', '2'),
(59, 'root', '2017-11-25 03:57:46', 'customers', 'update', '1'),
(60, 'root', '2017-11-25 03:57:46', 'purchases', 'insert', '27'),
(61, 'root', '2017-11-25 03:59:53', 'products', 'update', '1'),
(62, 'root', '2017-11-25 03:59:53', 'purchases', 'insert', '28'),
(63, 'root', '2017-11-25 04:02:02', 'products', 'update', '1'),
(64, 'root', '2017-11-25 04:02:02', 'customers', 'update', '6'),
(65, 'root', '2017-11-25 04:02:02', 'purchases', 'insert', '29'),
(66, 'root', '2017-11-25 09:51:37', 'products', 'update', '1'),
(67, 'root', '2017-11-25 09:51:37', 'customers', 'update', '1'),
(68, 'root', '2017-11-25 09:51:37', 'purchases', 'insert', '30'),
(69, 'root', '2017-11-25 10:00:58', 'products', 'update', '2'),
(70, 'root', '2017-11-25 10:00:58', 'customers', 'update', '1'),
(71, 'root', '2017-11-25 10:00:58', 'purchases', 'insert', '31'),
(72, 'root', '2017-11-25 10:04:32', 'products', 'update', '1'),
(73, 'root', '2017-11-25 10:04:32', 'customers', 'update', '1'),
(74, 'root', '2017-11-25 10:04:32', 'purchases', 'insert', '32'),
(75, 'root', '2017-11-25 10:04:54', 'products', 'update', '1'),
(76, 'root', '2017-11-25 10:04:54', 'customers', 'update', '1'),
(77, 'root', '2017-11-25 10:04:54', 'purchases', 'insert', '33'),
(78, 'root', '2017-11-25 10:05:46', 'products', 'update', '2'),
(79, 'root', '2017-11-25 10:05:46', 'products', 'update', '2'),
(80, 'root', '2017-11-25 10:05:46', 'customers', 'update', '1'),
(81, 'root', '2017-11-25 10:05:46', 'purchases', 'insert', '34'),
(82, 'root', '2017-11-25 10:08:16', 'products', 'update', '3'),
(83, 'root', '2017-11-25 10:08:16', 'customers', 'update', '1'),
(84, 'root', '2017-11-25 10:08:16', 'purchases', 'insert', '35'),
(85, 'root', '2017-11-25 10:11:32', 'products', 'update', '3'),
(86, 'root', '2017-11-25 10:11:32', 'customers', 'update', '1'),
(87, 'root', '2017-11-25 10:11:32', 'purchases', 'insert', '36'),
(88, 'root', '2017-11-25 10:18:05', 'products', 'update', '3'),
(89, 'root', '2017-11-25 10:18:05', 'products', 'update', '3'),
(90, 'root', '2017-11-25 10:18:05', 'customers', 'update', '1'),
(91, 'root', '2017-11-25 10:18:05', 'purchases', 'insert', '37'),
(92, 'root', '2017-11-25 10:18:34', 'products', 'update', '2'),
(93, 'root', '2017-11-25 10:18:58', 'products', 'update', '3'),
(94, 'root', '2017-11-25 10:19:09', 'products', 'update', '5'),
(95, 'root', '2017-11-25 10:19:19', 'products', 'update', '6'),
(96, 'root', '2017-11-25 10:19:27', 'products', 'update', '3'),
(97, 'root', '2017-11-25 10:19:27', 'customers', 'update', '1'),
(98, 'root', '2017-11-25 10:19:27', 'purchases', 'insert', '38'),
(99, 'root', '2017-11-25 10:19:38', 'products', 'update', '3'),
(100, 'root', '2017-11-25 10:19:38', 'customers', 'update', '1'),
(101, 'root', '2017-11-25 10:19:38', 'purchases', 'insert', '39'),
(102, 'root', '2017-11-25 10:23:32', 'products', 'update', '1'),
(103, 'root', '2017-11-25 10:23:32', 'customers', 'update', '1'),
(104, 'root', '2017-11-25 10:23:32', 'purchases', 'insert', '40'),
(105, 'root', '2017-11-25 10:25:48', 'products', 'update', '5'),
(106, 'root', '2017-11-25 10:25:48', 'customers', 'update', '1'),
(107, 'root', '2017-11-25 10:25:48', 'purchases', 'insert', '41'),
(108, 'root', '2017-11-25 10:33:58', 'products', 'update', '3'),
(109, 'root', '2017-11-25 10:33:58', 'customers', 'update', '1'),
(110, 'root', '2017-11-25 10:33:58', 'purchases', 'insert', '42'),
(111, 'root', '2017-11-25 10:36:59', 'products', 'update', '1'),
(112, 'root', '2017-11-25 10:36:59', 'customers', 'update', '1'),
(113, 'root', '2017-11-25 10:36:59', 'purchases', 'insert', '43'),
(114, 'root', '2017-11-25 10:38:50', 'products', 'update', '1'),
(115, 'root', '2017-11-25 10:38:50', 'customers', 'update', '1'),
(116, 'root', '2017-11-25 10:38:50', 'purchases', 'insert', '44'),
(117, 'root', '2017-11-25 10:42:53', 'products', 'update', '3'),
(118, 'root', '2017-11-25 10:42:53', 'customers', 'update', '1'),
(119, 'root', '2017-11-25 10:42:53', 'purchases', 'insert', '45'),
(120, 'root', '2017-11-25 10:43:19', 'products', 'update', '1'),
(121, 'root', '2017-11-25 10:43:19', 'customers', 'update', '1'),
(122, 'root', '2017-11-25 10:43:19', 'purchases', 'insert', '46'),
(123, 'root', '2017-11-25 10:52:20', 'products', 'update', '1'),
(124, 'root', '2017-11-25 10:52:20', 'purchases', 'insert', '47'),
(125, 'root', '2017-11-25 10:55:21', 'products', 'update', '1'),
(126, 'root', '2017-11-25 10:55:21', 'customers', 'update', '0'),
(127, 'root', '2017-11-25 10:55:21', 'purchases', 'insert', '48'),
(128, 'root', '2017-11-25 10:57:50', 'products', 'update', '1'),
(129, 'root', '2017-11-25 10:57:50', 'customers', 'update', '0'),
(130, 'root', '2017-11-25 10:57:50', 'purchases', 'insert', '49'),
(131, 'root', '2017-11-25 11:00:27', 'products', 'update', '2'),
(132, 'root', '2017-11-25 11:00:27', 'customers', 'update', '6'),
(133, 'root', '2017-11-25 11:00:27', 'purchases', 'insert', '50'),
(134, 'root', '2017-11-25 11:00:36', 'products', 'update', '3'),
(135, 'root', '2017-11-25 11:00:36', 'customers', 'update', '6'),
(136, 'root', '2017-11-25 11:00:36', 'purchases', 'insert', '51'),
(137, 'root', '2017-11-25 11:01:06', 'products', 'update', '2'),
(138, 'root', '2017-11-25 11:01:06', 'customers', 'update', '6'),
(139, 'root', '2017-11-25 11:01:06', 'purchases', 'insert', '52'),
(140, 'root', '2017-11-25 11:06:37', 'products', 'update', '1'),
(141, 'root', '2017-11-25 11:06:37', 'customers', 'update', '0'),
(142, 'root', '2017-11-25 11:06:37', 'purchases', 'insert', '53'),
(143, 'root', '2017-11-25 11:07:16', 'products', 'update', '1'),
(144, 'root', '2017-11-25 11:07:16', 'customers', 'update', '0'),
(145, 'root', '2017-11-25 11:07:16', 'purchases', 'insert', '54'),
(146, 'root', '2017-11-25 18:38:38', 'products', 'update', '1'),
(147, 'root', '2017-11-25 18:38:38', 'customers', 'update', '1'),
(148, 'root', '2017-11-25 18:38:38', 'purchases', 'insert', '55'),
(149, 'root', '2017-11-25 18:39:25', 'products', 'update', '2'),
(150, 'root', '2017-11-25 18:39:25', 'customers', 'update', '1'),
(151, 'root', '2017-11-25 18:39:25', 'purchases', 'insert', '56'),
(152, 'root', '2017-11-25 18:41:05', 'products', 'update', '3'),
(153, 'root', '2017-11-25 18:41:05', 'customers', 'update', '1'),
(154, 'root', '2017-11-25 18:41:05', 'purchases', 'insert', '57'),
(155, 'root', '2017-11-25 18:42:56', 'products', 'update', '1'),
(156, 'root', '2017-11-25 18:42:56', 'customers', 'update', '0'),
(157, 'root', '2017-11-25 18:42:56', 'purchases', 'insert', '58'),
(158, 'root', '2017-11-26 00:24:20', 'products', 'update', '6'),
(159, 'root', '2017-11-26 00:24:20', 'customers', 'update', '6'),
(160, 'root', '2017-11-26 00:24:20', 'purchases', 'insert', '59'),
(161, 'root', '2017-11-26 14:29:28', 'products', 'update', '2'),
(162, 'root', '2017-11-26 14:29:28', 'customers', 'update', '0'),
(163, 'root', '2017-11-26 14:29:28', 'purchases', 'insert', '60'),
(164, 'root', '2017-11-26 14:32:04', 'products', 'update', '1'),
(165, 'root', '2017-11-26 14:32:04', 'customers', 'update', '0'),
(166, 'root', '2017-11-26 14:32:04', 'purchases', 'insert', '61'),
(167, 'root', '2017-11-26 14:35:41', 'products', 'update', '1'),
(168, 'root', '2017-11-26 14:35:41', 'customers', 'update', '0'),
(169, 'root', '2017-11-26 14:35:41', 'purchases', 'insert', '62'),
(170, 'root', '2017-11-26 14:38:53', 'products', 'update', '1'),
(171, 'root', '2017-11-26 14:38:53', 'customers', 'update', '1'),
(172, 'root', '2017-11-26 14:38:53', 'purchases', 'insert', '63'),
(173, 'root', '2017-11-26 14:48:28', 'products', 'update', '1'),
(174, 'root', '2017-11-26 14:48:28', 'customers', 'update', '0'),
(175, 'root', '2017-11-26 14:48:28', 'purchases', 'insert', '64'),
(176, 'root', '2017-11-26 14:50:52', 'products', 'update', '1'),
(177, 'root', '2017-11-26 14:50:52', 'customers', 'update', '1'),
(178, 'root', '2017-11-26 14:50:52', 'purchases', 'insert', '65'),
(179, 'root', '2017-11-26 14:51:36', 'products', 'update', '2'),
(180, 'root', '2017-11-26 14:51:36', 'customers', 'update', '1'),
(181, 'root', '2017-11-26 14:51:36', 'purchases', 'insert', '66'),
(182, 'root', '2017-11-26 18:17:05', 'products', 'update', '1'),
(183, 'root', '2017-11-26 18:17:05', 'products', 'update', '1'),
(184, 'root', '2017-11-26 18:17:05', 'customers', 'update', '1'),
(185, 'root', '2017-11-26 18:17:05', 'purchases', 'insert', '67'),
(186, 'root', '2017-11-26 18:19:24', 'products', 'update', '1'),
(187, 'root', '2017-11-26 18:19:24', 'products', 'update', '1'),
(188, 'root', '2017-11-26 18:19:24', 'customers', 'update', '1'),
(189, 'root', '2017-11-26 18:19:24', 'purchases', 'insert', '68'),
(190, 'root', '2017-11-26 18:21:15', 'products', 'update', '1'),
(191, 'root', '2017-11-26 18:21:15', 'customers', 'update', '1'),
(192, 'root', '2017-11-26 18:21:15', 'purchases', 'insert', '69'),
(193, 'root', '2017-11-26 18:21:15', 'products', 'update', '1'),
(194, 'root', '2017-11-26 18:21:15', 'products', 'update', '1'),
(195, 'root', '2017-11-26 18:21:15', 'customers', 'update', '1'),
(196, 'root', '2017-11-26 18:21:15', 'purchases', 'insert', '70'),
(197, 'root', '2017-11-26 18:21:45', 'products', 'update', '1'),
(198, 'root', '2017-11-26 18:21:45', 'customers', 'update', '1'),
(199, 'root', '2017-11-26 18:21:45', 'purchases', 'insert', '71'),
(200, 'root', '2017-11-26 18:21:58', 'products', 'update', '1'),
(201, 'root', '2017-11-26 18:21:58', 'products', 'update', '1'),
(202, 'root', '2017-11-26 18:21:58', 'customers', 'update', '1'),
(203, 'root', '2017-11-26 18:21:58', 'purchases', 'insert', '72'),
(204, 'root', '2017-11-26 18:22:19', 'products', 'update', '1'),
(205, 'root', '2017-11-26 18:22:19', 'customers', 'update', '1'),
(206, 'root', '2017-11-26 18:22:19', 'purchases', 'insert', '73'),
(207, 'root', '2017-11-26 18:22:33', 'products', 'update', '1'),
(208, 'root', '2017-11-26 18:22:33', 'customers', 'update', '1'),
(209, 'root', '2017-11-26 18:22:33', 'purchases', 'insert', '74'),
(210, 'root', '2017-11-26 18:23:56', 'products', 'update', '1'),
(211, 'root', '2017-11-26 18:23:56', 'products', 'update', '1'),
(212, 'root', '2017-11-26 18:23:56', 'customers', 'update', '1'),
(213, 'root', '2017-11-26 18:23:56', 'purchases', 'insert', '75'),
(214, 'root', '2017-11-26 18:27:41', 'products', 'update', '7'),
(215, 'root', '2017-11-26 18:27:41', 'customers', 'update', '1'),
(216, 'root', '2017-11-26 18:27:41', 'purchases', 'insert', '76'),
(217, 'root', '2017-11-26 18:39:31', 'products', 'update', '1'),
(218, 'root', '2017-11-26 18:39:31', 'customers', 'update', '0'),
(219, 'root', '2017-11-26 18:39:31', 'purchases', 'insert', '77'),
(220, 'root', '2017-11-26 19:14:00', 'products', 'update', '1'),
(221, 'root', '2017-11-26 19:14:00', 'products', 'update', '1'),
(222, 'root', '2017-11-26 19:14:00', 'customers', 'update', '1'),
(223, 'root', '2017-11-26 19:14:00', 'purchases', 'insert', '78'),
(224, 'root', '2017-11-26 19:14:59', 'products', 'update', '1'),
(225, 'root', '2017-11-26 19:14:59', 'products', 'update', '1'),
(226, 'root', '2017-11-26 19:14:59', 'customers', 'update', '1'),
(227, 'root', '2017-11-26 19:14:59', 'purchases', 'insert', '79'),
(228, 'root', '2017-11-26 19:23:49', 'products', 'update', '1'),
(229, 'root', '2017-11-26 19:23:49', 'customers', 'update', '1'),
(230, 'root', '2017-11-26 19:23:49', 'purchases', 'insert', '80'),
(231, 'root', '2017-11-26 19:24:27', 'products', 'update', '1'),
(232, 'root', '2017-11-26 19:24:27', 'products', 'update', '1'),
(233, 'root', '2017-11-26 19:24:27', 'customers', 'update', '1'),
(234, 'root', '2017-11-26 19:24:27', 'purchases', 'insert', '81'),
(235, 'root', '2017-11-26 19:27:38', 'products', 'update', '1'),
(236, 'root', '2017-11-26 19:27:38', 'customers', 'update', '1'),
(237, 'root', '2017-11-26 19:27:38', 'purchases', 'insert', '82'),
(238, 'root', '2017-11-26 19:28:11', 'products', 'update', '1'),
(239, 'root', '2017-11-26 19:28:11', 'products', 'update', '1'),
(240, 'root', '2017-11-26 19:28:11', 'customers', 'update', '1'),
(241, 'root', '2017-11-26 19:28:11', 'purchases', 'insert', '83'),
(242, 'root', '2017-11-26 19:32:02', 'products', 'update', '1'),
(243, 'root', '2017-11-26 19:32:14', 'products', 'update', '1'),
(244, 'root', '2017-11-26 19:32:14', 'customers', 'update', '1'),
(245, 'root', '2017-11-26 19:32:14', 'purchases', 'insert', '84'),
(246, 'root', '2017-11-26 23:56:15', 'products', 'update', '1'),
(247, 'root', '2017-11-26 23:56:15', 'customers', 'update', '1'),
(248, 'root', '2017-11-26 23:56:15', 'purchases', 'insert', '85'),
(249, 'root', '2017-11-27 00:32:03', 'products', 'update', '5'),
(250, 'root', '2017-11-27 00:32:03', 'customers', 'update', '0'),
(251, 'root', '2017-11-27 00:32:03', 'purchases', 'insert', '86'),
(252, 'root', '2017-11-27 00:32:46', 'products', 'update', '3'),
(253, 'root', '2017-11-27 00:32:46', 'customers', 'update', '0'),
(254, 'root', '2017-11-27 00:32:46', 'purchases', 'insert', '87'),
(255, 'root', '2017-11-27 01:04:41', 'products', 'update', '5'),
(256, 'root', '2017-11-27 01:04:41', 'customers', 'update', '6'),
(257, 'root', '2017-11-27 01:04:41', 'purchases', 'insert', '88'),
(258, 'root', '2017-11-27 01:05:04', 'products', 'update', '3'),
(259, 'root', '2017-11-27 01:05:04', 'customers', 'update', '6'),
(260, 'root', '2017-11-27 01:05:04', 'purchases', 'insert', '89'),
(261, 'root', '2017-11-27 01:05:21', 'products', 'update', '5'),
(262, 'root', '2017-11-27 01:05:21', 'customers', 'update', '6'),
(263, 'root', '2017-11-27 01:05:21', 'purchases', 'insert', '90'),
(264, 'root', '2017-11-27 01:09:13', 'products', 'update', '6'),
(265, 'root', '2017-11-27 01:09:13', 'customers', 'update', '0'),
(266, 'root', '2017-11-27 01:09:13', 'purchases', 'insert', '91'),
(267, 'root', '2017-11-27 01:23:06', 'products', 'update', '5'),
(268, 'root', '2017-11-27 01:23:06', 'customers', 'update', '7'),
(269, 'root', '2017-11-27 01:23:06', 'purchases', 'insert', '92'),
(270, 'root', '2017-11-27 01:24:07', 'products', 'update', '6'),
(271, 'root', '2017-11-27 01:24:07', 'customers', 'update', '7'),
(272, 'root', '2017-11-27 01:24:07', 'purchases', 'insert', '93'),
(273, 'root', '2017-11-27 01:25:38', 'products', 'update', '1'),
(274, 'root', '2017-11-27 01:25:38', 'customers', 'update', '7'),
(275, 'root', '2017-11-27 01:25:38', 'purchases', 'insert', '94'),
(276, 'root', '2017-11-27 01:25:58', 'products', 'update', '1'),
(277, 'root', '2017-11-27 01:25:58', 'customers', 'update', '7'),
(278, 'root', '2017-11-27 01:25:58', 'purchases', 'insert', '95'),
(279, 'root', '2017-11-27 01:31:11', 'products', 'update', '1'),
(280, 'root', '2017-11-27 01:31:11', 'customers', 'update', '7'),
(281, 'root', '2017-11-27 01:31:11', 'purchases', 'insert', '96'),
(282, 'root', '2017-11-27 01:33:01', 'products', 'update', '2'),
(283, 'root', '2017-11-27 01:33:01', 'customers', 'update', '7'),
(284, 'root', '2017-11-27 01:33:01', 'purchases', 'insert', '97'),
(285, 'root', '2017-11-27 01:37:41', 'products', 'update', '5'),
(286, 'root', '2017-11-27 01:37:41', 'customers', 'update', '0'),
(287, 'root', '2017-11-27 01:37:41', 'purchases', 'insert', '98'),
(288, 'root', '2017-11-27 01:38:58', 'products', 'update', '5'),
(289, 'root', '2017-11-27 01:38:58', 'customers', 'update', '0'),
(290, 'root', '2017-11-27 01:38:58', 'purchases', 'insert', '99'),
(291, 'root', '2017-11-27 11:49:29', 'products', 'update', '1'),
(292, 'root', '2017-11-27 11:49:29', 'customers', 'update', '1'),
(293, 'root', '2017-11-27 11:49:29', 'purchases', 'insert', '100'),
(294, 'root', '2017-11-27 12:02:51', 'products', 'update', '1'),
(295, 'root', '2017-11-27 12:02:51', 'customers', 'update', '6'),
(296, 'root', '2017-11-27 12:02:51', 'purchases', 'insert', '101'),
(297, 'root', '2017-11-27 12:03:05', 'products', 'update', '2'),
(298, 'root', '2017-11-27 12:03:05', 'customers', 'update', '6'),
(299, 'root', '2017-11-27 12:03:05', 'purchases', 'insert', '102'),
(300, 'root', '2017-11-27 12:34:02', 'products', 'update', '1'),
(301, 'root', '2017-11-27 12:34:02', 'customers', 'update', '7'),
(302, 'root', '2017-11-27 12:34:02', 'purchases', 'insert', '103'),
(303, 'root', '2017-11-27 13:19:23', 'products', 'update', '1'),
(304, 'root', '2017-11-27 13:19:23', 'customers', 'update', '1'),
(305, 'root', '2017-11-27 13:19:23', 'purchases', 'insert', '104'),
(306, 'root', '2017-11-27 13:19:35', 'products', 'update', '1'),
(307, 'root', '2017-11-27 13:19:35', 'customers', 'update', '1'),
(308, 'root', '2017-11-27 13:19:35', 'purchases', 'insert', '105'),
(309, 'root', '2017-11-27 15:48:33', 'products', 'update', '1'),
(310, 'root', '2017-11-27 15:48:33', 'customers', 'update', '7'),
(311, 'root', '2017-11-27 15:48:33', 'purchases', 'insert', '106'),
(312, 'root', '2017-11-27 15:48:51', 'products', 'update', '2'),
(313, 'root', '2017-11-27 15:48:51', 'customers', 'update', '7'),
(314, 'root', '2017-11-27 15:48:51', 'purchases', 'insert', '107');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(20) NOT NULL,
  `qoh` int(5) NOT NULL,
  `qoh_threshold` int(5) DEFAULT NULL,
  `original_price` decimal(6,2) DEFAULT NULL,
  `discnt_rate` decimal(3,2) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `imgname` varchar(50) DEFAULT '',
  PRIMARY KEY (`pid`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`pid`, `pname`, `qoh`, `qoh_threshold`, `original_price`, `discnt_rate`, `sid`, `imgname`) VALUES
(1, 'Milk', 279, 10, '20.00', '2.00', 1, 'Milk.jpg'),
(2, 'jar', 162, 10, '55.00', '3.00', 2, 'jar.jpg'),
(3, 'Bread', 177, 10, '25.00', '2.00', 1, 'Bread.jpg'),
(5, 'Knife', 182, 8, '45.00', '5.00', 2, 'Knife.jpg'),
(6, 'Shovel', 171, 5, '55.00', '5.00', 1, 'Shovel.jpg'),
(7, 'pizza', 8, 2, '125.00', '5.00', 2, 'pizza.jpg');

--
-- Triggers `products`
--
DROP TRIGGER IF EXISTS `log_update_qoh`;
DELIMITER //
CREATE TRIGGER `log_update_qoh` AFTER UPDATE ON `products`
 FOR EACH ROW begin
  if new.qoh != old.qoh then
    insert into logs(who,time,table_name,operation,key_value) values('root',CURRENT_TIMESTAMP,'products','update',new.pid);
  end if;
  end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `purid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `qty` int(5) DEFAULT NULL,
  `ptime` datetime DEFAULT NULL,
  `total_price` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`purid`),
  KEY `cid` (`cid`),
  KEY `eid` (`eid`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=108 ;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`purid`, `cid`, `eid`, `pid`, `qty`, `ptime`, `total_price`) VALUES
(51, 6, 0, 3, 1, '2017-11-25 11:00:36', '23.00'),
(50, 6, 0, 2, 2, '2017-11-25 11:00:27', '8.00'),
(49, 0, 1, 1, 4, '2017-11-25 10:57:50', '72.00'),
(48, 0, 2, 1, 2, '2017-11-25 10:55:21', '36.00'),
(43, 1, 0, 1, 2, '2017-11-25 10:36:59', '36.00'),
(44, 1, 0, 1, 3, '2017-11-25 10:38:50', '54.00'),
(47, 0, 1, 1, 1, '2017-11-25 10:52:20', '18.00'),
(52, 6, 0, 2, 1, '2017-11-25 11:01:06', '4.00'),
(53, 0, 1, 1, 5, '2017-11-25 11:06:37', '90.00'),
(54, 0, 3, 1, 2, '2017-11-25 11:07:16', '36.00'),
(55, 1, 0, 1, 10, '2017-11-25 18:38:38', '180.00'),
(56, 1, 0, 2, 10, '2017-11-25 18:39:25', '520.00'),
(57, 1, 0, 3, 1, '2017-11-25 18:41:05', '23.00'),
(58, 0, 2, 1, 1, '2017-11-25 18:42:56', '18.00'),
(59, 6, 0, 6, 2, '2017-11-26 00:24:20', '100.00'),
(60, 0, 2, 2, 5, '2017-11-26 14:29:28', '260.00'),
(61, 0, 4, 1, 4, '2017-11-26 14:32:04', '72.00'),
(62, 0, 3, 1, 5, '2017-11-26 14:35:41', '90.00'),
(63, 1, 0, 1, 4, '2017-11-26 14:38:53', '72.00'),
(64, 0, 3, 1, 5, '2017-11-26 14:48:28', '90.00'),
(65, 1, 0, 1, 11, '2017-11-26 14:50:52', '198.00'),
(66, 1, 0, 2, 1, '2017-11-26 14:51:36', '52.00'),
(67, 1, 0, 1, 5, '2017-11-26 18:17:05', '90.00'),
(68, 1, 0, 1, 16, '2017-11-26 18:19:24', '288.00'),
(69, 1, 0, 1, 7, '2017-11-26 18:21:15', '126.00'),
(70, 1, 0, 1, 7, '2017-11-26 18:21:15', '126.00'),
(71, 1, 0, 1, 1, '2017-11-26 18:21:45', '18.00'),
(72, 1, 0, 1, 10, '2017-11-26 18:21:58', '180.00'),
(73, 1, 0, 1, 2, '2017-11-26 18:22:19', '36.00'),
(74, 1, 0, 1, 5, '2017-11-26 18:22:33', '90.00'),
(75, 1, 0, 1, 9, '2017-11-26 18:23:56', '162.00'),
(76, 1, 0, 7, 2, '2017-11-26 18:27:41', '240.00'),
(77, 0, 2, 1, 2, '2017-11-26 18:39:31', '36.00'),
(78, 1, 0, 1, 2, '2017-11-26 19:14:00', '36.00'),
(79, 1, 0, 1, 11, '2017-11-26 19:14:59', '198.00'),
(80, 1, 0, 1, 12, '2017-11-26 19:23:49', '216.00'),
(81, 1, 0, 1, 12, '2017-11-26 19:24:27', '216.00'),
(82, 1, 0, 1, 12, '2017-11-26 19:27:38', '216.00'),
(83, 1, 0, 1, 2, '2017-11-26 19:28:11', '36.00'),
(84, 1, 0, 1, 1200, '2017-11-26 19:32:14', '21600.00'),
(85, 1, 0, 1, 300, '2017-11-26 23:56:15', '5400.00'),
(86, 0, 1, 5, 1, '2017-11-27 00:32:03', '40.00'),
(87, 0, 1, 3, 1, '2017-11-27 00:32:46', '23.00'),
(88, 6, 0, 5, 1, '2017-11-27 01:04:41', '40.00'),
(89, 6, 0, 3, 1, '2017-11-27 01:05:04', '23.00'),
(90, 6, 0, 5, 1, '2017-11-27 01:05:21', '40.00'),
(91, 0, 5, 6, 1, '2017-11-27 01:09:13', '50.00'),
(92, 7, 0, 5, 2, '2017-11-27 01:23:06', '80.00'),
(93, 7, 0, 6, 6, '2017-11-27 01:24:07', '300.00'),
(94, 7, 0, 1, 1, '2017-11-27 01:25:38', '18.00'),
(95, 7, 0, 1, 1, '2017-11-27 01:25:58', '18.00'),
(96, 7, 0, 1, 3, '2017-11-27 01:31:11', '54.00'),
(97, 7, 0, 2, 1, '2017-11-27 01:33:01', '52.00'),
(98, 0, 5, 5, 1, '2017-11-27 01:37:41', '40.00'),
(99, 0, 2, 5, 1, '2017-11-27 01:38:58', '40.00'),
(100, 1, 0, 1, 1, '2017-11-27 11:49:29', '18.00'),
(101, 6, 0, 1, 2, '2017-11-27 12:02:51', '36.00'),
(102, 6, 0, 2, 2, '2017-11-27 12:03:05', '104.00'),
(103, 7, 0, 1, 2, '2017-11-27 12:34:02', '36.00'),
(104, 1, 0, 1, 3, '2017-11-27 13:19:23', '54.00'),
(105, 1, 0, 1, 5, '2017-11-27 13:19:35', '90.00'),
(106, 7, 0, 1, 3, '2017-11-27 15:48:33', '54.00'),
(107, 7, 0, 2, 6, '2017-11-27 15:48:51', '312.00');

--
-- Triggers `purchases`
--
DROP TRIGGER IF EXISTS `after_purchase`;
DELIMITER //
CREATE TRIGGER `after_purchase` AFTER INSERT ON `purchases`
 FOR EACH ROW begin
update products set qoh = qoh - new.qty where pid = new.pid;
update customers set visits_made = visits_made + 1,last_visit_time = new.ptime where cid = new.cid;
insert into logs(who,time,table_name,operation,key_value) values('root',CURRENT_TIMESTAMP,'purchases','insert',new.purid);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(15) NOT NULL,
  `city` varchar(15) DEFAULT NULL,
  `telephone_no` char(10) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sname` (`sname`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`sid`, `sname`, `city`, `telephone_no`) VALUES
(1, 'Supplier 1', 'BLR', '6075555431'),
(2, 'Supplier 2', 'NYC', '6075555432');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
