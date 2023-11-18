-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 15, 2022 at 01:51 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elrp`
--

-- --------------------------------------------------------

--
-- Table structure for table `accesories_wardrobe`
--

CREATE TABLE `accesories_wardrobe` (
  `ID` int(11) NOT NULL,
  `houseid` int(11) NOT NULL,
  `accName` varchar(128) NOT NULL DEFAULT 'None',
  `accModel` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `ID` int(11) NOT NULL,
  `Username` varchar(25) DEFAULT NULL,
  `Password` varchar(129) DEFAULT NULL,
  `Salt` varchar(65) DEFAULT NULL,
  `Email` varchar(32) DEFAULT 'server@test.com',
  `PhoneNumber` varchar(24) DEFAULT '085722222222',
  `IP` varchar(17) DEFAULT '127.0.0.1',
  `LeaveIP` varchar(17) DEFAULT '0.0.0.0',
  `Banned` int(4) DEFAULT 0,
  `Admin` int(4) DEFAULT 0,
  `AdminDuty` int(4) DEFAULT 0,
  `AdminHide` int(4) DEFAULT 0,
  `RegisterDate` int(32) DEFAULT 0,
  `LoginDate` int(32) DEFAULT 0,
  `AdminRankName` varchar(32) DEFAULT 'None',
  `VerifyCode` varchar(32) DEFAULT 'UG-0000',
  `Influencer` int(11) DEFAULT 0,
  `ReportPoint` int(11) DEFAULT NULL,
  `AdminDutyTime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `VerifyEmailToken` varchar(64) NOT NULL DEFAULT '0',
  `NextSendEmailToken` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ForgotPassToken` varchar(64) NOT NULL DEFAULT '0',
  `NextSendForgotPassToken` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `AdminAcceptReport` int(11) NOT NULL DEFAULT 0,
  `AdminDeniedReport` int(11) NOT NULL DEFAULT 0,
  `AdminAcceptStuck` int(11) NOT NULL DEFAULT 0,
  `AdminDeniedStuck` int(11) NOT NULL DEFAULT 0,
  `AdminBanned` int(11) NOT NULL DEFAULT 0,
  `AdminUnbanned` int(11) NOT NULL DEFAULT 0,
  `AdminJail` int(11) NOT NULL DEFAULT 0,
  `AdminAnswer` int(11) NOT NULL DEFAULT 0,
  `DiscordID` varchar(60) NOT NULL,
  `Code` int(4) NOT NULL DEFAULT 0,
  `Active` int(2) NOT NULL DEFAULT 0,
  `Registered` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `actorID` int(11) NOT NULL,
  `actorName` varchar(24) NOT NULL DEFAULT 'Stranger',
  `actorModel` int(11) NOT NULL DEFAULT 2,
  `actorX` float NOT NULL DEFAULT 0,
  `actorY` float NOT NULL DEFAULT 0,
  `actorZ` float NOT NULL DEFAULT 0,
  `actorA` float NOT NULL DEFAULT 0,
  `actorInterior` int(11) NOT NULL DEFAULT 0,
  `actorVirtualWorld` int(11) NOT NULL DEFAULT 0,
  `actorType` int(11) NOT NULL DEFAULT 0,
  `actorCash` int(11) NOT NULL DEFAULT 15000,
  `actorAnimLib` varchar(128) NOT NULL DEFAULT '',
  `actorAnimName` varchar(128) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`actorID`, `actorName`, `actorModel`, `actorX`, `actorY`, `actorZ`, `actorA`, `actorInterior`, `actorVirtualWorld`, `actorType`, `actorCash`, `actorAnimLib`, `actorAnimName`) VALUES
(1, 'Stranger', 2, 0, 0, 0, 0, 10, 6002, 0, 15000, '', ''),
(2, 'Stranger', 2, 0, 0, 0, 0, 6, 6008, 0, 15000, '', ''),
(3, 'Stranger', 2, 0, 0, 0, 0, 18, 6001, 0, 15000, '', ''),
(4, 'Stranger', 2, 0, 0, 0, 0, 3, 6018, 0, 15000, '', ''),
(5, 'Stranger', 2, 0, 0, 0, 0, 10, 6019, 0, 15000, '', ''),
(16, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(17, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(18, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(19, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(20, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(21, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(22, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(23, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(24, 'Stranger', 2, 0, 0, 0, 0, 0, 0, 0, 15000, '', ''),
(25, 'Stranger', 2, 0, 0, 0, 0, 4, 6017, 0, 15000, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `admin_activities`
--

CREATE TABLE `admin_activities` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('unknown','accept_report','deny_report','accept_stuck','deny_stuck','ban','unban','jail','answer') NOT NULL,
  `issuer` int(11) NOT NULL,
  `receiver` int(12) NOT NULL,
  `issuer_ip_address` varchar(32) NOT NULL,
  `receiver_ip_address` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Jam ini dalam UTC'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_activities`
--

INSERT INTO `admin_activities` (`id`, `type`, `issuer`, `receiver`, `issuer_ip_address`, `receiver_ip_address`, `description`, `created_at`) VALUES
(1, 'accept_report', 19, 7, '103.139.10.231', '103.139.10.231', 'Admin Elbier (playerid=13, IP=103.139.10.231) accept report from Ken Willbert (playerid=5, IP=140.213.67.146). Report message: ', '2022-09-10 11:23:24'),
(2, 'accept_report', 19, 63, '103.139.10.231', '140.213.191.92', 'Admin Elbier (playerid=20, IP=103.139.10.231) accept report from Ken Willbert (playerid=2, IP=140.213.191.92). Report message: ', '2022-09-10 12:14:51'),
(3, 'accept_report', 19, 7, '103.139.10.231', '103.139.10.231', 'Admin Elbier (playerid=20, IP=103.139.10.231) accept report from Xavier Jefferson (playerid=11, IP=222.124.109.231). Report mes', '2022-09-10 12:17:41'),
(4, 'accept_report', 19, 58, '103.139.10.231', '180.241.31.32', 'Admin Elbier (playerid=20, IP=103.139.10.231) accept report from George Walsh (playerid=5, IP=180.241.31.32). Report message: m', '2022-09-10 12:18:20'),
(5, 'answer', 19, 7, '103.139.10.231', '103.139.10.231', 'Admin Elbier (playerid=20, IP=103.139.10.231) answer Budi Alfarizi (playerid=6, IP=125.165.52.222) question. Question: MIN NGUL', '2022-09-10 12:21:12'),
(6, 'accept_report', 68, 51, '103.78.115.83', '103.78.115.83', 'Admin Jojo (playerid=21, IP=103.78.115.83) accept report from Gustav Ratzenhofer (playerid=0, IP=103.47.135.158). Report messag', '2022-09-10 12:30:42'),
(7, 'answer', 19, 7, '103.139.10.231', '103.139.10.231', 'Admin Elbier (playerid=5, IP=103.139.10.231) answer Xavier Jefferson (playerid=11, IP=222.124.109.231) question. Question: ini ', '2022-09-10 12:35:32'),
(8, 'accept_report', 19, 67, '103.139.10.231', '103.144.169.52', 'Admin Elbier (playerid=5, IP=103.139.10.231) accept report from Frenzy Shinigami (playerid=12, IP=103.144.169.52). Report messa', '2022-09-10 12:38:34'),
(9, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) bans account LordXav. Reason: Cheater Weapon Hack', '2022-09-10 12:49:48'),
(10, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) bans IP address 222.124.109.231. Reason: Cheater', '2022-09-10 12:50:37'),
(11, 'jail', 68, 51, '103.78.115.83', '103.78.115.83', 'Admin Jojo (playerid=10, IP=103.78.115.83) jails Jhonatan Joestar (playerid=10, IP=103.78.115.83) for 1 minutes. Reason: bug', '2022-09-10 12:54:03'),
(12, 'jail', 68, 51, '103.78.115.83', '103.78.115.83', 'Admin Jojo (playerid=10, IP=103.78.115.83) jails Jhonatan Joestar (playerid=10, IP=103.78.115.83) for 1 minutes. Reason: bug', '2022-09-10 12:54:06'),
(13, 'accept_report', 19, 67, '103.139.10.231', '103.144.169.52', 'Admin Elbier (playerid=5, IP=103.139.10.231) accept report from Frenzy Shinigami (playerid=17, IP=103.144.169.52). Report messa', '2022-09-10 13:06:25'),
(14, 'answer', 68, 101, '103.78.115.83', '114.79.38.202', 'Admin Jojo (playerid=18, IP=103.78.115.83) answer Guilherme Leao (playerid=16, IP=114.79.38.202) question. Question: ini tes GM', '2022-09-10 13:14:57'),
(15, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) bans account IscoXyz. Reason: Cheater Fly Hack', '2022-09-10 13:26:25'),
(16, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) bans IP address 8.30.234.95. Reason: Cheater', '2022-09-10 13:26:42'),
(17, 'accept_report', 41, 82, '125.166.112.180', '180.241.242.168', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) accept report from Dede Kurniawan (playerid=18, IP=180.241.242.168). Report m', '2022-09-10 13:27:35'),
(18, 'accept_report', 19, 7, '114.122.107.70', '114.122.107.70', 'Admin Elbier (playerid=9, IP=114.122.107.70) accept report from Murzy Eduardo (playerid=5, IP=180.251.55.176). Report message: ', '2022-09-10 13:39:27'),
(19, 'answer', 19, 7, '114.122.107.70', '114.122.107.70', 'Admin Elbier (playerid=9, IP=114.122.107.70) answer Derus Vann (playerid=1, IP=149.113.254.8) question. Question: tempat beli g', '2022-09-10 13:40:16'),
(20, 'answer', 19, 96, '114.122.107.70', '149.113.254.8', 'Admin Elbier (playerid=9, IP=114.122.107.70) answer Derus Vann (playerid=0, IP=149.113.254.8) question. Question: min dmn tempa', '2022-09-10 13:46:40'),
(21, 'jail', 68, 104, '103.78.115.83', '36.82.38.127', 'Admin Jojo (playerid=2, IP=103.78.115.83) jails Gerry Bramasta (playerid=17, IP=36.82.38.127) for 1 minutes. Reason: bug', '2022-09-10 13:49:46'),
(22, 'accept_report', 19, 5, '114.122.107.70', '103.108.130.117', 'Admin Elbier (playerid=9, IP=114.122.107.70) accept report from Frankie Charles (playerid=1, IP=103.108.130.117). Report messag', '2022-09-10 13:50:05'),
(23, 'ban', 10, 2, '182.1.126.204', '182.1.126.204', 'Admin AnantaHere (playerid=13, IP=182.1.126.204) bans VALLBA IS BACK (playerid=18, IP=125.164.99.217). Reason: NON RP NAME', '2022-09-10 13:51:17'),
(24, 'unban', 151, 115, '120.188.86.253', '120.188.86.253', 'Admin Arjun (playerid=1, IP=120.188.86.253) unbans VALLBA_IS_BACK.', '2022-09-10 14:04:18'),
(25, 'accept_report', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) accept report from Queensha Ethelyn (playerid=25, IP=180.252.85.93). Report m', '2022-09-10 14:28:32'),
(26, 'jail', 151, 51, '120.188.86.253', '103.78.115.83', 'Admin Arjun (playerid=17, IP=120.188.86.253) jails Jhonatan Joestar (playerid=2, IP=103.78.115.83) for 1 minutes. Reason: bug', '2022-09-10 14:31:37'),
(27, 'jail', 68, 51, '103.78.115.83', '103.78.115.83', 'Admin Jojo (playerid=2, IP=103.78.115.83) jails Jhonatan Joestar (playerid=2, IP=103.78.115.83) for 1 minutes. Reason: bug', '2022-09-10 14:34:31'),
(28, 'jail', 41, 51, '125.166.112.180', '103.78.115.83', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) jails Jhonatan Joestar (playerid=2, IP=103.78.115.83) for 1 minutes. Reason: ', '2022-09-10 14:35:43'),
(29, 'answer', 155, 54, '182.2.71.135', '103.108.130.117', 'Admin TerCooL (playerid=7, IP=182.2.71.135) answer Rudulf Geraldo (playerid=20, IP=103.108.130.117) question. Question: min tem', '2022-09-10 14:39:08'),
(30, 'answer', 155, 124, '182.2.71.135', '36.84.118.81', 'Admin TerCooL (playerid=7, IP=182.2.71.135) answer Xian Fernandez (playerid=10, IP=36.84.118.81) question. Question: min bisa m', '2022-09-10 14:43:47'),
(31, 'answer', 68, 51, '103.78.115.83', '103.78.115.83', 'Admin Jojo (playerid=2, IP=103.78.115.83) answer Jimmy Bernstein (playerid=9, IP=140.213.151.94) question. Question: cmd ambil ', '2022-09-10 15:10:28'),
(32, 'answer', 151, 96, '120.188.86.253', '149.113.254.8', 'Admin Arjun (playerid=6, IP=120.188.86.253) answer Derus Vann (playerid=14, IP=149.113.254.8) question. Question: atm dimana mi', '2022-09-10 15:14:39'),
(33, 'jail', 151, 122, '120.188.86.253', '128.199.247.154', 'Admin Arjun (playerid=6, IP=120.188.86.253) jails Marino Sanctacruz (playerid=4, IP=128.199.247.154) for 1 minutes. Reason: bug', '2022-09-10 15:16:08'),
(34, 'answer', 155, 119, '182.2.71.135', '182.2.71.135', 'Admin TerCooL (playerid=7, IP=182.2.71.135) answer Albert Camaron (playerid=13, IP=103.108.130.150) question. Question: cmd cla', '2022-09-10 15:29:44'),
(35, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) bans account nomi. Reason: Cheater Weapon Hack', '2022-09-10 15:31:59'),
(36, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) bans IP address 114.79.21.165. Reason: Cheater', '2022-09-10 15:32:19'),
(37, 'jail', 151, 16, '120.188.86.253', '36.85.6.140', 'Admin Arjun (playerid=6, IP=120.188.86.253) jails Axel Volter (playerid=10, IP=36.85.6.140) for 1 minutes. Reason: mukul di gz', '2022-09-10 15:40:59'),
(38, 'answer', 151, 135, '120.188.86.253', '36.79.195.64', 'Admin Arjun (playerid=6, IP=120.188.86.253) answer Alex Tuna (playerid=7, IP=36.79.195.64) question. Question: toko elektronik ', '2022-09-10 15:48:45'),
(39, 'jail', 151, 128, '120.188.86.253', '114.4.213.76', 'Admin Arjun (playerid=6, IP=120.188.86.253) jails Xolo Yolo (playerid=11, IP=114.4.213.76) for 1 minutes. Reason: bug', '2022-09-10 15:50:30'),
(40, 'accept_report', 86, 34, '120.188.65.220', '125.167.56.182', 'Admin Godzillas (playerid=13, IP=120.188.65.220) accept report from Amado Daluez (playerid=9, IP=125.167.56.182). Report messag', '2022-09-10 16:19:41'),
(41, 'answer', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=17, IP=103.108.130.2) answer Marsel Cuirass (playerid=15, IP=118.136.175.98) question. Question: dewa cmd', '2022-09-10 16:29:45'),
(42, 'answer', 86, 40, '120.188.65.220', '140.213.24.95', 'Admin Godzillas (playerid=13, IP=120.188.65.220) answer Ranz Summers (playerid=6, IP=140.213.24.95) question. Question: ulang u', '2022-09-10 16:31:09'),
(43, 'accept_report', 86, 144, '120.188.65.220', '180.244.162.24', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Patrick Benjamin (playerid=2, IP=180.244.162.24). Report mes', '2022-09-10 16:51:58'),
(44, 'answer', 86, 142, '120.188.65.220', '180.247.5.56', 'Admin Godzillas (playerid=9, IP=120.188.65.220) answer Antonio Ramorez (playerid=6, IP=180.247.5.56) question. Question: mau re', '2022-09-10 17:00:48'),
(45, 'accept_report', 86, 8, '120.188.65.220', '125.166.182.202', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Xavier Luciano (playerid=7, IP=125.166.182.202). Report mess', '2022-09-10 17:00:59'),
(46, 'accept_report', 86, 79, '120.188.65.220', '8.34.202.40', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Howard Barnett (playerid=18, IP=8.34.202.40). Report message', '2022-09-10 17:01:02'),
(47, 'accept_report', 86, 19, '120.188.65.220', '114.124.245.62', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Gun Walters (playerid=3, IP=114.124.245.62). Report message:', '2022-09-10 17:02:55'),
(48, 'accept_report', 86, 123, '120.188.65.220', '140.213.59.100', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Dejuam Vegeance (playerid=16, IP=140.213.59.100). Report mes', '2022-09-10 17:23:58'),
(49, 'accept_report', 86, 79, '120.188.65.220', '8.30.234.130', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Howard Barnett (playerid=4, IP=8.30.234.130). Report message', '2022-09-10 17:26:34'),
(50, 'accept_report', 86, 34, '120.188.65.220', '125.167.56.182', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Amado Daluez (playerid=20, IP=125.167.56.182). Report messag', '2022-09-10 17:33:05'),
(51, 'answer', 41, 133, '125.166.112.180', '103.47.135.138', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Lana Coraline (playerid=7, IP=103.47.135.138) question. Question: admi', '2022-09-10 17:37:34'),
(52, 'accept_report', 41, 17, '125.166.112.180', '180.244.160.162', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Rojer Hawkins (playerid=13, IP=180.244.160.162). Report me', '2022-09-10 17:37:58'),
(53, 'accept_report', 86, 54, '120.188.65.220', '103.108.130.117', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Rudulf Geraldo (playerid=22, IP=103.108.130.117). Report mes', '2022-09-10 17:42:51'),
(54, 'accept_report', 86, 30, '120.188.65.220', '36.85.1.57', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Owen Knight (playerid=24, IP=36.85.1.57). Report message: re', '2022-09-10 17:45:45'),
(55, 'deny_report', 86, 111, '120.188.65.220', '120.188.7.127', 'Admin Godzillas (playerid=9, IP=120.188.65.220) deny report from Miyu Tacibana (playerid=6, IP=120.188.7.127). Report message: ', '2022-09-10 17:57:37'),
(56, 'accept_report', 86, 40, '120.188.65.220', '140.213.24.95', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Ranz Summers (playerid=5, IP=140.213.24.95). Report message:', '2022-09-10 18:01:37'),
(57, 'answer', 108, 157, '103.108.130.2', '36.83.58.25', 'Admin pandu (playerid=12, IP=103.108.130.2) answer Kane Sutarjo (playerid=8, IP=36.83.58.25) question. Question: mau tanya cara', '2022-09-10 18:11:08'),
(58, 'answer', 86, 150, '120.188.65.220', '114.125.204.125', 'Admin Godzillas (playerid=9, IP=120.188.65.220) answer Aarzam Winter (playerid=21, IP=114.125.204.125) question. Question: kerj', '2022-09-10 18:12:10'),
(59, 'accept_report', 86, 151, '120.188.65.220', '114.10.27.145', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept stuck request from Han Shinigami (playerid=6, IP=114.10.27.145).', '2022-09-10 18:23:32'),
(60, 'accept_report', 86, 151, '120.188.65.220', '114.10.27.145', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept stuck request from Han Shinigami (playerid=6, IP=114.10.27.145).', '2022-09-10 18:23:55'),
(61, 'accept_report', 86, 151, '120.188.65.220', '114.10.27.145', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept stuck request from Han Shinigami (playerid=0, IP=114.10.27.145).', '2022-09-10 18:25:52'),
(62, 'accept_report', 86, 40, '120.188.65.220', '140.213.22.25', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Ranz Summers (playerid=16, IP=140.213.22.25). Report message', '2022-09-10 18:33:43'),
(63, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=12, IP=103.108.130.2) offline jails Edward_Francisco for 1 minutes. Reason: bug', '2022-09-10 18:37:25'),
(64, 'accept_report', 86, 6, '120.188.65.220', '36.72.56.4', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Edward Francisco (playerid=14, IP=36.72.56.4). Report messag', '2022-09-10 18:38:48'),
(65, 'answer', 108, 157, '103.108.130.2', '36.83.58.25', 'Admin pandu (playerid=12, IP=103.108.130.2) answer Kane Sutarjo (playerid=8, IP=36.83.58.25) question. Question: kenapa layar s', '2022-09-10 18:40:07'),
(66, 'accept_report', 86, 40, '120.188.65.220', '140.213.22.25', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Ranz Summers (playerid=11, IP=140.213.22.25). Report message', '2022-09-10 18:58:19'),
(67, 'accept_report', 86, 139, '120.188.65.220', '114.122.41.97', 'Admin Godzillas (playerid=9, IP=120.188.65.220) accept report from Andrey Rodriguez (playerid=13, IP=114.122.41.97). Report mes', '2022-09-10 18:58:33'),
(68, 'answer', 86, 104, '120.188.65.220', '36.82.38.127', 'Admin Godzillas (playerid=9, IP=120.188.65.220) answer Gerry Bramasta (playerid=10, IP=36.82.38.127) question. Question: min | ', '2022-09-10 18:59:29'),
(69, 'answer', 41, 157, '125.166.112.180', '36.83.58.25', 'Admin Rukitateki (playerid=4, IP=125.166.112.180) answer Kane Sutarjo (playerid=1, IP=36.83.58.25) question. Question: masih ng', '2022-09-10 19:05:43'),
(70, 'answer', 86, 157, '120.188.65.220', '36.83.58.25', 'Admin Godzillas (playerid=13, IP=120.188.65.220) answer Kane Sutarjo (playerid=1, IP=36.83.58.25) question. Question: kenapa ng', '2022-09-10 19:25:16'),
(71, 'accept_report', 68, 177, '103.78.115.83', '180.246.124.55', 'Admin Jojo (playerid=4, IP=103.78.115.83) accept report from Fazly Albiandra (playerid=2, IP=180.246.124.55). Report message: m', '2022-09-11 01:13:12'),
(72, 'answer', 68, 177, '103.78.115.83', '180.246.124.55', 'Admin Jojo (playerid=4, IP=103.78.115.83) answer Fazly Albiandra (playerid=2, IP=180.246.124.55) question. Question: admin mana', '2022-09-11 01:18:41'),
(73, 'accept_report', 19, 12, '103.139.10.100', '118.99.81.125', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Ferdison Alexander (playerid=7, IP=118.99.81.125). Report messa', '2022-09-11 01:28:14'),
(74, 'accept_report', 19, 182, '103.139.10.100', '182.1.193.231', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Alexander Morgan (playerid=5, IP=182.1.193.231). Report message', '2022-09-11 01:28:50'),
(75, 'accept_report', 19, 28, '103.139.10.100', '36.73.34.139', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Teddy Gibs (playerid=10, IP=36.73.34.139). Report message: min ', '2022-09-11 01:34:01'),
(76, 'accept_report', 19, 28, '103.139.10.100', '36.73.34.139', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Teddy Gibs (playerid=10, IP=36.73.34.139). Report message: sema', '2022-09-11 01:35:00'),
(77, 'accept_report', 19, 11, '103.139.10.100', '8.34.202.71', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from William Hotchner (playerid=0, IP=8.34.202.71). Report message: ', '2022-09-11 01:37:05'),
(78, 'accept_report', 41, 157, '125.166.112.180', '36.83.58.25', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Kane Sutarjo (playerid=13, IP=36.83.58.25). Report message', '2022-09-11 02:08:53'),
(79, 'answer', 41, 31, '125.166.112.180', '103.143.63.25', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) answer Popix Vicente (playerid=15, IP=103.143.63.25) question. Question: min ', '2022-09-11 02:11:34'),
(80, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Jackson Alexander (playerid=3, IP=111.94.58.42). Report message', '2022-09-11 02:23:47'),
(81, 'answer', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) answer Nicholas Barbara (playerid=1, IP=110.137.101.148) question. Question: ', '2022-09-11 02:26:31'),
(82, 'accept_report', 41, 60, '125.166.112.180', '114.10.29.17', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Daniell Wade (playerid=24, IP=114.10.29.17). Report messag', '2022-09-11 02:34:26'),
(83, 'jail', 68, 173, '103.78.115.83', '125.166.13.103', 'Admin Jojo (playerid=4, IP=103.78.115.83) jails Hilmy Fauzan (playerid=26, IP=125.166.13.103) for 1 minutes. Reason: bug', '2022-09-11 02:43:48'),
(84, 'answer', 41, 58, '125.166.112.180', '180.241.31.32', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) answer George Walsh (playerid=1, IP=180.241.31.32) question. Question: bisa r', '2022-09-11 02:45:51'),
(85, 'answer', 19, 177, '103.139.10.100', '180.246.124.55', 'Admin Elbier (playerid=2, IP=103.139.10.100) answer Fazly Albiandra (playerid=10, IP=180.246.124.55) question. Question: tempat', '2022-09-11 03:00:06'),
(86, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Jhon Rambo (playerid=5, IP=140.213.11.145). Report message: min', '2022-09-11 03:06:18'),
(87, 'accept_report', 68, 58, '103.78.115.83', '180.241.31.32', 'Admin Jojo (playerid=4, IP=103.78.115.83) accept report from George Walsh (playerid=1, IP=180.241.31.32). Report message: min i', '2022-09-11 03:08:24'),
(88, 'accept_report', 41, 60, '125.166.112.180', '114.10.29.17', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Daniell Wade (playerid=1, IP=114.10.29.17). Report message', '2022-09-11 03:13:16'),
(89, 'accept_report', 41, 131, '125.166.112.180', '140.213.192.14', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Leon Kennedy (playerid=8, IP=140.213.192.14). Report messa', '2022-09-11 03:22:38'),
(90, 'jail', 19, 103, '103.139.10.100', '114.142.168.39', 'Admin Elbier (playerid=2, IP=103.139.10.100) jails Mario Rush (playerid=14, IP=114.142.168.39) for 100 minutes. Reason: rusuh', '2022-09-11 03:29:10'),
(91, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) bans account hitam. Reason: Cheater Weapon Hack', '2022-09-11 03:29:43'),
(92, 'ban', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) bans IP address 114.142.168.39. Reason: Cheater Weapon Hack', '2022-09-11 03:30:00'),
(93, 'answer', 19, 63, '103.139.10.100', '140.213.183.115', 'Admin Elbier (playerid=2, IP=103.139.10.100) answer Ken Willbert (playerid=28, IP=140.213.183.115) question. Question: kapan re', '2022-09-11 03:33:44'),
(94, 'answer', 19, 63, '103.139.10.100', '140.213.183.115', 'Admin Elbier (playerid=2, IP=103.139.10.100) answer Ken Willbert (playerid=28, IP=140.213.183.115) question. Question: mon maaf', '2022-09-11 03:34:16'),
(95, 'accept_report', 41, 36, '125.166.112.180', '36.72.160.141', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Jayce Hylton (playerid=24, IP=36.72.160.141). Report messa', '2022-09-11 03:49:24'),
(96, 'accept_report', 19, 66, '103.139.10.100', '110.138.92.66', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Lucas Shane (playerid=26, IP=110.138.92.66). Report message: Mi', '2022-09-11 03:59:45'),
(97, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=2, IP=103.139.10.100) accept report from Adam Escobar (playerid=19, IP=114.10.29.66). Report message: wa', '2022-09-11 04:11:04'),
(98, 'accept_report', 41, 173, '125.166.112.180', '125.166.13.103', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Hilmy Fauzan (playerid=34, IP=125.166.13.103). Report mess', '2022-09-11 04:11:10'),
(99, 'accept_report', 41, 194, '125.166.112.180', '140.213.183.115', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Fajri Maulana (playerid=11, IP=140.213.183.115). Report me', '2022-09-11 04:15:37'),
(100, 'jail', 68, 142, '103.78.115.83', '180.247.5.84', 'Admin Jojo (playerid=4, IP=103.78.115.83) jails Antonio Ramorez (playerid=5, IP=180.247.5.84) for 1 minutes. Reason: bug', '2022-09-11 04:16:09'),
(101, 'answer', 155, 119, '182.2.71.159', '182.2.71.159', 'Admin TerCooL (playerid=0, IP=182.2.71.159) answer Jueno Pantacruzz (playerid=15, IP=114.79.1.8) question. Question: ini ada sp', '2022-09-11 04:16:24'),
(102, 'accept_report', 155, 18, '182.2.71.159', '110.137.36.231', 'Admin TerCooL (playerid=0, IP=182.2.71.159) accept report from Smith Levithan (playerid=14, IP=110.137.36.231). Report message:', '2022-09-11 04:17:10'),
(103, 'accept_report', 19, 142, '103.139.10.100', '180.247.5.84', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Antonio Ramorez (playerid=20, IP=180.247.5.84). Report message', '2022-09-11 04:20:55'),
(104, 'accept_report', 19, 35, '103.139.10.100', '140.213.192.193', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Andrew Wesly (playerid=29, IP=140.213.192.193). Report message', '2022-09-11 04:24:36'),
(105, 'accept_report', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Jayce Hylton (playerid=24, IP=36.72.160.141). Report message: ', '2022-09-11 04:25:24'),
(106, 'answer', 19, 104, '103.139.10.100', '36.82.38.127', 'Admin Elbier (playerid=30, IP=103.139.10.100) answer Gerry Bramasta (playerid=37, IP=36.82.38.127) question. Question: min sump', '2022-09-11 04:26:34'),
(107, 'accept_report', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Tommy Tysoon (playerid=0, IP=182.0.144.59). Report message', '2022-09-11 04:27:49'),
(108, 'accept_report', 151, 173, '120.188.86.253', '125.166.13.103', 'Admin Arjun (playerid=23, IP=120.188.86.253) accept report from Hilmy Fauzan (playerid=34, IP=125.166.13.103). Report message: ', '2022-09-11 04:28:20'),
(109, 'accept_report', 41, 9, '125.166.112.180', '140.213.44.129', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Smith Martin (playerid=24, IP=140.213.44.129). Report mess', '2022-09-11 04:31:36'),
(110, 'accept_report', 41, 104, '125.166.112.180', '36.82.38.127', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Gerry Bramasta (playerid=37, IP=36.82.38.127). Report mess', '2022-09-11 04:31:59'),
(111, 'accept_report', 19, 192, '103.139.10.100', '180.252.91.28', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Jahmiree Maleek (playerid=19, IP=180.252.91.28). Report messag', '2022-09-11 04:32:37'),
(112, 'accept_report', 41, 200, '125.166.112.180', '182.0.144.59', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Tommy Tysoon (playerid=34, IP=182.0.144.59). Report messag', '2022-09-11 04:33:53'),
(113, 'accept_report', 19, 65, '103.139.10.100', '114.10.21.206', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Ken Mang (playerid=2, IP=114.10.21.206). Report message: min s', '2022-09-11 04:34:25'),
(114, 'accept_report', 41, 193, '125.166.112.180', '8.25.96.11', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Aaron Petterson (playerid=17, IP=8.25.96.11). Report messa', '2022-09-11 04:34:57'),
(115, 'answer', 19, 157, '103.139.10.100', '36.85.3.213', 'Admin Elbier (playerid=30, IP=103.139.10.100) answer Kane Sutarjo (playerid=15, IP=36.85.3.213) question. Question: sewa kapal ', '2022-09-11 04:35:04'),
(116, 'accept_report', 19, 14, '103.139.10.100', '110.137.193.247', 'Admin Elbier (playerid=30, IP=103.139.10.100) accept report from Abel Petterson (playerid=26, IP=110.137.193.247). Report messa', '2022-09-11 04:35:34'),
(117, 'accept_report', 19, 14, '103.139.10.100', '110.137.193.247', 'Admin Elbier (playerid=23, IP=103.139.10.100) accept report from Abel Petterson (playerid=14, IP=110.137.193.247). Report messa', '2022-09-11 04:40:46'),
(118, 'answer', 41, 151, '125.166.112.180', '114.10.71.155', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) answer Han Shinigami (playerid=11, IP=114.10.71.155) question. Question: min ', '2022-09-11 04:44:27'),
(119, 'accept_report', 41, 16, '125.166.112.180', '36.85.3.156', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Axel Volter (playerid=1, IP=36.85.3.156). Report message: ', '2022-09-11 04:47:44'),
(120, 'answer', 19, 151, '103.139.10.100', '114.10.71.155', 'Admin Elbier (playerid=23, IP=103.139.10.100) answer Han Shinigami (playerid=11, IP=114.10.71.155) question. Question: min biki', '2022-09-11 04:47:48'),
(121, 'accept_report', 41, 192, '125.166.112.180', '180.252.91.28', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Jahmiree Maleek (playerid=19, IP=180.252.91.28). Report me', '2022-09-11 04:58:09'),
(122, 'accept_report', 41, 88, '125.166.112.180', '116.206.14.36', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) accept report from Qenzo Zevallo (playerid=28, IP=116.206.14.36). Report mess', '2022-09-11 05:01:10'),
(123, 'jail', 41, 88, '125.166.112.180', '116.206.14.36', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) jails Qenzo Zevallo (playerid=28, IP=116.206.14.36) for 1 minutes. Reason: bu', '2022-09-11 05:01:13'),
(124, 'accept_report', 19, 84, '114.122.106.54', '125.165.52.222', 'Admin Elbier (playerid=15, IP=114.122.106.54) accept report from Budi Alfarizi (playerid=28, IP=125.165.52.222). Report message', '2022-09-11 05:26:53'),
(125, 'accept_report', 19, 12, '114.122.106.54', '118.99.81.125', 'Admin Elbier (playerid=15, IP=114.122.106.54) accept report from Ferdison Alexander (playerid=12, IP=118.99.81.125). Report mes', '2022-09-11 05:28:53'),
(126, 'accept_report', 86, 4, '120.188.5.44', '140.213.146.58', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept report from Jahreem Kareem (playerid=14, IP=140.213.146.58). Report messag', '2022-09-11 05:43:07'),
(127, 'answer', 19, 60, '114.122.106.54', '114.10.29.17', 'Admin Elbier (playerid=15, IP=114.122.106.54) answer Daniell Wade (playerid=17, IP=114.10.29.17) question. Question: bm udah ad', '2022-09-11 05:45:59'),
(128, 'answer', 19, 60, '114.122.106.54', '114.10.29.17', 'Admin Elbier (playerid=15, IP=114.122.106.54) answer Daniell Wade (playerid=17, IP=114.10.29.17) question. Question: clue bm pl', '2022-09-11 05:47:44'),
(129, 'accept_report', 86, 16, '120.188.5.44', '36.85.6.140', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept report from Axel Volter (playerid=14, IP=36.85.6.140). Report message: Ref', '2022-09-11 05:53:32'),
(130, 'accept_report', 19, 84, '114.122.106.54', '125.165.52.222', 'Admin Elbier (playerid=15, IP=114.122.106.54) accept report from Budi Alfarizi (playerid=28, IP=125.165.52.222). Report message', '2022-09-11 06:10:14'),
(131, 'accept_report', 19, 11, '114.122.106.54', '8.34.202.71', 'Admin Elbier (playerid=15, IP=114.122.106.54) accept report from Plutarco Echeverra (playerid=13, IP=8.34.202.71). Report messa', '2022-09-11 06:15:46'),
(132, 'deny_report', 86, 62, '120.188.5.44', '103.126.86.51', 'Admin Godzillas (playerid=6, IP=120.188.5.44) deny report from Vittorini Leovince (playerid=11, IP=103.126.86.51). Report messa', '2022-09-11 06:24:07'),
(133, 'answer', 86, 12, '120.188.5.44', '118.99.81.125', 'Admin Godzillas (playerid=6, IP=120.188.5.44) answer Ferdison Alexander (playerid=24, IP=118.99.81.125) question. Question: min', '2022-09-11 06:24:51'),
(134, 'accept_report', 86, 13, '120.188.5.44', '125.164.19.185', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept stuck request from Kudak Deblow (playerid=12, IP=125.164.19.185).', '2022-09-11 06:25:26'),
(135, 'ban', 86, 64, '120.188.5.44', '120.188.5.44', 'Admin Godzillas (playerid=6, IP=120.188.5.44) offline bans character Jahreem_Kareem. Reason: Cheat surfly', '2022-09-11 06:32:55'),
(136, 'accept_report', 86, 11, '120.188.5.44', '8.34.202.71', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept report from Plutarco Echeverra (playerid=13, IP=8.34.202.71). Report messa', '2022-09-11 06:35:01'),
(137, 'accept_report', 19, 54, '114.122.106.54', '103.108.130.117', 'Admin Elbier (playerid=22, IP=114.122.106.54) accept report from Rudulf Geraldo (playerid=27, IP=103.108.130.117). Report messa', '2022-09-11 06:40:02'),
(138, 'answer', 19, 11, '114.122.106.54', '8.34.202.71', 'Admin Elbier (playerid=22, IP=114.122.106.54) answer Plutarco Echeverra (playerid=13, IP=8.34.202.71) question. Question: ini t', '2022-09-11 06:44:37'),
(139, 'accept_report', 86, 193, '120.188.5.44', '8.30.234.49', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept stuck request from Aaron Petterson (playerid=16, IP=8.30.234.49).', '2022-09-11 06:44:56'),
(140, 'accept_report', 86, 193, '120.188.5.44', '8.30.234.49', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept stuck request from Aaron Petterson (playerid=22, IP=8.30.234.49).', '2022-09-11 06:48:02'),
(141, 'answer', 19, 180, '103.139.10.100', '103.105.27.87', 'Admin Elbier (playerid=16, IP=103.139.10.100) answer Jay Francisco (playerid=30, IP=103.105.27.87) question. Question: gak ada ', '2022-09-11 06:48:52'),
(142, 'answer', 108, 180, '103.108.130.2', '103.105.27.87', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Jay Francisco (playerid=30, IP=103.105.27.87) question. Question: gw cari di', '2022-09-11 06:49:32'),
(143, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails Tokugawa_Leyasu for 1 minutes. Reason: bug', '2022-09-11 06:51:39'),
(144, 'accept_report', 19, 41, '103.139.10.100', '140.213.47.9', 'Admin Elbier (playerid=16, IP=103.139.10.100) accept report from Navaro Guillermo (playerid=26, IP=140.213.47.9). Report messag', '2022-09-11 06:52:39'),
(145, 'accept_report', 86, 41, '120.188.5.44', '140.213.47.9', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept stuck request from Navaro Guillermo (playerid=26, IP=140.213.47.9).', '2022-09-11 06:53:01'),
(146, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails Tokugawa_Leyasu for 1 minutes. Reason: bug', '2022-09-11 06:54:27'),
(147, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails Tokugawa_Leyasu for 1 minutes. Reason: bug', '2022-09-11 06:54:39'),
(148, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails Tokugawa_leyasu for 1 minutes. Reason: bug', '2022-09-11 06:55:15'),
(149, 'answer', 19, 177, '103.139.10.100', '180.246.124.55', 'Admin Elbier (playerid=16, IP=103.139.10.100) answer Fazly Albiandra (playerid=0, IP=180.246.124.55) question. Question: buat s', '2022-09-11 06:55:39'),
(150, 'jail', 86, 64, '120.188.5.44', '120.188.5.44', 'Admin Godzillas (playerid=6, IP=120.188.5.44) offline jails Tokugawa_Leyasu for 1 minutes. Reason: bug', '2022-09-11 06:56:58'),
(151, 'jail', 86, 64, '120.188.5.44', '120.188.5.44', 'Admin Godzillas (playerid=6, IP=120.188.5.44) offline jails Tokugawa_Leyasu for 1 minutes. Reason: bug', '2022-09-11 06:57:02'),
(152, 'jail', 86, 192, '120.188.5.44', '180.252.91.28', 'Admin Godzillas (playerid=6, IP=120.188.5.44) jails Jahmiree Maleek (playerid=1, IP=180.252.91.28) for 80 minutes. Reason: penj', '2022-09-11 06:57:32'),
(153, 'jail', 86, 41, '120.188.5.44', '140.213.47.9', 'Admin Godzillas (playerid=6, IP=120.188.5.44) jails Navaro Guillermo (playerid=36, IP=140.213.47.9) for 80 minutes. Reason: pen', '2022-09-11 06:57:38'),
(154, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails tokugawa_leyasu for 1 minutes. Reason: bug', '2022-09-11 06:59:18'),
(155, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails tokugawa_leyasu for 1 minutes. Reason: bug', '2022-09-11 06:59:29'),
(156, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails toyotomi for 1 minutes. Reason: 1', '2022-09-11 06:59:44'),
(157, 'answer', 108, 69, '103.108.130.2', '36.71.81.250', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Federico Gavi (playerid=33, IP=36.71.81.250) question. Question: di GM ini c', '2022-09-11 07:04:44'),
(158, 'jail', 108, 49, '103.108.130.2', '114.4.78.165', 'Admin pandu (playerid=18, IP=103.108.130.2) jails Tokugawa Ieyasu (playerid=37, IP=114.4.78.165) for 1 minutes. Reason: bug', '2022-09-11 07:08:23'),
(159, 'answer', 108, 193, '103.108.130.2', '110.137.193.247', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Aaron Petterson (playerid=17, IP=110.137.193.247) question. Question: cara a', '2022-09-11 07:14:05'),
(160, 'accept_report', 19, 84, '103.139.10.100', '125.165.52.222', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Budi Alfarizi (playerid=14, IP=125.165.52.222). Report message:', '2022-09-11 07:15:02'),
(161, 'accept_report', 19, 144, '103.139.10.100', '180.244.162.24', 'Admin Elbier (playerid=7, IP=103.139.10.100) accept report from Patrick Benjamin (playerid=9, IP=180.244.162.24). Report messag', '2022-09-11 07:17:06'),
(162, 'answer', 19, 217, '103.139.10.100', '140.213.22.147', 'Admin Elbier (playerid=7, IP=103.139.10.100) answer Ramm Mulki (playerid=13, IP=140.213.22.147) question. Question: min | Answe', '2022-09-11 07:17:22'),
(163, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) offline jails Ramm_Mulki for 1 minutes. Reason: bug', '2022-09-11 07:21:25'),
(164, 'answer', 19, 85, '103.139.10.100', '125.162.52.18', 'Admin Elbier (playerid=7, IP=103.139.10.100) answer Matsushima Kunio (playerid=22, IP=125.162.52.18) question. Question: CMD ka', '2022-09-11 07:23:27'),
(165, 'answer', 108, 117, '103.108.130.2', '36.65.2.62', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Putra Yosua (playerid=14, IP=36.65.2.62) question. Question: min bantu | Ans', '2022-09-11 07:24:15'),
(166, 'answer', 108, 117, '103.108.130.2', '36.65.2.62', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Putra Yosua (playerid=14, IP=36.65.2.62) question. Question: cara buka pintu', '2022-09-11 07:24:59'),
(167, 'accept_report', 86, 222, '120.188.5.44', '182.1.163.211', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept report from Paccho Delmosse (playerid=31, IP=182.1.163.211). Report messag', '2022-09-11 07:25:31'),
(168, 'answer', 86, 177, '120.188.5.44', '180.246.124.55', 'Admin Godzillas (playerid=6, IP=120.188.5.44) answer Fazly Albiandra (playerid=34, IP=180.246.124.55) question. Question: tempa', '2022-09-11 07:25:58'),
(169, 'jail', 86, 64, '120.188.5.44', '120.188.5.44', 'Admin Godzillas (playerid=6, IP=120.188.5.44) offline jails 28 for 1 minutes. Reason: bug', '2022-09-11 07:29:51'),
(170, 'jail', 86, 64, '120.188.5.44', '120.188.5.44', 'Admin Godzillas (playerid=6, IP=120.188.5.44) offline jails Paccho_Delmosse for 1 minutes. Reason: bug', '2022-09-11 07:30:09'),
(171, 'accept_report', 86, 217, '120.188.5.44', '140.213.22.147', 'Admin Godzillas (playerid=6, IP=120.188.5.44) accept report from Ramm Mulki (playerid=28, IP=140.213.22.147). Report message: m', '2022-09-11 07:31:15'),
(172, 'jail', 19, 7, '114.122.106.58', '114.122.106.58', 'Admin Elbier (playerid=8, IP=114.122.106.58) offline jails Paccho_Delmosse for 1 minutes. Reason: bug', '2022-09-11 07:37:18'),
(173, 'answer', 108, 144, '103.108.130.2', '180.244.162.24', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Patrick Benjamin (playerid=41, IP=180.244.162.24) question. Question: ini ko', '2022-09-11 07:37:50'),
(174, 'accept_report', 19, 222, '114.122.106.58', '182.1.163.211', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Paccho Delmosse (playerid=11, IP=182.1.163.211). Report messag', '2022-09-11 07:49:24'),
(175, 'accept_report', 19, 7, '114.122.106.58', '114.122.106.58', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Ranzy Bancmek (playerid=22, IP=36.85.222.70). Report message: ', '2022-09-11 07:50:36'),
(176, 'answer', 19, 7, '114.122.106.58', '114.122.106.58', 'Admin Elbier (playerid=27, IP=114.122.106.58) answer Yorell Powell (playerid=20, IP=125.164.20.79) question. Question: min bisa', '2022-09-11 07:51:51'),
(177, 'accept_report', 19, 9, '114.122.106.58', '36.68.218.239', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Smith Martin (playerid=17, IP=36.68.218.239). Report message: ', '2022-09-11 07:53:24'),
(178, 'accept_report', 108, 151, '103.108.130.2', '114.10.71.155', 'Admin pandu (playerid=18, IP=103.108.130.2) accept stuck request from Han Shinigami (playerid=6, IP=114.10.71.155).', '2022-09-11 07:55:38'),
(179, 'answer', 19, 7, '114.122.106.58', '114.122.106.58', 'Admin Elbier (playerid=27, IP=114.122.106.58) answer Jeremiah Gillard (playerid=30, IP=112.215.235.89) question. Question: cara', '2022-09-11 07:55:53'),
(180, 'answer', 19, 217, '114.122.106.58', '140.213.22.147', 'Admin Elbier (playerid=27, IP=114.122.106.58) answer Ramm Mulki (playerid=0, IP=140.213.22.147) question. Question: min reff di', '2022-09-11 08:03:29'),
(181, 'accept_report', 19, 28, '114.122.106.58', '114.142.168.35', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Teddy Gibs (playerid=2, IP=114.142.168.35). Report message: mi', '2022-09-11 08:06:53'),
(182, 'accept_report', 19, 7, '114.122.106.58', '114.122.106.58', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Dante Gibs (playerid=34, IP=36.85.222.70). Report message: min', '2022-09-11 08:07:20'),
(183, 'accept_report', 19, 165, '114.122.106.58', '114.79.4.192', 'Admin Elbier (playerid=27, IP=114.122.106.58) accept report from Diego Dioo (playerid=24, IP=114.79.4.192). Report message: Lay', '2022-09-11 08:11:42'),
(184, 'answer', 19, 28, '114.122.106.58', '114.142.168.35', 'Admin Elbier (playerid=27, IP=114.122.106.58) answer Teddy Gibs (playerid=2, IP=114.142.168.35) question. Question: min maksudn', '2022-09-11 08:13:43'),
(185, 'answer', 108, 28, '103.108.130.2', '114.142.168.35', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Teddy Gibs (playerid=2, IP=114.142.168.35) question. Question: cmd buat tau ', '2022-09-11 08:15:21'),
(186, 'answer', 10, 18, '182.1.78.13', '110.137.36.231', 'Admin AnantaHere (playerid=31, IP=182.1.78.13) answer Smith Levithan (playerid=11, IP=110.137.36.231) question. Question: minn ', '2022-09-11 08:20:47'),
(187, 'answer', 108, 18, '103.108.130.2', '110.137.36.231', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Smith Levithan (playerid=11, IP=110.137.36.231) question. Question: kalo dri', '2022-09-11 08:23:07'),
(188, 'answer', 108, 13, '103.108.130.2', '125.164.19.185', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Kudak Deblow (playerid=16, IP=125.164.19.185) question. Question: Min ini sa', '2022-09-11 08:27:44'),
(189, 'answer', 108, 28, '103.108.130.2', '114.142.168.35', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Teddy Gibs (playerid=2, IP=114.142.168.35) question. Question: min, ga ada g', '2022-09-11 08:29:51'),
(190, 'answer', 108, 16, '103.108.130.2', '36.85.6.140', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Axel Volter (playerid=5, IP=36.85.6.140) question. Question: pandu sibuk ga?', '2022-09-11 08:31:01'),
(191, 'accept_report', 108, 221, '103.108.130.2', '180.214.233.86', 'Admin pandu (playerid=18, IP=103.108.130.2) accept report from Zerozz Namikaze (playerid=33, IP=180.214.233.86). Report message', '2022-09-11 08:40:02'),
(192, 'answer', 108, 28, '103.108.130.2', '114.142.168.35', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Teddy Gibs (playerid=2, IP=114.142.168.35) question. Question: bar biru dise', '2022-09-11 08:41:03'),
(193, 'answer', 108, 40, '103.108.130.2', '140.213.47.107', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Ranz Summers (playerid=19, IP=140.213.47.107) question. Question: cara nemui', '2022-09-11 08:42:47'),
(194, 'ban', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=18, IP=103.108.130.2) bans account leonel. Reason: cit ', '2022-09-11 08:46:34'),
(195, 'ban', 108, 236, '103.108.130.2', '114.124.245.184', 'Admin pandu (playerid=18, IP=103.108.130.2) bans Kueza Hingston (playerid=13, IP=114.124.245.184). Reason: 30', '2022-09-11 08:46:39'),
(196, 'answer', 108, 28, '103.108.130.2', '114.142.168.35', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Teddy Gibs (playerid=2, IP=114.142.168.35) question. Question: minuman buat ', '2022-09-11 08:49:28'),
(197, 'answer', 108, 151, '103.108.130.2', '114.10.71.155', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Han Shinigami (playerid=32, IP=114.10.71.155) question. Question: min di gps', '2022-09-11 08:51:47'),
(198, 'answer', 108, 202, '103.108.130.2', '125.167.116.163', 'Admin pandu (playerid=18, IP=103.108.130.2) answer Roudey Conner (playerid=15, IP=125.167.116.163) question. Question: min gaji', '2022-09-11 08:53:20'),
(199, 'answer', 19, 16, '103.139.10.100', '36.85.6.140', 'Admin Elbier (playerid=36, IP=103.139.10.100) answer Axel Volter (playerid=5, IP=36.85.6.140) question. Question: Elbier sibuk?', '2022-09-11 09:04:36'),
(200, 'jail', 86, 173, '120.188.5.44', '125.166.13.103', 'Admin Godzillas (playerid=8, IP=120.188.5.44) jails Hilmy Fauzan (playerid=19, IP=125.166.13.103) for 60 minutes. Reason: Non R', '2022-09-11 09:14:11'),
(201, 'answer', 19, 173, '103.139.10.100', '125.166.13.103', 'Admin Elbier (playerid=36, IP=103.139.10.100) answer Hilmy Fauzan (playerid=19, IP=125.166.13.103) question. Question: layar ju', '2022-09-11 09:16:40'),
(202, 'accept_report', 86, 28, '120.188.5.44', '114.142.168.35', 'Admin Godzillas (playerid=8, IP=120.188.5.44) accept report from Teddy Gibs (playerid=2, IP=114.142.168.35). Report message: mi', '2022-09-11 09:17:53'),
(203, 'answer', 19, 219, '103.139.10.100', '140.213.146.58', 'Admin Elbier (playerid=36, IP=103.139.10.100) answer Robert Brooklyn (playerid=24, IP=140.213.146.58) question. Question: min b', '2022-09-11 09:21:29'),
(204, 'answer', 19, 31, '103.139.10.100', '103.143.63.25', 'Admin Elbier (playerid=36, IP=103.139.10.100) answer Popix Vicente (playerid=1, IP=103.143.63.25) question. Question: cara liat', '2022-09-11 09:26:21'),
(205, 'accept_report', 86, 16, '120.188.5.44', '36.85.6.140', 'Admin Godzillas (playerid=8, IP=120.188.5.44) accept stuck request from Axel Volter (playerid=5, IP=36.85.6.140).', '2022-09-11 09:37:37'),
(206, 'deny_report', 86, 143, '120.188.5.44', '125.164.18.245', 'Admin Godzillas (playerid=8, IP=120.188.5.44) deny report from Polse Lovve (playerid=21, IP=125.164.18.245). Report message: mi', '2022-09-11 09:48:12'),
(207, 'accept_report', 86, 72, '120.188.5.44', '140.213.231.106', 'Admin Godzillas (playerid=8, IP=120.188.5.44) accept report from Arthur Shelby (playerid=13, IP=140.213.231.106). Report messag', '2022-09-11 09:51:16'),
(208, 'answer', 86, 192, '120.188.5.44', '180.252.90.229', 'Admin Godzillas (playerid=8, IP=120.188.5.44) answer Jahmiree Maleek (playerid=20, IP=180.252.90.229) question. Question: cara ', '2022-09-11 09:51:52'),
(209, 'answer', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=35, IP=103.139.10.100) answer Jahmiree Maleek (playerid=28, IP=180.252.90.229) question. Question: cmd a', '2022-09-11 09:57:29'),
(210, 'accept_report', 86, 172, '114.5.250.168', '182.1.112.171', 'Admin Godzillas (playerid=22, IP=114.5.250.168) accept report from Reamy Xhyner (playerid=1, IP=182.1.112.171). Report message:', '2022-09-11 10:06:25'),
(211, 'answer', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=7, IP=103.139.10.100) answer Jahmiree Maleek (playerid=28, IP=180.252.90.229) question. Question: ko gua', '2022-09-11 10:10:38'),
(212, 'accept_report', 86, 46, '114.5.250.168', '112.215.239.88', 'Admin Godzillas (playerid=22, IP=114.5.250.168) accept report from Aiden Pearce (playerid=8, IP=112.215.239.88). Report message', '2022-09-11 10:12:05'),
(213, 'answer', 86, 11, '114.5.250.168', '8.30.234.216', 'Admin godzillas (playerid=23, IP=114.5.250.168) answer Plutarco Echeverra (playerid=9, IP=8.30.234.216) question. Question: ini', '2022-09-11 10:21:15'),
(214, 'jail', 86, 64, '114.5.250.168', '114.5.250.168', 'Admin godzillas (playerid=23, IP=114.5.250.168) offline jails Budi_Alfarizi for 1 minutes. Reason: bug', '2022-09-11 10:23:30'),
(215, 'accept_report', 19, 193, '103.139.10.100', '110.137.193.247', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Aaron Petterson (playerid=14, IP=110.137.193.247). Report messa', '2022-09-11 11:19:07'),
(216, 'accept_report', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Jayce Hylton (playerid=12, IP=36.72.160.141). Report message: m', '2022-09-11 11:19:34'),
(217, 'answer', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Jayce Hylton (playerid=12, IP=36.72.160.141) question. Question: min minta ', '2022-09-11 11:19:56'),
(218, 'accept_report', 19, 46, '103.139.10.100', '112.215.239.88', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Aiden Pearce (playerid=13, IP=112.215.239.88). Report message: ', '2022-09-11 11:20:05'),
(219, 'answer', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Jayce Hylton (playerid=12, IP=36.72.160.141) question. Question: desa diman', '2022-09-11 11:20:42'),
(220, 'accept_report', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Jahmiree Maleek (playerid=6, IP=180.252.90.229). Report message', '2022-09-11 11:21:53'),
(221, 'jail', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=4, IP=103.139.10.100) jails Jahmiree Maleek (playerid=6, IP=180.252.90.229) for 1 minutes. Reason: bug', '2022-09-11 11:22:02'),
(222, 'accept_report', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Jayce Hylton (playerid=12, IP=36.72.160.141). Report message: m', '2022-09-11 11:22:07'),
(223, 'answer', 19, 60, '103.139.10.100', '114.10.29.17', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Daniell Wade (playerid=16, IP=114.10.29.17) question. Question: min kok bel', '2022-09-11 11:24:04'),
(224, 'accept_report', 19, 195, '103.139.10.100', '125.160.228.57', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Duncan Victorovich (playerid=17, IP=125.160.228.57). Report mes', '2022-09-11 11:24:44'),
(225, 'jail', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=4, IP=103.139.10.100) offline jails Edward_Francisco for 1 minutes. Reason: bug', '2022-09-11 11:27:23'),
(226, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Liddell Lee (playerid=1, IP=116.206.9.16). Report message: beli', '2022-09-11 11:27:46'),
(227, 'answer', 19, 65, '103.139.10.100', '114.10.21.206', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Ken Mang (playerid=5, IP=114.10.21.206) question. Question: min kalo jual k', '2022-09-11 11:28:32'),
(228, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Liddell Lee (playerid=1, IP=116.206.9.16). Report message: haru', '2022-09-11 11:29:22'),
(229, 'answer', 19, 165, '103.139.10.100', '114.79.2.84', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Diego Dioo (playerid=22, IP=114.79.2.84) question. Question: min reff skill', '2022-09-11 11:35:41'),
(230, 'answer', 19, 36, '103.139.10.100', '36.72.160.141', 'Admin Elbier (playerid=4, IP=103.139.10.100) answer Jayce Hylton (playerid=12, IP=36.72.160.141) question. Question: min kasih ', '2022-09-11 11:40:17'),
(231, 'jail', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=7, IP=125.166.112.180) offline jails Edward_Francisco for 1 minutes. Reason: bug', '2022-09-11 11:40:39'),
(232, 'accept_report', 19, 60, '103.139.10.100', '114.10.29.17', 'Admin Elbier (playerid=4, IP=103.139.10.100) accept report from Daniell Wade (playerid=16, IP=114.10.29.17). Report message: he', '2022-09-11 11:40:41'),
(233, 'answer', 19, 60, '103.139.10.100', '114.10.29.17', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Daniell Wade (playerid=16, IP=114.10.29.17) question. Question: info clue b', '2022-09-11 11:44:49'),
(234, 'accept_report', 19, 144, '103.139.10.100', '111.95.61.33', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Patrick Benjamin (playerid=13, IP=111.95.61.33). Report message', '2022-09-11 11:48:40'),
(235, 'accept_report', 19, 15, '103.139.10.100', '110.137.193.42', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Oscar Vengeance (playerid=14, IP=110.137.193.42). Report messag', '2022-09-11 11:50:58'),
(236, 'answer', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Jahmiree Maleek (playerid=6, IP=180.252.90.229) question. Question: bm nya ', '2022-09-11 11:55:25');
INSERT INTO `admin_activities` (`id`, `type`, `issuer`, `receiver`, `issuer_ip_address`, `receiver_ip_address`, `description`, `created_at`) VALUES
(237, 'answer', 19, 12, '103.139.10.100', '118.99.81.125', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Ferdison Alexander (playerid=15, IP=118.99.81.125) question. Question: min ', '2022-09-11 11:58:59'),
(238, 'answer', 19, 60, '103.139.10.100', '114.10.29.17', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Daniell Wade (playerid=16, IP=114.10.29.17) question. Question: las baranca', '2022-09-11 12:02:38'),
(239, 'answer', 19, 31, '103.139.10.100', '103.143.63.25', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Popix Vicente (playerid=4, IP=103.143.63.25) question. Question: bg bantu g', '2022-09-11 12:13:46'),
(240, 'accept_report', 19, 165, '103.139.10.100', '114.79.2.84', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Diego Dioo (playerid=17, IP=114.79.2.84). Report message: min g', '2022-09-11 12:14:02'),
(241, 'accept_report', 19, 126, '103.139.10.100', '110.137.36.231', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Jack Yaguna (playerid=20, IP=110.137.36.231). Report message: m', '2022-09-11 12:15:16'),
(242, 'accept_report', 86, 31, '114.5.250.168', '103.143.63.25', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Popix Vicente (playerid=4, IP=103.143.63.25). Report message', '2022-09-11 12:15:47'),
(243, 'answer', 19, 192, '103.139.10.100', '180.252.90.229', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Jahmiree Maleek (playerid=6, IP=180.252.90.229) question. Question: nyerah ', '2022-09-11 12:19:54'),
(244, 'answer', 86, 31, '114.5.250.168', '103.143.63.25', 'Admin Godzillas (playerid=24, IP=114.5.250.168) answer Popix Vicente (playerid=4, IP=103.143.63.25) question. Question: gimana ', '2022-09-11 12:22:20'),
(245, 'accept_report', 86, 18, '114.5.250.168', '110.137.36.231', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Smith Levithan (playerid=19, IP=110.137.36.231). Report mess', '2022-09-11 12:28:31'),
(246, 'accept_report', 86, 254, '114.5.250.168', '125.167.75.20', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Jefferie Dominico (playerid=26, IP=125.167.75.20). Report me', '2022-09-11 12:28:35'),
(247, 'answer', 19, 152, '103.139.10.100', '112.215.239.197', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer RyuuGi Exodiaz (playerid=27, IP=112.215.239.197) question. Question: min gk', '2022-09-11 12:28:48'),
(248, 'accept_report', 19, 18, '103.139.10.100', '110.137.36.231', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Smith Levithan (playerid=19, IP=110.137.36.231). Report message', '2022-09-11 12:28:57'),
(249, 'accept_report', 86, 12, '114.5.250.168', '118.99.81.125', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Ferdison Alexander (playerid=30, IP=118.99.81.125). Report m', '2022-09-11 12:29:35'),
(250, 'accept_report', 86, 254, '114.5.250.168', '125.167.75.20', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Jefferie Dominico (playerid=26, IP=125.167.75.20). Report me', '2022-09-11 12:30:15'),
(251, 'accept_report', 86, 152, '114.5.250.168', '112.215.239.197', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from RyuuGi Exodiaz (playerid=27, IP=112.215.239.197). Report mes', '2022-09-11 12:30:33'),
(252, 'accept_report', 86, 18, '114.5.250.168', '110.137.36.231', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Smith Levithan (playerid=25, IP=110.137.36.231). Report mess', '2022-09-11 12:32:58'),
(253, 'answer', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Paul Bassano (playerid=23, IP=110.137.36.239) question. Question: cmd ngudu', '2022-09-11 12:34:07'),
(254, 'answer', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Paul Bassano (playerid=23, IP=110.137.36.239) question. Question: mksdnya g', '2022-09-11 12:35:00'),
(255, 'accept_report', 86, 217, '114.5.250.168', '140.213.24.209', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Ramm Mulki (playerid=31, IP=140.213.24.209). Report message:', '2022-09-11 12:39:13'),
(256, 'accept_report', 19, 254, '103.139.10.100', '125.167.75.20', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Jefferie Dominico (playerid=26, IP=125.167.75.20). Report messa', '2022-09-11 12:43:10'),
(257, 'accept_report', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=3, IP=103.139.10.100) accept report from Paul Bassano (playerid=23, IP=110.137.36.239). Report message: ', '2022-09-11 12:43:55'),
(258, 'jail', 19, 7, '103.139.10.100', '103.139.10.100', 'Admin Elbier (playerid=3, IP=103.139.10.100) offline jails Ryu_Exel for 30 minutes. Reason: Insult', '2022-09-11 12:45:43'),
(259, 'answer', 19, 219, '103.139.10.100', '140.213.147.156', 'Admin Elbier (playerid=3, IP=103.139.10.100) answer Robert Brooklyn (playerid=16, IP=140.213.147.156) question. Question: min k', '2022-09-11 12:46:05'),
(260, 'accept_report', 86, 11, '114.5.250.168', '8.29.105.188', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Plutarco Echeverra (playerid=9, IP=8.29.105.188). Report mes', '2022-09-11 12:48:59'),
(261, 'accept_report', 86, 254, '114.5.250.168', '125.167.75.20', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Jefferie Dominico (playerid=26, IP=125.167.75.20). Report me', '2022-09-11 12:52:37'),
(262, 'deny_report', 86, 60, '114.5.250.168', '114.10.29.17', 'Admin Godzillas (playerid=24, IP=114.5.250.168) deny report from Daniell Wade (playerid=1, IP=114.10.29.17). Report message: mi', '2022-09-11 12:54:12'),
(263, 'accept_report', 86, 105, '114.5.250.168', '103.139.10.148', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Kenzo Devalos (playerid=0, IP=103.139.10.148). Report messag', '2022-09-11 12:56:25'),
(264, 'deny_report', 86, 60, '114.5.250.168', '114.10.29.17', 'Admin Godzillas (playerid=24, IP=114.5.250.168) deny report from Daniell Wade (playerid=1, IP=114.10.29.17). Report message: in', '2022-09-11 13:00:52'),
(265, 'accept_report', 86, 173, '114.5.250.168', '125.166.13.103', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Hilmy Fauzan (playerid=22, IP=125.166.13.103). Report messag', '2022-09-11 13:01:22'),
(266, 'deny_report', 86, 254, '114.5.250.168', '125.167.75.20', 'Admin Godzillas (playerid=24, IP=114.5.250.168) deny report from Jefferie Dominico (playerid=4, IP=125.167.75.20). Report messa', '2022-09-11 13:48:20'),
(267, 'accept_report', 86, 105, '114.5.250.168', '103.139.10.148', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Kenzo Devalos (playerid=30, IP=103.139.10.148). Report messa', '2022-09-11 13:48:36'),
(268, 'deny_report', 86, 31, '114.5.250.168', '103.143.63.25', 'Admin Godzillas (playerid=24, IP=114.5.250.168) deny report from Popix Vicente (playerid=23, IP=103.143.63.25). Report message:', '2022-09-11 13:49:13'),
(269, 'deny_report', 86, 131, '114.5.250.168', '140.213.192.14', 'Admin Godzillas (playerid=24, IP=114.5.250.168) deny report from Leon Kennedy (playerid=5, IP=140.213.192.14). Report message: ', '2022-09-11 13:49:20'),
(270, 'accept_report', 86, 36, '114.5.250.168', '36.72.160.141', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Jayce Hylton (playerid=0, IP=36.72.160.141). Report message:', '2022-09-11 13:49:25'),
(271, 'accept_report', 86, 165, '114.5.250.168', '114.79.2.84', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Diego Dioo (playerid=17, IP=114.79.2.84). Report message: To', '2022-09-11 13:49:36'),
(272, 'accept_report', 86, 131, '114.5.250.168', '140.213.192.14', 'Admin Godzillas (playerid=24, IP=114.5.250.168) accept report from Leon Kennedy (playerid=5, IP=140.213.192.14). Report message', '2022-09-11 13:49:47'),
(273, 'accept_report', 136, 131, '114.79.37.111', '140.213.192.14', 'Admin bastian (playerid=0, IP=114.79.37.111) accept report from Leon Kennedy (playerid=1, IP=140.213.192.14). Report message: b', '2022-09-11 16:38:53'),
(274, 'accept_report', 136, 79, '114.79.37.111', '8.29.105.186', 'Admin bastian (playerid=0, IP=114.79.37.111) accept report from Howard Barnett (playerid=17, IP=8.29.105.186). Report message: ', '2022-09-11 16:40:23'),
(275, 'accept_report', 86, 105, '114.5.250.168', '114.122.100.188', 'Admin Godzillas (playerid=14, IP=114.5.250.168) accept report from Kenzo Devalos (playerid=19, IP=114.122.100.188). Report mess', '2022-09-11 16:49:04'),
(276, 'answer', 28, 99, '36.85.6.140', '36.74.40.1', 'Admin Axel (playerid=22, IP=36.85.6.140) answer Kiana Nakamura (playerid=0, IP=36.74.40.1) question. Question: skill mekanik ga', '2022-09-11 16:53:36'),
(277, 'accept_report', 28, 9, '36.85.6.140', '140.213.44.40', 'Admin Axel (playerid=22, IP=36.85.6.140) accept report from Smith Martin (playerid=20, IP=140.213.44.40). Report message: min a', '2022-09-11 16:58:22'),
(278, 'accept_report', 77, 239, '182.2.39.188', '180.214.232.25', 'Admin Kepin (playerid=8, IP=182.2.39.188) accept report from Shin Fushima (playerid=2, IP=180.214.232.25). Report message: min ', '2022-09-11 16:59:57'),
(279, 'accept_report', 28, 17, '36.85.6.140', '180.244.160.162', 'Admin Axel (playerid=22, IP=36.85.6.140) accept report from Rojer Hawkins (playerid=10, IP=180.244.160.162). Report message: ko', '2022-09-11 17:01:19'),
(280, 'deny_report', 86, 5, '114.5.250.168', '114.79.5.80', 'Admin Godzillas (playerid=14, IP=114.5.250.168) deny report from Frankie Charles (playerid=7, IP=114.79.5.80). Report message: ', '2022-09-11 17:01:53'),
(281, 'answer', 77, 180, '182.2.39.188', '140.213.165.230', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Jay Francisco (playerid=24, IP=140.213.165.230) question. Question: min cmd ke', '2022-09-11 17:02:52'),
(282, 'answer', 28, 117, '36.85.6.140', '36.65.2.62', 'Admin Axel (playerid=22, IP=36.85.6.140) answer Putra Yosua (playerid=3, IP=36.65.2.62) question. Question: permisi min | Answe', '2022-09-11 17:06:51'),
(283, 'answer', 28, 117, '36.85.6.140', '36.65.2.62', 'Admin Axel (playerid=22, IP=36.85.6.140) answer Putra Yosua (playerid=3, IP=36.65.2.62) question. Question: bisa teleport saya ', '2022-09-11 17:07:44'),
(284, 'answer', 28, 5, '36.85.6.140', '114.79.5.80', 'Admin Axel (playerid=22, IP=36.85.6.140) answer Frankie Charles (playerid=7, IP=114.79.5.80) question. Question: min ini /pay g', '2022-09-11 17:12:33'),
(285, 'answer', 28, 264, '36.85.6.140', '114.79.39.124', 'Admin Axel (playerid=22, IP=36.85.6.140) answer Ten Silvester (playerid=26, IP=114.79.39.124) question. Question: tempat beli g', '2022-09-11 17:13:19'),
(286, 'answer', 43, 5, '114.4.78.165', '114.79.5.80', 'Admin Toyotomi (playerid=12, IP=114.4.78.165) answer Frankie Charles (playerid=7, IP=114.79.5.80) question. Question: kok ini a', '2022-09-11 17:13:35'),
(287, 'answer', 77, 264, '182.2.39.188', '114.79.39.124', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Ten Silvester (playerid=26, IP=114.79.39.124) question. Question: tutup semua ', '2022-09-11 17:13:52'),
(288, 'answer', 77, 5, '182.2.39.188', '114.79.5.80', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Frankie Charles (playerid=7, IP=114.79.5.80) question. Question: itu kasih uan', '2022-09-11 17:14:08'),
(289, 'accept_report', 77, 139, '182.2.39.188', '140.213.36.206', 'Admin Kepin (playerid=8, IP=182.2.39.188) accept report from Andrey Rodriguez (playerid=2, IP=140.213.36.206). Report message: ', '2022-09-11 17:16:38'),
(290, 'answer', 86, 48, '114.5.250.168', '120.188.87.244', 'Admin Godzillas (playerid=14, IP=114.5.250.168) answer Imba Batustita (playerid=9, IP=120.188.87.244) question. Question: malam', '2022-09-11 17:20:20'),
(291, 'answer', 77, 213, '182.2.39.188', '114.124.180.53', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Jerome Smith (playerid=15, IP=114.124.180.53) question. Question: pada ngerp y', '2022-09-11 17:25:40'),
(292, 'answer', 169, 213, '140.213.192.14', '114.124.180.53', 'Admin Marxist (playerid=1, IP=140.213.192.14) answer Jerome Smith (playerid=15, IP=114.124.180.53) question. Question: saran mi', '2022-09-11 17:27:55'),
(293, 'answer', 77, 117, '182.2.39.188', '36.65.2.62', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Putra Yosua (playerid=3, IP=36.65.2.62) question. Question: min jadi miner gmn', '2022-09-11 17:31:14'),
(294, 'answer', 77, 117, '182.2.39.188', '36.65.2.62', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Putra Yosua (playerid=3, IP=36.65.2.62) question. Question: sudah min tapi ga ', '2022-09-11 17:31:48'),
(295, 'answer', 77, 117, '182.2.39.188', '36.65.2.62', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Putra Yosua (playerid=3, IP=36.65.2.62) question. Question: apa harus bawa pic', '2022-09-11 17:32:11'),
(296, 'answer', 77, 264, '182.2.39.188', '114.79.39.124', 'Admin Kepin (playerid=8, IP=182.2.39.188) answer Stenly Silvester (playerid=18, IP=114.79.39.124) question. Question: saya warg', '2022-09-11 17:32:46'),
(297, 'answer', 136, 264, '114.79.37.111', '114.79.39.124', 'Admin bastian (playerid=20, IP=114.79.37.111) answer Stenly Silvester (playerid=18, IP=114.79.39.124) question. Question: ga ad', '2022-09-11 17:33:22'),
(298, 'accept_report', 136, 266, '114.79.37.111', '115.178.221.41', 'Admin bastian (playerid=20, IP=114.79.37.111) accept report from Tan Stevano (playerid=9, IP=115.178.221.41). Report message: g', '2022-09-11 17:50:16'),
(299, 'answer', 43, 264, '114.4.78.165', '114.79.39.124', 'Admin Toyotomi (playerid=12, IP=114.4.78.165) answer Stenly Silvester (playerid=4, IP=114.79.39.124) question. Question: nyalai', '2022-09-11 18:02:04'),
(300, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: min ini ga ', '2022-09-11 18:16:35'),
(301, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: Jadi gini K', '2022-09-11 18:17:33'),
(302, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: nah dia cum', '2022-09-11 18:18:20'),
(303, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: ada | Answe', '2022-09-11 18:18:38'),
(304, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: tadi yang b', '2022-09-11 18:24:59'),
(305, 'answer', 28, 54, '36.85.3.156', '103.108.130.115', 'Admin Axel (playerid=11, IP=36.85.3.156) answer Rudulf Geraldo (playerid=4, IP=103.108.130.115) question. Question: nama dc nya', '2022-09-11 18:25:19'),
(306, 'accept_report', 28, 172, '36.85.3.156', '125.166.13.103', 'Admin Axel (playerid=11, IP=36.85.3.156) accept report from Reamy Xhyner (playerid=17, IP=125.166.13.103). Report message: ada ', '2022-09-11 18:28:22'),
(307, 'accept_report', 28, 5, '36.85.3.156', '114.79.5.80', 'Admin Axel (playerid=11, IP=36.85.3.156) accept report from Frankie Charles (playerid=3, IP=114.79.5.80). Report message: min ', '2022-09-11 18:35:00'),
(308, 'answer', 28, 172, '36.85.3.156', '125.166.13.103', 'Admin Axel (playerid=9, IP=36.85.3.156) answer Reamy Xhyner (playerid=17, IP=125.166.13.103) question. Question: kendaraan ae d', '2022-09-11 18:46:34'),
(309, 'answer', 41, 31, '125.166.112.180', '103.143.63.25', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Popix Vicente (playerid=8, IP=103.143.63.25) question. Question: udah ', '2022-09-11 18:52:17'),
(310, 'accept_report', 41, 172, '125.166.112.180', '125.166.13.103', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Reamy Xhyner (playerid=17, IP=125.166.13.103). Report mess', '2022-09-11 19:08:56'),
(311, 'accept_report', 136, 101, '114.79.37.111', '114.79.37.111', 'Admin bastian (playerid=2, IP=114.79.37.111) accept report from Elcapone Pettyfer (playerid=9, IP=103.237.32.218). Report messa', '2022-09-11 19:34:42'),
(312, 'accept_report', 41, 268, '125.166.112.180', '103.237.32.218', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Elcapone Pettyfer (playerid=9, IP=103.237.32.218). Report ', '2022-09-11 19:47:25'),
(313, 'accept_report', 155, 172, '182.2.38.218', '125.166.13.103', 'Admin TerCooL (playerid=7, IP=182.2.38.218) accept report from Reamy Xhyner (playerid=0, IP=125.166.13.103). Report message: mo', '2022-09-11 19:57:23'),
(314, 'accept_report', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Minami Chibiko (playerid=5, IP=125.164.148.32). Report mes', '2022-09-11 19:58:46'),
(315, 'accept_report', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Minami Chibiko (playerid=5, IP=125.164.148.32). Report mes', '2022-09-11 20:02:49'),
(316, 'answer', 155, 268, '182.2.38.218', '103.237.32.218', 'Admin TerCooL (playerid=7, IP=182.2.38.218) answer Elcapone Pettyfer (playerid=9, IP=103.237.32.218) question. Question: jawaba', '2022-09-11 20:11:26'),
(317, 'answer', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Minami Chibiko (playerid=5, IP=125.164.148.32) question. Question: ada', '2022-09-11 20:11:44'),
(318, 'answer', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Minami Chibiko (playerid=5, IP=125.164.148.32) question. Question: man', '2022-09-11 20:12:09'),
(319, 'answer', 155, 194, '182.2.38.218', '140.213.67.213', 'Admin TerCooL (playerid=7, IP=182.2.38.218) answer Fajri Maulana (playerid=6, IP=140.213.67.213) question. Question: min kalo a', '2022-09-11 20:12:19'),
(320, 'accept_report', 155, 194, '182.2.38.218', '140.213.67.213', 'Admin TerCooL (playerid=7, IP=182.2.38.218) accept report from Fajri Maulana (playerid=6, IP=140.213.67.213). Report message: t', '2022-09-11 20:14:06'),
(321, 'answer', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Minami Chibiko (playerid=5, IP=125.164.148.32) question. Question: RUK', '2022-09-11 20:14:35'),
(322, 'accept_report', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Minami Chibiko (playerid=5, IP=125.164.148.32). Report mes', '2022-09-11 20:16:45'),
(323, 'accept_report', 41, 25, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Minami Chibiko (playerid=5, IP=125.164.148.32). Report mes', '2022-09-11 20:17:20'),
(324, 'answer', 155, 192, '182.2.38.218', '180.252.90.229', 'Admin TerCooL (playerid=7, IP=182.2.38.218) answer Jahmiree Maleek (playerid=10, IP=180.252.90.229) question. Question: min clu', '2022-09-11 20:19:50'),
(325, 'answer', 41, 119, '125.166.112.180', '182.2.38.218', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer TerCooL (playerid=7, IP=182.2.38.218) question. Question: min  | Answe', '2022-09-11 20:20:09'),
(326, 'jail', 41, 23, '125.166.112.180', '125.166.112.180', 'Admin Rukitateki (playerid=5, IP=125.166.112.180) offline jails Elcapone_Pettyfer for 2022 minutes. Reason: RE RP SAPD Contact ', '2022-09-11 21:01:37'),
(327, 'answer', 136, 272, '114.79.37.111', '111.95.42.80', 'Admin bastian (playerid=1, IP=114.79.37.111) answer Canales Reynoso (playerid=5, IP=111.95.42.80) question. Question: ini saya ', '2022-09-11 21:40:31'),
(328, 'answer', 41, 31, '125.166.112.180', '103.143.63.25', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) answer Popix Vicente (playerid=7, IP=103.143.63.25) question. Question: bg ru', '2022-09-11 21:41:22'),
(329, 'answer', 41, 31, '125.166.112.180', '103.143.63.25', 'Admin Rukitateki (playerid=3, IP=125.166.112.180) answer Popix Vicente (playerid=7, IP=103.143.63.25) question. Question: use #', '2022-09-11 21:44:49'),
(330, 'answer', 136, 31, '114.79.37.111', '103.143.63.25', 'Admin bastian (playerid=1, IP=114.79.37.111) answer Popix Vicente (playerid=7, IP=103.143.63.25) question. Question: iya | Answ', '2022-09-11 21:45:46'),
(331, 'answer', 108, 247, '223.255.225.75', '114.10.9.45', 'Admin pandu (playerid=6, IP=223.255.225.75) answer Jelol Junior (playerid=5, IP=114.10.9.45) question. Question: bang pandu | A', '2022-09-12 00:19:02'),
(332, 'accept_report', 136, 247, '114.79.37.111', '114.10.23.206', 'Admin bastian (playerid=7, IP=114.79.37.111) accept report from Jelol Junior (playerid=5, IP=114.10.23.206). Report message: ak', '2022-09-12 00:33:07'),
(333, 'jail', 136, 247, '114.79.37.111', '114.10.23.206', 'Admin bastian (playerid=7, IP=114.79.37.111) jails Jelol Junior (playerid=5, IP=114.10.23.206) for 1 minutes. Reason: bug', '2022-09-12 00:34:18'),
(334, 'answer', 136, 35, '114.79.37.111', '114.122.205.160', 'Admin bastian (playerid=7, IP=114.79.37.111) answer Andrew Wesly (playerid=3, IP=114.122.205.160) question. Question: min mc di', '2022-09-12 01:18:22'),
(335, 'answer', 28, 217, '36.85.6.140', '140.213.45.6', 'Admin Axel (playerid=2, IP=36.85.6.140) answer Ramm Mulki (playerid=1, IP=140.213.45.6) question. Question: bng cara take job g', '2022-09-12 01:26:31'),
(336, 'accept_report', 28, 195, '36.85.6.140', '182.2.135.161', 'Admin Axel (playerid=2, IP=36.85.6.140) accept report from Duncan Victorovich (playerid=3, IP=182.2.135.161). Report message: b', '2022-09-12 01:31:49'),
(337, 'answer', 28, 217, '36.85.6.140', '140.213.45.6', 'Admin Axel (playerid=2, IP=36.85.6.140) answer Ramm Mulki (playerid=1, IP=140.213.45.6) question. Question: bng ambil cargo nya', '2022-09-12 01:32:54'),
(338, 'answer', 28, 16, '36.85.6.140', '36.85.6.140', 'Admin Axel (playerid=7, IP=36.85.6.140) answer Ethan Pietro (playerid=4, IP=125.161.70.33) question. Question: cmd staterpack n', '2022-09-12 03:28:34'),
(339, 'accept_report', 136, 193, '114.79.37.111', '180.252.162.98', 'Admin bastian (playerid=6, IP=114.79.37.111) accept report from Aaron Petterson (playerid=2, IP=180.252.162.98). Report message', '2022-09-12 03:34:50'),
(340, 'jail', 136, 193, '114.79.37.111', '180.252.162.98', 'Admin bastian (playerid=6, IP=114.79.37.111) jails Aaron Petterson (playerid=2, IP=180.252.162.98) for 1 minutes. Reason: bug', '2022-09-12 03:35:40'),
(341, 'jail', 136, 88, '114.79.37.111', '202.80.215.118', 'Admin bastian (playerid=6, IP=114.79.37.111) jails Qenzo Zevallo (playerid=8, IP=202.80.215.118) for 1 minutes. Reason: bug', '2022-09-12 03:48:00'),
(342, 'answer', 136, 193, '114.79.39.233', '180.252.162.98', 'Admin bastian (playerid=8, IP=114.79.39.233) answer Aaron Petterson (playerid=7, IP=180.252.162.98) question. Question: beli se', '2022-09-12 04:42:35'),
(343, 'answer', 136, 193, '114.79.39.233', '180.252.162.98', 'Admin bastian (playerid=8, IP=114.79.39.233) answer Aaron Petterson (playerid=7, IP=180.252.162.98) question. Question: namanya', '2022-09-12 04:43:41'),
(344, 'answer', 86, 193, '114.5.250.168', '180.252.162.98', 'Admin Godzillas (playerid=4, IP=114.5.250.168) answer Aaron Petterson (playerid=7, IP=180.252.162.98) question. Question: min h', '2022-09-12 04:58:16'),
(345, 'accept_report', 43, 193, '114.10.31.133', '180.252.162.98', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) accept report from Aaron Petterson (playerid=7, IP=180.252.162.98). Report messag', '2022-09-12 04:59:31'),
(346, 'answer', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Qenzo Zevallo (playerid=2, IP=202.80.215.118) question. Question: apakah b', '2022-09-12 05:12:39'),
(347, 'answer', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Qenzo Zevallo (playerid=2, IP=202.80.215.118) question. Question: apa cmd ', '2022-09-12 05:14:07'),
(348, 'answer', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Qenzo Zevallo (playerid=2, IP=202.80.215.118) question. Question: cara amb', '2022-09-12 05:25:14'),
(349, 'answer', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Qenzo Zevallo (playerid=2, IP=202.80.215.118) question. Question: udah d k', '2022-09-12 05:28:04'),
(350, 'answer', 43, 207, '114.10.31.133', '125.160.229.125', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Barnard Griffin (playerid=10, IP=125.160.229.125) question. Question: min ', '2022-09-12 05:29:33'),
(351, 'answer', 43, 282, '114.10.31.133', '103.213.128.27', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Nicholl Barttford (playerid=6, IP=103.213.128.27) question. Question: cara', '2022-09-12 05:30:51'),
(352, 'jail', 28, 62, '36.85.6.140', '103.126.86.51', 'Admin Axel (playerid=11, IP=36.85.6.140) jails Vittorini Leovince (playerid=8, IP=103.126.86.51) for 1 minutes. Reason: Bug', '2022-09-12 05:55:17'),
(353, 'accept_report', 28, 17, '36.85.6.140', '180.244.160.162', 'Admin Axel (playerid=11, IP=36.85.6.140) accept report from Rojer Hawkins (playerid=1, IP=180.244.160.162). Report message: ini', '2022-09-12 06:23:07'),
(354, 'accept_report', 28, 12, '36.85.6.140', '118.99.81.125', 'Admin Axel (playerid=11, IP=36.85.6.140) accept report from Ferdison Alexander (playerid=6, IP=118.99.81.125). Report message: ', '2022-09-12 06:23:54'),
(355, 'accept_report', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) accept report from Qenzo Zevallo (playerid=4, IP=202.80.215.118). Report message:', '2022-09-12 06:29:41'),
(356, 'answer', 28, 88, '36.85.6.140', '202.80.215.118', 'Admin Axel (playerid=11, IP=36.85.6.140) answer Qenzo Zevallo (playerid=4, IP=202.80.215.118) question. Question: bagaimana car', '2022-09-12 06:32:36'),
(357, 'jail', 86, 64, '120.188.65.82', '120.188.65.82', 'Admin Godzillas (playerid=6, IP=120.188.65.82) offline jails Lana_Coraline for 1 minutes. Reason: bug', '2022-09-12 06:35:43'),
(358, 'accept_report', 43, 247, '114.10.31.133', '114.10.23.206', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) accept report from Jelol Junior (playerid=9, IP=114.10.23.206). Report message: a', '2022-09-12 06:37:14'),
(359, 'answer', 43, 88, '114.10.31.133', '202.80.215.118', 'Admin Toyotomi (playerid=5, IP=114.10.31.133) answer Qenzo Zevallo (playerid=4, IP=202.80.215.118) question. Question: cara mat', '2022-09-12 06:37:58'),
(360, 'accept_report', 136, 105, '114.79.39.233', '114.122.68.242', 'Admin bastian (playerid=4, IP=114.79.39.233) accept report from Kenzo Devalos (playerid=1, IP=114.122.68.242). Report message: ', '2022-09-12 06:49:18'),
(361, 'accept_report', 136, 267, '114.79.39.233', '112.215.235.215', 'Admin bastian (playerid=4, IP=114.79.39.233) accept report from Xiao Yojin (playerid=0, IP=112.215.235.215). Report message: mi', '2022-09-12 06:50:52'),
(362, 'accept_report', 136, 177, '114.79.39.233', '118.96.156.130', 'Admin bastian (playerid=11, IP=114.79.39.233) accept report from Fazly Albiandra (playerid=13, IP=118.96.156.130). Report messa', '2022-09-12 06:55:58'),
(363, 'answer', 136, 177, '114.79.39.233', '118.96.156.130', 'Admin bastian (playerid=11, IP=114.79.39.233) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: min t', '2022-09-12 06:56:36'),
(364, 'jail', 136, 177, '114.79.39.233', '118.96.156.130', 'Admin bastian (playerid=11, IP=114.79.39.233) jails Fazly Albiandra (playerid=13, IP=118.96.156.130) for 1 minutes. Reason: bug', '2022-09-12 06:57:26'),
(365, 'accept_report', 136, 247, '114.79.39.233', '114.10.23.206', 'Admin bastian (playerid=11, IP=114.79.39.233) accept report from Jelol Junior (playerid=9, IP=114.10.23.206). Report message: k', '2022-09-12 06:58:39'),
(366, 'answer', 136, 177, '114.79.39.233', '118.96.156.130', 'Admin bastian (playerid=11, IP=114.79.39.233) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: cara ', '2022-09-12 07:00:26'),
(367, 'answer', 136, 213, '114.79.39.233', '182.2.135.126', 'Admin bastian (playerid=11, IP=114.79.39.233) answer Jerome Smith (playerid=4, IP=182.2.135.126) question. Question: repair eng', '2022-09-12 07:00:39'),
(368, 'answer', 136, 12, '114.79.39.233', '118.99.81.125', 'Admin bastian (playerid=11, IP=114.79.39.233) answer Samuel Ramirez (playerid=1, IP=118.99.81.125) question. Question: min cara', '2022-09-12 07:04:06'),
(369, 'answer', 86, 213, '120.188.65.82', '182.2.135.126', 'Admin Godzillas (playerid=6, IP=120.188.65.82) answer Jerome Smith (playerid=4, IP=182.2.135.126) question. Question: min untu ', '2022-09-12 07:12:44'),
(370, 'answer', 86, 177, '120.188.65.82', '118.96.156.130', 'Admin Godzillas (playerid=6, IP=120.188.65.82) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: cara', '2022-09-12 07:15:14'),
(371, 'answer', 86, 177, '120.188.65.82', '118.96.156.130', 'Admin Godzillas (playerid=6, IP=120.188.65.82) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: blac', '2022-09-12 07:17:12'),
(372, 'answer', 86, 177, '120.188.65.82', '118.96.156.130', 'Admin Godzillas (playerid=6, IP=120.188.65.82) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: temp', '2022-09-12 07:17:56'),
(373, 'answer', 86, 177, '120.188.65.82', '118.96.156.130', 'Admin Godzillas (playerid=6, IP=120.188.65.82) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: perb', '2022-09-12 07:27:02'),
(374, 'answer', 41, 217, '125.166.112.180', '140.213.47.72', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) answer Ramm Mulki (playerid=6, IP=140.213.47.72) question. Question: bang mob', '2022-09-12 07:41:24'),
(375, 'answer', 28, 217, '36.85.6.140', '140.213.47.72', 'Admin Axel (playerid=2, IP=36.85.6.140) answer Ramm Mulki (playerid=6, IP=140.213.47.72) question. Question: jadi gimna bng ? k', '2022-09-12 07:47:22'),
(376, 'accept_report', 28, 12, '36.85.6.140', '118.99.81.125', 'Admin Axel (playerid=2, IP=36.85.6.140) accept report from Samuel Ramirez (playerid=8, IP=118.99.81.125). Report message: min t', '2022-09-12 07:49:11'),
(377, 'accept_report', 28, 54, '36.85.6.140', '103.108.130.115', 'Admin Axel (playerid=2, IP=36.85.6.140) accept report from Rudulf Geraldo (playerid=0, IP=103.108.130.115). Report message: min', '2022-09-12 07:51:16'),
(378, 'accept_report', 28, 18, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Smith Levithan (playerid=5, IP=110.137.37.140). Report message: minn', '2022-09-12 07:56:16'),
(379, 'accept_report', 28, 18, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Smith Levithan (playerid=5, IP=110.137.37.140). Report message: cont', '2022-09-12 07:57:15'),
(380, 'answer', 28, 284, '36.85.3.156', '36.68.222.35', 'Admin Axel (playerid=2, IP=36.85.3.156) answer Diego Aaron (playerid=4, IP=36.68.222.35) question. Question: cmd ambil staterpa', '2022-09-12 07:58:06'),
(381, 'accept_report', 28, 123, '36.85.3.156', '112.215.237.184', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Dejuam Vegeance (playerid=11, IP=112.215.237.184). Report message: T', '2022-09-12 07:59:31'),
(382, 'accept_report', 28, 18, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Smith Levithan (playerid=5, IP=110.137.37.140). Report message: minn', '2022-09-12 08:05:14'),
(383, 'answer', 28, 17, '36.85.3.156', '180.244.160.162', 'Admin Axel (playerid=2, IP=36.85.3.156) answer Rojer Hawkins (playerid=12, IP=180.244.160.162) question. Question: ko kerja tra', '2022-09-12 08:12:04'),
(384, 'accept_report', 41, 17, '125.166.112.180', '180.244.160.162', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Rojer Hawkins (playerid=12, IP=180.244.160.162). Report me', '2022-09-12 08:14:52'),
(385, 'accept_report', 41, 38, '125.166.112.180', '114.79.47.157', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Eduardo Marcell (playerid=14, IP=114.79.47.157). Report me', '2022-09-12 08:15:53'),
(386, 'accept_report', 41, 17, '125.166.112.180', '180.244.160.162', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Rojer Hawkins (playerid=12, IP=180.244.160.162). Report me', '2022-09-12 08:16:10'),
(387, 'accept_report', 41, 17, '125.166.112.180', '180.244.160.162', 'Admin Rukitateki (playerid=1, IP=125.166.112.180) accept report from Rojer Hawkins (playerid=12, IP=180.244.160.162). Report me', '2022-09-12 08:17:30'),
(388, 'deny_report', 86, 40, '120.188.65.82', '140.213.24.133', 'Admin Godzillas (playerid=0, IP=120.188.65.82) deny report from Ranz Summers (playerid=10, IP=140.213.24.133). Report message: ', '2022-09-12 08:21:53'),
(389, 'answer', 41, 187, '125.166.112.180', '111.94.58.42', 'Admin Rukitateki (playerid=6, IP=125.166.112.180) answer Jackson Alexander (playerid=15, IP=111.94.58.42) question. Question: /', '2022-09-12 08:23:36'),
(390, 'answer', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=17, IP=103.108.130.2) answer Grenwole Alexander (playerid=18, IP=116.206.31.39) question. Question: cara ', '2022-09-12 08:33:18'),
(391, 'accept_report', 136, 144, '114.79.39.233', '180.244.160.9', 'Admin bastian (playerid=25, IP=114.79.39.233) accept report from Patrick Benjamin (playerid=22, IP=180.244.160.9). Report messa', '2022-09-12 08:35:21'),
(392, 'answer', 136, 65, '114.79.39.233', '114.10.21.206', 'Admin bastian (playerid=25, IP=114.79.39.233) answer Ken Mang (playerid=7, IP=114.10.21.206) question. Question: min kalo jual ', '2022-09-12 08:35:41'),
(393, 'answer', 28, 192, '36.85.3.156', '180.252.90.229', 'Admin Axel (playerid=2, IP=36.85.3.156) answer Jahmiree Maleek (playerid=9, IP=180.252.90.229) question. Question: ini nanam co', '2022-09-12 08:36:05'),
(394, 'answer', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=17, IP=103.108.130.2) answer Grenwole Alexander (playerid=18, IP=116.206.31.39) question. Question: cara ', '2022-09-12 08:45:10'),
(395, 'ban', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=2, IP=36.85.3.156) offline bans character Robert_Brooklyn. Reason: Teleport Hack', '2022-09-12 08:55:18'),
(396, 'answer', 41, 34, '180.243.4.95', '125.167.56.182', 'Admin Rukitateki (playerid=6, IP=180.243.4.95) answer Amado Daluez (playerid=20, IP=125.167.56.182) question. Question: hauler ', '2022-09-12 08:55:48'),
(397, 'answer', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Jack Eastwood (playerid=7, IP=182.1.78.114) question. Question: min apakah disi', '2022-09-12 09:01:45'),
(398, 'answer', 86, 176, '120.188.65.82', '114.79.47.154', 'Admin Godzillas (playerid=31, IP=120.188.65.82) answer Venustiano Henriquez (playerid=22, IP=114.79.47.154) question. Question:', '2022-09-12 09:02:16'),
(399, 'answer', 86, 176, '120.188.65.82', '114.79.47.154', 'Admin Godzillas (playerid=31, IP=120.188.65.82) answer Venustiano Henriquez (playerid=22, IP=114.79.47.154) question. Question:', '2022-09-12 09:02:26'),
(400, 'answer', 136, 176, '114.79.39.233', '114.79.47.154', 'Admin bastian (playerid=25, IP=114.79.39.233) answer Venustiano Henriquez (playerid=22, IP=114.79.47.154) question. Question: k', '2022-09-12 09:02:38'),
(401, 'accept_report', 136, 34, '114.79.39.233', '125.167.56.182', 'Admin bastian (playerid=25, IP=114.79.39.233) accept report from Amado Daluez (playerid=20, IP=125.167.56.182). Report message:', '2022-09-12 09:03:39'),
(402, 'accept_report', 136, 108, '114.79.39.233', '103.152.232.148', 'Admin bastian (playerid=25, IP=114.79.39.233) accept report from Slei Oconner (playerid=16, IP=103.152.232.148). Report message', '2022-09-12 09:05:51'),
(403, 'answer', 108, 176, '103.108.130.2', '114.79.47.154', 'Admin pandu (playerid=17, IP=103.108.130.2) answer Venustiano Henriquez (playerid=22, IP=114.79.47.154) question. Question: min', '2022-09-12 09:10:19'),
(404, 'accept_report', 136, 84, '114.79.39.233', '36.71.137.94', 'Admin bastian (playerid=25, IP=114.79.39.233) accept report from Budi Alfarizi (playerid=18, IP=36.71.137.94). Report message: ', '2022-09-12 09:15:57'),
(405, 'accept_report', 136, 142, '114.79.39.233', '180.247.4.209', 'Admin bastian (playerid=25, IP=114.79.39.233) accept report from Antonio Ramorez (playerid=3, IP=180.247.4.209). Report message', '2022-09-12 09:20:03'),
(406, 'jail', 136, 247, '114.79.39.233', '114.10.23.206', 'Admin bastian (playerid=25, IP=114.79.39.233) jails Jelol Junior (playerid=13, IP=114.10.23.206) for 30 minutes. Reason: Random', '2022-09-12 09:22:22'),
(407, 'answer', 28, 84, '36.85.3.156', '36.71.137.94', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Budi Alfarizi (playerid=18, IP=36.71.137.94) question. Question: min cara clear', '2022-09-12 09:28:14'),
(408, 'answer', 108, 36, '103.108.130.2', '36.72.160.141', 'Admin pandu (playerid=17, IP=103.108.130.2) answer Jayce Hylton (playerid=4, IP=36.72.160.141) question. Question: cmd kasih gu', '2022-09-12 09:35:13'),
(409, 'ban', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=33, IP=36.85.3.156) offline bans character Josh_Arkwood. Reason: Health Hack', '2022-09-12 09:40:30'),
(410, 'answer', 169, 84, '140.213.193.254', '36.71.137.94', 'Admin Marxist (playerid=27, IP=140.213.193.254) answer Budi Alfarizi (playerid=18, IP=36.71.137.94) question. Question: kok dar', '2022-09-12 09:42:18'),
(411, 'ban', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=33, IP=36.85.3.156) offline bans character Paulov_Xavier. Reason: CHEATER', '2022-09-12 09:42:51'),
(412, 'jail', 108, 40, '103.108.130.2', '112.215.253.183', 'Admin pandu (playerid=17, IP=103.108.130.2) jails Ranz Summers (playerid=22, IP=112.215.253.183) for 1 minutes. Reason: bug', '2022-09-12 09:47:21'),
(413, 'answer', 28, 192, '36.85.3.156', '180.252.90.229', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Jahmiree Maleek (playerid=24, IP=180.252.90.229) question. Question: baru di es', '2022-09-12 09:47:58'),
(414, 'accept_report', 28, 41, '36.85.3.156', '140.213.51.193', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Navaro Guillermo (playerid=8, IP=140.213.51.193). Report message: m', '2022-09-12 09:50:19'),
(415, 'answer', 169, 131, '140.213.193.254', '140.213.193.254', 'Admin Marxist (playerid=27, IP=140.213.193.254) answer Alexander Gregory (playerid=18, IP=103.127.65.47) question. Question: re', '2022-09-12 09:53:34'),
(416, 'answer', 28, 36, '36.85.3.156', '36.72.160.141', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Jayce Hylton (playerid=29, IP=36.72.160.141) question. Question: min clue bm ud', '2022-09-12 09:54:17'),
(417, 'accept_report', 28, 36, '36.85.3.156', '36.72.160.141', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Jayce Hylton (playerid=29, IP=36.72.160.141). Report message: min i', '2022-09-12 09:54:54'),
(418, 'answer', 28, 192, '36.85.3.156', '180.252.90.229', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Jahmiree Maleek (playerid=24, IP=180.252.90.229) question. Question: ini bm int', '2022-09-12 09:59:51'),
(419, 'accept_report', 169, 46, '140.213.193.254', '112.215.175.177', 'Admin Marxist (playerid=27, IP=140.213.193.254) accept report from Aiden Pearce (playerid=26, IP=112.215.175.177). Report messa', '2022-09-12 10:02:53'),
(420, 'accept_report', 28, 84, '36.85.3.156', '36.71.137.94', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Budi Alfarizi (playerid=31, IP=36.71.137.94). Report message: Min d', '2022-09-12 10:04:34'),
(421, 'answer', 28, 85, '36.85.3.156', '125.162.52.18', 'Admin Axel (playerid=33, IP=36.85.3.156) answer Matsushima Kunio (playerid=25, IP=125.162.52.18) question. Question: Min kalau ', '2022-09-12 10:07:17'),
(422, 'accept_report', 28, 126, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Jack Yaguna (playerid=30, IP=110.137.37.140). Report message: min g', '2022-09-12 10:09:21'),
(423, 'accept_report', 28, 177, '36.85.3.156', '118.96.156.130', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Fazly Albiandra (playerid=14, IP=118.96.156.130). Report message: k', '2022-09-12 10:09:33'),
(424, 'accept_report', 28, 299, '36.85.3.156', '112.215.175.249', 'Admin Axel (playerid=33, IP=36.85.3.156) accept report from Kayson Rostalve. (playerid=2, IP=112.215.175.249). Report message: ', '2022-09-12 10:12:39'),
(425, 'ban', 28, 303, '36.85.3.156', '114.10.30.182', 'Admin Axel (playerid=33, IP=36.85.3.156) bans Jahseeh Onfroy (playerid=20, IP=114.10.30.182). Reason: citer', '2022-09-12 10:13:14'),
(426, 'answer', 28, 192, '36.85.6.140', '180.252.90.229', 'Admin Axel (playerid=2, IP=36.85.6.140) answer Jahmiree Maleek (playerid=1, IP=180.252.90.229) question. Question: clue bm dong', '2022-09-12 10:43:57'),
(427, 'answer', 28, 192, '36.85.6.140', '180.252.90.229', 'Admin Axel (playerid=2, IP=36.85.6.140) answer Jahmiree Maleek (playerid=1, IP=180.252.90.229) question. Question: rumahnya cmn', '2022-09-12 10:45:00'),
(428, 'accept_report', 86, 305, '120.188.65.82', '103.127.65.47', 'Admin Godzillas (playerid=3, IP=120.188.65.82) accept report from Alexander Gregory (playerid=5, IP=103.127.65.47). Report mess', '2022-09-12 10:46:12'),
(429, 'accept_report', 86, 165, '120.188.65.82', '115.178.196.25', 'Admin Godzillas (playerid=3, IP=120.188.65.82) accept report from Diego Dioo (playerid=12, IP=115.178.196.25). Report message: ', '2022-09-12 10:51:43'),
(430, 'accept_report', 28, 89, '36.85.3.156', '180.249.165.169', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Kenneth Edward (playerid=4, IP=180.249.165.169). Report message: min', '2022-09-12 10:54:24'),
(431, 'accept_report', 28, 89, '36.85.3.156', '180.249.165.169', 'Admin Axel (playerid=2, IP=36.85.3.156) accept report from Kenneth Edward (playerid=4, IP=180.249.165.169). Report message: tp ', '2022-09-12 10:57:48'),
(432, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=0, IP=103.108.130.2) offline jails Qenzo_Zevallo for 1 minutes. Reason: bug', '2022-09-12 11:10:30'),
(433, 'unban', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=6, IP=180.243.4.95) unbans account nomi.', '2022-09-12 11:49:54'),
(434, 'answer', 136, 177, '114.79.39.233', '118.96.156.130', 'Admin bastian (playerid=9, IP=114.79.39.233) answer Fazly Albiandra (playerid=8, IP=118.96.156.130) question. Question: cara ob', '2022-09-12 11:55:49'),
(435, 'accept_report', 136, 88, '114.79.39.233', '202.80.215.118', 'Admin bastian (playerid=9, IP=114.79.39.233) accept report from Qenzo Zevallo (playerid=0, IP=202.80.215.118). Report message: ', '2022-09-12 11:55:57'),
(436, 'accept_report', 136, 297, '114.79.39.233', '116.206.14.57', 'Admin bastian (playerid=9, IP=114.79.39.233) accept report from Louis Maxximilliano (playerid=12, IP=116.206.14.57). Report mes', '2022-09-12 11:56:45'),
(437, 'answer', 136, 192, '114.79.39.233', '180.252.90.229', 'Admin bastian (playerid=9, IP=114.79.39.233) answer Jahmiree Maleek (playerid=4, IP=180.252.90.229) question. Question: min clu', '2022-09-12 12:01:54'),
(438, 'accept_report', 136, 9, '114.79.39.233', '140.213.44.40', 'Admin bastian (playerid=9, IP=114.79.39.233) accept report from Smith Martin (playerid=3, IP=140.213.44.40). Report message: Mi', '2022-09-12 12:02:30'),
(439, 'accept_report', 28, 173, '36.85.3.156', '125.166.13.103', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Hilmy Fauzan (playerid=1, IP=125.166.13.103). Report message: id 2 ', '2022-09-12 12:26:42'),
(440, 'accept_report', 28, 192, '36.85.3.156', '180.252.90.229', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Jahmiree Maleek (playerid=4, IP=180.252.90.229). Report message: ga', '2022-09-12 12:26:45'),
(441, 'answer', 136, 217, '114.79.39.233', '140.213.39.62', 'Admin bastian (playerid=23, IP=114.79.39.233) answer Ramm Mulki (playerid=4, IP=140.213.39.62) question. Question: tetep ga bis', '2022-09-12 12:32:03'),
(442, 'answer', 28, 305, '36.85.3.156', '103.127.65.47', 'Admin Axel (playerid=12, IP=36.85.3.156) answer Alexander Gregory (playerid=6, IP=103.127.65.47) question. Question: min bisa r', '2022-09-12 12:32:29'),
(443, 'answer', 136, 305, '114.79.39.233', '103.127.65.47', 'Admin bastian (playerid=23, IP=114.79.39.233) answer Alexander Gregory (playerid=6, IP=103.127.65.47) question. Question: ada r', '2022-09-12 12:32:48'),
(444, 'jail', 136, 194, '114.79.39.233', '140.213.67.3', 'Admin bastian (playerid=23, IP=114.79.39.233) jails Fajri Maulana (playerid=27, IP=140.213.67.3) for 1 minutes. Reason: bug', '2022-09-12 12:38:00'),
(445, 'jail', 136, 101, '114.79.39.233', '114.79.39.233', 'Admin bastian (playerid=23, IP=114.79.39.233) jails bastian (playerid=23, IP=114.79.39.233) for 1 minutes. Reason: bug', '2022-09-12 12:41:00'),
(446, 'answer', 28, 305, '36.85.3.156', '103.127.65.47', 'Admin Axel (playerid=12, IP=36.85.3.156) answer Alexander Gregory (playerid=6, IP=103.127.65.47) question. Question: kok ga bis', '2022-09-12 12:41:16'),
(447, 'accept_report', 136, 106, '114.79.39.233', '180.251.155.72', 'Admin bastian (playerid=13, IP=114.79.39.233) accept report from Rollins Maleek (playerid=26, IP=180.251.155.72). Report messag', '2022-09-12 12:55:59'),
(448, 'accept_report', 28, 18, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Smith Levithan (playerid=30, IP=110.137.37.140). Report message: mi', '2022-09-12 13:04:03'),
(449, 'jail', 43, 224, '114.4.212.160', '114.4.212.160', 'Admin Toyotomi (playerid=26, IP=114.4.212.160) offline jails Tokugawa for 1 minutes. Reason: bug ', '2022-09-12 13:05:53'),
(450, 'jail', 43, 224, '114.4.212.160', '114.4.212.160', 'Admin Toyotomi (playerid=26, IP=114.4.212.160) offline jails Tokugawa for 1 minutes. Reason: bug', '2022-09-12 13:05:56'),
(451, 'jail', 43, 224, '114.4.212.160', '114.4.212.160', 'Admin Toyotomi (playerid=26, IP=114.4.212.160) offline jails Toku for 1 minutes. Reason: 1', '2022-09-12 13:06:04'),
(452, 'accept_report', 28, 126, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Jack Yaguna (playerid=20, IP=110.137.37.140). Report message: proof', '2022-09-12 13:06:17'),
(453, 'jail', 43, 224, '114.4.212.160', '114.4.212.160', 'Admin Toyotomi (playerid=26, IP=114.4.212.160) offline jails Toku for 1 minutes. Reason: bug', '2022-09-12 13:06:22'),
(454, 'accept_report', 28, 126, '36.85.3.156', '110.137.37.140', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Jack Yaguna (playerid=20, IP=110.137.37.140). Report message: bukan', '2022-09-12 13:06:46'),
(455, 'answer', 28, 305, '36.85.3.156', '103.127.65.47', 'Admin Axel (playerid=12, IP=36.85.3.156) answer Alexander Gregory (playerid=6, IP=103.127.65.47) question. Question: cmd invite', '2022-09-12 13:08:53'),
(456, 'accept_report', 28, 84, '36.85.3.156', '36.71.137.94', 'Admin Axel (playerid=12, IP=36.85.3.156) accept report from Budi Alfarizi (playerid=16, IP=36.71.137.94). Report message: admin', '2022-09-12 13:12:52'),
(457, 'answer', 19, 177, '114.122.100.86', '118.96.156.130', 'Admin Elbier (playerid=27, IP=114.122.100.86) answer Fazly Albiandra (playerid=30, IP=118.96.156.130) question. Question: bang ', '2022-09-12 13:13:32'),
(458, 'answer', 19, 213, '114.122.100.86', '182.2.135.126', 'Admin Elbier (playerid=27, IP=114.122.100.86) answer Jerome Smith (playerid=13, IP=182.2.135.126) question. Question: binco blm', '2022-09-12 13:13:38'),
(459, 'answer', 19, 177, '114.122.100.86', '118.96.156.130', 'Admin Elbier (playerid=27, IP=114.122.100.86) answer Fazly Albiandra (playerid=30, IP=118.96.156.130) question. Question: desa ', '2022-09-12 13:14:15'),
(460, 'accept_report', 136, 85, '114.79.39.233', '125.162.52.18', 'Admin bastian (playerid=13, IP=114.79.39.233) accept report from Matsushima Kunio (playerid=10, IP=125.162.52.18). Report messa', '2022-09-12 13:29:41'),
(461, 'accept_report', 28, 239, '36.85.6.140', '180.214.233.19', 'Admin Axel (playerid=5, IP=36.85.6.140) accept report from Shin Fushima (playerid=12, IP=180.214.233.19). Report message: min k', '2022-09-12 13:31:08'),
(462, 'accept_report', 28, 126, '36.85.6.140', '110.137.37.140', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Jack Yaguna (playerid=2, IP=110.137.37.140). Report message: Tulung ', '2022-09-12 14:06:12'),
(463, 'accept_report', 28, 165, '36.85.6.140', '115.178.192.218', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Diego Dioo (playerid=0, IP=115.178.192.218). Report message: min ora', '2022-09-12 14:06:14'),
(464, 'accept_report', 28, 116, '36.85.6.140', '202.67.42.34', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Hazel Leone (playerid=4, IP=202.67.42.34). Report message: min bug v', '2022-09-12 14:06:38'),
(465, 'accept_report', 28, 8, '36.85.6.140', '125.166.182.202', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Xavier Luciano (playerid=9, IP=125.166.182.202). Report message: min', '2022-09-12 14:06:55'),
(466, 'jail', 28, 8, '36.85.6.140', '125.166.182.202', 'Admin Axel (playerid=7, IP=36.85.6.140) jails Xavier Luciano (playerid=9, IP=125.166.182.202) for 1 minutes. Reason: bug', '2022-09-12 14:07:04'),
(467, 'accept_report', 28, 239, '36.85.6.140', '180.214.232.69', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Shin Fushima (playerid=11, IP=180.214.232.69). Report message: min k', '2022-09-12 14:07:13'),
(468, 'accept_report', 28, 165, '36.85.6.140', '115.178.192.218', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Diego Dioo (playerid=16, IP=115.178.192.218). Report message: masih ', '2022-09-12 14:09:24'),
(469, 'accept_report', 28, 8, '36.85.6.140', '125.166.182.202', 'Admin Axel (playerid=7, IP=36.85.6.140) accept report from Xavier Luciano (playerid=9, IP=125.166.182.202). Report message: bel', '2022-09-12 14:09:51'),
(470, 'jail', 28, 165, '36.85.6.140', '115.178.192.218', 'Admin Axel (playerid=7, IP=36.85.6.140) jails Diego Dioo (playerid=16, IP=115.178.192.218) for 1 minutes. Reason: bug', '2022-09-12 14:13:20');
INSERT INTO `admin_activities` (`id`, `type`, `issuer`, `receiver`, `issuer_ip_address`, `receiver_ip_address`, `description`, `created_at`) VALUES
(471, 'accept_report', 136, 60, '114.79.39.233', '114.10.30.208', 'Admin bastian (playerid=27, IP=114.79.39.233) accept report from Daniell Wade (playerid=23, IP=114.10.30.208). Report message: ', '2022-09-12 14:17:29'),
(472, 'answer', 136, 165, '114.79.39.233', '115.178.192.218', 'Admin bastian (playerid=27, IP=114.79.39.233) answer Diego Dioo (playerid=16, IP=115.178.192.218) question. Question: min kenap', '2022-09-12 14:18:54'),
(473, 'deny_report', 86, 239, '120.188.65.82', '180.214.232.69', 'Admin Godzillas (playerid=14, IP=120.188.65.82) deny report from Shin Fushima (playerid=11, IP=180.214.232.69). Report message:', '2022-09-12 14:23:55'),
(474, 'answer', 136, 65, '114.79.39.233', '114.10.17.184', 'Admin bastian (playerid=27, IP=114.79.39.233) answer Ken Mang (playerid=5, IP=114.10.17.184) question. Question: min kenapa yah', '2022-09-12 14:25:36'),
(475, 'answer', 136, 65, '114.79.39.233', '114.10.17.184', 'Admin bastian (playerid=27, IP=114.79.39.233) answer Ken Mang (playerid=5, IP=114.10.17.184) question. Question: android | Answ', '2022-09-12 14:25:58'),
(476, 'answer', 136, 213, '114.79.39.233', '182.2.135.126', 'Admin bastian (playerid=1, IP=114.79.39.233) answer Jerome Smith (playerid=0, IP=182.2.135.126) question. Question: mantra buka', '2022-09-12 15:01:03'),
(477, 'answer', 136, 213, '114.79.39.233', '182.2.135.126', 'Admin bastian (playerid=1, IP=114.79.39.233) answer Jerome Smith (playerid=0, IP=182.2.135.126) question. Question: tp ke gue m', '2022-09-12 15:03:47'),
(478, 'accept_report', 136, 312, '114.79.39.233', '180.241.240.22', 'Admin bastian (playerid=1, IP=114.79.39.233) accept report from Justina Xie (playerid=16, IP=180.241.240.22). Report message: b', '2022-09-12 15:03:49'),
(479, 'accept_report', 86, 312, '120.188.65.82', '180.241.240.22', 'Admin Godzillas (playerid=11, IP=120.188.65.82) accept stuck request from Justina Xie (playerid=16, IP=180.241.240.22).', '2022-09-12 15:04:16'),
(480, 'accept_report', 136, 116, '114.79.39.233', '202.67.42.34', 'Admin bastian (playerid=1, IP=114.79.39.233) accept report from Hazel Leone (playerid=13, IP=202.67.42.34). Report message: min', '2022-09-12 15:05:32'),
(481, 'answer', 136, 12, '114.79.39.233', '118.99.81.112', 'Admin bastian (playerid=1, IP=114.79.39.233) answer Samuel Ramirez (playerid=3, IP=118.99.81.112) question. Question: min bm di', '2022-09-12 15:06:14'),
(482, 'jail', 136, 12, '114.79.39.233', '118.99.81.112', 'Admin bastian (playerid=1, IP=114.79.39.233) jails Samuel Ramirez (playerid=3, IP=118.99.81.112) for 5 minutes. Reason: mixxing', '2022-09-12 15:09:25'),
(483, 'accept_report', 370, 312, '112.215.235.118', '112.215.235.118', 'Admin MyKeengs (playerid=19, IP=112.215.235.118) accept report from Mahes Putra (playerid=20, IP=140.213.197.40). Report messag', '2022-09-12 15:21:27'),
(484, 'accept_report', 370, 312, '112.215.235.118', '112.215.235.118', 'Admin MyKeengs (playerid=19, IP=112.215.235.118) accept report from Juan Stance (playerid=23, IP=140.213.43.202). Report messag', '2022-09-12 15:21:32'),
(485, 'accept_report', 136, 5, '114.79.39.233', '103.108.130.116', 'Admin bastian (playerid=15, IP=114.79.39.233) accept report from Frankie Charles (playerid=22, IP=103.108.130.116). Report mess', '2022-09-12 15:38:30'),
(486, 'accept_report', 86, 142, '120.188.65.82', '180.247.4.209', 'Admin Godzillas (playerid=6, IP=120.188.65.82) accept stuck request from Antonio Ramorez (playerid=26, IP=180.247.4.209).', '2022-09-12 15:39:39'),
(487, 'accept_report', 136, 142, '114.79.39.233', '180.247.4.209', 'Admin bastian (playerid=15, IP=114.79.39.233) accept report from Antonio Ramorez (playerid=26, IP=180.247.4.209). Report messag', '2022-09-12 15:40:08'),
(488, 'jail', 136, 142, '114.79.39.233', '180.247.4.209', 'Admin bastian (playerid=15, IP=114.79.39.233) jails Antonio Ramorez (playerid=26, IP=180.247.4.209) for 1 minutes. Reason: bug', '2022-09-12 15:40:19'),
(489, 'answer', 136, 213, '114.79.39.233', '182.2.135.126', 'Admin bastian (playerid=15, IP=114.79.39.233) answer Jerome Smith (playerid=1, IP=182.2.135.126) question. Question: ini mobil ', '2022-09-12 15:51:56'),
(490, 'accept_report', 370, 30, '112.215.235.118', '114.5.242.177', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) accept report from Owen Knight (playerid=27, IP=114.5.242.177). Report message:', '2022-09-12 15:57:52'),
(491, 'accept_report', 370, 19, '112.215.235.118', '114.124.209.147', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) accept report from Gun Walters (playerid=25, IP=114.124.209.147). Report messag', '2022-09-12 15:58:24'),
(492, 'accept_report', 370, 316, '112.215.235.118', '140.213.58.82', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) accept report from Leo Smith (playerid=2, IP=140.213.58.82). Report message: mi', '2022-09-12 16:01:59'),
(493, 'accept_report', 370, 316, '112.215.235.118', '140.213.58.82', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) accept report from Leo Smith (playerid=12, IP=140.213.58.82). Report message: m', '2022-09-12 16:03:33'),
(494, 'answer', 370, 316, '112.215.235.118', '140.213.58.82', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) answer Leo Smith (playerid=12, IP=140.213.58.82) question. Question: min gw mau', '2022-09-12 16:05:50'),
(495, 'answer', 370, 40, '112.215.235.118', '140.213.39.122', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) answer Ranz Summers (playerid=0, IP=140.213.39.122) question. Question: kapan b', '2022-09-12 16:09:00'),
(496, 'answer', 370, 40, '112.215.235.118', '140.213.39.122', 'Admin MyKeengs (playerid=4, IP=112.215.235.118) answer Ranz Summers (playerid=0, IP=140.213.39.122) question. Question: senjata', '2022-09-12 16:09:58'),
(497, 'answer', 136, 40, '114.79.39.233', '140.213.39.122', 'Admin bastian (playerid=15, IP=114.79.39.233) answer Ranz Summers (playerid=0, IP=140.213.39.122) question. Question: gimana ba', '2022-09-12 16:15:52'),
(498, 'accept_report', 136, 267, '114.79.39.233', '112.215.170.134', 'Admin bastian (playerid=15, IP=114.79.39.233) accept report from Xiao Yojin (playerid=10, IP=112.215.170.134). Report message: ', '2022-09-12 16:20:33'),
(499, 'answer', 136, 30, '114.79.39.233', '114.5.242.177', 'Admin bastian (playerid=15, IP=114.79.39.233) answer Owen Knight (playerid=27, IP=114.5.242.177) question. Question: min reff r', '2022-09-12 16:22:25'),
(500, 'answer', 136, 30, '114.79.39.233', '114.5.242.177', 'Admin bastian (playerid=15, IP=114.79.39.233) answer Owen Knight (playerid=27, IP=114.5.242.177) question. Question: ada | Answ', '2022-09-12 16:22:43'),
(501, 'answer', 136, 30, '114.79.39.233', '114.5.242.177', 'Admin bastian (playerid=15, IP=114.79.39.233) answer Owen Knight (playerid=27, IP=114.5.242.177) question. Question: cek di ss ', '2022-09-12 16:23:06'),
(502, 'answer', 43, 30, '120.188.37.209', '114.5.242.177', 'Admin Toyotomi (playerid=11, IP=120.188.37.209) answer Owen Knight (playerid=27, IP=114.5.242.177) question. Question: gimana? ', '2022-09-12 16:24:25'),
(503, 'accept_report', 169, 30, '140.213.193.254', '114.5.242.177', 'Admin Marxist (playerid=7, IP=140.213.193.254) accept report from Owen Knight (playerid=22, IP=114.5.242.177). Report message: ', '2022-09-12 16:53:46'),
(504, 'answer', 169, 40, '140.213.193.254', '140.213.39.122', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Ranz Summers (playerid=0, IP=140.213.39.122) question. Question: tempat j', '2022-09-12 16:54:59'),
(505, 'accept_report', 169, 30, '140.213.193.254', '114.5.242.177', 'Admin Marxist (playerid=7, IP=140.213.193.254) accept report from Owen Knight (playerid=22, IP=114.5.242.177). Report message: ', '2022-09-12 16:56:14'),
(506, 'answer', 169, 40, '140.213.193.254', '140.213.39.122', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Ranz Summers (playerid=0, IP=140.213.39.122) question. Question: gk ada s', '2022-09-12 16:58:54'),
(507, 'deny_report', 86, 54, '120.188.65.82', '103.108.130.115', 'Admin Godzillas (playerid=20, IP=120.188.65.82) deny report from Rudulf Geraldo (playerid=24, IP=103.108.130.115). Report messa', '2022-09-12 16:59:58'),
(508, 'deny_report', 86, 54, '120.188.65.82', '103.108.130.115', 'Admin Godzillas (playerid=20, IP=120.188.65.82) deny report from Rudulf Geraldo (playerid=24, IP=103.108.130.115). Report messa', '2022-09-12 17:00:35'),
(509, 'deny_report', 86, 54, '120.188.65.82', '103.108.130.115', 'Admin Godzillas (playerid=20, IP=120.188.65.82) deny report from Rudulf Geraldo (playerid=24, IP=103.108.130.115). Report messa', '2022-09-12 17:02:18'),
(510, 'answer', 169, 319, '140.213.193.254', '140.213.230.136', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Callaverro Santacruz (playerid=18, IP=140.213.230.136) question. Question', '2022-09-12 17:05:08'),
(511, 'answer', 169, 319, '140.213.193.254', '140.213.230.136', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Callaverro Santacruz (playerid=18, IP=140.213.230.136) question. Question', '2022-09-12 17:06:19'),
(512, 'answer', 169, 31, '140.213.193.254', '103.143.63.25', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Popix Vicente (playerid=4, IP=103.143.63.25) question. Question: bg gw bu', '2022-09-12 17:06:36'),
(513, 'answer', 169, 319, '140.213.193.254', '140.213.230.136', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Callaverro Santacruz (playerid=18, IP=140.213.230.136) question. Question', '2022-09-12 17:06:46'),
(514, 'answer', 169, 319, '140.213.193.254', '140.213.230.136', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Callaverro Santacruz (playerid=18, IP=140.213.230.136) question. Question', '2022-09-12 17:07:23'),
(515, 'answer', 169, 31, '140.213.193.254', '103.143.63.25', 'Admin Marxist (playerid=7, IP=140.213.193.254) answer Popix Vicente (playerid=4, IP=103.143.63.25) question. Question: maksud n', '2022-09-12 17:07:54'),
(516, 'accept_report', 86, 31, '120.188.65.82', '103.143.63.25', 'Admin Godzillas (playerid=20, IP=120.188.65.82) accept report from Popix Vicente (playerid=15, IP=103.143.63.25). Report messag', '2022-09-12 17:14:38'),
(517, 'accept_report', 169, 319, '140.213.192.28', '140.213.230.136', 'Admin Marxist (playerid=4, IP=140.213.192.28) accept report from Callaverro Santacruz (playerid=17, IP=140.213.230.136). Report', '2022-09-12 17:16:10'),
(518, 'accept_report', 169, 319, '140.213.192.28', '140.213.230.136', 'Admin marxist (playerid=19, IP=140.213.192.28) accept report from Callaverro Santacruz (playerid=17, IP=140.213.230.136). Repor', '2022-09-12 17:26:55'),
(519, 'answer', 169, 319, '140.213.192.28', '140.213.230.136', 'Admin marxist (playerid=19, IP=140.213.192.28) answer Callaverro Santacruz (playerid=17, IP=140.213.230.136) question. Question', '2022-09-12 17:28:11'),
(520, 'answer', 169, 319, '140.213.192.28', '140.213.230.136', 'Admin marxist (playerid=19, IP=140.213.192.28) answer Callaverro Santacruz (playerid=17, IP=140.213.230.136) question. Question', '2022-09-12 17:28:50'),
(521, 'answer', 169, 8, '140.213.192.28', '125.166.182.202', 'Admin marxist (playerid=19, IP=140.213.192.28) answer Xavier Luciano (playerid=15, IP=125.166.182.202) question. Question: cmd ', '2022-09-12 17:33:21'),
(522, 'deny_report', 86, 8, '120.188.65.82', '125.166.182.202', 'Admin Godzillas (playerid=20, IP=120.188.65.82) deny report from Xavier Luciano (playerid=15, IP=125.166.182.202). Report messa', '2022-09-12 17:36:16'),
(523, 'accept_report', 86, 31, '120.188.65.82', '103.143.63.25', 'Admin Godzillas (playerid=20, IP=120.188.65.82) accept report from Popix Vicente (playerid=0, IP=103.143.63.25). Report message', '2022-09-12 18:10:34'),
(524, 'accept_report', 28, 5, '36.85.6.140', '103.108.130.116', 'Admin Axel (playerid=9, IP=36.85.6.140) accept report from Frankie Charles (playerid=1, IP=103.108.130.116). Report message: cj', '2022-09-12 18:49:14'),
(525, 'accept_report', 155, 267, '182.2.72.124', '112.215.170.134', 'Admin TerCooL (playerid=3, IP=182.2.72.124) accept report from Xiao Yojin (playerid=2, IP=112.215.170.134). Report message: min', '2022-09-12 18:58:40'),
(526, 'jail', 155, 267, '182.2.72.124', '112.215.170.134', 'Admin TerCooL (playerid=3, IP=182.2.72.124) jails Xiao Yojin (playerid=2, IP=112.215.170.134) for 1 minutes. Reason: Bug', '2022-09-12 18:58:44'),
(527, 'accept_report', 155, 239, '182.2.72.124', '180.214.232.15', 'Admin TerCooL (playerid=3, IP=182.2.72.124) accept report from Shin Fushima (playerid=14, IP=180.214.232.15). Report message: m', '2022-09-12 19:05:30'),
(528, 'accept_report', 155, 267, '182.2.72.124', '112.215.170.134', 'Admin TerCooL (playerid=3, IP=182.2.72.124) accept report from Xiao Yojin (playerid=2, IP=112.215.170.134). Report message: min', '2022-09-12 19:13:49'),
(529, 'accept_report', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=0, IP=36.85.3.156) accept report from Rico Jerico (playerid=3, IP=115.178.197.87). Report message: mau ref', '2022-09-13 01:16:27'),
(530, 'accept_report', 28, 16, '36.85.3.156', '36.85.3.156', 'Admin Axel (playerid=0, IP=36.85.3.156) accept report from Rico Jerico (playerid=3, IP=115.178.197.87). Report message: uang 20', '2022-09-13 01:17:20'),
(531, 'accept_report', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) accept report from Rollins Maleek (playerid=5, IP=180.251.150.234). Report message: ban', '2022-09-13 01:31:49'),
(532, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: job gaji bes', '2022-09-13 01:35:04'),
(533, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: selain itu a', '2022-09-13 01:35:26'),
(534, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: cara nanem m', '2022-09-13 01:35:53'),
(535, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: nanem marjun', '2022-09-13 01:36:15'),
(536, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: beli tanaman', '2022-09-13 01:36:36'),
(537, 'answer', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) answer Rollins Maleek (playerid=5, IP=180.251.150.234) question. Question: ada clue ga ', '2022-09-13 01:36:50'),
(538, 'accept_report', 28, 106, '36.85.3.156', '180.251.150.234', 'Admin Axel (playerid=6, IP=36.85.3.156) accept report from Rollins Maleek (playerid=5, IP=180.251.150.234). Report message: ban', '2022-09-13 01:40:15'),
(539, 'answer', 108, 77, '180.214.232.11', '180.214.232.11', 'Admin pandu (playerid=2, IP=180.214.232.11) answer Rico Jerico (playerid=3, IP=115.178.197.87) question. Question: garasi kota ', '2022-09-13 01:53:41'),
(540, 'answer', 108, 106, '180.214.232.11', '180.251.150.234', 'Admin pandu (playerid=2, IP=180.214.232.11) answer Rollins Maleek (playerid=8, IP=180.251.150.234) question. Question: tempat n', '2022-09-13 01:54:44'),
(541, 'answer', 28, 16, '36.85.6.140', '36.85.6.140', 'Admin Axel (playerid=1, IP=36.85.6.140) answer Gaviro Muerto (playerid=7, IP=180.241.45.103) question. Question: min apakah bis', '2022-09-13 01:54:56'),
(542, 'answer', 77, 217, '182.2.74.114', '112.215.208.160', 'Admin Kepin (playerid=5, IP=182.2.74.114) answer Ramm Mulki (playerid=4, IP=112.215.208.160) question. Question: bng kerja apa ', '2022-09-13 02:52:28'),
(543, 'accept_report', 136, 29, '114.79.37.225', '116.206.14.42', 'Admin bastian (playerid=2, IP=114.79.37.225) accept report from Xaviano Leyva (playerid=3, IP=116.206.14.42). Report message: m', '2022-09-13 03:25:35'),
(544, 'accept_report', 86, 142, '120.188.65.82', '180.247.7.168', 'Admin Godzillas (playerid=8, IP=120.188.65.82) accept stuck request from Antonio Ramorez (playerid=0, IP=180.247.7.168).', '2022-09-13 05:18:58'),
(545, 'answer', 41, 135, '180.243.4.95', '114.122.69.236', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) answer Alex Tuna (playerid=2, IP=114.122.69.236) question. Question: cara minum', '2022-09-13 06:07:23'),
(546, 'accept_report', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Veto Vercetti (playerid=3, IP=180.243.4.95). Report message:', '2022-09-13 06:08:32'),
(547, 'answer', 41, 105, '180.243.4.95', '103.139.10.148', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) answer Kenzo Devalos (playerid=12, IP=103.139.10.148) question. Question: ini t', '2022-09-13 06:24:19'),
(548, 'answer', 41, 188, '180.243.4.95', '180.243.32.107', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) answer Marrino Luccano (playerid=3, IP=180.243.32.107) question. Question: min ', '2022-09-13 06:38:11'),
(549, 'accept_report', 86, 9, '114.4.83.8', '36.68.216.16', 'Admin Godzillas (playerid=5, IP=114.4.83.8) accept report from Smith Martin (playerid=15, IP=36.68.216.16). Report message: Tol', '2022-09-13 07:05:47'),
(550, 'accept_report', 169, 6, '182.1.167.33', '125.164.17.213', 'Admin marxist (playerid=10, IP=182.1.167.33) accept report from Edward Francisco (playerid=4, IP=125.164.17.213). Report messag', '2022-09-13 07:08:33'),
(551, 'answer', 169, 88, '182.1.167.33', '202.80.215.118', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Qenzo Zevallo (playerid=9, IP=202.80.215.118) question. Question: kasih clu', '2022-09-13 07:12:28'),
(552, 'answer', 86, 159, '114.4.83.8', '125.162.208.78', 'Admin Godzillas (playerid=5, IP=114.4.83.8) answer Olmero Estevanez (playerid=8, IP=125.162.208.78) question. Question: apakah ', '2022-09-13 07:13:15'),
(553, 'answer', 169, 269, '182.1.167.33', '125.164.148.32', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Minami Chibiko (playerid=21, IP=125.164.148.32) question. Question: Apakah ', '2022-09-13 07:14:48'),
(554, 'accept_report', 86, 269, '114.4.83.8', '125.164.148.32', 'Admin Godzillas (playerid=5, IP=114.4.83.8) accept report from Minami Chibiko (playerid=21, IP=125.164.148.32). Report message:', '2022-09-13 07:15:05'),
(555, 'accept_report', 169, 105, '182.1.167.33', '103.139.10.148', 'Admin marxist (playerid=10, IP=182.1.167.33) accept report from Kenzo Devalos (playerid=12, IP=103.139.10.148). Report message:', '2022-09-13 07:18:03'),
(556, 'answer', 169, 177, '182.1.167.33', '118.96.156.130', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: cara k', '2022-09-13 07:18:18'),
(557, 'answer', 43, 177, '120.188.7.208', '118.96.156.130', 'Admin Toyotomi (playerid=2, IP=120.188.7.208) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: websi', '2022-09-13 07:18:44'),
(558, 'answer', 169, 177, '182.1.167.33', '118.96.156.130', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: lic tr', '2022-09-13 07:24:54'),
(559, 'answer', 169, 177, '182.1.167.33', '118.96.156.130', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: bikin ', '2022-09-13 07:25:30'),
(560, 'answer', 169, 177, '182.1.167.33', '118.96.156.130', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: bikin ', '2022-09-13 07:28:47'),
(561, 'accept_report', 169, 267, '182.1.167.33', '112.215.170.134', 'Admin marxist (playerid=10, IP=182.1.167.33) accept report from Xiao Yojin (playerid=22, IP=112.215.170.134). Report message: m', '2022-09-13 07:29:47'),
(562, 'accept_report', 41, 6, '180.243.4.95', '125.164.22.15', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Edward Francisco (playerid=25, IP=125.164.22.15). Report mes', '2022-09-13 07:32:03'),
(563, 'answer', 169, 177, '182.1.167.33', '118.96.156.130', 'Admin marxist (playerid=10, IP=182.1.167.33) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: kerja ', '2022-09-13 07:37:36'),
(564, 'accept_report', 41, 5, '180.243.4.95', '103.108.130.116', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Frankie Charles (playerid=23, IP=103.108.130.116). Report me', '2022-09-13 07:39:45'),
(565, 'answer', 86, 123, '114.4.83.8', '140.213.219.190', 'Admin Godzillas (playerid=5, IP=114.4.83.8) answer Dejuam Vegeance (playerid=4, IP=140.213.219.190) question. Question: Tec9 bo', '2022-09-13 07:40:29'),
(566, 'answer', 41, 88, '180.243.4.95', '202.80.215.118', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) answer Qenzo Zevallo (playerid=9, IP=202.80.215.118) question. Question: apa cm', '2022-09-13 07:48:52'),
(567, 'answer', 136, 123, '114.79.37.24', '140.213.219.190', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Dejuam Vegeance (playerid=4, IP=140.213.219.190) question. Question: Rob pa', '2022-09-13 07:49:04'),
(568, 'answer', 86, 88, '114.4.83.8', '202.80.215.118', 'Admin Godzillas (playerid=5, IP=114.4.83.8) answer Qenzo Zevallo (playerid=9, IP=202.80.215.118) question. Question: bagaimana ', '2022-09-13 07:49:18'),
(569, 'answer', 136, 60, '114.79.37.24', '120.188.7.20', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Daniell Wade (playerid=11, IP=120.188.7.20) question. Question: min minim p', '2022-09-13 07:49:38'),
(570, 'accept_report', 136, 108, '114.79.37.24', '103.152.232.148', 'Admin bastian (playerid=15, IP=114.79.37.24) accept report from Slei Oconner (playerid=12, IP=103.152.232.148). Report message:', '2022-09-13 07:49:56'),
(571, 'answer', 136, 177, '114.79.37.24', '118.96.156.130', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: cara t', '2022-09-13 07:53:15'),
(572, 'answer', 136, 177, '114.79.37.24', '118.96.156.130', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: maksud', '2022-09-13 07:54:16'),
(573, 'answer', 136, 177, '114.79.37.24', '118.96.156.130', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Fazly Albiandra (playerid=19, IP=118.96.156.130) question. Question: cara t', '2022-09-13 07:54:48'),
(574, 'answer', 43, 88, '120.188.7.208', '202.80.215.118', 'Admin Toyotomi (playerid=20, IP=120.188.7.208) answer Qenzo Zevallo (playerid=9, IP=202.80.215.118) question. Question: apa itu', '2022-09-13 07:59:28'),
(575, 'accept_report', 136, 12, '114.79.37.24', '118.99.81.112', 'Admin bastian (playerid=15, IP=114.79.37.24) accept report from Samuel Ramirez (playerid=0, IP=118.99.81.112). Report message: ', '2022-09-13 08:07:36'),
(576, 'jail', 136, 12, '114.79.37.24', '118.99.81.112', 'Admin bastian (playerid=15, IP=114.79.37.24) jails Samuel Ramirez (playerid=0, IP=118.99.81.112) for 1 minutes. Reason: bug', '2022-09-13 08:07:59'),
(577, 'answer', 108, 309, '103.108.130.2', '125.167.58.83', 'Admin pandu (playerid=11, IP=103.108.130.2) answer Axton William (playerid=8, IP=125.167.58.83) question. Question: min ada cmd', '2022-09-13 08:10:08'),
(578, 'accept_report', 136, 173, '114.79.37.24', '125.166.13.103', 'Admin bastian (playerid=15, IP=114.79.37.24) accept report from Hilmy Fauzan (playerid=3, IP=125.166.13.103). Report message: B', '2022-09-13 08:11:57'),
(579, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=11, IP=103.108.130.2) offline jails Hilmy_Fauzan for 1 minutes. Reason: bug', '2022-09-13 08:12:25'),
(580, 'answer', 136, 173, '114.79.37.24', '125.166.13.103', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Hilmy Fauzan (playerid=10, IP=125.166.13.103) question. Question: Nice | An', '2022-09-13 08:13:03'),
(581, 'accept_report', 136, 10, '114.79.37.24', '202.67.40.225', 'Admin bastian (playerid=15, IP=114.79.37.24) accept report from Epanzo Xenzyone (playerid=19, IP=202.67.40.225). Report message', '2022-09-13 08:16:00'),
(582, 'accept_report', 41, 10, '180.243.4.95', '202.67.40.225', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Epanzo Xenzyone (playerid=19, IP=202.67.40.225). Report mess', '2022-09-13 08:17:20'),
(583, 'answer', 136, 165, '114.79.37.24', '115.178.192.244', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Diego Dioo (playerid=21, IP=115.178.192.244) question. Question: min reff k', '2022-09-13 08:19:04'),
(584, 'answer', 136, 165, '114.79.37.24', '115.178.192.244', 'Admin bastian (playerid=15, IP=114.79.37.24) answer Diego Dioo (playerid=21, IP=115.178.192.244) question. Question: ada | Answ', '2022-09-13 08:19:27'),
(585, 'accept_report', 43, 172, '120.188.7.208', '182.1.101.204', 'Admin Toyotomi (playerid=20, IP=120.188.7.208) accept report from Reamy Xhyner (playerid=2, IP=182.1.101.204). Report message: ', '2022-09-13 08:27:57'),
(586, 'accept_report', 43, 172, '120.188.7.208', '182.1.101.204', 'Admin Toyotomi (playerid=20, IP=120.188.7.208) accept report from Reamy Xhyner (playerid=2, IP=182.1.101.204). Report message: ', '2022-09-13 08:30:18'),
(587, 'accept_report', 41, 10, '180.243.4.95', '202.67.40.225', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Epanzo Xenzyone (playerid=19, IP=202.67.40.225). Report mess', '2022-09-13 08:37:12'),
(588, 'accept_report', 41, 10, '180.243.4.95', '202.67.40.225', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Epanzo Xenzyone (playerid=19, IP=202.67.40.225). Report mess', '2022-09-13 08:38:18'),
(589, 'accept_report', 136, 221, '114.79.37.120', '180.214.233.66', 'Admin bastian (playerid=12, IP=114.79.37.120) accept report from Zeroz Namikaze (playerid=5, IP=180.214.233.66). Report message', '2022-09-13 08:56:39'),
(590, 'accept_report', 136, 340, '114.79.37.120', '125.164.20.143', 'Admin bastian (playerid=12, IP=114.79.37.120) accept report from Berlin Giovano (playerid=19, IP=125.164.20.143). Report messag', '2022-09-13 08:58:24'),
(591, 'accept_report', 41, 340, '180.243.4.95', '125.164.20.143', 'Admin Rukitateki (playerid=13, IP=180.243.4.95) accept report from Berlin Giovano (playerid=19, IP=125.164.20.143). Report mess', '2022-09-13 08:59:07'),
(592, 'answer', 136, 65, '114.79.37.120', '114.10.19.146', 'Admin bastian (playerid=12, IP=114.79.37.120) answer Ken Mang (playerid=17, IP=114.10.19.146) question. Question: min kantor sa', '2022-09-13 08:59:59'),
(593, 'accept_report', 136, 187, '114.79.37.120', '111.94.58.42', 'Admin bastian (playerid=12, IP=114.79.37.120) accept report from Jackson Alexander (playerid=21, IP=111.94.58.42). Report messa', '2022-09-13 09:00:21'),
(594, 'accept_report', 136, 239, '114.79.37.120', '114.10.31.13', 'Admin bastian (playerid=12, IP=114.79.37.120) accept report from Shin Fushima (playerid=10, IP=114.10.31.13). Report message: m', '2022-09-13 09:01:14'),
(595, 'ban', 136, 342, '114.79.37.120', '114.79.5.98', 'Admin bastian (playerid=12, IP=114.79.37.120) bans Alcantor Kontoloes (playerid=4, IP=114.79.5.98). Reason: Fly while shooting', '2022-09-13 09:03:34'),
(596, 'accept_report', 136, 333, '114.79.37.120', '139.193.8.42', 'Admin bastian (playerid=12, IP=114.79.37.120) accept report from Vincent Smith (playerid=8, IP=139.193.8.42). Report message: b', '2022-09-13 09:03:48'),
(597, 'answer', 43, 340, '120.188.7.208', '125.164.20.143', 'Admin Toyotomi (playerid=20, IP=120.188.7.208) answer Berlin Giovano (playerid=19, IP=125.164.20.143) question. Question: min c', '2022-09-13 09:12:48'),
(598, 'accept_report', 28, 36, '36.85.2.22', '180.251.32.212', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Jayce Hylton (playerid=0, IP=180.251.32.212). Report message: min tpi', '2022-09-13 09:23:08'),
(599, 'accept_report', 28, 165, '36.85.2.22', '115.178.192.244', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Diego Dioo (playerid=6, IP=115.178.192.244). Report message: motor ba', '2022-09-13 09:28:33'),
(600, 'answer', 28, 340, '36.85.2.22', '125.164.23.27', 'Admin Axel (playerid=2, IP=36.85.2.22) answer Berlin Giovano (playerid=11, IP=125.164.23.27) question. Question: cara buka kunc', '2022-09-13 09:30:26'),
(601, 'jail', 28, 265, '36.85.2.22', '110.137.96.163', 'Admin Axel (playerid=2, IP=36.85.2.22) jails James Bromwich (playerid=12, IP=110.137.96.163) for 45 minutes. Reason: ROB WITH O', '2022-09-13 09:32:16'),
(602, 'jail', 28, 36, '36.85.2.22', '180.251.54.144', 'Admin Axel (playerid=2, IP=36.85.2.22) jails Jayce Hylton (playerid=3, IP=180.251.54.144) for 45 minutes. Reason: ROB WITHOUT P', '2022-09-13 09:35:27'),
(603, 'accept_report', 28, 36, '36.85.2.22', '180.251.54.144', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Jayce Hylton (playerid=3, IP=180.251.54.144). Report message: udah di', '2022-09-13 09:35:48'),
(604, 'accept_report', 28, 85, '36.85.2.22', '125.162.52.18', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Matsushima Kunio (playerid=0, IP=125.162.52.18). Report message: Min ', '2022-09-13 09:36:01'),
(605, 'accept_report', 28, 85, '36.85.2.22', '125.162.52.18', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Matsushima Kunio (playerid=0, IP=125.162.52.18). Report message: Min ', '2022-09-13 09:36:43'),
(606, 'accept_report', 136, 30, '114.79.37.120', '120.188.77.234', 'Admin bastian (playerid=9, IP=114.79.37.120) accept report from Owen Knight (playerid=7, IP=120.188.77.234). Report message: mo', '2022-09-13 09:38:16'),
(607, 'accept_report', 28, 221, '36.85.2.22', '180.214.233.66', 'Admin Axel (playerid=11, IP=36.85.2.22) accept report from Zeroz Namikaze (playerid=8, IP=180.214.233.66). Report message: 6 ru', '2022-09-13 09:39:09'),
(608, 'answer', 28, 85, '36.85.2.22', '125.162.52.18', 'Admin Axel (playerid=11, IP=36.85.2.22) answer Matsushima Kunio (playerid=0, IP=125.162.52.18) question. Question: Gunanya cmd ', '2022-09-13 09:40:40'),
(609, 'ban', 28, 299, '36.85.2.22', '182.3.102.33', 'Admin Axel (playerid=11, IP=36.85.2.22) bans Kayson Rostalve. (playerid=3, IP=182.3.102.33). Reason: CHEATER', '2022-09-13 09:42:59'),
(610, 'ban', 136, 101, '114.79.37.120', '114.79.37.120', 'Admin bastian (playerid=9, IP=114.79.37.120) bans Kayson Rostalve. (playerid=16, IP=182.3.102.33). Reason: Cheat', '2022-09-13 09:43:27'),
(611, 'accept_report', 28, 85, '36.85.2.22', '125.162.52.18', 'Admin Axel (playerid=11, IP=36.85.2.22) accept report from Matsushima Kunio (playerid=0, IP=125.162.52.18). Report message: Min', '2022-09-13 09:48:15'),
(612, 'jail', 19, 41, '114.122.104.141', '140.213.24.188', 'Admin Elbier (playerid=4, IP=114.122.104.141) jails Navaro Guillermo (playerid=7, IP=140.213.24.188) for 25 minutes. Reason: ne', '2022-09-13 09:58:15'),
(613, 'accept_report', 28, 12, '36.85.2.22', '118.99.81.112', 'Admin Axel (playerid=7, IP=36.85.2.22) accept report from Samuel Ramirez (playerid=17, IP=118.99.81.112). Report message: min t', '2022-09-13 09:59:46'),
(614, 'answer', 43, 177, '120.188.7.208', '118.96.156.130', 'Admin Toyotomi (playerid=10, IP=120.188.7.208) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: bm di', '2022-09-13 10:00:20'),
(615, 'accept_report', 28, 13, '36.85.2.22', '180.253.233.58', 'Admin Axel (playerid=7, IP=36.85.2.22) accept report from Kudak Deblow (playerid=9, IP=180.253.233.58). Report message: Min hel', '2022-09-13 10:00:33'),
(616, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: sekitar di ma', '2022-09-13 10:00:56'),
(617, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: kasih clue la', '2022-09-13 10:01:31'),
(618, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: sekitar kebon', '2022-09-13 10:01:57'),
(619, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: cara matiin n', '2022-09-13 10:02:41'),
(620, 'jail', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=7, IP=36.85.2.22) offline jails Samuel_Ramirez for 60 minutes. Reason: Refuse RP, LTA', '2022-09-13 10:04:14'),
(621, 'answer', 43, 177, '120.188.7.208', '118.96.156.130', 'Admin Toyotomi (playerid=10, IP=120.188.7.208) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: bm ny', '2022-09-13 10:04:26'),
(622, 'answer', 43, 177, '120.188.7.208', '118.96.156.130', 'Admin Toyotomi (playerid=10, IP=120.188.7.208) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: hmmm ', '2022-09-13 10:05:22'),
(623, 'answer', 86, 144, '114.4.83.8', '180.244.160.9', 'Admin Godzillas (playerid=2, IP=114.4.83.8) answer Patrick Benjamin (playerid=19, IP=180.244.160.9) question. Question: rob sa ', '2022-09-13 10:08:43'),
(624, 'accept_report', 28, 144, '36.85.2.22', '180.244.160.9', 'Admin Axel (playerid=7, IP=36.85.2.22) accept report from Patrick Benjamin (playerid=19, IP=180.244.160.9). Report message: Kud', '2022-09-13 10:09:23'),
(625, 'jail', 86, 327, '114.4.83.8', '114.4.83.8', 'Admin Godzillas (playerid=2, IP=114.4.83.8) offline jails Kudak_Deblow for 1 minutes. Reason: bug', '2022-09-13 10:09:27'),
(626, 'accept_report', 28, 13, '36.85.2.22', '180.253.233.58', 'Admin Axel (playerid=7, IP=36.85.2.22) accept report from Kudak Deblow (playerid=6, IP=180.253.233.58). Report message: min bis', '2022-09-13 10:14:18'),
(627, 'answer', 28, 123, '36.85.2.22', '140.213.219.190', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Dejuam Vegeance (playerid=4, IP=140.213.219.190) question. Question: cmd drop gun', '2022-09-13 10:15:27'),
(628, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: tempat sv apa', '2022-09-13 10:17:53'),
(629, 'accept_report', 19, 194, '114.122.104.141', '140.213.183.163', 'Admin Elbier (playerid=18, IP=114.122.104.141) accept report from Fajri Maulana (playerid=12, IP=140.213.183.163). Report messa', '2022-09-13 10:18:11'),
(630, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=7, IP=36.85.2.22) answer Fazly Albiandra (playerid=3, IP=118.96.156.130) question. Question: di map ada ka', '2022-09-13 10:18:25'),
(631, 'answer', 43, 177, '120.188.7.208', '118.96.156.130', 'Admin Toyotomi (playerid=10, IP=120.188.7.208) answer Fazly Albiandra (playerid=7, IP=118.96.156.130) question. Question: cara ', '2022-09-13 10:32:49'),
(632, 'answer', 19, 31, '114.122.104.141', '103.143.63.25', 'Admin Elbier (playerid=5, IP=114.122.104.141) answer Popix Vicente (playerid=3, IP=103.143.63.25) question. Question: min gw di', '2022-09-13 10:37:13'),
(633, 'jail', 19, 7, '114.122.104.141', '114.122.104.141', 'Admin Elbier (playerid=5, IP=114.122.104.141) offline jails Jackson_Momoa for 30 minutes. Reason: !', '2022-09-13 10:39:09'),
(634, 'ban', 28, 349, '36.85.2.22', '61.247.38.76', 'Admin Axel (playerid=23, IP=36.85.2.22) bans Max Benjamin (playerid=20, IP=61.247.38.76). Reason: CHEATER', '2022-09-13 10:40:35'),
(635, 'accept_report', 19, 105, '114.122.104.141', '103.139.10.148', 'Admin Elbier (playerid=5, IP=114.122.104.141) accept report from Kenzo Devalos (playerid=14, IP=103.139.10.148). Report message', '2022-09-13 10:40:49'),
(636, 'accept_report', 28, 142, '36.85.2.22', '180.247.7.168', 'Admin Axel (playerid=23, IP=36.85.2.22) accept report from Antonio Ramorez (playerid=6, IP=180.247.7.168). Report message: id 1', '2022-09-13 10:41:29'),
(637, 'answer', 86, 327, '114.4.83.8', '114.4.83.8', 'Admin Godzillas (playerid=17, IP=114.4.83.8) answer Christian Jhonson (playerid=22, IP=180.252.92.111) question. Question: beli', '2022-09-13 10:43:33'),
(638, 'ban', 28, 350, '36.85.3.250', '61.247.38.76', 'Admin Axel (playerid=13, IP=36.85.3.250) bans Arthur Potts (playerid=20, IP=61.247.38.76). Reason: CITER', '2022-09-13 10:44:06'),
(639, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=13, IP=36.85.3.250) bans account scott. Reason: CHEATER', '2022-09-13 10:44:51'),
(640, 'accept_report', 28, 31, '36.85.3.250', '103.143.63.25', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Popix Vicente (playerid=3, IP=103.143.63.25). Report message: senja', '2022-09-13 10:46:06'),
(641, 'accept_report', 28, 31, '36.85.3.250', '103.143.63.25', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Popix Vicente (playerid=3, IP=103.143.63.25). Report message: bukan', '2022-09-13 10:47:15'),
(642, 'accept_report', 28, 142, '36.85.3.250', '180.247.7.168', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Antonio Ramorez (playerid=6, IP=180.247.7.168). Report message: id ', '2022-09-13 10:48:10'),
(643, 'answer', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=13, IP=36.85.3.250) answer Christian Jhonson (playerid=22, IP=180.252.92.111) question. Question: toko ele', '2022-09-13 10:50:31'),
(644, 'answer', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=13, IP=36.85.3.250) answer Christian Jhonson (playerid=22, IP=180.252.92.111) question. Question: kok ga a', '2022-09-13 10:51:41'),
(645, 'accept_report', 28, 31, '36.85.3.250', '103.143.63.25', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Popix Vicente (playerid=5, IP=103.143.63.25). Report message: jadi ', '2022-09-13 10:52:21'),
(646, 'accept_report', 136, 31, '114.79.37.120', '103.143.63.25', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Popix Vicente (playerid=5, IP=103.143.63.25). Report message: o', '2022-09-13 10:53:11'),
(647, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=13, IP=36.85.3.250) bans account Joaquin. Reason: CHEATER', '2022-09-13 10:55:54'),
(648, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=13, IP=36.85.3.250) offline bans character Asep_Asmara. Reason: CHEATER', '2022-09-13 10:56:27'),
(649, 'accept_report', 28, 40, '36.85.3.250', '140.213.22.87', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Ranz Summers (playerid=3, IP=140.213.22.87). Report message: min gi', '2022-09-13 10:57:52'),
(650, 'accept_report', 28, 331, '36.85.3.250', '115.178.197.93', 'Admin Axel (playerid=13, IP=36.85.3.250) accept report from Rico Jerico (playerid=18, IP=115.178.197.93). Report message: cara ', '2022-09-13 10:58:00'),
(651, 'jail', 108, 352, '103.108.130.2', '223.255.229.64', 'Admin pandu (playerid=13, IP=103.108.130.2) jails Hiroshi Yoshiki (playerid=19, IP=223.255.229.64) for 1 minutes. Reason: bug', '2022-09-13 11:07:47'),
(652, 'accept_report', 28, 36, '36.85.3.250', '180.251.54.144', 'Admin Axel (playerid=1, IP=36.85.3.250) accept report from Jayce Hylton (playerid=16, IP=180.251.54.144). Report message: min t', '2022-09-13 11:14:49'),
(653, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans account mamangsuter. Reason: CHEATER', '2022-09-13 11:21:27'),
(654, 'ban', 28, 343, '36.85.2.22', '182.3.102.33', 'Admin Axel (playerid=13, IP=36.85.2.22) bans Cody Matthew (playerid=14, IP=182.3.102.33). Reason: CHEATER', '2022-09-13 11:22:11'),
(655, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans account pler. Reason: CHEATER', '2022-09-13 11:22:52'),
(656, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans IP address 182.3.102.33. Reason: CHEATER', '2022-09-13 11:24:08'),
(657, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans IP address 182.3.103.101. Reason: CHEATER', '2022-09-13 11:24:36'),
(658, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans IP address 108.244.138.77. Reason: CHEATER', '2022-09-13 11:25:02'),
(659, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans IP address 61.247.38.76. Reason: CHEATER', '2022-09-13 11:25:41'),
(660, 'accept_report', 28, 194, '36.85.2.22', '140.213.183.129', 'Admin Axel (playerid=13, IP=36.85.2.22) accept report from Fajri Maulana (playerid=10, IP=140.213.183.129). Report message: mot', '2022-09-13 11:33:07'),
(661, 'answer', 136, 194, '114.79.37.120', '140.213.183.129', 'Admin bastian (playerid=20, IP=114.79.37.120) answer Fajri Maulana (playerid=10, IP=140.213.183.129) question. Question: cara c', '2022-09-13 11:34:14'),
(662, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans Alejandro Moreigh (playerid=0, IP=36.71.81.90). Reason: CHEATER', '2022-09-13 11:34:55'),
(663, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans account Langs. Reason: CHEATER', '2022-09-13 11:35:21'),
(664, 'accept_report', 136, 194, '114.79.37.120', '140.213.183.129', 'Admin bastian (playerid=20, IP=114.79.37.120) accept report from Fajri Maulana (playerid=10, IP=140.213.183.129). Report messag', '2022-09-13 11:35:37'),
(665, 'answer', 77, 46, '182.2.73.226', '112.215.201.160', 'Admin Kepin (playerid=18, IP=182.2.73.226) answer Aiden Pearce (playerid=12, IP=112.215.201.160) question. Question: malam min,', '2022-09-13 11:35:53'),
(666, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=13, IP=36.85.2.22) bans IP address 36.71.81.90. Reason: CHEATER', '2022-09-13 11:36:04'),
(667, 'answer', 77, 46, '182.2.73.226', '112.215.201.160', 'Admin Kepin (playerid=18, IP=182.2.73.226) answer Aiden Pearce (playerid=12, IP=112.215.201.160) question. Question: udah relog', '2022-09-13 11:36:45'),
(668, 'answer', 136, 46, '114.79.37.120', '112.215.201.160', 'Admin bastian (playerid=20, IP=114.79.37.120) answer Aiden Pearce (playerid=12, IP=112.215.201.160) question. Question: coba aj', '2022-09-13 11:37:44'),
(669, 'answer', 28, 192, '36.85.2.22', '180.252.90.229', 'Admin Axel (playerid=13, IP=36.85.2.22) answer Jahmiree Maleek (playerid=9, IP=180.252.90.229) question. Question: cot plit clu', '2022-09-13 11:40:55'),
(670, 'answer', 28, 346, '36.85.2.22', '180.252.92.111', 'Admin Axel (playerid=13, IP=36.85.2.22) answer Christian Jhonson (playerid=5, IP=180.252.92.111) question. Question: bang kok l', '2022-09-13 11:42:50'),
(671, 'answer', 77, 346, '182.2.73.226', '180.252.92.111', 'Admin Kepin (playerid=18, IP=182.2.73.226) answer Christian Jhonson (playerid=5, IP=180.252.92.111) question. Question: cara ma', '2022-09-13 11:44:05'),
(672, 'answer', 77, 346, '182.2.73.226', '180.252.92.111', 'Admin Kepin (playerid=18, IP=182.2.73.226) answer Christian Jhonson (playerid=5, IP=180.252.92.111) question. Question: ga bisa', '2022-09-13 11:44:31'),
(673, 'answer', 77, 346, '182.2.73.226', '180.252.92.111', 'Admin Kepin (playerid=18, IP=182.2.73.226) answer Christian Jhonson (playerid=5, IP=180.252.92.111) question. Question: ga bisa', '2022-09-13 11:45:17'),
(674, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=13, IP=36.85.2.22) answer Fazly Albiandra (playerid=21, IP=118.96.156.130) question. Question: beli motor ', '2022-09-13 11:50:30'),
(675, 'answer', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=13, IP=36.85.2.22) answer Fazly Albiandra (playerid=21, IP=118.96.156.130) question. Question: dealer nya ', '2022-09-13 11:51:11'),
(676, 'answer', 28, 46, '36.85.2.22', '112.215.201.160', 'Admin Axel (playerid=13, IP=36.85.2.22) answer Aiden Pearce (playerid=6, IP=112.215.201.160) question. Question: so | Answer: k', '2022-09-13 11:52:02'),
(677, 'answer', 136, 346, '114.79.37.120', '180.252.92.111', 'Admin bastian (playerid=5, IP=114.79.37.120) answer Christian Jhonson (playerid=2, IP=180.252.92.111) question. Question: renta', '2022-09-13 11:59:46'),
(678, 'accept_report', 108, 177, '103.108.130.2', '118.96.156.130', 'Admin pandu (playerid=5, IP=103.108.130.2) accept stuck request from Fazly Albiandra (playerid=7, IP=118.96.156.130).', '2022-09-13 12:24:50'),
(679, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=5, IP=103.108.130.2) offline jails Fazly_Albiandra for 0 minutes. Reason: bug', '2022-09-13 12:25:13'),
(680, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=5, IP=103.108.130.2) offline jails rojer_hawkins for 1 minutes. Reason: bug', '2022-09-13 12:26:42'),
(681, 'jail', 108, 77, '103.108.130.2', '103.108.130.2', 'Admin pandu (playerid=5, IP=103.108.130.2) offline jails Fazly_Albiandra for 1 minutes. Reason: bug', '2022-09-13 12:26:48'),
(682, 'jail', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) offline jails James_Bromwich for 1 minutes. Reason: bug', '2022-09-13 12:49:18'),
(683, 'ban', 28, 60, '36.85.3.250', '120.188.7.20', 'Admin Axel (playerid=6, IP=36.85.3.250) bans Daniell Wade (playerid=20, IP=120.188.7.20). Reason: CHEATER', '2022-09-13 12:50:49'),
(684, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) bans account skell. Reason: cheater', '2022-09-13 12:51:20'),
(685, 'accept_report', 28, 265, '36.85.3.250', '110.137.96.163', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from James Bromwich (playerid=23, IP=110.137.96.163). Report message: get', '2022-09-13 12:51:47'),
(686, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) bans IP address 120.188.38.54. Reason: CHEATER', '2022-09-13 12:54:32'),
(687, 'accept_report', 28, 31, '36.85.3.250', '103.143.63.25', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Popix Vicente (playerid=18, IP=103.143.63.25). Report message: min k', '2022-09-13 12:57:21'),
(688, 'accept_report', 169, 31, '140.213.195.201', '103.143.63.25', 'Admin Marxist (playerid=16, IP=140.213.195.201) accept report from Popix Vicente (playerid=18, IP=103.143.63.25). Report messag', '2022-09-13 12:58:01'),
(689, 'accept_report', 28, 5, '36.85.3.250', '103.108.130.116', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Frankie Charles (playerid=11, IP=103.108.130.116). Report message: m', '2022-09-13 13:07:12'),
(690, 'answer', 28, 364, '36.85.3.250', '180.242.233.239', 'Admin Axel (playerid=6, IP=36.85.3.250) answer Niko Gronnda (playerid=3, IP=180.242.233.239) question. Question: lord kok saya ', '2022-09-13 13:10:44'),
(691, 'jail', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) offline jails Rudolf_Geraldo for 1 minutes. Reason: bug', '2022-09-13 13:15:59'),
(692, 'jail', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) offline jails Rudulf_Geraldo for 1 minutes. Reason: bug', '2022-09-13 13:16:23'),
(693, 'accept_report', 28, 62, '36.85.3.250', '103.126.86.51', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Vittorini Leovince (playerid=17, IP=103.126.86.51). Report message: ', '2022-09-13 13:16:26'),
(694, 'answer', 28, 192, '36.85.3.250', '180.252.90.229', 'Admin Axel (playerid=6, IP=36.85.3.250) answer Jahmiree Maleek (playerid=9, IP=180.252.90.229) question. Question: cargo naon  ', '2022-09-13 13:17:27'),
(695, 'accept_report', 28, 365, '36.85.3.250', '112.215.241.141', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Filo Akihiko (playerid=14, IP=112.215.241.141). Report message: min ', '2022-09-13 13:19:12'),
(696, 'answer', 28, 17, '36.85.3.250', '180.244.162.11', 'Admin Axel (playerid=6, IP=36.85.3.250) answer Rojer Hawkins (playerid=12, IP=180.244.162.11) question. Question: bisa jual mob', '2022-09-13 13:23:13'),
(697, 'answer', 19, 17, '103.139.10.48', '180.244.162.11', 'Admin Elbier (playerid=13, IP=103.139.10.48) answer Rojer Hawkins (playerid=12, IP=180.244.162.11) question. Question: dimna ju', '2022-09-13 13:24:12'),
(698, 'answer', 19, 17, '103.139.10.48', '180.244.162.11', 'Admin Elbier (playerid=13, IP=103.139.10.48) answer Rojer Hawkins (playerid=12, IP=180.244.162.11) question. Question: yang /bu', '2022-09-13 13:25:59'),
(699, 'answer', 43, 17, '120.188.7.208', '180.244.162.11', 'Admin Toyotomi (playerid=14, IP=120.188.7.208) answer Rojer Hawkins (playerid=12, IP=180.244.162.11) question. Question: cuman ', '2022-09-13 13:28:21'),
(700, 'answer', 28, 213, '36.85.3.250', '182.2.135.129', 'Admin Axel (playerid=6, IP=36.85.3.250) answer Jerome Smith (playerid=0, IP=182.2.135.129) question. Question: tolong dong ems ', '2022-09-13 13:33:12'),
(701, 'accept_report', 28, 165, '36.85.3.250', '115.178.220.85', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Diego Dioo (playerid=5, IP=115.178.220.85). Report message: min teme', '2022-09-13 13:33:46'),
(702, 'accept_report', 28, 151, '36.85.3.250', '114.10.28.16', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Han Shinigami (playerid=20, IP=114.10.28.16). Report message: min sa', '2022-09-13 13:34:56'),
(703, 'accept_report', 136, 108, '114.79.37.120', '103.152.232.148', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Slei Oconner (playerid=22, IP=103.152.232.148). Report message:', '2022-09-13 13:51:09'),
(704, 'accept_report', 136, 17, '114.79.37.120', '180.244.162.11', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Rojer Hawkins (playerid=12, IP=180.244.162.11). Report message:', '2022-09-13 13:58:10'),
(705, 'answer', 161, 108, '180.251.176.171', '103.152.232.148', 'Admin Putri (playerid=15, IP=180.251.176.171) answer Slei Oconner (playerid=22, IP=103.152.232.148) question. Question: min kok', '2022-09-13 14:00:10'),
(706, 'jail', 136, 36, '114.79.37.120', '180.251.54.144', 'Admin bastian (playerid=2, IP=114.79.37.120) jails Jayce Hylton (playerid=14, IP=180.251.54.144) for 20 minutes. Reason: Death ', '2022-09-13 14:01:22'),
(707, 'answer', 108, 108, '103.108.130.2', '103.152.232.148', 'Admin pandu (playerid=1, IP=103.108.130.2) answer Slei Oconner (playerid=22, IP=103.152.232.148) question. Question: min stock ', '2022-09-13 14:07:11'),
(708, 'accept_report', 161, 108, '180.251.176.171', '103.152.232.148', 'Admin Putri (playerid=15, IP=180.251.176.171) accept report from Slei Oconner (playerid=22, IP=103.152.232.148). Report message', '2022-09-13 14:10:19');
INSERT INTO `admin_activities` (`id`, `type`, `issuer`, `receiver`, `issuer_ip_address`, `receiver_ip_address`, `description`, `created_at`) VALUES
(709, 'accept_report', 43, 108, '120.188.7.208', '103.152.232.148', 'Admin Toyotomi (playerid=24, IP=120.188.7.208) accept report from Slei Oconner (playerid=22, IP=103.152.232.148). Report messag', '2022-09-13 14:11:26'),
(710, 'answer', 136, 62, '114.79.37.120', '103.126.86.51', 'Admin bastian (playerid=2, IP=114.79.37.120) answer Vittorini Leovince (playerid=17, IP=103.126.86.51) question. Question: cara', '2022-09-13 14:14:18'),
(711, 'accept_report', 136, 135, '114.79.37.120', '114.122.68.40', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Alex Tuna (playerid=16, IP=114.122.68.40). Report message: bug ', '2022-09-13 14:21:05'),
(712, 'answer', 43, 173, '120.188.7.208', '180.248.21.104', 'Admin Toyotomi (playerid=12, IP=120.188.7.208) answer Hilmy Fauzan (playerid=3, IP=180.248.21.104) question. Question: Cara Buk', '2022-09-13 14:35:17'),
(713, 'answer', 43, 173, '120.188.7.208', '180.248.21.104', 'Admin Toyotomi (playerid=12, IP=120.188.7.208) answer Hilmy Fauzan (playerid=3, IP=180.248.21.104) question. Question: Kenapa M', '2022-09-13 14:36:07'),
(714, 'answer', 43, 173, '120.188.7.208', '180.248.21.104', 'Admin Toyotomi (playerid=12, IP=120.188.7.208) answer Hilmy Fauzan (playerid=3, IP=180.248.21.104) question. Question: Parkir s', '2022-09-13 14:36:48'),
(715, 'accept_report', 136, 5, '114.79.37.120', '115.178.196.104', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Frankie Charles (playerid=21, IP=115.178.196.104). Report messa', '2022-09-13 14:42:44'),
(716, 'accept_report', 136, 5, '114.79.37.120', '115.178.196.104', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Frankie Charles (playerid=21, IP=115.178.196.104). Report messa', '2022-09-13 14:44:09'),
(717, 'accept_report', 136, 17, '114.79.37.120', '180.244.162.11', 'Admin bastian (playerid=2, IP=114.79.37.120) accept report from Rojer Hawkins (playerid=5, IP=180.244.162.11). Report message: ', '2022-09-13 14:44:30'),
(718, 'jail', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=14, IP=36.85.3.250) offline jails Rudulf_Geraldo for 1 minutes. Reason: bug', '2022-09-13 14:44:45'),
(719, 'accept_report', 28, 11, '36.85.3.250', '8.25.96.95', 'Admin Axel (playerid=14, IP=36.85.3.250) accept report from Plutarco Echeverra (playerid=19, IP=8.25.96.95). Report message: mi', '2022-09-13 14:47:29'),
(720, 'accept_report', 28, 5, '36.85.3.250', '115.178.196.104', 'Admin Axel (playerid=14, IP=36.85.3.250) accept report from Frankie Charles (playerid=10, IP=115.178.196.104). Report message: ', '2022-09-13 14:47:31'),
(721, 'accept_report', 28, 5, '36.85.3.250', '115.178.196.104', 'Admin Axel (playerid=14, IP=36.85.3.250) accept report from Frankie Charles (playerid=10, IP=115.178.196.104). Report message: ', '2022-09-13 14:48:19'),
(722, 'jail', 28, 5, '36.85.3.250', '115.178.196.104', 'Admin Axel (playerid=14, IP=36.85.3.250) jails Frankie Charles (playerid=10, IP=115.178.196.104) for 1 minutes. Reason: bug', '2022-09-13 14:48:36'),
(723, 'jail', 43, 5, '120.188.7.208', '115.178.196.104', 'Admin Toyotomi (playerid=12, IP=120.188.7.208) jails Frankie Charles (playerid=10, IP=115.178.196.104) for 1 minutes. Reason: t', '2022-09-13 14:48:42'),
(724, 'accept_report', 28, 370, '36.85.3.250', '180.249.201.183', 'Admin Axel (playerid=14, IP=36.85.3.250) accept report from Jhon Vebri (playerid=7, IP=180.249.201.183). Report message: min bu', '2022-09-13 14:50:14'),
(725, 'accept_report', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=14, IP=36.85.3.250) accept report from Melvin Alexander (playerid=24, IP=112.215.210.198). Report message:', '2022-09-13 14:54:23'),
(726, 'jail', 43, 5, '120.188.7.208', '115.178.196.104', 'Admin Toyotomi (playerid=12, IP=120.188.7.208) jails Frankie Charles (playerid=10, IP=115.178.196.104) for 1 minutes. Reason: b', '2022-09-13 14:54:52'),
(727, 'ban', 28, 372, '36.85.3.250', '114.79.4.132', 'Admin Axel (playerid=14, IP=36.85.3.250) bans Tommy Sander (playerid=3, IP=114.79.4.132). Reason: CHEATER', '2022-09-13 15:03:15'),
(728, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=14, IP=36.85.3.250) bans account romero. Reason: CHEATER', '2022-09-13 15:03:53'),
(729, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=14, IP=36.85.3.250) bans IP address 114.79.5.98. Reason: CHEATER', '2022-09-13 15:04:47'),
(730, 'jail', 136, 101, '114.79.37.120', '114.79.37.120', 'Admin bastian (playerid=6, IP=114.79.37.120) jails Guilherme Leao (playerid=6, IP=114.79.37.120) for 1 minutes. Reason: bug', '2022-09-13 15:12:10'),
(731, 'jail', 28, 40, '36.85.3.250', '140.213.22.88', 'Admin Axel (playerid=14, IP=36.85.3.250) jails Ranz Summers (playerid=3, IP=140.213.22.88) for 60 minutes. Reason: NON RP FEAR', '2022-09-13 15:33:37'),
(732, 'accept_report', 43, 165, '120.188.7.208', '114.79.7.212', 'Admin Toyotomi (playerid=0, IP=120.188.7.208) accept report from Diego Dioo (playerid=10, IP=114.79.7.212). Report message: id ', '2022-09-13 15:42:48'),
(733, 'answer', 43, 139, '120.188.7.208', '140.213.36.209', 'Admin Toyotomi (playerid=7, IP=120.188.7.208) answer Andrey Rodriguez (playerid=9, IP=140.213.36.209) question. Question: CMD e', '2022-09-13 16:39:18'),
(734, 'answer', 86, 34, '114.4.83.8', '125.167.56.182', 'Admin Godzillas (playerid=16, IP=114.4.83.8) answer Amado Daluez (playerid=15, IP=125.167.56.182) question. Question: min saya ', '2022-09-13 16:47:56'),
(735, 'accept_report', 28, 371, '36.85.3.250', '112.215.210.198', 'Admin Axel (playerid=15, IP=36.85.3.250) accept report from Melvin Alexander (playerid=14, IP=112.215.210.198). Report message:', '2022-09-13 17:09:53'),
(736, 'accept_report', 28, 188, '36.85.2.22', '180.243.33.3', 'Admin Axel (playerid=11, IP=36.85.2.22) accept report from Marrino Luccano (playerid=10, IP=180.243.33.3). Report message: min ', '2022-09-13 17:21:31'),
(737, 'accept_report', 136, 188, '114.79.37.60', '180.243.33.3', 'Admin bastian (playerid=9, IP=114.79.37.60) accept report from Marrino Luccano (playerid=10, IP=180.243.33.3). Report message: ', '2022-09-13 17:23:00'),
(738, 'accept_report', 41, 371, '180.243.4.95', '112.215.210.198', 'Admin Rukitateki (playerid=8, IP=180.243.4.95) accept report from Melvin Alexander (playerid=7, IP=112.215.210.198). Report mes', '2022-09-13 17:25:42'),
(739, 'answer', 28, 188, '36.85.2.22', '180.243.33.3', 'Admin Axel (playerid=11, IP=36.85.2.22) answer Marrino Luccano (playerid=10, IP=180.243.33.3) question. Question: min nama duff', '2022-09-13 17:28:41'),
(740, 'ban', 28, 144, '36.85.3.250', '180.244.160.9', 'Admin Axel (playerid=8, IP=36.85.3.250) bans Patrick Benjamin (playerid=3, IP=180.244.160.9). Reason: CHEATER', '2022-09-13 19:31:00'),
(741, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=8, IP=36.85.3.250) bans account farwin. Reason: CHEATER', '2022-09-13 19:31:22'),
(742, 'accept_report', 86, 340, '114.4.83.8', '125.164.17.235', 'Admin godzillas (playerid=1, IP=114.4.83.8) accept report from Berlin Giovano (playerid=7, IP=125.164.17.235). Report message: ', '2022-09-13 20:00:12'),
(743, 'answer', 136, 371, '114.79.37.100', '112.215.210.214', 'Admin bastian (playerid=9, IP=114.79.37.100) answer Melvin Alexander (playerid=10, IP=112.215.210.214) question. Question: mas ', '2022-09-14 01:00:27'),
(744, 'accept_report', 136, 371, '114.79.37.100', '112.215.210.214', 'Admin bastian (playerid=9, IP=114.79.37.100) accept report from Melvin Alexander (playerid=10, IP=112.215.210.214). Report mess', '2022-09-14 01:07:22'),
(745, 'accept_report', 136, 239, '114.79.37.100', '116.206.28.14', 'Admin bastian (playerid=6, IP=114.79.37.100) accept report from Shin Fushima (playerid=5, IP=116.206.28.14). Report message: mi', '2022-09-14 01:24:34'),
(746, 'accept_report', 136, 40, '114.79.37.100', '112.215.209.126', 'Admin bastian (playerid=6, IP=114.79.37.100) accept report from Ranz Summers (playerid=8, IP=112.215.209.126). Report message: ', '2022-09-14 01:32:42'),
(747, 'jail', 136, 101, '114.79.37.100', '114.79.37.100', 'Admin bastian (playerid=6, IP=114.79.37.100) jails bastian (playerid=6, IP=114.79.37.100) for 1 minutes. Reason: bug', '2022-09-14 01:40:24'),
(748, 'jail', 136, 385, '114.79.37.24', '116.206.35.30', 'Admin bastian (playerid=2, IP=114.79.37.24) jails James Arksuhn (playerid=0, IP=116.206.35.30) for 60 minutes. Reason: Penyalah', '2022-09-14 03:00:52'),
(749, 'accept_report', 28, 31, '36.85.2.22', '103.143.63.25', 'Admin Axel (playerid=5, IP=36.85.2.22) accept report from Popix Vicente (playerid=0, IP=103.143.63.25). Report message: min gw ', '2022-09-14 03:18:41'),
(750, 'jail', 28, 31, '36.85.2.22', '103.143.63.25', 'Admin Axel (playerid=5, IP=36.85.2.22) jails Popix Vicente (playerid=0, IP=103.143.63.25) for 1 minutes. Reason: bug', '2022-09-14 03:18:56'),
(751, 'accept_report', 28, 213, '36.85.2.22', '182.2.137.152', 'Admin Axel (playerid=5, IP=36.85.2.22) accept report from Jerome Smith (playerid=6, IP=182.2.137.152). Report message: mobil ma', '2022-09-14 03:22:59'),
(752, 'answer', 28, 213, '36.85.2.22', '182.2.137.152', 'Admin Axel (playerid=5, IP=36.85.2.22) answer Jerome Smith (playerid=6, IP=182.2.137.152) question. Question: ga bisa diclaim I', '2022-09-14 03:23:46'),
(753, 'answer', 28, 213, '36.85.2.22', '182.2.137.152', 'Admin Axel (playerid=5, IP=36.85.2.22) answer Jerome Smith (playerid=6, IP=182.2.137.152) question. Question: 2jam min-_- | Ans', '2022-09-14 03:24:20'),
(754, 'answer', 28, 213, '36.85.2.22', '182.2.137.152', 'Admin Axel (playerid=5, IP=36.85.2.22) answer Jerome Smith (playerid=6, IP=182.2.137.152) question. Question: gabisa ditarikin?', '2022-09-14 03:25:00'),
(755, 'answer', 136, 213, '114.79.37.24', '182.2.137.152', 'Admin bastian (playerid=4, IP=114.79.37.24) answer Jerome Smith (playerid=6, IP=182.2.137.152) question. Question: duh lagi ngr', '2022-09-14 03:25:52'),
(756, 'answer', 41, 213, '180.243.4.95', '182.2.137.152', 'Admin Rukitateki (playerid=0, IP=180.243.4.95) answer Jerome Smith (playerid=2, IP=182.2.137.152) question. Question: stok semu', '2022-09-14 05:16:45'),
(757, 'accept_report', 136, 12, '114.79.37.4', '118.99.81.187', 'Admin bastian (playerid=7, IP=114.79.37.4) accept report from Samuel Ramirez (playerid=4, IP=118.99.81.187). Report message: mi', '2022-09-14 05:46:41'),
(758, 'jail', 136, 12, '114.79.37.4', '118.99.81.187', 'Admin bastian (playerid=7, IP=114.79.37.4) jails Samuel Ramirez (playerid=4, IP=118.99.81.187) for 50 minutes. Reason: Refuse R', '2022-09-14 05:51:59'),
(759, 'answer', 28, 71, '36.85.3.250', '180.251.150.189', 'Admin Axel (playerid=4, IP=36.85.3.250) answer Ozoro Shinigami (playerid=7, IP=180.251.150.189) question. Question: cara kerja ', '2022-09-14 06:03:23'),
(760, 'accept_report', 86, 116, '114.4.83.8', '202.67.43.15', 'Admin Godzillas (playerid=6, IP=114.4.83.8) accept report from Hazel Leone (playerid=10, IP=202.67.43.15). Report message: min ', '2022-09-14 06:06:03'),
(761, 'accept_report', 28, 381, '36.85.3.250', '114.79.39.134', 'Admin Axel (playerid=4, IP=36.85.3.250) accept report from Samuel Oconner (playerid=14, IP=114.79.39.134). Report message: min ', '2022-09-14 06:28:17'),
(762, 'accept_report', 28, 381, '36.85.3.250', '114.79.39.134', 'Admin Axel (playerid=4, IP=36.85.3.250) accept report from Samuel Oconner (playerid=14, IP=114.79.39.134). Report message: food', '2022-09-14 06:28:56'),
(763, 'answer', 43, 340, '114.10.28.15', '125.164.16.176', 'Admin Toyotomi (playerid=15, IP=114.10.28.15) answer Berlin Giovano (playerid=16, IP=125.164.16.176) question. Question: min ca', '2022-09-14 06:30:11'),
(764, 'accept_report', 28, 381, '36.85.3.250', '114.79.39.134', 'Admin Axel (playerid=4, IP=36.85.3.250) accept report from Samuel Oconner (playerid=14, IP=114.79.39.134). Report message: tutu', '2022-09-14 06:32:00'),
(765, 'answer', 43, 65, '114.10.28.15', '114.10.21.139', 'Admin Toyotomi (playerid=15, IP=114.10.28.15) answer Ken Mang (playerid=13, IP=114.10.21.139) question. Question: min seeds ema', '2022-09-14 06:43:32'),
(766, 'answer', 155, 159, '182.2.68.211', '125.162.208.78', 'Admin TerCooL (playerid=19, IP=182.2.68.211) answer Olmero Estevanez (playerid=18, IP=125.162.208.78) question. Question: ini m', '2022-09-14 06:50:20'),
(767, 'answer', 155, 67, '182.2.68.211', '103.144.169.52', 'Admin TerCooL (playerid=19, IP=182.2.68.211) answer Frenzy Shinigami (playerid=8, IP=103.144.169.52) question. Question: apakah', '2022-09-14 06:56:16'),
(768, 'accept_report', 155, 34, '182.2.68.211', '125.167.56.182', 'Admin TerCooL (playerid=19, IP=182.2.68.211) accept report from Amado Daluez (playerid=11, IP=125.167.56.182). Report message: ', '2022-09-14 06:56:30'),
(769, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=4, IP=36.85.3.250) offline bans character Cody_Marshall. Reason: CHEATER', '2022-09-14 07:56:42'),
(770, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=4, IP=36.85.3.250) bans account kontol. Reason: CHEATER', '2022-09-14 07:57:05'),
(771, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=4, IP=36.85.3.250) bans IP address 8.38.147.56. Reason: CHEATER', '2022-09-14 07:57:50'),
(772, 'ban', 28, 165, '36.85.3.250', '114.79.7.204', 'Admin Axel (playerid=10, IP=36.85.3.250) bans Diego Dioo (playerid=5, IP=114.79.7.204). Reason: CHEATER', '2022-09-14 08:06:52'),
(773, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=10, IP=36.85.3.250) bans account egoo. Reason: CHEATER', '2022-09-14 08:07:13'),
(774, 'accept_report', 28, 175, '36.85.3.250', '140.213.24.233', 'Admin Axel (playerid=10, IP=36.85.3.250) accept report from Yanto Clausius (playerid=0, IP=140.213.24.233). Report message: min', '2022-09-14 08:07:20'),
(775, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=10, IP=36.85.3.250) bans IP address 115.178.206.90. Reason: CHEATER', '2022-09-14 08:08:05'),
(776, 'answer', 28, 175, '36.85.3.250', '140.213.24.233', 'Admin Axel (playerid=10, IP=36.85.3.250) answer Yanto Clausius (playerid=0, IP=140.213.24.233) question. Question: boleh telepo', '2022-09-14 08:08:18'),
(777, 'answer', 28, 177, '36.85.3.250', '118.96.156.130', 'Admin Axel (playerid=10, IP=36.85.3.250) answer Fazly Albiandra (playerid=13, IP=118.96.156.130) question. Question: Cheater ny', '2022-09-14 08:08:50'),
(778, 'accept_report', 28, 34, '36.85.3.250', '125.167.56.182', 'Admin Axel (playerid=10, IP=36.85.3.250) accept report from Amado Daluez (playerid=14, IP=125.167.56.182). Report message: min ', '2022-09-14 08:10:00'),
(779, 'answer', 28, 346, '36.85.3.250', '180.252.92.111', 'Admin Axel (playerid=10, IP=36.85.3.250) answer Christian Jhonson (playerid=15, IP=180.252.92.111) question. Question: cara ren', '2022-09-14 08:11:12'),
(780, 'jail', 43, 177, '114.10.28.15', '118.96.156.130', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) jails Fazly Albiandra (playerid=13, IP=118.96.156.130) for 15 minutes. Reason: NON', '2022-09-14 08:23:54'),
(781, 'accept_report', 43, 34, '114.10.28.15', '125.167.56.182', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) accept report from Amado Daluez (playerid=14, IP=125.167.56.182). Report message: ', '2022-09-14 08:24:10'),
(782, 'accept_report', 28, 12, '36.85.2.22', '118.99.81.187', 'Admin Axel (playerid=10, IP=36.85.2.22) accept report from Samuel Ramirez (playerid=15, IP=118.99.81.187). Report message: min ', '2022-09-14 08:28:51'),
(783, 'accept_report', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=10, IP=36.85.2.22) accept report from Fazly Albiandra (playerid=17, IP=118.96.156.130). Report message: pa', '2022-09-14 08:30:37'),
(784, 'accept_report', 28, 108, '36.85.2.22', '103.152.232.148', 'Admin Axel (playerid=10, IP=36.85.2.22) accept report from Slei Oconner (playerid=3, IP=103.152.232.148). Report message: tolon', '2022-09-14 08:31:24'),
(785, 'answer', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) answer Slei Oconner (playerid=18, IP=103.152.232.148) question. Question: min cara', '2022-09-14 08:41:52'),
(786, 'accept_report', 43, 177, '114.10.28.15', '118.96.156.130', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) accept report from Fazly Albiandra (playerid=14, IP=118.96.156.130). Report messag', '2022-09-14 08:42:18'),
(787, 'answer', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) answer Slei Oconner (playerid=18, IP=103.152.232.148) question. Question: iya tp i', '2022-09-14 08:42:51'),
(788, 'answer', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) answer Slei Oconner (playerid=18, IP=103.152.232.148) question. Question: kaga bis', '2022-09-14 08:43:22'),
(789, 'accept_report', 28, 108, '36.85.2.22', '103.152.232.148', 'Admin Axel (playerid=20, IP=36.85.2.22) accept report from Slei Oconner (playerid=18, IP=103.152.232.148). Report message: bg a', '2022-09-14 08:50:24'),
(790, 'accept_report', 28, 177, '36.85.2.22', '118.96.156.130', 'Admin Axel (playerid=20, IP=36.85.2.22) accept report from Fazly Albiandra (playerid=14, IP=118.96.156.130). Report message: tp', '2022-09-14 08:51:38'),
(791, 'accept_report', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) accept report from Slei Oconner (playerid=18, IP=103.152.232.148). Report message:', '2022-09-14 09:01:22'),
(792, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=20, IP=36.85.2.22) temporary bans Ary Charleston (playerid=17, IP=203.78.119.92). Reason: HEALT HACK', '2022-09-14 09:01:32'),
(793, 'accept_report', 28, 108, '36.85.2.22', '103.152.232.148', 'Admin Axel (playerid=20, IP=36.85.2.22) accept report from Slei Oconner (playerid=18, IP=103.152.232.148). Report message: iy t', '2022-09-14 09:02:42'),
(794, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) bans account AryNihh. Reason: Cheater HEALTH HACK', '2022-09-14 09:12:32'),
(795, 'unban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) unbans Ary_Charleston.', '2022-09-14 09:13:06'),
(796, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) offline bans character Ary_Charleston. Reason: CHEATER Health Hack', '2022-09-14 09:13:11'),
(797, 'ban', 28, 16, '36.85.3.250', '36.85.3.250', 'Admin Axel (playerid=6, IP=36.85.3.250) bans IP address 203.78.119.92. Reason: Cheater HEALTH HACK', '2022-09-14 09:13:48'),
(798, 'accept_report', 28, 175, '36.85.3.250', '140.213.24.233', 'Admin Axel (playerid=6, IP=36.85.3.250) accept report from Yanto Clausius (playerid=0, IP=140.213.24.233). Report message: min ', '2022-09-14 09:15:09'),
(799, 'answer', 41, 12, '180.243.4.95', '118.99.81.187', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Samuel Ramirez (playerid=15, IP=118.99.81.187) question. Question: min c', '2022-09-14 09:28:36'),
(800, 'answer', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Vicky Escobar (playerid=13, IP=103.10.64.20) question. Question: min bis', '2022-09-14 09:29:37'),
(801, 'answer', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Vicky Escobar (playerid=13, IP=103.10.64.20) question. Question: beli gp', '2022-09-14 09:30:09'),
(802, 'answer', 41, 34, '180.243.4.95', '125.167.56.182', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Amado Daluez (playerid=5, IP=125.167.56.182) question. Question: cmd nga', '2022-09-14 09:30:15'),
(803, 'answer', 41, 155, '180.243.4.95', '149.113.254.240', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Derus Fann (playerid=9, IP=149.113.254.240) question. Question: min kok ', '2022-09-14 09:32:32'),
(804, 'accept_report', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) accept report from Slei Oconner (playerid=4, IP=103.152.232.148). Report message: ', '2022-09-14 09:40:06'),
(805, 'jail', 41, 34, '180.243.4.95', '125.167.56.182', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) jails Amado Daluez (playerid=5, IP=125.167.56.182) for 30 minutes. Reason: Powe', '2022-09-14 09:40:25'),
(806, 'accept_report', 28, 12, '36.85.2.22', '118.99.81.187', 'Admin Axel (playerid=1, IP=36.85.2.22) accept report from Samuel Ramirez (playerid=15, IP=118.99.81.187). Report message: min i', '2022-09-14 09:41:52'),
(807, 'answer', 41, 340, '180.243.4.95', '125.164.16.176', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Berlin Giovano (playerid=10, IP=125.164.16.176) question. Question: cara', '2022-09-14 09:43:00'),
(808, 'answer', 41, 194, '180.243.4.95', '140.213.183.91', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Fajri Maulana (playerid=17, IP=140.213.183.91) question. Question: TABBI', '2022-09-14 09:48:01'),
(809, 'answer', 43, 49, '114.10.28.15', '114.10.28.15', 'Admin Toyotomi (playerid=8, IP=114.10.28.15) answer Vicky Escobar (playerid=13, IP=103.10.64.20) question. Question: Min cmd de', '2022-09-14 09:50:10'),
(810, 'accept_report', 136, 34, '114.79.37.171', '125.167.56.182', 'Admin bastian (playerid=0, IP=114.79.37.171) accept report from Amado Daluez (playerid=5, IP=125.167.56.182). Report message: a', '2022-09-14 09:51:57'),
(811, 'ban', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) bans account Notzee. Reason: Account Sharing', '2022-09-14 09:59:47'),
(812, 'unban', 41, 25, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) unbans account LordXav.', '2022-09-14 10:00:58'),
(813, 'accept_report', 41, 40, '180.243.4.95', '112.215.253.227', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept stuck request from Ranz Summers (playerid=7, IP=112.215.253.227).', '2022-09-14 10:04:58'),
(814, 'accept_report', 41, 340, '180.243.4.95', '125.164.21.243', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Berlin Giovano (playerid=3, IP=125.164.21.243). Report messa', '2022-09-14 10:05:05'),
(815, 'jail', 41, 340, '180.243.4.95', '125.164.21.243', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) jails Berlin Giovano (playerid=3, IP=125.164.21.243) for 1 minutes. Reason: bug', '2022-09-14 10:08:20'),
(816, 'accept_report', 41, 12, '180.243.4.95', '118.99.81.187', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Samuel Ramirez (playerid=9, IP=118.99.81.187). Report messag', '2022-09-14 10:11:05'),
(817, 'accept_report', 41, 340, '180.243.4.95', '125.164.16.176', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Berlin Giovano (playerid=0, IP=125.164.16.176). Report messa', '2022-09-14 10:12:44'),
(818, 'jail', 41, 340, '180.243.4.95', '125.164.16.176', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) jails Berlin Giovano (playerid=0, IP=125.164.16.176) for 1 minutes. Reason: bug', '2022-09-14 10:13:23'),
(819, 'accept_report', 41, 177, '180.243.4.95', '118.96.156.130', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Fazly Albiandra (playerid=10, IP=118.96.156.130). Report mes', '2022-09-14 10:15:33'),
(820, 'accept_report', 41, 196, '180.243.4.95', '115.178.221.180', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Ayip Carlos (playerid=18, IP=115.178.221.180). Report messag', '2022-09-14 10:16:57'),
(821, 'accept_report', 41, 177, '180.243.4.95', '118.96.156.130', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Fazly Albiandra (playerid=10, IP=118.96.156.130). Report mes', '2022-09-14 10:17:09'),
(822, 'accept_report', 41, 11, '180.243.4.95', '8.25.96.95', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Plutarco Echeverra (playerid=24, IP=8.25.96.95). Report mess', '2022-09-14 10:19:55'),
(823, 'accept_report', 41, 34, '180.243.4.95', '125.167.56.182', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) accept report from Amado Daluez (playerid=5, IP=125.167.56.182). Report message', '2022-09-14 10:20:03'),
(824, 'answer', 41, 12, '180.243.4.95', '118.99.81.187', 'Admin Rukitateki (playerid=19, IP=180.243.4.95) answer Samuel Ramirez (playerid=9, IP=118.99.81.187) question. Question: min bi', '2022-09-14 10:20:56'),
(825, 'accept_report', 136, 12, '114.79.37.171', '118.99.81.187', 'Admin bastian (playerid=0, IP=114.79.37.171) accept report from Samuel Ramirez (playerid=9, IP=118.99.81.187). Report message: ', '2022-09-14 10:31:14'),
(826, 'answer', 28, 404, '36.85.2.22', '114.79.7.204', 'Admin Axel (playerid=2, IP=36.85.2.22) answer Martin Brooks (playerid=1, IP=114.79.7.204) question. Question: min tempat beli k', '2022-09-14 11:07:50'),
(827, 'ban', 28, 404, '36.85.2.22', '114.79.7.204', 'Admin Axel (playerid=2, IP=36.85.2.22) bans Martin Brooks (playerid=1, IP=114.79.7.204). Reason: CHEATER', '2022-09-14 11:10:28'),
(828, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) bans account God. Reason: Cheater', '2022-09-14 11:11:23'),
(829, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) bans IP address 114.79.7.204. Reason: Cheater', '2022-09-14 11:11:47'),
(830, 'jail', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) offline jails NI_NENGAH_DEWI_KIRANA_P for 9999 minutes. Reason: NONRP NAME(Contact High ', '2022-09-14 11:13:28'),
(831, 'accept_report', 28, 108, '36.85.2.22', '103.152.232.148', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Slei Oconner (playerid=7, IP=103.152.232.148). Report message: tolong', '2022-09-14 11:15:40'),
(832, 'answer', 28, 108, '36.85.2.22', '103.152.232.148', 'Admin Axel (playerid=2, IP=36.85.2.22) answer Slei Oconner (playerid=7, IP=103.152.232.148) question. Question: 71 | Answer: ok', '2022-09-14 11:16:15'),
(833, 'answer', 28, 340, '36.85.2.22', '125.164.18.176', 'Admin Axel (playerid=2, IP=36.85.2.22) answer Berlin Giovano (playerid=4, IP=125.164.18.176) question. Question: cara buka baga', '2022-09-14 11:17:01'),
(834, 'unban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) unbans Ary_Charleston.', '2022-09-14 11:17:55'),
(835, 'unban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) unbans account AryNihh.', '2022-09-14 11:18:04'),
(836, 'accept_report', 28, 194, '36.85.2.22', '140.213.67.137', 'Admin Axel (playerid=2, IP=36.85.2.22) accept report from Fajri Maulana (playerid=5, IP=140.213.67.137). Report message: min ke', '2022-09-14 11:21:22'),
(837, 'ban', 28, 403, '36.85.2.22', '103.10.65.119', 'Admin Axel (playerid=2, IP=36.85.2.22) bans Vicky Escobar (playerid=1, IP=103.10.65.119). Reason: CHEATER', '2022-09-14 11:23:27'),
(838, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) bans account Vicky. Reason: Cheater', '2022-09-14 11:23:59'),
(839, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=2, IP=36.85.2.22) bans IP address 103.10.64.20. Reason: Cheater', '2022-09-14 11:24:27'),
(840, 'accept_report', 136, 217, '114.79.37.171', '140.213.43.221', 'Admin bastian (playerid=18, IP=114.79.37.171) accept report from Ramm Mulki (playerid=14, IP=140.213.43.221). Report message: b', '2022-09-14 12:45:27'),
(841, 'jail', 136, 217, '114.79.37.171', '140.213.43.221', 'Admin bastian (playerid=18, IP=114.79.37.171) jails Ramm Mulki (playerid=14, IP=140.213.43.221) for 1 minutes. Reason: bug', '2022-09-14 12:45:44'),
(842, 'accept_report', 136, 108, '114.79.37.171', '103.152.232.148', 'Admin bastian (playerid=18, IP=114.79.37.171) accept report from Slei Oconner (playerid=21, IP=103.152.232.148). Report message', '2022-09-14 12:48:49'),
(843, 'accept_report', 136, 177, '114.79.37.171', '118.96.156.130', 'Admin bastian (playerid=18, IP=114.79.37.171) accept stuck request from Fazly Albiandra (playerid=25, IP=118.96.156.130).', '2022-09-14 12:53:43'),
(844, 'accept_report', 43, 108, '114.10.28.15', '103.152.232.148', 'Admin Toyotomi (playerid=13, IP=114.10.28.15) accept report from Slei Oconner (playerid=3, IP=103.152.232.148). Report message:', '2022-09-14 13:03:19'),
(845, 'accept_report', 43, 194, '114.10.28.15', '140.213.67.137', 'Admin Toyotomi (playerid=13, IP=114.10.28.15) accept report from Fajri Maulana (playerid=5, IP=140.213.67.137). Report message:', '2022-09-14 13:03:25'),
(846, 'answer', 136, 40, '114.79.37.171', '112.215.253.227', 'Admin bastian (playerid=15, IP=114.79.37.171) answer Ranz Summers (playerid=0, IP=112.215.253.227) question. Question: kode war', '2022-09-14 13:10:58'),
(847, 'answer', 136, 46, '114.79.37.171', '140.213.158.167', 'Admin bastian (playerid=15, IP=114.79.37.171) answer Aiden Pearce (playerid=12, IP=140.213.158.167) question. Question: malem m', '2022-09-14 13:15:01'),
(848, 'answer', 19, 46, '103.139.10.48', '140.213.158.167', 'Admin Elbier (playerid=5, IP=103.139.10.48) answer Aiden Pearce (playerid=14, IP=140.213.158.167) question. Question: malam min', '2022-09-14 13:24:24'),
(849, 'answer', 19, 46, '103.139.10.48', '140.213.158.167', 'Admin Elbier (playerid=5, IP=103.139.10.48) answer Aiden Pearce (playerid=14, IP=140.213.158.167) question. Question: udah leve', '2022-09-14 13:25:26'),
(850, 'accept_report', 19, 177, '103.139.10.48', '118.96.156.130', 'Admin Elbier (playerid=5, IP=103.139.10.48) accept report from Fazly Albiandra (playerid=20, IP=118.96.156.130). Report message', '2022-09-14 13:25:40'),
(851, 'answer', 19, 108, '103.139.10.48', '103.152.232.148', 'Admin Elbier (playerid=5, IP=103.139.10.48) answer Slei Oconner (playerid=12, IP=103.152.232.148) question. Question: min kok g', '2022-09-14 13:26:27'),
(852, 'accept_report', 19, 12, '103.139.10.48', '118.99.81.187', 'Admin Elbier (playerid=5, IP=103.139.10.48) accept report from Samuel Ramirez (playerid=2, IP=118.99.81.187). Report message: m', '2022-09-14 13:26:33'),
(853, 'answer', 43, 177, '114.10.28.15', '118.96.156.130', 'Admin Toyotomi (playerid=13, IP=114.10.28.15) answer Fazly Albiandra (playerid=20, IP=118.96.156.130) question. Question: cara ', '2022-09-14 13:28:03'),
(854, 'accept_report', 19, 46, '103.139.10.48', '140.213.158.167', 'Admin Elbier (playerid=5, IP=103.139.10.48) accept report from Aiden Pearce (playerid=14, IP=140.213.158.167). Report message: ', '2022-09-14 13:28:50'),
(855, 'jail', 19, 7, '103.139.10.48', '103.139.10.48', 'Admin Elbier (playerid=5, IP=103.139.10.48) offline jails Smith_Martin for 1 minutes. Reason: bug', '2022-09-14 13:32:11'),
(856, 'accept_report', 136, 62, '114.79.37.171', '103.126.86.51', 'Admin bastian (playerid=13, IP=114.79.37.171) accept report from Vittorini Leovince (playerid=9, IP=103.126.86.51). Report mess', '2022-09-14 15:30:46'),
(857, 'unban', 41, 23, '180.243.4.95', '180.243.4.95', 'Admin Rukitateki (playerid=1, IP=180.243.4.95) unbans account Notzee.', '2022-09-14 15:42:23'),
(858, 'jail', 136, 40, '114.79.37.171', '140.213.22.183', 'Admin bastian (playerid=9, IP=114.79.37.171) jails Ranz Summers (playerid=12, IP=140.213.22.183) for 1 minutes. Reason: bug', '2022-09-14 15:51:54'),
(859, 'jail', 136, 101, '114.79.39.187', '114.79.39.187', 'Admin bastian (playerid=3, IP=114.79.39.187) jails Popix (playerid=2, IP=36.85.7.204) for 1 minutes. Reason: bug', '2022-09-14 23:32:25'),
(860, 'jail', 136, 101, '114.79.39.187', '114.79.39.187', 'Admin bastian (playerid=3, IP=114.79.39.187) offline jails Popix_Vicente for 1 minutes. Reason: bug', '2022-09-14 23:33:36'),
(861, 'accept_report', 28, 40, '36.85.2.22', '140.213.41.106', 'Admin Axel (playerid=0, IP=36.85.2.22) accept report from Ranz Summers (playerid=2, IP=140.213.41.106). Report message: bang gu', '2022-09-15 02:13:42'),
(862, 'unban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=0, IP=36.85.2.22) unbans account egoo.', '2022-09-15 02:18:10'),
(863, 'unban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=0, IP=36.85.2.22) unbans Diego_Dioo.', '2022-09-15 02:18:20'),
(864, 'ban', 28, 16, '36.85.2.22', '36.85.2.22', 'Admin Axel (playerid=0, IP=36.85.2.22) offline temporary bans Diego_Dioo. Reason: Cheater Fly Hack', '2022-09-15 02:18:44'),
(865, 'accept_report', 41, 12, '180.243.4.95', '118.99.81.187', 'Admin Rukitateki (playerid=0, IP=180.243.4.95) accept report from Samuel Ramirez (playerid=3, IP=118.99.81.187). Report message', '2022-09-15 06:02:33'),
(866, 'accept_report', 41, 340, '180.243.4.95', '125.164.23.188', 'Admin Rukitateki (playerid=0, IP=180.243.4.95) accept report from Berlin Giovano (playerid=2, IP=125.164.23.188). Report messag', '2022-09-15 06:03:07'),
(867, 'accept_report', 41, 340, '180.243.4.95', '125.164.17.108', 'Admin Rukitateki (playerid=0, IP=180.243.4.95) accept report from Berlin Giovano (playerid=1, IP=125.164.17.108). Report messag', '2022-09-15 06:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `admin_duty_times`
--

CREATE TABLE `admin_duty_times` (
  `id` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_duty_times`
--

INSERT INTO `admin_duty_times` (`id`, `account`, `started_at`, `ended_at`, `created_at`, `updated_at`) VALUES
(1, 10, '2022-09-10 10:25:22', '2022-09-10 10:33:18', '2022-09-10 10:25:22', '2022-09-10 10:33:18'),
(2, 10, '2022-09-10 10:33:19', '2022-09-10 10:46:08', '2022-09-10 10:33:19', '2022-09-10 10:46:08'),
(3, 19, '2022-09-10 10:41:06', '2022-09-10 10:41:55', '2022-09-10 10:41:06', '2022-09-10 10:41:55'),
(4, 19, '2022-09-10 10:42:49', '2022-09-10 10:57:02', '2022-09-10 10:42:49', '2022-09-10 10:57:02'),
(5, 10, '2022-09-10 10:46:09', '2022-09-10 10:49:59', '2022-09-10 10:46:09', '2022-09-10 10:49:59'),
(6, 19, '2022-09-10 11:07:37', '2022-09-10 11:09:27', '2022-09-10 11:07:37', '2022-09-10 11:09:27'),
(7, 41, '2022-09-10 11:07:56', '2022-09-10 11:09:27', '2022-09-10 11:07:56', '2022-09-10 11:09:27'),
(8, 19, '2022-09-10 11:11:52', '2022-09-10 11:16:12', '2022-09-10 11:11:52', '2022-09-10 11:16:12'),
(9, 41, '2022-09-10 11:12:49', '2022-09-10 11:19:03', '2022-09-10 11:12:49', '2022-09-10 11:19:03'),
(10, 19, '2022-09-10 11:17:24', '2022-09-10 11:23:53', '2022-09-10 11:17:24', '2022-09-10 11:23:53'),
(11, 41, '2022-09-10 11:20:16', '2022-09-10 11:25:06', '2022-09-10 11:20:16', '2022-09-10 11:25:06'),
(12, 41, '2022-09-10 11:25:45', '2022-09-10 11:26:33', '2022-09-10 11:25:45', '2022-09-10 11:26:33'),
(13, 19, '2022-09-10 11:30:54', '2022-09-10 11:34:45', '2022-09-10 11:30:54', '2022-09-10 11:34:45'),
(14, 19, '2022-09-10 11:35:24', '2022-09-10 11:35:40', '2022-09-10 11:35:24', '2022-09-10 11:35:40'),
(15, 10, '2022-09-10 11:35:30', '2022-09-10 11:37:26', '2022-09-10 11:35:30', '2022-09-10 11:37:26'),
(16, 19, '2022-09-10 11:37:25', '2022-09-10 11:37:29', '2022-09-10 11:37:25', '2022-09-10 11:37:29'),
(17, 41, '2022-09-10 11:39:30', '2022-09-10 11:41:28', '2022-09-10 11:39:30', '2022-09-10 11:41:28'),
(18, 19, '2022-09-10 11:40:54', '2022-09-10 11:44:34', '2022-09-10 11:40:54', '2022-09-10 11:44:34'),
(19, 10, '2022-09-10 11:42:54', '2022-09-10 11:44:08', '2022-09-10 11:42:54', '2022-09-10 11:44:08'),
(20, 10, '2022-09-10 11:45:37', '2022-09-10 11:49:06', '2022-09-10 11:45:37', '2022-09-10 11:49:06'),
(21, 41, '2022-09-10 11:48:07', '2022-09-10 12:57:41', '2022-09-10 11:48:07', '2022-09-10 12:57:41'),
(22, 19, '2022-09-10 11:50:07', '2022-09-10 12:29:18', '2022-09-10 11:50:07', '2022-09-10 12:29:18'),
(23, 10, '2022-09-10 11:53:53', '2022-09-10 11:59:22', '2022-09-10 11:53:53', '2022-09-10 11:59:22'),
(24, 10, '2022-09-10 11:59:35', '2022-09-10 12:01:29', '2022-09-10 11:59:35', '2022-09-10 12:01:29'),
(25, 19, '2022-09-10 12:32:03', '2022-09-10 13:14:08', '2022-09-10 12:32:03', '2022-09-10 13:14:08'),
(26, 68, '2022-09-10 12:54:38', '2022-09-10 12:57:32', '2022-09-10 12:54:38', '2022-09-10 12:57:32'),
(27, 19, '2022-09-10 13:27:35', '2022-09-10 13:28:57', '2022-09-10 13:27:35', '2022-09-10 13:28:57'),
(28, 19, '2022-09-10 13:40:01', '2022-09-10 13:56:24', '2022-09-10 13:40:01', '2022-09-10 13:56:24'),
(29, 10, '2022-09-10 13:59:05', '2022-09-10 14:03:55', '2022-09-10 13:59:05', '2022-09-10 14:03:55'),
(30, 10, '2022-09-10 14:04:17', '2022-09-10 14:05:30', '2022-09-10 14:04:17', '2022-09-10 14:05:30'),
(31, 155, '2022-09-10 14:29:17', '2022-09-10 14:38:52', '2022-09-10 14:29:17', '2022-09-10 14:38:52'),
(32, 41, '2022-09-10 14:29:49', '2022-09-10 14:29:54', '2022-09-10 14:29:49', '2022-09-10 14:29:54'),
(33, 41, '2022-09-10 14:38:43', '2022-09-10 14:39:53', '2022-09-10 14:38:43', '2022-09-10 14:39:53'),
(34, 86, '2022-09-10 15:57:19', '2022-09-10 16:31:15', '2022-09-10 15:57:19', '2022-09-10 16:31:15'),
(35, 86, '2022-09-10 16:51:16', '2022-09-10 18:14:22', '2022-09-10 16:51:16', '2022-09-10 18:14:22'),
(36, 41, '2022-09-10 17:41:14', '2022-09-10 18:31:28', '2022-09-10 17:41:14', '2022-09-10 18:31:28'),
(37, 86, '2022-09-10 18:39:00', '2022-09-10 19:01:04', '2022-09-10 18:39:00', '2022-09-10 19:01:04'),
(38, 41, '2022-09-10 18:55:05', '2022-09-10 19:01:04', '2022-09-10 18:55:05', '2022-09-10 19:01:04'),
(39, 41, '2022-09-10 19:03:03', '2022-09-10 19:03:04', '2022-09-10 19:03:03', '2022-09-10 19:03:04'),
(40, 41, '2022-09-10 19:05:47', '2022-09-10 19:55:15', '2022-09-10 19:05:47', '2022-09-10 19:55:15'),
(41, 86, '2022-09-10 19:28:21', '2022-09-10 20:33:50', '2022-09-10 19:28:21', '2022-09-10 20:33:50'),
(42, 19, '2022-09-11 01:13:47', '2022-09-11 01:25:15', '2022-09-11 01:13:47', '2022-09-11 01:25:15'),
(43, 68, '2022-09-11 01:19:12', '2022-09-11 01:19:42', '2022-09-11 01:19:12', '2022-09-11 01:19:42'),
(44, 68, '2022-09-11 01:23:54', '2022-09-11 01:25:22', '2022-09-11 01:23:54', '2022-09-11 01:25:22'),
(45, 19, '2022-09-11 01:27:49', '2022-09-11 04:15:55', '2022-09-11 01:27:49', '2022-09-11 04:15:55'),
(46, 68, '2022-09-11 01:28:31', '2022-09-11 04:25:58', '2022-09-11 01:28:31', '2022-09-11 04:25:58'),
(47, 41, '2022-09-11 02:07:00', '2022-09-11 02:33:27', '2022-09-11 02:07:00', '2022-09-11 02:33:27'),
(48, 41, '2022-09-11 02:34:09', '2022-09-11 03:12:42', '2022-09-11 02:34:09', '2022-09-11 03:12:42'),
(49, 41, '2022-09-11 03:15:14', '2022-09-11 03:25:04', '2022-09-11 03:15:14', '2022-09-11 03:25:04'),
(50, 41, '2022-09-11 03:28:25', '2022-09-11 04:45:13', '2022-09-11 03:28:25', '2022-09-11 04:45:13'),
(51, 155, '2022-09-11 04:02:42', '2022-09-11 04:04:10', '2022-09-11 04:02:42', '2022-09-11 04:04:10'),
(52, 155, '2022-09-11 04:06:34', '2022-09-11 04:14:15', '2022-09-11 04:06:34', '2022-09-11 04:14:15'),
(53, 155, '2022-09-11 04:14:58', '2022-09-11 04:18:51', '2022-09-11 04:14:58', '2022-09-11 04:18:51'),
(54, 19, '2022-09-11 04:18:21', '2022-09-11 04:36:18', '2022-09-11 04:18:21', '2022-09-11 04:36:18'),
(55, 19, '2022-09-11 04:42:29', '2022-09-11 04:52:48', '2022-09-11 04:42:29', '2022-09-11 04:52:48'),
(56, 41, '2022-09-11 04:45:59', '2022-09-11 05:03:16', '2022-09-11 04:45:59', '2022-09-11 05:03:16'),
(57, 19, '2022-09-11 04:58:18', '2022-09-11 05:53:15', '2022-09-11 04:58:18', '2022-09-11 05:53:15'),
(58, 86, '2022-09-11 05:33:32', '2022-09-11 05:37:33', '2022-09-11 05:33:32', '2022-09-11 05:37:33'),
(59, 86, '2022-09-11 05:37:37', '2022-09-11 06:24:16', '2022-09-11 05:37:37', '2022-09-11 06:24:16'),
(60, 19, '2022-09-11 05:59:29', '2022-09-11 06:04:29', '2022-09-11 05:59:29', '2022-09-11 06:04:29'),
(61, 19, '2022-09-11 06:15:48', '2022-09-11 06:24:08', '2022-09-11 06:15:48', '2022-09-11 06:24:08'),
(62, 86, '2022-09-11 06:28:36', '2022-09-11 06:29:00', '2022-09-11 06:28:36', '2022-09-11 06:29:00'),
(63, 19, '2022-09-11 06:39:59', '2022-09-11 06:41:57', '2022-09-11 06:39:59', '2022-09-11 06:41:57'),
(64, 19, '2022-09-11 06:45:11', '2022-09-11 06:45:48', '2022-09-11 06:45:11', '2022-09-11 06:45:48'),
(65, 86, '2022-09-11 06:53:25', '2022-09-11 07:03:24', '2022-09-11 06:53:25', '2022-09-11 07:03:24'),
(66, 108, '2022-09-11 07:14:10', '2022-09-11 07:55:31', '2022-09-11 07:14:10', '2022-09-11 07:55:31'),
(67, 19, '2022-09-11 07:17:10', '2022-09-11 07:26:37', '2022-09-11 07:17:10', '2022-09-11 07:26:37'),
(68, 19, '2022-09-11 07:51:59', '2022-09-11 08:06:18', '2022-09-11 07:51:59', '2022-09-11 08:06:18'),
(69, 10, '2022-09-11 08:00:21', '2022-09-11 08:03:37', '2022-09-11 08:00:21', '2022-09-11 08:03:37'),
(70, 19, '2022-09-11 08:07:02', '2022-09-11 08:15:43', '2022-09-11 08:07:02', '2022-09-11 08:15:43'),
(71, 108, '2022-09-11 08:51:51', '2022-09-11 08:57:14', '2022-09-11 08:51:51', '2022-09-11 08:57:14'),
(72, 86, '2022-09-11 09:01:45', '2022-09-11 09:05:07', '2022-09-11 09:01:45', '2022-09-11 09:05:07'),
(73, 86, '2022-09-11 09:21:34', '2022-09-11 09:24:51', '2022-09-11 09:21:34', '2022-09-11 09:24:51'),
(74, 86, '2022-09-11 09:51:31', '2022-09-11 09:54:33', '2022-09-11 09:51:31', '2022-09-11 09:54:33'),
(75, 86, '2022-09-11 10:00:09', '2022-09-11 10:00:38', '2022-09-11 10:00:09', '2022-09-11 10:00:38'),
(76, 86, '2022-09-11 10:06:34', '2022-09-11 10:13:28', '2022-09-11 10:06:34', '2022-09-11 10:13:28'),
(77, 86, '2022-09-11 10:22:10', '2022-09-11 10:27:35', '2022-09-11 10:22:10', '2022-09-11 10:27:35'),
(78, 41, '2022-09-11 10:57:15', '2022-09-11 10:58:23', '2022-09-11 10:57:15', '2022-09-11 10:58:23'),
(79, 41, '2022-09-11 10:58:25', '2022-09-11 10:58:26', '2022-09-11 10:58:25', '2022-09-11 10:58:26'),
(80, 19, '2022-09-11 11:20:11', '2022-09-11 11:33:19', '2022-09-11 11:20:11', '2022-09-11 11:33:19'),
(81, 19, '2022-09-11 11:33:57', '2022-09-11 11:42:20', '2022-09-11 11:33:57', '2022-09-11 11:42:20'),
(82, 41, '2022-09-11 11:42:49', '2022-09-11 11:50:14', '2022-09-11 11:42:49', '2022-09-11 11:50:14'),
(83, 19, '2022-09-11 11:46:50', '2022-09-11 12:24:17', '2022-09-11 11:46:50', '2022-09-11 12:24:17'),
(84, 41, '2022-09-11 11:55:35', '2022-09-11 11:56:24', '2022-09-11 11:55:35', '2022-09-11 11:56:24'),
(85, 86, '2022-09-11 12:15:39', '2022-09-11 12:40:52', '2022-09-11 12:15:39', '2022-09-11 12:40:52'),
(86, 19, '2022-09-11 12:29:04', '2022-09-11 12:29:25', '2022-09-11 12:29:04', '2022-09-11 12:29:25'),
(87, 19, '2022-09-11 12:43:14', '2022-09-11 12:47:14', '2022-09-11 12:43:14', '2022-09-11 12:47:14'),
(88, 86, '2022-09-11 13:37:38', '2022-09-11 13:39:05', '2022-09-11 13:37:38', '2022-09-11 13:39:05'),
(89, 86, '2022-09-11 13:47:32', '2022-09-11 16:27:27', '2022-09-11 13:47:32', '2022-09-11 16:27:27'),
(90, 86, '2022-09-11 16:37:43', '2022-09-11 16:45:25', '2022-09-11 16:37:43', '2022-09-11 16:45:25'),
(91, 136, '2022-09-11 16:38:24', '2022-09-11 16:52:12', '2022-09-11 16:38:24', '2022-09-11 16:52:12'),
(92, 28, '2022-09-11 16:40:24', '2022-09-11 16:48:06', '2022-09-11 16:40:24', '2022-09-11 16:48:06'),
(93, 161, '2022-09-11 16:45:44', '2022-09-11 17:07:51', '2022-09-11 16:45:44', '2022-09-11 17:07:51'),
(94, 28, '2022-09-11 16:49:13', '2022-09-11 16:53:49', '2022-09-11 16:49:13', '2022-09-11 16:53:49'),
(95, 28, '2022-09-11 16:54:15', '2022-09-11 17:22:10', '2022-09-11 16:54:15', '2022-09-11 17:22:10'),
(96, 169, '2022-09-11 16:58:55', '2022-09-11 16:59:05', '2022-09-11 16:58:55', '2022-09-11 16:59:05'),
(97, 77, '2022-09-11 17:02:04', '2022-09-11 17:46:05', '2022-09-11 17:02:04', '2022-09-11 17:46:05'),
(98, 41, '2022-09-11 17:03:51', '2022-09-11 17:32:47', '2022-09-11 17:03:51', '2022-09-11 17:32:47'),
(99, 169, '2022-09-11 17:17:11', '2022-09-11 17:20:06', '2022-09-11 17:17:11', '2022-09-11 17:20:06'),
(100, 169, '2022-09-11 17:21:04', '2022-09-11 17:28:26', '2022-09-11 17:21:04', '2022-09-11 17:28:26'),
(101, 43, '2022-09-11 17:28:02', '2022-09-11 17:29:58', '2022-09-11 17:28:02', '2022-09-11 17:29:58'),
(102, 169, '2022-09-11 17:29:40', '2022-09-11 17:30:27', '2022-09-11 17:29:40', '2022-09-11 17:30:27'),
(103, 43, '2022-09-11 17:30:14', '2022-09-11 17:41:05', '2022-09-11 17:30:14', '2022-09-11 17:41:05'),
(104, 28, '2022-09-11 17:31:57', '2022-09-11 17:41:02', '2022-09-11 17:31:57', '2022-09-11 17:41:02'),
(105, 136, '2022-09-11 17:33:36', '2022-09-11 17:45:33', '2022-09-11 17:33:36', '2022-09-11 17:45:33'),
(106, 41, '2022-09-11 17:34:30', '2022-09-11 17:37:49', '2022-09-11 17:34:30', '2022-09-11 17:37:49'),
(107, 41, '2022-09-11 17:43:04', '2022-09-11 17:45:43', '2022-09-11 17:43:04', '2022-09-11 17:45:43'),
(108, 43, '2022-09-11 17:43:13', '2022-09-11 18:06:50', '2022-09-11 17:43:13', '2022-09-11 18:06:50'),
(109, 28, '2022-09-11 17:54:07', '2022-09-11 18:09:23', '2022-09-11 17:54:07', '2022-09-11 18:09:23'),
(110, 86, '2022-09-11 17:54:13', '2022-09-11 18:26:01', '2022-09-11 17:54:13', '2022-09-11 18:26:01'),
(111, 41, '2022-09-11 17:54:39', '2022-09-11 17:55:58', '2022-09-11 17:54:39', '2022-09-11 17:55:58'),
(112, 41, '2022-09-11 18:06:58', '2022-09-11 18:08:01', '2022-09-11 18:06:58', '2022-09-11 18:08:01'),
(113, 43, '2022-09-11 18:07:58', '2022-09-11 18:16:56', '2022-09-11 18:07:58', '2022-09-11 18:16:56'),
(114, 41, '2022-09-11 18:30:25', '2022-09-11 19:59:17', '2022-09-11 18:30:25', '2022-09-11 19:59:17'),
(115, 28, '2022-09-11 18:30:54', '2022-09-11 18:40:14', '2022-09-11 18:30:54', '2022-09-11 18:40:14'),
(116, 28, '2022-09-11 18:43:10', '2022-09-11 18:48:31', '2022-09-11 18:43:10', '2022-09-11 18:48:31'),
(117, 136, '2022-09-11 19:14:53', '2022-09-11 19:36:00', '2022-09-11 19:14:53', '2022-09-11 19:36:00'),
(118, 155, '2022-09-11 19:28:55', '2022-09-11 20:21:49', '2022-09-11 19:28:55', '2022-09-11 20:21:49'),
(119, 136, '2022-09-11 19:49:46', '2022-09-11 19:50:16', '2022-09-11 19:49:46', '2022-09-11 19:50:16'),
(120, 41, '2022-09-11 19:59:29', '2022-09-11 20:10:59', '2022-09-11 19:59:29', '2022-09-11 20:10:59'),
(121, 41, '2022-09-11 20:11:02', '2022-09-11 20:13:41', '2022-09-11 20:11:02', '2022-09-11 20:13:41'),
(122, 41, '2022-09-11 20:13:48', '2022-09-11 20:14:14', '2022-09-11 20:13:48', '2022-09-11 20:14:14'),
(123, 41, '2022-09-11 20:17:52', '2022-09-11 20:18:15', '2022-09-11 20:17:52', '2022-09-11 20:18:15'),
(124, 41, '2022-09-11 20:22:55', '2022-09-11 20:25:00', '2022-09-11 20:22:55', '2022-09-11 20:25:00'),
(125, 136, '2022-09-11 21:37:06', '2022-09-11 21:46:44', '2022-09-11 21:37:06', '2022-09-11 21:46:44'),
(126, 41, '2022-09-11 21:39:09', '2022-09-11 22:15:22', '2022-09-11 21:39:09', '2022-09-11 22:15:22'),
(127, 108, '2022-09-11 23:20:18', '2022-09-11 23:44:30', '2022-09-11 23:20:18', '2022-09-11 23:44:30'),
(128, 136, '2022-09-12 00:31:48', '2022-09-12 00:43:57', '2022-09-12 00:31:48', '2022-09-12 00:43:57'),
(129, 136, '2022-09-12 00:49:41', '2022-09-12 00:55:19', '2022-09-12 00:49:41', '2022-09-12 00:55:19'),
(130, 136, '2022-09-12 00:56:39', '2022-09-12 01:01:11', '2022-09-12 00:56:39', '2022-09-12 01:01:11'),
(131, 28, '2022-09-12 01:06:51', '2022-09-12 01:25:27', '2022-09-12 01:06:51', '2022-09-12 01:25:27'),
(132, 28, '2022-09-12 01:39:57', '2022-09-12 01:42:14', '2022-09-12 01:39:57', '2022-09-12 01:42:14'),
(133, 28, '2022-09-12 01:46:06', '2022-09-12 01:46:48', '2022-09-12 01:46:06', '2022-09-12 01:46:48'),
(134, 28, '2022-09-12 01:53:25', '2022-09-12 01:54:44', '2022-09-12 01:53:25', '2022-09-12 01:54:44'),
(135, 43, '2022-09-12 02:11:16', '2022-09-12 02:43:25', '2022-09-12 02:11:16', '2022-09-12 02:43:25'),
(136, 43, '2022-09-12 02:59:30', '2022-09-12 02:59:38', '2022-09-12 02:59:30', '2022-09-12 02:59:38'),
(137, 28, '2022-09-12 03:30:42', '2022-09-12 03:33:10', '2022-09-12 03:30:42', '2022-09-12 03:33:10'),
(138, 136, '2022-09-12 03:32:18', '2022-09-12 03:59:50', '2022-09-12 03:32:18', '2022-09-12 03:59:50'),
(139, 28, '2022-09-12 03:34:42', '2022-09-12 03:38:37', '2022-09-12 03:34:42', '2022-09-12 03:38:37'),
(140, 28, '2022-09-12 03:47:08', '2022-09-12 04:19:18', '2022-09-12 03:47:08', '2022-09-12 04:19:18'),
(141, 43, '2022-09-12 03:56:10', '2022-09-12 04:20:48', '2022-09-12 03:56:10', '2022-09-12 04:20:48'),
(142, 136, '2022-09-12 04:08:26', '2022-09-12 04:09:24', '2022-09-12 04:08:26', '2022-09-12 04:09:24'),
(143, 28, '2022-09-12 04:19:55', '2022-09-12 04:23:42', '2022-09-12 04:19:55', '2022-09-12 04:23:42'),
(144, 43, '2022-09-12 04:23:10', '2022-09-12 04:32:35', '2022-09-12 04:23:10', '2022-09-12 04:32:35'),
(145, 136, '2022-09-12 04:33:58', '2022-09-12 04:39:32', '2022-09-12 04:33:58', '2022-09-12 04:39:32'),
(146, 136, '2022-09-12 04:39:56', '2022-09-12 04:49:32', '2022-09-12 04:39:56', '2022-09-12 04:49:32'),
(147, 43, '2022-09-12 04:41:20', '2022-09-12 04:41:46', '2022-09-12 04:41:20', '2022-09-12 04:41:46'),
(148, 28, '2022-09-12 04:41:33', '2022-09-12 04:42:11', '2022-09-12 04:41:33', '2022-09-12 04:42:11'),
(149, 43, '2022-09-12 04:46:18', '2022-09-12 04:53:32', '2022-09-12 04:46:18', '2022-09-12 04:53:32'),
(150, 43, '2022-09-12 04:57:09', '2022-09-12 05:17:33', '2022-09-12 04:57:09', '2022-09-12 05:17:33'),
(151, 86, '2022-09-12 05:08:28', '2022-09-12 05:17:31', '2022-09-12 05:08:28', '2022-09-12 05:17:31'),
(152, 136, '2022-09-12 05:32:33', '2022-09-12 05:36:42', '2022-09-12 05:32:33', '2022-09-12 05:36:42'),
(153, 28, '2022-09-12 05:39:23', '2022-09-12 05:39:43', '2022-09-12 05:39:23', '2022-09-12 05:39:43'),
(154, 43, '2022-09-12 06:01:04', '2022-09-12 06:16:47', '2022-09-12 06:01:04', '2022-09-12 06:16:47'),
(155, 43, '2022-09-12 06:21:41', '2022-09-12 06:56:38', '2022-09-12 06:21:41', '2022-09-12 06:56:38'),
(156, 28, '2022-09-12 06:23:03', '2022-09-12 06:24:55', '2022-09-12 06:23:03', '2022-09-12 06:24:55'),
(157, 28, '2022-09-12 06:25:00', '2022-09-12 06:33:47', '2022-09-12 06:25:00', '2022-09-12 06:33:47'),
(158, 136, '2022-09-12 06:40:22', '2022-09-12 06:45:54', '2022-09-12 06:40:22', '2022-09-12 06:45:54'),
(159, 86, '2022-09-12 06:42:03', '2022-09-12 06:45:40', '2022-09-12 06:42:03', '2022-09-12 06:45:40'),
(160, 136, '2022-09-12 06:49:11', '2022-09-12 06:52:43', '2022-09-12 06:49:11', '2022-09-12 06:52:43'),
(161, 136, '2022-09-12 06:55:54', '2022-09-12 07:06:31', '2022-09-12 06:55:54', '2022-09-12 07:06:31'),
(162, 136, '2022-09-12 07:21:07', '2022-09-12 07:22:42', '2022-09-12 07:21:07', '2022-09-12 07:22:42'),
(163, 41, '2022-09-12 07:36:11', '2022-09-12 07:45:37', '2022-09-12 07:36:11', '2022-09-12 07:45:37'),
(164, 28, '2022-09-12 07:46:09', '2022-09-12 07:55:47', '2022-09-12 07:46:09', '2022-09-12 07:55:47'),
(165, 41, '2022-09-12 07:53:49', '2022-09-12 07:54:33', '2022-09-12 07:53:49', '2022-09-12 07:54:33'),
(166, 28, '2022-09-12 07:56:09', '2022-09-12 08:07:32', '2022-09-12 07:56:09', '2022-09-12 08:07:32'),
(167, 41, '2022-09-12 08:15:54', '2022-09-12 08:18:31', '2022-09-12 08:15:54', '2022-09-12 08:18:31'),
(168, 41, '2022-09-12 08:20:29', '2022-09-12 08:25:32', '2022-09-12 08:20:29', '2022-09-12 08:25:32'),
(169, 86, '2022-09-12 08:22:03', '2022-09-12 08:22:46', '2022-09-12 08:22:03', '2022-09-12 08:22:46'),
(170, 41, '2022-09-12 08:26:12', '2022-09-12 08:30:32', '2022-09-12 08:26:12', '2022-09-12 08:30:32'),
(171, 41, '2022-09-12 08:30:40', '2022-09-12 08:45:50', '2022-09-12 08:30:40', '2022-09-12 08:45:50'),
(172, 136, '2022-09-12 08:35:17', '2022-09-12 08:53:43', '2022-09-12 08:35:17', '2022-09-12 08:53:43'),
(173, 28, '2022-09-12 08:53:47', '2022-09-12 08:57:44', '2022-09-12 08:53:47', '2022-09-12 08:57:44'),
(174, 136, '2022-09-12 08:53:55', '2022-09-12 09:31:38', '2022-09-12 08:53:55', '2022-09-12 09:31:38'),
(175, 41, '2022-09-12 09:05:55', '2022-09-12 09:15:07', '2022-09-12 09:05:55', '2022-09-12 09:15:07'),
(176, 41, '2022-09-12 09:15:14', '2022-09-12 09:30:23', '2022-09-12 09:15:14', '2022-09-12 09:30:23'),
(177, 169, '2022-09-12 09:34:35', '2022-09-12 09:43:00', '2022-09-12 09:34:35', '2022-09-12 09:43:00'),
(178, 28, '2022-09-12 09:37:33', '2022-09-12 09:39:40', '2022-09-12 09:37:33', '2022-09-12 09:39:40'),
(179, 28, '2022-09-12 09:39:41', '2022-09-12 09:43:38', '2022-09-12 09:39:41', '2022-09-12 09:43:38'),
(180, 28, '2022-09-12 09:45:45', '2022-09-12 09:48:19', '2022-09-12 09:45:45', '2022-09-12 09:48:19'),
(181, 169, '2022-09-12 09:52:02', '2022-09-12 10:04:05', '2022-09-12 09:52:02', '2022-09-12 10:04:05'),
(182, 169, '2022-09-12 10:05:22', '2022-09-12 10:35:49', '2022-09-12 10:05:22', '2022-09-12 10:35:49'),
(183, 28, '2022-09-12 10:12:33', '2022-09-12 10:13:22', '2022-09-12 10:12:33', '2022-09-12 10:13:22'),
(184, 28, '2022-09-12 10:40:35', '2022-09-12 10:41:23', '2022-09-12 10:40:35', '2022-09-12 10:41:23'),
(185, 28, '2022-09-12 10:43:25', '2022-09-12 10:53:07', '2022-09-12 10:43:25', '2022-09-12 10:53:07'),
(186, 169, '2022-09-12 10:46:05', '2022-09-12 10:52:34', '2022-09-12 10:46:05', '2022-09-12 10:52:34'),
(187, 86, '2022-09-12 10:46:16', '2022-09-12 10:53:39', '2022-09-12 10:46:16', '2022-09-12 10:53:39'),
(188, 28, '2022-09-12 10:53:44', '2022-09-12 11:20:55', '2022-09-12 10:53:44', '2022-09-12 11:20:55'),
(189, 41, '2022-09-12 11:49:11', '2022-09-12 11:50:40', '2022-09-12 11:49:11', '2022-09-12 11:50:40'),
(190, 136, '2022-09-12 11:55:10', '2022-09-12 12:12:54', '2022-09-12 11:55:10', '2022-09-12 12:12:54'),
(191, 136, '2022-09-12 12:29:50', '2022-09-12 12:42:48', '2022-09-12 12:29:50', '2022-09-12 12:42:48'),
(192, 28, '2022-09-12 12:29:51', '2022-09-12 12:30:40', '2022-09-12 12:29:51', '2022-09-12 12:30:40'),
(193, 86, '2022-09-12 12:53:23', '2022-09-12 12:53:56', '2022-09-12 12:53:23', '2022-09-12 12:53:56'),
(194, 136, '2022-09-12 12:55:14', '2022-09-12 12:59:18', '2022-09-12 12:55:14', '2022-09-12 12:59:18'),
(195, 86, '2022-09-12 12:57:48', '2022-09-12 12:59:04', '2022-09-12 12:57:48', '2022-09-12 12:59:04'),
(196, 19, '2022-09-12 13:12:57', '2022-09-12 13:14:49', '2022-09-12 13:12:57', '2022-09-12 13:14:49'),
(197, 28, '2022-09-12 13:28:41', '2022-09-12 13:29:10', '2022-09-12 13:28:41', '2022-09-12 13:29:10'),
(198, 19, '2022-09-12 13:29:16', '2022-09-12 13:38:20', '2022-09-12 13:29:16', '2022-09-12 13:38:20'),
(199, 136, '2022-09-12 13:29:48', '2022-09-12 13:38:20', '2022-09-12 13:29:48', '2022-09-12 13:38:20'),
(200, 28, '2022-09-12 13:30:12', '2022-09-12 13:38:20', '2022-09-12 13:30:12', '2022-09-12 13:38:20'),
(201, 28, '2022-09-12 14:06:09', '2022-09-12 14:12:04', '2022-09-12 14:06:09', '2022-09-12 14:12:04'),
(202, 28, '2022-09-12 14:12:10', '2022-09-12 14:16:29', '2022-09-12 14:12:10', '2022-09-12 14:16:29'),
(203, 86, '2022-09-12 14:21:22', '2022-09-12 14:22:28', '2022-09-12 14:21:22', '2022-09-12 14:22:28'),
(204, 136, '2022-09-12 14:57:56', '2022-09-12 15:05:53', '2022-09-12 14:57:56', '2022-09-12 15:05:53'),
(205, 136, '2022-09-12 15:05:58', '2022-09-12 15:06:25', '2022-09-12 15:05:58', '2022-09-12 15:06:25'),
(206, 86, '2022-09-12 15:06:51', '2022-09-12 15:08:02', '2022-09-12 15:06:51', '2022-09-12 15:08:02'),
(207, 86, '2022-09-12 15:09:28', '2022-09-12 15:31:55', '2022-09-12 15:09:28', '2022-09-12 15:31:55'),
(208, 136, '2022-09-12 15:10:21', '2022-09-12 15:10:45', '2022-09-12 15:10:21', '2022-09-12 15:10:45'),
(209, 370, '2022-09-12 15:21:13', '2022-09-12 15:26:42', '2022-09-12 15:21:13', '2022-09-12 15:26:42'),
(210, 136, '2022-09-12 15:33:06', '2022-09-12 15:33:57', '2022-09-12 15:33:06', '2022-09-12 15:33:57'),
(211, 86, '2022-09-12 15:35:07', '2022-09-12 15:35:14', '2022-09-12 15:35:07', '2022-09-12 15:35:14'),
(212, 136, '2022-09-12 15:35:13', '2022-09-12 15:41:49', '2022-09-12 15:35:13', '2022-09-12 15:41:49'),
(213, 86, '2022-09-12 16:06:41', '2022-09-12 16:06:43', '2022-09-12 16:06:41', '2022-09-12 16:06:43'),
(214, 169, '2022-09-12 16:17:54', '2022-09-12 16:21:56', '2022-09-12 16:17:54', '2022-09-12 16:21:56'),
(215, 41, '2022-09-12 16:39:44', '2022-09-12 16:58:48', '2022-09-12 16:39:44', '2022-09-12 16:58:48'),
(216, 169, '2022-09-12 16:59:02', '2022-09-12 16:59:07', '2022-09-12 16:59:02', '2022-09-12 16:59:07'),
(217, 86, '2022-09-12 17:04:48', '2022-09-12 17:10:08', '2022-09-12 17:04:48', '2022-09-12 17:10:08'),
(218, 169, '2022-09-12 17:09:39', '2022-09-12 17:10:23', '2022-09-12 17:09:39', '2022-09-12 17:10:23'),
(219, 169, '2022-09-12 17:21:12', '2022-09-12 17:23:04', '2022-09-12 17:21:12', '2022-09-12 17:23:04'),
(220, 43, '2022-09-12 17:22:52', '2022-09-12 17:23:07', '2022-09-12 17:22:52', '2022-09-12 17:23:07'),
(221, 169, '2022-09-12 17:30:10', '2022-09-12 17:34:13', '2022-09-12 17:30:10', '2022-09-12 17:34:13'),
(222, 43, '2022-09-12 17:43:23', '2022-09-12 17:45:53', '2022-09-12 17:43:23', '2022-09-12 17:45:53'),
(223, 43, '2022-09-12 18:04:11', '2022-09-12 18:12:11', '2022-09-12 18:04:11', '2022-09-12 18:12:11'),
(224, 28, '2022-09-12 18:05:25', '2022-09-12 18:06:46', '2022-09-12 18:05:25', '2022-09-12 18:06:46'),
(225, 28, '2022-09-12 18:21:54', '2022-09-12 18:25:31', '2022-09-12 18:21:54', '2022-09-12 18:25:31'),
(226, 43, '2022-09-12 18:24:39', '2022-09-12 18:28:29', '2022-09-12 18:24:39', '2022-09-12 18:28:29'),
(227, 28, '2022-09-12 18:48:07', '2022-09-12 18:51:20', '2022-09-12 18:48:07', '2022-09-12 18:51:20'),
(228, 155, '2022-09-12 18:58:23', '2022-09-12 19:14:07', '2022-09-12 18:58:23', '2022-09-12 19:14:07'),
(229, 28, '2022-09-12 19:46:29', '2022-09-13 00:24:06', '2022-09-12 19:46:29', '2022-09-13 00:24:06'),
(230, 28, '2022-09-13 01:02:13', '2022-09-13 01:24:09', '2022-09-13 01:02:13', '2022-09-13 01:24:09'),
(231, 28, '2022-09-13 01:30:06', '2022-09-13 01:49:55', '2022-09-13 01:30:06', '2022-09-13 01:49:55'),
(232, 161, '2022-09-13 01:38:50', '2022-09-13 01:51:03', '2022-09-13 01:38:50', '2022-09-13 01:51:03'),
(233, 28, '2022-09-13 01:51:54', '2022-09-13 02:11:32', '2022-09-13 01:51:54', '2022-09-13 02:11:32'),
(234, 28, '2022-09-13 02:11:41', '2022-09-13 02:41:24', '2022-09-13 02:11:41', '2022-09-13 02:41:24'),
(235, 28, '2022-09-13 02:47:05', '2022-09-13 02:53:26', '2022-09-13 02:47:05', '2022-09-13 02:53:26'),
(236, 77, '2022-09-13 02:54:07', '2022-09-13 03:02:06', '2022-09-13 02:54:07', '2022-09-13 03:02:06'),
(237, 136, '2022-09-13 03:24:44', '2022-09-13 03:27:00', '2022-09-13 03:24:44', '2022-09-13 03:27:00'),
(238, 77, '2022-09-13 03:51:54', '2022-09-13 03:59:09', '2022-09-13 03:51:54', '2022-09-13 03:59:09'),
(239, 161, '2022-09-13 04:33:01', '2022-09-13 04:35:48', '2022-09-13 04:33:01', '2022-09-13 04:35:48'),
(240, 43, '2022-09-13 04:47:11', '2022-09-13 04:47:25', '2022-09-13 04:47:11', '2022-09-13 04:47:25'),
(241, 136, '2022-09-13 05:02:02', '2022-09-13 05:04:30', '2022-09-13 05:02:02', '2022-09-13 05:04:30'),
(242, 136, '2022-09-13 05:27:14', '2022-09-13 05:39:22', '2022-09-13 05:27:14', '2022-09-13 05:39:22'),
(243, 136, '2022-09-13 05:40:59', '2022-09-13 05:59:56', '2022-09-13 05:40:59', '2022-09-13 05:59:56'),
(244, 43, '2022-09-13 06:03:52', '2022-09-13 06:05:34', '2022-09-13 06:03:52', '2022-09-13 06:05:34'),
(245, 43, '2022-09-13 06:06:14', '2022-09-13 06:11:13', '2022-09-13 06:06:14', '2022-09-13 06:11:13'),
(246, 136, '2022-09-13 06:06:32', '2022-09-13 06:11:25', '2022-09-13 06:06:32', '2022-09-13 06:11:25'),
(247, 41, '2022-09-13 06:07:08', '2022-09-13 06:28:51', '2022-09-13 06:07:08', '2022-09-13 06:28:51'),
(248, 43, '2022-09-13 06:12:04', '2022-09-13 06:15:04', '2022-09-13 06:12:04', '2022-09-13 06:15:04'),
(249, 43, '2022-09-13 06:35:28', '2022-09-13 06:36:56', '2022-09-13 06:35:28', '2022-09-13 06:36:56'),
(250, 41, '2022-09-13 06:48:44', '2022-09-13 06:50:58', '2022-09-13 06:48:44', '2022-09-13 06:50:58'),
(251, 41, '2022-09-13 06:57:21', '2022-09-13 06:57:45', '2022-09-13 06:57:21', '2022-09-13 06:57:45'),
(252, 169, '2022-09-13 07:04:34', '2022-09-13 07:10:22', '2022-09-13 07:04:34', '2022-09-13 07:10:22'),
(253, 41, '2022-09-13 07:15:36', '2022-09-13 07:18:39', '2022-09-13 07:15:36', '2022-09-13 07:18:39'),
(254, 41, '2022-09-13 07:22:11', '2022-09-13 07:54:31', '2022-09-13 07:22:11', '2022-09-13 07:54:31'),
(255, 86, '2022-09-13 07:35:44', '2022-09-13 07:35:56', '2022-09-13 07:35:44', '2022-09-13 07:35:56'),
(256, 86, '2022-09-13 07:39:39', '2022-09-13 07:39:46', '2022-09-13 07:39:39', '2022-09-13 07:39:46'),
(257, 136, '2022-09-13 07:46:40', '2022-09-13 08:20:26', '2022-09-13 07:46:40', '2022-09-13 08:20:26'),
(258, 86, '2022-09-13 07:55:24', '2022-09-13 07:56:12', '2022-09-13 07:55:24', '2022-09-13 07:56:12'),
(259, 41, '2022-09-13 08:05:14', '2022-09-13 09:29:53', '2022-09-13 08:05:14', '2022-09-13 09:29:53'),
(260, 136, '2022-09-13 08:53:09', '2022-09-13 08:55:21', '2022-09-13 08:53:09', '2022-09-13 08:55:21'),
(261, 136, '2022-09-13 08:56:02', '2022-09-13 09:05:14', '2022-09-13 08:56:02', '2022-09-13 09:05:14'),
(262, 136, '2022-09-13 09:07:49', '2022-09-13 09:13:38', '2022-09-13 09:07:49', '2022-09-13 09:13:38'),
(263, 43, '2022-09-13 09:11:21', '2022-09-13 09:11:44', '2022-09-13 09:11:21', '2022-09-13 09:11:44'),
(264, 86, '2022-09-13 09:20:01', '2022-09-13 09:21:59', '2022-09-13 09:20:01', '2022-09-13 09:21:59'),
(265, 136, '2022-09-13 09:22:20', '2022-09-13 09:26:57', '2022-09-13 09:22:20', '2022-09-13 09:26:57'),
(266, 28, '2022-09-13 09:22:24', '2022-09-13 09:29:24', '2022-09-13 09:22:24', '2022-09-13 09:29:24'),
(267, 28, '2022-09-13 09:29:48', '2022-09-13 09:37:29', '2022-09-13 09:29:48', '2022-09-13 09:37:29'),
(268, 43, '2022-09-13 09:30:12', '2022-09-13 09:36:28', '2022-09-13 09:30:12', '2022-09-13 09:36:28'),
(269, 136, '2022-09-13 09:37:03', '2022-09-13 09:47:54', '2022-09-13 09:37:03', '2022-09-13 09:47:54'),
(270, 28, '2022-09-13 09:37:53', '2022-09-13 09:55:50', '2022-09-13 09:37:53', '2022-09-13 09:55:50'),
(271, 41, '2022-09-13 09:42:38', '2022-09-13 09:46:34', '2022-09-13 09:42:38', '2022-09-13 09:46:34'),
(272, 19, '2022-09-13 09:57:45', '2022-09-13 09:58:48', '2022-09-13 09:57:45', '2022-09-13 09:58:48'),
(273, 28, '2022-09-13 09:59:49', '2022-09-13 10:29:55', '2022-09-13 09:59:49', '2022-09-13 10:29:55'),
(274, 19, '2022-09-13 10:18:13', '2022-09-13 10:21:17', '2022-09-13 10:18:13', '2022-09-13 10:21:17'),
(275, 19, '2022-09-13 10:32:19', '2022-09-13 10:32:35', '2022-09-13 10:32:19', '2022-09-13 10:32:35'),
(276, 19, '2022-09-13 10:34:29', '2022-09-13 10:47:50', '2022-09-13 10:34:29', '2022-09-13 10:47:50'),
(277, 28, '2022-09-13 10:37:14', '2022-09-13 10:37:37', '2022-09-13 10:37:14', '2022-09-13 10:37:37'),
(278, 28, '2022-09-13 10:40:57', '2022-09-13 10:41:54', '2022-09-13 10:40:57', '2022-09-13 10:41:54'),
(279, 28, '2022-09-13 10:43:04', '2022-09-13 11:03:14', '2022-09-13 10:43:04', '2022-09-13 11:03:14'),
(280, 136, '2022-09-13 10:52:34', '2022-09-13 10:58:55', '2022-09-13 10:52:34', '2022-09-13 10:58:55'),
(281, 28, '2022-09-13 11:04:50', '2022-09-13 11:07:40', '2022-09-13 11:04:50', '2022-09-13 11:07:40'),
(282, 28, '2022-09-13 11:12:57', '2022-09-13 11:16:11', '2022-09-13 11:12:57', '2022-09-13 11:16:11'),
(283, 28, '2022-09-13 11:26:27', '2022-09-13 11:52:38', '2022-09-13 11:26:27', '2022-09-13 11:52:38'),
(284, 136, '2022-09-13 11:30:20', '2022-09-13 11:39:32', '2022-09-13 11:30:20', '2022-09-13 11:39:32'),
(285, 77, '2022-09-13 11:44:56', '2022-09-13 11:50:46', '2022-09-13 11:44:56', '2022-09-13 11:50:46'),
(286, 136, '2022-09-13 11:53:06', '2022-09-13 12:00:33', '2022-09-13 11:53:06', '2022-09-13 12:00:33'),
(287, 28, '2022-09-13 12:31:16', '2022-09-13 12:32:23', '2022-09-13 12:31:16', '2022-09-13 12:32:23'),
(288, 28, '2022-09-13 12:49:08', '2022-09-13 12:52:04', '2022-09-13 12:49:08', '2022-09-13 12:52:04'),
(289, 28, '2022-09-13 12:52:31', '2022-09-13 13:02:16', '2022-09-13 12:52:31', '2022-09-13 13:02:16'),
(290, 169, '2022-09-13 12:53:45', '2022-09-13 12:55:07', '2022-09-13 12:53:45', '2022-09-13 12:55:07'),
(291, 169, '2022-09-13 13:00:39', '2022-09-13 13:00:53', '2022-09-13 13:00:39', '2022-09-13 13:00:53'),
(292, 28, '2022-09-13 13:03:10', '2022-09-13 13:11:10', '2022-09-13 13:03:10', '2022-09-13 13:11:10'),
(293, 28, '2022-09-13 13:11:14', '2022-09-13 13:37:21', '2022-09-13 13:11:14', '2022-09-13 13:37:21'),
(294, 169, '2022-09-13 13:12:26', '2022-09-13 13:17:36', '2022-09-13 13:12:26', '2022-09-13 13:17:36'),
(295, 43, '2022-09-13 13:25:07', '2022-09-13 13:38:57', '2022-09-13 13:25:07', '2022-09-13 13:38:57'),
(296, 86, '2022-09-13 13:32:42', '2022-09-13 13:48:51', '2022-09-13 13:32:42', '2022-09-13 13:48:51'),
(297, 136, '2022-09-13 13:50:21', '2022-09-13 13:52:59', '2022-09-13 13:50:21', '2022-09-13 13:52:59'),
(298, 136, '2022-09-13 13:58:08', '2022-09-13 14:13:17', '2022-09-13 13:58:08', '2022-09-13 14:13:17'),
(299, 161, '2022-09-13 14:01:37', '2022-09-13 14:02:49', '2022-09-13 14:01:37', '2022-09-13 14:02:49'),
(300, 43, '2022-09-13 14:11:03', '2022-09-13 14:20:30', '2022-09-13 14:11:03', '2022-09-13 14:20:30'),
(301, 136, '2022-09-13 14:21:07', '2022-09-13 14:23:18', '2022-09-13 14:21:07', '2022-09-13 14:23:18'),
(302, 43, '2022-09-13 14:21:38', '2022-09-13 14:22:06', '2022-09-13 14:21:38', '2022-09-13 14:22:06'),
(303, 43, '2022-09-13 14:22:44', '2022-09-13 14:27:04', '2022-09-13 14:22:44', '2022-09-13 14:27:04'),
(304, 43, '2022-09-13 14:28:00', '2022-09-13 14:40:34', '2022-09-13 14:28:00', '2022-09-13 14:40:34'),
(305, 136, '2022-09-13 14:42:14', '2022-09-13 14:51:10', '2022-09-13 14:42:14', '2022-09-13 14:51:10'),
(306, 43, '2022-09-13 14:42:18', '2022-09-13 14:56:05', '2022-09-13 14:42:18', '2022-09-13 14:56:05'),
(307, 28, '2022-09-13 14:42:59', '2022-09-13 15:10:26', '2022-09-13 14:42:59', '2022-09-13 15:10:26'),
(308, 43, '2022-09-13 14:59:27', '2022-09-13 15:11:14', '2022-09-13 14:59:27', '2022-09-13 15:11:14'),
(309, 28, '2022-09-13 15:31:35', '2022-09-13 15:33:41', '2022-09-13 15:31:35', '2022-09-13 15:33:41'),
(310, 136, '2022-09-13 15:50:38', '2022-09-13 15:59:03', '2022-09-13 15:50:38', '2022-09-13 15:59:03'),
(311, 43, '2022-09-13 15:58:34', '2022-09-13 16:25:55', '2022-09-13 15:58:34', '2022-09-13 16:25:55'),
(312, 28, '2022-09-13 16:09:14', '2022-09-13 16:37:44', '2022-09-13 16:09:14', '2022-09-13 16:37:44'),
(313, 41, '2022-09-13 16:26:15', '2022-09-13 17:04:26', '2022-09-13 16:26:15', '2022-09-13 17:04:26'),
(314, 43, '2022-09-13 16:29:17', '2022-09-13 16:30:54', '2022-09-13 16:29:17', '2022-09-13 16:30:54'),
(315, 43, '2022-09-13 16:30:57', '2022-09-13 17:23:23', '2022-09-13 16:30:57', '2022-09-13 17:23:23'),
(316, 28, '2022-09-13 16:40:06', '2022-09-13 16:43:13', '2022-09-13 16:40:06', '2022-09-13 16:43:13'),
(317, 86, '2022-09-13 16:58:02', '2022-09-13 17:22:25', '2022-09-13 16:58:02', '2022-09-13 17:22:25'),
(318, 28, '2022-09-13 17:04:12', '2022-09-13 17:12:06', '2022-09-13 17:04:12', '2022-09-13 17:12:06'),
(319, 41, '2022-09-13 17:05:14', '2022-09-13 17:34:51', '2022-09-13 17:05:14', '2022-09-13 17:34:51'),
(320, 136, '2022-09-13 17:14:51', '2022-09-13 17:20:08', '2022-09-13 17:14:51', '2022-09-13 17:20:08'),
(321, 28, '2022-09-13 17:19:34', '2022-09-13 17:29:48', '2022-09-13 17:19:34', '2022-09-13 17:29:48'),
(322, 136, '2022-09-13 17:21:32', '2022-09-13 17:26:05', '2022-09-13 17:21:32', '2022-09-13 17:26:05'),
(323, 28, '2022-09-13 17:29:56', '2022-09-13 17:32:47', '2022-09-13 17:29:56', '2022-09-13 17:32:47'),
(324, 86, '2022-09-13 17:33:18', '2022-09-13 17:33:31', '2022-09-13 17:33:18', '2022-09-13 17:33:31'),
(325, 28, '2022-09-13 18:56:03', '2022-09-13 18:57:07', '2022-09-13 18:56:03', '2022-09-13 18:57:07'),
(326, 28, '2022-09-13 19:29:37', '2022-09-13 19:33:10', '2022-09-13 19:29:37', '2022-09-13 19:33:10'),
(327, 136, '2022-09-13 23:19:13', '2022-09-13 23:20:08', '2022-09-13 23:19:13', '2022-09-13 23:20:08'),
(328, 136, '2022-09-14 00:56:10', '2022-09-14 01:13:10', '2022-09-14 00:56:10', '2022-09-14 01:13:10'),
(329, 136, '2022-09-14 01:14:19', '2022-09-14 01:20:19', '2022-09-14 01:14:19', '2022-09-14 01:20:19'),
(330, 136, '2022-09-14 01:21:57', '2022-09-14 01:33:10', '2022-09-14 01:21:57', '2022-09-14 01:33:10'),
(331, 136, '2022-09-14 01:33:25', '2022-09-14 01:43:17', '2022-09-14 01:33:25', '2022-09-14 01:43:17'),
(332, 136, '2022-09-14 02:18:22', '2022-09-14 02:23:55', '2022-09-14 02:18:22', '2022-09-14 02:23:55'),
(333, 136, '2022-09-14 02:58:38', '2022-09-14 03:01:33', '2022-09-14 02:58:38', '2022-09-14 03:01:33'),
(334, 136, '2022-09-14 03:14:41', '2022-09-14 03:26:53', '2022-09-14 03:14:41', '2022-09-14 03:26:53'),
(335, 28, '2022-09-14 03:17:56', '2022-09-14 03:21:00', '2022-09-14 03:17:56', '2022-09-14 03:21:00'),
(336, 28, '2022-09-14 03:21:31', '2022-09-14 03:34:17', '2022-09-14 03:21:31', '2022-09-14 03:34:17'),
(337, 41, '2022-09-14 05:15:44', '2022-09-14 05:28:55', '2022-09-14 05:15:44', '2022-09-14 05:28:55'),
(338, 136, '2022-09-14 05:46:38', '2022-09-14 05:57:28', '2022-09-14 05:46:38', '2022-09-14 05:57:28'),
(339, 28, '2022-09-14 05:46:46', '2022-09-14 05:58:31', '2022-09-14 05:46:46', '2022-09-14 05:58:31'),
(340, 28, '2022-09-14 06:04:56', '2022-09-14 06:06:07', '2022-09-14 06:04:56', '2022-09-14 06:06:07'),
(341, 136, '2022-09-14 06:06:05', '2022-09-14 06:09:25', '2022-09-14 06:06:05', '2022-09-14 06:09:25'),
(342, 28, '2022-09-14 06:18:37', '2022-09-14 06:18:55', '2022-09-14 06:18:37', '2022-09-14 06:18:55'),
(343, 43, '2022-09-14 06:29:58', '2022-09-14 06:55:50', '2022-09-14 06:29:58', '2022-09-14 06:55:50'),
(344, 86, '2022-09-14 06:37:28', '2022-09-14 07:42:37', '2022-09-14 06:37:28', '2022-09-14 07:42:37'),
(345, 155, '2022-09-14 06:49:43', '2022-09-14 07:42:37', '2022-09-14 06:49:43', '2022-09-14 07:42:37'),
(346, 28, '2022-09-14 07:53:20', '2022-09-14 07:58:13', '2022-09-14 07:53:20', '2022-09-14 07:58:13'),
(347, 43, '2022-09-14 08:02:43', '2022-09-14 08:05:08', '2022-09-14 08:02:43', '2022-09-14 08:05:08'),
(348, 28, '2022-09-14 08:04:49', '2022-09-14 08:13:36', '2022-09-14 08:04:49', '2022-09-14 08:13:36'),
(349, 28, '2022-09-14 08:18:10', '2022-09-14 08:22:12', '2022-09-14 08:18:10', '2022-09-14 08:22:12'),
(350, 28, '2022-09-14 08:24:15', '2022-09-14 08:27:26', '2022-09-14 08:24:15', '2022-09-14 08:27:26'),
(351, 43, '2022-09-14 08:32:30', '2022-09-14 08:33:03', '2022-09-14 08:32:30', '2022-09-14 08:33:03'),
(352, 28, '2022-09-14 08:50:31', '2022-09-14 08:51:27', '2022-09-14 08:50:31', '2022-09-14 08:51:27'),
(353, 28, '2022-09-14 09:00:22', '2022-09-14 09:02:09', '2022-09-14 09:00:22', '2022-09-14 09:02:09'),
(354, 41, '2022-09-14 09:26:42', '2022-09-14 10:22:22', '2022-09-14 09:26:42', '2022-09-14 10:22:22'),
(355, 28, '2022-09-14 09:40:15', '2022-09-14 09:48:12', '2022-09-14 09:40:15', '2022-09-14 09:48:12'),
(356, 136, '2022-09-14 09:49:56', '2022-09-14 09:54:43', '2022-09-14 09:49:56', '2022-09-14 09:54:43'),
(357, 43, '2022-09-14 10:25:48', '2022-09-14 10:26:08', '2022-09-14 10:25:48', '2022-09-14 10:26:08'),
(358, 136, '2022-09-14 10:29:30', '2022-09-14 10:32:30', '2022-09-14 10:29:30', '2022-09-14 10:32:30'),
(359, 136, '2022-09-14 10:32:53', '2022-09-14 10:37:55', '2022-09-14 10:32:53', '2022-09-14 10:37:55'),
(360, 28, '2022-09-14 11:06:12', '2022-09-14 11:26:35', '2022-09-14 11:06:12', '2022-09-14 11:26:35'),
(361, 43, '2022-09-14 12:40:07', '2022-09-14 12:41:25', '2022-09-14 12:40:07', '2022-09-14 12:41:25'),
(362, 136, '2022-09-14 12:44:08', '2022-09-14 12:53:44', '2022-09-14 12:44:08', '2022-09-14 12:53:44'),
(363, 43, '2022-09-14 13:05:44', '2022-09-14 13:09:33', '2022-09-14 13:05:44', '2022-09-14 13:09:33'),
(364, 136, '2022-09-14 13:08:56', '2022-09-14 13:19:10', '2022-09-14 13:08:56', '2022-09-14 13:19:10'),
(365, 19, '2022-09-14 13:22:50', '2022-09-14 14:09:41', '2022-09-14 13:22:50', '2022-09-14 14:09:41'),
(366, 28, '2022-09-14 14:13:15', '2022-09-14 14:19:24', '2022-09-14 14:13:15', '2022-09-14 14:19:24'),
(367, 28, '2022-09-14 14:22:37', '2022-09-14 14:23:45', '2022-09-14 14:22:37', '2022-09-14 14:23:45'),
(368, 28, '2022-09-14 14:28:15', '2022-09-14 14:28:34', '2022-09-14 14:28:15', '2022-09-14 14:28:34'),
(369, 28, '2022-09-14 15:21:04', '2022-09-14 15:24:08', '2022-09-14 15:21:04', '2022-09-14 15:24:08'),
(370, 136, '2022-09-14 15:24:18', '2022-09-14 15:32:37', '2022-09-14 15:24:18', '2022-09-14 15:32:37'),
(371, 161, '2022-09-14 15:30:18', '2022-09-14 15:32:37', '2022-09-14 15:30:18', '2022-09-14 15:32:37'),
(372, 136, '2022-09-14 15:52:00', '2022-09-14 17:18:30', '2022-09-14 15:52:00', '2022-09-14 17:18:30'),
(373, 136, '2022-09-14 17:38:16', '2022-09-14 17:38:55', '2022-09-14 17:38:16', '2022-09-14 17:38:55'),
(374, 136, '2022-09-14 23:46:46', '2022-09-14 23:49:49', '2022-09-14 23:46:46', '2022-09-14 23:49:49'),
(375, 28, '2022-09-15 02:13:35', '2022-09-15 02:20:56', '2022-09-15 02:13:35', '2022-09-15 02:20:56'),
(376, 28, '2022-09-15 03:07:50', '2022-09-15 03:10:35', '2022-09-15 03:07:50', '2022-09-15 03:10:35'),
(377, 41, '2022-09-15 04:51:14', '2022-09-15 04:51:37', '2022-09-15 04:51:14', '2022-09-15 04:51:37'),
(378, 41, '2022-09-15 06:00:08', '2022-09-15 06:15:42', '2022-09-15 06:00:08', '2022-09-15 06:15:42'),
(379, 28, '2022-09-15 08:38:04', '2022-09-15 08:41:07', '2022-09-15 08:38:04', '2022-09-15 08:41:07');

-- --------------------------------------------------------

--
-- Table structure for table `aksesoris`
--

CREATE TABLE `aksesoris` (
  `ID` int(11) NOT NULL,
  `accID` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `Bone` int(11) DEFAULT NULL,
  `Show` int(11) DEFAULT NULL,
  `Type` varchar(32) DEFAULT NULL,
  `Color1` varchar(128) DEFAULT NULL,
  `Color2` varchar(128) DEFAULT NULL,
  `Offset` varchar(24) DEFAULT NULL,
  `Rot` varchar(72) DEFAULT NULL,
  `Scale` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aksesoris`
--

INSERT INTO `aksesoris` (`ID`, `accID`, `Model`, `Bone`, `Show`, `Type`, `Color1`, `Color2`, `Offset`, `Rot`, `Scale`) VALUES
(1, 4, 18904, 2, 0, 'Bandana14', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(2, 7, 371, 1, 1, 'gun_para', '255|255|255', '255|255|255', '-0.0379|-0.1368|0.0000', '-3.9999|88.1996|-1.6999', '2.3150|1.5779|1.5999'),
(7, 11, 19015, 2, 1, 'GlassesType10', '255|255|255', '255|255|255', '0.0979|0.0417|-0.0038', '6.7999|89.4999|86.9999', '1.0000|1.0247|1.0000'),
(8, 11, 19142, 1, 0, 'SWATARMOUR1', '255|255|255', '255|255|255', '0.0829|0.0410|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0720|1.0000'),
(14, 71, 19096, 2, 0, 'CowboyHat3', '255|255|255', '0|0|0', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(15, 133, 18912, 2, 1, 'Mask2', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(17, 79, 19033, 2, 1, 'GlassesType28', '255|255|255', '255|255|255', '0.0960|0.0329|0.0000', '97.2994|90.3999|-9.4996', '1.0000|1.0000|1.0000'),
(20, 79, 19069, 2, 0, 'HoodyHat3', '255|255|255', '255|255|255', '0.1168|0.0219|0.0000', '74.6996|115.8999|0.0000', '1.0000|1.0000|1.0000'),
(21, 79, 18964, 2, 1, 'SkullyCap1', '255|255|255', '255|255|255', '0.1208|0.0228|0.0000', '92.5998|100.0000|0.0000', '1.0000|1.0000|1.0000'),
(22, 79, 19347, 1, 1, 'badge01', '255|255|255', '255|255|255', '0.2369|0.1067|-0.0759', '78.0998|-32.2000|0.0000', '1.0000|1.0000|1.0000'),
(28, 77, 2919, 5, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.3490|0.0000|0.0000', '0.0000|-98.3000|0.0000', '0.2430|0.0329|0.4990'),
(29, 173, 19041, 5, 1, 'WatchType3', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(30, 77, 19801, 2, 1, 'Balaclava1', '255|255|255', '255|255|255', '0.0850|-0.0070|0.0000', '0.0000|89.0000|-179.7998', '1.2697|1.2890|1.2747'),
(31, 173, 19515, 1, 0, 'SWATAgrey', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(32, 105, 2919, 1, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.1269|-0.1298|-0.0006', '-1.5999|45.4999|-1.5000', '0.3869|0.1137|0.1456'),
(33, 105, 18964, 2, 1, 'SkullyCap1', '255|255|255', '255|255|255', '0.1208|0.0260|0.0000', '111.0000|101.3999|-21.1000', '1.2058|1.1619|1.1029'),
(34, 40, 19161, 1, 1, 'PoliceHat1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(36, 40, 18895, 2, 0, 'Bandana5', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(37, 14, 2919, 1, 0, 'kmb_holdall', '255|255|255', '255|255|255', '-0.1958|-0.1350|-0.0285', '39.7999|84.9999|-40.7999', '0.4108|0.1756|0.3280'),
(38, 193, 371, 1, 1, 'gun_para', '255|255|255', '255|255|255', '0.0489|-0.1359|0.0000', '0.0000|87.9000|0.0000', '2.0808|1.3890|1.3825'),
(39, 85, 19006, 1, 1, 'GlassesType1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(40, 9, 2919, 1, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.0229|-0.2187|-0.0186', '14.1997|26.7999|-9.6997', '0.5070|0.1400|0.3768'),
(43, 165, 19036, 1, 0, 'HockeyMask1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(44, 165, 19036, 2, 0, 'HockeyMask1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(45, 226, 19006, 2, 0, 'GlassesType1', '255|255|255', '255|255|255', '-0.0030|0.1620|-0.0137', '96.1996|167.3999|-79.0998', '1.0000|1.0000|1.0000'),
(46, 192, 2919, 7, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.2865|0.0000|-0.1404', '5.0998|-96.8998|-100.0000', '0.5626|0.1624|0.2806'),
(47, 12, 19137, 1, 0, 'CluckinBellHat1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(48, 60, 2919, 15, 0, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(49, 12, 19554, 2, 0, 'Beanie1', '001|007|001', '1|7|1', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(50, 12, 18896, 2, 0, 'Bandana6', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(51, 12, 18919, 8, 0, 'Mask9', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(56, 38, 18891, 2, 1, 'Bandana1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(58, 38, 18974, 1, 0, 'MaskZorro1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(61, 64, 2919, 1, 1, 'kmb_holdall', '245|245|245', '245|245|245', '0.0197|-0.1826|-0.0280', '4.4000|15.6000|1.6999', '0.5198|0.1448|0.1940'),
(70, 268, 18919, 2, 1, 'Mask9', '255|255|255', '255|255|255', '0.0750|0.0259|-0.0019', '-89.9000|4.1999|-92.1999', '1.0000|1.0000|1.0000'),
(72, 268, 2919, 1, 1, 'kmb_holdall', '255|255|255', '255|255|255', '-0.0810|-0.1620|-0.0428', '0.0000|88.4000|0.6000', '0.2529|0.1519|0.1949'),
(74, 31, 19142, 1, 0, 'SWATARMOUR1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(76, 194, 19036, 2, 0, 'HockeyMask1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(77, 194, 19113, 1, 0, 'SillyHelmet1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(82, 119, 19142, 1, 0, 'SWATARMOUR1', '255|255|255', '255|255|255', '0.0759|0.0599|0.0087', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(83, 119, 19520, 2, 1, 'pilotHat01', '255|255|255', '255|255|255', '0.1518|-0.0060|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.1576|1.1460'),
(84, 119, 19033, 2, 1, 'GlassesType28', '255|255|255', '255|255|255', '0.0798|0.0419|-0.0006', '0.0000|93.0998|89.4001', '1.0030|1.0160|1.3530'),
(85, 195, 18895, 1, 1, 'Bandana5', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(86, 195, 19039, 1, 1, 'WatchType1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(87, 195, 18911, 1, 1, 'Mask1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(101, 116, 371, 1, 0, 'gun_para', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(103, 108, 19015, 18, 0, 'GlassesType10', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(104, 108, 19042, 5, 1, 'WatchType4', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(106, 304, 18899, 2, 1, 'Bandana9', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(107, 304, 18955, 6, 1, 'CapOverEye1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(108, 304, 19014, 4, 1, 'GlassesType9', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(115, 64, 19559, 1, 1, 'HikerBackpack1', '255|255|255', '255|255|255', '0.1027|-0.0109|0.0000', '0.0000|89.5998|0.0000', '1.0000|1.0000|1.0000'),
(116, 64, 19142, 1, 0, 'SWATARMOUR1', '133|031|046', '0|0|0', '0.0658|0.0285|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(118, 291, 19012, 2, 1, 'GlassesType7', '255|255|255', '255|255|255', '0.0829|0.0230|0.0027', '94.4999|93.6996|-2.9000', '1.0000|1.0000|1.0000'),
(119, 291, 18896, 2, 0, 'Bandana6', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(120, 291, 18916, 2, 1, 'Mask6', '255|255|255', '255|255|255', '0.0728|0.0120|0.0027', '-87.1996|-0.1999|-89.1996', '1.0000|1.0000|1.0000'),
(121, 194, 19515, 1, 0, 'SWATAgrey', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(122, 105, 19033, 2, 1, 'GlassesType28', '255|255|255', '255|255|255', '0.0939|0.0186|-0.0040', '91.0998|81.9999|0.0000', '1.1640|1.0740|1.0230'),
(123, 331, 19096, 17, 0, 'CowboyHat3', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(124, 331, 18898, 2, 0, 'Bandana8', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(125, 144, 2919, 2, 0, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(126, 311, 19559, 1, 0, 'HikerBackpack1', '255|255|255', '255|255|255', '-0.1058|-0.0728|-0.0219', '0.0000|-90.6996|0.0000', '1.2316|1.0000|1.1727'),
(127, 123, 2919, 7, 0, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(128, 311, 19115, 2, 1, 'SillyHelmet3', '255|255|255', '255|255|255', '0.1480|-0.0186|-0.0098', '0.0000|0.0000|0.0000', '1.1130|1.1209|1.2020'),
(129, 14, 19115, 2, 0, 'SillyHelmet3', '255|255|255', '255|255|255', '0.1597|-0.0068|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0477|1.1710'),
(130, 311, 18912, 2, 0, 'Mask2', '255|255|255', '255|255|255', '0.0689|0.0090|-0.0099', '92.7999|168.9000|85.6999', '1.0979|1.0000|1.1970'),
(131, 18, 19554, 2, 0, 'Beanie1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(132, 18, 19012, 2, 0, 'GlassesType7', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(135, 5, 19942, 1, 1, 'PoliceRadio1', '255|255|255', '255|255|255', '-0.4399|0.2149|-0.1330', '11.1997|114.5998|-8.0000', '1.0000|1.0000|1.0000'),
(136, 5, 18892, 17, 0, 'Bandana2', '255|255|255', '255|255|255', '0.1307|0.0908|-0.0087', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(137, 5, 18940, 1, 0, 'CapBack3', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(139, 139, 2919, 8, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0070|0.0498', '7.2999|-90.3000|105.4999', '0.4889|0.0930|0.2599'),
(140, 159, 2919, 1, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.0579|-0.1368|0.0249', '5.9998|33.7999|-5.9998', '0.4338|0.1597|0.1808'),
(148, 188, 19036, 2, 1, 'HockeyMask1', '255|255|255', '255|255|255', '0.0959|0.0320|0.0060', '0.1999|74.5999|89.0000', '0.9529|1.1639|1.0000'),
(149, 188, 19137, 2, 1, 'CluckinBellHat1', '255|255|255', '255|255|255', '0.0390|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(150, 188, 2919, 1, 1, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|-0.2089|0.0000', '0.0000|-26.0999|0.0000', '0.5199|0.1910|0.2019'),
(154, 116, 2919, 1, 0, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(155, 213, 2919, 1, 0, 'kmb_holdall', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(156, 37, 19142, 1, 1, 'SWATARMOUR1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(157, 37, 19896, 3, 0, 'CigarettePack1', '255|255|255', '255|255|255', '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', '1.0000|1.0000|1.0000'),
(158, 34, 18912, 2, 1, 'Mask2', '255|255|255', '255|255|255', '0.0719|0.0379|0.0027', '-93.4000|2.1998|-96.1996', '1.0427|1.1727|1.1180'),
(159, 34, 18978, 2, 1, 'MotorcycleHelmet4', '255|255|255', '255|255|255', '0.0529|0.0509|-0.0038', '90.8000|82.5998|-0.2998', '1.1969|1.2596|1.1250');

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Model` int(10) NOT NULL DEFAULT 19315,
  `Health` int(10) UNSIGNED NOT NULL DEFAULT 100,
  `Time` int(10) NOT NULL DEFAULT 3600,
  `Pos` varchar(255) NOT NULL DEFAULT '0.0000|0.0000|0.0000',
  `Rot` varchar(255) NOT NULL DEFAULT '0.0000|0.0000|0.0000',
  `Potong` int(255) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `animals`
--

INSERT INTO `animals` (`ID`, `Model`, `Health`, `Time`, `Pos`, `Rot`, `Potong`) VALUES
(53, 19315, 100, 3600, '0.0000|0.0000|0.0000', '0.0000|0.0000|0.0000', 0);

-- --------------------------------------------------------

--
-- Table structure for table `apartment`
--

CREATE TABLE `apartment` (
  `apartmentID` int(11) NOT NULL,
  `apartmentType` int(11) NOT NULL DEFAULT 0,
  `apartmentName` varchar(128) NOT NULL DEFAULT 'Real Estate',
  `apartmentExteriorInt` int(11) NOT NULL DEFAULT 0,
  `apartmentExteriorWorld` int(11) NOT NULL DEFAULT 0,
  `apartmentExteriorPosX` float NOT NULL DEFAULT 0,
  `apartmentExteriorPosY` float NOT NULL DEFAULT 0,
  `apartmentExteriorPosZ` float NOT NULL DEFAULT 0,
  `apartmentExteriorPosA` float NOT NULL DEFAULT 0,
  `apartmentInteriorInt` int(11) NOT NULL DEFAULT 0,
  `apartmentInteriorWorld` int(11) NOT NULL DEFAULT 0,
  `apartmentInteriorPosX` float NOT NULL DEFAULT 0,
  `apartmentInteriorPosY` float NOT NULL DEFAULT 0,
  `apartmentInteriorPosZ` float NOT NULL DEFAULT 0,
  `apartmentInteriorPosA` float NOT NULL DEFAULT 0,
  `apartmentParkingPosX` float NOT NULL DEFAULT 0,
  `apartmentParkingPosY` float NOT NULL DEFAULT 0,
  `apartmentParkingPosZ` float NOT NULL DEFAULT 0,
  `apartmentParkingPosA` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `apartment_room`
--

CREATE TABLE `apartment_room` (
  `apartmentRoomID` int(11) NOT NULL,
  `apartmentID` int(11) NOT NULL DEFAULT -1,
  `apartmentRoomOwner` int(11) NOT NULL DEFAULT -1,
  `apartmentRoomPrice` int(11) NOT NULL DEFAULT 200000,
  `apartmentRoomOwnerName` varchar(128) NOT NULL DEFAULT 'Real Estate',
  `apartmentRoomName` varchar(128) NOT NULL DEFAULT 'None',
  `apartmentRoomInterior` int(11) NOT NULL DEFAULT 0,
  `apartmentRoomWorld` int(11) NOT NULL DEFAULT 0,
  `apartmentExteriorRoomPosX` float NOT NULL DEFAULT 0,
  `apartmentExteriorRoomPosY` float NOT NULL DEFAULT 0,
  `apartmentExteriorRoomPosZ` float NOT NULL DEFAULT 0,
  `apartmentExteriorRoomPosA` float NOT NULL DEFAULT 0,
  `apartmentInteriorRoomPosX` float NOT NULL DEFAULT 0,
  `apartmentInteriorRoomPosY` float NOT NULL DEFAULT 0,
  `apartmentInteriorRoomPosZ` float NOT NULL DEFAULT 0,
  `apartmentInteriorRoomPosA` float NOT NULL DEFAULT 0,
  `apartmentRoomLock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `apartment_storage`
--

CREATE TABLE `apartment_storage` (
  `itemID` int(11) NOT NULL,
  `apartmentRoomID` int(11) NOT NULL DEFAULT -1,
  `itemName` varchar(255) NOT NULL DEFAULT 'None',
  `itemModel` int(11) NOT NULL DEFAULT 0,
  `itemQuantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `arrestpoints`
--

CREATE TABLE `arrestpoints` (
  `arrestID` int(11) NOT NULL,
  `arrestX` float NOT NULL DEFAULT 0,
  `arrestY` float NOT NULL DEFAULT 0,
  `arrestZ` float NOT NULL DEFAULT 0,
  `arrestInterior` int(11) NOT NULL DEFAULT 0,
  `arrestWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `arrestpoints`
--

INSERT INTO `arrestpoints` (`arrestID`, `arrestX`, `arrestY`, `arrestZ`, `arrestInterior`, `arrestWorld`) VALUES
(1, 1525.22, -1677.93, 5.8906, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE `atm` (
  `atmID` int(11) NOT NULL,
  `atmX` float NOT NULL DEFAULT 0,
  `atmY` float NOT NULL DEFAULT 0,
  `atmZ` float NOT NULL DEFAULT 0,
  `atmA` float NOT NULL DEFAULT 0,
  `atmInterior` int(11) NOT NULL DEFAULT 0,
  `atmWorld` int(11) NOT NULL DEFAULT 0,
  `atmCap` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `atm`
--

INSERT INTO `atm` (`atmID`, `atmX`, `atmY`, `atmZ`, `atmA`, `atmInterior`, `atmWorld`, `atmCap`) VALUES
(2, 1334.91, -632.531, 109.134, 19.044, 0, 0, 25000),
(4, 1849.39, -1076.76, 41.652, 89.747, 110, 0, 25000),
(5, 1548.81, 1514.61, 25.801, 93.163, 13, 0, 0),
(6, -1075.19, -975.111, 129.304, 1.332, 15, 0, 25000),
(7, 661.419, -1387.38, 801.356, 180.6, 7, 0, 25000),
(8, 827.106, -1345.42, 13.538, 90.481, 0, 0, 25000),
(9, 1833.23, -1845.8, 13.578, 88.638, 0, 0, 25000),
(10, 1928.58, -1773.09, 13.545, 270.489, 0, 0, 25000),
(11, 1935.77, -1864.77, 13.56, 0.416, 0, 0, 25000),
(12, 2105.45, -1807.87, 13.553, 90.398, 0, 0, 25000),
(13, 2159.85, -1740.19, 13.569, 0.614, 0, 0, 25000),
(14, 1035.09, -1339.48, 13.725, 0.108, 0, 0, 25000),
(15, 1317.87, -897.802, 39.576, 180.828, 0, 0, 25000),
(16, 1000.84, -922.531, 42.326, 98.694, 0, 0, 25000),
(17, 1350.07, -1759.24, 13.515, 358.686, 0, 0, 25000),
(18, 1339.63, -1555.87, 13.562, 264.019, 0, 0, 25000),
(19, 957.465, -1734.15, 13.545, 359.803, 0, 0, 25000);

-- --------------------------------------------------------

--
-- Table structure for table `backpackitems`
--

CREATE TABLE `backpackitems` (
  `ID` int(12) DEFAULT 0,
  `itemID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `backpacks`
--

CREATE TABLE `backpacks` (
  `backpackID` int(12) NOT NULL,
  `backpackPlayer` int(12) DEFAULT 0,
  `backpackX` float DEFAULT 0,
  `backpackY` float DEFAULT 0,
  `backpackZ` float DEFAULT 0,
  `backpackInterior` int(12) DEFAULT 0,
  `backpackWorld` int(12) DEFAULT 0,
  `backpackHouse` int(12) DEFAULT 0,
  `backpackVehicle` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `billboards`
--

CREATE TABLE `billboards` (
  `bbID` int(12) NOT NULL,
  `bbExists` int(12) DEFAULT 0,
  `bbName` varchar(32) DEFAULT NULL,
  `bbOwner` int(12) NOT NULL DEFAULT 0,
  `bbPrice` int(12) NOT NULL DEFAULT 0,
  `bbRange` int(12) DEFAULT 10,
  `bbPosX` float DEFAULT 0,
  `bbPosY` float DEFAULT 0,
  `bbPosZ` float DEFAULT 0,
  `bbMessage` varchar(230) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bizwarn`
--

CREATE TABLE `bizwarn` (
  `ID` int(10) NOT NULL,
  `bizID` int(10) NOT NULL,
  `bwarnBy` varchar(35) CHARACTER SET utf8 NOT NULL,
  `bwarnReason` varchar(35) CHARACTER SET utf8 NOT NULL,
  `bwarnDate` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `ID` int(11) NOT NULL,
  `IP` varchar(16) DEFAULT '0.0.0.0',
  `Username` varchar(24) DEFAULT NULL,
  `Characters` varchar(24) DEFAULT NULL,
  `BannedBy` varchar(24) DEFAULT NULL,
  `Reason` varchar(128) DEFAULT NULL,
  `Date` int(10) UNSIGNED DEFAULT NULL,
  `Temp` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blacklist`
--

INSERT INTO `blacklist` (`ID`, `IP`, `Username`, `Characters`, `BannedBy`, `Reason`, `Date`, `Temp`) VALUES
(2, '222.124.109.231', '', '', 'Rukitateki', 'Cheater', 1662814237, 0),
(3, '', 'IscoXyz', '', 'Rukitateki', 'Cheater Fly Hack', 1662816385, 0),
(4, '8.30.234.95', '', '', 'Rukitateki', 'Cheater', 1662816402, 0),
(7, '114.79.21.165', '', '', 'Rukitateki', 'Cheater', 1662823939, 0),
(8, '', 'hitam', '', 'Rukitateki', 'Cheater Weapon Hack', 1662866983, 0),
(9, '114.142.168.39', '', '', 'Rukitateki', 'Cheater Weapon Hack', 1662867000, 0),
(10, '', '', 'Jahreem_Kareem', 'Godzillas', 'Cheat surfly', 1662877975, 0),
(11, '', 'leonel', '', 'pandu', 'cit ', 1662885994, 0),
(12, '', '', 'Kueza_Hingston', 'pandu', '30', 1662885999, 0),
(13, '', '', 'Robert_Brooklyn', 'Axel', 'Teleport Hack', 1662972918, 0),
(14, '', '', 'Josh_Arkwood', 'Axel', 'Health Hack', 1662975630, 0),
(15, '', '', 'Paulov_Xavier', 'Axel', 'CHEATER', 1662975771, 0),
(16, '', '', 'Jahseeh_Onfroy', 'Axel', 'citer', 1662977594, 0),
(17, '', '', 'Alcantor_Kontoloes', 'bastian', 'Fly while shooting', 1663059814, 0),
(18, '', '', 'Kayson_Rostalve.', 'Axel', 'CHEATER', 1663062179, 0),
(19, '', '', '', 'bastian', 'Cheat', 1663062207, 0),
(20, '', '', 'Max_Benjamin', 'Axel', 'CHEATER', 1663065635, 0),
(21, '', '', 'Arthur_Potts', 'Axel', 'CITER', 1663065846, 0),
(22, '', 'scott', '', 'Axel', 'CHEATER', 1663065891, 0),
(23, '', 'Joaquin', '', 'Axel', 'CHEATER', 1663066554, 0),
(24, '', '', 'Asep_Asmara', 'Axel', 'CHEATER', 1663066587, 0),
(25, '', 'mamangsuter', '', 'Axel', 'CHEATER', 1663068087, 0),
(26, '', '', 'Cody_Matthew', 'Axel', 'CHEATER', 1663068131, 0),
(27, '', 'pler', '', 'Axel', 'CHEATER', 1663068172, 0),
(28, '182.3.102.33', '', '', 'Axel', 'CHEATER', 1663068248, 0),
(29, '182.3.103.101', '', '', 'Axel', 'CHEATER', 1663068276, 0),
(30, '108.244.138.77', '', '', 'Axel', 'CHEATER', 1663068302, 0),
(31, '61.247.38.76', '', '', 'Axel', 'CHEATER', 1663068341, 0),
(32, '', '', 'Alejandro_Moreigh', 'Axel', 'CHEATER', 1663068895, 0),
(33, '', 'Langs', '', 'Axel', 'CHEATER', 1663068921, 0),
(34, '36.71.81.90', '', '', 'Axel', 'CHEATER', 1663068964, 0),
(35, '', '', 'Daniell_Wade', 'Axel', 'CHEATER', 1663073449, 0),
(36, '', 'skell', '', 'Axel', 'cheater', 1663073480, 0),
(37, '120.188.38.54', '', '', 'Axel', 'CHEATER', 1663073672, 0),
(38, '', '', 'Tommy_Sander', 'Axel', 'CHEATER', 1663081395, 0),
(39, '', 'romero', '', 'Axel', 'CHEATER', 1663081433, 0),
(40, '114.79.5.98', '', '', 'Axel', 'CHEATER', 1663081487, 0),
(41, '', '', 'Patrick_Benjamin', 'Axel', 'CHEATER', 1663097460, 0),
(42, '', 'farwin', '', 'Axel', 'CHEATER', 1663097482, 0),
(43, '', '', 'Cody_Marshall', 'Axel', 'CHEATER', 1663142202, 0),
(44, '', 'kontol', '', 'Axel', 'CHEATER', 1663142225, 0),
(45, '8.38.147.56', '', '', 'Axel', 'CHEATER', 1663142270, 0),
(48, '115.178.206.90', '', '', 'Axel', 'CHEATER', 1663142885, 0),
(52, '203.78.119.92', '', '', 'Axel', 'Cheater HEALTH HACK', 1663146828, 0),
(54, '', '', 'Martin_Brooks', 'Axel', 'CHEATER', 1663153828, 0),
(55, '', 'God', '', 'Axel', 'Cheater', 1663153883, 0),
(56, '114.79.7.204', '', '', 'Axel', 'Cheater', 1663153907, 0),
(57, '', '', 'Vicky_Escobar', 'Axel', 'CHEATER', 1663154607, 0),
(58, '', 'Vicky', '', 'Axel', 'Cheater', 1663154639, 0),
(59, '103.10.64.20', '', '', 'Axel', 'Cheater', 1663154667, 0),
(60, '', '', 'Diego_Dioo', 'Axel', 'Cheater Fly Hack', 1663208324, 1663294724);

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `bizID` int(12) NOT NULL,
  `bizName` varchar(32) DEFAULT NULL,
  `bizOwner` int(12) DEFAULT 0,
  `bizType` int(12) DEFAULT 0,
  `bizPrice` int(12) DEFAULT 0,
  `bizPosX` float DEFAULT 0,
  `bizPosY` float DEFAULT 0,
  `bizPosZ` float DEFAULT 0,
  `bizPosA` float DEFAULT 0,
  `bizIntX` float DEFAULT 0,
  `bizIntY` float DEFAULT 0,
  `bizIntZ` float DEFAULT 0,
  `bizIntA` float DEFAULT 0,
  `bizInterior` int(12) DEFAULT 0,
  `bizExterior` int(12) DEFAULT 0,
  `bizExteriorVW` int(12) DEFAULT 0,
  `bizLocked` int(4) DEFAULT 0,
  `bizVault` int(12) DEFAULT 0,
  `bizProducts` int(12) DEFAULT 0,
  `bizPrice1` int(12) DEFAULT 0,
  `bizPrice2` int(12) DEFAULT 0,
  `bizPrice3` int(12) DEFAULT 0,
  `bizPrice4` int(12) DEFAULT 0,
  `bizPrice5` int(12) DEFAULT 0,
  `bizPrice6` int(12) DEFAULT 0,
  `bizPrice7` int(12) DEFAULT 0,
  `bizPrice8` int(12) DEFAULT 0,
  `bizPrice9` int(12) DEFAULT 0,
  `bizPrice10` int(12) DEFAULT 0,
  `bizSpawnX` float DEFAULT 0,
  `bizSpawnY` float DEFAULT 0,
  `bizSpawnZ` float DEFAULT 0,
  `bizSpawnA` float DEFAULT 0,
  `bizDeliverX` float DEFAULT 0,
  `bizDeliverY` float DEFAULT 0,
  `bizDeliverZ` float DEFAULT 0,
  `bizMessage` varchar(128) DEFAULT NULL,
  `bizPrice11` int(12) DEFAULT 0,
  `bizPrice12` int(12) DEFAULT 0,
  `bizPrice13` int(12) DEFAULT 0,
  `bizPrice14` int(12) DEFAULT 0,
  `bizPrice15` int(12) DEFAULT 0,
  `bizPrice16` int(12) DEFAULT 0,
  `bizPrice17` int(12) DEFAULT 0,
  `bizPrice18` int(12) DEFAULT 0,
  `bizPrice19` int(12) DEFAULT 0,
  `bizPrice20` int(12) DEFAULT 0,
  `bizShipment` int(4) DEFAULT 0,
  `bizSeal` int(11) NOT NULL DEFAULT 0,
  `bOwnerName` varchar(225) NOT NULL DEFAULT 'None',
  `bizCargo` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bizLastVisited` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bizJob` int(5) NOT NULL DEFAULT 0,
  `bizWarn` int(5) NOT NULL DEFAULT 0,
  `bizLink` varchar(128) NOT NULL DEFAULT 'None',
  `bizDurability` int(10) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `businesses`
--

INSERT INTO `businesses` (`bizID`, `bizName`, `bizOwner`, `bizType`, `bizPrice`, `bizPosX`, `bizPosY`, `bizPosZ`, `bizPosA`, `bizIntX`, `bizIntY`, `bizIntZ`, `bizIntA`, `bizInterior`, `bizExterior`, `bizExteriorVW`, `bizLocked`, `bizVault`, `bizProducts`, `bizPrice1`, `bizPrice2`, `bizPrice3`, `bizPrice4`, `bizPrice5`, `bizPrice6`, `bizPrice7`, `bizPrice8`, `bizPrice9`, `bizPrice10`, `bizSpawnX`, `bizSpawnY`, `bizSpawnZ`, `bizSpawnA`, `bizDeliverX`, `bizDeliverY`, `bizDeliverZ`, `bizMessage`, `bizPrice11`, `bizPrice12`, `bizPrice13`, `bizPrice14`, `bizPrice15`, `bizPrice16`, `bizPrice17`, `bizPrice18`, `bizPrice19`, `bizPrice20`, `bizShipment`, `bizSeal`, `bOwnerName`, `bizCargo`, `bizLastVisited`, `bizJob`, `bizWarn`, `bizLink`, `bizDurability`) VALUES
(1, 'Kiddy Clothes', 23, 3, 1, 1933.49, -1864.77, 13.5619, 180.62, 161.48, -96.5363, 1001.8, 0, 18, 0, 0, 0, 100, 925, 100, 25, 25, 50, 50, 25, 25, 25, 0, 0, 1933.49, -1864.77, 13.5619, 180.62, 1921.17, -1861.33, 13.5598, 'Selamat datang, kami menyediakan berbagai macam pakaian', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vayler_Coleman', 100, 0, 0, 0, '', 100),
(2, 'Brody Restaurrant', 25, 4, 1, 1949.55, -1985, 13.5466, 92.2238, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 0, 1952, 676, 2, 5, 5, 10, 10, 15, 10, 0, 0, 0, 1949.55, -1985, 13.5466, 92.2238, 1946.17, -1979.61, 13.5466, 'Selamat datang, kami menyediakan berbagai macam makanan', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Valcon_Colemania', 100, 0, 0, 0, 'https://tinyurl.com/mwcct6kp', 60),
(3, 'Ananta Mart', 2, 1, 100, 1833.5, -1842.39, 13.5781, 114.2, -27.3073, -30.874, 1003.56, 0, 4, 0, 0, 0, 25222, 3856, 75, 125, 15, 100, 3, 2, 10, 100, 20, 10, 1833.5, -1842.39, 13.5781, 114.2, 1842.11, -1856.45, 13.3828, '', 150, 200, 160, 60, 50, 5, 10, 5, 0, 0, 0, 0, 'Ananta_Wiguna', 100, 0, 0, 0, '', 100),
(4, 'Gas Station', 172, 6, 1, 1928.58, -1776.24, 13.5466, 88.1567, -27.3383, -57.6907, 1003.55, 0, 6, 0, 0, 0, 4696, 82, 75, 20, 18, 18, 20, 4, 10, 90, 20, 10, 1928.58, -1776.24, 13.5466, 88.1567, 1923.17, -1791.76, 13.3828, '', 140, 150, 50, 40, 5, 10, 5, 0, 0, 0, 0, 0, 'Reamy_Xhyner', 100, 0, 0, 0, '', 100),
(7, 'Fast Food', 15, 4, 200000, 2419.76, -1508.98, 24, 85.749, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 0, 233, 0, 10, 8, 20, 10, 10, 15, 10, 0, 0, 0, 2419.76, -1508.98, 24, 85.749, 2409.45, -1486.66, 23.8281, 'MAKAN YANG BANYAK , KALO GA MAKAN LO MATI', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 'Oscar_Vengeance', 100, 0, 0, 0, 'http://d.zaix.ru/mcgl.jpg', 50),
(8, 'Furniture', 24, 7, 1, 2352.01, -1412.24, 23.9923, 270.976, -2240.5, 128.377, 1035.42, 270, 6, 0, 0, 0, 2875, 0, 75, 50, 25, 200, 50, 100, 50, 50, 50, 50, 2352.01, -1412.24, 23.9923, 270.976, 2349.55, -1403.52, 23.9902, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ventilya_Colemany', 100, 0, 0, 0, '', 100),
(9, 'Retail', 0, 1, 200000, 1315.53, -897.681, 39.578, 359.599, -27.3073, -30.874, 1003.56, 0, 4, 0, 0, 1, 0, 50, 75, 125, 15, 100, 3, 2, 10, 100, 20, 10, 1315.53, -897.681, 39.578, 359.599, 1327.28, -916.733, 36.9543, '', 150, 200, 160, 60, 50, 5, 10, 5, 0, 0, 0, 0, '', 100, 0, 0, 0, '', 100),
(10, 'Fast Food', 210, 4, 1, 1199.27, -918.587, 43.1197, 4.6957, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 1, 0, 50, 2, 5, 5, 10, 10, 15, 10, 0, 0, 0, 1199.27, -918.587, 43.1197, 4.6957, 1215.29, -903.825, 42.9188, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cho_Tabim', 100, 0, 0, 0, '', 100),
(12, 'Resto Tempiks', 179, 4, 200000, 1038.13, -1340.73, 13.7451, 181.542, 377.039, -193.306, 1000.63, 182.149, 17, 0, 0, 0, 10380, 16, 3, 6, 6, 12, 12, 6, 10, 0, 0, 0, 1038.13, -1340.73, 13.7451, 181.542, 1046.52, -1342.43, 13.5558, 'Selamat Datang di Resto Tempiks', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fitzroy_Mckenny', 101, 0, 0, 0, '', 0),
(13, 'Fast Food', 0, 4, 200000, 928.752, -1352.95, 13.3437, 269.609, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 1, 0, 50, 2, 5, 5, 10, 10, 15, 10, 0, 0, 0, 928.752, -1352.95, 13.3437, 269.609, 924.555, -1360.12, 13.3818, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 100, 0, 0, 0, '', 100),
(14, 'Electronic Store', 0, 8, 200000, 816.146, -1386.18, 13.5992, 1.6599, 0, 0, 0, 0, 0, 0, 0, 1, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 816.146, -1386.18, 13.5992, 1.6599, 823.152, -1388.84, 13.6323, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 100, 0, 0, 0, '', 100),
(15, 'Clothes', 0, 3, 200000, 2112.86, -1211.45, 23.9627, 0.5221, 161.48, -96.5366, 1001.8, 0, 18, 0, 0, 1, 0, 50, 25, 15, 10, 10, 0, 0, 0, 0, 0, 0, 2112.86, -1211.45, 23.9627, 0.5221, 2117.48, -1213.91, 23.9664, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 100, 0, 0, 0, '', 100),
(16, 'Furniture', 7, 7, 1, 2050.1, -1802.66, 14.85, 2.8828, -2240.5, 128.377, 1035.42, 270, 6, 0, 0, 0, 1978, 0, 75, 115, 50, 60, 20, 100, 300, 100, 150, 300, 2050.13, -1802.67, 14.85, 359.972, 2037.71, -1805.38, 13.553, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Berlin_Varcelo', 100, 0, 0, 0, 'https://youtu.be/9pn1M6DeiYI', 100),
(17, 'BIMA SAKTI', 210, 1, 1, 1352.4, -1759.25, 13.5078, 179.98, -27.3073, -30.874, 1003.56, 0, 4, 0, 0, 0, 188, 45, 75, 125, 15, 100, 3, 2, 10, 100, 20, 10, 1352.4, -1759.25, 13.5078, 179.98, 1347.03, -1757.35, 13.5078, '', 150, 200, 160, 60, 50, 5, 10, 5, 0, 0, 0, 0, 'Cho_Tabim', 100, 0, 0, 0, '', 100),
(18, 'Electronic Store', 115, 8, 1, 1848.33, -1871.74, 13.5781, 264.104, 418.828, -84.3663, 1001.8, 190.32, 3, 0, 0, 0, 20270, 192, 20, 15, 30, 25, 50, 5, 35, 10, 100, 0, 1848.33, -1871.74, 13.5781, 264.104, 1851.09, -1864.41, 13.5781, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arjun_Walker', 100, 0, 0, 0, '', 100),
(19, 'Fast Food', 77, 4, 1, 2105.49, -1806.45, 13.5544, 0, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 0, 36697, 20, 20, 35, 50, 60, 50, 30, 10, 0, 0, 0, 2105.49, -1806.45, 13.5544, 0, 2118.4, -1784.15, 13.3837, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Pandu_Pangestu', 100, 0, 0, 0, '', 0),
(21, 'Eve Clothes', 11, 3, 1, 2001.93, -1761.96, 13.5389, 180.661, 161.48, -96.5363, 1001.8, 0, 18, 0, 0, 0, 2750, 0, 50, 25, 25, 25, 25, 25, 25, 25, 0, 0, 2001.93, -1761.96, 13.5389, 180.661, 2006.09, -1759.67, 13.5389, 'Welcome to Eve Clothes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Plutarco_Echeverra', 125, 0, 0, 0, 'https://www.youtube.com/watch?v=IJ0VewgW73I', 100),
(22, 'Electronic Store', 5, 8, 1, 1133.81, -1270.87, 13.5467, 2.4856, 0, 0, 0, 0, 0, 0, 0, 1, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1133.81, -1270.87, 13.5467, 2.4856, 1128.99, -1274.37, 13.5467, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Frankie_Charles', 100, 0, 0, 0, '', 100),
(23, 'BlueBerry\'S Food', 173, 4, 1, 212.168, -202.188, 1.5779, 359.203, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 0, 1090, 0, 9, 10, 10, 15, 20, 20, 10, 0, 0, 0, 212.168, -202.188, 1.5779, 359.203, 220.268, -204.451, 1.5779, 'Selamat Datang Di BlueBerry\'S Food Selamat Berbelanja', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hilmy_Fauzan', 100, 0, 0, 0, 'http://d.zaix.ru/mcgI.jpg', 50),
(24, 'King Foods', 105, 4, 1, 1419.17, -1623.91, 13.5466, 87.9328, 363.34, -74.6679, 1001.51, 315, 10, 0, 0, 0, 3260, 0, 10, 15, 20, 20, 25, 30, 10, 0, 0, 0, 1419.17, -1623.91, 13.5466, 87.9328, 1421.26, -1627.49, 13.5466, 'Selamat Datang di King Foods,Selamat Menikmati ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kenzo_Devalos', 60, 0, 0, 0, '', 50),
(25, 'Fox Market', 46, 1, 1, 1133.53, -1370.03, 13.9841, 359.227, -27.3073, -30.874, 1003.56, 0, 4, 0, 0, 0, 335, 27, 75, 100, 10, 100, 35, 5, 50, 100, 20, 10, 1133.53, -1370.03, 13.9841, 359.227, 1131.24, -1371.37, 13.9841, 'Selamat Datang,ayo borong banyak-banyak', 150, 200, 160, 60, 50, 5, 10, 5, 0, 0, 0, 0, 'Aiden_Pearce', 500, 0, 0, 0, '', 100),
(26, 'Clothes', 269, 3, 1, 2244.35, -1665.56, 15.4764, 162.452, 161.48, -96.5364, 1001.8, 0, 18, 0, 0, 0, 415, 0, 25, 15, 10, 10, 0, 0, 0, 0, 0, 0, 2244.35, -1665.56, 15.4764, 162.452, 2251.59, -1664.87, 15.4687, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Minami_Chibiko', 100, 0, 0, 0, '', 100),
(27, 'Bar And Lounge', 271, 9, 1, 2310.08, -1643.53, 14.8269, 321.203, 501.941, -67.563, 998.758, 6.4534, 11, 0, 0, 1, 0, 1000, 3, 5, 3, 5, 10, 0, 0, 0, 0, 0, 2310.08, -1643.53, 14.8269, 321.203, 2306.91, -1642.95, 14.5425, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mahleek_Preston', 100, 0, 0, 0, '', 100),
(28, 'Gas Station', 77, 3, 1, 1000.59, -919.927, 42.328, 276.397, 161.48, -96.5367, 1001.8, 0, 18, 0, 0, 0, 554, 0, 75, 115, 15, 1, 3, 2, 10, 90, 20, 10, 1000.59, -919.927, 42.328, 276.397, 998.546, -926.431, 42.1795, '', 140, 150, 50, 40, 5, 10, 5, 0, 0, 0, 0, 0, 'Pandu_Pangestu', 100, 0, 0, 0, '', 100);

-- --------------------------------------------------------

--
-- Table structure for table `business_employe`
--

CREATE TABLE `business_employe` (
  `ID` int(11) NOT NULL,
  `playerID` int(11) NOT NULL,
  `Business` int(11) NOT NULL DEFAULT -1,
  `Name` varchar(255) NOT NULL DEFAULT 'Stranger',
  `DutyHour` int(11) NOT NULL DEFAULT 0,
  `Time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `business_employe`
--

INSERT INTO `business_employe` (`ID`, `playerID`, `Business`, `Name`, `DutyHour`, `Time`) VALUES
(1, 15, 11, 'Oscar_Vengeance', 0, 1662918487),
(2, 62, 7, 'Vittorini_Leovince', 0, 1663086581),
(3, 15, 7, 'Oscar_Vengeance', 0, 1663086823);

-- --------------------------------------------------------

--
-- Table structure for table `business_queue`
--

CREATE TABLE `business_queue` (
  `Username` varchar(24) NOT NULL,
  `ID` int(10) UNSIGNED NOT NULL,
  `Message` varchar(32) NOT NULL,
  `Date` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cardestroy`
--

CREATE TABLE `cardestroy` (
  `destroyBy` varchar(24) NOT NULL,
  `destroyModel` int(10) UNSIGNED NOT NULL,
  `destroyOwner` varchar(24) NOT NULL,
  `destroyTime` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cardestroy`
--

INSERT INTO `cardestroy` (`destroyBy`, `destroyModel`, `destroyOwner`, `destroyTime`) VALUES
('Pandu_Pangestu', 560, 'Ranz_Summers', 1662829083),
('Popix_Vicente', 496, 'Popix_Vicente', 1662829887),
('Synester_Vengeance', 432, 'Synester_Vengeance', 1662832274),
('Kane_Sutarjo', 457, 'Synester_Vengeance', 1662837934),
('Ferdison_Alexander', 422, 'Ranz_Summers', 1662856185),
('Jerell_Ware', 560, 'Smith_Martin', 1662860210),
('Rudulf_Geraldo', 477, 'Rudulf_Geraldo', 1662863367),
('Jackson_Alexander', 499, 'Fazly_Albiandra', 1662864756),
('Plutarco_Echeverra', 477, 'Jay_Francisco', 1662866061),
('Kudak_Deblow', 422, 'Rey_Marcel', 1662866766),
('Vayler_Coleman', 560, 'Jay_Francisco', 1662868172),
('Plutarco_Echeverra', 560, 'Smith_Martin', 1662871364),
('Axel_Volter', 560, 'Axel_Volter', 1662871411),
('Diego_Dioo', 506, 'Diego_Dioo', 1662871918),
('RyuuGi_Exodiaz', 560, 'Ranz_Summers', 1662874483),
('Ferdison_Alexander', 560, 'Ferdison_Alexander', 1662875216),
('Plutarco_Echeverra', 463, 'Ferdison_Alexander', 1662876035),
('Hilmy_Fauzan', 411, 'Hilmy_Fauzan', 1662876437),
('Aaron_Petterson', 579, 'Aaron_Petterson', 1662876520),
('Daniell_Wade', 560, 'Jahreem_Kareem', 1662877841),
('Federico_Gavi', 559, 'Fazly_Albiandra', 1662879351),
('RyuuGi_Exodiaz', 411, 'Pandu_Pangestu', 1662879874),
('Ananta_Wiguna', 560, 'Smith_Martin', 1662884425),
('Axel_Volter', 560, 'Axel_Volter', 1662884772),
('Howard_Barnett', 420, 'Howard_Barnett', 1662888288),
('Synester_Vengeance', 463, 'Xavier_Luciano', 1662889208),
('Oscar_Vengeance', 494, 'Oscar_Vengeance', 1662889225),
('Lucas_Shane', 426, 'Lucas_Shane', 1662889808),
('Aaron_Petterson', 525, 'Abel_Petterson', 1662890995),
('Rojer_Hawkins', 560, 'Rojer_Hawkins', 1662893515),
('Synester_Vengeance', 477, 'Ken_Mang', 1662900245),
('Genzo_Ruffor', 422, 'Genzo_Ruffor', 1662902100),
('Abel_Petterson', 579, 'Aaron_Petterson', 1662903473),
('Ryu_Exel', 521, 'Diego_Dioo', 1662903577),
('Leon_Kennedy', 560, 'Leon_Kennedy', 1662914312),
('Reamy_Xhyner', 560, 'Rudulf_Geraldo', 1662926060),
('Reamy_Xhyner', 470, 'Reamy_Xhyner', 1662932159),
('Rojer_Hawkins', 560, 'Rojer_Hawkins', 1662934119),
('Duncan_Victorovich', 463, 'Duncan_Victorovich', 1662938460),
('Andrew_Wesly', 560, 'Andrew_Wesly', 1662945677),
('Axel_Volter', 560, 'Axel_Volter', 1662947185),
('Duncan_Victorovich', 463, 'Duncan_Victorovich', 1662947554),
('Abel_Petterson', 543, 'Aaron_Petterson', 1662958414),
('Dante_Gibs', 560, 'Ranz_Summers', 1662961595),
('Axel_Volter', 463, 'Vittorini_Leovince', 1662961683),
('Eduardo_Marcell', 560, 'Eduardo_Marcell', 1662972452),
('Pandu_Pangestu', 521, 'Diego_Dioo', 1662972725),
('Gun_Walters', 562, 'Budi_Alfarizi', 1662973899),
('Kudak_Deblow', 560, 'Axel_Volter', 1662981306),
('Smith_Martin', 560, 'Smith_Martin', 1662984113),
('Smith_Martin', 560, 'Smith_Martin', 1662984855),
('Rojer_Hawkins', 568, 'Gun_Walters', 1662985068),
('Vittorini_Leovince', 586, 'Kudak_Deblow', 1662985213),
('Popix_Vicente', 496, 'Popix_Vicente', 1662987300),
('George_Walsh', 543, 'Aaron_Petterson', 1662987780),
('Zeroz_Namikaze', 521, 'Diego_Dioo', 1662992347),
('Ronald_Christopher', 554, 'Abel_Petterson', 1662996602),
('Frenzy_Shinigami', 562, 'Gun_Walters', 1662997197),
('Justina_Xie', 560, 'Justina_Xie', 1662997807),
('Patrick_Benjamin', 521, 'Synester_Vengeance', 1663002206),
('Andrey_Rodriguez', 560, 'Hazel_Leone', 1663002496),
('Pance_Knight', 468, 'Tokugawa_Ieyasu', 1663004768),
('Axel_Volter', 560, 'Axel_Volter', 1663006750),
('Owen_Knight', 521, 'Owen_Knight', 1663007844),
('Duncan_Victorovich', 463, 'Duncan_Victorovich', 1663008272),
('Budi_Alfarizi', 562, 'Budi_Alfarizi', 1663017135),
('Ken_Mang', 477, 'Ken_Mang', 1663043602),
('Samuel_Ramirez', 541, 'Samuel_Ramirez', 1663049161),
('Smith_Martin', 499, 'Edward_Francisco', 1663052741),
('Smith_Martin', 462, 'Antonio_Ramorez', 1663052742),
('Smith_Martin', 560, 'Ronald_Christopher', 1663052742),
('Smith_Martin', 468, 'Edward_Francisco', 1663052742),
('Smith_Martin', 521, 'Asep_Nurohman', 1663052742),
('Smith_Martin', 562, 'Smith_Martin', 1663052742),
('Qenzo_Zevallo', 462, 'Asep_Nurohman', 1663054252),
('Ronald_Christopher', 560, 'Ronald_Christopher', 1663057085),
('Smith_Martin', 462, 'Vittorini_Leovince', 1663059953),
('Vittorini_Leovince', 521, 'Diego_Dioo', 1663061233),
('Tokugawa_Ieyasu', 415, 'Tokugawa_Ieyasu', 1663064623),
('Popix_Vicente', 496, 'Popix_Vicente', 1663067966),
('Ronald_Christopher', 463, 'Ronald_Christopher', 1663073418),
('Abel_Petterson', 463, 'Abel_Petterson', 1663073437),
('Rojer_Hawkins', 560, 'Rojer_Hawkins', 1663077467),
('Jerome_Smith', 506, 'Jerome_Smith', 1663077662),
('Slei_Oconner', 499, 'Pandu_Pangestu', 1663078248),
('Vittorini_Leovince', 500, 'Alex_Tuna', 1663078581),
('Jerome_Smith', 506, 'Jerome_Smith', 1663079177),
('Guilherme_Leao', 560, 'Guilherme_Leao', 1663079271),
('Lana_Coraline', 560, 'Lana_Coraline', 1663080309),
('Diego_Dioo', 468, 'Olmero_Estevanez', 1663083247),
('Patrick_Benjamin', 560, 'Patrick_Benjamin', 1663087428),
('Frankie_Charles', 560, 'Rudulf_Geraldo', 1663088679),
('Owen_Knight', 559, 'Owen_Knight', 1663099937),
('Shin_Fushima', 422, 'Shin_Fushima', 1663118461),
('Jerome_Smith', 506, 'Jerome_Smith', 1663119895),
('Ken_Mang', 422, 'Ken_Mang', 1663137455),
('Synester_Vengeance', 470, 'Synester_Vengeance', 1663137620),
('Synester_Vengeance', 440, 'Synester_Vengeance', 1663137620),
('Xaviano_Leyva', 562, 'Xaviano_Leyva', 1663142153),
('Ary_Charleston', 543, 'Slei_Oconner', 1663145346),
('Owen_Knight', 559, 'Owen_Knight', 1663147637),
('Ken_Mang', 543, 'Ken_Mang', 1663153301),
('Vittorini_Leovince', 542, 'Axel_Volter', 1663154000),
('Vittorini_Leovince', 499, 'Axel_Volter', 1663154000),
('Vittorini_Leovince', 542, 'Kudak_Deblow', 1663154000),
('Vittorini_Leovince', 531, 'Vittorini_Leovince', 1663154001),
('Vittorini_Leovince', 500, 'Vittorini_Leovince', 1663154001),
('Vittorini_Leovince', 579, 'Vittorini_Leovince', 1663154001),
('Ayip_Carlos', 499, 'Federico_Gavi', 1663160748),
('Samuel_Ramirez', 541, 'Samuel_Ramirez', 1663160990),
('George_Walsh', 543, 'George_Walsh', 1663230828);

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `product` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `posX` float DEFAULT NULL,
  `posY` float DEFAULT NULL,
  `posZ` float DEFAULT NULL,
  `posA` float DEFAULT NULL,
  `expired` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `carstorage`
--

CREATE TABLE `carstorage` (
  `itemID` int(11) NOT NULL,
  `itemVehicle` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) UNSIGNED DEFAULT 0,
  `itemQuantity` int(12) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carstorage`
--

INSERT INTO `carstorage` (`itemID`, `itemVehicle`, `itemName`, `itemModel`, `itemQuantity`) VALUES
(7, 167, 'Marijuana', 1578, 1000),
(8, 167, 'Marijuana', 1578, 1000),
(12, 167, 'Marijuana', 1578, 1000),
(24, 296, 'Marijuana', 1578, 1000),
(39, 272, 'Cocaine', 1575, 190),
(40, 272, 'LSD', 1578, 199),
(41, 270, 'Ecstasy', 1575, 190),
(42, 282, 'Component', 18633, 1355),
(78, 145, 'Component', 18633, 2000),
(82, 163, 'Marijuana', 1578, 920),
(90, 412, 'Marijuana', 1578, 2),
(99, 421, 'Component', 18633, 138),
(116, 153, 'Materials', 11746, 39600),
(117, 448, 'Marijuana', 1578, 10),
(119, 295, 'Cocaine', 1575, 25),
(123, 412, 'Heroin', 1577, 2),
(125, 295, 'Marijuana', 1578, 75),
(141, 312, 'Component', 18633, 2000),
(143, 312, 'Component', 18633, 2000),
(144, 312, 'Component', 18633, 2000),
(154, 300, 'Component', 18633, 2000),
(155, 300, 'Component', 18633, 140),
(157, 173, 'Marijuana', 1578, 970),
(161, 294, 'Marijuana', 1578, 21),
(162, 294, 'LSD', 1578, 2),
(167, 369, 'Component', 18633, 2000),
(170, 412, 'Cocaine', 1575, 20),
(172, 381, 'Component', 18633, 2000),
(174, 381, 'Component', 18633, 2000),
(177, 163, 'Materials', 11746, 4605),
(178, 163, 'Marijuana', 1578, 935),
(179, 418, 'Materials', 11746, 310),
(186, 242, 'Marijuana', 1578, 5),
(193, 316, 'Cocaine', 1575, 5),
(194, 316, 'Heroin', 1577, 10),
(195, 295, 'Materials', 11746, 1100),
(196, 145, 'Component', 18633, 2000),
(197, 307, 'Marijuana', 1578, 905),
(198, 173, 'Materials', 11746, 2000),
(199, 381, 'Component', 18633, 1036),
(200, 300, 'Component', 18633, 1400),
(203, 240, 'Cocaine Seeds', 1575, 50),
(204, 240, 'Heroin Opium Seeds', 1577, 50),
(205, 242, 'Marijuana Seeds', 1578, 100);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `ID` int(12) NOT NULL,
  `Username` varchar(24) DEFAULT NULL,
  `password` varchar(65) DEFAULT NULL,
  `salt` varchar(65) DEFAULT NULL,
  `Character` varchar(24) DEFAULT NULL,
  `Admin` int(11) DEFAULT NULL,
  `Created` int(4) DEFAULT 0,
  `Gender` int(4) DEFAULT 0,
  `Birthdate` varchar(32) DEFAULT '01/01/1970',
  `Origin` varchar(32) DEFAULT 'Not Specified',
  `Skin` int(12) DEFAULT 0,
  `Glasses` int(12) DEFAULT 0,
  `Hat` int(12) DEFAULT 0,
  `Bandana` int(12) DEFAULT 0,
  `PosX` float DEFAULT 0,
  `PosY` float DEFAULT 0,
  `PosZ` float DEFAULT 0,
  `PosA` float DEFAULT 0,
  `Interior` int(12) DEFAULT 0,
  `World` int(12) DEFAULT 0,
  `Hospital` int(12) DEFAULT -1,
  `HospitalInt` int(12) DEFAULT 0,
  `Money` int(12) DEFAULT 500,
  `BankMoney` int(12) DEFAULT 1000,
  `OwnsBillboard` int(12) DEFAULT -1,
  `Savings` int(12) DEFAULT 0,
  `JailTime` int(12) DEFAULT 0,
  `Muted` int(4) DEFAULT 0,
  `CreateDate` int(12) DEFAULT 0,
  `LastLogin` varchar(40) DEFAULT 'None',
  `Tester` int(4) DEFAULT 0,
  `Gun1` int(12) DEFAULT 0,
  `Gun2` int(12) DEFAULT 0,
  `Gun3` int(12) DEFAULT 0,
  `Gun4` int(12) DEFAULT 0,
  `Gun5` int(12) DEFAULT 0,
  `Gun6` int(12) DEFAULT 0,
  `Gun7` int(12) DEFAULT 0,
  `Gun8` int(12) DEFAULT 0,
  `Gun9` int(12) DEFAULT 0,
  `Gun10` int(12) DEFAULT 0,
  `Gun11` int(12) DEFAULT 0,
  `Gun12` int(12) DEFAULT 0,
  `Gun13` int(12) DEFAULT 0,
  `Ammo1` int(12) DEFAULT 0,
  `Ammo2` int(12) DEFAULT 0,
  `Ammo3` int(12) DEFAULT 0,
  `Ammo4` int(12) DEFAULT 0,
  `Ammo5` int(12) DEFAULT 0,
  `Ammo6` int(12) DEFAULT 0,
  `Ammo7` int(12) DEFAULT 0,
  `Ammo8` int(12) DEFAULT 0,
  `Ammo9` int(12) DEFAULT 0,
  `Ammo10` int(12) DEFAULT 0,
  `Ammo11` int(12) DEFAULT 0,
  `Ammo12` int(12) DEFAULT 0,
  `Ammo13` int(12) DEFAULT 0,
  `GunStatus13` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus1` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus2` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus3` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus4` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus5` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus6` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus7` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus8` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus9` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus10` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus11` smallint(5) UNSIGNED DEFAULT NULL,
  `GunStatus12` smallint(5) UNSIGNED DEFAULT NULL,
  `House` int(12) DEFAULT -1,
  `Business` int(12) DEFAULT -1,
  `Phone` int(12) DEFAULT 0,
  `Lottery` int(12) DEFAULT 0,
  `Hunger` float DEFAULT 100,
  `Bladder` float DEFAULT 100,
  `Energy` float DEFAULT 100,
  `PlayingHours` int(12) DEFAULT 0,
  `Minutes` int(12) DEFAULT 0,
  `ArmorStatus` float DEFAULT 0,
  `Entrance` int(12) DEFAULT 0,
  `Job` int(12) DEFAULT 0,
  `Faction` int(12) DEFAULT -1,
  `FactionRank` int(12) DEFAULT 0,
  `FactionDiv` int(12) DEFAULT 0,
  `Prisoned` int(4) DEFAULT 0,
  `Warrants` int(12) DEFAULT 0,
  `Injured` int(4) DEFAULT 0,
  `Health` float DEFAULT 0,
  `Channel` int(12) UNSIGNED NOT NULL DEFAULT 0,
  `Accent` varchar(24) DEFAULT NULL,
  `Bleeding` int(4) DEFAULT 0,
  `Warnings` int(12) DEFAULT 0,
  `Warn1` varchar(32) DEFAULT NULL,
  `Warn2` varchar(32) DEFAULT NULL,
  `MaskID` int(12) DEFAULT 0,
  `FactionMod` int(12) DEFAULT 0,
  `Capacity` int(12) DEFAULT 35 COMMENT 'kapasitas inventory karakter',
  `AdminHide` int(4) DEFAULT 0,
  `LotteryB` int(11) DEFAULT 0,
  `SpawnPoint` int(11) DEFAULT 0,
  `aname` varchar(24) NOT NULL DEFAULT 'none',
  `pScore` int(11) DEFAULT 1,
  `reputasi` int(11) DEFAULT NULL,
  `JailReason` varchar(225) NOT NULL DEFAULT 'Unknown Reason',
  `RankName` varchar(35) NOT NULL DEFAULT 'none',
  `reputasiadmin` int(11) DEFAULT NULL,
  `MinutesRep` int(11) DEFAULT NULL,
  `CanRep` int(11) DEFAULT NULL,
  `JobLeave` int(11) DEFAULT 0,
  `JobTime` int(11) DEFAULT NULL,
  `JobSide` int(11) DEFAULT NULL,
  `FactionDuty` int(11) DEFAULT 0,
  `LoginSkin` int(11) DEFAULT NULL,
  `Paycheck` int(11) DEFAULT NULL,
  `DrivingLicense` int(10) UNSIGNED DEFAULT 0,
  `DrivingLicenseExpired` int(11) DEFAULT 0,
  `Played` varchar(64) DEFAULT NULL,
  `Alias` varchar(24) DEFAULT 'Player',
  `Work` int(11) NOT NULL DEFAULT 0,
  `DelayFishing` int(11) UNSIGNED DEFAULT 0,
  `DelayTruck` int(11) DEFAULT 0,
  `LoginDate` varchar(50) DEFAULT NULL,
  `RegisterDate` varchar(50) DEFAULT '0',
  `IP` varchar(32) DEFAULT NULL,
  `SkinFaction` int(10) UNSIGNED DEFAULT 0,
  `Component` int(10) UNSIGNED DEFAULT NULL,
  `Fish0` varchar(24) DEFAULT NULL,
  `Fish1` varchar(24) DEFAULT NULL,
  `Fish2` varchar(24) DEFAULT NULL,
  `Fish3` varchar(24) DEFAULT NULL,
  `Fish4` varchar(24) DEFAULT NULL,
  `Fish5` varchar(24) DEFAULT NULL,
  `Fish6` varchar(24) DEFAULT NULL,
  `Fish7` varchar(24) DEFAULT NULL,
  `Fish8` varchar(24) DEFAULT NULL,
  `Fish9` varchar(24) DEFAULT NULL,
  `Fish10` varchar(24) DEFAULT NULL,
  `Fish11` varchar(24) DEFAULT NULL,
  `Fish12` varchar(24) DEFAULT NULL,
  `Fish13` varchar(24) DEFAULT NULL,
  `Fish14` varchar(24) DEFAULT NULL,
  `Fish15` varchar(24) DEFAULT NULL,
  `Fish16` varchar(24) DEFAULT NULL,
  `Fish17` varchar(24) DEFAULT NULL,
  `Fish18` varchar(24) DEFAULT NULL,
  `Fish19` varchar(24) DEFAULT NULL,
  `Fish20` varchar(24) DEFAULT NULL,
  `Fish21` varchar(24) DEFAULT NULL,
  `Fish22` varchar(24) DEFAULT NULL,
  `Fish23` varchar(24) DEFAULT NULL,
  `Fish24` varchar(24) DEFAULT NULL,
  `WoodDelay` int(10) UNSIGNED DEFAULT 0,
  `BusinessLicense` int(10) UNSIGNED DEFAULT 0,
  `BusinessLicenseExpired` int(25) UNSIGNED DEFAULT 0,
  `WorkshopLicense` int(10) UNSIGNED DEFAULT 0,
  `WorkshopLicenseExpired` int(25) UNSIGNED DEFAULT 0,
  `FirearmLicense` int(10) UNSIGNED DEFAULT 0,
  `FirearmLicenseExpired` int(25) UNSIGNED DEFAULT 0,
  `LumberLicense` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `LumberLicenseExpired` int(25) UNSIGNED NOT NULL DEFAULT 0,
  `LumberDelay` int(10) UNSIGNED DEFAULT 0,
  `AdjWep` tinyint(3) UNSIGNED DEFAULT 0,
  `Badge` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Damage0` varchar(128) NOT NULL DEFAULT 'None',
  `Damage1` varchar(128) NOT NULL DEFAULT 'None',
  `Damage2` varchar(128) NOT NULL DEFAULT 'None',
  `Damage3` varchar(128) NOT NULL DEFAULT 'None',
  `Damage4` varchar(128) NOT NULL DEFAULT 'None',
  `Damage5` varchar(128) NOT NULL DEFAULT 'None',
  `Damage6` varchar(128) NOT NULL DEFAULT 'None',
  `Damage7` varchar(128) NOT NULL DEFAULT 'None',
  `Damage8` varchar(128) NOT NULL DEFAULT 'None',
  `Damage9` varchar(128) NOT NULL DEFAULT 'None',
  `UsePills` int(10) UNSIGNED DEFAULT 0,
  `CoughPills` int(10) UNSIGNED DEFAULT NULL,
  `MigrainPills` int(10) UNSIGNED DEFAULT 0,
  `FiverPills` int(10) UNSIGNED DEFAULT 0,
  `MigrainUsed` int(10) UNSIGNED DEFAULT 0,
  `FeverUsed` int(10) UNSIGNED DEFAULT 0,
  `Cough` int(10) UNSIGNED DEFAULT 0,
  `MigrainTime` int(10) UNSIGNED DEFAULT NULL,
  `MigrainRate` int(10) UNSIGNED DEFAULT NULL,
  `Fever` int(10) UNSIGNED DEFAULT NULL,
  `Garage` int(10) DEFAULT 0,
  `GunAuthority` int(10) UNSIGNED DEFAULT 0,
  `FurnStore` int(11) NOT NULL DEFAULT -1,
  `DMVTime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `SweeperDelay` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `BusDelay` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Cuffed` int(10) DEFAULT 0,
  `Influencer` int(6) DEFAULT NULL,
  `JailedBy` varchar(25) DEFAULT NULL,
  `GiveupTime` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `FightStyle` int(5) NOT NULL DEFAULT 0,
  `MechanicLevel` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `MechanicEXP` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `DrugEffect` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `DrugHeroin` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `DrugCocaine` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `Love` float NOT NULL DEFAULT 0,
  `PartnerName` varchar(50) NOT NULL DEFAULT 'Single',
  `PartnerID` int(10) NOT NULL DEFAULT 0,
  `PartnerGift` int(20) UNSIGNED NOT NULL DEFAULT 0,
  `Status` int(5) NOT NULL DEFAULT 0,
  `SalaryDuty` int(10) NOT NULL DEFAULT 0,
  `DutyTime` int(10) NOT NULL DEFAULT 0,
  `TruckLicense` int(10) NOT NULL DEFAULT 0,
  `TruckLicenseExpired` int(10) NOT NULL DEFAULT 0,
  `MineSalary` int(10) NOT NULL DEFAULT 0,
  `UndercoverDuty` int(5) NOT NULL DEFAULT 0,
  `PhoneCredits` int(50) NOT NULL DEFAULT 0,
  `PlayerAccent` varchar(50) NOT NULL DEFAULT 'None',
  `PhoneBattery` float NOT NULL DEFAULT 100,
  `pBusinessJob` int(10) NOT NULL DEFAULT -1,
  `pBusinessDuty` int(10) NOT NULL DEFAULT 0,
  `pBusinessDutyHour` int(10) NOT NULL DEFAULT 0,
  `pExperience` int(5) NOT NULL DEFAULT 0,
  `Bandage` int(5) NOT NULL DEFAULT 0,
  `BLSLicense` int(5) NOT NULL DEFAULT 0,
  `BLSLicenseExpired` int(5) NOT NULL DEFAULT 0,
  `Freq0` int(5) NOT NULL DEFAULT 0,
  `Freq1` int(5) NOT NULL DEFAULT 0,
  `Freq2` int(5) NOT NULL DEFAULT 0,
  `Freq3` int(5) NOT NULL DEFAULT 0,
  `Freq4` int(5) NOT NULL DEFAULT 0,
  `Freq5` int(5) NOT NULL DEFAULT 0,
  `LiveMode` int(11) NOT NULL DEFAULT 0,
  `ParkedVehicle` int(5) NOT NULL DEFAULT 0,
  `pTogOOC` int(5) NOT NULL DEFAULT 0,
  `pTogPM` int(5) NOT NULL DEFAULT 0,
  `pTogBC` int(5) NOT NULL DEFAULT 0,
  `pTogLogin` int(5) NOT NULL DEFAULT 0,
  `pTogAnim` int(5) NOT NULL DEFAULT 0,
  `pTogRelation` int(5) NOT NULL DEFAULT 0,
  `pTogFaction` int(5) NOT NULL DEFAULT 0,
  `Drunk` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `DrunkTime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `DeadTime` float NOT NULL DEFAULT 100,
  `MoneyTransDelay` int(11) NOT NULL DEFAULT 0,
  `BoxvilleDelay` int(11) NOT NULL DEFAULT 0,
  `last_armor` float NOT NULL DEFAULT 0,
  `Apartment` int(11) NOT NULL DEFAULT -1,
  `ApartmentBuilding` int(11) NOT NULL DEFAULT -1,
  `IDCardExpired` int(11) NOT NULL DEFAULT 0,
  `DrugLSD` int(11) NOT NULL DEFAULT 0,
  `DrugEcstasy` int(11) NOT NULL DEFAULT 0,
  `DrugSpecialEffect` int(11) NOT NULL DEFAULT 0,
  `Tied` int(11) NOT NULL DEFAULT 0,
  `pFishingSkill` float NOT NULL DEFAULT 0,
  `pHuntingSkill` float NOT NULL DEFAULT 0,
  `pLumberSkill` float NOT NULL DEFAULT 0,
  `pTruckerSkill` float NOT NULL DEFAULT 0,
  `pFarmerSkill` float NOT NULL DEFAULT 0,
  `PetModel` int(11) NOT NULL DEFAULT 0,
  `PetName` varchar(128) NOT NULL DEFAULT 'Jack',
  `HudStyle` int(11) NOT NULL DEFAULT 0,
  `FactionSalaryCollected` int(11) NOT NULL DEFAULT 0,
  `FactionSalaryResettedAt` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clothes_wardrobe`
--

CREATE TABLE `clothes_wardrobe` (
  `ID` int(11) NOT NULL,
  `houseid` int(11) NOT NULL,
  `clothesName` varchar(128) NOT NULL DEFAULT 'None',
  `clothesModel` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `ID` int(12) DEFAULT 0,
  `contactID` int(12) NOT NULL,
  `contactName` varchar(32) DEFAULT NULL,
  `contactNumber` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`ID`, `contactID`, `contactName`, `contactNumber`) VALUES
(115, 1, 'xolo', 86100),
(115, 2, 'ncim', 43203),
(113, 3, 'Arjun_Walker', 13153),
(132, 4, '13153', 13153),
(17, 5, '84266', 84266),
(9, 7, 'Bandar', 43008),
(31, 8, 'igun', 88373),
(165, 9, 'Bg egi', 93832),
(54, 10, 'Ken', 21212),
(65, 11, 'Rudulf', 84266),
(177, 12, 'Ken_Mang', 21212),
(65, 13, 'fazly', 38048),
(144, 14, 'S.Barnet', 7752),
(31, 15, 'xiojin', 33304),
(271, 16, 'James.', 17170),
(270, 17, 'Mahleek_Preston', 22235),
(288, 18, 'Rizki', 45396),
(19, 19, 'budi', 59922),
(267, 20, 'zee1', 14717),
(267, 21, 'nanang', 74749),
(65, 22, 'taxi', 1222),
(177, 23, 'Jerome_smith', 14717),
(331, 24, 'dio', 42545),
(31, 25, 'smith', 11171),
(9, 26, 'Bawahan', 98801),
(30, 28, 'popix', 98801),
(12, 29, 'police', 911),
(49, 30, 'Brown_Henskip', 16515),
(177, 31, 'Gun_walters', 88373),
(331, 32, 'siei ', 31723),
(331, 33, 'Ranz', 84322),
(30, 34, 'aiden', 22031),
(49, 35, 'AutoBahn', 22031);

-- --------------------------------------------------------

--
-- Table structure for table `crates`
--

CREATE TABLE `crates` (
  `crateID` int(12) NOT NULL,
  `crateType` int(12) DEFAULT 0,
  `crateX` float DEFAULT 0,
  `crateY` float DEFAULT 0,
  `crateZ` float DEFAULT 0,
  `crateA` float DEFAULT 0,
  `crateInterior` int(12) DEFAULT 0,
  `crateWorld` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

CREATE TABLE `damages` (
  `IDs` int(10) UNSIGNED NOT NULL,
  `weapon` int(11) UNSIGNED NOT NULL,
  `bodypart` int(11) UNSIGNED NOT NULL,
  `amount` float UNSIGNED DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `ID` int(10) UNSIGNED NOT NULL,
  `amountkevlar` float UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `damages`
--

INSERT INTO `damages` (`IDs`, `weapon`, `bodypart`, `amount`, `time`, `ID`, `amountkevlar`) VALUES
(11, 0, 0, 164.63, 1662899243, 3, 0),
(22, 0, 0, 1.32, 1662806523, 5, 0),
(38, 0, 0, 34.18, 1662807155, 7, 0),
(27, 0, 0, 9.22, 1662870008, 22, 0),
(45, 0, 0, 11.87, 1662807757, 23, 0),
(63, 0, 0, 105.23, 1662813080, 28, 0),
(72, 0, 0, 4.62, 1662890411, 36, 0),
(70, 0, 0, 5.28, 1662812734, 41, 0),
(86, 0, 0, 1.32, 1662812956, 45, 0),
(83, 0, 0, 1.32, 1662814529, 49, 0),
(67, 0, 0, 1.32, 1662815404, 53, 0),
(91, 0, 0, 0.86, 1662817482, 59, 0),
(111, 0, 0, 17.79, 1662883181, 60, 0),
(108, 0, 0, 36.54, 1663145972, 61, 0),
(95, 0, 0, 3.96, 1662817163, 62, 0),
(91, 28, 2, 2.17, 1662817841, 64, 0),
(104, 0, 0, 1.32, 1662818243, 66, 0),
(96, 0, 0, 1.32, 1662818426, 67, 0),
(90, 0, 0, 7.92, 1662818483, 68, 0),
(114, 24, 5, 46.2, 1662818897, 70, 0),
(92, 0, 0, 3.63, 1662819138, 71, 0),
(91, 24, 0, 15.23, 1662819250, 73, 0),
(115, 0, 0, 11.55, 1662824448, 74, 0),
(117, 0, 0, 2.64, 1662870892, 75, 0),
(119, 0, 0, 37.61, 1662820541, 76, 0),
(127, 0, 0, 2.64, 1663043594, 77, 0),
(129, 0, 0, 1.32, 1662820276, 78, 0),
(118, 0, 0, 1.32, 1662820751, 79, 0),
(119, 42, 0, 0.33, 1662822793, 81, 0),
(128, 0, 0, 2.64, 1662826387, 87, 0),
(113, 0, 0, 8.89, 1662826784, 88, 0),
(145, 0, 0, 37.93, 1662825926, 91, 0),
(146, 0, 0, 100.31, 1662826298, 92, 0),
(154, 0, 0, 1.32, 1662830827, 99, 0),
(151, 0, 0, 1.98, 1662831395, 103, 0),
(132, 0, 0, 6.59, 1662834602, 109, 0),
(159, 0, 0, 6.92, 1663143858, 110, 0),
(159, 24, 0, 23.1, 1662835066, 112, 0),
(4, 0, 0, 3.8, 1662877120, 121, 0),
(179, 0, 0, 2.64, 1662860049, 126, 0),
(102, 0, 0, 14.18, 1663075877, 129, 0),
(11, 41, 0, 0, 1662864288, 141, 0.33),
(51, 0, 0, 3.3, 1662869524, 142, 0),
(188, 0, 0, 1.32, 1662865592, 143, 0),
(180, 0, 0, 7.92, 1662873996, 144, 0),
(97, 0, 0, 1.32, 1662865791, 146, 0),
(26, 0, 0, 1.32, 1662866598, 148, 0),
(11, 34, 6, 100, 1662866731, 153, 0),
(11, 31, 2, 9.89, 1662866801, 157, 0),
(11, 31, 3, 9.89, 1662866801, 158, 0),
(130, 31, 0, 39.59, 1662866843, 160, 0),
(114, 0, 0, 6.26, 1662866852, 161, 0),
(11, 24, 1, 92.4, 1662866903, 167, 0),
(11, 24, 0, 0, 1662866947, 168, 92.4),
(155, 0, 0, 1.32, 1662868800, 182, 0),
(170, 0, 0, 99.98, 1662869620, 185, 0),
(41, 0, 0, 43.18, 1663074190, 187, 0),
(76, 0, 0, 7.26, 1662870334, 191, 0),
(199, 0, 0, 1.32, 1662871161, 193, 0),
(178, 0, 0, 1.32, 1662871234, 194, 0),
(95, 23, 3, 13.19, 1662873307, 198, 0),
(77, 0, 0, 19.43, 1663078374, 200, 0),
(180, 5, 0, 75, 1662873974, 203, 0),
(11, 25, 0, 118.8, 1662974384, 232, 204.58),
(11, 25, 2, 62.68, 1662974382, 234, 0),
(11, 25, 3, 6.59, 1662876830, 235, 0),
(11, 25, 1, 26.37, 1662974347, 236, 0),
(11, 23, 0, 13.18, 1662876834, 237, 0),
(11, 23, 3, 13.18, 1662876834, 238, 0),
(11, 25, 5, 33, 1662876839, 239, 0),
(11, 25, 6, 49.5, 1662876908, 240, 0),
(202, 0, 0, 2.94, 1662877473, 247, 0),
(41, 25, 3, 6.59, 1662877520, 251, 0),
(41, 25, 6, 3.25, 1662877522, 252, 0),
(41, 25, 4, 3.25, 1662877558, 254, 0),
(41, 25, 1, 6.59, 1662877559, 255, 0),
(41, 34, 0, 80, 1662877826, 271, 0),
(215, 0, 0, 12.53, 1662880353, 283, 0),
(218, 0, 0, 17.81, 1662880347, 284, 0),
(145, 24, 3, 92.4, 1662880255, 285, 0),
(232, 0, 0, 37.29, 1662884067, 294, 0),
(77, 32, 3, 13.18, 1662885957, 310, 0),
(77, 32, 0, 13.18, 1662885957, 311, 0),
(77, 31, 6, 29.7, 1662885962, 312, 0),
(77, 31, 0, 19.79, 1662885963, 313, 0),
(77, 31, 3, 9.89, 1662885963, 314, 0),
(204, 0, 0, 1.32, 1662886685, 321, 0),
(66, 0, 0, 14.51, 1662890408, 327, 0),
(241, 23, 0, 13.18, 1662893285, 333, 0),
(241, 23, 3, 26.37, 1662893287, 334, 0),
(241, 23, 1, 13.18, 1662893325, 335, 0),
(241, 0, 0, 100.3, 1662903632, 338, 0),
(255, 0, 0, 1.32, 1662900071, 349, 0),
(255, 5, 0, 4.61, 1662900146, 350, 0),
(60, 0, 0, 38.26, 1663073441, 361, 0),
(216, 0, 0, 2.64, 1662904182, 363, 0),
(26, 23, 2, 13.19, 1662904523, 377, 0),
(157, 0, 0, 85.46, 1663003810, 378, 0),
(264, 0, 0, 7.26, 1662917505, 379, 0),
(268, 0, 0, 2.64, 1662926431, 404, 0),
(269, 0, 0, 60.71, 1663053441, 406, 0),
(23, 25, 4, 13.18, 1662930020, 411, 0),
(268, 27, 0, 0, 1662930032, 412, 49.5),
(268, 27, 5, 14.85, 1662930032, 413, 0),
(268, 27, 3, 34.65, 1662930032, 414, 0),
(268, 27, 2, 59.4, 1662930033, 415, 0),
(273, 0, 0, 209.22, 1662931660, 416, 0),
(272, 0, 0, 9.89, 1662931548, 417, 0),
(174, 0, 0, 1.32, 1662965838, 433, 0),
(289, 0, 0, 6.26, 1662972850, 464, 0),
(108, 25, 1, 16.29, 1662973512, 465, 0),
(108, 25, 2, 1.08, 1662973513, 466, 0),
(301, 0, 0, 16.17, 1662975023, 479, 0),
(300, 0, 0, 1.32, 1662975023, 480, 0),
(173, 0, 0, 9.22, 1662983973, 482, 0),
(299, 0, 0, 2.99, 1663061055, 483, 0),
(299, 24, 0, 106.69, 1662977011, 497, 0),
(299, 24, 3, 15.22, 1662975432, 498, 0),
(299, 25, 0, 16.29, 1662975581, 500, 0),
(299, 25, 5, 8.71, 1662975582, 501, 0),
(302, 25, 2, 62.7, 1662975638, 502, 0),
(299, 24, 2, 15.22, 1662976162, 504, 0),
(299, 28, 3, 4.34, 1662976165, 505, 0),
(299, 28, 0, 13.06, 1662976166, 506, 0),
(23, 25, 0, 0, 1662976721, 515, 3.25),
(23, 25, 2, 6.59, 1662976722, 516, 0),
(23, 25, 1, 9.89, 1662976723, 518, 0),
(23, 24, 0, 0, 1662976734, 525, 46.2),
(23, 24, 2, 46.2, 1662976740, 531, 0),
(303, 25, 1, 26.38, 1662976809, 534, 0),
(303, 25, 2, 13.18, 1662976810, 535, 0),
(173, 5, 0, 4.61, 1662977376, 565, 0),
(299, 32, 0, 2.17, 1662977519, 570, 0),
(299, 32, 3, 2.17, 1662977523, 571, 0),
(299, 32, 4, 2.17, 1662977524, 572, 0),
(299, 32, 1, 2.17, 1662977524, 573, 0),
(299, 32, 6, 2.17, 1662977524, 574, 0),
(299, 32, 2, 4.34, 1663061364, 575, 0),
(299, 32, 5, 2.17, 1662977525, 576, 0),
(89, 0, 0, 6.6, 1662980934, 578, 0),
(64, 31, 0, 9.89, 1662995593, 641, 0),
(313, 0, 0, 28.37, 1662997947, 642, 0),
(64, 0, 0, 8.89, 1663088131, 649, 0),
(312, 0, 0, 41.9, 1662998890, 654, 0),
(315, 0, 0, 56.42, 1662998897, 655, 0),
(316, 0, 0, 0.43, 1662999108, 663, 0),
(320, 0, 0, 51.47, 1663009097, 673, 0),
(131, 0, 0, 11.88, 1663074038, 674, 0),
(321, 0, 0, 106.25, 1663003823, 676, 0),
(24, 0, 0, 17.13, 1663057205, 684, 0),
(49, 0, 0, 18.76, 1663150804, 686, 0),
(16, 32, 0, 151.75, 1663089427, 688, 65.98),
(16, 32, 6, 46.18, 1663087236, 689, 0),
(16, 32, 2, 92.36, 1663089427, 690, 0),
(16, 25, 0, 9.89, 1663008146, 698, 0),
(270, 0, 0, 46.19, 1663008473, 703, 0),
(323, 0, 0, 1.98, 1663008848, 704, 0),
(320, 24, 1, 46.2, 1663009962, 711, 0),
(314, 0, 0, 79.19, 1663011663, 717, 0),
(271, 0, 0, 19.79, 1663010276, 718, 0),
(267, 0, 0, 2.64, 1663135697, 719, 0),
(16, 0, 0, 715.09, 1663231764, 720, 0),
(106, 0, 0, 0.43, 1663033239, 721, 0),
(16, 24, 3, 107.62, 1663137195, 722, 0),
(16, 24, 0, 369.57, 1663137203, 723, 138.13),
(16, 24, 2, 277.2, 1663035481, 724, 0),
(16, 24, 4, 61.43, 1663137168, 725, 0),
(195, 5, 0, 8.27, 1663036846, 726, 0),
(16, 5, 0, 98.98, 1663075944, 727, 0),
(195, 24, 0, 45.72, 1663036954, 728, 0),
(195, 24, 2, 45.72, 1663036892, 729, 0),
(242, 0, 0, 0.43, 1663044082, 730, 0),
(159, 23, 5, 13.18, 1663053096, 748, 0),
(159, 23, 0, 0, 1663053096, 749, 13.18),
(49, 24, 3, 46.2, 1663054100, 754, 0),
(49, 24, 4, 92.4, 1663054121, 756, 0),
(337, 31, 6, 9.9, 1663054268, 757, 0),
(337, 31, 1, 19.8, 1663054274, 758, 0),
(337, 24, 0, 92.4, 1663054283, 759, 0),
(193, 0, 0, 8.56, 1663055028, 761, 0),
(329, 23, 1, 13.18, 1663058702, 774, 0),
(265, 0, 0, 18.2, 1663077069, 775, 0),
(9, 0, 0, 1.32, 1663059523, 776, 0),
(9, 4, 0, 3666.62, 1663060247, 783, 0),
(13, 0, 0, 1.32, 1663060583, 784, 0),
(16, 30, 3, 9.89, 1663061345, 785, 0),
(49, 24, 1, 92.4, 1663061408, 786, 0),
(13, 24, 1, 23.1, 1663062362, 789, 0),
(7, 25, 2, 39.59, 1663063051, 792, 0),
(7, 25, 6, 23.1, 1663063052, 793, 0),
(7, 25, 0, 42.9, 1663063059, 794, 49.5),
(7, 25, 3, 49.5, 1663063054, 795, 0),
(16, 24, 6, 138.6, 1663086881, 796, 0),
(16, 23, 1, 39.59, 1663063800, 800, 0),
(16, 23, 0, 52.79, 1663063802, 801, 0),
(16, 23, 6, 13.18, 1663063802, 802, 0),
(16, 23, 3, 26.37, 1663063811, 803, 0),
(7, 0, 0, 1.32, 1663064461, 804, 0),
(13, 29, 0, 0, 1663064766, 807, 8.25),
(13, 29, 1, 8.25, 1663064767, 808, 0),
(187, 32, 2, 26.4, 1663064794, 810, 0),
(187, 32, 0, 0, 1663064784, 817, 6.6),
(85, 32, 6, 6.59, 1663064784, 818, 0),
(187, 32, 1, 6.6, 1663064785, 819, 0),
(85, 32, 4, 13.18, 1663064792, 820, 0),
(85, 24, 0, 0, 1663064799, 821, 92.4),
(85, 32, 0, 0, 1663064792, 824, 6.59),
(187, 32, 3, 6.6, 1663064793, 826, 0),
(85, 32, 1, 6.59, 1663064793, 827, 0),
(343, 30, 6, 9.8, 1663065621, 832, 0),
(343, 30, 3, 22.86, 1663065626, 833, 0),
(343, 30, 0, 29.38, 1663065625, 834, 0),
(343, 30, 5, 3.25, 1663065622, 835, 0),
(343, 30, 2, 9.8, 1663065624, 836, 0),
(343, 30, 1, 6.53, 1663065624, 837, 0),
(343, 30, 4, 9.8, 1663065625, 838, 0),
(85, 0, 0, 7.26, 1663065649, 839, 0),
(311, 0, 0, 38.93, 1663072864, 840, 0),
(14, 0, 0, 5.28, 1663072919, 841, 0),
(352, 25, 1, 11.97, 1663067914, 842, 0),
(352, 25, 4, 5.44, 1663067915, 843, 0),
(352, 25, 0, 5.44, 1663067916, 844, 0),
(343, 0, 0, 0.43, 1663068051, 847, 0),
(226, 0, 0, 7.92, 1663069505, 848, 0),
(41, 5, 0, 17.14, 1663069585, 849, 0),
(60, 5, 0, 19.79, 1663068878, 850, 0),
(192, 5, 0, 102.94, 1663076037, 851, 0),
(226, 5, 0, 9.24, 1663069501, 852, 0),
(355, 0, 0, 5.44, 1663068888, 853, 0),
(77, 5, 0, 4.61, 1663069278, 854, 0),
(192, 0, 0, 44.22, 1663076375, 855, 0),
(16, 25, 4, 36.29, 1663069578, 856, 0),
(144, 5, 0, 2.64, 1663069710, 857, 0),
(192, 24, 3, 46.2, 1663072068, 858, 0),
(360, 0, 0, 2.72, 1663074170, 859, 0),
(360, 4, 0, 2.17, 1663072704, 860, 0),
(362, 0, 0, 1.32, 1663073405, 861, 0),
(265, 24, 6, 15.22, 1663073794, 862, 0),
(306, 0, 0, 21.77, 1663074395, 863, 0),
(327, 25, 2, 29.7, 1663074881, 864, 0),
(327, 0, 0, 9.88, 1663099708, 865, 0),
(102, 5, 0, 27.06, 1663075937, 873, 0),
(327, 5, 0, 12.52, 1663075959, 874, 0),
(265, 5, 0, 10.67, 1663075975, 875, 0),
(192, 24, 0, 0, 1663076042, 876, 2.64),
(102, 25, 4, 3.3, 1663076559, 879, 0),
(102, 33, 6, 24.75, 1663077025, 881, 0),
(265, 30, 1, 3.25, 1663077273, 882, 0),
(265, 30, 2, 9.8, 1663077775, 892, 0),
(265, 30, 3, 6.53, 1663077787, 893, 0),
(265, 30, 0, 16.3, 1663077798, 894, 0),
(274, 24, 6, 46.2, 1663078608, 897, 0),
(220, 5, 0, 25.05, 1663081166, 901, 0),
(101, 0, 0, 5.28, 1663159704, 903, 0),
(49, 5, 0, 2.64, 1663083797, 911, 0),
(144, 0, 0, 1.98, 1663084735, 919, 0),
(16, 32, 3, 52.79, 1663089426, 920, 0),
(16, 32, 1, 72.58, 1663089429, 921, 0),
(16, 32, 4, 65.98, 1663089429, 922, 0),
(123, 24, 3, 45.72, 1663085091, 923, 0),
(123, 24, 0, 30.45, 1663085169, 924, 0),
(123, 24, 1, 15.22, 1663085092, 925, 0),
(123, 24, 5, 15.22, 1663085117, 926, 0),
(123, 24, 2, 15.22, 1663085169, 927, 0),
(123, 24, 6, 15.22, 1663085169, 928, 0),
(16, 25, 2, 26.37, 1663085177, 929, 0),
(16, 4, 0, 10.56, 1663089366, 931, 0),
(64, 32, 1, 6.59, 1663086868, 932, 0),
(64, 32, 0, 0, 1663087238, 933, 22.44),
(144, 24, 3, 92.4, 1663086892, 934, 0),
(64, 32, 3, 6.59, 1663087237, 936, 0),
(16, 32, 5, 39.59, 1663089429, 937, 0),
(224, 32, 1, 6.6, 1663087255, 938, 0),
(224, 32, 3, 13.2, 1663087255, 939, 0),
(224, 32, 0, 13.2, 1663087256, 940, 0),
(224, 32, 2, 19.8, 1663087256, 941, 0),
(224, 24, 0, 2.64, 1663087278, 942, 0),
(224, 4, 0, 5.28, 1663087294, 943, 0),
(5, 0, 0, 61.38, 1663088604, 944, 0),
(62, 24, 1, 46.2, 1663089360, 946, 0),
(62, 32, 5, 6.59, 1663089367, 947, 0),
(144, 24, 0, 0, 1663089445, 949, 92.4),
(144, 24, 2, 46.2, 1663089446, 950, 0),
(62, 0, 0, 87.76, 1663154104, 952, 0),
(144, 4, 0, 2.64, 1663091255, 953, 0),
(31, 24, 0, 46.2, 1663098527, 954, 0),
(31, 24, 2, 46.2, 1663098527, 955, 0),
(31, 5, 0, 9.22, 1663161502, 957, 0),
(9, 34, 0, 400, 1663121429, 966, 0),
(31, 0, 0, 1.32, 1663121870, 967, 0),
(159, 22, 0, 0, 1663124751, 971, 16.5),
(37, 33, 6, 24.75, 1663124765, 972, 0),
(101, 33, 3, 24.75, 1663125337, 973, 0),
(101, 33, 6, 49.5, 1663125352, 974, 0),
(101, 33, 0, 24.75, 1663125351, 975, 0),
(37, 0, 0, 100.62, 1663146833, 976, 0),
(25, 0, 0, 1.32, 1663133713, 977, 0),
(267, 22, 0, 0, 1663135524, 978, 8.25),
(267, 22, 6, 8.25, 1663135525, 979, 0),
(135, 30, 0, 9.89, 1663136732, 981, 0),
(135, 24, 0, 46.2, 1663136967, 982, 0),
(135, 24, 1, 46.2, 1663136968, 983, 0),
(16, 24, 1, 15.22, 1663136975, 984, 0),
(135, 24, 2, 46.2, 1663137043, 985, 0),
(135, 24, 5, 46.2, 1663137075, 986, 0),
(135, 24, 3, 92.4, 1663145549, 987, 0),
(67, 5, 0, 4.61, 1663144270, 994, 0),
(399, 0, 0, 69.3, 1663145152, 995, 0),
(135, 0, 0, 1.32, 1663145264, 997, 0),
(135, 24, 4, 46.2, 1663145533, 1000, 0),
(40, 0, 0, 7.92, 1663148518, 1004, 0),
(213, 0, 0, 10.22, 1663147721, 1005, 0),
(17, 0, 0, 1.32, 1663148726, 1008, 0),
(221, 38, 4, 46.2, 1663153316, 1021, 0),
(221, 38, 5, 46.2, 1663153316, 1022, 0),
(221, 38, 2, 46.2, 1663153316, 1023, 0),
(221, 38, 0, 46.2, 1663153316, 1024, 0),
(69, 33, 6, 74.25, 1663158276, 1027, 0),
(194, 0, 0, 3.63, 1663160098, 1028, 0),
(416, 0, 0, 1.25, 1663160764, 1029, 0),
(416, 5, 0, 1.5, 1663161506, 1030, 0),
(196, 5, 0, 4.61, 1663161507, 1031, 0),
(18, 0, 0, 1.32, 1663162042, 1032, 0),
(196, 0, 0, 1.32, 1663162242, 1033, 0),
(126, 31, 3, 9.89, 1663165102, 1034, 0),
(126, 31, 0, 0, 1663165103, 1035, 9.89),
(126, 31, 5, 9.89, 1663165103, 1036, 0),
(79, 0, 0, 1.32, 1663165560, 1037, 0),
(14, 4, 0, 0, 1663169495, 1038, 0),
(311, 24, 0, 23.1, 1663169752, 1039, 0),
(311, 24, 2, 23.1, 1663169752, 1040, 0),
(429, 25, 0, 95.69, 1663200175, 1041, 0),
(16, 22, 3, 2.72, 1663211694, 1042, 0),
(37, 24, 2, 46.2, 1663211697, 1043, 0),
(37, 24, 0, 2.64, 1663211701, 1044, 92.4),
(37, 5, 0, 612.46, 1663211936, 1045, 0),
(23, 0, 0, 1.32, 1663221930, 1046, 0),
(340, 0, 0, 1.32, 1663223740, 1047, 0),
(335, 25, 4, 39.59, 1663223756, 1048, 0),
(340, 25, 4, 9.9, 1663223770, 1049, 0),
(335, 25, 5, 49.5, 1663223771, 1050, 0),
(340, 25, 2, 42.9, 1663223775, 1051, 0),
(340, 25, 6, 95.7, 1663223805, 1052, 0),
(13, 25, 1, 39.6, 1663230611, 1053, 0),
(15, 32, 0, 0, 1663230949, 1054, 6.59),
(15, 30, 2, 79.2, 1663231691, 1055, 0),
(15, 0, 0, 7.59, 1663231112, 1056, 0),
(15, 5, 0, 47.51, 1663231192, 1057, 0),
(15, 30, 0, 277.19, 1663231691, 1058, 89.1),
(15, 30, 3, 108.9, 1663231746, 1059, 0),
(15, 30, 1, 188.09, 1663231689, 1060, 0),
(15, 30, 6, 19.79, 1663231538, 1061, 0),
(15, 30, 4, 29.69, 1663231594, 1062, 0),
(15, 30, 5, 19.79, 1663231589, 1063, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dealer`
--

CREATE TABLE `dealer` (
  `ID` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Lock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealership`
--

CREATE TABLE `dealership` (
  `ID` int(11) NOT NULL,
  `Lock` int(11) NOT NULL DEFAULT 0,
  `Stock` int(11) NOT NULL DEFAULT 0,
  `Name` varchar(32) NOT NULL DEFAULT 'None',
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `SpawnX` float NOT NULL DEFAULT 0,
  `SpawnY` float NOT NULL DEFAULT 0,
  `SpawnZ` float NOT NULL DEFAULT 0,
  `SpawnRZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dealership`
--

INSERT INTO `dealership` (`ID`, `Lock`, `Stock`, `Name`, `PosX`, `PosY`, `PosZ`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnRZ`) VALUES
(1, 0, 87, 'Grotti Dealership', 542.46, -1293.03, 17.24, 564.445, -1284.84, 17.2482, 16.8396),
(2, 0, 73, 'Job Dealer', 1990.67, -1991.33, 13.55, 1985.53, -1988.55, 13.5468, 84.9042);

-- --------------------------------------------------------

--
-- Table structure for table `dealervehicle`
--

CREATE TABLE `dealervehicle` (
  `ID` int(11) NOT NULL,
  `Dealer` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealervehicles`
--

CREATE TABLE `dealervehicles` (
  `ID` int(12) DEFAULT 0,
  `vehID` int(12) NOT NULL,
  `vehModel` int(12) DEFAULT 0,
  `vehPrice` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealer_vehicles`
--

CREATE TABLE `dealer_vehicles` (
  `dealer_id` int(11) NOT NULL,
  `model` mediumint(3) UNSIGNED NOT NULL,
  `price` int(7) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dealer_vehicles`
--

INSERT INTO `dealer_vehicles` (`dealer_id`, `model`, `price`) VALUES
(1, 415, 20000),
(1, 558, 17000),
(1, 560, 15000),
(1, 562, 10000),
(2, 422, 2500),
(2, 525, 2500),
(2, 531, 3000),
(2, 543, 2500),
(2, 554, 3000);

-- --------------------------------------------------------

--
-- Table structure for table `detectors`
--

CREATE TABLE `detectors` (
  `detectorID` int(12) NOT NULL,
  `detectorX` float DEFAULT 0,
  `detectorY` float DEFAULT 0,
  `detectorZ` float DEFAULT 0,
  `detectorAngle` float DEFAULT 0,
  `detectorInterior` int(12) DEFAULT 0,
  `detectorWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `discord`
--

CREATE TABLE `discord` (
  `ID` int(12) NOT NULL,
  `DiscordID` varchar(64) NOT NULL,
  `Code` int(4) NOT NULL DEFAULT 0,
  `Active` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `donation_characters`
--

CREATE TABLE `donation_characters` (
  `pid` int(10) UNSIGNED NOT NULL,
  `name` varchar(24) DEFAULT NULL,
  `type` tinyint(1) UNSIGNED DEFAULT NULL,
  `expired` int(10) UNSIGNED DEFAULT NULL,
  `changename` tinyint(2) UNSIGNED DEFAULT 0,
  `changephone` tinyint(2) UNSIGNED DEFAULT 0,
  `changemask` tinyint(2) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donation_characters`
--

INSERT INTO `donation_characters` (`pid`, `name`, `type`, `expired`, `changename`, `changephone`, `changemask`) VALUES
(1, 'Cyrill_Sylvestre', 4, 1677341319, 3, 3, 3),
(7, 'Berlin_Varcelo', 4, 1665497137, 3, 3, 3),
(11, 'Plutarco_Echeverra', 3, 1665498235, 2, 3, 3),
(15, 'Oscar_Vengeance', 1, 1665491353, 0, 1, 1),
(19, 'Gun_Walters', 3, 1670764669, 2, 3, 3),
(27, 'Branz_Sanzu', 1, 1665495757, 0, 1, 1),
(67, 'Frenzy_Shinigami', 4, 1665705681, 3, 3, 3),
(77, 'Pandu_Pangestu', 4, 1726011526, 3, 3, 3),
(105, 'Kenzo_Devalos', 1, 1665502628, 0, 1, 1),
(187, 'Jackson_Alexander', 1, 1665492715, 0, 1, 1),
(210, 'Cho_Tabim', 4, 1665701742, 3, 3, 3),
(271, 'Mahleek_Preston', 2, 1665567617, 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `donation_coins`
--

CREATE TABLE `donation_coins` (
  `id` int(11) NOT NULL,
  `code` varchar(16) NOT NULL,
  `added_by` varchar(24) NOT NULL,
  `coin` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `donation_coin_list`
--

CREATE TABLE `donation_coin_list` (
  `pid` int(10) UNSIGNED NOT NULL,
  `coins` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donation_coin_list`
--

INSERT INTO `donation_coin_list` (`pid`, `coins`) VALUES
(1, 2500),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 2500),
(8, 0),
(9, 0),
(10, 0),
(11, 1000),
(12, 0),
(13, 0),
(14, 0),
(15, 250),
(16, 0),
(17, 0),
(18, 0),
(19, 1000),
(20, 0),
(21, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 250),
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0),
(38, 0),
(40, 0),
(41, 0),
(44, 0),
(46, 0),
(47, 0),
(48, 0),
(49, 0),
(51, 0),
(53, 0),
(54, 0),
(55, 0),
(57, 0),
(58, 0),
(60, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 2500),
(68, 0),
(69, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(76, 0),
(77, 2500),
(78, 0),
(79, 0),
(80, 0),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(95, 0),
(96, 0),
(97, 0),
(98, 0),
(99, 0),
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 250),
(106, 0),
(108, 0),
(110, 0),
(111, 0),
(113, 0),
(114, 0),
(115, 0),
(116, 0),
(117, 0),
(119, 0),
(121, 0),
(122, 0),
(123, 0),
(124, 0),
(125, 0),
(126, 0),
(127, 0),
(130, 0),
(131, 0),
(132, 0),
(133, 0),
(134, 0),
(135, 0),
(136, 0),
(137, 0),
(138, 0),
(139, 0),
(140, 0),
(141, 0),
(142, 0),
(143, 0),
(144, 0),
(145, 0),
(147, 0),
(148, 0),
(150, 0),
(151, 0),
(152, 0),
(153, 0),
(155, 0),
(156, 0),
(157, 0),
(158, 0),
(159, 0),
(160, 0),
(161, 0),
(163, 0),
(164, 0),
(165, 0),
(166, 0),
(170, 0),
(172, 0),
(173, 0),
(174, 0),
(175, 0),
(177, 0),
(178, 0),
(180, 0),
(181, 0),
(182, 0),
(183, 0),
(184, 0),
(185, 0),
(186, 0),
(187, 250),
(188, 0),
(190, 0),
(192, 0),
(193, 0),
(194, 0),
(195, 0),
(196, 0),
(199, 0),
(200, 0),
(202, 0),
(204, 0),
(205, 0),
(207, 0),
(209, 0),
(210, 2750),
(213, 0),
(214, 0),
(216, 0),
(217, 0),
(219, 0),
(220, 0),
(221, 0),
(222, 0),
(223, 0),
(224, 0),
(225, 0),
(226, 0),
(230, 0),
(232, 0),
(233, 0),
(234, 0),
(236, 0),
(237, 0),
(238, 0),
(239, 0),
(240, 0),
(241, 0),
(242, 0),
(243, 0),
(247, 0),
(248, 0),
(252, 0),
(254, 0),
(255, 0),
(256, 0),
(257, 0),
(258, 0),
(260, 0),
(264, 0),
(265, 0),
(266, 0),
(267, 0),
(268, 0),
(269, 0),
(270, 0),
(271, 1000),
(272, 0),
(274, 0),
(275, 0),
(277, 0),
(281, 0),
(284, 0),
(286, 0),
(288, 0),
(289, 0),
(291, 0),
(292, 0),
(294, 0),
(295, 0),
(296, 0),
(297, 0),
(299, 0),
(300, 0),
(301, 0),
(302, 0),
(303, 0),
(304, 0),
(305, 0),
(306, 0),
(307, 0),
(309, 0),
(310, 0),
(311, 0),
(312, 0),
(313, 0),
(314, 0),
(315, 0),
(316, 0),
(318, 0),
(319, 0),
(320, 0),
(321, 0),
(322, 0),
(325, 0),
(326, 0),
(327, 0),
(328, 0),
(329, 0),
(331, 0),
(333, 0),
(334, 0),
(335, 0),
(336, 0),
(338, 0),
(340, 0),
(342, 0),
(343, 0),
(344, 0),
(345, 0),
(346, 0),
(352, 0),
(353, 0),
(354, 0),
(357, 0),
(358, 0),
(359, 0),
(360, 0),
(361, 0),
(363, 0),
(364, 0),
(365, 0),
(368, 0),
(370, 0),
(371, 0),
(376, 0),
(379, 0),
(380, 0),
(381, 0),
(382, 0),
(383, 0),
(385, 0),
(386, 0),
(388, 0),
(389, 0),
(391, 0),
(392, 0),
(393, 0),
(398, 0),
(402, 0),
(403, 0),
(404, 0),
(409, 0),
(412, 0),
(416, 0),
(423, 0),
(424, 0),
(429, 0),
(23872, 0);

-- --------------------------------------------------------

--
-- Table structure for table `donation_token`
--

CREATE TABLE `donation_token` (
  `id` int(11) NOT NULL,
  `code` varchar(16) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `added_by` varchar(24) NOT NULL,
  `expired` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donation_token`
--

INSERT INTO `donation_token` (`id`, `code`, `type`, `added_by`, `expired`) VALUES
(13, 'U-SNVN3694', 3, 'pandu', 1665705720);

-- --------------------------------------------------------

--
-- Table structure for table `donation_vehicles`
--

CREATE TABLE `donation_vehicles` (
  `model` smallint(4) UNSIGNED NOT NULL,
  `coin` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donation_vehicles`
--

INSERT INTO `donation_vehicles` (`model`, `coin`) VALUES
(411, 500);

-- --------------------------------------------------------

--
-- Table structure for table `dropped`
--

CREATE TABLE `dropped` (
  `ID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemX` float DEFAULT 0,
  `itemY` float DEFAULT 0,
  `itemZ` float DEFAULT 0,
  `itemInt` int(12) DEFAULT 0,
  `itemWorld` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0,
  `itemAmmo` int(12) DEFAULT 0,
  `itemWeapon` int(12) DEFAULT 0,
  `itemPlayer` varchar(24) DEFAULT NULL,
  `itemTime` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `droppedweapon`
--

CREATE TABLE `droppedweapon` (
  `ID` int(11) NOT NULL,
  `dropby` varchar(24) NOT NULL,
  `interior` int(10) UNSIGNED NOT NULL,
  `vw` int(10) UNSIGNED NOT NULL,
  `weapon` int(10) UNSIGNED NOT NULL,
  `ammo` int(10) UNSIGNED NOT NULL,
  `durability` int(10) UNSIGNED NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `expired` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `efurniture`
--

CREATE TABLE `efurniture` (
  `id` int(11) NOT NULL,
  `Placed` int(11) NOT NULL,
  `Xpos` float NOT NULL,
  `Ypos` float NOT NULL,
  `Zpos` float NOT NULL,
  `Xrot` float NOT NULL,
  `Yrot` float NOT NULL,
  `Zrot` float NOT NULL,
  `HouseSQLID` int(11) NOT NULL,
  `Model` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

CREATE TABLE `entrances` (
  `entranceID` int(12) NOT NULL,
  `entranceName` varchar(32) DEFAULT NULL,
  `entranceIcon` int(12) DEFAULT 0,
  `entrancePosX` float DEFAULT 0,
  `entrancePosY` float DEFAULT 0,
  `entrancePosZ` float DEFAULT 0,
  `entrancePosA` float DEFAULT 0,
  `entranceIntX` float DEFAULT 0,
  `entranceIntY` float DEFAULT 0,
  `entranceIntZ` float DEFAULT 0,
  `entranceIntA` float DEFAULT 0,
  `entranceInterior` int(12) DEFAULT 0,
  `entranceExterior` int(12) DEFAULT 0,
  `entranceExteriorVW` int(12) DEFAULT 0,
  `entranceType` int(12) DEFAULT 0,
  `entrancePass` varchar(32) DEFAULT NULL,
  `entranceLocked` int(12) DEFAULT 0,
  `entranceCustom` int(4) DEFAULT 0,
  `entranceWorld` int(12) DEFAULT 0,
  `entranceVehAble` smallint(2) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entrances`
--

INSERT INTO `entrances` (`entranceID`, `entranceName`, `entranceIcon`, `entrancePosX`, `entrancePosY`, `entrancePosZ`, `entrancePosA`, `entranceIntX`, `entranceIntY`, `entranceIntZ`, `entranceIntA`, `entranceInterior`, `entranceExterior`, `entranceExteriorVW`, `entranceType`, `entrancePass`, `entranceLocked`, `entranceCustom`, `entranceWorld`, `entranceVehAble`) VALUES
(170, 'Los Santos Police Departement', 0, 1555.5, -1675.63, 16.1951, 270.076, -1080.39, -975.097, 129.305, 182.352, 15, 0, 0, 0, '', 0, 0, 7170, 0),
(171, 'Los Santos City Hall', 0, 1481.04, -1772.02, 18.7957, 178.555, 1523.55, 1566.16, 15.8732, 173.748, 13, 0, 0, 3, '', 0, 0, 7171, 0),
(172, 'All Saints General Hospital', 0, 1172.28, -1323.51, 15.4033, 274.93, 1849.52, -1072.2, 41.6537, 96.0957, 110, 0, 0, 0, '', 0, 0, 100000, 0),
(173, 'Radeo Bank', 0, 593.645, -1250.96, 18.2539, 197.903, 513.026, -1303.49, 1021.62, 107.026, 4, 0, 0, 2, '', 0, 0, 7173, 0),
(174, 'SANews Agency', 0, 649.151, -1357.28, 13.567, 88.2975, 664.381, -1387.85, 801.359, 174.108, 7, 0, 0, 10, '', 0, 0, 7174, 0),
(175, 'Fish Factory', 0, 101.317, -1818.96, 2.5099, 170.792, 1353.65, 1326.06, 10.8858, 260.5, 6, 0, 0, 9, '', 0, 0, 7175, 0),
(176, 'DMV', 0, 1081.17, -1696.99, 13.5466, 185.202, -2029.55, -118.8, 1035.17, 0, 3, 0, 0, 1, '', 0, 0, 7176, 0),
(177, 'Parking', 0, -1069.99, -946.505, 130.355, 359.208, 1568.56, -1689.97, 6.2185, 356.654, 0, 15, 7170, 0, '', 0, 0, 0, 0),
(178, 'Parking', 0, 1834.84, -1082.44, 41.6537, 181.302, 1147.97, -1318, 13.6541, 180, 0, 110, 100000, 0, '', 0, 0, 0, 0),
(179, 'Parking', 0, 657.176, -1424.62, 804.184, 181.062, 759.403, -1361.16, 13.9139, 155.58, 0, 7, 7174, 0, '', 0, 0, 0, 0),
(180, 'Umbrella Corporation', 0, 952.551, -909.111, 45.7653, 1.4118, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 7180, 0),
(181, 'Parking', 0, 1523.2, 1501.72, 25.8013, 180.04, 1479.92, -1824.74, 13.5466, 357.197, 0, 13, 7171, 0, '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `factionID` int(12) NOT NULL,
  `factionName` varchar(128) DEFAULT NULL,
  `factionColor` int(12) DEFAULT 0,
  `factionType` int(12) DEFAULT 0,
  `factionRanks` int(12) DEFAULT 0,
  `factionLockerX` float DEFAULT 0,
  `factionLockerY` float DEFAULT 0,
  `factionLockerZ` float DEFAULT 0,
  `factionLockerInt` int(12) DEFAULT 0,
  `factionLockerWorld` int(12) DEFAULT 0,
  `factionWeapon1` int(12) DEFAULT 0,
  `factionAmmo1` int(12) DEFAULT 0,
  `factionDurability1` int(12) UNSIGNED NOT NULL DEFAULT 1000,
  `factionWeapon2` int(12) DEFAULT 0,
  `factionAmmo2` int(12) DEFAULT 0,
  `factionDurability2` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon3` int(12) DEFAULT 0,
  `factionAmmo3` int(12) DEFAULT 0,
  `factionDurability3` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon4` int(12) DEFAULT 0,
  `factionAmmo4` int(12) DEFAULT 0,
  `factionDurability4` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon5` int(12) DEFAULT 0,
  `factionAmmo5` int(12) DEFAULT 0,
  `factionDurability5` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon6` int(12) DEFAULT 0,
  `factionAmmo6` int(12) DEFAULT 0,
  `factionDurability6` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon7` int(12) DEFAULT 0,
  `factionAmmo7` int(12) DEFAULT 0,
  `factionDurability7` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon8` int(12) DEFAULT 0,
  `factionAmmo8` int(12) DEFAULT 0,
  `factionDurability8` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon9` int(12) DEFAULT 0,
  `factionAmmo9` int(12) DEFAULT 0,
  `factionDurability9` int(12) UNSIGNED DEFAULT 1000,
  `factionWeapon10` int(12) DEFAULT 0,
  `factionAmmo10` int(12) DEFAULT 0,
  `factionDurability10` int(12) UNSIGNED DEFAULT 1000,
  `factionRank1` varchar(32) DEFAULT NULL,
  `factionRank2` varchar(32) DEFAULT NULL,
  `factionRank3` varchar(32) DEFAULT NULL,
  `factionRank4` varchar(32) DEFAULT NULL,
  `factionRank5` varchar(32) DEFAULT NULL,
  `factionRank6` varchar(32) DEFAULT NULL,
  `factionRank7` varchar(32) DEFAULT NULL,
  `factionRank8` varchar(32) DEFAULT NULL,
  `factionRank9` varchar(32) DEFAULT NULL,
  `factionRank10` varchar(32) DEFAULT NULL,
  `factionRank11` varchar(32) DEFAULT NULL,
  `factionRank12` varchar(32) DEFAULT NULL,
  `factionRank13` varchar(32) DEFAULT NULL,
  `factionRank14` varchar(32) DEFAULT NULL,
  `factionRank15` varchar(32) DEFAULT NULL,
  `factionDiv1` varchar(32) DEFAULT NULL,
  `factionDiv2` varchar(32) DEFAULT NULL,
  `factionDiv3` varchar(32) DEFAULT NULL,
  `factionDiv4` varchar(32) DEFAULT NULL,
  `factionDiv5` varchar(32) DEFAULT NULL,
  `factionSkin1` int(12) DEFAULT 0,
  `factionSkin2` int(12) DEFAULT 0,
  `factionSkin3` int(12) DEFAULT 0,
  `factionSkin4` int(12) DEFAULT 0,
  `factionSkin5` int(12) DEFAULT 0,
  `factionSkin6` int(12) DEFAULT 0,
  `factionSkin7` int(12) DEFAULT 0,
  `factionSkin8` int(12) DEFAULT 0,
  `SpawnX` float NOT NULL DEFAULT 0,
  `SpawnY` float NOT NULL DEFAULT 0,
  `SpawnZ` float NOT NULL DEFAULT 0,
  `SpawnInterior` int(11) NOT NULL DEFAULT 0,
  `SpawnVW` int(1) NOT NULL DEFAULT 0,
  `factionMoney` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionDeposit` varchar(24) NOT NULL DEFAULT 'None',
  `factionWithdraw` varchar(24) NOT NULL DEFAULT 'None',
  `factionDepositMoney` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `factionWithdrawMoney` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `factionMotd` varchar(225) DEFAULT NULL,
  `factionGunRank1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank3` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank4` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank5` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank6` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank7` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank8` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank9` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionGunRank10` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `factionSalary` varchar(255) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `factionNumber` int(11) NOT NULL DEFAULT -1,
  `factionSerial1` int(11) NOT NULL DEFAULT 0,
  `factionSerial2` int(11) NOT NULL DEFAULT 0,
  `factionSerial3` int(11) NOT NULL DEFAULT 0,
  `factionSerial4` int(11) NOT NULL DEFAULT 0,
  `factionSerial5` int(11) NOT NULL DEFAULT 0,
  `factionSerial6` int(11) NOT NULL DEFAULT 0,
  `factionSerial7` int(11) NOT NULL DEFAULT 0,
  `factionSerial8` int(11) NOT NULL DEFAULT 0,
  `factionSerial9` int(11) NOT NULL DEFAULT 0,
  `factionSerial10` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`factionID`, `factionName`, `factionColor`, `factionType`, `factionRanks`, `factionLockerX`, `factionLockerY`, `factionLockerZ`, `factionLockerInt`, `factionLockerWorld`, `factionWeapon1`, `factionAmmo1`, `factionDurability1`, `factionWeapon2`, `factionAmmo2`, `factionDurability2`, `factionWeapon3`, `factionAmmo3`, `factionDurability3`, `factionWeapon4`, `factionAmmo4`, `factionDurability4`, `factionWeapon5`, `factionAmmo5`, `factionDurability5`, `factionWeapon6`, `factionAmmo6`, `factionDurability6`, `factionWeapon7`, `factionAmmo7`, `factionDurability7`, `factionWeapon8`, `factionAmmo8`, `factionDurability8`, `factionWeapon9`, `factionAmmo9`, `factionDurability9`, `factionWeapon10`, `factionAmmo10`, `factionDurability10`, `factionRank1`, `factionRank2`, `factionRank3`, `factionRank4`, `factionRank5`, `factionRank6`, `factionRank7`, `factionRank8`, `factionRank9`, `factionRank10`, `factionRank11`, `factionRank12`, `factionRank13`, `factionRank14`, `factionRank15`, `factionDiv1`, `factionDiv2`, `factionDiv3`, `factionDiv4`, `factionDiv5`, `factionSkin1`, `factionSkin2`, `factionSkin3`, `factionSkin4`, `factionSkin5`, `factionSkin6`, `factionSkin7`, `factionSkin8`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnInterior`, `SpawnVW`, `factionMoney`, `factionDeposit`, `factionWithdraw`, `factionDepositMoney`, `factionWithdrawMoney`, `factionMotd`, `factionGunRank1`, `factionGunRank2`, `factionGunRank3`, `factionGunRank4`, `factionGunRank5`, `factionGunRank6`, `factionGunRank7`, `factionGunRank8`, `factionGunRank9`, `factionGunRank10`, `factionSalary`, `factionNumber`, `factionSerial1`, `factionSerial2`, `factionSerial3`, `factionSerial4`, `factionSerial5`, `factionSerial6`, `factionSerial7`, `factionSerial8`, `factionSerial9`, `factionSerial10`) VALUES
(3, 'San Andreas Police Department', 1048575, 1, 15, -1082.04, -949.464, 130.355, 15, 7170, 41, 1, 0, 3, 1, 0, 22, 250, 0, 24, 250, 0, 25, 250, 0, 27, 250, 0, 29, 250, 0, 31, 1500, 0, 33, 250, 0, 34, 250, 0, 'Junior Reserve', 'PO-I', 'PO-II', 'PO-III', 'Prob. Sergeant', 'Sergeant I', 'Sergeant II ', 'Lieutenant', 'Captain', 'Commander', 'Secretary Chief', 'Deputy Chief Of Police', 'Assistant Chief Of Police', 'Chief of Police', 'Commissioner', NULL, NULL, NULL, NULL, NULL, 280, 281, 282, 283, 288, 285, 306, 307, 0, 0, 0, 0, 0, 30375, 'Ticket Pay', 'Plutarco_Echeverra', 400, 900, 'TOLONG PATUHI SEMUA RULES YANG BERLAKU - HC', 1, 1, 1, 1, 2, 4, 4, 4, 4, 5, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'San Andreas Government Service', 3692491, 4, 7, 1499.66, 1554.62, 18.6219, 13, 7171, 3, 1, 0, 24, 250, 0, 31, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Driver & Guard', 'Customer Service', 'License Staff', 'Field Agent', 'Secretary', 'Deputy Governor', 'Governor', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 46, 228, 164, 166, 147, 59, 187, 141, 0, 0, 0, 0, 0, 50, '', '', 0, 0, '', 1, 1, 4, 2, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 'San Andreas Medical Department', 16764129, 3, 10, 1833.37, -1070.78, 41.6537, 110, 100000, 14, 1, 0, 42, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EMT Basic I', 'EMT Basic II', 'Pharmacy Agent', 'Paramedic', 'Senior Paramedic', 'Paramedic Supervisor', 'Executive Assistant', 'Hospital Executive', 'Assistant Chief of Paramedic', 'Chief of Paramedic', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 276, 275, 274, 70, 0, 0, 308, 0, 0, 0, 0, 0, 0, 41675, 'Tokugawa_Ieyasu', '', 3000, 0, '', 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '500|1000|2000|2500|3000|4000|5000|5500|6000|10000|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'San Andreas News Agency', 9194393, 2, 5, 667.578, -1401.96, 801.359, 7, 7174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 147, 171, 189, 240, 185, 186, 150, 172, 0, 0, 0, 0, 0, 100, '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Umbrella Corporation', 16121770, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 'Piston Road MC', 16121770, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'MEMBER', 'Road Captain', 'Enforcer/Treasure', 'V.President', 'President', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Los Flores X3', 16121770, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Pandilleros', 'Soldado', 'Shotcaller', 'Lil Jefe', 'El Jefe', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fire`
--

CREATE TABLE `fire` (
  `fireID` int(11) NOT NULL,
  `fireX` float NOT NULL DEFAULT 0,
  `fireY` float NOT NULL DEFAULT 0,
  `fireZ` float NOT NULL DEFAULT 0,
  `fireHealth` float NOT NULL DEFAULT 1000,
  `fireInt` int(11) NOT NULL DEFAULT 0,
  `fireWorld` int(11) NOT NULL DEFAULT 0,
  `fireModel` int(11) NOT NULL DEFAULT 18690
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fire`
--

INSERT INTO `fire` (`fireID`, `fireX`, `fireY`, `fireZ`, `fireHealth`, `fireInt`, `fireWorld`, `fireModel`) VALUES
(18, 0, 0, 0, 1000, 0, 0, 18690);

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `ID` int(12) DEFAULT 0,
  `furnitureID` int(12) NOT NULL,
  `furnitureName` varchar(32) DEFAULT NULL,
  `furnitureModel` int(12) DEFAULT 0,
  `furnitureX` float DEFAULT 0,
  `furnitureY` float DEFAULT 0,
  `furnitureZ` float DEFAULT 0,
  `furnitureRX` float DEFAULT 0,
  `furnitureRY` float DEFAULT 0,
  `furnitureRZ` float DEFAULT 0,
  `furnitureType` int(12) DEFAULT 0,
  `furnitureUnused` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `furnitureStatus` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `furniture`
--

INSERT INTO `furniture` (`ID`, `furnitureID`, `furnitureName`, `furnitureModel`, `furnitureX`, `furnitureY`, `furnitureZ`, `furnitureRX`, `furnitureRY`, `furnitureRZ`, `furnitureType`, `furnitureUnused`, `furnitureStatus`) VALUES
(87, 2, 'Table 1', 1433, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 3, 'Chair 23', 1764, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 4, 'Bed 1', 1700, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 5, 'Cabinet 3', 1741, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 6, 'Television 12', 2316, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 7, 'Kitchen 1', 2013, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 8, 'Bathroom 1', 2514, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 9, 'Bathroom 12', 2527, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 10, 'Bathroom 7', 2522, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 11, 'Bathroom 5', 2520, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 12, 'Kitchen 48', 15036, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 13, 'Kitchen 7', 2135, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 14, 'Bathroom 4', 2518, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 15, 'Dark?Luxury?Bed', 2566, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 16, 'Twin?Dark?Hotel?Beds', 2565, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 17, 'Security?Camera', 1616, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 18, 'Mat 2', 2632, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 19, 'China?China?Lamp', 2075, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 20, 'Lab?Door', 1523, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 21, 'Bolla?Bolla?1', 19121, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 22, 'Wash?Hands', 2685, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 23, 'Cosy?Set?2', 2802, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 24, 'Washer', 1208, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 25, 'Water Cooler', 1808, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 26, 'Book', 2894, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(2, 47, 'Frame 3', 2287, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(198, 48, 'Bathroom 12', 2527, 1877.88, -2423.93, 12.5445, 0, 0, 1.3544, 0, 0, 0),
(198, 49, 'Television 4', 1748, 1880.65, -2416.33, 17.8192, 0, 0, 3.2407, 0, 0, 0),
(198, 50, 'Bed 11', 1798, 1878.97, -2422.13, 16.0592, 0, 0, -179.117, 0, 0, 0),
(198, 51, 'Frame 13', 2277, 1882.3, -2417.17, 17.7591, 0, 0, -4.1539, 0, 0, 0),
(198, 52, 'Table 31', 2236, 1879.83, -2428.18, 12.5733, 0, -0.4, 89.7514, 0, 0, 0),
(198, 53, 'Chair 33', 1703, 1877.92, -2428.63, 12.5445, 0, 0, 89.1626, 0, 0, 0),
(198, 54, 'Chair 8', 1724, 1878.73, -2425.39, 12.5045, 0, 0, -0.1471, 0, 0, 0),
(198, 55, 'Cabinet 6', 2025, 1883.12, -2425.38, 16.1345, 0, 0, -177.954, 0, 0, 0),
(198, 56, 'Washer', 1208, 1877.76, -2416.95, 12.5745, 0, 0, -91.0867, 0, 0, 0),
(198, 57, 'Water Cooler', 1808, 1883.39, -2425.03, 12.6245, 0, 0, -85.0325, 0, 0, 0),
(198, 58, 'Ceiling Fan 2', 1657, 1882.92, -2428.87, 15.6745, 0, 0, -95.0371, 0, 0, 0),
(198, 59, 'Bathroom 3', 2517, 1879.81, -2423.94, 12.5045, 0, 0, 0.1437, 0, 0, 0),
(198, 60, 'Bed 11', 1798, 1880.79, -2422.14, 16.0645, 0, 0, -179.949, 0, 0, 0),
(198, 61, 'Television 13', 2317, 1879.42, -2427.66, 13.3345, 0, 0, -89.9907, 0, 0, 0),
(198, 62, 'Lamp 3', 2069, 1877.88, -2425.43, 12.6444, 0, 0, 41.6976, 0, 0, 0),
(198, 63, 'Dresser 3', 2573, 1877.87, -2433.15, 12.5845, 0, 0, 89.4449, 0, 0, 0),
(145, 64, 'Bed 4', 1745, 1880.97, -2422.36, 16.2292, 0, 0, -179.434, 0, 0, 0),
(145, 65, 'Lamp 3', 2069, 1881.6, -2425.62, 16.2791, 0, 0, 183.493, 0, 0, 0),
(145, 66, 'Kitchen 1', 2013, 1877.87, -2425.23, 12.4145, 0, 0, 89.345, 0, 0, 0),
(145, 67, 'Kitchen 2', 2017, 1877.88, -2426.23, 12.4145, 0, 0, 89.4718, 0, 0, 0),
(145, 68, 'Television 12', 2316, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(145, 69, 'Cabinet 10', 2087, 1877.55, -2421.46, 16.2292, 0, 0, 89.5736, 0, 0, 0),
(145, 70, 'Table 25', 2032, 1880.14, -2425.24, 12.5745, 0, 0, 90.6109, 0, 0, 0),
(145, 71, 'Chair 1', 1671, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(46, 72, 'Table 7', 2314, 1876.51, -2415.19, 12.4444, 0, 0, -177.247, 0, 0, 0),
(46, 73, 'Chair 15', 1810, 1875.11, -2414.12, 12.5644, 0, 0, 15.8375, 0, 0, 0),
(46, 74, 'Chair 15', 1810, 1876.35, -2413.99, 12.5845, 0, 0, -9.3893, 0, 0, 0),
(46, 75, 'Television 17', 16377, 1873.04, -2415.26, 13.5144, 0, 0, -85.5647, 0, 0, 0),
(46, 76, 'Chair 23', 1764, 1878.22, -2414.52, 12.5244, 0, 0, -99.4228, 0, 0, 0),
(46, 77, 'Chair 23', 1764, 1877.17, -2416.93, 12.5244, 0, 0, -176.207, 0, 0, 0),
(47, 78, 'Frame 13', 2277, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 79, 'Table 16', 937, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 81, 'Bathroom 12', 2527, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 82, 'Chair 31', 1712, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 83, 'Chair 11', 1735, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 84, 'Chair?and?Table?Set', 1594, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 85, 'Television 11', 2312, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 86, 'Lamp 3', 2069, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 87, 'Bathroom 14', 2738, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(15, 88, 'Bed 11', 1798, 1870.56, -2414.05, 12.1345, 0, 0, 180.533, 0, 0, 0),
(15, 90, 'Table 5', 2185, 1878.49, -2416.08, 12.6145, 0, 0, -178.599, 0, 0, 0),
(209, 92, 'Rimbo?Rambo?Desk?2', 1999, 1877.99, -2417.16, 16.1692, 0, 0, -0.6983, 0, 0, 0),
(209, 93, 'LS:CDF?Flag', 2047, 1880.47, -2425.87, 18.0888, 0.4999, 0.2999, -178.528, 0, 0, 0),
(209, 94, 'Slot?Table', 2592, 1877.74, -2425.79, 13.5834, 5.6999, -0.3999, 91.1173, 0, 0, 0),
(209, 95, 'Blue?Pool?Table', 2964, 1878.19, -2430.07, 12.2345, 0, -0.1999, 89.852, 0, 0, 0),
(209, 96, 'Frame 20', 2270, 1886.33, -2428.08, 14.2945, 0.8999, 0.5, -90.708, 0, 0, 0),
(209, 97, 'Bathroom 3', 2517, 1878.98, -2417.35, 12.5845, 0.9999, 1.3, 88.602, 0, 0, 0),
(209, 98, 'Bathroom 13', 2528, 1883.19, -2417.17, 12.7445, 0, 0, 359.918, 0, 0, 0),
(209, 99, 'Dark?Luxury?Bed', 2566, 1881.97, -2423.41, 16.6792, 0, 0, 178.443, 0, 0, 0),
(209, 100, 'Chair?and?Speakers', 11665, 1879.05, -2421.17, 16.7992, 0, 0, -177.169, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `furnobject`
--

CREATE TABLE `furnobject` (
  `id` int(10) UNSIGNED NOT NULL,
  `model` int(10) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `price` int(11) UNSIGNED NOT NULL,
  `stock` int(11) UNSIGNED NOT NULL,
  `storeid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `materials` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `furnstore`
--

CREATE TABLE `furnstore` (
  `id` int(10) UNSIGNED NOT NULL,
  `ownername` varchar(24) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `i_x` float NOT NULL,
  `i_y` float NOT NULL,
  `i_z` float NOT NULL,
  `owner` int(10) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `vault` int(11) NOT NULL,
  `employe1` tinyint(4) NOT NULL,
  `employe2` tinyint(4) NOT NULL,
  `employe3` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `garage`
--

CREATE TABLE `garage` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Owner` varchar(24) NOT NULL,
  `OwnerID` int(10) UNSIGNED NOT NULL,
  `Location` varchar(64) NOT NULL,
  `Price` int(10) UNSIGNED NOT NULL,
  `Type` int(10) UNSIGNED NOT NULL,
  `Lock` int(10) UNSIGNED NOT NULL,
  `LocationInt` varchar(64) NOT NULL,
  `Inside` int(10) UNSIGNED NOT NULL,
  `HouseLink` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `garbage`
--

CREATE TABLE `garbage` (
  `garbageID` int(12) NOT NULL,
  `garbageModel` int(12) DEFAULT 1236,
  `garbageCapacity` int(12) DEFAULT 0,
  `garbageX` float DEFAULT 0,
  `garbageY` float DEFAULT 0,
  `garbageZ` float DEFAULT 0,
  `garbageA` float DEFAULT 0,
  `garbageInterior` int(12) DEFAULT 0,
  `garbageWorld` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `garbage`
--

INSERT INTO `garbage` (`garbageID`, `garbageModel`, `garbageCapacity`, `garbageX`, `garbageY`, `garbageZ`, `garbageA`, `garbageInterior`, `garbageWorld`) VALUES
(2, 1236, 10, 2306.47, -1950.3, 13.5753, 90.6098, 0, 0),
(3, 1236, 10, 2277.9, -1887.39, 13.5599, 359.214, 0, 0),
(4, 1236, 10, 2223.54, -1791.19, 13.5625, 271.963, 0, 0),
(5, 1236, 10, 2242.15, -1725.07, 13.5468, 359.881, 0, 0),
(6, 1236, 10, 2283.93, -1756.3, 13.5468, 178.847, 0, 0),
(7, 1236, 10, 2349.81, -1701.14, 13.5234, 269.408, 0, 0),
(14, 1236, 10, 2498.34, -1687.43, 13.4392, 189.849, 0, 0),
(15, 1236, 10, 2403.38, -1650.34, 13.483, 2.0811, 0, 0),
(17, 1236, 10, 2300.31, -1650.11, 14.6829, 1.3999, 0, 0),
(19, 1236, 10, 2127.43, -1611.55, 13.5625, 339.337, 0, 0),
(21, 1236, 10, 2045.6, -1639.43, 13.5468, 270.108, 0, 0),
(22, 1236, 10, 1992.35, -1715.8, 13.5468, 89.3659, 0, 0),
(23, 1236, 10, 1943.91, -1794.58, 13.5468, 182.075, 0, 0),
(24, 1236, 10, 1928.55, -1864.1, 13.5619, 179.438, 0, 0),
(25, 1236, 10, 1950.71, -1988.56, 13.5468, 89.3639, 0, 0),
(27, 1236, 10, 1799.83, -1882.67, 13.5757, 359.684, 0, 0),
(28, 1236, 10, 1833.78, -1888.38, 13.4193, 179.061, 0, 0),
(31, 1236, 10, 1809.29, -1739.43, 13.5363, 180.834, 0, 0),
(32, 1236, 10, 1757.25, -1679.52, 13.5506, 269.43, 0, 0),
(33, 1236, 10, 1692.58, -1585.43, 13.5407, 1.0241, 0, 0),
(34, 1236, 10, 1693.26, -1528.11, 13.5468, 89.6569, 0, 0),
(35, 1236, 10, 1616.32, -1332.34, 17.4727, 268.491, 0, 0),
(36, 1236, 10, 1475.96, -1167.86, 24.0832, 179.792, 0, 0),
(38, 1236, 10, 1474.87, -1025.91, 23.8251, 358.644, 0, 0),
(39, 1236, 10, 1231.43, -912.269, 43.0937, 280.513, 0, 0),
(40, 1236, 10, 1003.79, -1133.42, 23.8281, 359.972, 0, 0),
(41, 1236, 10, 920.614, -1232.78, 16.9765, 271.926, 0, 0),
(42, 1236, 10, 829.563, -1334.77, 13.5468, 181.26, 0, 0),
(43, 1236, 10, 646.55, -1344.61, 13.5468, 268.639, 0, 0),
(44, 1236, 10, 770.26, -1386.99, 13.6386, 0.6154, 0, 0),
(45, 1236, 10, 775.606, -1522.2, 13.5494, 77.2679, 0, 0),
(47, 1236, 10, 816.425, -1624.26, 13.5468, 50.6363, 0, 0),
(49, 1236, 10, 161.138, -1827.96, 3.7565, 268.952, 0, 0),
(50, 1236, 10, 495.038, -1734.77, 11.3837, 171.866, 0, 0),
(52, 1236, 10, 663.787, -1730.65, 13.7418, 347.536, 0, 0),
(53, 1236, 10, 924.393, -1731.33, 13.5468, 269.87, 0, 0),
(54, 1236, 10, 1225.78, -1844.87, 13.5468, 359.757, 0, 0),
(55, 1236, 10, 1114.19, -1748.31, 13.5703, 181.505, 0, 0),
(56, 1236, 10, 1255.97, -1696.02, 13.5468, 0.0342, 0, 0),
(57, 1236, 10, 1541.48, -1692.83, 13.547, 268.534, 0, 0),
(58, 1236, 10, 1646.48, -1865.15, 13.5347, 0.0197, 0, 0),
(59, 1236, 10, 1353.63, -1572, 13.539, 344.868, 0, 0),
(60, 1236, 10, 1364.98, -1286.21, 13.5468, 270.326, 0, 0),
(61, 1236, 10, 1272.89, -1321.24, 13.4959, 90.7914, 0, 0),
(62, 1236, 10, 1188.13, -1348.81, 13.5678, 90.68, 0, 0),
(63, 1236, 10, 1107.11, -1413.41, 13.6065, 182.263, 0, 0),
(64, 1236, 10, 1014.03, -1564.72, 13.6473, 359.265, 0, 0),
(65, 1236, 10, 1783.86, -2076.2, 13.5876, 181.316, 0, 0),
(66, 1236, 10, 1928.62, -2097.13, 13.5786, 0.3102, 0, 0),
(67, 1236, 10, 1674.02, -2311.91, 13.5429, 1.0722, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `gateID` int(12) NOT NULL,
  `gateModel` int(12) DEFAULT 0,
  `gateSpeed` float DEFAULT 0,
  `gateTime` int(12) DEFAULT 0,
  `gateX` float DEFAULT 0,
  `gateY` float DEFAULT 0,
  `gateZ` float DEFAULT 0,
  `gateRX` float DEFAULT 0,
  `gateRY` float DEFAULT 0,
  `gateRZ` float DEFAULT 0,
  `gateInterior` int(12) DEFAULT 0,
  `gateWorld` int(12) DEFAULT 0,
  `gateMoveX` float DEFAULT 0,
  `gateMoveY` float DEFAULT 0,
  `gateMoveZ` float DEFAULT 0,
  `gateMoveRX` float DEFAULT 0,
  `gateMoveRY` float DEFAULT 0,
  `gateMoveRZ` float DEFAULT 0,
  `gateLinkID` int(12) DEFAULT 0,
  `gateFaction` int(12) NOT NULL DEFAULT -1,
  `gatePass` varchar(32) DEFAULT NULL,
  `gateRadius` float DEFAULT 0,
  `gateMakeBy` varchar(24) NOT NULL DEFAULT 'none',
  `gateLastEdit` varchar(24) NOT NULL DEFAULT 'none',
  `gateWorkshop` int(10) DEFAULT -1,
  `gateTollPrice` int(4) NOT NULL DEFAULT 0,
  `gateFlag` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gates`
--

INSERT INTO `gates` (`gateID`, `gateModel`, `gateSpeed`, `gateTime`, `gateX`, `gateY`, `gateZ`, `gateRX`, `gateRY`, `gateRZ`, `gateInterior`, `gateWorld`, `gateMoveX`, `gateMoveY`, `gateMoveZ`, `gateMoveRX`, `gateMoveRY`, `gateMoveRZ`, `gateLinkID`, `gateFaction`, `gatePass`, `gateRadius`, `gateMakeBy`, `gateLastEdit`, `gateWorkshop`, `gateTollPrice`, `gateFlag`) VALUES
(1, 968, 0, 0, 79.0245, -1266.82, 14.12, 3.3, 88.9999, 123.504, 0, 0, 79.0245, -1266.82, 14.12, 3.3, 4.6999, 123.504, -1, -1, 'none', 10, 'none', 'none', -1, 5, 0),
(2, 968, 0, 0, 90.2226, -1281.24, 13.5833, 0, -91, 127.162, 0, 0, 90.2226, -1281.24, 13.5833, 0, -3.6, 127.162, -1, -1, 'none', 10, 'none', 'none', -1, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `ID` int(12) DEFAULT 0,
  `locationID` int(12) NOT NULL,
  `locationName` varchar(32) DEFAULT NULL,
  `locationX` float DEFAULT 0,
  `locationY` float DEFAULT 0,
  `locationZ` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gps`
--

INSERT INTO `gps` (`ID`, `locationID`, `locationName`, `locationX`, `locationY`, `locationZ`) VALUES
(141, 1, 'on', 1814.67, -1840.11, 13.1734),
(54, 3, 'rojer_hawkins', 2136.96, -1276.04, 25.4921),
(166, 4, 'bank', 1616.07, -1731.63, 12.9814),
(29, 5, 'fimd vehicle', 1830.09, -1909.64, 13.0356),
(166, 6, 'food', 1337.99, -1346.18, 13.3828),
(40, 7, 'mobil gua', -514.182, 1973.33, 60.4569),
(180, 8, 'bank', 951.453, -957.245, 39.3371),
(180, 9, 'bank los santos', 1232.14, -1705.68, 13.5468),
(192, 10, 'bank', 2231.6, -1648.16, 14.8527),
(108, 11, 'el corona', 157.207, -282.573, 1.3895),
(165, 12, 'Mc', 2529.61, -1543.15, 25.4233),
(254, 13, 'Sidejob', 150.747, -1837.2, 3.5909),
(217, 14, 'bus station ', 1692.93, -1925.77, 13.5462),
(217, 15, 'HOME', 1692.69, -1926.22, 13.5463),
(133, 16, 'RUMAJ', 251.027, -1223.62, 74.8524),
(133, 17, 'RUMAH 2', 255.482, -1364.1, 52.649),
(133, 18, 'RUMAH 3', 297.457, -1336.99, 52.9801),
(40, 19, 'mobil gua Sultan', 1362.28, -1230.48, 13.4179),
(40, 20, 'UP', 1657.25, -1887.31, 13.5521),
(40, 21, 'car', 1777.28, -1887.4, 13.094),
(319, 23, 'trucker', 901.453, -1655.7, 13.5468),
(65, 24, 'scrayard', 1956.66, -2008.63, 13.4433),
(65, 25, '/scrapyard', 1956.66, -2008.63, 13.4433),
(40, 26, 'mc', 2514.02, -1555.32, 25.6364),
(40, 27, 'y', 2407.41, -1439.44, 23.619),
(385, 29, 'kontol', 1846.51, -1870.47, 13.5781),
(40, 30, 'bm', -48.6752, -226.818, 5.0546),
(194, 31, 'BM', -48.8809, -227.52, 5.4296),
(30, 32, 'lv street 220', 1657.96, -1483.8, 12.9488);

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE `graffiti` (
  `graffitiID` int(12) NOT NULL,
  `graffitiX` float DEFAULT 0,
  `graffitiY` float DEFAULT 0,
  `graffitiZ` float DEFAULT 0,
  `graffitiAngle` float DEFAULT 0,
  `graffitiColor` int(12) DEFAULT 0,
  `graffitiText` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gunracks`
--

CREATE TABLE `gunracks` (
  `rackID` int(12) NOT NULL,
  `rackHouse` int(12) DEFAULT 0,
  `rackX` float DEFAULT 0,
  `rackY` float DEFAULT 0,
  `rackZ` float DEFAULT 0,
  `rackA` float DEFAULT 0,
  `rackInterior` int(12) DEFAULT 0,
  `rackWorld` int(12) DEFAULT 0,
  `rackWeapon1` int(12) DEFAULT 0,
  `rackAmmo1` int(12) DEFAULT 0,
  `rackWeapon2` int(12) DEFAULT 0,
  `rackAmmo2` int(12) DEFAULT 0,
  `rackWeapon3` int(12) DEFAULT 0,
  `rackAmmo3` int(12) DEFAULT 0,
  `rackWeapon4` int(12) DEFAULT 0,
  `rackAmmo4` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `housekeys`
--

CREATE TABLE `housekeys` (
  `ID` int(11) NOT NULL,
  `playerID` int(10) NOT NULL DEFAULT -1,
  `houseID` int(10) NOT NULL DEFAULT -1,
  `houseOwnerID` int(10) NOT NULL DEFAULT -1,
  `houseKeyExists` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `housekeys`
--

INSERT INTO `housekeys` (`ID`, `playerID`, `houseID`, `houseOwnerID`, `houseKeyExists`) VALUES
(1, 235, 198, 7, 1),
(2, 204, 198, 7, 1),
(3, 144, 125, 133, 1),
(4, 299, 203, 36, 1),
(5, 265, 203, 36, 1);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `houseID` int(12) NOT NULL,
  `houseOwner` int(12) DEFAULT 0,
  `housePrice` int(12) DEFAULT 0,
  `houseOwnerName` varchar(32) NOT NULL DEFAULT 'State',
  `houseAddress` varchar(32) DEFAULT NULL,
  `housePosX` float DEFAULT 0,
  `housePosY` float DEFAULT 0,
  `housePosZ` float DEFAULT 0,
  `housePosA` float DEFAULT 0,
  `houseIntX` float DEFAULT 0,
  `houseIntY` float DEFAULT 0,
  `houseIntZ` float DEFAULT 0,
  `houseIntA` float DEFAULT 0,
  `houseInterior` int(12) DEFAULT 0,
  `houseExterior` int(12) DEFAULT 0,
  `houseExteriorVW` int(12) DEFAULT 0,
  `houseLocked` int(4) DEFAULT 0,
  `houseWeapon1` int(12) DEFAULT 0,
  `houseAmmo1` int(12) DEFAULT 0,
  `houseWeapon2` int(12) DEFAULT 0,
  `houseAmmo2` int(12) DEFAULT 0,
  `houseWeapon3` int(12) DEFAULT 0,
  `houseAmmo3` int(12) DEFAULT 0,
  `houseWeapon4` int(12) DEFAULT 0,
  `houseAmmo4` int(12) DEFAULT 0,
  `houseWeapon5` int(12) DEFAULT 0,
  `houseAmmo5` int(12) DEFAULT 0,
  `houseWeapon6` int(12) DEFAULT 0,
  `houseAmmo6` int(12) DEFAULT 0,
  `houseWeapon7` int(12) DEFAULT 0,
  `houseAmmo7` int(12) DEFAULT 0,
  `houseWeapon8` int(12) DEFAULT 0,
  `houseAmmo8` int(12) DEFAULT 0,
  `houseWeapon9` int(12) DEFAULT 0,
  `houseAmmo9` int(12) DEFAULT 0,
  `houseWeapon10` int(12) DEFAULT 0,
  `houseAmmo10` int(12) DEFAULT 0,
  `houseMoney` int(12) DEFAULT 0,
  `houseLastVisited` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `houseParkingSlot` int(5) NOT NULL DEFAULT 0,
  `houseParkingSlotUsed` int(5) NOT NULL DEFAULT 0,
  `houseSeal` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`houseID`, `houseOwner`, `housePrice`, `houseOwnerName`, `houseAddress`, `housePosX`, `housePosY`, `housePosZ`, `housePosA`, `houseIntX`, `houseIntY`, `houseIntZ`, `houseIntA`, `houseInterior`, `houseExterior`, `houseExteriorVW`, `houseLocked`, `houseWeapon1`, `houseAmmo1`, `houseWeapon2`, `houseAmmo2`, `houseWeapon3`, `houseAmmo3`, `houseWeapon4`, `houseAmmo4`, `houseWeapon5`, `houseAmmo5`, `houseWeapon6`, `houseAmmo6`, `houseWeapon7`, `houseAmmo7`, `houseWeapon8`, `houseAmmo8`, `houseWeapon9`, `houseAmmo9`, `houseWeapon10`, `houseAmmo10`, `houseMoney`, `houseLastVisited`, `houseParkingSlot`, `houseParkingSlotUsed`, `houseSeal`) VALUES
(2, 77, 1, 'Pandu_Pangestu', '2', 1872.26, -1911.79, 15.2566, 0.9696, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663161065, 0, 0, 0),
(3, 0, 30000, 'The State', '3', 1973.18, -1705.14, 15.9687, 0.4038, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(4, 0, 50000, 'The State', '4', 1980.99, -1682.85, 17.0536, 86.9349, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(5, 0, 30000, 'The State', '5', 1974.73, -1671.19, 15.9687, 359.272, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(6, 0, 30000, 'The State', '6', 1970.05, -1671.2, 15.9687, 356.034, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(7, 0, 30000, 'The State', '7', 1969.98, -1671.19, 18.5454, 354.9, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(8, 0, 30000, 'The State', '8', 1974.98, -1671.19, 18.5454, 1.6187, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808356, 0, 0, 0),
(9, 0, 30000, 'The State', '9', 1969.39, -1654.67, 15.9687, 357.248, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808473, 0, 0, 0),
(10, 0, 30000, 'The State', '10', 1973.4, -1654.67, 15.9687, 0.8896, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808487, 0, 0, 0),
(11, 0, 30000, 'The State', '11', 1967.3, -1633.71, 15.9687, 0.0766, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808630, 0, 0, 0),
(12, 0, 30000, 'The State', '12', 1972.3, -1633.71, 15.9687, 359.596, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808630, 0, 0, 0),
(13, 0, 30000, 'The State', '13', 1967.36, -1633.71, 18.5688, 4.0471, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808703, 0, 0, 0),
(14, 0, 30000, 'The State', '14', 1972.41, -1633.71, 18.5688, 0.8093, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808707, 0, 0, 0),
(15, 15, 30000, 'Oscar_Vengeance', '15', 2018.06, -1629.69, 14.0424, 270.033, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663229527, 0, 0, 0),
(16, 24, 1, 'Ventilya_Colemany', '16', 2016.54, -1641.71, 14.1127, 271.814, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663217625, 0, 0, 0),
(17, 0, 30000, 'The State', '17', 2013.58, -1656.13, 14.1363, 271.328, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808707, 0, 0, 0),
(18, 0, 30000, 'The State', '18', 2018.24, -1703.34, 14.2342, 271.49, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808757, 0, 0, 0),
(19, 0, 30000, 'The State', '19', 2015.86, -1717.08, 14.0041, 272.3, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808846, 0, 0, 0),
(20, 194, 1, 'Fajri_Maulana', '20', 2015.35, -1732.42, 14.2341, 269.79, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663160475, 0, 0, 0),
(21, 0, 50000, 'The State', '21', 2067.06, -1731.47, 14.2066, 91.917, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808846, 0, 0, 0),
(22, 0, 30000, 'The State', '22', 2066.25, -1717.2, 14.1363, 91.1076, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808846, 0, 0, 0),
(23, 9, 50000, 'Smith_Martin', '23', 2065.1, -1703.66, 14.1484, 89.8935, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1070000, 1663197456, 0, 0, 0),
(24, 0, 30000, 'The State', '24', 2066.74, -1656.54, 14.1328, 83.2559, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808846, 0, 0, 0),
(25, 49, 1, 'Tokugawa_Ieyasu', '25', 2067.56, -1643.8, 14.1363, 92.2406, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 1663211282, 0, 0, 0),
(26, 0, 30000, 'The State', '26', 2067.7, -1628.84, 14.2066, 89.084, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662808846, 0, 0, 0),
(27, 30, 30000, 'Owen_Knight', '27', 2244.42, -1637.6, 16.2378, 337.74, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663182490, 0, 0, 0),
(28, 0, 30000, 'The State', '28', 2257.08, -1643.94, 15.808, 355.386, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662809480, 0, 0, 0),
(29, 268, 1, 'Elcapone_Pettyfer', '29', 2282.3, -1641.21, 15.8893, 0.4857, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662969295, 0, 0, 0),
(30, 60, 1, 'Daniell_Wade', '30', 2306.99, -1679.2, 14.3316, 180.706, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663073249, 0, 0, 0),
(31, 0, 50000, 'The State', '31', 2326.88, -1681.89, 14.9295, 87.4576, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662809480, 0, 0, 0),
(32, 239, 30000, 'Shin_Fushima', '32', 2326.72, -1716.7, 14.2377, 358.742, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663198678, 0, 0, 0),
(33, 139, 1, 'Andrey_Rodriguez', '33', 2308.83, -1714.33, 14.9799, 354.613, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663230079, 0, 0, 0),
(34, 25, 1, 'Valcon_Colemania', 'Grove Street', 2495.42, -1691.14, 14.7656, 178.784, 2198.88, 2853.92, 13.3261, 86.9944, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 1663218031, 0, 0, 0),
(35, 159, 1, 'Olmero_Estevanez', '34', 2459.42, -1691.66, 13.5459, 177.63, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663213237, 0, 0, 0),
(37, 0, 50000, 'The State', '36', 2523.27, -1679.29, 15.4968, 272.174, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810708, 0, 0, 0),
(38, 0, 30000, 'The State', '37', 2524.71, -1658.62, 15.824, 269.908, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810708, 0, 0, 0),
(39, 101, 30000, 'Guilherme_Leao', '38', 2513.73, -1650.27, 14.3556, 315.355, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663220586, 0, 0, 0),
(40, 0, 30000, 'The State', '39', 2498.42, -1642.25, 14.1129, 1.0447, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810738, 0, 0, 0),
(41, 0, 50000, 'The State', '40', 2486.42, -1644.54, 14.077, 358.698, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810738, 0, 0, 0),
(42, 0, 30000, 'The State', '41', 2469.39, -1646.35, 13.7799, 0.9638, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810751, 0, 0, 0),
(43, 311, 30000, 'Ronald_Christopher', '42', 2451.73, -1641.41, 14.0662, 2.2588, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663070368, 0, 0, 0),
(44, 14, 30000, 'Abel_Petterson', '43', 2413.92, -1646.79, 14.0115, 4.9302, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663213802, 0, 0, 0),
(45, 0, 30000, 'The State', '44', 2409.04, -1674.94, 14.375, 183.694, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810751, 0, 0, 0),
(46, 271, 1, 'Mahleek_Preston', '45', 2393.18, -1646.03, 13.9048, 357.925, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663091290, 0, 0, 0),
(47, 65, 30000, 'Ken_Mang', '46', 2384.7, -1675.84, 15.2454, 180.169, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663225918, 0, 0, 0),
(48, 0, 50000, 'The State', '47', 2368.26, -1675.35, 14.1681, 181.221, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810829, 0, 0, 0),
(49, 0, 30000, 'The State', '49', 2362.94, -1643.14, 14.3514, 358.609, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810853, 0, 0, 0),
(50, 0, 50000, 'The State', '48', 2385.4, -1711.66, 14.242, 3.2228, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810888, 0, 0, 0),
(51, 0, 30000, 'The State', '50', 2402.64, -1714.74, 14.1328, 358.808, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810892, 0, 0, 0),
(52, 0, 30000, 'The State', '51', 2438.05, -2020.84, 13.9025, 180, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(53, 0, 30000, 'The State', '52', 2465.33, -2020.79, 14.124, 182.671, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(54, 0, 30000, 'The State', '53', 2465.2, -1995.75, 14.0193, 1.317, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(55, 0, 30000, 'The State', '54', 2483.53, -1995.34, 13.8343, 358.565, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(56, 0, 30000, 'The State', '55', 2486.46, -2021.55, 13.9988, 181.376, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(57, 0, 30000, 'The State', '56', 2507.65, -2021.05, 14.2101, 174.981, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(58, 0, 30000, 'The State', '57', 2508.03, -1998.36, 13.9025, 0.0593, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662810966, 0, 0, 0),
(59, 0, 30000, 'The State', '58', 2524.39, -1998.35, 14.1129, 315.782, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811067, 0, 0, 0),
(60, 0, 30000, 'The State', '59', 2522.68, -2019.04, 14.0743, 227.47, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811067, 0, 0, 0),
(61, 0, 30000, 'The State', '60', 2637.15, -1991.63, 14.324, 45.2993, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811287, 0, 0, 0),
(62, 0, 30000, 'The State', '61', 2650.7, -2021.73, 14.1766, 270.04, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811287, 0, 0, 0),
(63, 0, 30000, 'The State', '62', 2635.59, -2012.89, 14.1443, 123.978, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811322, 0, 0, 0),
(64, 0, 30000, 'The State', '64', 2652.7, -1989.43, 13.9988, 0.0441, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811322, 0, 0, 0),
(65, 0, 30000, 'The State', '63', 2672.78, -1989.47, 14.324, 359.972, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811337, 0, 0, 0),
(66, 0, 30000, 'The State', '65', 2696.33, -1990.36, 14.2228, 354.951, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811337, 0, 0, 0),
(67, 0, 30000, 'The State', '66', 2695.36, -2020.45, 14.0221, 180.352, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811337, 0, 0, 0),
(68, 0, 30000, 'The State', '67', 2673.31, -2020.29, 14.1681, 182.781, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811337, 0, 0, 0),
(69, 0, 100000, 'The State', '68', 893.639, -1635.7, 14.9295, 1.1396, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811822, 0, 0, 0),
(70, 0, 100000, 'The State', '69', 865.246, -1633.85, 14.9295, 2.1108, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811822, 0, 0, 0),
(71, 0, 50000, 'The State', '70', 797.235, -1729.29, 13.5467, 91.0652, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811822, 0, 0, 0),
(72, 0, 50000, 'The State', '71', 793.976, -1707.68, 14.0382, 90.4177, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(73, 0, 50000, 'The State', '72', 794.798, -1692.09, 14.4632, 181.481, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(74, 0, 50000, 'The State', '73', 790.812, -1661.14, 13.484, 3.1586, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(75, 0, 50000, 'The State', '74', 769.227, -1696.59, 5.1553, 270.962, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(76, 0, 50000, 'The State', '75', 769.158, -1726.23, 13.432, 6.0728, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(77, 0, 50000, 'The State', '76', 769.226, -1745.73, 13.0771, 268.983, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(78, 0, 50000, 'The State', '77', 768.076, -1655.73, 5.6093, 268.659, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662811924, 0, 0, 0),
(79, 0, 50000, 'The State', '78', 766.923, -1605.77, 13.8037, 270.152, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812031, 0, 0, 0),
(80, 0, 50000, 'The State', '79', 761.159, -1564.11, 13.9287, 84.7512, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812057, 0, 0, 0),
(81, 0, 50000, 'The State', '80', 771.091, -1510.83, 13.5467, 78.2757, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812057, 0, 0, 0),
(82, 46, 1, 'Aiden_Pearce', '81', 822.474, -1505.26, 14.3943, 176.256, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663161801, 0, 0, 0),
(83, 0, 50000, 'The State', '82', 782.8, -1464.36, 13.5467, 82.315, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812127, 0, 0, 0),
(84, 9, 100000, 'Smith_Martin', '83', 813.683, -1456.75, 14.2278, 267.797, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663197456, 0, 0, 0),
(85, 0, 100000, 'The State', '84', 824.735, -1424.2, 14.4988, 181.914, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812127, 0, 0, 0),
(86, 0, 100000, 'The State', '85', 852.452, -1423.01, 14.1412, 174.386, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812127, 0, 0, 0),
(87, 40, 1, 'Ranz_Summers', '86', 880.185, -1424.27, 14.4877, 177.948, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663223576, 0, 0, 0),
(88, 0, 100000, 'The State', '87', 900.531, -1447.33, 14.3692, 92.8742, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812127, 0, 0, 0),
(89, 0, 100000, 'The State', '88', 900.205, -1471.15, 14.3437, 86.7226, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812127, 0, 0, 0),
(90, 77, 1, 'Pandu_Pangestu', '89', 841.246, -1471.36, 14.3133, 355.659, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663161065, 5, 0, 0),
(91, 88, 1, 'Qenzo_Zevallo', '90', 849.904, -1520.21, 14.3519, 82.55, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663215629, 2, 0, 0),
(92, 173, 1, 'Hilmy_Fauzan', '91', 738.986, -1418.51, 13.5234, 174.46, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663150123, 0, 0, 0),
(93, 0, 100000, 'The State', '92', 738.881, -1428.77, 13.8984, 358.448, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812265, 0, 0, 0),
(94, 172, 1, 'Reamy_Xhyner', '93', 725.642, -1451.04, 17.6951, 176.321, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663115713, 0, 0, 0),
(95, 5, 1, 'Frankie_Charles', '94', 683.404, -1435.75, 14.8514, 1.4794, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663213884, 0, 0, 0),
(96, 0, 50000, 'The State', '95', 685.707, -1421.91, 14.7742, 182.23, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812401, 0, 0, 0),
(97, 0, 50000, 'The State', '96', 657.213, -1434.11, 14.8514, 182.878, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812423, 0, 0, 0),
(98, 0, 50000, 'The State', '97', 662.434, -1440.41, 14.8514, 89.7097, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812423, 0, 0, 0),
(99, 0, 50000, 'The State', '98', 648.857, -1442.39, 14.7293, 267.826, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812423, 0, 0, 0),
(100, 0, 50000, 'The State', '99', 657.462, -1481.29, 14.8514, 182.024, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(101, 0, 50000, 'The State', '100', 662.432, -1466.84, 14.8514, 90.9238, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(102, 0, 50000, 'The State', '101', 662.434, -1487.79, 14.8514, 96.5092, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(103, 0, 50000, 'The State', '102', 648.857, -1489.56, 14.8417, 268.437, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(104, 0, 50000, 'The State', '103', 662.432, -1513.89, 14.8514, 90.3572, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(105, 0, 50000, 'The State', '104', 662.434, -1534.66, 14.8514, 86.0671, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(106, 0, 50000, 'The State', '105', 657.444, -1528.45, 14.8514, 178.183, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(107, 0, 50000, 'The State', '106', 648.85, -1536.81, 14.9344, 269.445, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(108, 0, 50000, 'The State', '107', 660.395, -1599.85, 15, 173.245, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(109, 0, 50000, 'The State', '108', 692.797, -1602.77, 15.0467, 181.178, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812460, 0, 0, 0),
(110, 0, 50000, 'The State', '109', 653.241, -1619.91, 15, 269.408, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812614, 0, 0, 0),
(111, 0, 50000, 'The State', '110', 656.069, -1635.87, 15.8617, 4.0332, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812614, 0, 0, 0),
(112, 0, 50000, 'The State', '111', 657.227, -1652.65, 15.4062, 272.646, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812614, 0, 0, 0),
(113, 0, 50000, 'The State', '112', 652.662, -1694.06, 14.5506, 270.623, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812641, 0, 0, 0),
(114, 0, 50000, 'The State', '113', 653.596, -1714, 14.7646, 267.871, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812641, 0, 0, 0),
(115, 12, 1, 'Samuel_Ramirez', '114', 315.978, -1769.44, 4.624, 1.2783, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663226026, 1, 0, 0),
(116, 0, 100000, 'The State', '115', 295.284, -1764.12, 4.8699, 1.5212, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812641, 0, 0, 0),
(117, 0, 100000, 'The State', '116', 281.034, -1767.07, 4.5468, 359.174, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812641, 0, 0, 0),
(118, 0, 100000, 'The State', '117', 206.972, -1768.88, 4.3695, 359.336, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812641, 0, 0, 0),
(119, 0, 100000, 'The State', '118', 192.781, -1769.4, 4.3287, 3.1401, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812757, 0, 0, 0),
(120, 0, 100000, 'The State', '119', 168.243, -1768.41, 4.4867, 1.9261, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812757, 0, 0, 0),
(121, 0, 100000, 'The State', '120', 142.741, -1470.15, 25.2108, 141.654, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812757, 0, 0, 0),
(122, 0, 100000, 'The State', '121', 152.546, -1449.13, 32.8448, 230.892, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812757, 0, 0, 0),
(123, 131, 1, 'Leon_Kennedy', '122', 228.195, -1405.21, 51.6091, 156.018, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663205045, 0, 0, 0),
(124, 180, 100000, 'Jay_Francisco', '123', 189.639, -1308.37, 70.249, 89.9664, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663082400, 0, 0, 0),
(125, 133, 100000, 'Lana_Coraline', '124', 254.403, -1367.16, 53.1091, 125.825, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663177793, 0, 0, 0),
(126, 0, 100000, 'The State', '125', 298.737, -1338.43, 53.4415, 213.849, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662812757, 0, 0, 0),
(127, 0, 100000, 'The State', '126', 355.038, -1281.21, 53.7036, 205.836, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813130, 0, 0, 0),
(128, 0, 100000, 'The State', '127', 398.286, -1271.32, 50.0196, 203.407, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813130, 0, 0, 0),
(129, 0, 100000, 'The State', '128', 432.155, -1253.92, 51.5808, 202.355, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813130, 0, 0, 0),
(130, 0, 100000, 'The State', '129', 352.293, -1197.83, 76.5156, 220.774, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813200, 0, 0, 0),
(132, 0, 100000, 'The State', '131', 253.14, -1270.05, 74.4306, 208.345, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813200, 0, 0, 0),
(133, 0, 100000, 'The State', '132', 219.333, -1250.03, 78.3355, 43.5404, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813200, 0, 0, 0),
(134, 0, 100000, 'The State', '133', 251.489, -1220.17, 76.1023, 35.8506, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813200, 0, 0, 0),
(135, 0, 100000, 'The State', '134', 416.678, -1154.07, 76.6875, 325.59, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813200, 0, 0, 0),
(136, 0, 100000, 'The State', '135', 470.888, -1163.53, 67.2181, 12.9434, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813296, 0, 0, 0),
(137, 0, 100000, 'The State', '136', 558.841, -1160.96, 54.4295, 208.463, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813296, 0, 0, 0),
(138, 247, 1, 'Jelol_Junior', '137', 646.075, -1117.33, 44.207, 226.955, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663054593, 0, 0, 0),
(139, 0, 100000, 'The State', '138', 612.198, -1085.9, 58.8265, 214.328, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813328, 0, 0, 0),
(140, 0, 100000, 'The State', '139', 648.322, -1058.7, 52.5798, 227.441, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813328, 0, 0, 0),
(141, 38, 1, 'Eduardo_Marcell', '140', 700.232, -1060.38, 49.4216, 239.016, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663222513, 0, 0, 0),
(142, 0, 100000, 'The State', '141', 673.11, -1020.15, 55.7596, 246.176, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813328, 0, 0, 0),
(143, 0, 100000, 'The State', '142', 558.843, -1075.87, 72.9218, 212.385, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(144, 0, 100000, 'The State', '143', 497.972, -1094.77, 82.3591, 173.693, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(145, 105, 1, 'Kenzo_Devalos', '144', 724.79, -999.43, 52.7341, 153.375, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663228565, 1, 1, 0),
(146, 0, 100000, 'The State', '145', 785.957, -828.583, 70.2894, 188.785, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(147, 0, 100000, 'The State', '146', 808.227, -759.253, 76.5313, 108.613, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(148, 0, 100000, 'The State', '147', 835.774, -894.727, 68.7687, 155.111, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(149, 0, 100000, 'The State', '148', 827.808, -857.984, 70.3308, 18.7998, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(150, 0, 100000, 'The State', '149', 923.853, -853.302, 93.4564, 120.423, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(151, 0, 100000, 'The State', '150', 937.602, -848.838, 93.5771, 209.823, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(152, 0, 100000, 'The State', '151', 910.549, -817.457, 103.126, 209.139, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(153, 0, 100000, 'The State', '152', 891.089, -783.165, 101.313, 193.399, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(154, 0, 100000, 'The State', '153', 847.937, -745.447, 94.9692, 137.87, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(155, 0, 100000, 'The State', '154', 867.549, -717.52, 105.68, 159.689, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(156, 0, 100000, 'The State', '155', 898.069, -676.948, 116.89, 59.2803, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(157, 0, 100000, 'The State', '156', 946.267, -710.72, 122.62, 208.984, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(158, 0, 100000, 'The State', '157', 980.507, -677.252, 121.976, 208.58, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(159, 19, 1, 'Gun_Walters', '158', 1045.14, -642.942, 120.117, 190.286, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663177847, 0, 0, 0),
(160, 0, 100000, 'The State', '159', 1094.99, -647.707, 113.648, 181.868, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(161, 127, 1, 'Queensha_Ethelyn', '160', 1332.22, -633.459, 109.135, 200.728, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663074597, 0, 0, 0),
(162, 0, 100000, 'The State', '161', 1442.36, -628.829, 95.7184, 0.5943, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(163, 0, 100000, 'The State', '162', 1496.98, -687.892, 95.5633, 5.6129, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(164, 0, 100000, 'The State', '163', 1298.48, -798.115, 84.1406, 0.3515, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813489, 0, 0, 0),
(165, 29, 1, 'Xaviano_Leyva', '164', 1112.64, -741.946, 100.133, 269.163, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663182895, 0, 0, 0),
(166, 0, 100000, 'The State', '165', 1094.05, -807.119, 107.419, 191.294, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(167, 17, 1, 'Rojer_Hawkins', '166', 1034.92, -813.142, 101.852, 201.007, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663177479, 0, 0, 0),
(168, 0, 100000, 'The State', '167', 1016.61, -762.998, 112.563, 187.202, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(169, 0, 100000, 'The State', '168', 977.452, -771.548, 112.203, 178.136, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(170, 0, 100000, 'The State', '169', 989.79, -828.64, 95.4684, 214.561, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(171, 0, 100000, 'The State', '170', 1527.79, -772.671, 80.5781, 314.691, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(172, 0, 100000, 'The State', '171', 1535.04, -800.12, 72.8494, 273.004, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(173, 0, 100000, 'The State', '172', 1540.47, -851.126, 64.3359, 271.871, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(174, 0, 100000, 'The State', '173', 1468.49, -906.172, 54.8358, 183.155, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(175, 0, 100000, 'The State', '174', 1422.04, -886.142, 50.6832, 176.76, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(176, 0, 100000, 'The State', '175', 1410.89, -920.829, 38.4217, 347.025, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(177, 0, 100000, 'The State', '176', 1440.65, -926.141, 39.6475, 350.101, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(178, 0, 100000, 'The State', '177', 1325.95, -1067.75, 31.5545, 91.5251, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(179, 0, 100000, 'The State', '178', 1326.26, -1090.65, 27.9764, 87.4778, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662813833, 0, 0, 0),
(180, 0, 100000, 'The State', '179', 1242.27, -1099.75, 27.9764, 86.7051, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814089, 0, 0, 0),
(181, 0, 100000, 'The State', '180', 1285.27, -1090.06, 28.2577, 276.882, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814089, 0, 0, 0),
(182, 0, 100000, 'The State', '181', 1285.26, -1067.19, 31.6788, 269.921, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814089, 0, 0, 0),
(183, 0, 100000, 'The State', '182', 1242.02, -1076.95, 31.5545, 93.2173, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814089, 0, 0, 0),
(184, 0, 100000, 'The State', '183', 1183.47, -1099.55, 28.2577, 272.386, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(185, 0, 100000, 'The State', '184', 1142.12, -1092.81, 28.1875, 88.2352, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(186, 0, 100000, 'The State', '185', 1141.81, -1069.79, 31.7656, 85.6449, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(187, 0, 100000, 'The State', '186', 1183.47, -1075.96, 31.6788, 272.26, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(188, 0, 100000, 'The State', '187', 1127.82, -1021.24, 34.992, 0.3285, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(189, 0, 100000, 'The State', '188', 1118.36, -1021.24, 34.992, 5.1045, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(190, 0, 100000, 'The State', '189', 1103.4, -1069.39, 31.8897, 263.725, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(191, 0, 100000, 'The State', '190', 1068.42, -1081.26, 27.5669, 87.4259, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(192, 0, 100000, 'The State', '191', 1103.41, -1092.69, 28.4687, 273.96, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814157, 0, 0, 0),
(193, 0, 100000, 'The State', '192', 1059.37, -1105.14, 28.045, 3.8461, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814266, 0, 0, 0),
(194, 0, 100000, 'The State', '193', 985.951, -1094.39, 27.604, 11.6534, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814266, 0, 0, 0),
(195, 0, 30000, 'The State', '194', -68.9116, -1545.79, 3.0043, 321.909, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814354, 0, 0, 0),
(196, 0, 30000, 'The State', '195', -89.1903, -1564.47, 3.0043, 42.4858, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814354, 0, 0, 0),
(197, 0, 30000, 'The State', '196', -91.2472, -1592.52, 3.0043, 122.334, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662814354, 0, 0, 0),
(198, 7, 1, 'Berlin_Varcelo', '197', -427.625, -392.714, 16.5799, 144.684, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663199468, 0, 0, 0),
(199, 115, 1, 'Arjun_Walker', '0', 2392.36, -54.963, 28.1534, 194.519, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1662869679, 0, 0, 0),
(200, 54, 1, 'Rudulf_Geraldo', 'Jefferson', 2132.35, -1280.05, 25.8906, 3.194, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663177498, 0, 0, 0),
(201, 11, 1, 'Plutarco_Echeverra', '198', 2129.59, -1361.69, 26.1361, 1.0777, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663150745, 0, 0, 0),
(202, 15, 100000, 'Oscar_Vengeance', 'Bluberry', 252.888, -121.271, 3.5353, 267.726, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663229527, 1, 0, 0),
(203, 36, 1, 'Jayce_Hylton', 'Crenshaw 1', 2148.94, -1484.91, 26.624, 267.729, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663085943, 0, 0, 0),
(204, 41, 1, 'Navaro_Guillermo', 'Crenshaw 2', 2152.22, -1446.4, 26.1049, 269.862, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663073273, 0, 0, 0),
(205, 13, 30000, 'Kudak_Deblow', 'Jefferson 1', 2153.74, -1243.81, 25.367, 180.04, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663230555, 0, 0, 0),
(206, 192, 1, 'Jahmiree_Maleek', 'Crenshaw 3', 2190.44, -1470.38, 25.9139, 89.0966, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663158153, 0, 0, 0),
(207, 105, 1, 'Kenzo_Devalos', '201', -392.188, -1439.27, 26.3388, 274.345, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663228565, 1, 1, 0),
(208, 210, 1, 'Cho_Tabim', 'Mullholand', 300.113, -1154.32, 81.3899, 303.331, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663073448, 0, 0, 0),
(209, 133, 1, 'Lana_Coraline', '202', 252.887, -92.4194, 3.5353, 270.951, 1882.12, -2434.84, 13.5845, 358.311, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663177793, 0, 0, 0),
(210, 16, 30000, 'Axel_Volter', '203', 295.165, -54.5447, 2.7771, 358.241, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663231077, 0, 0, 0),
(211, 62, 1, 'Vittorini_Leovince', 'blubery', 312.925, -92.2835, 3.5353, 91.7723, 1882.12, -2434.84, 13.5845, 358.311, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663213440, 1, 0, 0),
(212, 64, 1, 'Synester_Vengeance', 'Blueberry 1', 267.692, -54.5429, 2.7771, 0.2818, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 1663219247, 0, 0, 0),
(229, 23, 1, 'Vayler_Coleman', 'Idlewood', 1980.37, -1718.99, 17.0303, 89.1221, 1954.15, 2818.29, 13.8837, 0.3486, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663221023, 0, 0, 0),
(230, 335, 1, 'Veto_Vercetti', 'El Corona', 1854.04, -1914.26, 15.2566, 357.819, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663225154, 0, 0, 0),
(231, 69, 1, 'Federico_Gavi', 'Ganton', 2514.33, -1691.61, 14.0459, 228.01, 1875.94, -2408.62, 13.5845, 176.977, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1663229292, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `housestorage`
--

CREATE TABLE `housestorage` (
  `ID` int(12) DEFAULT 0,
  `itemID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `housestorage`
--

INSERT INTO `housestorage` (`ID`, `itemID`, `itemName`, `itemModel`, `itemQuantity`) VALUES
(34, 1, 'Marijuana', 1578, 11000),
(35, 2, 'Marijuana', 1578, 54000),
(35, 5, 'Component', 18633, 2000),
(95, 9, 'Marijuana', 1578, 3970),
(95, 10, 'Materials', 11746, 3750),
(20, 11, 'Marijuana', 1578, 9865),
(210, 12, 'Materials', 11746, 91939),
(165, 14, 'Cigarettes', 19896, 10),
(165, 15, 'Laptop', 19893, 1),
(84, 18, 'Marijuana', 1578, 3145),
(82, 20, 'Materials', 11746, 10000),
(82, 21, 'Marijuana', 1578, 184),
(29, 22, 'Marijuana', 1578, 143),
(29, 23, 'Materials', 11746, 100),
(34, 24, 'LSD', 1578, 1000),
(34, 25, 'Ecstasy', 1578, 1000),
(34, 26, 'Cocaine', 1575, 1000),
(34, 27, 'Heroin', 1577, 1000),
(34, 28, 'Steroids', 1241, 1000),
(210, 30, 'Cocaine', 1575, 67),
(212, 31, 'Cocaine', 1575, 545),
(212, 32, 'Marijuana', 1578, 905),
(91, 33, 'Component', 18633, 31000),
(212, 34, 'Materials', 11746, 57280),
(91, 35, 'Marijuana', 1578, 520),
(30, 36, 'Marijuana', 1578, 50),
(35, 37, 'Materials', 11746, 23919),
(210, 38, 'Marijuana', 1578, 115),
(25, 40, 'Component', 18633, 818),
(25, 41, 'Marijuana', 1578, 1),
(25, 42, 'First Aid', 1580, 6),
(25, 44, 'Lazattavitus Extra', 2709, 9),
(25, 45, 'Neladryl Acetate', 2709, 10),
(25, 49, 'Kratotamax Plus 1.0', 2709, 10),
(25, 50, 'Frozen Pizza', 2814, 10),
(25, 51, 'Water', 1484, 10),
(34, 53, 'Materials', 11746, 97700),
(230, 54, 'Materials', 11746, 10000),
(230, 55, 'Marijuana', 1578, 1000),
(33, 56, 'Materials', 11746, 10768),
(33, 57, 'Marijuana', 1578, 765);

-- --------------------------------------------------------

--
-- Table structure for table `house_queue`
--

CREATE TABLE `house_queue` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Location` varchar(24) NOT NULL,
  `Date` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Username` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `impoundlots`
--

CREATE TABLE `impoundlots` (
  `impoundID` int(12) NOT NULL,
  `impoundLotX` float DEFAULT 0,
  `impoundLotY` float DEFAULT 0,
  `impoundLotZ` float DEFAULT 0,
  `impoundReleaseX` float DEFAULT 0,
  `impoundReleaseY` float DEFAULT 0,
  `impoundReleaseZ` float DEFAULT 0,
  `impoundReleaseInt` int(12) DEFAULT 0,
  `impoundReleaseWorld` int(12) DEFAULT 0,
  `impoundReleaseA` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `ID` int(12) DEFAULT 0,
  `invID` int(12) NOT NULL,
  `invItem` varchar(32) DEFAULT NULL,
  `invModel` int(12) DEFAULT 0,
  `invQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`ID`, `invID`, `invItem`, `invModel`, `invQuantity`) VALUES
(2, 1, 'GPS System', 18875, 1),
(2, 2, 'Component', 18633, 400),
(23, 3, 'GPS System', 18875, 1),
(6, 4, 'Mask', 19036, 1),
(59, 5, 'Mask', 19036, 1),
(59, 6, 'First Aid', 1580, 1),
(6, 7, 'Water', 1484, 5),
(11, 8, 'Mask', 19036, 1),
(11, 9, 'Spray Can', 365, 1),
(2, 10, 'Water', 1484, 1),
(62, 11, 'Mask', 19036, 1),
(29, 12, 'Mask', 19036, 1),
(29, 13, 'Cigarettes', 19896, 7),
(29, 15, 'Campfire', 19632, 1),
(7, 16, 'GPS System', 18875, 1),
(7, 18, 'Component', 18633, 2000),
(68, 23, 'Mask', 19036, 1),
(68, 24, 'Campfire', 19632, 1),
(3, 25, 'Cigarettes', 19896, 20),
(3, 26, 'Mask', 19036, 1),
(70, 27, 'Spray Can', 365, 1),
(70, 28, 'First Aid', 1580, 3),
(70, 29, 'Frozen Pizza', 2814, 1),
(70, 30, 'Mask', 19036, 1),
(70, 31, 'Water', 1484, 1),
(70, 32, 'Campfire', 19632, 1),
(70, 33, 'Cigarettes', 19896, 20),
(51, 34, 'GPS System', 18875, 1),
(87, 35, 'Mask', 19036, 1),
(87, 36, 'Water', 1484, 5),
(87, 37, 'Cigarettes', 19896, 20),
(87, 38, 'Spray Can', 365, 1),
(95, 39, 'Mask', 19036, 1),
(89, 40, 'Mask', 19036, 1),
(95, 41, 'Cigarettes', 19896, 20),
(89, 42, 'First Aid', 1580, 1),
(89, 43, 'Cigarettes', 19896, 17),
(96, 45, 'Mask', 19036, 1),
(96, 47, 'Cigarettes', 19896, 20),
(68, 48, 'Bait', 19630, 40),
(68, 49, 'Fish Rod', 18632, 1),
(90, 50, 'Cigarettes', 19896, 20),
(63, 51, 'Cigarettes', 19896, 20),
(63, 52, 'Mask', 19036, 1),
(108, 53, 'Mask', 19036, 1),
(107, 54, 'GPS System', 18875, 1),
(96, 55, 'GPS System', 18875, 1),
(90, 56, 'GPS System', 18875, 1),
(108, 57, 'GPS System', 18875, 1),
(109, 58, 'GPS System', 18875, 1),
(91, 59, 'GPS System', 18875, 1),
(111, 60, 'GPS System', 18875, 1),
(92, 61, 'GPS System', 18875, 1),
(17, 62, 'GPS System', 18875, 1),
(100, 63, 'Mask', 19036, 1),
(63, 64, 'GPS System', 18875, 1),
(2, 66, 'Snack', 2768, 1),
(23, 67, 'Cellphone', 330, 1),
(125, 68, 'Campfire', 19632, 1),
(121, 69, 'Spray Can', 365, 1),
(119, 70, 'Cigarettes', 19896, 19),
(121, 71, 'Mask', 19036, 1),
(130, 72, 'First Aid', 1580, 1),
(130, 73, 'Campfire', 19632, 1),
(54, 76, 'Mask', 19036, 1),
(37, 77, 'First Aid', 1580, 3),
(9, 78, 'Cigarettes', 19896, 13),
(15, 80, 'Cigarettes', 19896, 8),
(15, 81, 'Mask', 19036, 1),
(15, 82, 'First Aid', 1580, 2),
(115, 83, 'GPS System', 18875, 1),
(115, 84, 'Cellphone', 330, 1),
(115, 85, 'Portable Radio', 18868, 1),
(132, 86, 'Cellphone', 330, 1),
(128, 87, 'Cellphone', 330, 1),
(9, 88, 'GPS System', 18875, 1),
(9, 89, 'Cellphone', 330, 1),
(113, 91, 'Cellphone', 330, 1),
(64, 92, 'GPS System', 18875, 1),
(34, 93, 'Cellphone', 330, 1),
(34, 94, 'GPS System', 18875, 1),
(34, 95, 'MP3 Player', 18875, 1),
(34, 96, 'Laptop', 19893, 1),
(77, 97, 'GPS System', 18875, 1),
(141, 98, 'GPS System', 18875, 1),
(141, 99, 'Cellphone', 330, 1),
(141, 100, 'MP3 Player', 18875, 1),
(23, 101, 'Kratotamax Plus 1.0', 2709, 10),
(143, 102, 'Marijuana', 1578, 100),
(77, 103, 'Cellphone', 330, 1),
(62, 104, 'Materials', 11746, 32379),
(19, 105, 'Cellphone', 330, 1),
(19, 106, 'GPS System', 18875, 1),
(19, 107, 'Portable Radio', 18868, 1),
(136, 109, 'Mask', 19036, 1),
(136, 110, 'Campfire', 19632, 1),
(136, 111, 'Cigarettes', 19896, 20),
(136, 112, 'First Aid', 1580, 1),
(136, 113, 'Spray Can', 365, 1),
(136, 114, 'Cellphone', 330, 1),
(136, 115, 'GPS System', 18875, 1),
(136, 116, 'Portable Radio', 18868, 1),
(136, 117, 'Laptop', 19893, 1),
(136, 118, 'MP3 Player', 18875, 1),
(153, 120, 'GPS System', 18875, 1),
(153, 121, 'Cellphone', 330, 1),
(40, 122, 'Mask', 19036, 1),
(142, 124, 'Cigarettes', 19896, 19),
(142, 125, 'Mask', 19036, 1),
(156, 127, 'Cellphone', 330, 1),
(156, 128, 'GPS System', 18875, 1),
(156, 129, 'Portable Radio', 18868, 1),
(156, 130, 'Laptop', 19893, 1),
(156, 131, 'MP3 Player', 18875, 1),
(151, 134, 'Mask', 19036, 1),
(151, 135, 'Spray Can', 365, 1),
(116, 136, 'Cigarettes', 19896, 5),
(151, 138, 'Campfire', 19632, 1),
(151, 139, 'Cigarettes', 19896, 20),
(116, 140, 'Mask', 19036, 1),
(116, 142, 'First Aid', 1580, 2),
(155, 144, 'Cigarettes', 19896, 16),
(155, 145, 'Mask', 19036, 1),
(155, 146, 'First Aid', 1580, 1),
(17, 151, 'Cellphone', 330, 1),
(23, 158, 'Marijuana', 1578, 5),
(40, 159, 'GPS System', 18875, 1),
(54, 165, 'GPS System', 18875, 1),
(54, 166, 'Portable Radio', 18868, 1),
(54, 167, 'Cellphone', 330, 1),
(116, 171, 'Fish Rod', 18632, 1),
(116, 172, 'Bait', 19630, 98),
(157, 173, 'Fish Rod', 18632, 1),
(157, 174, 'Bait', 19630, 60),
(116, 195, 'GPS System', 18875, 1),
(116, 196, 'Cellphone', 330, 1),
(116, 199, 'Portable Radio', 18868, 1),
(157, 201, 'GPS System', 18875, 1),
(157, 204, 'Portable Radio', 18868, 1),
(116, 207, 'MP3 Player', 18875, 1),
(160, 235, 'Kratotamax Plus 1.0', 2709, 1),
(6, 236, 'Lazattavitus Extra', 2709, 6),
(133, 240, 'GPS System', 18875, 1),
(62, 241, 'Cellphone', 330, 1),
(133, 242, 'Cellphone', 330, 1),
(64, 243, 'Cellphone', 330, 1),
(62, 244, 'GPS System', 18875, 1),
(64, 245, 'Portable Radio', 18868, 1),
(62, 246, 'Portable Radio', 18868, 1),
(133, 247, 'Portable Radio', 18868, 1),
(64, 248, 'MP3 Player', 18875, 1),
(62, 249, 'Laptop', 19893, 1),
(133, 250, 'MP3 Player', 18875, 1),
(25, 251, 'Bait', 19630, 100),
(25, 252, 'GPS System', 18875, 1),
(25, 253, 'Cellphone', 330, 1),
(6, 262, 'GPS System', 18875, 1),
(6, 263, 'Cellphone', 330, 1),
(6, 264, 'Portable Radio', 18868, 1),
(6, 265, 'MP3 Player', 18875, 1),
(6, 266, 'Laptop', 19893, 1),
(29, 267, 'Cellphone', 330, 1),
(29, 268, 'GPS System', 18875, 1),
(29, 269, 'Portable Radio', 18868, 1),
(29, 270, 'MP3 Player', 18875, 1),
(29, 272, 'First Aid', 1580, 3),
(160, 273, 'Cellphone', 330, 1),
(160, 274, 'GPS System', 18875, 1),
(158, 275, 'Cellphone', 330, 1),
(160, 276, 'Portable Radio', 18868, 1),
(158, 277, 'GPS System', 18875, 1),
(160, 278, 'Laptop', 19893, 1),
(158, 280, 'Laptop', 19893, 1),
(160, 281, 'MP3 Player', 18875, 1),
(160, 282, 'First Aid', 1580, 1),
(160, 283, 'Mask', 19036, 1),
(158, 284, 'Mask', 19036, 1),
(160, 285, 'Cigarettes', 19896, 18),
(158, 286, 'Cigarettes', 19896, 20),
(160, 288, 'Water', 1484, 1),
(139, 289, 'First Aid', 1580, 3),
(139, 290, 'Cigarettes', 19896, 20),
(139, 291, 'Spray Can', 365, 1),
(139, 293, 'Mask', 19036, 1),
(139, 294, 'Water', 1484, 4),
(159, 295, 'Cigarettes', 19896, 11),
(159, 296, 'Mask', 19036, 1),
(159, 297, 'First Aid', 1580, 2),
(159, 298, 'Frozen Pizza', 2814, 1),
(104, 301, 'Portable Radio', 18868, 1),
(64, 302, 'Marijuana', 1578, 60),
(31, 304, 'GPS System', 18875, 1),
(31, 308, 'Cellphone', 330, 1),
(166, 310, 'GPS System', 18875, 1),
(166, 311, 'Cellphone', 330, 1),
(4, 312, 'Mask', 19036, 1),
(4, 313, 'GPS System', 18875, 1),
(4, 314, 'Cellphone', 330, 1),
(4, 315, 'Portable Radio', 18868, 1),
(67, 316, 'Cellphone', 330, 1),
(67, 317, 'GPS System', 18875, 1),
(71, 318, 'GPS System', 18875, 1),
(71, 319, 'Laptop', 19893, 1),
(71, 320, 'Cellphone', 330, 1),
(71, 321, 'Portable Radio', 18868, 1),
(172, 322, 'Cellphone', 330, 1),
(172, 323, 'GPS System', 18875, 1),
(172, 325, 'Laptop', 19893, 1),
(173, 326, 'GPS System', 18875, 1),
(173, 327, 'Cellphone', 330, 1),
(174, 328, 'GPS System', 18875, 1),
(174, 329, 'Cellphone', 330, 1),
(175, 330, 'GPS System', 18875, 1),
(175, 331, 'Cellphone', 330, 1),
(180, 332, 'Cellphone', 330, 1),
(180, 333, 'GPS System', 18875, 1),
(180, 334, 'Portable Radio', 18868, 1),
(180, 335, 'Laptop', 19893, 1),
(180, 336, 'MP3 Player', 18875, 1),
(179, 337, 'GPS System', 18875, 1),
(180, 338, 'Mask', 19036, 1),
(180, 339, 'Campfire', 19632, 1),
(178, 340, 'GPS System', 18875, 1),
(178, 341, 'Cellphone', 330, 1),
(179, 342, 'Materials', 11746, 100),
(15, 343, 'GPS System', 18875, 1),
(15, 344, 'MP3 Player', 18875, 1),
(15, 345, 'Portable Radio', 18868, 1),
(15, 346, 'Laptop', 19893, 1),
(102, 347, 'Cellphone', 330, 1),
(102, 348, 'GPS System', 18875, 1),
(102, 349, 'Portable Radio', 18868, 1),
(7, 350, 'Cellphone', 330, 1),
(7, 351, 'Portable Radio', 18868, 1),
(102, 352, 'Laptop', 19893, 1),
(9, 353, 'Mask', 19036, 1),
(184, 354, 'GPS System', 18875, 1),
(184, 356, 'Cellphone', 330, 1),
(184, 357, 'Portable Radio', 18868, 1),
(184, 358, 'Laptop', 19893, 1),
(184, 359, 'MP3 Player', 18875, 1),
(9, 360, 'Water', 1484, 5),
(23, 361, 'Neladryl Acetate', 2709, 10),
(9, 362, 'Spray Can', 365, 2),
(23, 363, 'Lazattavitus Extra', 2709, 10),
(155, 365, 'GPS System', 18875, 1),
(155, 366, 'MP3 Player', 18875, 1),
(155, 367, 'Cellphone', 330, 1),
(155, 368, 'Portable Radio', 18868, 1),
(14, 369, 'Mask', 19036, 1),
(14, 371, 'Cellphone', 330, 1),
(14, 372, 'GPS System', 18875, 1),
(14, 373, 'Portable Radio', 18868, 1),
(14, 374, 'MP3 Player', 18875, 1),
(5, 383, 'GPS System', 18875, 1),
(174, 384, 'Bait', 19630, 20),
(174, 385, 'Fish Rod', 18632, 1),
(11, 386, 'Cellphone', 330, 1),
(11, 387, 'GPS System', 18875, 1),
(11, 388, 'Portable Radio', 18868, 1),
(11, 389, 'MP3 Player', 18875, 1),
(11, 390, 'Laptop', 19893, 1),
(18, 391, 'Cellphone', 330, 1),
(18, 392, 'GPS System', 18875, 1),
(18, 393, 'Portable Radio', 18868, 1),
(126, 394, 'Mask', 19036, 1),
(187, 395, 'Cigarettes', 19896, 20),
(126, 400, 'GPS System', 18875, 1),
(126, 401, 'Cellphone', 330, 1),
(187, 402, 'GPS System', 18875, 1),
(187, 403, 'Cellphone', 330, 1),
(58, 404, 'Mask', 19036, 1),
(187, 405, 'MP3 Player', 18875, 1),
(58, 406, 'Cellphone', 330, 1),
(58, 407, 'GPS System', 18875, 1),
(58, 408, 'Portable Radio', 18868, 1),
(58, 409, 'MP3 Player', 18875, 1),
(58, 410, 'Laptop', 19893, 1),
(12, 413, 'Cellphone', 330, 1),
(65, 417, 'Mask', 19036, 1),
(13, 419, 'Cellphone', 330, 1),
(13, 420, 'GPS System', 18875, 1),
(13, 421, 'Laptop', 19893, 1),
(65, 422, 'Cellphone', 330, 1),
(65, 423, 'GPS System', 18875, 1),
(152, 425, 'Cellphone', 330, 1),
(12, 426, 'Mask', 19036, 1),
(12, 428, 'Spray Can', 365, 2),
(12, 429, 'Frozen Pizza', 2814, 1),
(85, 430, 'Cellphone', 330, 1),
(85, 431, 'GPS System', 18875, 1),
(85, 432, 'Portable Radio', 18868, 1),
(12, 433, 'GPS System', 18875, 1),
(85, 434, 'Laptop', 19893, 1),
(85, 435, 'MP3 Player', 18875, 1),
(26, 437, 'Component', 18633, 700),
(114, 438, 'Mask', 19036, 1),
(65, 440, 'First Aid', 1580, 3),
(65, 441, 'Frozen Pizza', 2814, 5),
(114, 442, 'Cellphone', 330, 1),
(114, 443, 'GPS System', 18875, 1),
(65, 445, 'Cigarettes', 19896, 19),
(131, 447, 'Cellphone', 330, 1),
(131, 448, 'Mask', 19036, 1),
(131, 449, 'Portable Radio', 18868, 1),
(131, 450, 'Fuel Can', 1650, 3),
(131, 451, 'First Aid', 1580, 3),
(27, 453, 'Mask', 19036, 1),
(27, 454, 'GPS System', 18875, 1),
(27, 455, 'Cellphone', 330, 1),
(36, 457, 'GPS System', 18875, 1),
(36, 458, 'Cellphone', 330, 1),
(194, 459, 'Cellphone', 330, 1),
(194, 460, 'GPS System', 18875, 1),
(49, 461, 'GPS System', 18875, 1),
(49, 462, 'Cellphone', 330, 1),
(155, 463, 'Component', 18633, 667),
(95, 466, 'Cellphone', 330, 1),
(95, 467, 'GPS System', 18875, 1),
(95, 468, 'Portable Radio', 18868, 1),
(95, 469, 'Laptop', 19893, 1),
(95, 470, 'MP3 Player', 18875, 1),
(192, 471, 'GPS System', 18875, 1),
(114, 484, 'Bait', 19630, 20),
(114, 486, 'Fish Rod', 18632, 1),
(194, 494, 'Laptop', 19893, 1),
(151, 495, 'GPS System', 18875, 1),
(117, 496, 'GPS System', 18875, 1),
(151, 497, 'Cellphone', 330, 1),
(117, 498, 'Cellphone', 330, 1),
(37, 500, 'Cellphone', 330, 1),
(37, 501, 'GPS System', 18875, 1),
(16, 505, 'Mask', 19036, 1),
(16, 509, 'Portable Radio', 18868, 1),
(16, 510, 'GPS System', 18875, 1),
(16, 511, 'Cellphone', 330, 1),
(89, 512, 'Cellphone', 330, 1),
(89, 513, 'GPS System', 18875, 1),
(89, 514, 'Portable Radio', 18868, 1),
(89, 515, 'MP3 Player', 18875, 1),
(89, 516, 'Laptop', 19893, 1),
(16, 517, 'MP3 Player', 18875, 1),
(37, 522, 'Mask', 19036, 1),
(133, 529, 'Cigarettes', 19896, 20),
(133, 530, 'Mask', 19036, 1),
(35, 532, 'Portable Radio', 18868, 1),
(35, 533, 'Cellphone', 330, 1),
(35, 534, 'GPS System', 18875, 1),
(142, 536, 'GPS System', 18875, 1),
(142, 537, 'Portable Radio', 18868, 1),
(79, 538, 'Cellphone', 330, 1),
(79, 539, 'GPS System', 18875, 1),
(79, 540, 'Portable Radio', 18868, 1),
(142, 541, 'Cellphone', 330, 1),
(152, 545, 'GPS System', 18875, 1),
(206, 550, 'Mask', 19036, 1),
(206, 551, 'Water', 1484, 1),
(123, 554, 'Cellphone', 330, 1),
(123, 555, 'MP3 Player', 18875, 1),
(123, 556, 'Portable Radio', 18868, 1),
(123, 557, 'GPS System', 18875, 1),
(123, 559, 'Laptop', 19893, 1),
(18, 563, 'Mask', 19036, 1),
(18, 565, 'Frozen Pizza', 2814, 1),
(193, 566, 'Cellphone', 330, 1),
(193, 567, 'GPS System', 18875, 1),
(193, 568, 'Portable Radio', 18868, 1),
(193, 569, 'MP3 Player', 18875, 1),
(27, 571, 'Bait', 19630, 2),
(27, 572, 'Fish Rod', 18632, 1),
(207, 573, 'GPS System', 18875, 1),
(207, 574, 'Cellphone', 330, 1),
(60, 577, 'Cigarettes', 19896, 18),
(60, 578, 'Mask', 19036, 1),
(60, 580, 'Laptop', 19893, 1),
(60, 581, 'GPS System', 18875, 1),
(60, 582, 'Cellphone', 330, 1),
(60, 583, 'Portable Radio', 18868, 1),
(105, 584, 'Cellphone', 330, 1),
(105, 585, 'GPS System', 18875, 1),
(105, 586, 'Laptop', 19893, 1),
(84, 588, 'GPS System', 18875, 1),
(41, 589, 'Mask', 19036, 1),
(41, 590, 'First Aid', 1580, 1),
(41, 594, 'Portable Radio', 18868, 1),
(41, 595, 'GPS System', 18875, 1),
(41, 596, 'Cellphone', 330, 1),
(41, 597, 'MP3 Player', 18875, 1),
(35, 599, 'Marijuana', 1578, 1000),
(8, 600, 'First Aid', 1580, 3),
(8, 601, 'Cigarettes', 19896, 20),
(8, 602, 'Campfire', 19632, 1),
(157, 603, 'Cigarettes', 19896, 2),
(202, 607, 'GPS System', 18875, 1),
(202, 608, 'Cellphone', 330, 1),
(65, 616, 'MP3 Player', 18875, 1),
(65, 617, 'Portable Radio', 18868, 1),
(177, 618, 'GPS System', 18875, 1),
(177, 619, 'Cellphone', 330, 1),
(214, 621, 'Cellphone', 330, 1),
(214, 622, 'GPS System', 18875, 1),
(214, 623, 'Laptop', 19893, 1),
(214, 624, 'MP3 Player', 18875, 1),
(214, 625, 'Portable Radio', 18868, 1),
(69, 627, 'Cellphone', 330, 1),
(69, 628, 'GPS System', 18875, 1),
(180, 629, 'Component', 18633, 900),
(152, 632, 'First Aid', 1580, 3),
(219, 634, 'Mask', 19036, 1),
(219, 635, 'Cigarettes', 19896, 17),
(219, 637, 'Portable Radio', 18868, 1),
(219, 638, 'Cellphone', 330, 1),
(219, 639, 'GPS System', 18875, 1),
(84, 640, 'Cellphone', 330, 1),
(8, 641, 'Kratotamax Plus 1.0', 2709, 2),
(8, 645, 'Water', 1484, 3),
(8, 647, 'Mask', 19036, 1),
(144, 652, 'Mask', 19036, 1),
(144, 653, 'Cigarettes', 19896, 20),
(144, 655, 'Cellphone', 330, 1),
(144, 656, 'GPS System', 18875, 1),
(64, 659, 'Cocaine', 1575, 20),
(89, 661, 'Cocaine', 1575, 100),
(108, 665, 'Cellphone', 330, 1),
(108, 667, 'Portable Radio', 18868, 1),
(225, 669, 'Cellphone', 330, 1),
(225, 670, 'GPS System', 18875, 1),
(225, 671, 'Portable Radio', 18868, 1),
(225, 672, 'MP3 Player', 18875, 1),
(131, 674, 'MP3 Player', 18875, 1),
(222, 681, 'Water', 1484, 1),
(192, 682, 'Cellphone', 330, 1),
(192, 683, 'Portable Radio', 18868, 1),
(222, 684, 'Mask', 19036, 1),
(222, 685, 'Cellphone', 330, 1),
(222, 686, 'GPS System', 18875, 1),
(233, 691, 'Mask', 19036, 1),
(233, 692, 'GPS System', 18875, 1),
(233, 693, 'Cellphone', 330, 1),
(28, 694, 'Cellphone', 330, 1),
(28, 695, 'GPS System', 18875, 1),
(28, 697, 'Laptop', 19893, 1),
(233, 698, 'Cigarettes', 19896, 19),
(165, 700, 'Cellphone', 330, 1),
(165, 701, 'GPS System', 18875, 1),
(165, 702, 'MP3 Player', 18875, 1),
(2, 704, 'Cellphone', 330, 1),
(165, 705, 'Component', 18633, 80),
(35, 709, 'First Aid', 1580, 2),
(123, 711, 'Frozen Pizza', 2814, 1),
(35, 712, 'Mask', 19036, 1),
(8, 718, 'GPS System', 18875, 1),
(40, 719, 'Cellphone', 330, 1),
(88, 721, 'GPS System', 18875, 1),
(88, 722, 'Cellphone', 330, 1),
(235, 724, 'Cocaine', 1575, 10),
(235, 725, 'Marijuana', 1578, 10),
(235, 726, 'Ecstasy', 1578, 10),
(241, 739, 'Mask', 19036, 1),
(241, 740, 'Cellphone', 330, 1),
(241, 741, 'GPS System', 18875, 1),
(241, 742, 'Laptop', 19893, 1),
(241, 743, 'MP3 Player', 18875, 1),
(241, 744, 'Portable Radio', 18868, 1),
(30, 745, 'Mask', 19036, 1),
(30, 746, 'First Aid', 1580, 1),
(239, 747, 'GPS System', 18875, 1),
(221, 748, 'GPS System', 18875, 1),
(221, 749, 'Cellphone', 330, 1),
(239, 750, 'Cellphone', 330, 1),
(30, 751, 'GPS System', 18875, 1),
(30, 752, 'Cellphone', 330, 1),
(30, 753, 'Portable Radio', 18868, 1),
(30, 754, 'Laptop', 19893, 1),
(30, 755, 'MP3 Player', 18875, 1),
(64, 756, 'Mask', 19036, 1),
(15, 758, 'Cellphone', 330, 1),
(88, 759, 'Portable Radio', 18868, 1),
(88, 760, 'MP3 Player', 18875, 1),
(19, 764, 'Cigarettes', 19896, 13),
(19, 766, 'Mask', 19036, 1),
(225, 767, 'Spray Can', 365, 3),
(16, 771, 'Laptop', 19893, 1),
(244, 773, 'Cellphone', 330, 1),
(225, 774, 'Component', 18633, 50),
(244, 775, 'GPS System', 18875, 1),
(244, 776, 'Portable Radio', 18868, 1),
(226, 782, 'Spray Can', 365, 2),
(192, 783, 'Mask', 19036, 1),
(226, 786, 'Cigarettes', 19896, 14),
(192, 787, 'Cigarettes', 19896, 16),
(226, 788, 'Mask', 19036, 1),
(192, 789, 'Spray Can', 365, 1),
(246, 790, 'GPS System', 18875, 1),
(246, 791, 'Cellphone', 330, 1),
(223, 792, 'GPS System', 18875, 1),
(46, 796, 'GPS System', 18875, 1),
(46, 797, 'Cellphone', 330, 1),
(46, 798, 'Portable Radio', 18868, 1),
(46, 799, 'MP3 Player', 18875, 1),
(193, 800, 'Cigarettes', 19896, 18),
(161, 801, 'Cellphone', 330, 1),
(161, 802, 'GPS System', 18875, 1),
(161, 803, 'Portable Radio', 18868, 1),
(24, 804, 'GPS System', 18875, 1),
(24, 805, 'Cellphone', 330, 1),
(241, 807, 'First Aid', 1580, 1),
(241, 808, 'Cigarettes', 19896, 19),
(225, 809, 'Kratotamax Plus 1.0', 2709, 5),
(225, 810, 'Lazattavitus Extra', 2709, 4),
(38, 811, 'GPS System', 18875, 1),
(38, 812, 'Cellphone', 330, 1),
(38, 813, 'Portable Radio', 18868, 1),
(38, 814, 'Laptop', 19893, 1),
(38, 815, 'MP3 Player', 18875, 1),
(131, 816, 'Cigarettes', 19896, 20),
(131, 817, 'Spray Can', 365, 2),
(223, 818, 'Cellphone', 330, 1),
(195, 823, 'Cigarettes', 19896, 19),
(195, 824, 'Mask', 19036, 1),
(31, 838, 'Mask', 19036, 1),
(144, 846, 'Portable Radio', 18868, 1),
(195, 847, 'Portable Radio', 18868, 1),
(195, 848, 'Cellphone', 330, 1),
(195, 849, 'GPS System', 18875, 1),
(195, 850, 'MP3 Player', 18875, 1),
(131, 852, 'Kratotamax Plus 1.0', 2709, 3),
(252, 855, 'GPS System', 18875, 1),
(252, 856, 'Cellphone', 330, 1),
(252, 857, 'Portable Radio', 18868, 1),
(252, 858, 'Laptop', 19893, 1),
(252, 859, 'MP3 Player', 18875, 1),
(131, 861, 'Lazattavitus Extra', 2709, 2),
(254, 872, 'Cellphone', 330, 1),
(254, 873, 'GPS System', 18875, 1),
(255, 874, 'Campfire', 19632, 1),
(255, 875, 'Cigarettes', 19896, 19),
(173, 876, 'Laptop', 19893, 1),
(173, 877, 'Portable Radio', 18868, 1),
(173, 878, 'Mask', 19036, 1),
(165, 880, 'Mask', 19036, 1),
(175, 885, 'Frozen Pizza', 2814, 1),
(105, 887, 'Mask', 19036, 1),
(217, 888, 'GPS System', 18875, 1),
(217, 889, 'Cellphone', 330, 1),
(219, 890, 'First Aid', 1580, 1),
(105, 891, 'MP3 Player', 18875, 1),
(226, 893, 'Cocaine', 1575, 25),
(192, 894, 'Cocaine', 1575, 70),
(219, 895, 'Cocaine', 1575, 5),
(13, 896, 'Cigarettes', 19896, 17),
(13, 898, 'Mask', 19036, 1),
(60, 902, 'Spray Can', 365, 1),
(60, 903, 'First Aid', 1580, 1),
(259, 906, 'Spray Can', 365, 1),
(259, 908, 'GPS System', 18875, 1),
(259, 909, 'Cellphone', 330, 1),
(9, 910, 'Marijuana', 1578, 149),
(254, 912, 'Bait', 19630, 20),
(216, 913, 'Cellphone', 330, 1),
(216, 914, 'Portable Radio', 18868, 1),
(216, 915, 'First Aid', 1580, 2),
(26, 916, 'Mask', 19036, 1),
(26, 917, 'GPS System', 18875, 1),
(26, 918, 'Cellphone', 330, 1),
(26, 919, 'Portable Radio', 18868, 1),
(254, 921, 'Fish Rod', 18632, 1),
(9, 923, 'First Aid', 1580, 1),
(36, 924, 'First Aid', 1580, 3),
(36, 925, 'Mask', 19036, 1),
(36, 926, 'Spray Can', 365, 2),
(36, 927, 'Cigarettes', 19896, 19),
(36, 928, 'Campfire', 19632, 1),
(36, 929, 'Water', 1484, 2),
(12, 930, 'Portable Radio', 18868, 1),
(36, 931, 'Portable Radio', 18868, 1),
(36, 932, 'MP3 Player', 18875, 1),
(36, 933, 'Laptop', 19893, 1),
(64, 941, 'Bait', 19630, 98),
(62, 947, 'Cigarettes', 19896, 12),
(15, 948, 'Frozen Pizza', 2814, 3),
(15, 949, 'Water', 1484, 5),
(57, 950, 'GPS System', 18875, 1),
(57, 951, 'Cellphone', 330, 1),
(99, 952, 'Cellphone', 330, 1),
(99, 953, 'GPS System', 18875, 1),
(99, 954, 'Portable Radio', 18868, 1),
(99, 956, 'MP3 Player', 18875, 1),
(264, 958, 'Marijuana', 1578, 15),
(48, 959, 'GPS System', 18875, 1),
(131, 962, 'GPS System', 18875, 1),
(48, 963, 'Cellphone', 330, 1),
(180, 964, 'Lazattavitus Extra', 2709, 5),
(64, 976, 'Cigarettes', 19896, 17),
(64, 978, 'Fuel Can', 1650, 1),
(19, 987, 'LSD', 1, 2),
(16, 990, 'Heroin', 1577, 1),
(264, 994, 'Mask', 19036, 1),
(264, 995, 'First Aid', 1580, 2),
(264, 997, 'GPS System', 18875, 1),
(264, 998, 'Cellphone', 330, 1),
(264, 999, 'Portable Radio', 18868, 1),
(5, 1001, 'Mask', 19036, 1),
(17, 1002, 'Mask', 19036, 1),
(5, 1005, 'Cigarettes', 19896, 17),
(54, 1009, 'Frozen Pizza', 2814, 1),
(172, 1011, 'First Aid', 1580, 1),
(77, 1013, 'First Aid', 1580, 1),
(172, 1017, 'Marijuana', 1578, 346),
(172, 1018, 'Materials', 11746, 2694),
(172, 1022, 'Fuel Can', 1650, 3),
(172, 1023, 'Mask', 19036, 1),
(172, 1024, 'Snack', 2768, 3),
(267, 1030, 'GPS System', 18875, 1),
(267, 1031, 'Cellphone', 330, 1),
(54, 1038, 'Cigarettes', 19896, 15),
(267, 1039, 'Component', 18633, 575),
(119, 1040, 'Mask', 19036, 1),
(268, 1043, 'First Aid', 1580, 1),
(268, 1044, 'Mask', 19036, 1),
(268, 1045, 'Cellphone', 330, 1),
(268, 1046, 'GPS System', 18875, 1),
(268, 1047, 'Portable Radio', 18868, 1),
(268, 1048, 'Laptop', 19893, 1),
(268, 1049, 'MP3 Player', 18875, 1),
(267, 1050, 'Spray Can', 365, 2),
(271, 1051, 'GPS System', 18875, 1),
(271, 1052, 'Cellphone', 330, 1),
(270, 1053, 'Cellphone', 330, 1),
(270, 1054, 'GPS System', 18875, 1),
(172, 1055, 'LSD', 1, 3),
(175, 1056, 'Component', 18633, 505),
(24, 1057, 'Neladryl Acetate', 2709, 10),
(24, 1058, 'Kratotamax Plus 1.0', 2709, 4),
(24, 1059, 'Lazattavitus Extra', 2709, 10),
(172, 1071, 'Cigarettes', 19896, 20),
(101, 1079, 'GPS System', 18875, 1),
(224, 1083, 'Cigarettes', 19896, 20),
(224, 1084, 'Mask', 19036, 1),
(278, 1088, 'First Aid', 1580, 1),
(278, 1089, 'Cigarettes', 19896, 20),
(279, 1092, 'Cellphone', 330, 1),
(279, 1093, 'GPS System', 18875, 1),
(279, 1094, 'Portable Radio', 18868, 1),
(49, 1095, 'Bait', 19630, 80),
(49, 1096, 'Fish Rod', 18632, 1),
(40, 1099, 'Cigarettes', 19896, 14),
(40, 1101, 'Portable Radio', 18868, 1),
(88, 1102, 'Campfire', 19632, 1),
(133, 1104, 'Frozen Pizza', 2814, 1),
(38, 1106, 'Mask', 19036, 1),
(207, 1110, 'Mask', 19036, 1),
(207, 1111, 'First Aid', 1580, 2),
(71, 1115, 'Cigarettes', 19896, 17),
(88, 1118, 'Mask', 19036, 1),
(49, 1119, 'MP3 Player', 18875, 1),
(49, 1121, 'Portable Radio', 18868, 1),
(247, 1122, 'GPS System', 18875, 1),
(174, 1125, 'First Aid', 1580, 2),
(143, 1129, 'Mask', 19036, 1),
(143, 1130, 'Cigarettes', 19896, 20),
(284, 1132, 'Cellphone', 330, 1),
(284, 1133, 'GPS System', 18875, 1),
(284, 1134, 'Portable Radio', 18868, 1),
(287, 1135, 'Marijuana', 1578, 1),
(38, 1139, 'Materials', 11746, 800),
(16, 1140, 'Marijuana', 1578, 64),
(290, 1144, 'GPS System', 18875, 1),
(192, 1146, 'Ecstasy', 1, 2),
(288, 1147, 'GPS System', 18875, 1),
(288, 1148, 'Cellphone', 330, 1),
(288, 1149, 'MP3 Player', 18875, 1),
(288, 1150, 'Laptop', 19893, 1),
(288, 1151, 'Portable Radio', 18868, 1),
(289, 1153, 'Cellphone', 330, 1),
(289, 1154, 'GPS System', 18875, 1),
(289, 1155, 'Portable Radio', 18868, 1),
(289, 1156, 'Laptop', 19893, 1),
(289, 1157, 'MP3 Player', 18875, 1),
(88, 1173, 'Laptop', 19893, 1),
(299, 1176, 'Cellphone', 330, 1),
(299, 1177, 'GPS System', 18875, 1),
(299, 1178, 'Portable Radio', 18868, 1),
(299, 1179, 'Laptop', 19893, 1),
(291, 1183, 'Cigarettes', 19896, 19),
(291, 1190, 'GPS System', 18875, 1),
(291, 1191, 'Cellphone', 330, 1),
(291, 1192, 'Portable Radio', 18868, 1),
(299, 1194, 'Mask', 19036, 1),
(255, 1196, 'Marijuana', 1578, 50),
(295, 1197, 'Marijuana', 1578, 50),
(46, 1198, 'Marijuana', 1578, 10),
(46, 1202, 'First Aid', 1580, 3),
(306, 1204, 'Mask', 19036, 1),
(306, 1205, 'GPS System', 18875, 1),
(19, 1221, 'First Aid', 1580, 1),
(84, 1222, 'First Aid', 1580, 1),
(177, 1229, 'First Aid', 1580, 1),
(19, 1231, 'Laptop', 19893, 1),
(84, 1232, 'Component', 18633, 130),
(297, 1234, 'Cellphone', 330, 1),
(297, 1235, 'GPS System', 18875, 1),
(297, 1236, 'Laptop', 19893, 1),
(217, 1238, 'Fish Rod', 18632, 1),
(217, 1239, 'Bait', 19630, 60),
(62, 1240, 'Fish Rod', 18632, 1),
(177, 1241, 'Portable Radio', 18868, 1),
(304, 1242, 'Spray Can', 365, 1),
(304, 1243, 'Mask', 19036, 1),
(304, 1246, 'First Aid', 1580, 1),
(221, 1247, 'Kratotamax Plus 1.0', 2709, 1),
(304, 1248, 'GPS System', 18875, 1),
(304, 1249, 'MP3 Player', 18875, 1),
(304, 1250, 'Cellphone', 330, 1),
(304, 1251, 'Portable Radio', 18868, 1),
(106, 1253, 'Marijuana', 1578, 21),
(311, 1262, 'GPS System', 18875, 1),
(311, 1263, 'Cellphone', 330, 1),
(311, 1264, 'Portable Radio', 18868, 1),
(19, 1265, 'Spray Can', 365, 2),
(13, 1271, 'Frozen Pizza', 2814, 4),
(13, 1278, 'Water', 1484, 2),
(15, 1281, 'Cooked Pizza', 2702, 2),
(314, 1303, 'GPS System', 18875, 1),
(312, 1310, 'Mask', 19036, 1),
(311, 1312, 'First Aid', 1580, 2),
(193, 1313, 'First Aid', 1580, 2),
(316, 1317, 'Cellphone', 330, 1),
(316, 1318, 'GPS System', 18875, 1),
(148, 1343, 'Cellphone', 330, 1),
(148, 1344, 'GPS System', 18875, 1),
(148, 1345, 'Laptop', 19893, 1),
(148, 1346, 'Water', 1484, 1),
(148, 1347, 'First Aid', 1580, 1),
(148, 1348, 'Frozen Pizza', 2814, 1),
(148, 1349, 'Spray Can', 365, 2),
(148, 1350, 'Cigarettes', 19896, 18),
(319, 1355, 'Cellphone', 330, 1),
(319, 1358, 'Laptop', 19893, 1),
(319, 1359, 'Mask', 19036, 1),
(319, 1360, 'GPS System', 18875, 1),
(31, 1370, 'Spray Can', 365, 1),
(195, 1373, 'Materials', 11746, 40587),
(320, 1381, 'GPS System', 18875, 1),
(320, 1382, 'Cellphone', 330, 1),
(320, 1383, 'Mask', 19036, 1),
(19, 1389, 'Water', 1484, 5),
(5, 1391, 'Materials', 11746, 100),
(5, 1392, 'Bobby Pin', 11746, 20),
(17, 1393, 'Bobby Pin', 11746, 10),
(177, 1395, 'Mask', 19036, 1),
(28, 1397, 'First Aid', 1580, 2),
(28, 1398, 'Cigarettes', 19896, 19),
(58, 1407, 'Materials', 11746, 200),
(332, 1408, 'GPS System', 18875, 1),
(332, 1409, 'Portable Radio', 18868, 1),
(332, 1410, 'Laptop', 19893, 1),
(193, 1412, 'Water', 1484, 1),
(29, 1416, 'Water', 1484, 5),
(217, 1419, 'Mask', 19036, 1),
(123, 1443, 'Heroin', 1577, 5),
(62, 1444, 'Heroin', 1577, 40),
(49, 1446, 'Campfire', 19632, 1),
(49, 1447, 'Cigarettes', 19896, 15),
(335, 1458, 'GPS System', 18875, 1),
(335, 1459, 'Cellphone', 330, 1),
(335, 1460, 'Mask', 19036, 1),
(159, 1463, 'GPS System', 18875, 1),
(159, 1464, 'Cellphone', 330, 1),
(159, 1465, 'Portable Radio', 18868, 1),
(17, 1471, 'Portable Radio', 18868, 1),
(133, 1472, 'Kratotamax Plus 1.0', 2709, 1),
(6, 1473, 'Kratotamax Plus 1.0', 2709, 6),
(25, 1477, 'Portable Radio', 18868, 1),
(188, 1480, 'Portable Radio', 18868, 1),
(188, 1481, 'MP3 Player', 18875, 1),
(188, 1482, 'Cellphone', 330, 1),
(267, 1485, 'MP3 Player', 18875, 1),
(267, 1486, 'Portable Radio', 18868, 1),
(267, 1487, 'Laptop', 19893, 1),
(23, 1488, 'Materials', 11746, 1160),
(172, 1495, 'Portable Radio', 18868, 1),
(172, 1499, 'Water', 1484, 5),
(267, 1501, 'First Aid', 1580, 3),
(267, 1503, 'Cigarettes', 19896, 19),
(267, 1504, 'Mask', 19036, 1),
(267, 1505, 'Campfire', 19632, 1),
(9, 1517, 'Materials', 11746, 521),
(116, 1521, 'Spray Can', 365, 3),
(10, 1522, 'Spray Can', 365, 1),
(10, 1524, 'Cigarettes', 19896, 20),
(10, 1525, 'GPS System', 18875, 1),
(10, 1526, 'First Aid', 1580, 3),
(10, 1527, 'Campfire', 19632, 1),
(299, 1529, 'First Aid', 1580, 3),
(299, 1530, 'Water', 1484, 5),
(36, 1531, 'Frozen Pizza', 2814, 1),
(333, 1534, 'GPS System', 18875, 1),
(333, 1535, 'Cellphone', 330, 1),
(172, 1536, 'Lazattavitus Extra', 2709, 1),
(340, 1539, 'Marijuana', 1578, 965),
(340, 1540, 'Materials', 11746, 18500),
(340, 1541, 'GPS System', 18875, 1),
(340, 1542, 'Cellphone', 330, 1),
(340, 1543, 'Mask', 19036, 1),
(172, 1544, 'Spray Can', 365, 2),
(177, 1546, 'Cigarettes', 19896, 16),
(36, 1548, 'Marijuana', 1578, 20),
(36, 1549, 'Heroin', 1577, 5),
(265, 1550, 'Marijuana', 1578, 20),
(299, 1551, 'Marijuana', 1578, 5),
(9, 1553, 'Bobby Pin', 11746, 20),
(49, 1556, 'Laptop', 19893, 1),
(192, 1561, 'Materials', 11746, 1203),
(343, 1562, 'Mask', 19036, 1),
(343, 1563, 'First Aid', 1580, 3),
(343, 1564, 'Cellphone', 330, 1),
(226, 1567, 'Portable Radio', 18868, 1),
(343, 1568, 'Portable Radio', 18868, 1),
(192, 1570, 'First Aid', 1580, 3),
(331, 1573, 'Cellphone', 330, 1),
(331, 1574, 'GPS System', 18875, 1),
(331, 1575, 'MP3 Player', 18875, 1),
(328, 1576, 'Mask', 19036, 1),
(328, 1577, 'Cigarettes', 19896, 19),
(328, 1579, 'First Aid', 1580, 1),
(328, 1580, 'Cellphone', 330, 1),
(328, 1581, 'GPS System', 18875, 1),
(328, 1582, 'Portable Radio', 18868, 1),
(328, 1584, 'MP3 Player', 18875, 1),
(352, 1585, 'GPS System', 18875, 1),
(9, 1591, 'Frozen Pizza', 2814, 1),
(357, 1593, 'Cellphone', 330, 1),
(357, 1594, 'GPS System', 18875, 1),
(357, 1595, 'Portable Radio', 18868, 1),
(360, 1609, 'GPS System', 18875, 1),
(360, 1610, 'Portable Radio', 18868, 1),
(265, 1611, 'Mask', 19036, 1),
(265, 1612, 'Cellphone', 330, 1),
(265, 1613, 'GPS System', 18875, 1),
(265, 1614, 'Portable Radio', 18868, 1),
(65, 1616, 'Water', 1484, 5),
(361, 1617, 'Cellphone', 330, 1),
(361, 1618, 'GPS System', 18875, 1),
(361, 1619, 'Portable Radio', 18868, 1),
(361, 1620, 'Mask', 19036, 1),
(131, 1621, 'Neladryl Acetate', 2709, 10),
(77, 1625, 'Spray Can', 365, 1),
(175, 1626, 'Spray Can', 365, 2),
(165, 1633, 'First Aid', 1580, 2),
(365, 1639, 'Mask', 19036, 1),
(88, 1640, 'Marijuana', 1578, 5),
(365, 1641, 'GPS System', 18875, 1),
(135, 1645, 'Portable Radio', 18868, 1),
(62, 1646, 'Cooked Pizza', 2702, 3),
(108, 1650, 'Fuel Can', 1650, 1),
(108, 1652, 'Component', 18633, 868),
(173, 1660, 'Component', 18633, 344),
(54, 1662, 'First Aid', 1580, 1),
(5, 1663, 'First Aid', 1580, 1),
(220, 1669, 'Cellphone', 330, 1),
(220, 1670, 'GPS System', 18875, 1),
(220, 1671, 'Portable Radio', 18868, 1),
(220, 1672, 'Laptop', 19893, 1),
(105, 1683, 'Spray Can', 365, 2),
(371, 1685, 'GPS System', 18875, 1),
(371, 1686, 'Cellphone', 330, 1),
(49, 1697, 'Mask', 19036, 1),
(101, 1698, 'Materials', 11746, 200),
(142, 1701, 'First Aid', 1580, 2),
(126, 1702, 'Frozen Burger', 2768, 1),
(126, 1704, 'Fuel Can', 1650, 1),
(126, 1706, 'Portable Radio', 18868, 1),
(16, 1711, 'Cigarettes', 19896, 19),
(25, 1720, 'Bobby Pin', 11746, 20),
(188, 1724, 'Marijuana', 1578, 100),
(371, 1726, 'Mask', 19036, 1),
(371, 1727, 'Water', 1484, 3),
(376, 1729, 'Mask', 19036, 1),
(376, 1730, 'Campfire', 19632, 1),
(376, 1731, 'First Aid', 1580, 1),
(377, 1732, 'Cellphone', 330, 1),
(377, 1733, 'GPS System', 18875, 1),
(376, 1734, 'Cellphone', 330, 1),
(376, 1735, 'GPS System', 18875, 1),
(376, 1736, 'Portable Radio', 18868, 1),
(376, 1737, 'Laptop', 19893, 1),
(376, 1738, 'MP3 Player', 18875, 1),
(377, 1739, 'Laptop', 19893, 1),
(62, 1740, 'Marijuana', 1578, 50),
(54, 1743, 'Bait', 19630, 80),
(54, 1744, 'Fish Rod', 18632, 1),
(15, 1745, 'Materials', 11746, 8959),
(15, 1746, 'Cocaine', 1575, 107),
(30, 1750, 'Water', 1484, 2),
(30, 1751, 'Frozen Pizza', 2814, 1),
(30, 1752, 'Cigarettes', 19896, 20),
(30, 1753, 'Spray Can', 365, 1),
(155, 1760, 'Lazattavitus Extra', 2709, 5),
(155, 1762, 'Bait', 19630, 20),
(217, 1763, 'Cigarettes', 19896, 16),
(217, 1764, 'Laptop', 19893, 1),
(217, 1765, 'Portable Radio', 18868, 1),
(217, 1766, 'MP3 Player', 18875, 1),
(381, 1768, 'Cellphone', 330, 1),
(381, 1769, 'GPS System', 18875, 1),
(17, 1780, 'Component', 18633, 600),
(379, 1781, 'Cellphone', 330, 1),
(379, 1782, 'GPS System', 18875, 1),
(172, 1788, 'Frozen Pizza', 2814, 1),
(159, 1792, 'Materials', 11746, 1800),
(385, 1793, 'Mask', 19036, 1),
(139, 1794, 'Materials', 11746, 189),
(385, 1795, 'GPS System', 18875, 1),
(385, 1796, 'Cellphone', 330, 1),
(139, 1798, 'Marijuana', 1578, 90),
(389, 1799, 'Water', 1484, 1),
(389, 1800, 'Cellphone', 330, 1),
(389, 1801, 'GPS System', 18875, 1),
(389, 1802, 'Portable Radio', 18868, 1),
(389, 1803, 'Laptop', 19893, 1),
(25, 1806, 'Cigarettes', 19896, 19),
(327, 1807, 'Cellphone', 330, 1),
(327, 1808, 'GPS System', 18875, 1),
(327, 1809, 'Portable Radio', 18868, 1),
(327, 1810, 'MP3 Player', 18875, 1),
(34, 1812, 'First Aid', 1580, 1),
(391, 1813, 'GPS System', 18875, 1),
(391, 1814, 'Cellphone', 330, 1),
(9, 1822, 'Cooked Pizza', 2702, 2),
(135, 1823, 'GPS System', 18875, 1),
(135, 1824, 'Cellphone', 330, 1),
(133, 1825, 'First Aid', 1580, 2),
(40, 1827, 'Campfire', 19632, 1),
(40, 1828, 'Frozen Pizza', 2814, 2),
(67, 1829, 'Fish Rod', 18632, 1),
(71, 1830, 'Fish Rod', 18632, 1),
(67, 1831, 'Bait', 19630, 15),
(71, 1832, 'Bait', 19630, 34),
(301, 1834, 'First Aid', 1580, 3),
(301, 1835, 'Mask', 19036, 1),
(301, 1836, 'Campfire', 19632, 1),
(49, 1837, 'Neladryl Acetate', 2709, 10),
(49, 1839, 'Lazattavitus Extra', 2709, 10),
(396, 1840, 'Cellphone', 330, 1),
(396, 1841, 'GPS System', 18875, 1),
(71, 1849, 'Frozen Pizza', 2814, 1),
(399, 1852, 'First Aid', 1580, 1),
(29, 1854, 'Component', 18633, 225),
(177, 1857, 'MP3 Player', 18875, 1),
(400, 1859, 'Mask', 19036, 1),
(17, 1861, 'First Aid', 1580, 1),
(105, 1862, 'Portable Radio', 18868, 1),
(402, 1863, 'First Aid', 1580, 1),
(105, 1864, 'Cigarettes', 19896, 20),
(71, 1868, 'Campfire', 19632, 1),
(105, 1873, 'Kratotamax Plus 1.0', 2709, 3),
(40, 1874, 'Component', 18633, 800),
(49, 1876, 'Kratotamax Plus 1.0', 2709, 3),
(393, 1879, 'GPS System', 18875, 1),
(108, 1883, 'Laptop', 19893, 1),
(12, 1884, 'Kratotamax Plus 1.0', 2709, 5),
(403, 1885, 'Cigarettes', 19896, 20),
(34, 1887, 'Portable Radio', 18868, 1),
(403, 1888, 'First Aid', 1580, 1),
(403, 1889, 'Cellphone', 330, 1),
(403, 1890, 'GPS System', 18875, 1),
(108, 1891, 'Water', 1484, 1),
(403, 1892, 'Laptop', 19893, 1),
(196, 1898, 'Fuel Can', 1650, 1),
(88, 1904, 'Component', 18633, 1124),
(155, 1906, 'Spray Can', 365, 2),
(49, 1907, 'Water', 1484, 5),
(49, 1908, 'Frozen Burger', 2768, 5),
(49, 1909, 'Snack', 2768, 5),
(12, 1910, 'First Aid', 1580, 2),
(49, 1911, 'Fuel Can', 1650, 2),
(194, 1913, 'Mask', 19036, 1),
(405, 1914, 'GPS System', 18875, 1),
(405, 1915, 'Cellphone', 330, 1),
(405, 1916, 'Portable Radio', 18868, 1),
(405, 1917, 'MP3 Player', 18875, 1),
(406, 1918, 'Mask', 19036, 1),
(328, 1920, 'Laptop', 19893, 1),
(69, 1921, 'First Aid', 1580, 2),
(139, 1922, 'Campfire', 19632, 1),
(177, 1923, 'Materials', 11746, 1546),
(416, 1924, 'GPS System', 18875, 1),
(196, 1925, 'GPS System', 18875, 1),
(415, 1926, 'Cigarettes', 19896, 20),
(416, 1927, 'Cellphone', 330, 1),
(196, 1928, 'Cellphone', 330, 1),
(416, 1929, 'MP3 Player', 18875, 1),
(105, 1930, 'First Aid', 1580, 2),
(331, 1934, 'Cigarettes', 19896, 19),
(46, 1936, 'Component', 18633, 2000),
(416, 1938, 'Mask', 19036, 1),
(416, 1939, 'Component', 18633, 1300),
(13, 1940, 'Materials', 11746, 19158),
(425, 1941, 'GPS System', 18875, 1),
(425, 1942, 'Cellphone', 330, 1),
(31, 1944, 'Water', 1484, 1),
(430, 1946, 'GPS System', 18875, 1),
(429, 1947, 'Spray Can', 365, 1),
(429, 1948, 'GPS System', 18875, 1),
(429, 1949, 'Cellphone', 330, 1),
(16, 1950, 'Materials', 11746, 1500),
(177, 1956, 'Water', 1484, 3),
(363, 1957, 'GPS System', 18875, 1),
(15, 1961, 'Marijuana', 1578, 750),
(13, 1962, 'Marijuana', 1578, 290);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `jobID` int(12) NOT NULL,
  `jobPosX` float DEFAULT 0,
  `jobPosY` float DEFAULT 0,
  `jobPosZ` float DEFAULT 0,
  `jobPointX` float DEFAULT 0,
  `jobPointY` float DEFAULT 0,
  `jobPointZ` float DEFAULT 0,
  `jobDeliverX` float DEFAULT 0,
  `jobDeliverY` float DEFAULT 0,
  `jobDeliverZ` float DEFAULT 0,
  `jobInterior` int(12) DEFAULT 0,
  `jobWorld` int(12) DEFAULT 0,
  `jobType` int(12) DEFAULT 0,
  `jobPointInt` int(12) DEFAULT 0,
  `jobPointWorld` int(12) DEFAULT 0,
  `jobStock` int(10) UNSIGNED NOT NULL DEFAULT 1000,
  `jobPrison` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`jobID`, `jobPosX`, `jobPosY`, `jobPosZ`, `jobPointX`, `jobPointY`, `jobPointZ`, `jobDeliverX`, `jobDeliverY`, `jobDeliverZ`, `jobInterior`, `jobWorld`, `jobType`, `jobPointInt`, `jobPointWorld`, `jobStock`, `jobPrison`) VALUES
(2, 1823.85, -1063.27, 26.0167, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0),
(4, 2281.06, -2365.01, 13.5468, 2533.24, -1531.42, 25.8764, 2533.24, -1531.42, 25.8764, 0, 0, 1, 0, 0, 10, 0),
(5, 2534.24, -1532.94, 25.8763, 2195.83, -1973.52, 13.5586, 2535, -1561.72, 25.8864, 0, 0, 2, 0, 0, 15000, 0),
(6, -76.9581, -1136.71, 1.0781, 0, 0, 0, -75.1884, -1107.76, 1.0781, 0, 0, 4, 0, 0, 0, 0),
(7, -382.019, -1438.87, 25.7265, 0, 0, 0, -379.596, -1425.98, 25.7265, 0, 0, 11, 0, 0, 0, 0),
(8, 149.746, -287.576, 1.5781, 0, 0, 0, 162.707, -294.227, 1.5781, 0, 0, 10, 0, 0, 0, 0),
(9, -491.457, -194.445, 78.3951, 0, 0, 0, -488.026, -178.48, 78.2109, 0, 0, 9, 0, 0, 0, 0),
(10, -101.513, 1374.51, 10.4698, 0, 0, 0, -688.107, 938.132, 13.6328, 0, 0, 8, 0, 0, 0, 0),
(11, 595.41, 873.764, -43.2904, 605.641, 870.508, -40.9917, 826.059, 857.367, 12.1909, 0, 0, 5, 0, 0, 999, 0);

-- --------------------------------------------------------

--
-- Table structure for table `lumber`
--

CREATE TABLE `lumber` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Time` int(10) UNSIGNED NOT NULL,
  `Pos` varchar(64) NOT NULL,
  `Rot` varchar(64) NOT NULL,
  `Tebang` int(10) UNSIGNED NOT NULL,
  `Take` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lumber`
--

INSERT INTO `lumber` (`ID`, `Time`, `Pos`, `Rot`, `Tebang`, `Take`) VALUES
(2, 3600, '1252.6648|-98.2462|37.5257', '0.0000|0.0000|0.0000', 0, 0),
(3, 3600, '1245.0380|-102.2033|37.9938', '0.0000|0.0000|0.0000', 0, 0),
(4, 3600, '1238.6320|-111.5812|38.8809', '0.0000|0.0000|0.0000', 0, 0),
(5, 3600, '1229.7465|-103.6435|39.1868', '0.0000|0.0000|0.0000', 0, 0),
(6, 3600, '1231.5408|-89.6884|38.1042', '0.0000|0.0000|0.0000', 0, 0),
(7, 3600, '957.6633|207.6583|35.0480', '0.0000|0.0000|0.0000', 0, 0),
(8, 3600, '979.1192|210.1182|35.2531', '0.0000|0.0000|0.0000', 0, 0),
(9, 3600, '1005.0067|201.8696|35.3119', '0.0000|0.0000|0.0000', 0, 0),
(10, 3600, '998.4104|182.5237|33.1099', '0.0000|0.0000|0.0000', 0, 0),
(11, 3600, '934.5399|219.6744|34.3493', '0.0000|0.0000|0.0000', 0, 0),
(12, 3600, '151.5311|45.7759|2.0836', '0.0000|0.0000|0.0000', 0, 0),
(13, 3600, '168.2162|29.8324|1.7943', '0.0000|0.0000|0.0000', 0, 0),
(14, 3600, '188.2755|29.6363|1.9634', '0.0000|0.0000|0.0000', 0, 0),
(15, 3600, '164.8539|7.4231|1.4877', '0.0000|0.0000|0.0000', 0, 0),
(16, 3600, '136.2973|28.5142|1.3314', '0.0000|0.0000|0.0000', 0, 0),
(17, 3600, '-531.5233|-415.7013|22.8807', '0.0000|0.0000|0.0000', 0, 0),
(18, 3600, '-533.8315|-423.2674|26.7334', '0.0000|0.0000|0.0000', 0, 0),
(19, 3600, '-544.3645|-419.5515|27.0814', '0.0000|0.0000|0.0000', 0, 0),
(20, 3600, '-548.8893|-406.6715|22.4738', '0.0000|0.0000|0.0000', 0, 0),
(21, 3600, '-559.4200|-414.0987|25.0685', '0.0000|0.0000|0.0000', 0, 0),
(22, 3600, '-786.2440|-1046.0924|87.2784', '0.0000|0.0000|0.0000', 0, 0),
(23, 3600, '-775.7101|-1061.1008|86.5072', '0.0000|0.0000|0.0000', 0, 0),
(24, 3600, '-776.1854|-1083.9974|86.3625', '0.0000|0.0000|0.0000', 0, 0),
(25, 3600, '-790.3521|-1077.0265|87.2384', '0.0000|0.0000|0.0000', 0, 0),
(26, 3600, '-803.4399|-1064.6920|88.2433', '0.0000|0.0000|0.0000', 0, 0),
(27, 3600, '-826.0175|-1154.2820|63.6992', '0.0000|0.0000|0.0000', 0, 0),
(28, 3600, '-809.5564|-1131.0566|57.3614', '0.0000|0.0000|0.0000', 0, 0),
(29, 3600, '-820.9057|-1111.9106|58.1847', '0.0000|0.0000|0.0000', 0, 0),
(30, 3600, '-781.3058|-1134.0524|62.6721', '0.0000|0.0000|0.0000', 0, 0),
(31, 3600, '-779.7946|-1147.2725|63.2612', '0.0000|0.0000|0.0000', 0, 0),
(32, 3600, '-1221.4653|-1438.3994|112.5810', '0.0000|0.0000|0.0000', 0, 0),
(33, 3600, '-1222.4194|-1422.3135|113.4333', '0.0000|0.0000|0.0000', 0, 0),
(34, 3600, '-1207.0421|-1405.8192|117.4627', '0.0000|0.0000|0.0000', 0, 0),
(35, 3600, '-1232.1875|-1390.4852|116.6879', '0.0000|0.0000|0.0000', 0, 0),
(36, 3600, '-1266.4573|-1388.4091|115.7651', '0.0000|0.0000|0.0000', 0, 0),
(37, 3600, '-1393.3458|-1391.8687|138.8448', '0.0000|0.0000|0.0000', 0, 0),
(38, 3600, '-1382.5834|-1380.0956|139.8166', '0.0000|0.0000|0.0000', 0, 0),
(39, 3600, '-1392.3834|-1358.8295|133.4249', '0.0000|0.0000|0.0000', 0, 0),
(40, 3600, '-1368.1532|-1337.0092|140.6356', '0.0000|0.0000|0.0000', 0, 0),
(41, 3600, '-1337.1173|-1334.6082|147.4865', '0.0000|0.0000|0.0000', 0, 0),
(42, 3600, '-1542.3278|-1153.5303|135.8874', '0.0000|0.0000|0.0000', 0, 0),
(43, 3600, '-1556.9806|-1141.0101|137.2920', '0.0000|0.0000|0.0000', 0, 0),
(44, 3600, '-1557.5902|-1115.3942|136.8744', '0.0000|0.0000|0.0000', 0, 0),
(45, 3600, '-1579.5613|-1121.2897|139.3230', '0.0000|0.0000|0.0000', 0, 0),
(46, 3600, '-1572.2031|-1139.1949|139.1466', '0.0000|0.0000|0.0000', 0, 0),
(47, 3600, '-1282.9796|-768.6750|68.8153', '0.0000|0.0000|0.0000', 0, 0),
(48, 3600, '-1269.1417|-747.8250|67.3352', '0.0000|0.0000|0.0000', 0, 0),
(49, 3600, '-1249.7020|-756.5939|64.9451', '0.0000|0.0000|0.0000', 0, 0),
(50, 3600, '-1250.0537|-769.4000|65.4704', '0.0000|0.0000|0.0000', 0, 0),
(51, 3600, '-1264.9198|-774.9366|67.2884', '0.0000|0.0000|0.0000', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `maps`
--

CREATE TABLE `maps` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `stream` float(15,7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `marketplace`
--

CREATE TABLE `marketplace` (
  `id` int(11) NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `price` tinyint(3) UNSIGNED NOT NULL DEFAULT 100,
  `product` tinyint(3) UNSIGNED NOT NULL DEFAULT 10,
  `posX` float NOT NULL DEFAULT 0,
  `posY` float NOT NULL DEFAULT 0,
  `posZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `marketplace`
--

INSERT INTO `marketplace` (`id`, `type`, `price`, `product`, `posX`, `posY`, `posZ`) VALUES
(3, 1, 50, 15, 2354.62, -2288.55, 17.422),
(4, 3, 50, 15, 2255.96, -2387.87, 17.422),
(5, 6, 50, 15, 2719.22, -2516.8, 17.367),
(6, 4, 50, 15, 2445.28, -2548.12, 17.911),
(7, 7, 50, 15, 2721.2, -2381.14, 17.34),
(8, 8, 50, 15, 2530.2, -2434.89, 17.883),
(9, 2, 50, 15, 2735.59, -2465.85, 13.648),
(10, 9, 50, 15, 2700.12, -2386.15, 13.633),
(11, 5, 50, 15, 2407.17, -2477.14, 13.631);

-- --------------------------------------------------------

--
-- Table structure for table `namechanges`
--

CREATE TABLE `namechanges` (
  `ID` int(12) NOT NULL,
  `OldName` varchar(24) DEFAULT NULL,
  `NewName` varchar(24) DEFAULT NULL,
  `Date` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `objecttext`
--

CREATE TABLE `objecttext` (
  `ID` int(11) NOT NULL,
  `Text` varchar(128) NOT NULL DEFAULT 'Text',
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `posRX` float NOT NULL DEFAULT 0,
  `posRY` float NOT NULL DEFAULT 0,
  `posRZ` float NOT NULL DEFAULT 0,
  `Vw` int(11) NOT NULL DEFAULT 0,
  `Int` int(11) NOT NULL DEFAULT 0,
  `FontColor` int(11) NOT NULL DEFAULT -1,
  `BackColor` int(11) NOT NULL DEFAULT -1,
  `FontSize` int(11) NOT NULL DEFAULT 100,
  `FontNames` varchar(24) NOT NULL DEFAULT 'Arial',
  `Model` int(11) NOT NULL DEFAULT 18244
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

CREATE TABLE `plants` (
  `plantID` int(12) NOT NULL,
  `plantType` int(12) DEFAULT 0,
  `plantDrugs` int(12) DEFAULT 0,
  `plantX` float DEFAULT 0,
  `plantY` float DEFAULT 0,
  `plantZ` float DEFAULT 0,
  `plantA` float DEFAULT 0,
  `plantInterior` int(12) DEFAULT 0,
  `plantWorld` int(12) DEFAULT 0,
  `plantTime` tinyint(2) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playerammo`
--

CREATE TABLE `playerammo` (
  `ID` int(10) UNSIGNED NOT NULL,
  `owned` int(10) UNSIGNED NOT NULL,
  `ammo` int(10) UNSIGNED NOT NULL,
  `used` int(10) UNSIGNED NOT NULL,
  `weapon` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playerweapon`
--

CREATE TABLE `playerweapon` (
  `ID` int(10) UNSIGNED NOT NULL,
  `owned` int(10) UNSIGNED DEFAULT NULL,
  `durability` int(10) UNSIGNED DEFAULT 1000,
  `used` int(10) UNSIGNED DEFAULT NULL,
  `model` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player_animation`
--

CREATE TABLE `player_animation` (
  `id` int(11) NOT NULL,
  `slot` int(11) NOT NULL DEFAULT 0,
  `playerid` int(11) NOT NULL DEFAULT 0,
  `animlib` varchar(32) NOT NULL DEFAULT 'RUNNINGMAN',
  `animname` varchar(32) NOT NULL DEFAULT 'DANCE_LOOP'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `player_animation`
--

INSERT INTO `player_animation` (`id`, `slot`, `playerid`, `animlib`, `animname`) VALUES
(1, 7, 131, 'INT_HOUSE', 'WASH_UP'),
(2, 6, 131, 'INT_SHOP', 'SHOP_CASHIER'),
(3, 0, 131, 'MEDIC', 'CPR'),
(4, 1, 131, 'INT_OFFICE', 'OFF_SIT_TYPE_LOOP'),
(5, 1, 30, 'BAR', 'BARSERVE_GLASS'),
(6, 2, 30, 'KISSING', 'GIFT_GIVE'),
(7, 3, 30, 'BAR', 'BARSERVE_GLASS'),
(8, 4, 30, 'BD_FIRE', 'BD_GF_WAVE'),
(9, 5, 30, 'BENCHPRESS', 'GYM_BP_GETON'),
(10, 6, 30, 'BOMBER', 'BOM_PLANT_LOOP'),
(11, 1, 223, 'ATTRACTORS', 'STEPSIT_LOOP'),
(12, 3, 223, 'BAR', 'BARCUSTOM_GET'),
(13, 0, 19, 'ROB_BANK', 'SHP_HANDSUP_SCR'),
(14, 1, 19, 'BEACH', 'SITNWAIT_LOOP_W'),
(15, 3, 19, 'ROB_BANK', 'SHP_HANDSUP_SCR'),
(16, 1, 65, 'DANCING', 'DNCE_M_D'),
(17, 2, 65, 'CHAINSAW', 'CSAW_G'),
(18, 1, 379, 'ATTRACTORS', 'STEPSIT_LOOP');

-- --------------------------------------------------------

--
-- Table structure for table `player_vehicles`
--

CREATE TABLE `player_vehicles` (
  `ID` int(11) NOT NULL,
  `Owner` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `Pos1` float DEFAULT NULL,
  `Pos2` float DEFAULT NULL,
  `Pos3` float DEFAULT NULL,
  `Pos4` float DEFAULT NULL,
  `Color1` int(11) DEFAULT NULL,
  `Color2` int(11) DEFAULT NULL,
  `Paintjob` int(11) DEFAULT NULL,
  `Locked` int(11) DEFAULT NULL,
  `Impound` int(11) DEFAULT NULL,
  `ImpoundPrice` int(11) DEFAULT NULL,
  `Health` float DEFAULT NULL,
  `Weapon1` int(11) DEFAULT NULL,
  `Ammo1` int(11) UNSIGNED DEFAULT NULL,
  `Durability1` int(11) DEFAULT NULL,
  `Weapon2` int(11) DEFAULT NULL,
  `Ammo2` int(11) UNSIGNED DEFAULT NULL,
  `Durability2` int(11) DEFAULT NULL,
  `Weapon3` int(11) DEFAULT NULL,
  `Ammo3` int(11) DEFAULT NULL,
  `Durability3` int(11) DEFAULT NULL,
  `Weapon4` int(11) DEFAULT NULL,
  `Ammo4` int(11) DEFAULT NULL,
  `Durability4` int(11) DEFAULT NULL,
  `Weapon5` int(11) DEFAULT NULL,
  `Ammo5` int(11) DEFAULT NULL,
  `Durability5` int(11) DEFAULT NULL,
  `Mods1` int(11) DEFAULT NULL,
  `Mods2` int(11) DEFAULT NULL,
  `Mods3` int(11) DEFAULT NULL,
  `Mods4` int(11) DEFAULT NULL,
  `Mods5` int(11) DEFAULT NULL,
  `Mods6` int(11) DEFAULT NULL,
  `Mods7` int(11) DEFAULT NULL,
  `Mods8` int(11) DEFAULT NULL,
  `Mods9` int(11) DEFAULT NULL,
  `Mods10` int(11) DEFAULT NULL,
  `Mods11` int(11) DEFAULT NULL,
  `Mods12` int(11) DEFAULT NULL,
  `Mods13` int(11) DEFAULT NULL,
  `Mods14` int(11) DEFAULT NULL,
  `Damage1` int(11) DEFAULT NULL,
  `Damage2` int(11) DEFAULT NULL,
  `Damage3` int(11) DEFAULT NULL,
  `Damage4` int(11) DEFAULT NULL,
  `Plate` varchar(24) DEFAULT NULL,
  `Lumber` int(11) DEFAULT NULL,
  `Rental` int(10) UNSIGNED DEFAULT NULL,
  `RentalOwned` int(10) UNSIGNED DEFAULT NULL,
  `RentalTime` int(10) UNSIGNED DEFAULT NULL,
  `RentalPrice` int(10) UNSIGNED DEFAULT NULL,
  `Faction` int(10) UNSIGNED DEFAULT NULL,
  `Fuel` int(10) UNSIGNED NOT NULL DEFAULT 100,
  `Component` int(10) UNSIGNED DEFAULT NULL,
  `Neon` int(10) UNSIGNED DEFAULT NULL,
  `NeonToggle` tinyint(2) UNSIGNED DEFAULT NULL,
  `Insurance` int(10) UNSIGNED NOT NULL DEFAULT 3,
  `Sirine` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `STNK` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ImpoundDelay` int(10) UNSIGNED DEFAULT NULL,
  `Garage` int(10) UNSIGNED DEFAULT NULL,
  `Int` int(10) UNSIGNED DEFAULT NULL,
  `Vw` int(10) UNSIGNED DEFAULT NULL,
  `MaxHealth` float NOT NULL DEFAULT 1000,
  `InsideInsurance` int(11) DEFAULT NULL,
  `InsuranceTime` int(11) DEFAULT NULL,
  `Job` smallint(2) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pumps`
--

CREATE TABLE `pumps` (
  `ID` int(12) DEFAULT 0,
  `pumpID` int(12) NOT NULL,
  `pumpPosX` float DEFAULT 0,
  `pumpPosY` float DEFAULT 0,
  `pumpPosZ` float DEFAULT 0,
  `pumpPosA` float DEFAULT 0,
  `pumpFuel` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pumps`
--

INSERT INTO `pumps` (`ID`, `pumpID`, `pumpPosX`, `pumpPosY`, `pumpPosZ`, `pumpPosA`, `pumpFuel`) VALUES
(4, 1, 1941.6, -1776.22, 14.1205, -89.6979, 628),
(4, 2, 1941.72, -1769.36, 14.1206, -88.5555, 665),
(28, 7, 1000.54, -937.512, 42.8279, 188.234, 823),
(28, 8, 1007.7, -936.047, 42.8117, 191.215, 900);

-- --------------------------------------------------------

--
-- Table structure for table `quizes`
--

CREATE TABLE `quizes` (
  `id` int(10) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `rules` text DEFAULT NULL,
  `must_shown` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `random`
--

CREATE TABLE `random` (
  `model` int(11) NOT NULL,
  `x` float(15,7) NOT NULL,
  `y` float(15,7) NOT NULL,
  `z` float(15,7) NOT NULL,
  `rx` float(15,7) NOT NULL,
  `ry` float(15,7) NOT NULL,
  `rz` float(15,7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

CREATE TABLE `rentals` (
  `ID` int(10) UNSIGNED NOT NULL,
  `PosX` float DEFAULT NULL,
  `PosY` float DEFAULT NULL,
  `PosZ` float DEFAULT NULL,
  `SpawnX` float DEFAULT NULL,
  `SpawnY` float DEFAULT NULL,
  `SpawnZ` float DEFAULT NULL,
  `SpawnRZ` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`ID`, `PosX`, `PosY`, `PosZ`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnRZ`) VALUES
(1, 1808.2, -1897.49, 13.578, 1804.09, -1899.13, 13.403, 83.756),
(2, 1676.28, -2325.27, 13.547, 1674.64, -2321.79, 13.383, 272.178),
(3, 810.124, -1339.4, 13.539, 809.633, -1335.03, 13.547, 270.39),
(4, 141.394, -1867.22, 2.009, 131.241, -1871.47, 1.407, 91.825);

-- --------------------------------------------------------

--
-- Table structure for table `rental_vehicles`
--

CREATE TABLE `rental_vehicles` (
  `rental_id` int(10) UNSIGNED NOT NULL,
  `model` smallint(3) UNSIGNED NOT NULL,
  `price` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rental_vehicles`
--

INSERT INTO `rental_vehicles` (`rental_id`, `model`, `price`) VALUES
(1, 462, 50),
(1, 509, 20),
(1, 586, 70),
(2, 462, 50),
(2, 509, 20),
(2, 586, 70),
(3, 462, 50),
(3, 509, 20),
(3, 586, 70),
(4, 453, 75),
(4, 473, 50);

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `ID` int(10) UNSIGNED NOT NULL,
  `LinkID` int(11) UNSIGNED NOT NULL,
  `Money` int(11) UNSIGNED NOT NULL,
  `Issue` varchar(128) NOT NULL DEFAULT 'none',
  `Reason` varchar(128) NOT NULL DEFAULT 'none',
  `Date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`ID`, `LinkID`, `Money`, `Issue`, `Reason`, `Date`) VALUES
(2, 33, 600, 'Bus Sidejob', 'none', 1662807614),
(5, 45, 0, 'Boxville Sidejob', 'none', 1662807967),
(8, 74, 694, 'Money Transporter Sidejob', 'none', 1662810837),
(9, 83, 809, 'Boxville Sidejob', 'none', 1662814290),
(11, 95, 683, 'Bus Sidejob', 'none', 1662816005),
(12, 96, 600, 'Bus Sidejob', 'none', 1662816898),
(22, 141, 600, 'Money Transporter Sidejob', 'none', 1662825295),
(26, 141, 617, 'Bus Sidejob', 'none', 1662827631),
(28, 139, 671, 'Bus Sidejob', 'none', 1662831625),
(32, 153, 0, 'Boxville Sidejob', 'none', 1662832629),
(33, 160, 600, 'Money Transporter Sidejob', 'none', 1662833851),
(34, 153, 692, 'Bus Sidejob', 'none', 1662834812),
(36, 166, 645, 'Bus Sidejob', 'none', 1662849431),
(41, 178, 611, 'Bus Sidejob', 'none', 1662859805),
(44, 184, 627, 'Bus Sidejob', 'none', 1662863029),
(45, 184, 629, 'Sweeper Sidejob', 'none', 1662863880),
(46, 138, 631, 'Money Transporter Sidejob', 'none', 1662864113),
(47, 181, 0, 'Boxville Sidejob', 'none', 1662864140),
(48, 11, 0, 'San Andreas Police Department', 'none', 1662864206),
(49, 184, 200, 'Boxville Sidejob', 'none', 1662864737),
(51, 190, 600, 'Money Transporter Sidejob', 'none', 1662865875),
(55, 114, 680, 'Bus Sidejob', 'none', 1662869797),
(60, 11, 0, 'San Andreas Police Department', 'none', 1662872652),
(65, 71, 60, 'Boxville Sidejob', 'none', 1662876093),
(72, 11, 0, 'San Andreas Police Department', 'none', 1662878841),
(73, 216, 600, 'Money Transporter Sidejob', 'none', 1662879964),
(78, 223, 627, 'Sweeper Sidejob', 'none', 1662881608),
(80, 160, 674, 'Bus Sidejob', 'none', 1662881944),
(89, 202, 600, 'Bus Sidejob', 'none', 1662886314),
(91, 240, 0, 'Boxville Sidejob', 'none', 1662887923),
(100, 187, 0, 'San Andreas Police Department', 'none', 1662890990),
(101, 223, 100, 'Boxville Sidejob', 'none', 1662891208),
(105, 245, 600, 'Money Transporter Sidejob', 'none', 1662891773),
(109, 248, 0, 'Boxville Sidejob', 'none', 1662894083),
(110, 249, 600, 'Money Transporter Sidejob', 'none', 1662894641),
(111, 185, 664, 'Money Transporter Sidejob', 'none', 1662894785),
(112, 240, 602, 'Bus Sidejob', 'none', 1662894865),
(121, 254, 645, 'Bus Sidejob', 'none', 1662900726),
(123, 130, 0, 'San Andreas Police Department', 'none', 1662901213),
(124, 180, 651, 'Money Transporter Sidejob', 'none', 1662902203),
(131, 48, 600, 'Sweeper Sidejob', 'none', 1662915622),
(133, 265, 600, 'Bus Sidejob', 'none', 1662916240),
(134, 180, 653, 'Money Transporter Sidejob', 'none', 1662916392),
(136, 48, 0, 'Boxville Sidejob', 'none', 1662918383),
(140, 271, 600, 'Sweeper Sidejob', 'none', 1662929255),
(141, 270, 651, 'Sweeper Sidejob', 'none', 1662929264),
(142, 23, 0, 'San Andreas Police Department', 'none', 1662929751),
(156, 279, 634, 'Bus Sidejob', 'none', 1662956738),
(166, 62, 611, 'Money Transporter Sidejob', 'none', 1662962431),
(173, 136, 200, 'Boxville Sidejob', 'none', 1662968451),
(174, 285, 600, 'Bus Sidejob', 'none', 1662968849),
(175, 285, 5, 'Boxville Sidejob', 'none', 1662968984),
(183, 25, 0, 'San Andreas Government Service', 'none', 1662971208),
(186, 161, 0, 'San Andreas Government Service', 'none', 1662972005),
(189, 187, 0, 'San Andreas Police Department', 'none', 1662972592),
(193, 295, 605, 'Sweeper Sidejob', 'none', 1662973725),
(194, 11, 0, 'San Andreas Police Department', 'none', 1662973904),
(196, 295, 200, 'Boxville Sidejob', 'none', 1662974333),
(201, 298, 600, 'Bus Sidejob', 'none', 1662976836),
(202, 187, 0, 'San Andreas Police Department', 'none', 1662977192),
(210, 309, 691, 'Money Transporter Sidejob', 'none', 1662987487),
(213, 310, 600, 'Money Transporter Sidejob', 'none', 1662988289),
(220, 48, 600, 'Sweeper Sidejob', 'none', 1662996306),
(228, 187, 0, 'San Andreas Police Department', 'none', 1662998079),
(235, 25, 0, 'San Andreas Government Service', 'none', 1663002480),
(236, 319, 0, 'Boxville Sidejob', 'none', 1663002575),
(238, 319, 0, 'Boxville Sidejob', 'none', 1663003755),
(241, 119, 0, 'San Andreas Police Department', 'none', 1663009201),
(243, 5, 600, 'Sweeper Sidejob', 'none', 1663011166),
(244, 314, 692, 'Sweeper Sidejob', 'none', 1663014364),
(247, 291, 223, 'Boxville Sidejob', 'none', 1663040649),
(263, 329, 0, 'Boxville Sidejob', 'none', 1663051364),
(269, 193, 600, 'Money Transporter Sidejob', 'none', 1663056925),
(270, 291, 625, 'Sweeper Sidejob', 'none', 1663057046),
(271, 309, 625, 'Sweeper Sidejob', 'none', 1663057057),
(272, 173, 1100, 'Trashmaster Sidejob', 'none', 1663057836),
(274, 173, 600, 'Sweeper Sidejob', 'none', 1663058566),
(281, 221, 671, 'Sweeper Sidejob', 'none', 1663062955),
(283, 85, 0, 'San Andreas Police Department', 'none', 1663064272),
(284, 187, 0, 'San Andreas Police Department', 'none', 1663065028),
(288, 354, 600, 'Money Transporter Sidejob', 'none', 1663068963),
(310, 306, 669, 'Sweeper Sidejob', 'none', 1663073338),
(313, 165, 600, 'Money Transporter Sidejob', 'none', 1663074136),
(314, 151, 0, 'San Andreas Government Service', 'none', 1663076546),
(315, 366, 600, 'Money Transporter Sidejob', 'none', 1663076802),
(316, 365, 600, 'Sweeper Sidejob', 'none', 1663077180),
(318, 365, 600, 'Money Transporter Sidejob', 'none', 1663077943),
(319, 108, 600, 'Sweeper Sidejob', 'none', 1663078155),
(321, 173, 1100, 'Trashmaster Sidejob', 'none', 1663078904),
(323, 368, 636, 'Bus Sidejob', 'none', 1663079728),
(328, 165, 640, 'Money Transporter Sidejob', 'none', 1663083387),
(332, 335, 1156, 'Trashmaster Sidejob', 'none', 1663090994),
(333, 54, 600, 'Sweeper Sidejob', 'none', 1663091297),
(335, 335, 638, 'Money Transporter Sidejob', 'none', 1663091705),
(337, 335, 600, 'Sweeper Sidejob', 'none', 1663092225),
(338, 54, 600, 'Money Transporter Sidejob', 'none', 1663092294),
(366, 368, 664, 'Sweeper Sidejob', 'none', 1663117326),
(373, 297, 0, 'San Andreas Police Department', 'none', 1663119630),
(377, 368, 682, 'Bus Sidejob', 'none', 1663121090),
(381, 267, 171, 'Cargo', 'none', 1663132771),
(382, 267, 197, 'Cargo', 'none', 1663132810),
(383, 267, 159, 'Cargo', 'none', 1663132832),
(384, 267, 186, 'Cargo', 'none', 1663132857),
(385, 267, 186, 'Cargo', 'none', 1663133421),
(388, 25, 200, 'Boxville Sidejob', 'none', 1663134830),
(392, 71, 110, 'Boxville Sidejob', 'none', 1663136897),
(397, 25, 200, 'Boxville Sidejob', 'none', 1663137104),
(404, 71, 141, 'Boxville Sidejob', 'none', 1663143447),
(410, 71, 100, 'Boxville Sidejob', 'none', 1663145030),
(413, 135, 606, 'Sweeper Sidejob', 'none', 1663145246),
(418, 71, 600, 'Bus Sidejob', 'none', 1663146275),
(419, 402, 615, 'Money Transporter Sidejob', 'none', 1663146786),
(423, 393, 685, 'Sweeper Sidejob', 'none', 1663147941),
(426, 403, 677, 'Money Transporter Sidejob', 'none', 1663148810),
(427, 17, 619, 'Money Transporter Sidejob', 'none', 1663149273),
(428, 393, 674, 'Bus Sidejob', 'none', 1663149405),
(429, 17, 669, 'Sweeper Sidejob', 'none', 1663149661),
(430, 54, 600, 'Sweeper Sidejob', 'none', 1663149820),
(432, 17, 100, 'Boxville Sidejob', 'none', 1663149986),
(433, 54, 124, 'Boxville Sidejob', 'none', 1663150215),
(434, 54, 600, 'Money Transporter Sidejob', 'none', 1663150301),
(435, 393, 605, 'Sweeper Sidejob', 'none', 1663150601),
(436, 34, 600, 'Sweeper Sidejob', 'none', 1663151355),
(437, 404, 661, 'Money Transporter Sidejob', 'none', 1663151831),
(438, 267, 188, 'Cargo', 'none', 1663152967),
(439, 267, 183, 'Cargo', 'none', 1663153027),
(440, 34, 600, 'Sweeper Sidejob', 'none', 1663153109),
(442, 331, 200, 'Boxville Sidejob', 'none', 1663158533),
(444, 331, 637, 'Sweeper Sidejob', 'none', 1663158974),
(445, 414, 600, 'Sweeper Sidejob', 'none', 1663159770),
(446, 274, 649, 'Sweeper Sidejob', 'none', 1663160163),
(447, 18, 0, 'San Andreas Police Department', 'none', 1663160307),
(448, 175, 600, 'Sweeper Sidejob', 'none', 1663160470),
(449, 79, 0, 'San Andreas Police Department', 'none', 1663160482),
(450, 34, 600, 'Sweeper Sidejob', 'none', 1663161138),
(452, 274, 624, 'Bus Sidejob', 'none', 1663161715),
(453, 17, 1145, 'Trashmaster Sidejob', 'none', 1663165741),
(456, 31, 600, 'Money Transporter Sidejob', 'none', 1663178144),
(458, 30, 600, 'Bus Sidejob', 'none', 1663178230),
(459, 31, 652, 'Sweeper Sidejob', 'none', 1663178505),
(462, 31, 684, 'Sweeper Sidejob', 'none', 1663180551),
(463, 31, 600, 'Money Transporter Sidejob', 'none', 1663180889),
(464, 239, 200, 'Boxville Sidejob', 'none', 1663180932),
(465, 239, 1100, 'Trashmaster Sidejob', 'none', 1663181365),
(466, 239, 611, 'Sweeper Sidejob', 'none', 1663181736),
(467, 239, 692, 'Money Transporter Sidejob', 'none', 1663181878),
(468, 430, 627, 'Sweeper Sidejob', 'none', 1663194724),
(474, 429, 239, 'Boxville Sidejob', 'none', 1663207457),
(475, 429, 1184, 'Trashmaster Sidejob', 'none', 1663207902),
(476, 429, 610, 'Money Transporter Sidejob', 'none', 1663208632),
(477, 429, 1100, 'Trashmaster Sidejob', 'none', 1663210030),
(478, 429, 609, 'Sweeper Sidejob', 'none', 1663210416),
(479, 28, 75, 'Miner', 'none', 1663214387),
(482, 363, 210, 'Boxville Sidejob', 'none', 1663229846);

-- --------------------------------------------------------

--
-- Table structure for table `server`
--

CREATE TABLE `server` (
  `ID` int(10) UNSIGNED NOT NULL,
  `g_Motd` varchar(225) NOT NULL,
  `g_Players` int(11) NOT NULL,
  `a_Motd` varchar(255) NOT NULL,
  `h_Motd` varchar(255) NOT NULL,
  `fish_Price` float NOT NULL DEFAULT 0.5,
  `config` smallint(2) UNSIGNED NOT NULL DEFAULT 0,
  `tax` int(5) NOT NULL DEFAULT 5,
  `cow_price` int(5) NOT NULL DEFAULT 0,
  `deer_price` int(5) NOT NULL DEFAULT 0,
  `admin_online` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `lsd_price` int(5) NOT NULL DEFAULT 0,
  `ecs_price` int(5) NOT NULL DEFAULT 0,
  `server_timer` int(11) NOT NULL DEFAULT 0,
  `server_time` int(11) NOT NULL DEFAULT 0,
  `server_time_minute` int(4) NOT NULL DEFAULT 0,
  `server_time_interval` int(4) NOT NULL DEFAULT 30,
  `server_time_sync` int(4) NOT NULL DEFAULT 0,
  `wheat_price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `server`
--

INSERT INTO `server` (`ID`, `g_Motd`, `g_Players`, `a_Motd`, `h_Motd`, `fish_Price`, `config`, `tax`, `cow_price`, `deer_price`, `admin_online`, `lsd_price`, `ecs_price`, `server_timer`, `server_time`, `server_time_minute`, `server_time_interval`, `server_time_sync`, `wheat_price`) VALUES
(1, 'Halo! jika butuh bantuan silahkan gunakan /report !', 44, 'Dilarang abuse staff command!', '', 0.5, 0, 5, 272, 106, 'Last Check : Thursday, 15 September 2022 -- 18:51:16\n\n', 451, 766, 0, 12, 43, 30, 0, 79);

-- --------------------------------------------------------

--
-- Table structure for table `server_economies`
--

CREATE TABLE `server_economies` (
  `id` int(11) NOT NULL,
  `supply` int(11) NOT NULL DEFAULT 1000000,
  `reserve` int(11) NOT NULL DEFAULT 1000000,
  `inflation_rate` int(11) NOT NULL DEFAULT 0,
  `sales_tax_rate` int(11) NOT NULL DEFAULT 0,
  `max_faction_salary_weekly` int(11) NOT NULL DEFAULT 0,
  `component_price` int(11) NOT NULL DEFAULT 1,
  `material_price` int(11) NOT NULL DEFAULT 1,
  `treatment_price` int(11) NOT NULL DEFAULT 100,
  `rental_vehicle_overtime_forfeit` int(11) NOT NULL DEFAULT 100,
  `rental_vehicle_destroyed_forfeit` int(11) NOT NULL DEFAULT 100,
  `rental_vehicle_damaged_forfeit` int(11) NOT NULL DEFAULT 100,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0,
  `deleted_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `server_economies`
--

INSERT INTO `server_economies` (`id`, `supply`, `reserve`, `inflation_rate`, `sales_tax_rate`, `max_faction_salary_weekly`, `component_price`, `material_price`, `treatment_price`, `rental_vehicle_overtime_forfeit`, `rental_vehicle_destroyed_forfeit`, `rental_vehicle_damaged_forfeit`, `created_at`, `updated_at`, `deleted_at`) VALUES
(5, 1000000, 2474202, 0, 0, 10000, 1, 10, 100, 100, 100, 1, 1645792522, 1663231786, 0);

--
-- Triggers `server_economies`
--
DELIMITER $$
CREATE TRIGGER `server_economy_before_insert` BEFORE INSERT ON `server_economies` FOR EACH ROW BEGIN

	SET NEW.`created_at` = UNIX_TIMESTAMP(NOW());

	SET NEW.`updated_at` = UNIX_TIMESTAMP(NOW());

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `server_economy_update_timestamp` BEFORE UPDATE ON `server_economies` FOR EACH ROW BEGIN

	SET NEW.`updated_at` = UNIX_TIMESTAMP(NOW());

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `server_vehicles`
--

CREATE TABLE `server_vehicles` (
  `id` int(11) NOT NULL,
  `model` smallint(5) UNSIGNED DEFAULT NULL,
  `extraid` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `state` tinyint(1) DEFAULT 0,
  `renttime` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `interior` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `world` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `color1` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `color2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `paintjob` tinyint(1) UNSIGNED DEFAULT 3,
  `plate` varchar(32) NOT NULL DEFAULT 'NONE',
  `health` float NOT NULL DEFAULT 1000,
  `fuel` float NOT NULL DEFAULT 100,
  `posX` float DEFAULT NULL,
  `posY` float DEFAULT NULL,
  `posZ` float DEFAULT NULL,
  `posRZ` float DEFAULT NULL,
  `damage1` int(11) DEFAULT NULL,
  `damage2` int(11) DEFAULT NULL,
  `damage3` int(11) DEFAULT NULL,
  `damage4` int(11) DEFAULT NULL,
  `insurance` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `insurancetime` int(10) UNSIGNED DEFAULT NULL,
  `impoundprice` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `impoundtime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lumber` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `siren` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `engineup` int(2) UNSIGNED NOT NULL DEFAULT 0,
  `bodyup` int(2) UNSIGNED NOT NULL DEFAULT 0,
  `gasup` int(2) UNSIGNED NOT NULL DEFAULT 0,
  `bodyrepair` float UNSIGNED NOT NULL DEFAULT 1000,
  `neoncolor` int(5) NOT NULL DEFAULT 0,
  `togneon` int(2) NOT NULL DEFAULT 0,
  `vehwoods` int(5) NOT NULL DEFAULT 0,
  `vehcomponent` int(5) NOT NULL DEFAULT 0,
  `turbo` int(5) NOT NULL DEFAULT 0,
  `parking` int(3) NOT NULL DEFAULT 0,
  `house_parking` int(15) NOT NULL DEFAULT -1,
  `doorstatus` int(2) NOT NULL DEFAULT 1,
  `enginestatus` int(2) NOT NULL DEFAULT 0,
  `vehlocktire` int(5) NOT NULL DEFAULT 0,
  `vehlocktireposx` float NOT NULL DEFAULT 0,
  `vehlocktireposy` float NOT NULL DEFAULT 0,
  `vehlocktireposz` float NOT NULL DEFAULT 0,
  `vehlocktireposrz` float NOT NULL DEFAULT 0,
  `current_mileage` float(13,4) DEFAULT 0.0000,
  `durability_mileage` float(13,4) DEFAULT 100.0000,
  `accumulated_mileage` float(13,4) DEFAULT 0.0000,
  `vehhandbrake` int(10) NOT NULL DEFAULT 0,
  `vehhandbrakeposx` float NOT NULL DEFAULT 0,
  `vehhandbrakeposy` float NOT NULL DEFAULT 0,
  `vehhandbrakeposz` float NOT NULL DEFAULT 0,
  `vehhandbrakeposrz` float NOT NULL DEFAULT 0,
  `apartment_id` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `server_vehicles`
--

INSERT INTO `server_vehicles` (`id`, `model`, `extraid`, `type`, `state`, `renttime`, `interior`, `world`, `color1`, `color2`, `paintjob`, `plate`, `health`, `fuel`, `posX`, `posY`, `posZ`, `posRZ`, `damage1`, `damage2`, `damage3`, `damage4`, `insurance`, `insurancetime`, `impoundprice`, `impoundtime`, `lumber`, `siren`, `engineup`, `bodyup`, `gasup`, `bodyrepair`, `neoncolor`, `togneon`, `vehwoods`, `vehcomponent`, `turbo`, `parking`, `house_parking`, `doorstatus`, `enginestatus`, `vehlocktire`, `vehlocktireposx`, `vehlocktireposy`, `vehlocktireposz`, `vehlocktireposrz`, `current_mileage`, `durability_mileage`, `accumulated_mileage`, `vehhandbrake`, `vehhandbrakeposx`, `vehhandbrakeposy`, `vehhandbrakeposz`, `vehhandbrakeposrz`, `apartment_id`) VALUES
(2, 431, 1, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1802.73, -1927.81, 13.3888, 1.1838, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(5, 431, 1, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1796.86, -1928.41, 13.3885, 0.5286, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(6, 431, 1, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1790, -1928.23, 13.3885, 358.705, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(7, 574, 2, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1708.36, -1526.6, 13.5469, 91.1325, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(13, 574, 2, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1708.34, -1523.52, 13.5469, 91.7085, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(15, 574, 2, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1708.19, -1520.15, 13.5469, 89.5831, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(20, 408, 3, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 2341.52, -2010, 13.5453, 358.763, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(21, 408, 3, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 2346.54, -2009.97, 13.5441, 358.437, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(23, 408, 3, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 2351.27, -2009.67, 13.543, 359.471, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(24, 498, 5, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1635.91, -1907.8, 13.5521, 19.9558, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(25, 498, 5, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1640.13, -1906.03, 13.5521, 23.6299, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(26, 498, 5, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 1644.34, -1903.9, 13.5521, 18.9288, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(27, 428, 4, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 863.552, -1245.15, 14.8586, 270.726, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(28, 428, 4, 3, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 100, 864.036, -1255.29, 14.8572, 273.004, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(30, 410, 0, 5, 1, 0, 0, 0, 6, 6, 3, '{ADD8E6}DMV', 1000, 100, 1132.72, -1695.83, 13.6971, 271.369, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(31, 410, 0, 5, 1, 0, 0, 0, 6, 6, 3, '{ADD8E6}DMV', 1000, 100, 1132.08, -1692.22, 13.9765, 267.714, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(32, 462, 59, 4, 1, 3101, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 55202.4, 94.82, 2067.79, -1511.61, 2.9073, 72.4715, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(35, 560, 25, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 99.82, 2507.07, -1694.82, 13.2644, 183.875, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0219, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(36, 541, 3, 2, 1, 0, 0, 0, 1, 1, 3, 'PD-COMM-1', 1000, 100, 1529.5, -1683.82, 5.8906, 270.874, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(40, 541, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-HOTEL-1', 1000, 100, 1529.51, -1687.73, 5.8906, 270.827, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(44, 596, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-ADAM-2', 1000, 95.74, 2114.86, -1379.72, 23.6177, 91.3118, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2.9124, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(46, 596, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-ADAM-3', 1000, 34.15, 1626.6, -1437.78, 13.1017, 91.2541, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 41.5946, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(48, 597, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-METRO-1', 1000, 67.24, 1156.18, -1047.65, 31.544, 177.915, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 17.2154, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(49, 597, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-METRO-2', 1000, 100, 1587.24, -1710.61, 5.5939, 0.7323, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(52, 598, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-JOHN-1', 1000, 100, 1591.35, -1710.68, 5.8906, 359.307, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(53, 598, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-JOHN-2', 1000, 100, 1595.24, -1710.41, 5.8906, 1.3702, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(54, 599, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-ALPHA-1', 1000, 100, 1562.59, -1710.92, 5.8906, 1.436, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(55, 599, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-ALPHA-2', 1000, 100, 1566.25, -1710.59, 5.8906, 0.3774, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(56, 560, 3, 2, 1, 0, 0, 0, 0, 1, 3, 'STAFF-1', 1000, 100, 1602.28, -1704.24, 5.8906, 90.8917, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(57, 560, 3, 2, 1, 0, 0, 0, 1, 1, 3, 'STAFF-2', 1000, 100, 1601.82, -1700.37, 5.8906, 90.7161, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(58, 560, 3, 2, 1, 0, 0, 0, 11, 1, 3, 'STAFF-3', 1000, 100, 1601.74, -1696.11, 5.8906, 90.6626, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(59, 560, 3, 2, 1, 0, 0, 0, 79, 1, 3, 'STAFF-4', 1000, 100, 1601.81, -1692.2, 5.8906, 88.3229, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(60, 426, 3, 2, 1, 0, 0, 0, 106, 1, 3, 'GCLU', 1000, 100, 1584.46, -1671.98, 5.893, 269.868, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(67, 523, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-MARY-1', 1000, 100, 1600.22, -1710.62, 5.8906, 36.9317, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(68, 523, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-MARY-2', 1000, 100, 1601.79, -1709.3, 5.8906, 46.1185, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(70, 451, 3, 2, 1, 0, 0, 0, 0, 0, 3, '1-HOTEL-2', 1000, 100, 1545.23, -1684.24, 5.8906, 88.2473, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(75, 552, 3, 2, 1, 0, 0, 0, 1, 0, 3, '1-TOM-1', 1000, 100, 1538.96, -1645.53, 5.8906, 181.237, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(77, 415, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-HOTEL-3', 1000, 100, 1545.09, -1680.04, 5.8906, 89.6292, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(78, 596, 3, 2, 1, 0, 0, 0, 0, 1, 3, '1-ADAM-1', 1000, 100, 1893.01, -2168.03, 13.1047, 281.665, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(79, 462, 82, 4, 1, 3055, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 996, 97.52, 1493.2, -1744.11, 13.1444, 145.247, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(81, 416, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Rescue 111', 1000, 100, 1146.07, -1308.64, 13.6639, 91.1405, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(82, 416, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Rescue 112', 1000, 100, 1146.07, -1304.04, 13.6591, 93.2393, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(83, 416, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Rescue 113', 1000, 100, 1145.86, -1299.59, 13.6491, 89.9897, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(84, 426, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Paul 111', 1000, 99.96, 1140.19, -1273.42, 13.3104, 23.4957, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0649, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(86, 426, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Paul 112', 1000, 100, 1141.2, -1325.79, 13.6361, 89.7415, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(88, 579, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Paul 221', 1000, 100, 1141.16, -1329.8, 13.648, 90.7711, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(89, 579, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'Paul 222', 1000, 100, 1141.27, -1334.96, 13.6461, 90.3431, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(90, 586, 5, 2, 1, 0, 0, 0, 3, 3, 3, 'William 1', 1000, 100, 1128.36, -1307.71, 13.585, 0.1312, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(92, 586, 5, 2, 1, 0, 0, 0, 3, 3, 3, 'William 2', 1000, 100, 1125.26, -1307.21, 13.5855, 0.1312, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(95, 487, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'FlightAIR', 1000, 100, 1160.62, -1319.56, 31.4933, 270.445, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(98, 487, 5, 2, 1, 0, 0, 0, 3, 1, 3, 'FlightAIR', 1000, 100, 1160.88, -1298.62, 31.499, 269.014, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(100, 586, 63, 4, 1, 6193, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 587.13, 99.97, 1828.44, -1857.25, 13.0983, 190.298, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(106, 582, 6, 2, 1, 0, 0, 0, 6, 1, 3, 'SANA 1', 1000, 100, 760.521, -1348.23, 13.5541, 359.419, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(107, 582, 6, 2, 1, 0, 0, 0, 6, 1, 3, 'SANA 2', 1000, 100, 756.189, -1347.8, 13.5541, 1.9662, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(108, 582, 6, 2, 1, 0, 0, 0, 6, 1, 3, 'SANA 3', 1000, 100, 751.727, -1348.01, 13.5541, 358.334, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(109, 563, 6, 2, 1, 0, 0, 0, 6, 1, 3, 'SANA AIR 1', 1000, 100, 741.807, -1371.73, 25.6922, 358.772, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(110, 462, 96, 4, 1, 8985, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 388.83, 94.17, 590.192, -1238.68, 17.4556, 163.477, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(114, 462, 124, 4, 1, 3116, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 966.27, 99.89, 1832.61, -1849.42, 13.1665, 358.257, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(117, 586, 134, 4, 1, 3443, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 99.22, 1809.54, -1799.14, 13.0671, 185.112, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(119, 560, 9, 1, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1167.66, 83.82, 583.06, -1237.81, 17.3629, 112.587, 35651600, 33686018, 4, 0, 2, 1662994913, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 53.9420, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(120, 462, 141, 4, 1, 9563, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 96.85, 151.405, -286.229, 1.1757, 70.3425, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(121, 462, 126, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 886, 100, 2120.08, -1477.58, 23.5246, 324.165, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(123, 580, 126, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 91.22, 1601.49, -1683.4, 5.6335, 271.654, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 6.9344, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(124, 525, 18, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 953.53, 98.81, 1547.23, -1667.79, 5.8785, 269.194, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.5806, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(125, 521, 18, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 955.31, 97.51, 1533.45, -1664.25, 5.459, 3.7229, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.0959, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(126, 562, 9, 1, 3, 0, 0, 0, 6, 6, 3, 'NONE', 959.9, 85.13, 251.872, -76.4642, 1.1625, 274.116, 33554432, 512, 0, 0, 2, 1663063542, 0, 0, 0, 0, 1, 3, 2, 750, 18652, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 10.4631, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(127, 560, 9, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 439, 50.52, 1062.76, -1769.82, 13.0287, 89.2514, 19005474, 33554948, 5, 0, 0, 1662995655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 25.4979, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(128, 560, 144, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 789.56, 41.8, 237.799, -111.185, 1.2088, 354.583, 16777216, 131586, 0, 0, 2, 1663098228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 55.9988, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(129, 463, 144, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 923.23, 98.33, 221.217, -64.7129, 0.8805, 335.815, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 33.2703, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(130, 579, 220, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 749.56, 80.62, 267.884, -144.151, 1.5111, 268.772, 2162688, 131074, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 10.9976, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(132, 560, 40, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 671.89, 72.11, 2214.43, -1785.54, 12.9546, 178.648, 19070992, 514, 4, 0, 1, 1662972395, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 21.6499, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(133, 560, 40, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 441.54, 37.27, 1872.31, -2165.22, 13.0841, -0, 1048592, 0, 4, 0, 2, 1662839883, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 65.9085, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(134, 468, 34, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1154.83, 56.99, 1716.36, -1551.28, 13.2151, 268.846, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 100.6604, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(135, 420, 79, 1, 3, 0, 0, 0, 0, 0, 3, 'NONE', 338.44, 80.5, 1393.54, -1408.45, 13.1489, 219.33, 36765730, 33686018, 5, 0, 2, 1662899088, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 14.0749, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(137, 579, 79, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 917.55, 97.16, 1534.29, -1643.3, 5.8668, 2.2439, 18874385, 512, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1.1569, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(138, 496, 31, 1, 1, 0, 0, 0, 127, 127, 3, 'NONE', 957.05, 62.4, 2159.74, -1804.94, 13.0938, 91.4634, 0, 0, 0, 0, 0, 1663078766, 0, 0, 0, 0, 0, 0, 0, 0, 18652, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 27.2562, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(140, 545, 8, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 669.24, 99.91, 1763.91, -1936.85, 13.4335, 90.472, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0005, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(141, 463, 8, 1, 3, 0, 0, 0, 1, 0, 3, 'NONE', 949.93, 99.97, 1791.1, -1917.17, 12.9544, 16.5681, 0, 0, 0, 0, 2, 1662900008, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(142, 468, 8, 1, 1, 0, 0, 0, 5, 0, 3, 'NONE', 883.87, 99.32, 1148.42, -1027.51, 31.7261, 19.8507, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.4232, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(143, 462, 142, 1, 3, 0, 0, 0, 9, 9, 3, 'NONE', 955.99, 97.21, 240.725, -122.024, 1.175, 2.2259, 0, 0, 0, 0, 2, 1663063542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.0381, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(144, 522, 19, 1, 1, 0, 0, 0, 88, 88, 3, 'LS-53404', 2000, 121.56, 1033.69, -642.851, 119.68, 123.485, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 1, 3, 2, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 31.2933, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(145, 562, 19, 1, 1, 0, 0, 0, 251, 251, 3, 'LS-20770', 1000, 91.37, 1041.31, -624.371, 117.678, 100.126, 0, 0, 0, 0, 2, 1663007997, 0, 0, 0, 0, 1, 3, 2, 1000, 18648, 1, 0, 0, 3, 0, -1, 1, 0, 0, 0, 0, 0, 0, 34.2708, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(147, 500, 62, 1, 3, 0, 0, 0, 5, 5, 3, 'NONE', 1000, 93.56, 322.143, -84.0658, 1.8366, 90.3612, 0, 0, 0, 0, 2, 1663164801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 3.7244, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(148, 579, 62, 1, 3, 0, 0, 0, 5, 5, 3, 'NONE', 680, 39.28, 319.957, -87.247, 1.9424, 89.021, 0, 0, 0, 0, 2, 1663164801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 34.4039, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(150, 586, 147, 1, 1, 0, 0, 0, 2, 2, 3, 'NONE', 1000, 100, 1719.35, -1472.21, 13.0629, 278.386, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(151, 525, 147, 1, 1, 0, 0, 0, 2, 2, 3, 'NONE', 999.33, 99.42, 1205.98, -1293.37, 13.2736, 132.666, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.4476, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(152, 463, 123, 1, 1, 0, 0, 0, 77, 77, 3, 'NONE', 30200.7, 67.3, 261.385, -46.0623, 1.6182, 353.698, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 60.2218, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(153, 440, 123, 1, 1, 0, 0, 0, 77, 77, 3, 'NONE', 1000, 100, 267.427, -127.759, 2.978, 176.43, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(154, 468, 154, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 99.54, 1782.61, -1887.59, 13.0031, 4.4603, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.3305, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(155, 468, 153, 1, 5, 0, 0, 0, 1, 1, 3, 'NONE', 780.59, 99.35, 1082.81, -1698.18, 13.216, 52.5003, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 1, 0, 0, 0, 0, 0, 0, 0.7383, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(156, 562, 99, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 948.49, 90.35, 1934.23, -1639.8, 13.2053, 170.6, 3145744, 0, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 7.2120, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(158, 468, 151, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 968, 100, -426.643, -381.366, 15.1653, 277.381, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(159, 545, 133, 1, 1, 0, 0, 0, 5, 5, 3, 'NONE', 953.09, 100, 248.429, -1383.95, 52.8592, 36.9912, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(160, 560, 133, 1, 1, 0, 0, 0, 5, 5, 3, 'NONE', 811.29, 96.46, 317.213, -69.1721, 1.1352, 283.595, 0, 0, 0, 0, 2, 1663091109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1.7766, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(163, 602, 17, 1, 1, 0, 0, 0, 148, 148, 3, 'LS-03140', 998.6, 99.97, 1031.13, -811.485, 101.658, 199.695, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18650, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0399, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(164, 420, 156, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 832.04, 99.97, 1802.83, -1912.68, 13.1755, 358.792, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(165, 468, 139, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 853.65, 47.94, 996.676, -1264.51, 14.6325, -0, 0, 0, 0, 3, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 1, 0, 0, 0, 0, 31.7684, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(166, 426, 139, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 97.58, 2749.59, -1108.75, 69.3091, 320.009, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.9402, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(167, 515, 139, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.94, 2750.88, -1115.73, 70.6456, 327.969, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0038, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(170, 422, 221, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-12540', 650.9, 70.47, 1834.54, -1869.68, 13.3733, 359.19, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 26.9841, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(171, 560, 54, 1, 1, 0, 0, 0, 235, 235, 3, 'LS-15181', 532, 80.03, 1098.49, -1769.68, 13.0051, 90.3709, 0, 0, 0, 0, 1, 1663099479, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 13.7124, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(172, 477, 54, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-85711', 714.74, 61.59, 2140.21, -1294.19, 23.7317, 88.2627, 0, 0, 0, 0, 2, 1662874167, 0, 0, 0, 0, 0, 3, 0, 700, 18650, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 109.3238, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(173, 545, 54, 1, 1, 0, 0, 0, 7, 5, 3, 'LS-66551', 978, 99.79, 2138.12, -1283.8, 24.6365, 359.999, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0401, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(174, 559, 30, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 300, 98.77, 2230.08, -1649.95, 14.9645, 257.06, 0, 0, 0, 0, 1, 1663158437, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.6564, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(175, 499, 30, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 821.42, 93.2, 2239.48, -1630.17, 15.7012, 339.498, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 4.6247, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(176, 521, 30, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 733.21, 94.12, 2239.95, -1641.55, 15.1065, 311.505, 0, 0, 0, 0, 2, 1663018644, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 4.0089, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(180, 462, 155, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 904.53, 95.14, 1784.81, -1906.6, 12.982, 172.954, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 4.6908, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(181, 422, 155, 1, 1, 0, 0, 0, 2, 1, 3, 'NONE', 911.39, 96.24, 2532.92, -1542.2, 25.8278, 265.861, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 3.1001, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(182, 545, 116, 1, 1, 0, 0, 0, 135, 135, 3, 'LS-51321', 895.7, 66.14, 1180.47, -1308.95, 13.4821, 87.5711, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 23.4562, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(183, 474, 157, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 399.47, 99.82, 739.99, -1796.21, 12.9447, 170.29, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.2249, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(185, 477, 65, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-63181', 1138.89, 36.6, 2385.46, -1663.05, 13.2132, 268.807, 0, 0, 0, 0, 2, 1663054402, 0, 0, 0, 0, 1, 3, 2, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 107.8991, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(186, 426, 159, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 985.89, 95.87, 2475.26, -1699.03, 13.2685, 4.4182, 17825793, 512, 1, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.1333, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(187, 554, 159, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.63, 2472.23, -1699.22, 13.6009, 1.9377, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0238, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(188, 468, 159, 1, 3, 0, 0, 0, 3, 3, 3, 'NONE', 989.6, 92.49, 1841.21, -1871.86, 13.036, 198.735, 0, 0, 0, 0, 2, 1663094047, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 5.6795, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(190, 560, 6, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 932.91, 86.53, 1124.21, -1331.26, 12.6538, 356.106, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 10.0705, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(191, 468, 6, 1, 3, 0, 0, 0, 3, 3, 3, 'NONE', 991.01, 99.96, 241.363, -81.201, 1.2452, 169.126, 0, 0, 0, 0, 2, 1663063542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 1, 0, 0, 0, 0, 0.0388, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(192, 499, 6, 1, 3, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.97, 248.344, -22.6928, 1.5871, 178.503, 0, 0, 0, 0, 2, 1663063541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0714, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(198, 579, 25, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 98.98, 2503.82, -1694.67, 13.553, 179.638, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.7329, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(199, 470, 64, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 983.6, 76.25, 268.369, -63.0592, 1.5696, 103.049, 0, 0, 0, 0, 2, 1663148420, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 14.4123, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(201, 463, 62, 1, 3, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 95.08, 983.183, -431.072, 58.4757, 198.056, 0, 0, 0, 0, 2, 1662972483, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 4.5258, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(202, 440, 64, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 87.41, 1098.59, -1763.79, 13.05, 90.25, 0, 0, 0, 0, 2, 1663148420, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 8.8329, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(203, 411, 77, 1, 1, 0, 0, 0, 136, 136, 3, 'NONE', 985.97, 98.59, 2433.23, -2088.7, 13.274, 272.096, 2097152, 33554432, 0, 0, 2, 1662890674, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 1.0362, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(209, 521, 71, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 297.12, 74.65, 1040.87, -2010.21, 12.5146, 173.976, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 19.4500, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(211, 560, 15, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 955.72, 100, 262.568, -115.79, 2.3738, 180.219, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(212, 545, 29, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 676.06, 74.6, 1109.45, -734.106, 99.8031, 269.673, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 17.5013, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(213, 499, 29, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 992.24, 99.99, 1109.25, -730.491, 100.389, 91.0099, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(214, 506, 15, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 989.24, 100, 270.177, -110.635, 2.5898, 352.582, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(215, 463, 15, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 30220.1, 71.65, 265.361, -119.489, 2.2786, 97.9787, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 21.1819, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(216, 468, 174, 1, 5, 0, 0, 0, 3, 3, 3, 'NONE', 919.01, 97.43, 99.0526, -1820.21, 2.1781, 79.6516, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 1.4649, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(217, 545, 5, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 720.31, 87.17, 1618.76, -1431.65, 13.3043, 53.1825, 3145778, 2, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 14.6527, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(218, 560, 5, 1, 1, 0, 0, 0, 171, 171, 3, 'LS-13571', 386.92, 42.1, 1954.23, -1859.79, 13.2498, 182.457, 35717155, 512, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 1, 0, 0, 0, 0, 36.5606, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(219, 560, 12, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 967.87, 94.99, 2113.75, -1365.69, 23.6524, 6.7186, 0, 0, 0, 0, 2, 1662886016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 1, 0, 0, 0, 0, 2.3306, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(220, 463, 12, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 36917.1, 85.19, 1865.93, -1868.2, 13.0849, 16.35, 0, 0, 0, 0, 2, 1662886835, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 9.6326, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(221, 499, 28, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 100, 1775.97, -1905.74, 13.3904, 180.465, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(222, 422, 28, 1, 1, 0, 0, 0, 79, 79, 3, 'NONE', 830.97, 99.04, 1781.13, -1905.52, 13.3766, 180.784, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.8044, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(223, 507, 28, 1, 1, 0, 0, 0, 243, 243, 3, 'NONE', 635.16, 93.89, 582.445, -1239.57, 17.4952, 107.562, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 4.7051, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(224, 463, 14, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 469.06, 90.67, 848.132, -148.231, 9.28, 342.003, 0, 0, 0, 0, 2, 1663084237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 43.5315, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(225, 463, 187, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 21567.9, 86.11, 1998.29, -1752.62, 12.9235, 39.8463, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 1, 0, 0, 0, 0, 10.3451, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(226, 560, 187, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-80456', 979.43, 92.76, 1526.64, -1644.94, 5.5553, 2.0398, 1048577, 33685504, 1, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 4.7543, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(227, 486, 51, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 761.81, 100, 1343.79, -1568.34, 13.7695, 334.229, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(228, 586, 13, 1, 3, 0, 0, 0, 0, 0, 3, 'NONE', 737, 52.85, 737.565, 50.8463, 59.0444, 312.583, 0, 0, 0, 0, 2, 1662996013, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 33.8847, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(229, 554, 14, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 95.2, 276.002, 18.8647, 2.5245, 282.102, 2097152, 2, 0, 0, 2, 1663007402, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2.7897, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(230, 483, 13, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 886.57, 66.96, 2148.55, -1253, 24.9734, 179.364, 16777216, 512, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 24.6203, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(231, 579, 193, 1, 2, 0, 0, 0, 1, 1, 3, 'NONE', 791.75, 77.71, 41.8246, 1382.79, 9.3399, 236.089, 3145730, 50331648, 1, 0, 2, 1662887320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 13.2041, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(232, 542, 13, 1, 3, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 95.09, 236.704, -62.0709, 1.1953, 340.077, 0, 0, 0, 0, 2, 1663164800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 3.5151, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(233, 507, 60, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.97, 2298.16, -1634.88, 14.5068, 82.1458, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(234, 426, 60, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 994, 85.22, 2130.05, -1479.87, 23.5566, 273.266, 1048592, 33554432, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 7.1785, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(235, 463, 60, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 995, 97.16, 2297.4, -1643.81, 14.2747, 95.1662, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.1689, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(236, 506, 180, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 300, 91.19, 761.588, -1212.94, 13.2513, 264.249, 35782690, 33686020, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 5.5984, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(237, 477, 180, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 944.22, 95.18, 1097.3, -1752.84, 13.1033, 289.249, 0, 0, 0, 0, 2, 1662876861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2.5541, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(238, 560, 180, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 300, 87.52, 2162.98, -1727.64, 13.2621, 135.06, 35717169, 50332164, 5, 0, 2, 1662878972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 8.2945, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(240, 499, 177, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 945.29, 99.83, 2371.52, -1636.82, 13.4574, 182.565, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0315, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(241, 463, 89, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 940.42, 62.57, 256.757, -64.9307, 1.1183, 92.7105, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 24.8558, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(242, 559, 177, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-82225', 1773.99, 68.33, 2375.86, -1635.74, 13.1581, 180.773, 0, 0, 0, 0, 2, 1662890151, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 18.3840, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(243, 463, 58, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 956.72, 78.49, 250.659, -80.4224, 1.1183, 356.612, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 13.8268, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(244, 468, 26, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 100, 2532.31, -1541.2, 25.5454, 283.69, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(245, 422, 26, 1, 3, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 100, 1829.72, -1851.81, 13.5781, 135.871, 0, 0, 0, 0, 2, 1662877566, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(246, 506, 165, 1, 1, 0, 0, 0, 1, 2, 3, 'NONE', 1000, 33.32, 2513.78, -1552.78, 25.3339, 166.078, 0, 0, 0, 0, 2, 1662882718, 0, 0, 0, 0, 0, 0, 0, 0, 18649, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 43.3694, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(248, 586, 114, 4, 1, 519, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 754.36, 98.35, 1315.44, -1704.63, 12.9042, 344.862, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(249, 463, 41, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 569.94, 89.66, -1878.32, -2596.61, 57.0366, 190.547, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 6.7494, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(250, 492, 41, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 850, 77.87, 248.709, -72.5026, 1.2111, 255.906, 18874402, 33686016, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 14.3680, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(251, 521, 131, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 985.86, 89.3, 222.489, -1400.24, 51.1309, 225.755, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 6.2072, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(252, 525, 225, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 988.83, 74.33, 1354.26, -1536.05, 13.4446, 354.366, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 16.9995, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(253, 560, 131, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 734.87, 90.23, 1343.2, -1548.48, 13.2683, 263.556, 2162705, 3, 5, 0, 3, 1662925112, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 5.9347, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(254, 426, 27, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 477.92, 100, 1787.7, -1865.87, 13.0174, 84.6462, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(255, 458, 27, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 679.83, 100, 1065.27, -1832.57, 13.5171, 232.738, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(256, 560, 27, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 980.67, 100, 1812.47, -1832.95, 13.1035, 65.1171, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(257, 542, 16, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 99.76, 1063.49, -1766.08, 13.1218, 89.9971, 0, 0, 0, 0, 2, 1663164800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.1272, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(258, 499, 16, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 965, 99.94, 1098.6, -1757.91, 13.05, 90.14, 0, 0, 0, 0, 2, 1663164800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.1230, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(259, 560, 16, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 21.97, 280.289, -72.053, 1.1336, 293.876, 0, 0, 0, 0, 2, 1663017550, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 47.0329, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(260, 463, 192, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 847.95, 79.78, 658.869, 664.638, 7.1921, 275.924, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 74.1731, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(261, 560, 192, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 568.09, 0, 2160.53, -1454.75, 25.2442, 0, 18874386, 514, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 54.9603, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(262, 426, 36, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 891.9, 91, 586.32, -1238.65, 17.55, 120.443, 35717137, 33686016, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 6.6634, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(263, 463, 36, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 63324.6, 95.77, 2098.53, -1800.35, 13.0075, 248.146, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 2.9212, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(264, 509, 108, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 866, 100, 1712.45, -1550.98, 13.0561, 265.385, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(265, 463, 66, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 992, 99.37, 2137.89, -1487.72, 23.5247, 92.9339, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.4485, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(266, 426, 66, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 964, 95.43, 1489, -2143.28, 13.5336, 109.657, 34603024, 512, 4, 0, 2, 1662900608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 2.8631, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(267, 463, 194, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 748.96, 100, 2002.13, -1727.78, 12.9269, 5.4496, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 1, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(268, 560, 194, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-36372', 899.61, 100, 1350.92, -1472.2, 13.0883, 337.297, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(270, 559, 7, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-43038', 1000, 42.42, -428.199, -374.355, 14.1637, 292.268, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 33.2620, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(271, 496, 49, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 781.73, 98.47, 2055.46, -1644.46, 13.2876, 181.729, 3145746, 4, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 21.8614, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(272, 541, 7, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-27676', 1000, 99.99, -430.386, -371.035, 13.7177, 291.667, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0147, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(275, 463, 41, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 617.26, 89.24, 1643.95, -1908.48, 13.0725, 94.0956, 0, 0, 0, 2, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 7.4408, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(276, 468, 104, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 996.71, 97.24, 877.818, -1583.06, 13.216, 127.999, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 2.3161, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(277, 468, 37, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 971.63, 87.44, 1823.47, -1869.19, 13.0558, 305.057, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 31.8504, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(279, 554, 178, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 912.15, 98.01, 1776.51, -1848.82, 13.6182, 275.865, 2097184, 0, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1.4491, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(280, 499, 178, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 972.29, 99.69, -71.5966, -1128.92, 1.0702, 300.719, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0788, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(281, 453, 178, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 965.67, 100, 1802.51, -1847.13, 13.5052, 88.0633, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(282, 411, 173, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-11213', 1971.85, 100, 1776.53, -1905.32, 13.0728, 181.457, 0, 0, 0, 0, 2, 1662887237, 0, 0, 0, 0, 1, 3, 0, 1000, 18651, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(283, 515, 173, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 450.13, 99.94, 1807.86, -1826.15, 14.5832, 120.073, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 1, 0, 0, 0, 0, 0.0030, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(284, 500, 135, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 897.8, 92.33, 282.21, -124.273, 1.5327, 7.1553, 17825808, 514, 4, 0, 2, 1663089381, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 4.6462, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(285, 579, 135, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 946.06, 99.65, 1799.45, -1825.5, 13.5553, 357.273, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 1, 0, 0, 0, 0, 0.0593, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(286, 463, 202, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 736.78, 92.62, 2038.61, -966.582, 42.1909, 243.571, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 6.8460, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(287, 543, 108, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 997.66, 69.45, 1829.89, -1876.94, 13.3766, 313.864, 0, 0, 0, 0, 2, 1663156146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 25.5524, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(288, 560, 142, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 666.18, 74.33, 1536.54, -1673.06, 13.0984, 179.316, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 14.6307, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(290, 468, 84, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 608.22, 99.97, 1101.46, -1786.77, 13.2806, 179.326, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(291, 562, 84, 1, 1, 0, 0, 0, 251, 251, 3, 'NONE', 463.42, 87.16, 1813.17, -1740.63, 13.2076, 7.76, 0, 0, 0, 0, 1, 1663027935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 8.4069, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(293, 468, 105, 1, 6, 0, 0, 0, 1, 1, 3, 'NONE', 898.82, 77.64, 726.584, -1011.46, 52.4073, 1.8489, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 145, 1, 0, 0, 0, 0, 0, 0, 80.5592, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(294, 560, 105, 1, 6, 0, 0, 0, 0, 0, 3, 'NONE', 710.88, 70.87, -394.449, -1435.35, 25.3779, 176.269, 35651584, 512, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 207, 0, 1, 0, 0, 0, 0, 0, 53.6029, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(295, 525, 14, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 582.11, 84.61, 2415.51, -1653.82, 13.3294, 267.688, 3211280, 33685506, 4, 0, 2, 1662901795, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 87.3977, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(296, 560, 4, 1, 3, 0, 0, 0, 2, 2, 3, 'NONE', 1000, 99.97, -2281.2, -2475.49, 25.664, 18.8189, 0, 0, 0, 0, 2, 1662888641, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0147, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(297, 463, 4, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.84, 1801.55, -1870.42, 13.1099, 182.43, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0863, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(298, 579, 4, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.53, 1781.88, -1905.31, 13.3198, 180.342, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0505, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(299, 463, 35, 1, 1, 0, 0, 0, 8, 8, 3, 'NONE', 591.65, 91.83, 1094.99, -1795.85, 13.1474, 271.648, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 6.8090, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(300, 470, 105, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 86.91, 717.995, -1001.08, 52.3358, 148.26, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 35.5652, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(301, 562, 210, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 962.458, -919.899, 45.3886, 109.757, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(302, 580, 210, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 974.883, -924.677, 45.5805, 116.057, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(303, 522, 210, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 748, 100, 1351.01, -1756.84, 13.0531, 334.528, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(304, 578, 69, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 99.89, 1213.65, -1422.92, 13.9749, -0, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0441, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(305, 468, 69, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 802.65, 57.59, 2617.9, -1250.63, 48.5538, 256.907, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 28.9955, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1);
INSERT INTO `server_vehicles` (`id`, `model`, `extraid`, `type`, `state`, `renttime`, `interior`, `world`, `color1`, `color2`, `paintjob`, `plate`, `health`, `fuel`, `posX`, `posY`, `posZ`, `posRZ`, `damage1`, `damage2`, `damage3`, `damage4`, `insurance`, `insurancetime`, `impoundprice`, `impoundtime`, `lumber`, `siren`, `engineup`, `bodyup`, `gasup`, `bodyrepair`, `neoncolor`, `togneon`, `vehwoods`, `vehcomponent`, `turbo`, `parking`, `house_parking`, `doorstatus`, `enginestatus`, `vehlocktire`, `vehlocktireposx`, `vehlocktireposy`, `vehlocktireposz`, `vehlocktireposrz`, `current_mileage`, `durability_mileage`, `accumulated_mileage`, `vehhandbrake`, `vehhandbrakeposx`, `vehhandbrakeposy`, `vehhandbrakeposz`, `vehhandbrakeposrz`, `apartment_id`) VALUES
(306, 499, 69, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 950.71, 99.97, 1189.13, -1327.45, 13.5503, 7.925, 0, 0, 0, 0, 2, 1663171548, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0302, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(307, 506, 37, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-00704', 932.75, 71.76, 1834.22, -1868.5, 13.0871, 134.858, 0, 0, 0, 0, 1, 1663130695, 0, 0, 0, 0, 1, 0, 0, 0, 18648, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 21.3356, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(309, 499, 12, 1, 1, 0, 0, 0, 5, 5, 3, 'NONE', 359.53, 85.6, 1697, -1904.08, 13.538, 176.434, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 11.2665, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(312, 422, 173, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-14052', 946.37, 100, 2515.9, -1520.88, 23.9867, 180.317, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18648, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(315, 586, 184, 4, 1, 3569, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 99.83, 1876.39, -1755.81, 12.9047, 265.483, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(316, 568, 19, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-65376', 1618.19, 63.68, 1054.9, -638.275, 119.932, 313.716, 0, 0, 0, 0, 2, 1662995868, 0, 0, 0, 0, 1, 3, 2, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 21.2388, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(317, 525, 19, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-55182', 1864.65, 55.17, 1037.91, -632.254, 119.999, 103.994, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 34.8218, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(318, 586, 160, 4, 1, 3521, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 996.5, 99.93, 1821.11, -1859.62, 12.9359, 178.458, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(319, 462, 230, 4, 1, 10705, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1790.34, -1602.64, 13.1432, 70.2137, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(320, 426, 226, 1, 1, 0, 0, 0, 2, 2, 3, 'NONE', 982.2, 78.4, 2134.09, -1469.23, 23.8758, 191.527, 1048576, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 66.7608, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(322, 463, 226, 1, 1, 0, 0, 0, 2, 2, 3, 'NONE', 769, 98.82, 2044.19, -1756.31, 12.9243, 264.769, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.5095, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(323, 468, 217, 1, 1, 0, 0, 0, 3, 0, 3, 'NONE', 1000, 93.29, 1697.2, -1970.65, 8.4937, 272.853, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 3.6373, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(324, 499, 217, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 661.11, 90.03, 1697.31, -1938.73, 13.5391, 179.478, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 24.1874, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(325, 562, 2, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 996.13, 98.75, 1356.14, -1565.55, 13.2179, 256.7, 0, 131072, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.8116, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(326, 525, 225, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 998.98, 93.04, 1720.17, -1601.43, 13.4168, 265.685, 1048576, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 5.0163, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(328, 468, 220, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 899, 100, 261.132, -1372.22, 52.7785, 132.686, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(329, 462, 240, 4, 1, 2374, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 995.73, 98.08, 1786.56, -1930.93, 12.9807, 178.317, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(330, 422, 235, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 999.82, 96.39, 209.929, -1617.33, 14.5227, 30.8496, 16777216, 512, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 2.6475, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(331, 422, 204, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 96.9492, -1132.39, -0.2754, 284.737, 0, 0, 0, 0, 2, 1662912900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(335, 521, 72, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 954.18, 98.91, 22.9684, -224.48, 1.9629, 202.146, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 1.0375, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(336, 560, 7, 1, 1, 0, 0, 0, 5, 2, 3, 'NONE', 1000, 96.48, -426.31, -377.789, 14.7097, 270.809, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.9601, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(337, 462, 202, 4, 1, 3541, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 958.18, 97.65, 1104.1, 1615.22, 12.1458, 22.0216, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(338, 522, 11, 1, 1, 0, 0, 0, 11, 11, 3, 'Plutarco', 14224, 37.4, 2287.25, -1680.67, 13.703, 159.237, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 38.0758, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(341, 462, 38, 4, 1, 5678, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 954, 94.51, 1797.34, -1934.45, 12.9839, 57.7733, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(342, 579, 193, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 741.58, 83.73, 198.076, -207.973, 1.3827, 278.375, 17825792, 512, 0, 0, 2, 1662914273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 95.4077, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(343, 560, 46, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 548.431, 288.637, 16.6063, 339.899, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(344, 560, 46, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 902.38, 70, 1954.16, -2005.99, 13.2517, 180.143, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 16.9836, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(345, 579, 46, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 557.298, 299.44, 17.7386, 293.304, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(346, 560, 23, 1, 1, 0, 0, 0, 0, 0, 3, 'LIMITED', 2000, 99.2, 1986.36, -1736.77, 15.6461, 266.774, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 3, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.2680, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(347, 463, 195, 1, 3, 0, 0, 0, 1, 1, 3, 'LS-10536', 655.6, 76.37, 270.908, -80.6513, 1.0941, 15.5241, 0, 0, 0, 0, 2, 1663019072, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 47.9766, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(348, 580, 195, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 938.55, 86.89, -53.9055, -225.075, 5.2258, 85.0056, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 9.2529, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(350, 451, 11, 1, 1, 0, 0, 0, 7, 7, 3, 'PLUTAR', 1000, 99.48, 2136.16, -1356.61, 25.2448, 179.232, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.1071, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(351, 507, 254, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 952.74, 98.49, 1357.96, -1564.51, 13.3854, 270.179, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 1.3043, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(352, 543, 219, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 848.94, 92.44, 2133.06, -1474.82, 23.6161, 199.333, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 4.4077, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(353, 462, 259, 4, 1, 6957, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 975.88, 98.98, 943.614, -1328.57, 12.967, 189.572, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(355, 543, 193, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 833.38, 85.38, 561.416, -1284.99, 17.0839, 191.251, 36700193, 50332162, 5, 0, 1, 1662998580, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 9.9916, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(356, 462, 57, 4, 1, 1069, 0, 6003, 12, 12, 3, '{6B8E23}RENTAL', 960.77, 92.33, 1295.71, -1799.94, 12.9791, 180.793, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(357, 462, 157, 4, 1, 778, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 948, 100, 2086.37, -1819.9, 12.9893, 345.558, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(359, 558, 239, 1, 1, 0, 0, 0, 1, 1, 0, 'LS-41805', 450.55, 63.98, 2319.56, -1709.78, 13.1783, 182.031, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 29.8369, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(360, 504, 15, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 989.17, 90.68, 269.387, -118.561, 2.666, 209.648, 0, 67371008, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 5.7579, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(361, 531, 19, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 854.09, 90.43, 1040.88, -639.28, 120.075, 156.553, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 9.4826, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(362, 521, 23, 1, 1, 0, 0, 0, 3, 3, 3, 'Ultimate', 927.55, 89.83, 1961.49, -1732.75, 15.5339, 135.646, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 7.7887, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(364, 462, 117, 4, 1, 2589, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 955.33, 98.31, 2149.47, -1744.45, 13.1382, 280.072, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(367, 522, 172, 1, 1, 0, 0, 0, 0, 155, 3, 'LS-65252', 713.33, 90.31, 955.513, -1748.54, 13.11, 184.15, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 3, 2, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 5.6522, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(368, 451, 172, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-81227', 1000, 99.98, 967.565, -1746.61, 13.2526, 359.166, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18652, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0197, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(369, 470, 172, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 876.28, 99.97, 964.075, -1746.14, 13.5389, 357.198, 0, 0, 0, 0, 2, 1662942959, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(370, 560, 119, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 987.9, 96.05, 783.887, -1412.04, 13.2289, 269.82, 1048592, 0, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.3183, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(371, 506, 268, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 633.82, 88.77, 2543.83, -1490.57, 23.732, 57.8536, 3211282, 33685504, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 7.3812, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(376, 426, 271, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 954.66, 65.62, 2367.38, -1727.03, 13.0186, 91.0742, 35651616, 33686016, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 18.8887, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(377, 560, 217, 1, 1, 0, 0, 0, 79, 0, 3, 'LS-24141', 1000, 85.72, 1691.63, -1963.24, 7.9581, 180.49, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 3, 0, 950, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 9.6519, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(379, 560, 35, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 1098.22, -1775.58, 13.04, 90.4, 0, 0, 0, 0, 2, 1662956477, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(380, 560, 101, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 994.86, 78.16, 1782, -1904.34, 13.0955, 174.977, 0, 0, 0, 0, 2, 1663090071, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 12.4679, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(381, 525, 116, 1, 1, 0, 0, 0, 113, 113, 3, 'LS-40723', 886.62, 81.02, 2520.51, -1520.18, 23.8663, 178.177, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 14.8947, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(387, 499, 267, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 996.52, 90.28, 2425.71, -1508.45, 23.9455, 20.8668, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 6.5878, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(388, 560, 267, 1, 1, 0, 0, 0, 1, 1, 3, 'LS-28222', 987.83, 83.43, 2539.63, -1522.3, 23.7056, 358.248, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 10.8170, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(389, 586, 174, 4, 1, 6274, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 723.28, 100, 94.3473, -1830.34, 2.0298, 95.7249, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(390, 409, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 1', 1000, 100, 1480, -1841.72, 13.5469, 358.859, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(391, 421, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 2', 1000, 100, 1483.51, -1841.6, 13.5469, 358.403, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(392, 421, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 3', 1000, 100, 1476.53, -1841.59, 13.5469, 0.3769, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(394, 405, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 4', 1000, 100, 1472.95, -1841.64, 13.5469, 358.973, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(396, 405, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 6', 1000, 100, 1487.26, -1841.72, 13.5469, 359.383, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(398, 405, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 5', 1000, 100, 1480, -1830.07, 13.5469, 89.3873, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(399, 586, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 7', 1000, 100, 1471.23, -1833.25, 13.5469, 1.4184, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(400, 586, 4, 2, 1, 0, 0, 0, 1, 1, 3, 'SAGS 8', 1000, 100, 1489.64, -1833.56, 13.5469, 358.027, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(402, 462, 289, 4, 1, 8314, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 283, 94.01, 569.616, -1291.37, 16.8325, 232.789, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(403, 468, 247, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 940.21, 99.47, 1456.58, -1465.48, 13.0098, 188.976, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 1, 0, 0, 0, 0, 0.4302, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(404, 586, 290, 4, 1, 5964, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 580.07, 94.94, 1843.32, -1932.31, 12.899, 251.595, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(406, 560, 38, 1, 3, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, -387.96, -1691.22, 19.8321, 7.1862, 0, 0, 0, 0, 2, 1662983252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(407, 521, 38, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 1397.96, -1831.54, 12.8967, 154.421, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(408, 499, 38, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 1398.16, -1834.12, 13.7444, 161.017, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(409, 560, 247, 1, 1, 0, 0, 0, 11, 1, 3, 'NONE', 945.87, 99.96, 1834.95, -1871.17, 13.0927, 183.668, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0015, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(412, 560, 116, 1, 1, 0, 0, 0, 228, 228, 1, 'LS-54672', 840.68, 88.44, 2516.3, -1519.92, 23.7061, 179.867, 0, 0, 0, 0, 2, 1663013296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 6.4726, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(413, 499, 77, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 840.55, 98.68, 1081.42, -1776.31, 13.4376, 204.611, 18874400, 33554946, 4, 0, 3, 1663089048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1.2309, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(414, 509, 293, 4, 1, 3391, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1831.26, -1848.43, 13.0904, 4.4607, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(415, 586, 294, 4, 1, 2503, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 996.57, 100, 2164.1, -1499.33, 23.483, 294.693, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(416, 509, 295, 4, 1, 638, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 997.86, 100, 1784.26, -1906.06, 12.9223, 176.616, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(417, 509, 176, 4, 1, 10279, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 998.39, 100, 613.88, -1395.92, 12.9111, 171.2, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(418, 541, 12, 1, 1, 0, 0, 0, 1, 0, 3, 'NONE', 306.66, 1.27, 322.496, -1765.99, 4.2336, 179.534, 0, 0, 0, 0, 1, 1663171790, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 58.1292, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(420, 461, 105, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 960.43, 71.92, 728.096, -996.175, 52.3116, 252.001, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 1, 0, 0, 0, 0, 0, 20.2115, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(421, 560, 88, 1, 1, 0, 0, 0, 26, 26, 2, 'NONE', 911.5, 97.83, 854.766, -1512.96, 12.8802, 86.5706, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18651, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.1899, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(422, 559, 88, 1, 1, 0, 0, 0, 25, 25, 3, 'NONE', 996.81, 95.98, 852.769, -1527.99, 12.682, 86.9764, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18651, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.1036, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(423, 541, 88, 1, 1, 0, 0, 0, 6, 13, 3, 'NONE', 1052.21, 42.41, 382.754, -69.8706, 2.726, 177.07, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 1, 0, 0, 0, 18651, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 57.5217, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(424, 586, 296, 4, 1, 3184, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 723.49, 100, 1847.5, -1860.92, 13.1035, 272.197, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(425, 586, 291, 4, 1, 7442, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 99.49, 576.927, -1244.16, 17.146, 128.906, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(426, 411, 88, 1, 1, 0, 0, 0, 6, 4, 3, 'NONE', 761.64, 94.18, 854.275, -1520.43, 13.2816, 84.719, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18651, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.8182, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(427, 586, 298, 4, 1, 5367, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 621.18, 100, 1789.37, -1909.47, 12.9159, 0.5262, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(428, 468, 297, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-28627', 887.31, 99.98, 1536.95, -1678.8, 13.0517, 173.82, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(429, 586, 302, 4, 1, 7000, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 2134, -1478.43, 23.1399, 171.085, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(430, 586, 303, 4, 1, 3014, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1822.8, -1621.62, 12.8997, 344.881, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(431, 509, 306, 4, 1, 10026, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1691.93, -1529.58, 13.0588, 357.048, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(432, 468, 305, 1, 1, 0, 0, 0, 9, 9, 3, 'NONE', 1000, 99.86, 1775.74, -1907.65, 13.0436, 189.445, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0430, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(433, 560, 305, 1, 1, 0, 0, 0, 9, 9, 3, 'NONE', 286, 91.63, 641.156, -1349.83, 13.1487, 326.626, 52428834, 67371524, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 5.5411, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(434, 499, 305, 1, 1, 0, 0, 0, 9, 9, 3, 'NONE', 963.42, 99.95, 1781.04, -1888.98, 13.3846, 2.6203, 1048576, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0452, 100.0000, 0.0000, 1, 0, 0, 0, 0, -1),
(435, 509, 309, 4, 1, 8984, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1807.06, -1896.92, 12.918, 164.663, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(436, 426, 106, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 887.06, 83.94, -381.307, -1453.35, 25.4698, 176.309, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 9.5562, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(438, 531, 241, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 1985.53, -1988.55, 13.5468, 84.9042, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(440, 560, 311, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 812, 79.27, 225.853, -39.0029, 1.2834, 358.402, 3145778, 131072, 5, 0, 1, 1663067885, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 10.5059, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(441, 463, 311, 1, 3, 0, 0, 0, 0, 0, 3, 'NONE', 993.32, 96.92, 831.704, -147.992, 10.6894, 183.612, 0, 0, 0, 0, 2, 1663084218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 2.7593, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(442, 586, 316, 4, 1, 1665, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 848.68, 90.54, 1182.41, -1306.04, 13.2105, 88.0148, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(443, 560, 312, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 100, 2143.37, -1726.41, 13.4559, 21.2914, 0, 0, 0, 0, 2, 1663008607, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(445, 509, 322, 4, 1, 10282, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 984.29, 100, -89.4733, -1174.4, 1.8633, 296.393, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(447, 586, 330, 4, 1, 7116, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 358.76, -1771.61, 4.78, 99.2879, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(448, 543, 58, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 79.86, 263.583, -35.4643, 1.4733, 266.763, 0, 0, 0, 0, 2, 1663241628, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 13.2686, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(449, 560, 331, 1, 1, 0, 0, 0, 126, 126, 3, 'NONE', 541.68, 97.42, 1908.23, -1875.77, 13.2402, 178.264, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.6986, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(450, 542, 331, 1, 1, 0, 0, 0, 126, 126, 3, 'LS-26086', 963.85, 100, 1912.73, -1873.68, 13.2858, 180.204, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(451, 562, 29, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 494.2, 99.56, 1103.47, -731.867, 101.005, 91.9014, 0, 0, 0, 0, 2, 1663152953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.2675, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(452, 521, 327, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 898.68, 83.71, 255.674, -76.0323, 0.9981, 84.496, 0, 0, 0, 0, 2, 1663063542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 10.3648, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(454, 560, 335, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 1841.38, -1914.51, 14.755, 188.847, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(455, 521, 335, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 970.92, 94.59, 1785.78, -1907.6, 12.9621, 179.556, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 3.5353, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(456, 579, 335, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 1836.81, -1914.91, 14.9465, 185.788, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(457, 415, 23, 1, 1, 0, 0, 0, 6, 6, 3, 'NONE', 1000, 99.28, 1956.51, -1718.99, 15.7214, 359.667, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0329, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(459, 586, 337, 4, 1, 2745, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 689.44, 93.53, 656.462, -545.476, 15.8229, 276.52, 0, 0, 0, 1, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(462, 468, 10, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 719.97, 91.27, 2337.8, -2315.75, 13.2165, 309.853, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 5.9843, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(463, 586, 10, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.97, 816.008, -1412.67, 13.0625, 73.6735, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0263, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(465, 586, 207, 4, 1, 3496, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 821.34, 100, 1114.47, -1187.39, 17.8588, 274.466, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(466, 426, 340, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 902.22, 92.19, 1186.63, -1325.61, 13.324, 12.9165, 34603024, 33554944, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 4.9837, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(467, 521, 340, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 967.13, 94.9, 2096.73, -1360.48, 23.5472, 0.6947, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 3.3673, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(468, 509, 338, 4, 1, 10661, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1490.27, -1739.53, 13.0589, 88.0598, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(470, 415, 49, 1, 1, 0, 0, 0, 150, 0, 3, 'LS-88247', 776.17, 61.42, 1110.84, -1330.84, 12.8636, 3.2815, 0, 0, 0, 0, 2, 1663075423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 19.1884, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(472, 509, 328, 4, 1, 1748, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 974.24, 100, 548.414, -1280.54, 16.7609, 149.538, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(473, 509, 343, 4, 1, 2592, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 2135.09, -1477.07, 23.4671, 233.662, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(474, 509, 347, 4, 1, 7101, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 910.166, -1768.91, 12.8949, 80.2124, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(476, 509, 327, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 997, 100, 267.02, -57.6753, 2.3316, 280.361, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(477, 509, 353, 4, 1, 9644, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1793.47, -1887.84, 12.8175, 44.7412, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(479, 586, 354, 4, 1, 2966, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 972.48, 100, 241.811, -79.3121, 1.0983, 176.78, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(480, 509, 360, 4, 1, 1194, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 986.51, 100, 2124.75, -1454.09, 23.5085, 157.189, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(481, 560, 9, 2, 1, 0, 0, 0, 0, 0, 3, 'X3', 1000, 100, 2601.75, -1249.57, 47.704, 261.97, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(482, 566, 9, 2, 1, 0, 0, 0, 0, 0, 3, 'X2', 1000, 100, 2593.46, -1249.47, 47.079, 273.709, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(483, 509, 359, 4, 1, 3088, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1488.18, -1744.24, 13.0577, 112.681, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(484, 543, 265, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 991.92, 96.2, 274.935, -34.7733, 1.4987, 269.53, 2097168, 0, 4, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 2.6886, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(485, 509, 306, 4, 1, 6106, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1365.52, -1874.13, 12.7279, 11.2348, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(486, 462, 361, 4, 1, 3217, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 970.14, 97.78, 87.0269, -1548.68, 5.4627, 251.71, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(487, 586, 357, 4, 1, 911, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 754.71, 100, 1458.07, -1746.07, 13.0663, 208.394, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(489, 509, 365, 4, 1, 2011, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 986.53, 100, 1898.36, -1755.43, 12.7157, 229.969, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(490, 560, 67, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 98.24, 1656.36, -1823.71, 13.2511, 89.9544, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.0815, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(491, 522, 67, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 22269.6, 69.89, 2362.91, -2009.86, 13.0987, 271.946, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 16.8097, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(492, 411, 67, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 93.54, 1655.68, -1832.3, 13.1092, 96.7019, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 18647, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 4.6977, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(493, 462, 368, 4, 1, 2281, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 802.16, 100, 402.687, -1701.46, 8.3828, 281.154, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(494, 462, 369, 4, 1, 10661, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 963.74, 98.24, 1224.39, -1855.66, 12.9806, 268.28, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(495, 531, 220, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 928, 99.98, 218.827, -127.056, 1.5428, 79.656, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0013, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(496, 531, 62, 1, 3, 0, 0, 0, 1, 1, 3, 'NONE', 887, 95.04, 246.643, -54.1194, 1.5428, 87.1329, 0, 67371008, 0, 0, 2, 1663164801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 5.3235, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(497, 586, 372, 4, 1, 7193, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1804.08, -1899.34, 12.9211, 82.8854, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(499, 509, 373, 4, 1, 3600, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 809.633, -1335.03, 13.547, 270.39, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(500, 562, 5, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 99.17, 838.007, -1340.26, 6.8302, 73.2154, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.6231, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(501, 554, 17, 1, 1, 0, 0, 0, 0, 0, 3, 'LS-17655', 788.26, 96.6, 1027.83, -811.084, 101.937, 199.95, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 1.9522, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(502, 499, 371, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-65846', 997.23, 92.7, 2189.36, -1755.91, 13.4101, 344.913, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 5.8119, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(503, 515, 371, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 99.95, 2781.87, -1840.07, 10.8144, 25.5072, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0476, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(504, 463, 371, 1, 1, 0, 0, 0, 3, 3, 3, 'LS-10308', 793, 89.16, 2785.74, -1835.3, 9.3583, 48.6976, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 8.5755, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(505, 586, 376, 4, 1, 2981, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 814.49, 94.42, 2180.35, -1724.06, 12.9419, 345.503, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(506, 586, 377, 4, 1, 2934, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 970.23, 95.71, 1783.29, -1928.75, 12.9079, 234.46, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(508, 586, 378, 4, 1, 3577, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 99.97, 1669.53, -2319.54, 12.9026, 12.6678, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(510, 473, 54, 4, 1, 3804, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 17.2275, -1966.48, -0.3444, 275.233, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(512, 560, 327, 1, 1, 0, 0, 0, 0, 0, 3, 'NONE', 1000, 100, 278.632, -56.3195, 1.2827, 355.758, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(514, 560, 31, 1, 1, 0, 0, 0, 155, 155, 3, 'LS-26208', 674.32, 68.83, 585.063, -1238.19, 17.4381, 119.667, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 20.9675, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(515, 586, 382, 4, 1, 3312, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 949.83, 96.82, 1932.13, -1771.89, 12.8944, 15.332, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(516, 422, 239, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 995.84, 85.8, 2319.24, -1717.04, 13.5374, 183.228, 0, 0, 0, 0, 2, 1663129261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 12.2767, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(517, 586, 381, 4, 1, 1156, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 638.46, 100, 1702.89, -1517, 12.9028, 204.793, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(518, 509, 383, 4, 1, 2705, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 909.065, -1229.09, 16.483, 94.6296, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(519, 586, 379, 4, 1, 1018, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 636.72, 100, 1784.64, -1899.15, 12.9129, 359.93, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(520, 586, 385, 4, 1, 2760, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 754, 94.73, 2125.42, -1810.18, 13.0746, 176.171, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(522, 586, 386, 4, 1, 3570, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 775.986, -1337.61, 13.0742, 132.977, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(523, 586, 389, 4, 1, 2998, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 931.54, 97.57, 2297.17, -2372.38, 13.0464, 298.042, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(525, 422, 71, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 983, 88.52, 1657.35, -1814.2, 13.5284, 263.48, 16777216, 512, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 7.6539, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(526, 586, 391, 4, 1, 2882, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 798.65, 100, 1691.19, -1523.06, 13.0736, 342.48, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(528, 420, 133, 1, 1, 0, 0, 0, 5, 5, 3, 'NONE', 896.2, 97.42, 236.037, -1381.14, 52.8768, 35.6042, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 2.2904, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(529, 415, 340, 1, 1, 0, 0, 0, 6, 0, 3, 'NONE', 657, 72.49, 548.209, -1266.47, 17.0178, 34.3244, 19988513, 33554946, 5, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 14.5670, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(530, 455, 64, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 1000, 99.99, 608.813, 858.359, -42.4771, 211.499, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(531, 560, 17, 1, 1, 0, 0, 0, 126, 126, 3, 'LS-43071', 923.94, 95.33, 1031.97, -805.255, 101.553, 199.466, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 3.3259, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(532, 462, 395, 4, 1, 3167, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 980.99, 95.4, 2444.34, -2092.01, 13.1448, 89.4749, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(533, 509, 396, 4, 1, 3279, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 999.81, 100, 593.144, -1248.3, 17.6728, 187.212, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(534, 453, 71, 4, 1, 7245, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 942.83, 99.64, 128.926, -1929.55, -0.3652, 5.8937, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(536, 586, 400, 4, 1, 3309, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 996.77, 98.21, 1163.99, -1387.57, 13.1877, 274.411, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(537, 462, 401, 4, 1, 3265, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 928.73, 97, 288.633, -66.2916, 1.131, 95.467, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(538, 543, 175, 1, 1, 0, 0, 0, 43, 43, 3, 'NONE', 597.1, 90.17, 2534.27, -1552.7, 23.7661, 98.2237, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 6.6732, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(539, 462, 393, 4, 1, 875, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 872.2, 94.29, 1176.79, -1324.92, 14.4553, 77.4513, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(542, 525, 108, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 942.53, 99.22, 2516.37, -1520.2, 23.8777, 182.205, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.6988, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(543, 462, 406, 4, 1, 6853, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 937.99, 100, 1469.38, -1744, 13.1419, 253.416, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(544, 543, 65, 1, 3, 0, 0, 0, 1, 1, 3, 'LS-86221', 1000, 94.48, 1839.34, -1859.28, 13.1463, 66.7564, 0, 0, 0, 0, 2, 1663164101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 4.1957, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(545, 586, 407, 4, 1, 2840, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 880.66, 95.28, 930.859, -1729.16, 13.2505, 161.186, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(546, 586, 409, 4, 1, 6746, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 930.7, 94, 221.111, -118.752, 1.1905, 184.099, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(547, 531, 194, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 821.34, 99.95, -334.229, -1389.6, 13.5298, 84.3292, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0005, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(548, 586, 412, 4, 1, 3382, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 883.81, 98.29, 1570.54, -1764.53, 12.9015, 338.963, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(550, 462, 413, 4, 1, 3490, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 99.08, 1541.35, -2129.13, 14.1954, 280.472, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(551, 586, 417, 4, 1, 3600, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1681.08, -1650.64, 13.0668, 178.484, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(552, 525, 105, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 554.3, 93.69, -395.821, -1452.3, 25.551, 13.7579, 3276802, 33554434, 1, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 3.8124, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(553, 586, 422, 4, 1, 3600, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1182.83, -1324.69, 13.0945, 42.6161, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(554, 586, 423, 4, 1, 3600, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1804.09, -1899.13, 12.9056, 83.7552, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(555, 462, 428, 4, 1, 3111, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 993.01, 98.02, 1943.59, -1727.58, 12.9807, 337.516, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(558, 543, 177, 1, 1, 0, 0, 0, 1, 1, 3, 'NONE', 994.52, 99.98, 993.487, -1357.56, 13.169, 177.944, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(559, 586, 429, 4, 1, 341, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 981.94, 100, 1808.66, -1893.78, 12.92, 169.336, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(560, 462, 24, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 2406.35, -1724.69, 13.2164, 270.244, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(561, 426, 24, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 2412.57, -1723.71, 13.4336, 295.242, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(562, 531, 24, 1, 1, 0, 0, 0, 3, 3, 3, 'NONE', 1000, 100, 2416.27, -1718.01, 13.7177, 354.135, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1),
(563, 462, 431, 4, 1, 10800, 0, 0, 12, 12, 3, '{6B8E23}RENTAL', 1000, 100, 1952.96, -1984.15, 13.1453, 70.2662, 0, 0, 0, 0, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0.0000, 100.0000, 0.0000, 0, 0, 0, 0, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `sidejob_boxville_configs`
--

CREATE TABLE `sidejob_boxville_configs` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `base_salary` int(11) NOT NULL DEFAULT 100,
  `bonus_chance` float(6,2) NOT NULL DEFAULT 100.00,
  `bonus_minimum` int(11) NOT NULL DEFAULT 100,
  `bonus_maximum` int(11) NOT NULL DEFAULT 200,
  `exit_delay` int(11) NOT NULL DEFAULT 300,
  `fail_delay` int(11) NOT NULL DEFAULT 600,
  `success_delay` int(11) NOT NULL DEFAULT 1800,
  `earn_per_house` int(11) NOT NULL DEFAULT 10,
  `max_houses_delivered` int(11) NOT NULL DEFAULT 10,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sidejob_boxville_configs`
--

INSERT INTO `sidejob_boxville_configs` (`id`, `enabled`, `base_salary`, `bonus_chance`, `bonus_minimum`, `bonus_maximum`, `exit_delay`, `fail_delay`, `success_delay`, `earn_per_house`, `max_houses_delivered`, `created_at`, `updated_at`) VALUES
(2, 1, 100, 50.00, 10, 50, 300, 600, 1200, 5, 20, 0, 1662829283);

-- --------------------------------------------------------

--
-- Table structure for table `sidejob_bus_driver_configs`
--

CREATE TABLE `sidejob_bus_driver_configs` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `base_salary` int(11) NOT NULL DEFAULT 100,
  `bonus_chance` float(6,2) NOT NULL DEFAULT 100.00,
  `bonus_minimum` int(11) NOT NULL DEFAULT 100,
  `bonus_maximum` int(11) NOT NULL DEFAULT 200,
  `exit_delay` int(11) NOT NULL DEFAULT 300,
  `fail_delay` int(11) NOT NULL DEFAULT 600,
  `success_delay` int(11) NOT NULL DEFAULT 1800,
  `minimum_health` float(8,2) NOT NULL DEFAULT 0.00,
  `max_speed` float(8,2) NOT NULL DEFAULT 100.00,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sidejob_bus_driver_configs`
--

INSERT INTO `sidejob_bus_driver_configs` (`id`, `enabled`, `base_salary`, `bonus_chance`, `bonus_minimum`, `bonus_maximum`, `exit_delay`, `fail_delay`, `success_delay`, `minimum_health`, `max_speed`, `created_at`, `updated_at`) VALUES
(2, 1, 500, 100.00, 100, 200, 300, 600, 1200, 600.00, 80.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sidejob_money_transporter_configs`
--

CREATE TABLE `sidejob_money_transporter_configs` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `base_salary` int(11) NOT NULL DEFAULT 100,
  `bonus_chance` float(6,2) NOT NULL DEFAULT 100.00,
  `bonus_minimum` int(11) NOT NULL DEFAULT 100,
  `bonus_maximum` int(11) NOT NULL DEFAULT 200,
  `exit_delay` int(11) NOT NULL DEFAULT 300,
  `fail_delay` int(11) NOT NULL DEFAULT 600,
  `success_delay` int(11) NOT NULL DEFAULT 1800,
  `max_atm_cash` int(11) NOT NULL DEFAULT 10,
  `max_van_cash` int(11) NOT NULL DEFAULT 10,
  `deposit_cash_rate` float(9,3) NOT NULL DEFAULT 2.000,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sidejob_money_transporter_configs`
--

INSERT INTO `sidejob_money_transporter_configs` (`id`, `enabled`, `base_salary`, `bonus_chance`, `bonus_minimum`, `bonus_maximum`, `exit_delay`, `fail_delay`, `success_delay`, `max_atm_cash`, `max_van_cash`, `deposit_cash_rate`, `created_at`, `updated_at`) VALUES
(2, 1, 500, 100.00, 100, 200, 300, 600, 1200, 25000, 50000, 0.000, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sidejob_sweeper_configs`
--

CREATE TABLE `sidejob_sweeper_configs` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `base_salary` int(11) NOT NULL DEFAULT 100,
  `bonus_chance` float(6,2) NOT NULL DEFAULT 100.00,
  `bonus_minimum` int(11) NOT NULL DEFAULT 100,
  `bonus_maximum` int(11) NOT NULL DEFAULT 200,
  `exit_delay` int(11) NOT NULL DEFAULT 300,
  `fail_delay` int(11) NOT NULL DEFAULT 600,
  `success_delay` int(11) NOT NULL DEFAULT 1800,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sidejob_sweeper_configs`
--

INSERT INTO `sidejob_sweeper_configs` (`id`, `enabled`, `base_salary`, `bonus_chance`, `bonus_minimum`, `bonus_maximum`, `exit_delay`, `fail_delay`, `success_delay`, `created_at`, `updated_at`) VALUES
(2, 1, 500, 100.00, 100, 200, 300, 600, 1200, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sidejob_trashmaster_configs`
--

CREATE TABLE `sidejob_trashmaster_configs` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `base_salary` int(11) NOT NULL DEFAULT 100,
  `bonus_chance` float(6,2) NOT NULL DEFAULT 100.00,
  `bonus_minimum` int(11) NOT NULL DEFAULT 100,
  `bonus_maximum` int(11) NOT NULL DEFAULT 200,
  `exit_delay` int(11) NOT NULL DEFAULT 300,
  `fail_delay` int(11) NOT NULL DEFAULT 600,
  `success_delay` int(11) NOT NULL DEFAULT 1800,
  `earn_per_trash` int(11) NOT NULL DEFAULT 10,
  `max_trashes` int(11) NOT NULL DEFAULT 10,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sidejob_trashmaster_configs`
--

INSERT INTO `sidejob_trashmaster_configs` (`id`, `enabled`, `base_salary`, `bonus_chance`, `bonus_minimum`, `bonus_maximum`, `exit_delay`, `fail_delay`, `success_delay`, `earn_per_trash`, `max_trashes`, `created_at`, `updated_at`) VALUES
(2, 1, 500, 100.00, 100, 200, 300, 600, 1200, 5, 100, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `speedcameras`
--

CREATE TABLE `speedcameras` (
  `speedID` int(12) NOT NULL,
  `speedRange` float DEFAULT 0,
  `speedLimit` float DEFAULT 0,
  `speedX` float DEFAULT 0,
  `speedY` float DEFAULT 0,
  `speedZ` float DEFAULT 0,
  `speedAngle` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `submitted_quizes`
--

CREATE TABLE `submitted_quizes` (
  `id` int(11) NOT NULL,
  `session_id` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'draft',
  `account` int(11) NOT NULL,
  `reviewer` int(11) DEFAULT NULL,
  `reason` text CHARACTER SET utf8mb4 DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `submitted_quiz_questions`
--

CREATE TABLE `submitted_quiz_questions` (
  `id` int(11) NOT NULL,
  `session_id` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
  `question` text CHARACTER SET utf8mb4 NOT NULL,
  `answer` text CHARACTER SET utf8mb4 DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tagId` int(11) NOT NULL,
  `tagText` varchar(65) NOT NULL,
  `tagFont` varchar(24) NOT NULL,
  `tagCreated` varchar(24) NOT NULL,
  `tagColor` int(10) UNSIGNED NOT NULL,
  `tagFontsize` int(10) UNSIGNED NOT NULL,
  `tagBold` int(10) UNSIGNED NOT NULL,
  `tagOwner` int(10) UNSIGNED NOT NULL,
  `tagPosx` float NOT NULL,
  `tagPosy` float NOT NULL,
  `tagPosz` float NOT NULL,
  `tagRotx` float NOT NULL,
  `tagRoty` float NOT NULL,
  `tagRotz` float NOT NULL,
  `tagExpired` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ID` int(12) DEFAULT 0,
  `ticketID` int(12) NOT NULL,
  `ticketFee` int(12) DEFAULT 0,
  `ticketIssuer` varchar(24) DEFAULT NULL,
  `ticketDate` varchar(36) DEFAULT NULL,
  `ticketReason` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`ID`, `ticketID`, `ticketFee`, `ticketIssuer`, `ticketDate`, `ticketReason`) VALUES
(180, 1, 950, 'Jackson Alexander', '11 September 2022, 03:32:40', 'P1.A,B P2.A'),
(157, 2, 250, 'Jack Yaguna', '11 September 2022, 03:44:54', 'ugal ugalan'),
(19, 4, 650, 'Jackson Alexander', '11 September 2022, 09:55:55', 'Tidak mempunyai plate dan parkir sembarangan di area ASGH.'),
(12, 11, 500, 'Antonio Ramorez', '14 September 2022, 16:39:21', 'tidak mempunyai plate dan parkir sembarangan');

-- --------------------------------------------------------

--
-- Table structure for table `underground`
--

CREATE TABLE `underground` (
  `id` int(11) NOT NULL,
  `enterX` float NOT NULL,
  `enterY` float NOT NULL,
  `enterZ` float NOT NULL,
  `exitX` float NOT NULL,
  `exitY` float NOT NULL,
  `exitZ` float NOT NULL,
  `exitRZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehiclekeys`
--

CREATE TABLE `vehiclekeys` (
  `ID` int(10) NOT NULL,
  `playerID` int(50) NOT NULL DEFAULT -1,
  `vehicleID` int(50) NOT NULL DEFAULT -1,
  `vehicleModel` int(11) NOT NULL DEFAULT 0,
  `vehicleKeyExists` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehiclekeys`
--

INSERT INTO `vehiclekeys` (`ID`, `playerID`, `vehicleID`, `vehicleModel`, `vehicleKeyExists`) VALUES
(1, 64, 161, 463, 1),
(2, 13, 231, 579, 1),
(3, 193, 295, 525, 1),
(4, 219, 260, 463, 1),
(5, 225, 252, 525, 1),
(6, 221, 170, 422, 1),
(7, 14, 342, 579, 1),
(8, 17, 173, 545, 1),
(9, 16, 169, 560, 1),
(10, 299, 250, 492, 1),
(11, 36, 250, 492, 1),
(12, 255, 119, 560, 1),
(13, 46, 252, 525, 1),
(14, 46, 326, 525, 1),
(15, 17, 433, 560, 1),
(16, 311, 229, 554, 1),
(17, 17, 171, 560, 1),
(18, 17, 218, 560, 1),
(19, 192, 234, 426, 1),
(20, 139, 172, 477, 1),
(21, 5, 171, 560, 1),
(22, 108, 133, 560, 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_cargo`
--

CREATE TABLE `vehicle_cargo` (
  `id` int(11) NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `product` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `vehicle_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_components`
--

CREATE TABLE `vehicle_components` (
  `componentid` smallint(4) UNSIGNED NOT NULL,
  `part` enum('Exhausts','Front Bullbar','Front Bumper','Hood','Lamps','Misc','Rear Bullbar','Rear Bumper','Roof','Side Skirts','Spoilers','Vents','Wheels','Hydraulics') DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `cars` smallint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_mod`
--

CREATE TABLE `vehicle_mod` (
  `vehicleid` int(10) UNSIGNED NOT NULL,
  `mod0` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod1` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod2` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod3` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod4` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod5` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod6` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod7` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod8` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod9` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod10` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod11` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod12` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod13` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod14` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod15` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `mod16` smallint(4) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle_mod`
--

INSERT INTO `vehicle_mod` (`vehicleid`, `mod0`, `mod1`, `mod2`, `mod3`, `mod4`, `mod5`, `mod6`, `mod7`, `mod8`, `mod9`, `mod10`, `mod11`, `mod12`, `mod13`, `mod14`, `mod15`, `mod16`) VALUES
(119, 0, 1028, 0, 1169, 0, 0, 0, 0, 0, 0, 1141, 1032, 1026, 1139, 0, 0, 1085),
(126, 0, 1034, 0, 1171, 0, 0, 0, 0, 1010, 0, 1149, 1038, 1040, 1146, 0, 0, 1080),
(138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1003, 0, 0, 1080),
(145, 0, 1034, 0, 1172, 0, 0, 0, 0, 1010, 0, 1149, 0, 0, 1147, 0, 0, 1080),
(163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(242, 0, 1066, 0, 1173, 0, 0, 0, 0, 1010, 0, 1161, 0, 1070, 1158, 0, 0, 0),
(246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(268, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(291, 0, 1034, 0, 1171, 0, 0, 0, 0, 0, 0, 1148, 0, 0, 1146, 0, 0, 0),
(307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(316, 0, 0, 0, 0, 0, 0, 1087, 0, 1010, 0, 0, 0, 0, 0, 1086, 0, 0),
(359, 0, 1092, 0, 1166, 0, 0, 0, 0, 1010, 0, 1168, 1088, 1094, 1164, 0, 0, 1080),
(421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(426, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1080),
(514, 0, 0, 0, 1169, 0, 0, 0, 0, 0, 0, 1140, 0, 0, 1138, 0, 0, 1080);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_model_parts`
--

CREATE TABLE `vehicle_model_parts` (
  `modelid` smallint(3) UNSIGNED NOT NULL,
  `parts` bit(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_object`
--

CREATE TABLE `vehicle_object` (
  `id` int(10) UNSIGNED NOT NULL,
  `model` int(10) UNSIGNED DEFAULT NULL,
  `vehicle` int(10) UNSIGNED DEFAULT NULL,
  `color` int(24) DEFAULT NULL,
  `type` tinyint(2) UNSIGNED DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `rx` float DEFAULT NULL,
  `ry` float DEFAULT NULL,
  `rz` float DEFAULT NULL,
  `text` varchar(32) DEFAULT 'Text',
  `font` varchar(24) DEFAULT NULL,
  `fontcolor` int(10) UNSIGNED DEFAULT NULL,
  `fontsize` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle_object`
--

INSERT INTO `vehicle_object` (`id`, `model`, `vehicle`, `color`, `type`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `text`, `font`, `fontcolor`, `fontsize`) VALUES
(50, 1001, 4, 0, 1, 0.024165, -2.08227, 0.367608, 0, 0, -357.696, '', '', 0, 0),
(53, 1000, 133, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(54, 1013, 133, 6, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(55, 1019, 133, 17, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(57, 1015, 381, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(58, 1001, 381, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(59, 1003, 172, 2, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0),
(61, 1001, 312, 6, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vending`
--

CREATE TABLE `vending` (
  `vendID` int(11) NOT NULL,
  `vendInterior` int(11) NOT NULL DEFAULT 0,
  `vendWorld` int(11) NOT NULL DEFAULT 0,
  `vendName` varchar(255) NOT NULL DEFAULT 'None',
  `vendOwner` int(11) NOT NULL DEFAULT -1,
  `vendOwnerName` varchar(255) NOT NULL DEFAULT 'None',
  `vendX` float NOT NULL DEFAULT 0,
  `vendY` float NOT NULL DEFAULT 0,
  `vendZ` float NOT NULL DEFAULT 0,
  `vendA` float NOT NULL DEFAULT 0,
  `vendPrice` int(11) NOT NULL DEFAULT 999999,
  `vendType` int(11) NOT NULL DEFAULT 1,
  `vendStockPrice` int(11) NOT NULL DEFAULT 5,
  `vendStock` int(11) NOT NULL DEFAULT 0,
  `vendVault` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vending`
--

INSERT INTO `vending` (`vendID`, `vendInterior`, `vendWorld`, `vendName`, `vendOwner`, `vendOwnerName`, `vendX`, `vendY`, `vendZ`, `vendA`, `vendPrice`, `vendType`, `vendStockPrice`, `vendStock`, `vendVault`) VALUES
(1, 0, 0, 'None', 77, 'Pandu_Pangestu', 1832.86, -1849.65, 13.578, 97.166, 36, 1, 10, 882, 1171),
(2, 0, 0, 'None', 77, 'Pandu_Pangestu', 1833.17, -1851.71, 13.578, 94.194, 1, 2, 10, 9899, 1010);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendorID` int(12) NOT NULL,
  `vendorType` int(12) DEFAULT 0,
  `vendorX` float DEFAULT 0,
  `vendorY` float DEFAULT 0,
  `vendorZ` float DEFAULT 0,
  `vendorA` float DEFAULT 0,
  `vendorInterior` int(12) DEFAULT 0,
  `vendorWorld` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wanrslog`
--

CREATE TABLE `wanrslog` (
  `ID` int(10) UNSIGNED NOT NULL,
  `warnBy` varchar(24) NOT NULL,
  `warnReason` varchar(255) NOT NULL,
  `warnDate` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wanrslog`
--

INSERT INTO `wanrslog` (`ID`, `warnBy`, `warnReason`, `warnDate`) VALUES
(11, 'AnantaHere', 'Abuse', '10 September 2022, 11:58:53'),
(150, 'Godzillas', 'cheater', '10 September 2022, 18:22:27'),
(4, 'Godzillas', 'cheat surfly', '11 September 2022, 06:32:37'),
(173, 'Godzillas', 'non RP drive', '11 September 2022, 09:14:02'),
(152, 'Godzillas', 'OOC insult', '11 September 2022, 12:46:12'),
(219, 'Godzillas', 'Possible Teleport hack', '12 September 2022, 08:54:58'),
(247, 'bastian', 'Random Punch', '12 September 2022, 09:21:52'),
(294, 'Axel', 'Health Hack', '12 September 2022, 09:40:14'),
(302, 'Axel', 'Health Hacm', '12 September 2022, 09:42:28'),
(302, 'Axel', 'Health Hack', '12 September 2022, 09:42:30'),
(303, 'Rukitateki', 'Cheater Weapon Hack', '12 September 2022, 10:13:07'),
(265, 'Toyotomi', 'baca rules sebelum rob', '13 September 2022, 09:31:37'),
(36, 'Axel', 'ROB WITHOUT PD ON DUTY', '13 September 2022, 09:34:56'),
(12, 'Axel', 'Refuse RP', '13 September 2022, 10:04:52'),
(36, 'bastian', 'Death Match.', '13 September 2022, 14:00:58'),
(40, 'Axel', 'NON RP FEAR', '13 September 2022, 15:31:42'),
(385, 'bastian', 'Penyalahgunaan Senjata [ForumRe', '14 September 2022, 10:00:02'),
(12, 'Axel', 'Refuse RP', '14 September 2022, 12:54:05'),
(34, 'Rukitateki', 'Powergaming (/drag sambil bawa ', '14 September 2022, 16:41:50');

-- --------------------------------------------------------

--
-- Table structure for table `warrants`
--

CREATE TABLE `warrants` (
  `ID` int(12) NOT NULL,
  `Suspect` varchar(24) DEFAULT NULL,
  `Username` varchar(24) DEFAULT NULL,
  `Date` varchar(36) DEFAULT NULL,
  `Description` varchar(128) DEFAULT NULL,
  `Arrest` int(5) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `warrants`
--

INSERT INTO `warrants` (`ID`, `Suspect`, `Username`, `Date`, `Description`, `Arrest`) VALUES
(1, 'Ferdison_Alexander', 'Plutarco_Echeverra', '11 September 2022, 04:07:18', '(4) B. Possessing of Illegal Firearms', 1),
(2, 'Ferdison_Alexander', 'Plutarco_Echeverra', '11 September 2022, 04:08:29', '(3) B. Possessing of Marijuana (Large Amount)', 1),
(3, 'Ferdison_Alexander', 'Jackson_Alexander', '11 September 2022, 06:49:31', 'Evading From Police.', 1),
(4, 'Duncan_Victorovich', 'Vayler_Coleman', '12 September 2022, 09:45:32', 'dun', 0),
(5, 'Kudak_Deblow', 'Matsushima_Kunio', '13 September 2022, 10:48:46', '2A, 3A, 3F, 5E', 1);

-- --------------------------------------------------------

--
-- Table structure for table `weapons`
--

CREATE TABLE `weapons` (
  `WeaponID` int(11) DEFAULT NULL,
  `Ammo` int(11) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `Category` int(11) DEFAULT NULL,
  `Authority` int(10) UNSIGNED DEFAULT NULL,
  `Enable` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Day` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weaponsettings`
--

CREATE TABLE `weaponsettings` (
  `ID` int(10) NOT NULL,
  `charID` int(12) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `WeaponID` int(4) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `RotX` float NOT NULL DEFAULT 0,
  `RotY` float NOT NULL DEFAULT 0,
  `RotZ` float NOT NULL DEFAULT 0,
  `Bone` int(4) NOT NULL DEFAULT 0,
  `Hidden` int(4) NOT NULL DEFAULT 0,
  `WepExists` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weaponsettings`
--

INSERT INTO `weaponsettings` (`ID`, `charID`, `Name`, `WeaponID`, `PosX`, `PosY`, `PosZ`, `RotX`, `RotY`, `RotZ`, `Bone`, `Hidden`, `WepExists`) VALUES
(1, 11, 'Plutarco_Echeverra', 24, -0.116, 0.033, -0.21, -84.6, 1.8, 174.1, 1, 0, 1),
(2, 9, 'Oscar_Vengeance', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1, 1),
(3, 144, 'Patrick_Benjamin', 30, -0.553, -0.136, -0.024, 0, 44.5, 0, 1, 0, 1),
(4, 139, 'Andrey_Rodriguez', 30, -0.206, 0.246, -0.205, 98.6, -81.1, 1.4, 1, 0, 1),
(5, 159, 'Olmero_Estevanez', 23, -0.429, -0.073, -0.274, 93.3, 94.2, -2.2, 1, 1, 1),
(6, 25, 'Rukitateki', 30, -0.116, -0.134, -0.07, -179.7, 34.5, -7.4, 1, 0, 1),
(7, 11, 'Plutarco_Echeverra', 31, -0.116, 0.191, 0.137, 0, -172.8, 8, 1, 0, 1),
(8, 85, 'Abel_Petterson', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1, 1),
(9, 13, 'Kudak_Deblow', 30, -0.116, -0.117, -0.116, 0, 4.9, 0, 1, 0, 1),
(10, 13, 'Axel_Volter', 24, -0.119, 0.03, 0.136, 93.4, -174.5, 0, 1, 1, 1),
(11, 188, 'Marrino_Luccano', 25, -0.298, -0.092, -0.108, 13.2, 143.5, 179.7, 1, 0, 1),
(12, 58, 'George_Walsh', 25, -0.209, -0.112, 0.088, 0, 159.6, 0, 1, 0, 1),
(13, 142, 'Antonio_Ramorez', 25, -0.116, -0.12, 0.088, 0, 44.5, 0, 1, 0, 1),
(14, 142, 'Alex_Tuna', 24, -0.157, 0.073, 0.041, 0, 44.5, 0, 8, 1, 1),
(15, 18, 'Smith_Levithan', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 0, 1),
(16, 187, 'Jackson_Alexander', 25, -0.21, 0.173, 0.149, 0, 44.5, 0, 1, 0, 1),
(17, 187, 'Cody_Marshall', 24, -0.274, -0.081, -0.08, 2, 52.4, -1.5, 1, 1, 1),
(18, 16, 'Axel_Volter', 30, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 0, 1),
(19, 79, 'Smith_Levithan', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1, 1),
(20, 79, 'Howard_Barnett', 25, -0.116, -0.122, 0.088, 0, 44.5, 0, 1, 0, 1),
(21, 11, 'Plutarco_Echeverra', 34, 0.244, -0.12, 0.053, -6.2, 157.3, 14.3, 1, 0, 1),
(22, 11, 'Plutarco_Echeverra', 25, 0.241, 0.182, 0.152, 0, 158.7, 0, 1, 0, 1),
(23, 41, 'Navaro_Guillermo', 25, -0.232, -0.15, 0.166, 7.6, 44.1, 0, 1, 0, 1),
(24, 14, 'Abel_Petterson', 30, -0.286, -0.148, 0.208, -175.7, 89.7, 174.5, 1, 0, 1),
(25, 69, 'Oscar_Vengeance', 24, -0.116, 0.078, 0.088, 0, 44.5, 0, 1, 1, 1),
(26, 60, 'Daniell_Wade', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 7, 0, 1),
(27, 64, 'Kayson_Rostalve.', 24, -0.465, -0.072, -0.235, 3.7, 94.5, 86, 1, 1, 1),
(28, 126, 'Jack_Yaguna', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 0, 1),
(29, 62, 'Vittorini_Leovince', 25, 0.214, -0.164, 0.088, 21.5, 169.1, 0, 1, 0, 1),
(30, 9, 'Smith_Martin', 30, -0.226, -0.209, -0.005, 0, 28.9, 0, 1, 0, 1),
(31, 192, 'Jahmiree_Maleek', 23, 0.372, -0.156, -0.136, 27.5, -92.4, 100.6, 7, 1, 1),
(32, 226, 'Yorell_Powell', 25, -0.188, -0.08, 0.062, -10.6, -169, 5.9, 1, 0, 1),
(33, 192, 'Jahmiree_Maleek', 25, 0.375, -0.211, -0.191, -1.8, -89.4, 77.2, 7, 0, 1),
(34, 41, 'Navaro_Guillermo', 23, -0.259, 0.068, -0.22, 100.6, -176.4, -10.7, 1, 0, 1),
(35, 268, 'Elcapone_Pettyfer', 25, -0.202, -0.143, 0.14, 0, 44.5, 5.4, 1, 0, 1),
(36, 14, 'Abel_Petterson', 25, -0.277, -0.209, 0.068, -104, 86.1, 111.9, 1, 0, 1),
(37, 64, 'Synester_Vengeance', 25, -0.231, -0.233, 0.004, -1.1, 30.6, 9.6, 1, 0, 1),
(38, 142, 'Antonio_Ramorez', 29, -0.116, -0.11, 0.068, 0, 44.5, 0, 1, 0, 1),
(39, 294, 'Jahseeh_Onfroy', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 7, 1, 1),
(40, 192, 'Jahmiree_Maleek', 30, 0.352, -0.22, -0.137, 124, -94.9, -156.7, 7, 0, 1),
(41, 79, 'Howard_Barnett', 33, -2.346, -0.074, 0.011, 0, 10, 1.6, 1, 0, 1),
(42, 311, 'Ronald_Christopher', 30, -0.093, -0.148, 0.088, 8, 54, 3.6, 1, 0, 1),
(43, 311, 'Ronald_Christopher', 25, 0.168, -0.172, -0.17, -24.7, -141.8, -0.3, 1, 0, 1),
(44, 101, 'Axel', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1, 1),
(45, 64, 'Synester_Vengeance', 30, -0.116, -0.141, 0.088, 0, 44.5, 0, 1, 0, 1),
(46, 64, 'Vittorini_Leovince', 32, -0.363, -0.104, -0.23, 0, 85.5, 81.9, 1, 1, 1),
(47, 195, 'Duncan_Victorovich', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 0, 1),
(48, 142, 'Antonio_Ramorez', 31, -0.116, -0.114, 0.088, 0, 44.5, 0, 1, 0, 1),
(49, 159, 'Olmero_Estevanez', 25, -0.189, -0.161, 0.109, 0, 44.5, 0, 1, 0, 1),
(50, 311, 'Ronald_Christopher', 32, -0.009, -0.079, 0.087, -88.1, -6.5, -5.3, 8, 0, 1),
(51, 299, 'Kayson_Rostalve.', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 14, 1, 1),
(52, 123, 'Dejuam_Vegeance', 32, -0.116, 0.189, 0.088, 0, 44.5, 0, 8, 1, 1),
(53, 85, 'Matsushima_Kunio', 29, 0.048, -0.138, 0.088, 0, 44.5, 0, 1, 0, 1),
(54, 8, 'Xavier_Luciano', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 15, 0, 1),
(55, 192, 'Jahmiree_Maleek', 33, 0.388, -0.169, -0.049, 94.1, -102, 176.3, 7, 0, 1),
(56, 123, 'Dejuam_Vegeance', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 11, 0, 1),
(57, 192, 'Abel_Petterson', 32, 0.323, -0.09, -0.056, -116.1, -79.6, -46.5, 7, 1, 1),
(58, 192, 'Jahmiree_Maleek', 24, 0.442, -0.105, -0.091, -72.4, -90.3, 0, 7, 0, 1),
(59, 265, 'James_Bromwich', 25, -0.116, -0.111, -0.212, 0, 34.5, -180, 1, 0, 1),
(60, 360, 'Cody_Marshall', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 0, 1),
(61, 8, 'Xavier_Luciano', 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1, 1),
(62, 139, 'Andrey_Rodriguez', 25, 0.08, -0.211, 0.118, -99.3, -77.2, 4.9, 8, 0, 1),
(63, 25, 'Oscar_Vengeance', 24, 0.016, -0.121, 0.158, -102.7, -27.4, -2.6, 8, 1, 1),
(64, 135, 'Alex_Tuna', 30, -0.116, -0.132, 0.088, 0, 44.5, 0, 1, 0, 1),
(65, 123, 'Dejuam_Vegeance', 30, -0.116, 0.189, 0.088, 0, 44.5, 0, 8, 0, 1),
(66, 19, 'Gun_Walters', 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 18, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `weapon_apartment`
--

CREATE TABLE `weapon_apartment` (
  `weaponID` int(11) NOT NULL,
  `apartmentRoomID` int(11) NOT NULL DEFAULT -1,
  `Weapon` int(11) NOT NULL DEFAULT 0,
  `WeaponAmmo` int(11) NOT NULL DEFAULT 0,
  `WeaponDurability` int(11) NOT NULL DEFAULT 0,
  `WeaponSlot` int(11) NOT NULL DEFAULT 0,
  `WeaponSerial` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weapon_factions`
--

CREATE TABLE `weapon_factions` (
  `userid` int(12) UNSIGNED NOT NULL,
  `slot` int(3) UNSIGNED NOT NULL,
  `weaponid` tinyint(3) UNSIGNED NOT NULL,
  `ammo` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon_factions`
--

INSERT INTO `weapon_factions` (`userid`, `slot`, `weaponid`, `ammo`) VALUES
(8, 2, 24, 19985),
(8, 3, 25, 247),
(18, 2, 24, 250),
(18, 5, 31, 1470),
(79, 2, 24, 245),
(79, 5, 31, 1435),
(90, 2, 24, 217),
(119, 2, 24, 38),
(119, 5, 31, 1493),
(126, 5, 31, 1500),
(130, 2, 24, 248),
(151, 1, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `weapon_houses`
--

CREATE TABLE `weapon_houses` (
  `id` int(11) UNSIGNED NOT NULL,
  `houseid` int(11) UNSIGNED NOT NULL,
  `weaponid` tinyint(3) UNSIGNED NOT NULL,
  `ammo` int(11) UNSIGNED NOT NULL,
  `durability` int(11) UNSIGNED NOT NULL,
  `slot` int(11) NOT NULL DEFAULT 0,
  `serial` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon_houses`
--

INSERT INTO `weapon_houses` (`id`, `houseid`, `weaponid`, `ammo`, `durability`, `slot`, `serial`) VALUES
(4, 30, 5, 1, 1, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `weapon_players`
--

CREATE TABLE `weapon_players` (
  `userid` int(12) UNSIGNED NOT NULL,
  `slot` tinyint(3) UNSIGNED NOT NULL,
  `weaponid` tinyint(3) UNSIGNED NOT NULL,
  `ammo` int(10) UNSIGNED NOT NULL,
  `durability` int(10) UNSIGNED NOT NULL,
  `created` int(12) UNSIGNED NOT NULL,
  `serial` varchar(64) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon_players`
--

INSERT INTO `weapon_players` (`userid`, `slot`, `weaponid`, `ammo`, `durability`, `created`, `serial`) VALUES
(4, 3, 25, 72, 472, 1662877162, '0'),
(5, 2, 22, 129, 459, 1663075015, '0'),
(9, 5, 30, 1990, 948, 1663121636, '0'),
(12, 3, 25, 95, 495, 1663221909, '0'),
(13, 2, 24, 322, 472, 1663230687, '0'),
(13, 5, 30, 1934, 434, 1663230643, '0'),
(13, 4, 32, 1998, 998, 1663230674, '0'),
(14, 2, 24, 70, 500, 1663165600, '0'),
(16, 1, 5, 1, 1, 1663017103, '0'),
(16, 2, 24, 0, 150, 1663080479, '0'),
(17, 1, 5, 1, 1, 1663113542, 'None'),
(25, 5, 30, 942, 442, 1663218086, '0'),
(27, 1, 5, 1, 1, 1662868220, 'None'),
(28, 1, 5, 1, 1, 1662883955, 'None'),
(29, 1, 5, 1, 1, 1663144154, 'None'),
(31, 1, 5, 1, 1, 1663086433, 'None'),
(34, 1, 5, 1, 1, 1663147761, 'None'),
(37, 2, 22, 132, 462, 1663177047, '0'),
(38, 1, 5, 1, 1, 1662894065, 'None'),
(38, 3, 25, 69, 494, 1662971049, '0'),
(41, 2, 23, 233, 233, 1663062946, '0'),
(41, 3, 25, 25, 425, 1663062943, '0'),
(46, 1, 5, 1, 1, 1662892963, 'None'),
(51, 2, 24, 0, 96, 1662864350, '0'),
(60, 1, 4, 1, 1, 1663072463, '0'),
(62, 1, 4, 1, 1, 1663088113, '0'),
(62, 2, 24, 347, 500, 1663092054, '0'),
(62, 4, 32, 2000, 1000, 1663088210, '0'),
(65, 1, 5, 1, 1, 1663227067, '0'),
(66, 3, 25, 66, 66, 1662873022, '0'),
(67, 3, 25, 46, 446, 1663078194, '0'),
(69, 2, 24, 65, 85, 1662876689, '0'),
(71, 1, 5, 1, 1, 1662854306, 'None'),
(71, 9, 43, 1, 500, 1662854301, 'None'),
(77, 1, 5, 1, 1, 1662886330, 'None'),
(77, 2, 23, 74, 474, 1662971797, '0'),
(101, 3, 25, 0, 480, 1663125467, '0'),
(108, 9, 43, 1, 500, 1662968489, 'None'),
(114, 1, 5, 1, 1, 1662867219, 'None'),
(123, 3, 25, 29, 429, 1663168574, '0'),
(135, 1, 9, 1, 1, 1663137045, '338464'),
(135, 2, 24, 312, 462, 1663137619, '0'),
(135, 5, 30, 1926, 426, 1663137675, '0'),
(135, 9, 43, 1, 500, 1663138051, 'None'),
(148, 1, 5, 1, 1, 1662999911, 'None'),
(148, 9, 43, 1, 500, 1662999939, 'None'),
(152, 1, 5, 1, 1, 1662880797, 'None'),
(155, 1, 5, 1, 1, 1662862560, 'None'),
(156, 1, 5, 1, 1, 1662831613, 'None'),
(158, 1, 5, 1, 1, 1662839120, 'None'),
(159, 3, 25, 72, 390, 1663084950, '0'),
(160, 9, 43, 1, 500, 1662839098, 'None'),
(173, 1, 5, 1, 1, 1662899734, 'None'),
(174, 1, 5, 1, 1, 1662855616, 'None'),
(180, 1, 5, 1, 1, 1662858321, 'None'),
(180, 9, 43, 1, 500, 1662858325, 'None'),
(184, 1, 5, 1, 1, 1662861561, 'None'),
(184, 9, 43, 1, 500, 1662861574, 'None'),
(188, 3, 25, 88, 88, 1662867038, '0'),
(192, 2, 24, 350, 500, 1663070158, '0'),
(192, 3, 25, 100, 500, 1662889878, '7889192'),
(192, 5, 30, 2000, 500, 1663070845, '0'),
(192, 4, 32, 2000, 500, 1663070912, '0'),
(192, 6, 33, 90, 490, 1663070202, '0'),
(193, 1, 5, 1, 1, 1662959970, '0'),
(193, 5, 30, 447, 947, 1663220067, '0'),
(193, 9, 43, 1, 500, 1662959968, '0'),
(195, 1, 5, 1, 1, 1662897348, 'None'),
(195, 2, 24, 350, 500, 1663199455, '0'),
(196, 1, 5, 1, 1, 1663160171, 'None'),
(200, 3, 25, 30, 472, 1662872114, '0'),
(202, 1, 9, 1, 1, 1662876922, '0'),
(214, 9, 43, 1, 500, 1662879129, 'None'),
(217, 1, 5, 1, 1, 1662901412, 'None'),
(217, 9, 43, 1, 500, 1663114569, 'None'),
(219, 1, 5, 1, 1, 1662880161, 'None'),
(222, 1, 5, 1, 1, 1662882983, 'None'),
(226, 2, 24, 333, 483, 1663070506, '0'),
(226, 4, 32, 1952, 452, 1663070810, '0'),
(233, 1, 5, 1, 1, 1662883915, 'None'),
(244, 1, 5, 1, 1, 1662890052, 'None'),
(252, 1, 5, 1, 1, 1662897919, 'None'),
(252, 9, 43, 1, 500, 1662897922, 'None'),
(259, 1, 5, 1, 1, 1662902695, 'None'),
(267, 1, 5, 1, 1, 1662923877, 'None'),
(267, 9, 43, 1, 500, 1663052004, 'None'),
(268, 3, 25, 95, 495, 1662929518, '4924268'),
(289, 9, 43, 1, 500, 1662971859, 'None'),
(304, 1, 5, 1, 1, 1662986852, 'None'),
(311, 4, 32, 115, 215, 1663067092, '0'),
(320, 1, 5, 1, 1, 1663007243, 'None'),
(327, 1, 5, 1, 1, 1663075757, '0'),
(328, 1, 5, 1, 1, 1663067395, 'None'),
(328, 9, 43, 1, 500, 1663067467, 'None'),
(331, 1, 5, 1, 1, 1663066629, 'None'),
(333, 9, 43, 1, 500, 1663058827, 'None'),
(335, 3, 25, 212, 462, 1663223747, '0'),
(340, 3, 25, 96, 496, 1663223698, '0'),
(416, 1, 5, 1, 1, 1663160130, 'None');

-- --------------------------------------------------------

--
-- Table structure for table `weapon_vehicles`
--

CREATE TABLE `weapon_vehicles` (
  `id` int(11) NOT NULL,
  `vehicleid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `weaponid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ammo` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `durability` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `serial` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon_vehicles`
--

INSERT INTO `weapon_vehicles` (`id`, `vehicleid`, `weaponid`, `ammo`, `durability`, `serial`) VALUES
(304, 166, 25, 75, 500, 0),
(305, 166, 25, 75, 500, 0),
(307, 166, 25, 75, 500, 0),
(308, 166, 25, 75, 500, 0),
(319, 186, 23, 100, 500, 0),
(320, 186, 23, 100, 500, 0),
(323, 186, 30, 500, 500, 0),
(324, 187, 30, 500, 500, 0),
(325, 187, 30, 500, 500, 0),
(326, 187, 24, 100, 500, 0),
(327, 187, 24, 100, 500, 0),
(328, 187, 24, 100, 500, 0),
(329, 167, 30, 500, 500, 0),
(333, 153, 30, 500, 1000, 0),
(347, 190, 43, 1, 500, 0),
(348, 127, 24, 97, 97, 0),
(353, 211, 24, 95, 100, 0),
(364, 232, 4, 1, 1, 0),
(365, 226, 43, 1, 500, 0),
(381, 261, 23, 100, 100, 0),
(392, 266, 23, 75, 75, 0),
(393, 270, 27, 35, 35, 367212),
(396, 211, 4, 1, 1, 0),
(398, 261, 25, 75, 75, 3055192),
(407, 259, 30, 500, 1000, 0),
(408, 259, 30, 500, 1000, 0),
(415, 258, 30, 500, 1000, 0),
(417, 257, 30, 500, 1000, 0),
(418, 257, 24, 100, 500, 0),
(419, 257, 24, 100, 500, 0),
(420, 257, 24, 100, 500, 0),
(421, 257, 24, 100, 500, 0),
(422, 214, 30, 500, 1000, 0),
(424, 250, 43, 1, 500, 0),
(426, 296, 23, 100, 500, 0),
(436, 258, 25, 100, 500, 0),
(440, 229, 30, 900, 900, 0),
(448, 317, 24, 100, 500, 0),
(461, 258, 30, 500, 1000, 0),
(466, 253, 5, 1, 1, 0),
(467, 253, 43, 1, 500, 0),
(472, 272, 25, 100, 100, 51367),
(474, 320, 23, 771, 771, 0),
(496, 309, 23, 0, 400, 0),
(497, 261, 23, 252, 252, 0),
(503, 259, 30, 500, 500, 0),
(504, 258, 30, 500, 500, 0),
(506, 35, 30, 500, 500, 0),
(507, 35, 30, 500, 500, 0),
(508, 258, 25, 496, 500, 0),
(513, 368, 24, 91, 500, 0),
(514, 368, 25, 147, 500, 0),
(520, 35, 30, 500, 500, 0),
(521, 35, 30, 500, 500, 0),
(522, 198, 24, 100, 500, 0),
(523, 198, 24, 100, 500, 0),
(524, 198, 24, 100, 500, 0),
(525, 198, 24, 100, 500, 0),
(526, 198, 24, 100, 500, 0),
(527, 163, 25, 86, 486, 0),
(575, 199, 30, 2000, 1000, 0),
(576, 199, 30, 2000, 1000, 0),
(577, 199, 30, 2000, 1000, 0),
(579, 199, 30, 2000, 500, 0),
(588, 199, 30, 2000, 1000, 0),
(589, 348, 25, 100, 500, 0),
(590, 202, 24, 350, 500, 0),
(594, 348, 30, 2000, 500, 0),
(595, 348, 32, 2000, 500, 0),
(597, 348, 30, 2000, 139, 0),
(599, 148, 32, 2000, 500, 0),
(600, 148, 30, 2000, 1000, 0),
(601, 148, 24, 350, 500, 0),
(602, 148, 23, 350, 500, 0),
(605, 259, 30, 500, 500, 0),
(612, 259, 30, 400, 500, 0),
(613, 148, 25, 99, 499, 0),
(618, 147, 32, 2000, 500, 0),
(620, 147, 30, 2000, 500, 0),
(621, 147, 24, 350, 500, 0),
(623, 147, 33, 100, 500, 0),
(624, 147, 25, 100, 500, 0),
(625, 202, 32, 1992, 484, 0),
(628, 163, 22, 148, 478, 0),
(629, 218, 22, 164, 494, 0),
(633, 229, 30, 2000, 500, 0),
(642, 160, 24, 350, 483, 0),
(644, 454, 24, 100, 500, 0),
(645, 454, 24, 100, 500, 0),
(646, 454, 24, 100, 500, 0),
(647, 454, 24, 100, 500, 0),
(651, 153, 24, 50, 450, 0),
(659, 262, 23, 51, 453, 0),
(662, 466, 24, 100, 500, 0),
(673, 448, 25, 100, 500, 0),
(675, 270, 24, 47, 47, 72577),
(685, 448, 23, 0, 400, 0),
(687, 448, 24, 350, 500, 0),
(689, 320, 30, 1980, 980, 0),
(690, 320, 25, 441, 441, 0),
(691, 261, 30, 400, 400, 0),
(692, 261, 32, 2000, 500, 0),
(694, 229, 23, 88, 88, 0),
(697, 218, 23, 456, 500, 0),
(703, 214, 30, 495, 995, 0),
(707, 132, 24, 100, 100, 0),
(713, 484, 25, 81, 481, 0),
(715, 166, 24, 350, 499, 0),
(716, 501, 23, 99, 499, 0),
(718, 501, 25, 225, 500, 0),
(719, 501, 25, 124, 495, 0),
(720, 501, 23, 100, 500, 0),
(722, 501, 23, 100, 500, 0),
(725, 360, 30, 2000, 500, 0),
(726, 360, 30, 2000, 500, 0),
(728, 360, 32, 1758, 258, 0),
(729, 360, 30, 2000, 500, 0),
(730, 360, 30, 2000, 500, 0),
(731, 159, 24, 148, 498, 0),
(735, 211, 30, 2000, 500, 0),
(737, 214, 30, 2000, 500, 0),
(739, 159, 30, 2000, 1000, 0),
(740, 160, 30, 2000, 500, 0),
(741, 160, 30, 2000, 1000, 0),
(742, 512, 32, 2000, 500, 0),
(743, 512, 30, 1974, 474, 0),
(752, 167, 30, 2000, 500, 0),
(754, 119, 30, 2000, 958, 0),
(755, 186, 32, 2000, 500, 0),
(756, 186, 33, 8, 488, 0),
(759, 202, 32, 2000, 500, 0),
(762, 202, 32, 1912, 412, 0),
(763, 202, 24, 268, 418, 0),
(764, 412, 25, 50, 50, 0),
(767, 160, 9, 1, 1, 4751133),
(770, 531, 25, 100, 500, 0),
(776, 160, 25, 95, 495, 0),
(778, 531, 24, 98, 498, 0),
(781, 153, 30, 462, 962, 0),
(783, 466, 25, 100, 500, 0),
(784, 466, 24, 100, 500, 0),
(785, 175, 24, 90, 90, 0),
(787, 229, 32, 254, 354, 0),
(788, 295, 32, 2000, 500, 0),
(789, 295, 30, 480, 480, 0),
(791, 153, 32, 1984, 484, 0),
(792, 440, 30, 500, 1000, 0),
(793, 440, 25, 100, 500, 0),
(795, 531, 25, 100, 500, 0),
(798, 514, 25, 92, 92, 0),
(800, 348, 24, 350, 500, 0),
(802, 132, 30, 67, 67, 0),
(803, 229, 25, 119, 119, 0),
(804, 185, 23, 100, 100, 0),
(805, 418, 23, 50, 450, 0),
(806, 466, 24, 100, 500, 0),
(808, 185, 25, 100, 500, 0),
(814, 240, 25, 100, 500, 0),
(815, 240, 23, 350, 500, 0),
(817, 240, 8, 1, 1, 0),
(818, 242, 23, 50, 50, 0);

-- --------------------------------------------------------

--
-- Table structure for table `whitelist`
--

CREATE TABLE `whitelist` (
  `ID` int(5) NOT NULL,
  `pID` int(10) NOT NULL,
  `whitelisted` int(5) NOT NULL DEFAULT 0,
  `whitelistdate` varchar(64) NOT NULL,
  `whitelistby` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'None',
  `whitelistreason` varchar(255) NOT NULL DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `workshop`
--

CREATE TABLE `workshop` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Price` int(10) UNSIGNED NOT NULL,
  `Vault` int(10) UNSIGNED NOT NULL,
  `Component` int(10) UNSIGNED NOT NULL,
  `Toggle` int(10) UNSIGNED NOT NULL,
  `Owner` int(10) UNSIGNED NOT NULL,
  `Name` varchar(32) NOT NULL DEFAULT 'Nothing',
  `Text` varchar(128) NOT NULL DEFAULT 'This workshop is for {FF0000}sale',
  `Pos` varchar(72) NOT NULL,
  `BoardPos` varchar(72) NOT NULL,
  `Seal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workshop`
--

INSERT INTO `workshop` (`ID`, `Price`, `Vault`, `Component`, `Toggle`, `Owner`, `Name`, `Text`, `Pos`, `BoardPos`, `Seal`) VALUES
(1, 1, 1625, 8865, 0, 77, 'Umbrella Corp', 'Owned by Pandu_Pangestu', '2160.2761|-1728.1932|13.5705', '2151.7658|-1727.7242|17.1019|88.3999|-2.2999|-89.0000', 0),
(2, 50000, 201, 25370, 0, 131, 'Autobahn', 'Open Service! Call:13434-42030-22031', '1358.3420|-1562.2530|13.5628', '1355.0246|-1558.7716|14.9993|89.9000|-6.6999|-98.0998', 0),
(4, 1, 0, 8554, 0, 172, 'LOLIGO GARAGE', 'LOLIGO GARAGE ', '966.9644|-1732.1069|13.5466', '963.2946|-1735.1700|15.3055|89.9999|21.8999|157.8999', 0);

-- --------------------------------------------------------

--
-- Table structure for table `workshop_employe`
--

CREATE TABLE `workshop_employe` (
  `ID` int(11) NOT NULL,
  `Workshop` int(10) UNSIGNED NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Time` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workshop_employe`
--

INSERT INTO `workshop_employe` (`ID`, `Workshop`, `Name`, `Time`) VALUES
(1, 2, 'Rene_Descartes', 1662882112),
(3, 4, 'Reamy_Xhyner', 1662934633),
(4, 4, 'Rojer_Hawkins', 1662936135),
(5, 1, 'Gun_Walters', 1662972838),
(6, 2, 'Aiden_Pearce', 1662975972);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesories_wardrobe`
--
ALTER TABLE `accesories_wardrobe`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`actorID`);

--
-- Indexes for table `admin_activities`
--
ALTER TABLE `admin_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_activities_issuer_FK` (`issuer`),
  ADD KEY `admin_activities_receiver_FK` (`receiver`);

--
-- Indexes for table `admin_duty_times`
--
ALTER TABLE `admin_duty_times`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_duty_times_accounts_FK` (`account`);

--
-- Indexes for table `aksesoris`
--
ALTER TABLE `aksesoris`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `apartment`
--
ALTER TABLE `apartment`
  ADD PRIMARY KEY (`apartmentID`);

--
-- Indexes for table `apartment_room`
--
ALTER TABLE `apartment_room`
  ADD PRIMARY KEY (`apartmentRoomID`);

--
-- Indexes for table `apartment_storage`
--
ALTER TABLE `apartment_storage`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `arrestpoints`
--
ALTER TABLE `arrestpoints`
  ADD PRIMARY KEY (`arrestID`);

--
-- Indexes for table `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`atmID`);

--
-- Indexes for table `backpackitems`
--
ALTER TABLE `backpackitems`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `backpacks`
--
ALTER TABLE `backpacks`
  ADD PRIMARY KEY (`backpackID`);

--
-- Indexes for table `billboards`
--
ALTER TABLE `billboards`
  ADD PRIMARY KEY (`bbID`);

--
-- Indexes for table `bizwarn`
--
ALTER TABLE `bizwarn`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `bizID` (`bizID`);

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`bizID`);

--
-- Indexes for table `business_employe`
--
ALTER TABLE `business_employe`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carstorage`
--
ALTER TABLE `carstorage`
  ADD PRIMARY KEY (`itemID`) USING BTREE;

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `clothes_wardrobe`
--
ALTER TABLE `clothes_wardrobe`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactID`);

--
-- Indexes for table `crates`
--
ALTER TABLE `crates`
  ADD PRIMARY KEY (`crateID`);

--
-- Indexes for table `damages`
--
ALTER TABLE `damages`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dealership`
--
ALTER TABLE `dealership`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dealervehicle`
--
ALTER TABLE `dealervehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dealervehicles`
--
ALTER TABLE `dealervehicles`
  ADD PRIMARY KEY (`vehID`);

--
-- Indexes for table `dealer_vehicles`
--
ALTER TABLE `dealer_vehicles`
  ADD PRIMARY KEY (`dealer_id`,`model`);

--
-- Indexes for table `detectors`
--
ALTER TABLE `detectors`
  ADD PRIMARY KEY (`detectorID`);

--
-- Indexes for table `discord`
--
ALTER TABLE `discord`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `donation_characters`
--
ALTER TABLE `donation_characters`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `donation_coins`
--
ALTER TABLE `donation_coins`
  ADD PRIMARY KEY (`id`,`code`);

--
-- Indexes for table `donation_coin_list`
--
ALTER TABLE `donation_coin_list`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `donation_token`
--
ALTER TABLE `donation_token`
  ADD PRIMARY KEY (`id`,`code`);

--
-- Indexes for table `donation_vehicles`
--
ALTER TABLE `donation_vehicles`
  ADD PRIMARY KEY (`model`);

--
-- Indexes for table `dropped`
--
ALTER TABLE `dropped`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `droppedweapon`
--
ALTER TABLE `droppedweapon`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `efurniture`
--
ALTER TABLE `efurniture`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entrances`
--
ALTER TABLE `entrances`
  ADD PRIMARY KEY (`entranceID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `fire`
--
ALTER TABLE `fire`
  ADD PRIMARY KEY (`fireID`);

--
-- Indexes for table `furniture`
--
ALTER TABLE `furniture`
  ADD PRIMARY KEY (`furnitureID`);

--
-- Indexes for table `furnobject`
--
ALTER TABLE `furnobject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `furnstore`
--
ALTER TABLE `furnstore`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `garage`
--
ALTER TABLE `garage`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `garbage`
--
ALTER TABLE `garbage`
  ADD PRIMARY KEY (`garbageID`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`gateID`);

--
-- Indexes for table `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`locationID`);

--
-- Indexes for table `graffiti`
--
ALTER TABLE `graffiti`
  ADD PRIMARY KEY (`graffitiID`);

--
-- Indexes for table `gunracks`
--
ALTER TABLE `gunracks`
  ADD PRIMARY KEY (`rackID`);

--
-- Indexes for table `housekeys`
--
ALTER TABLE `housekeys`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `houseID` (`houseID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`houseID`);

--
-- Indexes for table `housestorage`
--
ALTER TABLE `housestorage`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `impoundlots`
--
ALTER TABLE `impoundlots`
  ADD PRIMARY KEY (`impoundID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`invID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`jobID`);

--
-- Indexes for table `lumber`
--
ALTER TABLE `lumber`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marketplace`
--
ALTER TABLE `marketplace`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `namechanges`
--
ALTER TABLE `namechanges`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `objecttext`
--
ALTER TABLE `objecttext`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `plants`
--
ALTER TABLE `plants`
  ADD PRIMARY KEY (`plantID`);

--
-- Indexes for table `playerammo`
--
ALTER TABLE `playerammo`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `playerweapon`
--
ALTER TABLE `playerweapon`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `player_animation`
--
ALTER TABLE `player_animation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_vehicles`
--
ALTER TABLE `player_vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pumps`
--
ALTER TABLE `pumps`
  ADD PRIMARY KEY (`pumpID`);

--
-- Indexes for table `quizes`
--
ALTER TABLE `quizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `rental_vehicles`
--
ALTER TABLE `rental_vehicles`
  ADD PRIMARY KEY (`rental_id`,`model`),
  ADD UNIQUE KEY `rental_id` (`rental_id`,`model`),
  ADD UNIQUE KEY `rental_id_2` (`rental_id`,`model`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `server`
--
ALTER TABLE `server`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `server_economies`
--
ALTER TABLE `server_economies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `server_vehicles`
--
ALTER TABLE `server_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sidejob_boxville_configs`
--
ALTER TABLE `sidejob_boxville_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sidejob_bus_driver_configs`
--
ALTER TABLE `sidejob_bus_driver_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sidejob_money_transporter_configs`
--
ALTER TABLE `sidejob_money_transporter_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sidejob_sweeper_configs`
--
ALTER TABLE `sidejob_sweeper_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sidejob_trashmaster_configs`
--
ALTER TABLE `sidejob_trashmaster_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `speedcameras`
--
ALTER TABLE `speedcameras`
  ADD PRIMARY KEY (`speedID`);

--
-- Indexes for table `submitted_quizes`
--
ALTER TABLE `submitted_quizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id_2` (`session_id`),
  ADD KEY `reviewer` (`reviewer`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `account` (`account`,`session_id`);

--
-- Indexes for table `submitted_quiz_questions`
--
ALTER TABLE `submitted_quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`,`session_id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tagId`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticketID`);

--
-- Indexes for table `underground`
--
ALTER TABLE `underground`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehiclekeys`
--
ALTER TABLE `vehiclekeys`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `vehicleID` (`vehicleID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `vehicle_cargo`
--
ALTER TABLE `vehicle_cargo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_components`
--
ALTER TABLE `vehicle_components`
  ADD PRIMARY KEY (`componentid`);

--
-- Indexes for table `vehicle_mod`
--
ALTER TABLE `vehicle_mod`
  ADD PRIMARY KEY (`vehicleid`),
  ADD UNIQUE KEY `vehicleid` (`vehicleid`);

--
-- Indexes for table `vehicle_model_parts`
--
ALTER TABLE `vehicle_model_parts`
  ADD PRIMARY KEY (`modelid`);

--
-- Indexes for table `vehicle_object`
--
ALTER TABLE `vehicle_object`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vending`
--
ALTER TABLE `vending`
  ADD PRIMARY KEY (`vendID`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`vendorID`);

--
-- Indexes for table `warrants`
--
ALTER TABLE `warrants`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `weaponsettings`
--
ALTER TABLE `weaponsettings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `weapon_apartment`
--
ALTER TABLE `weapon_apartment`
  ADD PRIMARY KEY (`weaponID`);

--
-- Indexes for table `weapon_factions`
--
ALTER TABLE `weapon_factions`
  ADD PRIMARY KEY (`userid`,`slot`);

--
-- Indexes for table `weapon_houses`
--
ALTER TABLE `weapon_houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weapon_players`
--
ALTER TABLE `weapon_players`
  ADD PRIMARY KEY (`userid`,`weaponid`);

--
-- Indexes for table `weapon_vehicles`
--
ALTER TABLE `weapon_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `pID_2` (`pID`),
  ADD KEY `pID` (`pID`);

--
-- Indexes for table `workshop`
--
ALTER TABLE `workshop`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `workshop_employe`
--
ALTER TABLE `workshop_employe`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesories_wardrobe`
--
ALTER TABLE `accesories_wardrobe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=589;

--
-- AUTO_INCREMENT for table `actor`
--
ALTER TABLE `actor`
  MODIFY `actorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `admin_activities`
--
ALTER TABLE `admin_activities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=868;

--
-- AUTO_INCREMENT for table `admin_duty_times`
--
ALTER TABLE `admin_duty_times`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=380;

--
-- AUTO_INCREMENT for table `aksesoris`
--
ALTER TABLE `aksesoris`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `animals`
--
ALTER TABLE `animals`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `apartment`
--
ALTER TABLE `apartment`
  MODIFY `apartmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `apartment_room`
--
ALTER TABLE `apartment_room`
  MODIFY `apartmentRoomID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `apartment_storage`
--
ALTER TABLE `apartment_storage`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `arrestpoints`
--
ALTER TABLE `arrestpoints`
  MODIFY `arrestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `atm`
--
ALTER TABLE `atm`
  MODIFY `atmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `backpackitems`
--
ALTER TABLE `backpackitems`
  MODIFY `itemID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backpacks`
--
ALTER TABLE `backpacks`
  MODIFY `backpackID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `billboards`
--
ALTER TABLE `billboards`
  MODIFY `bbID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bizwarn`
--
ALTER TABLE `bizwarn`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `bizID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `business_employe`
--
ALTER TABLE `business_employe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `carstorage`
--
ALTER TABLE `carstorage`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=432;

--
-- AUTO_INCREMENT for table `clothes_wardrobe`
--
ALTER TABLE `clothes_wardrobe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `crates`
--
ALTER TABLE `crates`
  MODIFY `crateID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `damages`
--
ALTER TABLE `damages`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1064;

--
-- AUTO_INCREMENT for table `dealership`
--
ALTER TABLE `dealership`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dealervehicle`
--
ALTER TABLE `dealervehicle`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealervehicles`
--
ALTER TABLE `dealervehicles`
  MODIFY `vehID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detectors`
--
ALTER TABLE `detectors`
  MODIFY `detectorID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discord`
--
ALTER TABLE `discord`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donation_coins`
--
ALTER TABLE `donation_coins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `donation_token`
--
ALTER TABLE `donation_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `dropped`
--
ALTER TABLE `dropped`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `droppedweapon`
--
ALTER TABLE `droppedweapon`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `efurniture`
--
ALTER TABLE `efurniture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entrances`
--
ALTER TABLE `entrances`
  MODIFY `entranceID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `fire`
--
ALTER TABLE `fire`
  MODIFY `fireID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `furniture`
--
ALTER TABLE `furniture`
  MODIFY `furnitureID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `furnobject`
--
ALTER TABLE `furnobject`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `furnstore`
--
ALTER TABLE `furnstore`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `garage`
--
ALTER TABLE `garage`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `garbage`
--
ALTER TABLE `garbage`
  MODIFY `garbageID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `gateID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `locationID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `graffiti`
--
ALTER TABLE `graffiti`
  MODIFY `graffitiID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gunracks`
--
ALTER TABLE `gunracks`
  MODIFY `rackID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `housekeys`
--
ALTER TABLE `housekeys`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `houseID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `housestorage`
--
ALTER TABLE `housestorage`
  MODIFY `itemID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `impoundlots`
--
ALTER TABLE `impoundlots`
  MODIFY `impoundID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1963;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `jobID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `lumber`
--
ALTER TABLE `lumber`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketplace`
--
ALTER TABLE `marketplace`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `namechanges`
--
ALTER TABLE `namechanges`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `objecttext`
--
ALTER TABLE `objecttext`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plants`
--
ALTER TABLE `plants`
  MODIFY `plantID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `playerammo`
--
ALTER TABLE `playerammo`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `playerweapon`
--
ALTER TABLE `playerweapon`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_animation`
--
ALTER TABLE `player_animation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `player_vehicles`
--
ALTER TABLE `player_vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pumps`
--
ALTER TABLE `pumps`
  MODIFY `pumpID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `quizes`
--
ALTER TABLE `quizes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rentals`
--
ALTER TABLE `rentals`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `salary`
--
ALTER TABLE `salary`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=483;

--
-- AUTO_INCREMENT for table `server`
--
ALTER TABLE `server`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `server_economies`
--
ALTER TABLE `server_economies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `server_vehicles`
--
ALTER TABLE `server_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=564;

--
-- AUTO_INCREMENT for table `sidejob_boxville_configs`
--
ALTER TABLE `sidejob_boxville_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sidejob_bus_driver_configs`
--
ALTER TABLE `sidejob_bus_driver_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sidejob_money_transporter_configs`
--
ALTER TABLE `sidejob_money_transporter_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sidejob_sweeper_configs`
--
ALTER TABLE `sidejob_sweeper_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sidejob_trashmaster_configs`
--
ALTER TABLE `sidejob_trashmaster_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `speedcameras`
--
ALTER TABLE `speedcameras`
  MODIFY `speedID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submitted_quizes`
--
ALTER TABLE `submitted_quizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submitted_quiz_questions`
--
ALTER TABLE `submitted_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tagId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticketID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `underground`
--
ALTER TABLE `underground`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehiclekeys`
--
ALTER TABLE `vehiclekeys`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `vehicle_cargo`
--
ALTER TABLE `vehicle_cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `vehicle_object`
--
ALTER TABLE `vehicle_object`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `vending`
--
ALTER TABLE `vending`
  MODIFY `vendID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `vendorID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warrants`
--
ALTER TABLE `warrants`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `weaponsettings`
--
ALTER TABLE `weaponsettings`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `weapon_apartment`
--
ALTER TABLE `weapon_apartment`
  MODIFY `weaponID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapon_houses`
--
ALTER TABLE `weapon_houses`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `weapon_vehicles`
--
ALTER TABLE `weapon_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=819;

--
-- AUTO_INCREMENT for table `whitelist`
--
ALTER TABLE `whitelist`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshop`
--
ALTER TABLE `workshop`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `workshop_employe`
--
ALTER TABLE `workshop_employe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_duty_times`
--
ALTER TABLE `admin_duty_times`
  ADD CONSTRAINT `admin_duty_times_accounts_FK` FOREIGN KEY (`account`) REFERENCES `accounts` (`ID`);

--
-- Constraints for table `submitted_quizes`
--
ALTER TABLE `submitted_quizes`
  ADD CONSTRAINT `submitted_quizes_ibfk_1` FOREIGN KEY (`account`) REFERENCES `accounts` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `submitted_quizes_ibfk_2` FOREIGN KEY (`reviewer`) REFERENCES `accounts` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `submitted_quiz_questions`
--
ALTER TABLE `submitted_quiz_questions`
  ADD CONSTRAINT `submitted_quiz_questions_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `submitted_quizes` (`session_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
