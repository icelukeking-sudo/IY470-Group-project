CREATE DATABASE  IF NOT EXISTS `iy470_gym` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `iy470_gym`;
-- MySQL dump 10.13  Distrib 8.0.44, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: iy470_gym
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `membership`
--

DROP TABLE IF EXISTS `membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership` (
  `id` int NOT NULL AUTO_INCREMENT,
  `membership_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `is_student` tinyint(1) DEFAULT NULL,
  `chosen_gym` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addons` text COLLATE utf8mb4_unicode_ci,
  `final_cost` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership`
--

LOCK TABLES `membership` WRITE;
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_option`
--

DROP TABLE IF EXISTS `membership_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_option` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gym` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_option`
--

LOCK TABLES `membership_option` WRITE;
/*!40000 ALTER TABLE `membership_option` DISABLE KEYS */;
INSERT INTO `membership_option` VALUES (11,'ugym','joining_fee','Joining fee',10.00),(12,'ugym','membership','Anytime',50.00),(13,'ugym','membership','Off-peak',40.00),(14,'ugym','massage','30min',20.00),(15,'ugym','physio','Session',30.00),(16,'powerzone','joining_fee','Joining fee',12.00),(17,'powerzone','membership','Anytime',48.00),(18,'powerzone','membership','Off-peak',38.00),(19,'powerzone','massage','30min',22.00),(20,'powerzone','physio','Session',32.00);
/*!40000 ALTER TABLE `membership_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_options`
--

DROP TABLE IF EXISTS `membership_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gym` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_options`
--

LOCK TABLES `membership_options` WRITE;
/*!40000 ALTER TABLE `membership_options` DISABLE KEYS */;
INSERT INTO `membership_options` VALUES (35,'ugym','joining_fee','Joining fee',10.00),(36,'ugym','membership','Super-off peak',16.00),(37,'ugym','membership','Off-peak',21.00),(38,'ugym','membership','Anytime',30.00),(39,'ugym','swim_without','Standard',25.00),(40,'ugym','swim_with','Standard',15.00),(41,'ugym','classes_without','Standard',20.00),(42,'ugym','classes_with','Standard',10.00),(43,'ugym','massage_without','Standard',30.00),(44,'ugym','massage_with','Standard',25.00),(45,'ugym','physio_without','Standard',25.00),(46,'ugym','physio_with','Standard',20.00),(47,'powerzone','joining_fee','Joining fee',30.00),(48,'powerzone','membership','Super-off peak',13.00),(49,'powerzone','membership','Off-peak',19.00),(50,'powerzone','membership','Anytime',24.00),(51,'powerzone','swim_without','Standard',20.00),(52,'powerzone','swim_with','Standard',12.50),(53,'powerzone','classes_without','Standard',20.00),(54,'powerzone','classes_with','Standard',0.00),(55,'powerzone','massage_without','Standard',30.00),(56,'powerzone','massage_with','Standard',25.00),(57,'powerzone','physio_without','Standard',30.00),(58,'powerzone','physio_with','Standard',25.00);
/*!40000 ALTER TABLE `membership_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberships` (
  `id` int NOT NULL AUTO_INCREMENT,
  `membership_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `is_student` tinyint(1) DEFAULT NULL,
  `chosen_gym` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addons` text COLLATE utf8mb4_unicode_ci,
  `final_cost` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES (1,'be17a453dc804f60a4d99b5a1d99e451',18,1,'powerzone','Anytime','massage:30min',74.80,'2026-01-21 20:03:42'),(2,'313aef4c2927468698ea5f76e58ba9e1',18,1,'ugym','Anytime','massage:30min',70.00,'2026-01-21 20:04:00'),(3,'bf131744d35b48fbb58c9a1c561a2e08',18,1,'ugym','Anytime','massage:30min',70.00,'2026-01-21 20:06:08'),(4,'3e7ba43a9f07495d9415bc2babfe0644',20,1,'powerzone','Anytime','',50.40,'2026-01-21 20:18:04'),(5,'206af929daa744088c39e629fc10beb7',18,1,'ugym','Anytime','',34.00,'2026-01-21 20:38:07');
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-21 20:48:58
