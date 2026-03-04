CREATE DATABASE  IF NOT EXISTS `pet_adoption_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pet_adoption_system`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pet_adoption_system
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `adopters`
--

DROP TABLE IF EXISTS `adopters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adopters` (
  `adp_id` int NOT NULL AUTO_INCREMENT,
  `adp_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'USA',
  `registration_date` date DEFAULT (curdate()),
  PRIMARY KEY (`adp_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adopters`
--

LOCK TABLES `adopters` WRITE;
/*!40000 ALTER TABLE `adopters` DISABLE KEYS */;
INSERT INTO `adopters` VALUES (1,'Emma Wilson','emma.wilson@gmail.com','617-555-1001','Boston','USA','2024-12-20'),(2,'James Taylor','james.taylor@gmail.com','617-555-1002','Brookline','USA','2025-03-22'),(3,'Olivia Martinez','olivia.m@gmail.com','617-555-1003','Cambridge','USA','2025-07-01'),(4,'William Brown','william.b@gmail.com','617-555-1004','Rhode Island','USA','2024-11-05'),(5,'Sophia Anderson','sophia.a@gmail.com','617-555-1005','Quincy','USA','2024-05-15'),(6,'Henry Carter','henry.carter@gmail.com','617-555-2001','Boston','USA','2024-09-12'),(7,'Megan Reed','megan.reed@gmail.com','617-555-2002','Cambridge','USA','2024-06-15'),(8,'Lucas Gray','lucas.gray@gmail.com','617-555-2003','Somerville','USA','2025-02-20'),(9,'Ava Scott','ava.scott@gmail.com','617-555-2004','Fenway','USA','2024-03-18'),(10,'Ryan Cooper','ryan.cooper@gmail.com','617-555-2005','Vermont','USA','2025-01-10'),(11,'Ella White','ella.white@gmail.com','617-555-3001','Boston','USA','2025-02-12'),(12,'Jack Harris','jack.harris@gmail.com','617-555-3002','Cambridge','USA','2025-03-01'),(13,'Mia Thompson','mia.thompson@gmail.com','617-555-3003','Brookline','USA','2024-11-25'),(14,'Noah King','noah.king@gmail.com','617-555-3004','Somerville','USA','2025-01-05'),(15,'hari','hari@gmail.com','6178569285','Mumbai','India','2025-11-30'),(16,'','','','','USA','2025-11-30');
/*!40000 ALTER TABLE `adopters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `pet_id` int NOT NULL,
  `adp_id` int NOT NULL,
  `app_date` date NOT NULL DEFAULT (curdate()),
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `staff_id` int DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `unique_pet_adopter` (`pet_id`,`adp_id`),
  KEY `adp_id` (`adp_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`adp_id`) REFERENCES `adopters` (`adp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `application_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,3,1,'2024-11-15','Pending',3,NULL,'First time adopter, needs home visit'),(2,6,2,'2024-07-20','Approved',1,'2024-07-25','Excellent home environment'),(3,1,3,'2024-11-18','Approved',2,'2025-12-04','Awaiting review\n[2025-12-04] Good person'),(5,9,5,'2024-11-16','Rejected',2,'2025-12-03','Interested in bird adoption\n[2025-12-03] Not good apartment '),(6,12,6,'2024-08-05','Rejected',2,'2025-12-04','Interested in rabbit\n[2025-12-04] No good place to keep cat '),(7,7,7,'2024-12-01','Approved',1,'2025-01-03','Great adopter'),(8,2,11,'2024-10-05','Approved',2,'2024-10-08','Excellent home environment'),(9,4,12,'2024-09-18','Approved',1,'2025-09-10','Adopter has previous pet experience'),(10,10,8,'2024-11-25','Rejected',4,'2025-10-28','Not suitable'),(11,8,13,'2024-12-02','Approved',3,'2024-12-05','Great match for the cat'),(12,9,14,'2024-10-22','Approved',5,'2023-10-25','Perfect fit for family with kids'),(13,14,10,'2024-12-15','Approved',3,'2025-12-03','Excited about adoption\n[2025-12-03] good place  A PET '),(14,18,12,'2025-11-30','Approved',4,'2025-11-30','I want a companion pet for my other cat \n[2025-11-30] good animal lover person ');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_before_application_insert` BEFORE INSERT ON `application` FOR EACH ROW BEGIN
    DECLARE pet_status VARCHAR(20);
    SELECT status INTO pet_status FROM Pets WHERE pet_id = NEW.pet_id;
    IF pet_status = 'Adopted' THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Cannot apply for an adopted pet';
    END IF;
    -- Set default application date if not provided
    IF NEW.app_date IS NULL THEN
	SET NEW.app_date = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_after_application_approval` AFTER UPDATE ON `application` FOR EACH ROW BEGIN
IF NEW.status = 'Approved' AND OLD.status != 'Approved' THEN
-- Ensure pet is marked as adopted (redundant safety check)
	UPDATE Pets 
	SET status = 'Adopted', adoption_date = CURDATE()
	WHERE pet_id = NEW.pet_id AND status != 'Adopted';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `breeds`
--

DROP TABLE IF EXISTS `breeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breeds` (
  `breed_id` int NOT NULL AUTO_INCREMENT,
  `breed_name` varchar(100) NOT NULL,
  `species_id` int NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`breed_id`),
  UNIQUE KEY `unique_breed_species` (`breed_name`,`species_id`),
  KEY `species_id` (`species_id`),
  CONSTRAINT `breeds_ibfk_1` FOREIGN KEY (`species_id`) REFERENCES `species` (`species_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `breeds`
--

LOCK TABLES `breeds` WRITE;
/*!40000 ALTER TABLE `breeds` DISABLE KEYS */;
INSERT INTO `breeds` VALUES (1,'Golden Retriever',1,'Friendly and intelligent dog breed','2025-11-28 06:52:21'),(2,'Labrador Retriever',1,'Outgoing and active dog','2025-11-28 06:52:21'),(3,'Husky',1,'Energetic and friendly','2025-11-28 06:52:21'),(4,'German Shepherd',1,'Confident and courageous','2025-11-28 06:52:21'),(5,'Beagle',1,'Curious and friendly','2025-11-28 06:52:21'),(6,'Persian Cat',2,'Quiet and sweet-tempered','2025-11-28 06:52:21'),(7,'Siamese Cat',2,'Vocal and affectionate','2025-11-28 06:52:21'),(8,'Maine Coon',2,'Gentle giants','2025-11-28 06:52:21'),(9,'Bulldog',1,'Calm and courageous','2025-11-28 06:52:21'),(10,'Poodle',1,'Intelligent and active','2025-11-28 06:52:21'),(11,'Sphynx',2,'Hairless and affectionate','2025-11-28 06:52:21'),(12,'Cockatoo',3,'Playful and talkative','2025-11-28 06:52:21'),(13,'Rex Rabbit',4,'Soft fur and friendly','2025-11-28 06:52:21'),(14,'Parakeet',3,'Social and intelligent','2025-11-28 06:52:21'),(15,'Cockatiel',3,'Friendly and easy to care for','2025-11-28 06:52:21'),(16,'Holland Lop',4,'Compact and friendly rabbit','2025-11-28 06:52:21'),(17,'American Guinea Pig',5,'Gentle and social','2025-11-28 06:52:21');
/*!40000 ALTER TABLE `breeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets` (
  `pet_id` int NOT NULL AUTO_INCREMENT,
  `pet_name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `status` enum('Available','Adopted','Under Review') DEFAULT 'Available',
  `species_id` int NOT NULL,
  `breed_id` int NOT NULL,
  `shelter_id` int NOT NULL,
  `intake_date` date DEFAULT (curdate()),
  `adoption_date` date DEFAULT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `species_id` (`species_id`),
  KEY `breed_id` (`breed_id`),
  KEY `shelter_id` (`shelter_id`),
  CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`species_id`) REFERENCES `species` (`species_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pets_ibfk_2` FOREIGN KEY (`breed_id`) REFERENCES `breeds` (`breed_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pets_ibfk_3` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pets_chk_1` CHECK (((`age` >= 0) and (`age` <= 30)))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES (1,'Max',3,'Male','Adopted',1,1,1,'2024-10-01','2025-12-04'),(2,'Bella',2,'Female','Available',1,2,1,'2024-10-15',NULL),(3,'Charlie',4,'Male','Under Review',1,3,2,'2024-09-20',NULL),(4,'Luna',2,'Female','Available',2,5,3,'2025-06-01',NULL),(5,'Cooper',5,'Male','Available',1,4,2,'2024-08-10',NULL),(6,'Daisy',2,'Female','Adopted',2,6,1,'2024-07-15',NULL),(7,'Rocky',3,'Male','Available',1,1,3,'2024-11-10',NULL),(8,'Milo',1,'Male','Available',2,7,2,'2023-10-25',NULL),(9,'Tweety',2,'Female','Available',3,8,3,'2025-05-05',NULL),(10,'Sunny',1,'Male','Available',3,9,1,'2024-01-30',NULL),(11,'Fluffy',3,'Female','Available',4,10,2,'2024-09-15',NULL),(12,'Coco',1,'Female','Available',5,11,3,'2023-11-12',NULL),(13,'Buddy',6,'Male','Available',1,12,1,'2024-10-10',NULL),(14,'Nala',3,'Female','Adopted',2,13,1,'2024-10-12','2025-12-03'),(15,'Ghost',2,'Male','Available',1,7,2,'2024-08-12',NULL),(16,'Misty',4,'Female','Adopted',2,6,3,'2024-05-25',NULL),(17,'Pablo',1,'Male','Available',3,14,2,'2025-01-01',NULL),(18,'Choco',3,'Female','Adopted',4,15,1,'2024-07-07','2025-11-30'),(19,'Snowy',2,'Female','Available',5,11,3,'2023-12-12',NULL),(20,'Shadow',5,'Male','Under Review',1,4,2,'2024-07-30',NULL),(21,'Whiskers',2,'Male','Available',2,7,3,'2024-11-01',NULL),(22,'Ruby',1,'Female','Available',3,9,1,'2025-02-05',NULL),(23,'Willow',3,'Male','Available',1,1,2,'2025-11-28',NULL),(24,'Lucky',7,'Female','Available',2,11,3,'2025-11-30',NULL),(27,'Max',5,'Female','Available',3,14,2,'2025-12-03',NULL),(28,'Criky',4,'Male','Available',3,14,1,'2025-12-03',NULL),(31,'rose',4,'Male','Available',2,8,3,'2025-12-04',NULL);
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_before_pet_delete` BEFORE DELETE ON `pets` FOR EACH ROW BEGIN
    DECLARE pending_count INT;
    SELECT COUNT(*) INTO pending_count
    FROM Application
    WHERE pet_id = OLD.pet_id AND status = 'Pending';
    IF pending_count > 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Cannot delete pet with pending applications';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shelter`
--

DROP TABLE IF EXISTS `shelter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter` (
  `shelter_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `capacity` int DEFAULT '50',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`shelter_id`),
  UNIQUE KEY `phone` (`phone`),
  CONSTRAINT `shelter_chk_1` CHECK ((`capacity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter`
--

LOCK TABLES `shelter` WRITE;
/*!40000 ALTER TABLE `shelter` DISABLE KEYS */;
INSERT INTO `shelter` VALUES (1,'Happy Paws Shelter','Boston','617-555-0101',100,'2025-11-28 06:52:21'),(2,'Safe Haven Animal Rescue','Cambridge','617-555-0102',75,'2025-11-28 06:52:21'),(3,'Furry Friends Sanctuary','Brookline','617-555-0103',50,'2025-11-28 06:52:21');
/*!40000 ALTER TABLE `shelter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `species` (
  `species_id` int NOT NULL AUTO_INCREMENT,
  `species_name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`species_id`),
  UNIQUE KEY `species_name` (`species_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` VALUES (1,'Dog','2025-11-28 06:52:21'),(2,'Cat','2025-11-28 06:52:21'),(3,'Bird','2025-11-28 06:52:21'),(4,'Rabbit','2025-11-28 06:52:21'),(5,'Guinea Pig','2025-11-28 06:52:21');
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `shelter_id` int NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT (curdate()),
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email` (`email`),
  KEY `shelter_id` (`shelter_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'John Smith','Manager',1,'john.smith@happypaws.org','2020-01-15','2025-11-28 06:52:21'),(2,'Sarah Johnson','Veterinarian',1,'sarah.j@happypaws.org','2021-03-20','2025-11-28 06:52:21'),(3,'Mike Brown','Adoption Coordinator',2,'mike.b@safehaven.org','2019-06-10','2025-11-28 06:52:21'),(4,'Emily Davis','Manager',2,'emily.d@safehaven.org','2018-09-05','2025-11-28 06:52:21'),(5,'Chris Wilson','Volunteer Coordinator',3,'chris.w@furryfriends.org','2022-02-14','2025-11-28 06:52:21'),(6,'Laura Green','Veterinarian',3,'laura.green@furryfriends.org','2021-01-10','2025-11-28 06:52:21'),(7,'Daniel Evans','Manager',1,'daniel.evans@happypaws.org','2017-05-19','2025-11-28 06:52:21'),(8,'Rebecca Turner','Adoption Coordinator',2,'rebecca.t@safehaven.org','2020-11-22','2025-11-28 06:52:21');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_pets_detailed`
--

DROP TABLE IF EXISTS `vw_pets_detailed`;
/*!50001 DROP VIEW IF EXISTS `vw_pets_detailed`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pets_detailed` AS SELECT 
 1 AS `pet_id`,
 1 AS `pet_name`,
 1 AS `age`,
 1 AS `gender`,
 1 AS `status`,
 1 AS `species_name`,
 1 AS `breed_name`,
 1 AS `shelter_name`,
 1 AS `shelter_city`,
 1 AS `intake_date`,
 1 AS `adoption_date`,
 1 AS `days_in_shelter`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'pet_adoption_system'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `event_cleanup_old_applications` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `event_cleanup_old_applications` ON SCHEDULE EVERY 1 DAY STARTS '2025-11-28 01:52:34' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
-- Delete applications rejected more than 6 months ago
DELETE FROM Application
WHERE status = 'Rejected' 
AND review_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'pet_adoption_system'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_adopter_application_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_adopter_application_count`(p_adp_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE app_count INT;
    SELECT COUNT(*) INTO app_count 
    FROM Application 
    WHERE adp_id = p_adp_id;
    RETURN app_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_avg_pet_age_by_species` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_avg_pet_age_by_species`(p_species_id INT) RETURNS decimal(5,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE avg_age DECIMAL(5,2);
    SELECT AVG(age) INTO avg_age
    FROM Pets
    WHERE species_id = p_species_id;
    RETURN IFNULL(avg_age, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_count_pets_by_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_count_pets_by_status`(p_status VARCHAR(20)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE pet_count INT;
    SELECT COUNT(*) INTO pet_count 
    FROM Pets 
    WHERE status = p_status;
    RETURN pet_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_shelter_occupancy_rate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_shelter_occupancy_rate`(p_shelter_id INT) RETURNS decimal(5,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE current_pets INT;
    DECLARE max_capacity INT;
    DECLARE occupancy_rate DECIMAL(5,2);
    SELECT COUNT(*) INTO current_pets 
    FROM Pets 
    WHERE shelter_id = p_shelter_id AND status != 'Adopted';
    SELECT capacity INTO max_capacity 
    FROM Shelter 
    WHERE shelter_id = p_shelter_id;
    IF max_capacity > 0 THEN
        SET occupancy_rate = (current_pets / max_capacity) * 100;
    ELSE
        SET occupancy_rate = 0;
    END IF;
    RETURN occupancy_rate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_adopter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_adopter`(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_city VARCHAR(100),
    IN p_country VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error adding adopter - email may already exist';
    END;
    START TRANSACTION;
    INSERT INTO Adopters (adp_name, email, phone, city, country)
    VALUES (p_name, p_email, p_phone, p_city, p_country);
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_pet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_pet`(
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_species_id INT,
    IN p_breed_id INT,
    IN p_shelter_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error adding pet to database';
    END;
    START TRANSACTION;
    -- Validate inputs
    IF p_age < 0 OR p_age > 30 THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Invalid age: must be between 0 and 30';
    END IF;
    INSERT INTO Pets (pet_name, age, gender, species_id, breed_id, shelter_id)
    VALUES (p_name, p_age, p_gender, p_species_id, p_breed_id, p_shelter_id);
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_pet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_pet`(IN p_pet_id INT)
BEGIN
DECLARE v_pet_status VARCHAR(20);
DECLARE v_pending_apps INT;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error deleting pet';
END;    
START TRANSACTION;
-- Check pet status
SELECT status INTO v_pet_status FROM Pets WHERE pet_id = p_pet_id;
IF v_pet_status IS NULL THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Pet does not exist';
END IF;
IF v_pet_status = 'Adopted' THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Cannot delete adopted pet - archive instead';
END IF;
-- Check for pending applications
SELECT COUNT(*) INTO v_pending_apps 
FROM Application 
WHERE pet_id = p_pet_id AND status = 'Pending';
IF v_pending_apps > 0 THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Cannot delete pet with pending applications';
END IF;
DELETE FROM Pets WHERE pet_id = p_pet_id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_available_pets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_available_pets`(
    IN p_species_id INT,
    IN p_breed_id INT
)
BEGIN
    IF p_species_id IS NOT NULL AND p_breed_id IS NOT NULL THEN
	SELECT p.pet_id, p.pet_name, p.age, p.gender, 
	s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available' 
	AND p.species_id = p_species_id 
	AND p.breed_id = p_breed_id
	ORDER BY p.intake_date DESC;
    ELSEIF p_species_id IS NOT NULL THEN
	SELECT p.pet_id, p.pet_name, p.age, p.gender, s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available' AND p.species_id = p_species_id
	ORDER BY p.intake_date DESC;
    ELSE
	SELECT p.pet_id, p.pet_name, p.age, p.gender, s.species_name, b.breed_name, sh.name as shelter_name, sh.city, p.intake_date
	FROM Pets p
	JOIN Species s ON p.species_id = s.species_id
	JOIN Breeds b ON p.breed_id = b.breed_id
	JOIN Shelter sh ON p.shelter_id = sh.shelter_id
	WHERE p.status = 'Available'
	ORDER BY p.intake_date DESC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_submit_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_submit_application`(
    IN p_pet_id INT,
    IN p_adp_id INT,
    IN p_notes TEXT
)
BEGIN
    DECLARE v_pet_status VARCHAR(20);
    DECLARE v_existing_app INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error submitting application';
    END;
    START TRANSACTION;
    -- Check if pet exists and is available
    SELECT status INTO v_pet_status FROM Pets WHERE pet_id = p_pet_id;
    IF v_pet_status IS NULL THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Pet does not exist';
    END IF;
    IF v_pet_status != 'Available' THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Pet is not available for adoption';
    END IF;
    -- Check for duplicate application
    SELECT COUNT(*) INTO v_existing_app 
    FROM Application 
    WHERE pet_id = p_pet_id AND adp_id = p_adp_id;
    IF v_existing_app > 0 THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Application already exists for this pet';
    END IF;
    -- Insert application
    INSERT INTO Application (pet_id, adp_id, app_date, status, notes)
    VALUES (p_pet_id, p_adp_id, CURDATE(), 'Pending', p_notes);
    -- Update pet status
    UPDATE Pets SET status = 'Under Review' WHERE pet_id = p_pet_id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_application_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_application_status`(
    IN p_app_id INT,
    IN p_status VARCHAR(20),
    IN p_staff_id INT,
    IN p_notes TEXT
)
BEGIN
    DECLARE v_pet_id INT;
    DECLARE v_current_status VARCHAR(20);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Error updating application status';
    END;
    START TRANSACTION;
    SELECT pet_id, status INTO v_pet_id, v_current_status
    FROM Application WHERE app_id = p_app_id;
    IF v_pet_id IS NULL THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Application does not exist';
    END IF;
    -- Update application
    UPDATE Application 
    SET status = p_status, 
	staff_id = p_staff_id,
	review_date = CURDATE(),
	notes = CONCAT(IFNULL(notes, ''), '\n[', CURDATE(), '] ', p_notes)
    WHERE app_id = p_app_id;
    -- Update pet status based on application decision
    IF p_status = 'Approved' THEN
	UPDATE Pets 
	SET status = 'Adopted', adoption_date = CURDATE() 
	WHERE pet_id = v_pet_id;
	-- Reject all other pending applications for this pet
	UPDATE Application
	SET status = 'Rejected',
	notes = CONCAT(IFNULL(notes, ''), '\n[', CURDATE(), '] Auto-rejected: Pet was adopted')
	WHERE pet_id = v_pet_id AND app_id != p_app_id AND status = 'Pending';
    ELSEIF p_status = 'Rejected' THEN
	-- Check if there are other pending applications
	IF NOT EXISTS (SELECT 1 FROM Application WHERE pet_id = v_pet_id AND status = 'Pending' AND app_id != p_app_id) THEN
		UPDATE Pets SET status = 'Available' WHERE pet_id = v_pet_id;
		END IF;
    END IF;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_pet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_pet`(
    IN p_pet_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_shelter_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error updating pet information';
    END;
    START TRANSACTION;
    IF p_age < 0 OR p_age > 30 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid age: must be between 0 and 30';
    END IF;
    UPDATE Pets 
    SET pet_name = p_name, age = p_age, shelter_id = p_shelter_id
    WHERE pet_id = p_pet_id;
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Pet not found';
    END IF;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_pets_detailed`
--

/*!50001 DROP VIEW IF EXISTS `vw_pets_detailed`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pets_detailed` AS select `p`.`pet_id` AS `pet_id`,`p`.`pet_name` AS `pet_name`,`p`.`age` AS `age`,`p`.`gender` AS `gender`,`p`.`status` AS `status`,`s`.`species_name` AS `species_name`,`b`.`breed_name` AS `breed_name`,`sh`.`name` AS `shelter_name`,`sh`.`city` AS `shelter_city`,`p`.`intake_date` AS `intake_date`,`p`.`adoption_date` AS `adoption_date`,(to_days(ifnull(`p`.`adoption_date`,curdate())) - to_days(`p`.`intake_date`)) AS `days_in_shelter` from (((`pets` `p` join `species` `s` on((`p`.`species_id` = `s`.`species_id`))) join `breeds` `b` on((`p`.`breed_id` = `b`.`breed_id`))) join `shelter` `sh` on((`p`.`shelter_id` = `sh`.`shelter_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 14:30:08
