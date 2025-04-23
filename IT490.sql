-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: IT490
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
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movie_title` varchar(255) NOT NULL,
  `year` varchar(10) DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `imdb_id` varchar(20) DEFAULT NULL,
  `poster_url` text,
  `is_favorite` tinyint(1) DEFAULT '0',
  `last_searched` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imdb_id` (`imdb_id`),
  KEY `idx_user_movie` (`user_id`,`movie_title`),
  KEY `idx_imdb` (`imdb_id`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,5,'Logan','2017',NULL,'tt3315342','https://m.media-amazon.com/images/M/MV5BM2JjODdkMGMtNmY2YS00OGM2LThiY2YtZGYyNzE4Nzc2ODA0XkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(2,5,'Logan Lucky','2017',NULL,'tt5439796','https://m.media-amazon.com/images/M/MV5BMTYyODg0NDU1OV5BMl5BanBnXkFtZTgwNjcxMzU0MjI@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(3,5,'The Taking of Deborah Logan','2014',NULL,'tt3387648','https://m.media-amazon.com/images/M/MV5BNjhhNTM1OGUtYTRkZC00Mzg4LWFiY2ItYTUwMDg3NDIxYjExXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(4,5,'The Night Logan Woke Up','2022',NULL,'tt13527546','https://m.media-amazon.com/images/M/MV5BZTQ1YjU1NDMtYzg0NS00MTlmLTkyNTktOWQ1ZjA5ODQ2NDhiXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(5,5,'Super Mario Logan','2007–2021',NULL,'tt4067420','https://m.media-amazon.com/images/M/MV5BMjU5ODczYzctY2Y0Ni00NGYzLWI3ZTktOWI0ZmYxODMyZmJlXkEyXkFqcGdeQXVyNTE4MzE3ODc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(6,5,'The Two Worlds of Jennie Logan','1979',NULL,'tt0078430','https://m.media-amazon.com/images/M/MV5BNzk1ZDQ3MDUtZmI0Ny00MWY3LWJiZTktZTU1YWY0YWM5YjI1XkEyXkFqcGdeQXVyMTM0ODAyOTc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(7,5,'The Kate Logan Affair','2010',NULL,'tt1744793','https://m.media-amazon.com/images/M/MV5BMTk0ODQ0MTQyN15BMl5BanBnXkFtZTcwMzIyODMwNA@@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(8,5,'Logan Paul Vs','2016–2017',NULL,'tt6193484','https://m.media-amazon.com/images/M/MV5BY2E1ZDdkOWYtOWM1My00NjE0LWE0ODQtYzVkZTcwNjkzMGM5XkEyXkFqcGdeQXVyNTg4NDc5MTE@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(9,5,'Logan','2010',NULL,'tt1483010','https://m.media-amazon.com/images/M/MV5BNzI5NDgzNDQ3NV5BMl5BanBnXkFtZTcwODU0ODQxNA@@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(10,5,'KSI vs. Logan Paul Live at the Manchester Arena','2018',NULL,'tt8777606','https://m.media-amazon.com/images/M/MV5BMmE4OTA4YmItYzViNS00NjQ0LTllZGQtYjRjYzgyNjcwNWRkXkEyXkFqcGdeQXVyNDIzMzcwNjc@._V1_SX300.jpg',0,'2025-04-09 00:57:59','2025-04-09 00:57:59'),(11,5,'Sonic the Hedgehog','2020',NULL,'tt3794354','https://m.media-amazon.com/images/M/MV5BYTg2Yjc5MzItNzVmMi00MTllLWI2MDQtOTYyOWNjYWIxNzEzXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(12,5,'Sonic the Hedgehog 2','2022',NULL,'tt12412888','https://m.media-amazon.com/images/M/MV5BMDBiYzk0YTMtNWRiYi00YWY0LWE3NjgtYmJiYTAwZmYzOTM0XkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(13,5,'Sonic the Hedgehog 3','2024',NULL,'tt18259086','https://m.media-amazon.com/images/M/MV5BMjZjNjE5NDEtOWJjYS00Mjk2LWI1ZDYtOWI1ZWI3MzRjM2UzXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(14,5,'Sonic Boom','2014–2017',NULL,'tt3232262','https://m.media-amazon.com/images/M/MV5BNDliOTc4NDItMjg5OS00MmM0LWE1MmUtMzNmMWIzYzliM2JmXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(15,5,'Sonic X','2003–2006',NULL,'tt0367413','https://m.media-amazon.com/images/M/MV5BNzdjYTU1MWItNjY3Mi00NTNjLWIzNzctZmU5ZWQ0NGVlMTAzXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(16,5,'Sonic the Hedgehog','1993–1994',NULL,'tt0106140','https://m.media-amazon.com/images/M/MV5BYzRiMGYyYTItMmRlMC00ZmE2LTk4OTEtOTJiOWM2OTBkNGYyXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(17,5,'Adventures of Sonic the Hedgehog','1993',NULL,'tt0222518','https://m.media-amazon.com/images/M/MV5BMjczYjgyZmMtMjA4Zi00MDk5LTgwODgtOWEwODE4ZWFlZGNjXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(18,5,'Sonic Highways','2014',NULL,'tt3893538','https://m.media-amazon.com/images/M/MV5BMjE2MjkyODM4OF5BMl5BanBnXkFtZTgwNjUzMzE3MjE@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(19,5,'Sonic Prime','2022–2025',NULL,'tt13961348','https://m.media-amazon.com/images/M/MV5BMDA3ZTY0MmQtMjc5YS00ODdkLWIxNDEtNjg4MTdmNGIzNjI4XkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(20,5,'Sonic Underground','1999',NULL,'tt0230804','https://m.media-amazon.com/images/M/MV5BZGU0MDQ5OGEtNjlhMC00ZDVkLWI5NGQtNWE3YzQwODlhYzhlXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-09 01:07:06','2025-04-09 01:07:06'),(21,5,'Batman Begins','2005',NULL,'tt0372784','https://m.media-amazon.com/images/M/MV5BODIyMDdhNTgtNDlmOC00MjUxLWE2NDItODA5MTdkNzY3ZTdhXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(22,5,'The Batman','2022',NULL,'tt1877830','https://m.media-amazon.com/images/M/MV5BMmU5NGJlMzAtMGNmOC00YjJjLTgyMzUtNjAyYmE4Njg5YWMyXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(23,5,'Batman v Superman: Dawn of Justice','2016',NULL,'tt2975590','https://m.media-amazon.com/images/M/MV5BZTJkYjdmYjYtOGMyNC00ZGU1LThkY2ItYTc1OTVlMmE2YWY1XkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(24,5,'Batman','1989',NULL,'tt0096895','https://m.media-amazon.com/images/M/MV5BYzZmZWViM2EtNzhlMi00NzBlLWE0MWEtZDFjMjk3YjIyNTBhXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(25,5,'Batman Returns','1992',NULL,'tt0103776','https://m.media-amazon.com/images/M/MV5BZTliMDVkYTktZDdlMS00NTAwLWJhNzYtMWIwMDZjN2ViMGFiXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(26,5,'Batman & Robin','1997',NULL,'tt0118688','https://m.media-amazon.com/images/M/MV5BYzU3ZjE3M2UtM2E4Ni00MDI5LTkyZGUtOTFkMGIyYjNjZGU3XkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(27,5,'Batman Forever','1995',NULL,'tt0112462','https://m.media-amazon.com/images/M/MV5BMTUyNjJhZWItMTZkNS00NDc4LTllNjUtYTg3NjczMzA5ZTViXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(28,5,'The Lego Batman Movie','2017',NULL,'tt4116284','https://m.media-amazon.com/images/M/MV5BMTcyNTEyOTY0M15BMl5BanBnXkFtZTgwOTAyNzU3MDI@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(29,5,'Batman: The Animated Series','1992–1995',NULL,'tt0103359','https://m.media-amazon.com/images/M/MV5BYjgwZWUzMzUtYTFkNi00MzM0LWFkMWUtMDViMjMxNGIxNDUxXkEyXkFqcGc@._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50'),(30,5,'Batman v Superman: Dawn of Justice (Ultimate Edition)','2016',NULL,'tt18689424','https://m.media-amazon.com/images/M/MV5BOTRlNWQwM2ItNjkyZC00MGI3LThkYjktZmE5N2FlMzcyNTIyXkEyXkFqcGdeQXVyMTEyNzgwMDUw._V1_SX300.jpg',0,'2025-04-16 17:04:50','2025-04-16 17:04:50');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `session_key` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_key` (`session_key`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,1,'3521cfe5fc082ea38ed24bfe5a39ce2f','2025-03-07 18:19:08','2025-03-07 17:19:08'),(2,1,'3b5dbff11115187061bf6f3de92c6cd4','2025-03-07 18:19:08','2025-03-07 17:19:08'),(3,1,'a2eb85aeef5df38bc50aeff3af6c03ac','2025-03-07 18:19:08','2025-03-07 17:19:08'),(4,1,'acd872838c498b822ee18e4a87521498','2025-03-07 18:19:43','2025-03-07 17:19:43'),(5,1,'4fbaf5935ddb94000f4f7fd48f543e60','2025-03-08 01:43:22','2025-03-08 00:43:22'),(6,1,'217c29ed713e92b6ba4c2bc46662d9c6','2025-03-08 01:43:22','2025-03-08 00:43:22'),(7,1,'9aa68e60f44c0f09f58e2b88a7a1d0bf','2025-03-08 01:43:22','2025-03-08 00:43:22'),(8,1,'66359691c386ced28192281ac5915867','2025-03-08 01:43:22','2025-03-08 00:43:22'),(9,2,'02496a6c531571341b38ce133002e739','2025-03-08 01:44:50','2025-03-08 00:44:50'),(10,2,'be79554d1a40bc8aa4d1d4dfa2aff6b4','2025-03-08 01:45:57','2025-03-08 00:45:57'),(11,3,'7e078782eb68e7e25189e0fddd58da3b','2025-03-08 01:46:41','2025-03-08 00:46:41'),(12,3,'bdc114901afa635f8b70b15597f8db26','2025-03-08 01:46:58','2025-03-08 00:46:58'),(13,4,'987053ab65f8a64a0cc178d57efecef8','2025-03-09 02:32:28','2025-03-09 01:32:28'),(14,4,'cd04b6cb2ca46bdeec19fa2e3a023c8c','2025-03-09 02:32:39','2025-03-09 01:32:39'),(15,1,'5a839f664dd8c8f9409764679a7fbddf','2025-04-06 22:52:32','2025-04-06 21:52:32'),(16,1,'dd13bab9ea9590724666480fd820b583','2025-04-06 22:53:24','2025-04-06 21:53:24'),(17,5,'7fabacef2f70e47cc24f2bd6c19b9a58','2025-04-06 22:54:31','2025-04-06 21:54:31'),(18,1,'01e7666d56e84a03979e3c1f29123963','2025-04-06 22:58:13','2025-04-06 21:58:13'),(19,1,'30d23a9c4c7e2e41b8e5e043c9fe834d','2025-04-06 23:02:53','2025-04-06 22:02:53'),(20,1,'9dda0e5ecad90efe426d15f60fd37529','2025-04-06 23:04:20','2025-04-06 22:04:20'),(21,5,'a9649e3b2ebd4f84429552c06bb22a2a','2025-04-06 23:04:47','2025-04-06 22:04:47'),(22,1,'58288692702bf8588e312503711695a9','2025-04-06 23:10:32','2025-04-06 22:10:32'),(23,1,'c2d96e32af34c428504f580add047ce9','2025-04-06 23:24:52','2025-04-06 22:24:52'),(24,5,'25239336497a651e738728865bb32a96','2025-04-06 23:25:58','2025-04-06 22:25:58'),(25,5,'c98090e642afc545fd788b5348fc4e59','2025-04-06 23:29:04','2025-04-06 22:29:04'),(26,1,'ad8d114b99a89a6eebce9e4bb10a949d','2025-04-06 23:36:25','2025-04-06 22:36:25'),(27,1,'3fec051fbabe177c17bf6b86ab99d0b5','2025-04-07 00:58:31','2025-04-06 23:58:31'),(28,5,'8aef556b668b0272cc4da18003047661','2025-04-07 00:58:31','2025-04-06 23:58:31'),(29,5,'9f60471b791214d29ee1b4278ef025b3','2025-04-07 00:58:31','2025-04-06 23:58:31'),(30,1,'56b391e25295292d665bb64fe6820e4a','2025-04-07 00:58:31','2025-04-06 23:58:31'),(31,1,'6c257e86b054f737592370a30f89a46d','2025-04-07 00:58:31','2025-04-06 23:58:31'),(32,5,'998929e7883e0470f7bd2c7a8d6992ac','2025-04-07 00:58:31','2025-04-06 23:58:31'),(33,5,'3ab44870cea0cfb88ca21027b3b5b971','2025-04-07 00:58:31','2025-04-06 23:58:31'),(34,5,'363be8851167bbdd4ee1ac05efc08840','2025-04-07 00:58:39','2025-04-06 23:58:39'),(35,1,'486f6eece61b2429dffc3e5b87b1ac8d','2025-04-07 01:03:41','2025-04-07 00:03:41'),(36,5,'7ac961cb7e124db6973b98bccf0f3786','2025-04-07 01:05:02','2025-04-07 00:05:02'),(37,5,'cb085324a098f2f7dad6c01fee357d31','2025-04-07 01:09:06','2025-04-07 00:09:06'),(38,5,'78082ed9376f6f6c2f336364cb40a824','2025-04-07 01:12:52','2025-04-07 00:12:52'),(39,5,'c48c1323569944aca3e3569fe3c3f9e2','2025-04-09 01:22:17','2025-04-09 00:22:17'),(40,5,'ee6a3fc5a107ee9da05a341df93cb314','2025-04-09 01:22:25','2025-04-09 00:22:25'),(41,5,'406b158bd6ba73a1dabc27108284c452','2025-04-09 01:42:08','2025-04-09 00:42:08'),(42,5,'1a54e8fb494672b45b665ecf1f29fc8f','2025-04-09 01:46:54','2025-04-09 00:46:54'),(43,5,'ab6e8ed3fc1898e80a8761c823fbd7f8','2025-04-09 02:04:34','2025-04-09 01:04:34'),(44,5,'8f50389764a313cfe4854f2da4176c5d','2025-04-09 02:52:24','2025-04-09 01:52:24'),(45,5,'24153e07f2a1acbd9f976dc837306774','2025-04-09 02:54:15','2025-04-09 01:54:15'),(46,5,'411832981bf0d01d836ff8ddfec77b5b','2025-04-09 02:54:15','2025-04-09 01:54:15'),(47,5,'10f876aba1875b80965141d43e1e6561','2025-04-09 02:58:22','2025-04-09 01:58:22'),(48,5,'d21f5f7a4fd6bc3b91cefbbf07e66341','2025-04-09 03:02:12','2025-04-09 02:02:12'),(49,5,'cdf2c904f2fda68db7df2c700d4491b5','2025-04-09 03:02:41','2025-04-09 02:02:41'),(50,5,'1bbd8f8da12a5f7c41cd742d6580d646','2025-04-16 17:56:18','2025-04-16 16:56:18'),(51,5,'266f7fc678af607c67055dfd02fac26f','2025-04-16 18:01:56','2025-04-16 17:01:56'),(52,5,'1ff8c70b43001f55a4bb460e6bf081c8','2025-04-16 18:04:18','2025-04-16 17:04:18'),(53,5,'10dbbd75b33b327e2fc57bd1b9890172','2025-04-23 17:51:49','2025-04-23 16:51:49');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
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
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test','$2y$10$EgERW/R1gF3YkWh9nwtm8.wfwihRDpS3uraC4mcp7eFQT07giBwL6','2025-03-07 17:19:08'),(2,'basit','$2y$10$UmtZuYnpyFZPwa2/SnKpWOC9R..IrkS5OI2ExN3TWOc7Bj7fnhWVG','2025-03-08 00:44:40'),(3,'test2','$2y$10$S7iY6aGlS5IFNOUPCjP.Vui8yfa5mFeZrb6bvdPdNvAKq6XvN.FZq','2025-03-08 00:46:27'),(4,'testuser','$2y$10$.6offsXwHFc4NQWbl69cCuHjCugopq.5v3p3Z5l7BSQFfFpBsZGt.','2025-03-09 01:32:28'),(5,'basita','$2y$10$9u0elpFdoQWEs7GyhZ35weI.9zw6U/K6neIYgeMxhI55MTtGXzSmy','2025-04-06 21:53:52'),(6,'basitali','$2y$10$GIxensfunWskEDlMiXCZEefc2uTHcIInqjga7G4YpLpXWlcJ8a8S.','2025-04-06 22:15:23');
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

-- Dump completed on 2025-04-23 13:15:52
