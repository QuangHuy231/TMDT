-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: modelshop
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `img_category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (10,'Naruto','https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993460/xniwr0dkqykwutttpznj.jpg'),(11,'Dragon Ball','https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993472/kbjq8pqxcmu8wd8ziwsm.jpg'),(12,'One Piece','https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993491/c51kxbeznxqckh67zhnj.jpg'),(13,'Demon Slayer','https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993539/c2m9goqxiuz5yjded3d0.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `detail_order_idx` (`order_id`),
  KEY `detail_product_idx` (`product_id`),
  CONSTRAINT `detail_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (5,11,40,2,20),(6,12,40,2,20),(7,12,41,5,50),(8,13,59,1,10),(9,13,58,1,10),(10,14,58,1,10),(11,14,57,1,10),(12,15,53,1,5),(13,15,54,1,10),(14,16,54,1,10),(15,16,53,1,5),(16,17,56,1,10),(17,17,55,1,5),(18,18,59,1,10),(19,18,58,2,20),(20,19,54,1,10),(21,19,58,2,20),(22,20,56,1,10),(23,20,55,1,5),(24,21,59,1,10),(25,21,61,1,10);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` float DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_user_idx` (`user_id`),
  CONSTRAINT `order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (11,6,'2023-08-03 06:37:30',8),(12,6,'2023-08-03 06:38:04',8),(13,6,'2023-08-03 06:39:54',20),(14,6,'2023-08-03 06:41:30',20),(15,6,'2023-08-03 06:42:17',15),(16,6,'2023-08-03 06:43:58',15),(17,6,'2023-08-03 06:49:50',15),(18,6,'2023-08-03 07:10:26',30),(19,6,'2023-08-03 08:37:14',30),(20,6,'2023-08-03 08:38:03',15),(21,6,'2023-08-03 08:38:33',20);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `old_price` float DEFAULT NULL,
  `description` text,
  `category_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `promotion_id` int DEFAULT NULL,
  `new_price` float DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_catagory_idx` (`category_id`),
  KEY `product_promotion_idx` (`promotion_id`),
  CONSTRAINT `product_catagory` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (40,'Kakashi',10,'Kakashi chibi cute❤️',10,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993627/ern9qikrynovfruklynf.jpg','2023-08-02 16:27:33',NULL,10),(41,'Luffy',10,'Smile ❤️',12,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690993677/yu71fabxpiccp4d5uqds.jpg','2023-08-02 16:28:19',10,5),(46,'Chopper',10,'Bác sĩ❤️',12,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994054/hntazels8qlhjd3a6q34.jpg','2023-08-02 16:34:26',10,5),(47,'Sakura',10,'Tiểu Đào',10,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994084/y82pbhk2tnkv2s41iuwr.jpg','2023-08-02 16:34:57',NULL,10),(48,'Zennitsu',10,'Tia chớp⚡',13,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994127/mqer9tseyafsgtf6og8m.png','2023-08-02 16:36:39',NULL,10),(49,'Luffy Gear 4',10,'Angry',12,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994217/fot9syzudteixfbvpavw.png','2023-08-02 16:37:35',10,5),(50,'Son Goku',10,'Kamehameha',11,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994268/o8ykq6kdjf6lv4udkaqn.png','2023-08-02 16:38:06',NULL,10),(51,'Rengoku',10,'Viêm Trụ Rengoku',13,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994307/zj6cu7armxtam2emowpn.jpg','2023-08-02 16:38:47',NULL,10),(52,'Sasuke',10,'Sasuke Chibi ',10,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994337/yjobo05k0kx9cfwonvqa.jpg','2023-08-02 16:39:19',NULL,10),(53,'Zoro',10,'Zoro hiphop',12,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994368/ewvyjxt8vjg28dp7x9xd.png','2023-08-02 16:39:46',10,5),(54,'Mitsuri',10,'Luyến trụ - Mitsuri',13,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994400/k76pt1rvy7cgyeunq0oq.jpg','2023-08-02 16:40:46',NULL,10),(55,'Zoro - Wano',10,'Wano quốc - Samurai tử sĩ',12,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994457/xw1cfqnd62t44lxnsj1b.jpg','2023-08-02 16:41:37',10,5),(56,'Tanjiro',10,'Tanjiro - Hơi thở mặt trời',13,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994545/iozxos0nekteajfdhxwc.jpg','2023-08-02 16:42:49',NULL,10),(57,'Itachi',10,'Makyo Saringan',10,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994582/hbifynux9pe6tb2iya4m.jpg','2023-08-02 16:43:25',NULL,10),(58,'Goten',10,'Goten Cute ❤️',11,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994633/u5jrp3ht25iahthncesi.jpg','2023-08-02 16:44:17',NULL,10),(59,'Akatsuki Itachi',10,'Very Cool',10,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994673/d08k2b4354q6sou7nfnz.jpg','2023-08-02 16:45:30',NULL,10),(61,'Nham Trụ',10,'Himejima Gyoumei: Nham Trụ',13,'https://res.cloudinary.com/du3ih0nrz/image/upload/v1690994828/jkj9zojwwphqvcnngkwg.jpg','2023-08-02 16:48:12',NULL,10);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `promotion_id` int NOT NULL AUTO_INCREMENT,
  `discount` float DEFAULT NULL,
  `start_date` text,
  `end_date` text,
  `promotion_code` varchar(45) NOT NULL,
  PRIMARY KEY (`promotion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (10,50,'2023-08-03','2023-08-30','SALE 50%');
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` varchar(45) DEFAULT NULL,
  `review_text` text,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `user_review_idx` (`user_id`),
  KEY `product_review_idx` (`product_id`),
  CONSTRAINT `product_review` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_review` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'nguyenquanghuy','$2b$10$xqdaUKOTEmV0k4GybmmMdeYMWUtDdvVa60h9yeyzM0Py0Uw7XlKdy','nguyenquanghuya3kd@gmail.com','Nguyễn Quang Huy','Binh Dinh province','0854345978');
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

-- Dump completed on 2023-08-03 15:47:16
