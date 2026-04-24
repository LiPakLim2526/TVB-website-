-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: tvb_charity_db
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banners` (
  `banner_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `start_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (40,'æ„›å¿ƒè¡Œå‹•','charity-action','TVB è·è—å“¡æ„›å¿ƒåŸºé‡‘çš„æœ€æ–°å‹•æ…‹èˆ‡æ…ˆå–„æ´»å‹•'),(41,'å€‹æ¡ˆæ´åŠ©','case-support','ç¤¾æœƒå„ç•Œå¼±å‹¢ç¾¤é«”çš„å€‹æ¡ˆæ´åŠ©èˆ‡å‹Ÿæ¬¾é€²åº¦'),(42,'å°ˆé¡Œå ±å°Ž','feature-report','æ·±å…¥æŽ¢è¨Žç¤¾æœƒè­°é¡Œèˆ‡å…¬ç›Šå°ˆé¡Œ');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `video_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_center_items`
--

DROP TABLE IF EXISTS `data_center_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_center_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `link_url` text,
  `display_order` int DEFAULT '0',
  `published_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_center_items`
--

LOCK TABLES `data_center_items` WRITE;
/*!40000 ALTER TABLE `data_center_items` DISABLE KEYS */;
INSERT INTO `data_center_items` VALUES (1,'援助詳情','https://www.tvb.com/thumbor/iGtzSJmUzxBkRX8vAavBP99fUnQ=/1600x900/filters:quality(80)/public/tvbcom/article/images/202412/e0fcc4c3-9684-4702-88a3-a90155305175.jpg','https://www.tvb.com/charityinfocenter-c/%E6%8F%B4%E5%8A%A9%E8%A9%B3%E6%83%85-1004283',3,'2026-04-24 09:26:23'),(2,'無綫電視暨職藝員愛心基金','https://www.tvb.com/thumbor/gakocLO0px_yZTGdilaKVYhlK00=/1600x900/filters:quality(80)/public/tvbcom/article/images/202507/d279ec00-899b-4b58-b916-786b152cb58a.jpg','https://www.tvb.com/charityinfocenter-c/TVB%E6%84%9B%E5%BF%83%E7%BE%A9%E5%B7%A5%E9%9A%8A%E7%9A%84%E7%9A%84%E8%B5%B7%E6%BA%90%E5%8F%8A%E6%9C%8D%E5%8B%99%E5%AE%97%E6%97%A8-1004280',2,'2026-04-24 09:26:48');
/*!40000 ALTER TABLE `data_center_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_articles`
--

DROP TABLE IF EXISTS `news_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_articles` (
  `article_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `published_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `image_url` varchar(255) DEFAULT NULL,
  `view_count` int DEFAULT '0',
  `link_url` text,
  `display_order` int DEFAULT '0',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_articles`
--

LOCK TABLES `news_articles` WRITE;
/*!40000 ALTER TABLE `news_articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'å¤§åŸ”å®ç¦è‹‘'),(2,'é€æš–è¡Œå‹•'),(3,'ç·Šæ€¥æ´åŠ©'),(4,'é’å°‘å¹´'),(5,'å¤§åŸ”å®ç¦è‹‘'),(6,'é€æš–è¡Œå‹•'),(7,'ç·Šæ€¥æ´åŠ©'),(8,'é’å°‘å¹´'),(9,'å¤§åŸ”å®ç¦è‹‘'),(10,'é€æš–è¡Œå‹•'),(11,'ç·Šæ€¥æ´åŠ©'),(12,'é’å°‘å¹´'),(13,'å¤§åŸ”å®ç¦è‹‘'),(14,'é€æš–è¡Œå‹•'),(15,'ç·Šæ€¥æ´åŠ©'),(16,'é’å°‘å¹´'),(17,'å¤§åŸ”å®ç¦è‹‘'),(18,'é€æš–è¡Œå‹•'),(19,'ç·Šæ€¥æ´åŠ©'),(20,'é’å°‘å¹´'),(21,'å¤§åŸ”å®ç¦è‹‘'),(22,'é€æš–è¡Œå‹•'),(23,'ç·Šæ€¥æ´åŠ©'),(24,'é’å°‘å¹´'),(25,'å¤§åŸ”å®ç¦è‹‘'),(26,'é€æš–è¡Œå‹•'),(27,'ç·Šæ€¥æ´åŠ©'),(28,'é’å°‘å¹´'),(29,'å¤§åŸ”å®ç¦è‹‘'),(30,'é€æš–è¡Œå‹•'),(31,'ç·Šæ€¥æ´åŠ©'),(32,'é’å°‘å¹´'),(33,'å¤§åŸ”å®ç¦è‹‘'),(34,'é€æš–è¡Œå‹•'),(35,'ç·Šæ€¥æ´åŠ©'),(36,'é’å°‘å¹´'),(37,'å¤§åŸ”å®ç¦è‹‘'),(38,'é€æš–è¡Œå‹•'),(39,'ç·Šæ€¥æ´åŠ©'),(40,'é’å°‘å¹´'),(41,'å¤§åŸ”å®ç¦è‹‘'),(42,'é€æš–è¡Œå‹•'),(43,'ç·Šæ€¥æ´åŠ©'),(44,'é’å°‘å¹´'),(45,'å¤§åŸ”å®ç¦è‹‘'),(46,'é€æš–è¡Œå‹•'),(47,'ç·Šæ€¥æ´åŠ©'),(48,'é’å°‘å¹´'),(49,'å¤§åŸ”å®ç¦è‹‘'),(50,'é€æš–è¡Œå‹•'),(51,'ç·Šæ€¥æ´åŠ©'),(52,'é’å°‘å¹´'),(53,'å¤§åŸ”å®ç¦è‹‘'),(54,'é€æš–è¡Œå‹•'),(55,'ç·Šæ€¥æ´åŠ©'),(56,'é’å°‘å¹´');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_tags`
--

DROP TABLE IF EXISTS `video_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_tags` (
  `video_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`video_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_tags`
--

LOCK TABLES `video_tags` WRITE;
/*!40000 ALTER TABLE `video_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `video_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `views` int DEFAULT '0',
  `release_date` date DEFAULT NULL,
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-24 15:32:02
