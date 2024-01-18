-- Ini script SQL untuk membuat table admin_activities.
-- Keperluannya adalah untuk menyimpan aktivitas admin.
CREATE TABLE IF NOT EXISTS `admin_activities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('unknown','accept_report','deny_report','accept_stuck','deny_stuck','ban','unban','jail','answer') NOT NULL,
  `issuer` int(11) NOT NULL,
  `receiver` int(12) NOT NULL,
  `issuer_ip_address` varchar(32) NOT NULL,
  `receiver_ip_address` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_activities_issuer_FK` (`issuer`),
  KEY `admin_activities_receiver_FK` (`receiver`),
  CONSTRAINT `admin_activities_issuer_FK` FOREIGN KEY (`issuer`) REFERENCES `accounts` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `admin_activities_receiver_FK` FOREIGN KEY (`receiver`) REFERENCES `characters` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
