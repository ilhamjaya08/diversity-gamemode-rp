-- Ini script SQL untuk membuat table admin_duty_times.
-- Keperluannya adalah untuk menyimpan aktivitas admin duty admin.
CREATE TABLE IF NOT EXISTS `admin_duty_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` int(11) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_duty_times_accounts_FK` (`account`),
  CONSTRAINT `admin_duty_times_accounts_FK` FOREIGN KEY (`account`) REFERENCES `accounts` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
