-- -----------------------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           11.5.1-MariaDB-log - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour driftv // Listing the base structure for driftv
CREATE DATABASE IF NOT EXISTS `driftv` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `driftv`;

-- Listage de la structure de table driftv. kvp // Listing the driftv.kvp table structure
CREATE TABLE IF NOT EXISTS `kvp` (
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `players` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `license` VARCHAR(255) NOT NULL,
    `season` VARCHAR(255) NOT NULL,
    `pName` VARCHAR(255) NOT NULL,
    `money` INT NOT NULL DEFAULT 0,
    `driftPoint` INT NOT NULL DEFAULT 0,
    `exp` INT NOT NULL DEFAULT 0,
    `level` INT NOT NULL DEFAULT 0,
    `cars` JSON NOT NULL,
    `succes` JSON NOT NULL,
    `crew` VARCHAR(255) NOT NULL DEFAULT 'None',
    `crewOwner` BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (`license`, `season`)
);

CREATE TABLE `crews` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `tag` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `memberCount` INT NOT NULL DEFAULT 1,
    `totalPoints` INT NOT NULL DEFAULT 0,
    `win` INT NOT NULL DEFAULT 0,
    `loose` INT NOT NULL DEFAULT 0,
    `elo` INT NOT NULL DEFAULT 1000,
    `members` JSON NOT NULL,
    `rank` INT NOT NULL DEFAULT 500
);

-- Les données exportées n'étaient pas sélectionnées. // The exported data was not selected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
