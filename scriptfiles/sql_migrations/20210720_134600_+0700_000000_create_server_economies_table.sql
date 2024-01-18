-- Ini script SQL untuk membuat table server_economies.
-- Keperluannya adalah untuk menyimpan ekonomi server.
CREATE TABLE IF NOT EXISTS `server_economies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supply` int(11) NOT NULL DEFAULT 1000000,
  `reserve` int(11) NOT NULL DEFAULT 1000000,
  `inflation_rate` int(4) NULL DEFAULT 0,
  `sales_tax_rate` int(4) NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL DEFAULT 0,
  `deleted_at` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4

-- Create trigger untuk meng-update updated_at menjadi waktu terbaru ketika ada update data.
CREATE TRIGGER IF NOT EXISTS server_economy_before_insert
BEFORE INSERT
ON server_economies FOR EACH ROW
BEGIN
	SET NEW.created_at = UNIX_TIMESTAMP(NOW());
	SET NEW.updated_at = UNIX_TIMESTAMP(NOW());
END;

CREATE TRIGGER IF NOT EXISTS server_economy_update_timestamp
BEFORE UPDATE
ON server_economies FOR EACH ROW
BEGIN
	SET NEW.updated_at = UNIX_TIMESTAMP(NOW());
END;
