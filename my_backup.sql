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

-- Dump completed on 2026-04-25  6:02:00
