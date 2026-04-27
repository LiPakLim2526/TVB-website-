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
-- Table structure for table `access_logs`
--

DROP TABLE IF EXISTS `access_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `login_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `access_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_logs`
--

LOCK TABLES `access_logs` WRITE;
/*!40000 ALTER TABLE `access_logs` DISABLE KEYS */;
INSERT INTO `access_logs` VALUES (1,11,'2026-04-27 10:04:56','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),(2,12,'2026-04-27 10:05:05','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),(3,12,'2026-04-27 10:24:35','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),(4,12,'2026-04-27 10:34:39','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),(5,12,'2026-04-27 10:34:52','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),(6,12,'2026-04-27 10:35:38','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
/*!40000 ALTER TABLE `access_logs` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES (2,'無綫電視暨職藝員愛心基金','https://www.tvb.com/thumbor/gakocLO0px_yZTGdilaKVYhlK00=/1600x900/filters:quality(80)/public/tvbcom/article/images/202507/d279ec00-899b-4b58-b916-786b152cb58a.jpg','https://www.tvb.com/charityinfocenter-c/TVB%E6%84%9B%E5%BF%83%E7%BE%A9%E5%B7%A5%E9%9A%8A%E7%9A%84%E7%9A%84%E8%B5%B7%E6%BA%90%E5%8F%8A%E6%9C%8D%E5%8B%99%E5%AE%97%E6%97%A8-1004280',9,0,'2026-04-25 05:50:27',NULL),(3,'援助詳情','https://www.tvb.com/thumbor/iGtzSJmUzxBkRX8vAavBP99fUnQ=/1600x900/filters:quality(80)/public/tvbcom/article/images/202412/e0fcc4c3-9684-4702-88a3-a90155305175.jpg','https://www.tvb.com/charityinfocenter-c/%E6%8F%B4%E5%8A%A9%E8%A9%B3%E6%83%85-1004283',5,0,'2026-04-25 05:50:49',NULL),(4,'「善款移交暨委任愛心大使」活動','https://www.tvb.com/thumbor/DsjFz2VepzXCDv7e341YyCdDgeo=/1600x900/filters:water(21):quality(80)/public/tvbcom/article/images/202504/14991061-c824-426d-aaf7-bf289e64d843.jpg','https://www.tvb.com/eventnews-c/-%E5%96%84%E6%AC%BE%E7%A7%BB%E4%BA%A4%E6%9A%A8%E5%A7%94%E4%BB%BB%E6%84%9B%E5%BF%83%E5%A4%A7%E4%BD%BF-%E6%B4%BB%E5%8B%95-1006051',0,0,'2026-04-25 05:51:06',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_articles`
--

LOCK TABLES `news_articles` WRITE;
/*!40000 ALTER TABLE `news_articles` DISABLE KEYS */;
INSERT INTO `news_articles` VALUES (2,'無綫電視暨職藝員愛心基金「愛心送暖2026」','發佈日期：2026-02-05 17:10\r\n\r\n文章版權為電視廣播有限公司所擁有，原文請按﹕ https://www.tvb.com/1011722',NULL,'2026-04-25 05:51:28','https://www.tvb.com/thumbor/n1fyaEaigTXQJelqQkdvNowygEk=/1600x900/filters:water(21):quality(80)/public/tvbcom/article/images/202602/9042946f-d344-43bf-918d-ed0884ef3948.jpg',0,'https://www.tvb.com/eventnews-c/%E7%84%A1%E7%B6%AB%E9%9B%BB%E8%A6%96%E6%9A%A8%E8%81%B7%E8%97%9D%E5%93%A1%E6%84%9B%E5%BF%83%E5%9F%BA%E9%87%91-%E6%84%9B%E5%BF%83%E9%80%81%E6%9A%962026--1011722',10),(3,'愛心不止步 TVB愛心基金與社會各界為宏福苑受影響居民持續募款','發佈日期：2025-12-04 18:44\r\n',NULL,'2026-04-25 05:51:53','https://www.tvb.com/thumbor/D_UX7NIIE2YRu260a_X6e3fHE8w=/1600x900/filters:quality(80)/public/tvbcom/article/images/202512/dc390a0d-fcac-4d99-ac24-c378131dbfcc.jpg',0,'https://www.tvb.com/eventnews-c/%E6%84%9B%E5%BF%83%E4%B8%8D%E6%AD%A2%E6%AD%A5-TVB%E6%84%9B%E5%BF%83%E5%9F%BA%E9%87%91%E8%88%87%E7%A4%BE%E6%9C%83%E5%90%84%E7%95%8C%E7%82%BA%E5%AE%8F%E7%A6%8F%E8%8B%91%E5%8F%97%E5%BD%B1%E9%9F%BF%E5%B1%85%E6%B0%91%E6%8C%81%E7%BA%8C%E5%8B%9F%E6%AC%BE-1010512',9),(4,'TVB 電視廣播城內兩間員工餐廳12月1日全日收益不扣除成本 全數捐助「宏福苑｣ 受影響居民','發佈日期：2025-12-01 17:54\r\n',NULL,'2026-04-25 05:52:15','https://www.tvb.com/thumbor/5bhD8OHHcyk_KmNBjsH0K0to7Uc=/1600x900/filters:quality(80)/public/tvbcom/article/images/202512/08994a6c-a138-4375-a972-e9cba63ad633.jpg',0,'https://www.tvb.com/eventnews-c/TVB-%E9%9B%BB%E8%A6%96%E5%BB%A3%E6%92%AD%E5%9F%8E%E5%85%A7%E5%85%A9%E9%96%93%E5%93%A1%E5%B7%A5%E9%A4%90%E5%BB%B312%E6%9C%881%E6%97%A5%E5%85%A8%E6%97%A5%E6%94%B6%E7%9B%8A%E4%B8%8D%E6%89%A3%E9%99%A4%E6%88%90%E6%9C%AC-%E5%85%A8%E6%95%B8%E6%8D%90%E5%8A%A9-%E5%AE%8F%E7%A6%8F%E8%8B%91--%E5%8F%97%E5%BD%B1%E9%9F%BF%E5%B1%85%E6%B0%91-1010414',8),(5,'「無綫電視暨職藝員愛心基金」捐出港幣100萬元予「大埔宏福苑援助基金」','發佈日期：2025-11-28 18:22\r\n',NULL,'2026-04-25 05:52:41','https://www.tvb.com/thumbor/fHxHZg_K_B0pVaO36CDVLGgqFk4=/1600x900/filters:quality(80)/public/tvbcom/article/images/202511/46960c5d-5982-4075-b4bf-bafd97080794.jpg',0,'https://www.tvb.com/eventnews-c/-%E7%84%A1%E7%B6%AB%E9%9B%BB%E8%A6%96%E6%9A%A8%E8%81%B7%E8%97%9D%E5%93%A1%E6%84%9B%E5%BF%83%E5%9F%BA%E9%87%91-%E6%8D%90%E5%87%BA%E6%B8%AF%E5%B9%A3100%E8%90%AC%E5%85%83%E4%BA%88-%E5%A4%A7%E5%9F%94%E5%AE%8F%E7%A6%8F%E8%8B%91%E6%8F%B4%E5%8A%A9%E5%9F%BA%E9%87%91--1010380',7),(6,'「善款移交暨委任愛心大使」活動','發佈日期：2025-04-14 15:22\r\n',NULL,'2026-04-25 05:53:02','https://www.tvb.com/thumbor/DsjFz2VepzXCDv7e341YyCdDgeo=/1600x900/filters:water(21):quality(80)/public/tvbcom/article/images/202504/14991061-c824-426d-aaf7-bf289e64d843.jpg',0,'https://www.tvb.com/eventnews-c/-%E5%96%84%E6%AC%BE%E7%A7%BB%E4%BA%A4%E6%9A%A8%E5%A7%94%E4%BB%BB%E6%84%9B%E5%BF%83%E5%A4%A7%E4%BD%BF-%E6%B4%BB%E5%8B%95-1006051',6),(7,'TVB x 少年警訊慈善開年籃球友誼賽2025圓滿舉行','發佈日期：2025-03-03 11:01\r\n',NULL,'2026-04-25 05:53:26','https://www.tvb.com/thumbor/6nrqyNLZJkBWHXA16-GyKuATgxc=/1600x900/filters:quality(80)/public/tvbcom/article/images/202503/1e7e11be-0007-4b59-94fd-d9d4f9d829f4.jpg',0,'https://www.tvb.com/eventnews-c/TVB-x-%E5%B0%91%E5%B9%B4%E8%AD%A6%E8%A8%8A%E6%85%88%E5%96%84%E9%96%8B%E5%B9%B4%E7%B1%83%E7%90%83%E5%8F%8B%E8%AA%BC%E8%B3%BD2025%E5%9C%93%E6%BB%BF%E8%88%89%E8%A1%8C-1005413',5),(8,'TVB 賽馬日2025','發佈日期：2025-02-20 12:53\r\n',NULL,'2026-04-25 05:53:53','https://www.tvb.com/thumbor/RpAur2i9w4a6lW1Kc7YCG6Q1Jmw=/1600x900/filters:quality(80)/public/tvbcom/article/images/202502/933c886f-add8-4fa8-8ec9-99c45f5b1250.jpg',0,'https://www.tvb.com/eventnews-c/2025-TVB-%E8%B3%BD%E9%A6%AC%E6%97%A5-%E6%85%88%E5%96%84%E7%9B%9B%E6%9C%83%E8%88%87%E6%84%9B%E5%BF%83%E7%B1%8C%E6%AC%BE%E6%B4%BB%E5%8B%95-1005282',4),(9,'無綫電視暨職藝員愛心基金 「蛇年送暖」張濟仁主筆賀年揮春慈善義賣 善款全數撥捐愛心基金','發佈日期：2025-02-06 15:20\r\n',NULL,'2026-04-25 05:54:24','https://www.tvb.com/thumbor/ZJydzlVDudn4OF2aYgsxGSuwMoI=/1600x900/filters:quality(80)/public/tvbcom/article/images/202502/36520b25-36d4-46ce-9fdb-d340d6bf6668.jpg',0,'https://www.tvb.com/eventnews-c/%E7%84%A1%E7%B6%AB%E9%9B%BB%E8%A6%96%E6%9A%A8%E8%81%B7%E8%97%9D%E5%93%A1%E6%84%9B%E5%BF%83%E5%9F%BA%E9%87%91--%E8%9B%87%E5%B9%B4%E9%80%81%E6%9A%96-%E5%BC%B5%E6%BF%9F%E4%BB%81%E4%B8%BB%E7%AD%86%E8%B3%80%E5%B9%B4%E6%8F%AE%E6%98%A5%E6%85%88%E5%96%84%E7%BE%A9%E8%B3%A3-%E5%96%84%E6%AC%BE%E5%85%A8%E6%95%B8%E6%92%A5%E6%8D%90%E6%84%9B%E5%BF%83%E5%9F%BA%E9%87%91-1005053',0);
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
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'us','us@gmail.com','123','scrypt:32768:8:1$AMIxhvwwyt1DBpDF$9463f51f3065babe2ff27472846676bd9c928bdce1c67c492c7da4d7cf650a4335906ba8007ec64747a590158d9667970b6b36185a188bb14add162fe308fca4',0,'2026-04-25 07:45:46','2026-04-25 07:45:46'),(2,'us','us@gmail.com','123','scrypt:32768:8:1$8M5jiwwUnu3BARcO$02ced301246169191dc12f28bae7df8d308a212803d1d0d45391238461445da4e02eb8bdc258878c1393c998beb3368895891e40333fd83b1f1a8d09fb361b16',0,'2026-04-25 07:49:21','2026-04-25 07:49:21'),(3,'user','user@gmail.com','1233','scrypt:32768:8:1$IH2Blg7cYAweiinz$a72a4aeeb6a43f784659b2fd186644c4870b659661eeadf0f6b71764351196b3c50635446517e3fc20095033455a1c5b67260b34506285f7863ff60b60691baf',0,'2026-04-25 07:49:32','2026-04-25 07:49:32'),(4,'user','user@gmail.com','1233','scrypt:32768:8:1$d5I1SQJKibdG00st$523b43712c07e3ba1dcfe36603374d94a8d15fdcaafec8c559e778f25d766c5f3343a19887c8a5ded6a3c93a1c9300f4885406cde968ba02e5af50fba9cc220c',0,'2026-04-25 07:50:48','2026-04-25 07:50:48'),(5,'user','user@gmail.com','1233','scrypt:32768:8:1$iiavPH9sGxlAlGwp$11350d6aeaaf4fb04b86175e9c4bbb4c46afd8d6f6a1063a6583fa4e9fdf25e0aa6bb3b6127301dad1fc75f3618f646e99054cf328e18dc7269ca7738e4f88e5',0,'2026-04-25 07:50:55','2026-04-25 07:50:55'),(6,'user','user@gmail.com','1233','scrypt:32768:8:1$qLHvtYIJAGCfMH4C$1faa6accd58c753c6d19fb86f91db18a53f50bb15795213b320649be7ef83e0d87e5a735c5764eb63abd6c420785ab316347962ce21eb60a389fd07ff3e135be',0,'2026-04-25 07:51:17','2026-04-25 07:51:17'),(7,'user-1','user-1@gamil.com','1233','scrypt:32768:8:1$BXlmkXJ291hhABdi$e1907bc80d4a0fcaa4df1a1aaa8c281d2d48ee92f7615e378dc512f4ae27b34aab0510ec4a384cc0ea1663bf93bd9e7e4fe4f16f6bacc8984b993d93de2be5e0',0,'2026-04-25 07:51:39','2026-04-25 07:51:39'),(8,'ximenxiaotian','ximenxiaotian@gmail.com','23143214','scrypt:32768:8:1$QAmfxpP1sX52jde2$8f20cec37df56779f03c9dc90c640a30f3431165856649f775b06ec9aece9f86a14d270b3f2c69edfa6df9ceeb052a104273a74a97b81483e1ab6c29585d746b',0,'2026-04-25 07:58:20','2026-04-25 07:58:20'),(9,'ximenxiaotian','ximenxiaotian@gmail.com','1234124124','scrypt:32768:8:1$KTaVLpfTcoZpiIss$224291000b4da3716ff4c8db5e8378fc242ae2ee098e61bf79655b733bbb570d86a5ca1b66f014b9f710558500b04816a540de0fc9d7bae11d60efd30b0020c6',0,'2026-04-25 08:02:35','2026-04-25 08:02:35'),(10,'123','123@gmail.com','12314','scrypt:32768:8:1$dIQvI4nHpEzBmxjf$e73454e19a3eae677a4126d213e5b06a1bfcbc6295d40cd8b7e157a013159aa8b2e1dd542bad3f3652e0c97b7f7ff6f47d150c278d231884fde06bcc5ba6ac89',0,'2026-04-25 09:48:02','2026-04-25 09:48:02'),(11,'12344','1234@gmail.com','123456785','scrypt:32768:8:1$0JZTB2a6TmL2rKPO$66e312bb41aa14a8711090746ae63f6f43428b5950e74b80e53e0d4dce6f03a8d3a7c7b82866ad1f0b2954e08ada7c434f10902523bda02173bcec9ae2e1ea05',0,'2026-04-27 08:04:52','2026-04-27 09:11:36'),(12,'1123134774sasa','1123134774sasa@gmail.com','23143214','scrypt:32768:8:1$MJ1DRyO7WCYdTCTY$60f0dfc33c7a02b36363d90599dc982dbbf6a7fd5947d134bbb6600e112a9e1da3e5b2e035ac23983cf63d046bc71eb1077350ab5f823b4a8df8d4d776a9151b',1,'2026-04-27 09:28:00','2026-04-27 09:33:08');
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

-- Dump completed on 2026-04-27 14:14:50
