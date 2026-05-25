-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: myatm
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `accountinfo`
--

DROP TABLE IF EXISTS `accountinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accountinfo` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `pin` varchar(4) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountinfo`
--

LOCK TABLES `accountinfo` WRITE;
/*!40000 ALTER TABLE `accountinfo` DISABLE KEYS */;
INSERT INTO `accountinfo` VALUES (7,'adithya','jilakara','adithya@09','2002'),(8,'siddartha','buruju','siddu','1234'),(9,'kameshwar rao','bursu','kamesh','1235'),(10,'yashwanth','papanuboina','yashwanth','1111');
/*!40000 ALTER TABLE `accountinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactioninfo`
--

DROP TABLE IF EXISTS `transactioninfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactioninfo` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `transactioninfo_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accountinfo` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactioninfo`
--

LOCK TABLES `transactioninfo` WRITE;
/*!40000 ALTER TABLE `transactioninfo` DISABLE KEYS */;
INSERT INTO `transactioninfo` VALUES (1,7,0.00),(2,8,0.00),(3,9,0.00),(4,7,2000.00),(5,7,1000.00),(6,7,3000.00),(7,7,5000.00),(8,7,3000.00),(9,7,5000.00),(10,7,3000.00),(11,7,5000.00),(12,10,0.00),(13,10,100000.00),(14,7,8000.00),(15,7,6000.00),(16,7,5000.00),(17,7,15000.00),(18,7,5000.00),(19,7,3000.00),(20,7,5000.00),(21,7,4500.00),(22,7,4300.00),(23,8,2002.00),(24,8,2.00);
/*!40000 ALTER TABLE `transactioninfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 14:49:23
