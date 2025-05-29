-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: my_robenoltl2_project2024_2025
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `EXPORTED_REPORTS`
--

DROP TABLE IF EXISTS `EXPORTED_REPORTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EXPORTED_REPORTS` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_id` int NOT NULL,
  `export_format` enum('Excel','Word','PDF') NOT NULL,
  `export_path` varchar(255) NOT NULL,
  `exported_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `EXPORTED_REPORTS_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `GENERATED_REPORTS` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EXPORTED_REPORTS`
--

LOCK TABLES `EXPORTED_REPORTS` WRITE;
/*!40000 ALTER TABLE `EXPORTED_REPORTS` DISABLE KEYS */;
INSERT INTO `EXPORTED_REPORTS` VALUES (1,1,'Excel','C:/Users/kdch1/OneDrive/Escritorio/test\\NEW.xlsx','2025-03-24 17:17:28'),(2,1,'Word','C:/Users/kdch1/OneDrive/Escritorio/test\\new2.docx','2025-03-24 17:19:29'),(3,1,'PDF','C:/Users/kdch1/OneDrive/Escritorio/test\\new3.pdf','2025-03-24 17:19:50'),(4,2,'Word','C:/Users/super/OneDrive/Desktop\\tester.docx','2025-03-25 17:16:03'),(5,2,'PDF','C:/Users/super/OneDrive/Desktop\\tester.pdf','2025-03-25 17:16:26');
/*!40000 ALTER TABLE `EXPORTED_REPORTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENERATED_REPORTS`
--

DROP TABLE IF EXISTS `GENERATED_REPORTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENERATED_REPORTS` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `program_title_id` int DEFAULT NULL,
  `main_category_id` int DEFAULT NULL,
  `sub_category_id` int DEFAULT NULL,
  `bucket_key` varchar(255) DEFAULT NULL,
  `bucket_val` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `report_status` enum('Pending','Completed') DEFAULT 'Pending',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `program_title_id` (`program_title_id`),
  KEY `main_category_id` (`main_category_id`),
  KEY `sub_category_id` (`sub_category_id`),
  CONSTRAINT `GENERATED_REPORTS_ibfk_1` FOREIGN KEY (`program_title_id`) REFERENCES `PROGRAM_TITLES` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `GENERATED_REPORTS_ibfk_2` FOREIGN KEY (`main_category_id`) REFERENCES `MAIN_CATEGORY` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `GENERATED_REPORTS_ibfk_3` FOREIGN KEY (`sub_category_id`) REFERENCES `SUB_CATEGORY` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENERATED_REPORTS`
--

LOCK TABLES `GENERATED_REPORTS` WRITE;
/*!40000 ALTER TABLE `GENERATED_REPORTS` DISABLE KEYS */;
INSERT INTO `GENERATED_REPORTS` VALUES (1,'test',NULL,6,NULL,'Audience',3000,'2025-03-04','2025-03-24','Pending','2025-03-24 17:16:27'),(2,'test2',NULL,6,NULL,'Audience',3000,'2025-03-11','2025-03-25','Pending','2025-03-24 21:18:01');
/*!40000 ALTER TABLE `GENERATED_REPORTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MAIN_CATEGORY`
--

DROP TABLE IF EXISTS `MAIN_CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MAIN_CATEGORY` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `TitleId` int NOT NULL,
  PRIMARY KEY (`Name`,`TitleId`),
  UNIQUE KEY `Id` (`Id`),
  KEY `TitleId` (`TitleId`),
  CONSTRAINT `MAIN_CATEGORY_ibfk_1` FOREIGN KEY (`TitleId`) REFERENCES `PROGRAM_TITLES` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MAIN_CATEGORY`
--

LOCK TABLES `MAIN_CATEGORY` WRITE;
/*!40000 ALTER TABLE `MAIN_CATEGORY` DISABLE KEYS */;
INSERT INTO `MAIN_CATEGORY` VALUES (21,'Social Media',20),(22,'Websites',20),(23,'Social Media',21),(24,'Websites',21);
/*!40000 ALTER TABLE `MAIN_CATEGORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERMITTED_BKT_KEY`
--

DROP TABLE IF EXISTS `PERMITTED_BKT_KEY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERMITTED_BKT_KEY` (
  `MainId` int NOT NULL,
  `BktKey` varchar(255) NOT NULL,
  PRIMARY KEY (`MainId`,`BktKey`),
  CONSTRAINT `PERMITTED_BKT_KEY_ibfk_1` FOREIGN KEY (`MainId`) REFERENCES `MAIN_CATEGORY` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERMITTED_BKT_KEY`
--

LOCK TABLES `PERMITTED_BKT_KEY` WRITE;
/*!40000 ALTER TABLE `PERMITTED_BKT_KEY` DISABLE KEYS */;
INSERT INTO `PERMITTED_BKT_KEY` VALUES (21,'Comments'),(21,'Likes'),(21,'Shares'),(22,'Comments'),(22,'Visitors'),(23,'Engagement'),(23,'Followers'),(23,'Posts');
/*!40000 ALTER TABLE `PERMITTED_BKT_KEY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROGRAM_TITLES`
--

DROP TABLE IF EXISTS `PROGRAM_TITLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROGRAM_TITLES` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROGRAM_TITLES`
--

LOCK TABLES `PROGRAM_TITLES` WRITE;
/*!40000 ALTER TABLE `PROGRAM_TITLES` DISABLE KEYS */;
INSERT INTO `PROGRAM_TITLES` VALUES (20,'Awareness'),(25,'Care'),(21,'Family');
/*!40000 ALTER TABLE `PROGRAM_TITLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUB_CATEGORY`
--

DROP TABLE IF EXISTS `SUB_CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUB_CATEGORY` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `MainId` int NOT NULL,
  PRIMARY KEY (`Name`,`MainId`),
  UNIQUE KEY `Id` (`Id`),
  KEY `MainId` (`MainId`),
  CONSTRAINT `SUB_CATEGORY_ibfk_1` FOREIGN KEY (`MainId`) REFERENCES `MAIN_CATEGORY` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUB_CATEGORY`
--

LOCK TABLES `SUB_CATEGORY` WRITE;
/*!40000 ALTER TABLE `SUB_CATEGORY` DISABLE KEYS */;
INSERT INTO `SUB_CATEGORY` VALUES (12,'Instagram',23),(13,'Facebook',23),(14,'Company Website',24),(15,'Blog',24),(16,'Facebook',21);
/*!40000 ALTER TABLE `SUB_CATEGORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUB_CAT_BKT_KEY_VALS`
--

DROP TABLE IF EXISTS `SUB_CAT_BKT_KEY_VALS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUB_CAT_BKT_KEY_VALS` (
  `SubId` int NOT NULL,
  `BktKey` varchar(255) NOT NULL,
  `inputDate` date NOT NULL DEFAULT (curdate()),
  `BktVal` int NOT NULL,
  PRIMARY KEY (`SubId`,`BktKey`,`inputDate`),
  CONSTRAINT `SUB_CAT_BKT_KEY_VALS_ibfk_1` FOREIGN KEY (`SubId`) REFERENCES `SUB_CATEGORY` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUB_CAT_BKT_KEY_VALS`
--

LOCK TABLES `SUB_CAT_BKT_KEY_VALS` WRITE;
/*!40000 ALTER TABLE `SUB_CAT_BKT_KEY_VALS` DISABLE KEYS */;
INSERT INTO `SUB_CAT_BKT_KEY_VALS` VALUES (12,'Engagement','2025-03-29',300),(12,'Followers','2025-03-29',1500),(12,'Posts','2025-03-29',25),(13,'Followers','2025-03-29',1200),(13,'Posts','2025-03-29',20),(16,'Comments','2025-04-01',750);
/*!40000 ALTER TABLE `SUB_CAT_BKT_KEY_VALS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buckets`
--

DROP TABLE IF EXISTS `buckets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bucket_name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buckets`
--

LOCK TABLES `buckets` WRITE;
/*!40000 ALTER TABLE `buckets` DISABLE KEYS */;
INSERT INTO `buckets` VALUES (1,'Testbucket','2024-11-25 22:06:59'),(2,'Testbucket2','2024-11-26 12:37:28');
/*!40000 ALTER TABLE `buckets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Tester1'),(3,''),(4,'Test2'),(5,'Wellness'),(6,'Tester1'),(7,'Healthcare');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_category_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `main_category_id` (`main_category_id`),
  CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`main_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (4,1,'TestSubCat'),(5,1,'TestSub'),(7,1,'Awareness'),(9,3,'Med exams');
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'nyseem3','05ac2cade2504071d90e1e79f8074c14183ab11eb13b2c5bc255dd3e88d34235','Nyseem Roberson','Admin'),(2,'tr2','93915a0a4bf8f634cb1856494dd4304472ad46b9827f541f76b6761c49cc55b0','Truong Pham','Admin'),(6,'tr3','299408b5ac7c141fc48e1074f6838c5b3515b4ed05d379a664d04996d15371c1',NULL,'User'),(7,'tr4','9d14dfa297f70afcfe3606a53eeed84aa4f29ee94bb7c23e7d916e3efa0d8629',NULL,'User');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-01  2:44:37
