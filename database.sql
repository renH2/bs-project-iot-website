-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: iotproject1
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add device',7,'add_device'),(26,'Can change device',7,'change_device'),(27,'Can delete device',7,'delete_device'),(28,'Can view device',7,'view_device'),(29,'Can add 用户',8,'add_user'),(30,'Can change 用户',8,'change_user'),(31,'Can delete 用户',8,'delete_user'),(32,'Can view 用户',8,'view_user'),(33,'Can add captcha store',9,'add_captchastore'),(34,'Can change captcha store',9,'change_captchastore'),(35,'Can delete captcha store',9,'delete_captchastore'),(36,'Can view captcha store',9,'view_captchastore'),(37,'Can add device info',10,'add_deviceinfo'),(38,'Can change device info',10,'change_deviceinfo'),(39,'Can delete device info',10,'delete_deviceinfo'),(40,'Can view device info',10,'view_deviceinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `captcha_captchastore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (62,'QJTC','qjtc','7c199bdd05354d8727b30b8c0df3fa1e3d57fb96','2021-06-29 12:32:38.011405');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_device`
--

DROP TABLE IF EXISTS `device_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_device` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` varchar(45) NOT NULL,
  `info` varchar(50) NOT NULL,
  `value` int NOT NULL,
  `alert` int NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `timestamp` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_device`
--

LOCK TABLES `device_device` WRITE;
/*!40000 ALTER TABLE `device_device` DISABLE KEYS */;
INSERT INTO `device_device` VALUES (1,'device0003','Device Data 2021/06/26 15:22:38',11,0,30.17281839847565,120.15304485559464,1624692158670),(2,'device0001','Device Data 2021/06/26 15:22:38',19,0,30.47739017009735,119.99543110132218,1624692158670),(3,'device0002','Device Data 2021/06/26 15:22:39',51,0,30.49904718399048,120.4702555179596,1624692159664),(4,'device0005','Device Data 2021/06/26 15:22:40',63,0,30.35447030067444,120.41989493370056,1624692160664),(5,'device0003','Device Data 2021/06/26 15:22:40',14,0,30.130592536926272,120.18421720266343,1624692160811),(6,'device0004','Device Data 2021/06/26 15:22:44',58,0,30.14647574424744,120.00382305383683,1624692164664),(7,'device0001','Device Data 2021/06/26 15:22:46',39,0,30.108012652397157,119.92130843400956,1624692166817),(8,'device0002','Device Data 2021/06/26 15:22:47',26,0,30.498814964294436,120.21179875135422,1624692167668),(9,'device0005','Device Data 2021/06/26 15:22:48',53,0,30.423066234588624,120.13406218290329,1624692168678),(10,'device0003','Device Data 2021/06/26 15:22:48',57,0,30.344313192367554,120.21256972551346,1624692168814),(11,'device0003','Device Data 2021/06/26 15:22:49',79,0,30.23083419799805,120.39350821971894,1624692169819),(12,'device0002','Device Data 2021/06/26 15:22:51',28,0,30.449258303642274,120.04772498607636,1624692171675),(13,'device0004','Device Data 2021/06/26 15:22:52',47,0,30.119951510429384,120.2591132760048,1624692172671),(14,'device0003','Device Data 2021/06/26 15:22:52',4,0,30.28749103546143,120.35869218111038,1624692172831),(15,'device0003','Device Data 2021/06/26 15:22:52',11,0,30.38294496536255,120.19372384548188,1624692172831),(16,'device0001','Device Data 2021/06/26 15:22:53',24,0,30.351881623268127,119.94432518482209,1624692173831),(17,'device0005','Device Data 2021/06/26 15:22:54',17,0,30.17179446220398,120.26992597579957,1624692174691),(18,'device0001','Device Data 2021/06/26 15:22:54',50,0,30.278176999092103,120.1294530749321,1624692174835),(19,'device0002','Device Data 2021/06/26 15:22:56',3,0,30.427501940727236,120.06941579580308,1624692176688),(20,'device0004','Device Data 2021/06/26 15:22:59',54,0,30.499180579185488,120.32962515354157,1624692179682),(21,'device0005','Device Data 2021/06/26 15:22:59',97,1,30.103076553344728,120.07547465562821,1624692179698),(22,'device0005','Device Data 2021/06/26 15:22:59',19,0,30.30704963207245,120.45960553884507,1624692179698),(23,'device0002','Device Data 2021/06/26 15:23:00',38,0,30.293308711051942,120.0892812371254,1624692180689),(24,'device0003','Device Data 2021/06/26 15:23:00',22,0,30.119047188758852,120.24829732179643,1624692180843),(25,'device0001','Device Data 2021/06/26 15:23:01',71,0,30.26106517314911,120.25457111597062,1624692181849),(26,'device0005','Device Data 2021/06/26 15:23:02',44,0,30.445260667800905,120.04657599925996,1624692182698),(27,'device0001','Device Data 2021/06/26 15:23:04',6,0,30.348810482025147,120.27469286918641,1624692184860),(28,'device0001','Device Data 2021/06/26 15:23:05',42,0,30.181979417800903,120.17391884326935,1624692185870),(29,'device0004','Device Data 2021/06/26 15:23:08',64,0,30.276068592071535,120.33954367637635,1624692188694),(30,'device0002','Device Data 2021/06/26 15:23:09',85,1,30.11632106304169,119.9448310136795,1624692189699),(31,'device0003','Device Data 2021/06/26 15:23:09',5,0,30.183672571182253,120.21185103654862,1624692189847),(32,'device0001','Device Data 2021/06/26 15:23:09',49,0,30.374096846580507,120.33790692090989,1624692189878),(33,'device0005','Device Data 2021/06/26 15:23:11',62,0,30.23047573566437,120.25368419885636,1624692191709),(34,'device0003','Device Data 2021/06/26 15:23:12',34,0,30.48561067581177,120.02848564386369,1624692192848),(35,'device0003','Device Data 2021/06/26 15:23:13',59,0,30.277323198318484,120.35156794786454,1624692193853),(36,'device0002','Device Data 2021/06/28 17:17:52',41,0,30.397896695137025,119.98430554866792,1624871872416),(37,'device0001','Device Data 2021/06/28 17:17:52',67,0,30.35795207023621,120.39753990173341,1624871872599),(38,'device0005','Device Data 2021/06/28 17:17:53',67,0,30.37553586959839,120.40740181207657,1624871873416),(39,'device0004','Device Data 2021/06/28 17:17:55',31,0,30.460514688491823,120.0055188894272,1624871875416),(40,'device0003','Device Data 2021/06/28 17:17:57',33,0,30.30375547409058,120.36227089166641,1624871877416),(41,'device0004','Device Data 2021/06/28 17:17:57',29,0,30.1208477973938,120.20041567087173,1624871877418),(42,'device0002','Device Data 2021/06/28 17:17:57',93,1,30.428264141082764,120.34188803434373,1624871877427),(43,'device0001','Device Data 2021/06/28 17:17:57',87,1,30.41978578567505,120.26328010559082,1624871877601),(44,'device0005','Device Data 2021/06/28 17:18:00',73,0,30.33367624282837,119.91093779802323,1624871880418),(45,'device0001','Device Data 2021/06/28 17:18:01',38,0,30.323145866394043,120.15620596408844,1624871881603),(46,'device0004','Device Data 2021/06/28 17:18:04',62,0,30.369656920433044,120.27419877052307,1624871884420),(47,'device0005','Device Data 2021/06/28 17:18:04',58,0,30.45905718803406,119.96244547367097,1624871884420),(48,'device0005','Device Data 2021/06/28 17:18:04',67,0,30.367251563072205,120.46739757061005,1624871884421),(49,'device0003','Device Data 2021/06/28 17:18:05',27,0,30.158262205123904,120.00222027301788,1624871885417),(50,'device0002','Device Data 2021/06/28 17:18:05',0,0,30.394126462936402,120.32502748966218,1624871885428),(51,'device0002','Device Data 2021/06/28 17:18:07',89,1,30.384508347511293,120.15935784578323,1624871887429),(52,'device0002','Device Data 2021/06/28 17:18:07',47,0,30.191381120681765,120.40316781997682,1624871887433),(53,'device0002','Device Data 2021/06/28 17:18:08',11,0,30.246280121803284,120.20006519556046,1624871888436),(54,'device0005','Device Data 2021/06/28 17:18:09',50,0,30.25617425441742,120.31016465425492,1624871889422),(55,'device0001','Device Data 2021/06/28 17:18:09',67,0,30.30093791484833,120.39523023366928,1624871889606),(56,'device0004','Device Data 2021/06/28 17:18:11',76,0,30.365848016738894,120.4997263789177,1624871891422),(57,'device0005','Device Data 2021/06/28 17:18:12',65,0,30.478194427490237,120.45482205152513,1624871892422),(58,'device0001','Device Data 2021/06/28 17:18:12',26,0,30.4355783700943,120.36068627834321,1624871892608),(59,'device0002','Device Data 2021/06/28 17:18:13',14,0,30.349261927604676,120.02313789129258,1624871893437),(60,'device0003','Device Data 2021/06/28 17:18:14',33,0,30.43838655948639,120.03675832748414,1624871894419),(61,'device0004','Device Data 2021/06/28 17:18:14',72,0,30.437649321556094,120.06660623550415,1624871894423),(62,'device0004','Device Data 2021/06/28 17:18:15',93,1,30.16881241798401,119.99028551578522,1624871895424),(63,'device0004','Device Data 2021/06/28 17:18:15',5,0,30.314767980575564,120.2690548658371,1624871895425),(64,'device0005','Device Data 2021/06/28 17:18:16',84,1,30.239229249954224,120.15269792079926,1624871896424),(65,'device0001','Device Data 2021/06/28 17:18:19',27,0,30.1613920211792,120.4657833814621,1624871899610),(66,'device0003','Device Data 2021/06/28 17:18:20',76,0,30.499075675010683,119.94374421834947,1624871900421),(67,'device0002','Device Data 2021/06/28 17:18:20',39,0,30.22494468688965,120.02003121376038,1624871900441),(68,'device0004','Device Data 2021/06/28 17:18:21',90,1,30.162463617324832,120.06631866693498,1624871901426),(69,'device0002','Device Data 2021/06/28 17:18:22',89,1,30.27410912513733,120.12696738243103,1624871902443),(70,'device0001','Device Data 2021/06/28 17:18:23',52,0,30.394277644157413,120.33780181407928,1624871903612),(71,'device0005','Device Data 2021/06/28 17:18:24',17,0,30.141103696823123,120.47917847633363,1624871904426),(72,'device0002','Device Data 2021/06/28 17:18:25',92,1,30.268512678146365,120.22513358592988,1624871905444),(73,'device0004','Device Data 2021/06/28 17:18:26',10,0,30.378534388542178,120.13641866445542,1624871906427),(74,'device0002','Device Data 2021/06/28 17:18:26',84,1,30.17762191295624,120.34541538953782,1624871906447),(75,'device0003','Device Data 2021/06/28 17:18:27',76,0,30.22301688194275,119.94010299444199,1624871907426),(76,'device0003','Device Data 2021/06/28 17:18:27',2,0,30.372065019607547,120.0116439819336,1624871907435),(77,'device0001','Device Data 2021/06/28 17:18:27',98,1,30.436017322540284,119.91790020465851,1624871907615),(78,'device0004','Device Data 2021/06/28 17:18:30',5,0,30.45912792682648,120.18540642261506,1624871910429),(79,'device0004','Device Data 2021/06/28 17:18:30',87,1,30.11938099861145,119.95834072828293,1624871910430),(80,'device0001','Device Data 2021/06/28 17:18:31',74,0,30.113608908653262,120.1150295495987,1624871911618),(81,'device0005','Device Data 2021/06/28 17:18:32',15,0,30.267123603820803,119.98426070213318,1624871912429),(82,'device0004','Device Data 2021/06/28 17:18:33',46,0,30.120724487304688,120.13463295698166,1624871913431),(83,'device0005','Device Data 2021/06/28 17:18:33',73,0,30.483531188964847,120.25855988264084,1624871913432),(84,'device0002','Device Data 2021/06/28 17:18:33',46,0,30.39531650543213,120.46482132673265,1624871913448),(85,'device0002','Device Data 2021/06/28 17:18:34',69,0,30.413869404792788,120.29502007961274,1624871914450),(86,'device0003','Device Data 2021/06/28 17:18:35',41,0,30.47228858470917,120.30766887664795,1624871915436),(87,'device0001','Device Data 2021/06/28 17:18:37',38,0,30.488905143737796,120.16524951457978,1624871917621),(88,'device0004','Device Data 2021/06/28 17:18:39',14,0,30.12121481895447,120.3903104543686,1624871919433),(89,'device0003','Device Data 2021/06/29 19:15:37',82,1,30.156138849258426,120.08398480415345,1624965337266),(90,'device0002','Device Data 2021/06/29 19:15:39',70,0,30.26982071399689,120.45879669189453,1624965339269),(91,'device0004','Device Data 2021/06/29 19:15:40',30,0,30.38498103618622,120.16729410886765,1624965340270),(92,'device0002','Device Data 2021/06/29 19:15:40',9,0,30.25910863876343,120.24694466590881,1624965340270),(93,'device0002','Device Data 2021/06/29 19:15:40',93,1,30.37760765552521,119.98308013677598,1624965340270),(94,'device0002','Device Data 2021/06/29 19:15:40',36,0,30.454571700096132,120.29591636657716,1624965340270),(95,'device0001','Device Data 2021/06/29 19:15:41',74,0,30.450799345970154,120.04889879226685,1624965341271),(96,'device0005','Device Data 2021/06/29 19:15:44',19,0,30.301464390754703,120.35528523921967,1624965344270),(97,'device0004','Device Data 2021/06/29 19:15:45',77,0,30.47396457195282,119.93639496564866,1624965345284),(98,'device0003','Device Data 2021/06/29 19:15:46',26,0,30.43456702232361,119.93652263879777,1624965346391),(99,'device0002','Device Data 2021/06/29 19:15:47',72,0,30.25524342060089,120.05376224517823,1624965347271),(100,'device0004','Device Data 2021/06/29 19:15:47',24,0,30.26332085132599,120.42146255970002,1624965347284),(101,'device0001','Device Data 2021/06/29 19:15:48',78,0,30.330831933021546,120.14789015054703,1624965348271),(102,'device0004','Device Data 2021/06/29 19:15:49',46,0,30.235328364372254,120.07336962223053,1624965349285),(103,'device0005','Device Data 2021/06/29 19:15:50',20,0,30.24290816783905,120.42624937295915,1624965350275),(104,'device0003','Device Data 2021/06/29 19:15:50',48,0,30.364613747596742,120.33680564165115,1624965350400),(105,'device0002','Device Data 2021/06/29 19:15:51',98,1,30.182874250411988,120.39775937795639,1624965351285),(106,'device0005','Device Data 2021/06/29 19:15:52',60,0,30.47962446212769,120.20503854751587,1624965352279),(107,'device0002','Device Data 2021/06/29 19:15:53',96,1,30.222898507118227,119.9370515704155,1624965353291),(108,'device0004','Device Data 2021/06/29 19:15:53',66,0,30.35748567581177,120.26363784074783,1624965353291),(109,'device0003','Device Data 2021/06/29 19:15:54',72,0,30.23468647003174,120.08000587224961,1624965354413),(110,'device0001','Device Data 2021/06/29 19:15:55',29,0,30.337342453002933,119.91515423059464,1624965355273),(111,'device0005','Device Data 2021/06/29 19:15:57',78,0,30.207536935806274,120.13549591302872,1624965357282),(112,'device0002','Device Data 2021/06/29 19:15:57',80,0,30.456010222434998,120.16207406520844,1624965357311),(113,'device0001','Device Data 2021/06/29 19:15:58',17,0,30.32558798789978,120.18530435562134,1624965358280),(114,'device0003','Device Data 2021/06/29 19:15:58',85,1,30.309836912155152,120.03196926116944,1624965358416),(115,'device0004','Device Data 2021/06/29 19:15:59',4,0,30.298088669776917,120.30974565744401,1624965359304),(116,'device0004','Device Data 2021/06/29 20:31:25',78,0,30.247372055053713,120.48174370527268,1624969885598),(117,'device0003','Device Data 2021/06/29 20:31:25',77,0,30.243750262260438,119.91343811750413,1624969885598),(118,'device0005','Device Data 2021/06/29 20:31:26',67,0,30.30691592693329,120.06336855888367,1624969886593),(119,'device0002','Device Data 2021/06/29 20:31:26',84,1,30.394136810302737,120.27425388097764,1624969886595),(120,'device0002','Device Data 2021/06/29 20:31:28',68,0,30.131106352806093,119.98666024208069,1624969888596),(121,'device0001','Device Data 2021/06/29 20:31:29',5,0,30.152860140800477,120.20140068531038,1624969889585),(122,'device0003','Device Data 2021/06/29 20:31:31',36,0,30.374167370796204,120.006331884861,1624969891895),(123,'device0005','Device Data 2021/06/29 20:31:32',17,0,30.396464347839355,119.90482035875321,1624969892601),(124,'device0004','Device Data 2021/06/29 20:31:33',18,0,30.130707836151124,120.18498796224594,1624969893895),(125,'device0001','Device Data 2021/06/29 20:31:34',62,0,30.118782901763918,120.01471618413926,1624969894606),(126,'device0002','Device Data 2021/06/29 20:31:34',97,1,30.390816402435306,119.92122070789338,1624969894606),(127,'device0001','Device Data 2021/06/29 20:31:39',59,0,30.184722733497622,120.17104820013047,1624969899624),(128,'device0003','Device Data 2021/06/29 20:31:39',79,0,30.402899765968325,120.34390498399735,1624969899903),(129,'device0005','Device Data 2021/06/29 20:31:40',63,0,30.411910152435304,120.42929875850677,1624969900626),(130,'device0001','Device Data 2021/06/29 20:31:40',63,0,30.134577465057376,120.2775523543358,1624969900626),(131,'device0003','Device Data 2021/06/29 20:31:41',90,1,30.134923291206363,119.97952517271042,1624969901904),(132,'device0004','Device Data 2021/06/29 20:31:42',32,0,30.110001945495608,120.01258325576782,1624969902896),(133,'device0002','Device Data 2021/06/29 20:31:43',42,0,30.427761173248292,120.1800223350525,1624969903607),(134,'device0001','Device Data 2021/06/29 20:31:43',44,0,30.14476728439331,120.47146937847138,1624969903626),(135,'device0004','Device Data 2021/06/29 20:31:43',58,0,30.250958800315857,120.42820366621018,1624969903897),(136,'device0004','Device Data 2021/06/29 20:31:43',1,0,30.381306910514834,120.19954119920732,1624969903899),(137,'device0001','Device Data 2021/06/29 20:31:45',9,0,30.402246642112733,120.44024360179901,1624969905630),(138,'device0003','Device Data 2021/06/29 20:31:45',63,0,30.319435977935793,120.35968034267427,1624969905907),(139,'device0005','Device Data 2021/06/29 20:31:48',6,0,30.238917875289918,119.96552722454072,1624969908626),(140,'device0005','Device Data 2021/06/29 20:31:48',67,0,30.30696575641632,120.28533226251602,1624969908628),(141,'device0001','Device Data 2021/06/29 20:31:49',38,0,30.35049047470093,120.09146384000779,1624969909631),(142,'device0002','Device Data 2021/06/29 20:31:50',38,0,30.387520241737366,120.47167004346848,1624969910608),(143,'device0004','Device Data 2021/06/29 20:31:51',5,0,30.423862862586976,120.36842455863953,1624969911901),(144,'device0002','Device Data 2021/06/29 20:31:53',6,0,30.48458380699158,120.1405722975731,1624969913610),(145,'device0003','Device Data 2021/06/29 20:31:54',57,0,30.34479284286499,119.96111924648285,1624969914907),(146,'device0004','Device Data 2021/06/29 20:31:55',83,1,30.2686047077179,120.2209051012993,1624969915903),(147,'device0005','Device Data 2021/06/29 20:31:57',30,0,30.311473870277407,120.16575967073442,1624969917628),(148,'device0002','Device Data 2021/06/29 20:31:58',93,1,30.122924852371217,120.03509013652803,1624969918612),(149,'device0001','Device Data 2021/06/29 20:31:58',97,1,30.11551640033722,120.37975277900696,1624969918633),(150,'device0003','Device Data 2021/06/29 20:31:59',75,0,30.307478952407838,120.10272632837297,1624969919908),(151,'device0002','Device Data 2021/06/29 20:32:00',49,0,30.175771355628967,120.18129173517228,1624969920613),(152,'device0001','Device Data 2021/06/29 20:32:00',54,0,30.446811103820803,120.32775322198869,1624969920634),(153,'device0001','Device Data 2021/06/29 20:32:01',26,0,30.456373739242554,119.99833943843842,1624969921636),(154,'device0004','Device Data 2021/06/29 20:32:01',86,1,30.328375267982484,120.40044029951096,1624969921904),(155,'device0002','Device Data 2021/06/29 20:32:02',18,0,30.38933687210083,120.00695333480836,1624969922619),(156,'device0003','Device Data 2021/06/29 20:32:02',4,0,30.274210262298585,120.41648259162903,1624969922909),(157,'device0005','Device Data 2021/06/29 20:32:03',12,0,30.454016971588135,120.05974682569504,1624969923629),(158,'device0001','Device Data 2021/06/29 20:32:03',46,0,30.41574218273163,120.29165458679199,1624969923637),(159,'device0004','Device Data 2021/06/29 20:32:03',6,0,30.462423610687257,120.35296248197557,1624969923906),(160,'device0001','Device Data 2021/06/29 20:32:05',76,0,30.117835664749148,120.11905000209809,1624969925639),(161,'device0002','Device Data 2021/06/29 20:32:10',77,0,30.162126231193543,120.19251720905305,1624969930623),(162,'device0001','Device Data 2021/06/29 20:32:10',37,0,30.466893482208253,120.35053426027298,1624969930654),(163,'device0003','Device Data 2021/06/29 20:32:10',87,1,30.10357885360718,120.10339566469193,1624969930936);
/*!40000 ALTER TABLE `device_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_deviceinfo`
--

DROP TABLE IF EXISTS `device_deviceinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_deviceinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` varchar(45) NOT NULL,
  `client_name` varchar(50) NOT NULL,
  `client_declare` varchar(100) NOT NULL,
  `client_user` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_deviceinfo`
--

LOCK TABLES `device_deviceinfo` WRITE;
/*!40000 ALTER TABLE `device_deviceinfo` DISABLE KEYS */;
INSERT INTO `device_deviceinfo` VALUES (2,'device0002','倚天屠龙剑','可斩恶龙','xxx'),(4,'device0003','电视','使用电子技术传送活动的图像画面和音频信号的设备','xxx'),(7,'device0004','智能冰箱','智能控温','xxx'),(8,'device0005','摄像头','安全监控记录','xxx'),(9,'device0001','ipad2018','平板电脑','xxx');
/*!40000 ALTER TABLE `device_deviceinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(9,'captcha','captchastore'),(5,'contenttypes','contenttype'),(7,'device','device'),(10,'device','deviceinfo'),(8,'login','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-06-26 07:21:56.221124'),(2,'auth','0001_initial','2021-06-26 07:21:56.424200'),(3,'admin','0001_initial','2021-06-26 07:21:57.158551'),(4,'admin','0002_logentry_remove_auto_add','2021-06-26 07:21:57.299026'),(5,'admin','0003_logentry_add_action_flag_choices','2021-06-26 07:21:57.299026'),(6,'contenttypes','0002_remove_content_type_name','2021-06-26 07:21:57.455495'),(7,'auth','0002_alter_permission_name_max_length','2021-06-26 07:21:57.533472'),(8,'auth','0003_alter_user_email_max_length','2021-06-26 07:21:57.564558'),(9,'auth','0004_alter_user_username_opts','2021-06-26 07:21:57.564558'),(10,'auth','0005_alter_user_last_login_null','2021-06-26 07:21:57.642666'),(11,'auth','0006_require_contenttypes_0002','2021-06-26 07:21:57.642666'),(12,'auth','0007_alter_validators_add_error_messages','2021-06-26 07:21:57.658314'),(13,'auth','0008_alter_user_username_max_length','2021-06-26 07:21:57.736423'),(14,'auth','0009_alter_user_last_name_max_length','2021-06-26 07:21:57.798878'),(15,'auth','0010_alter_group_name_max_length','2021-06-26 07:21:57.861364'),(16,'auth','0011_update_proxy_permissions','2021-06-26 07:21:57.861364'),(17,'captcha','0001_initial','2021-06-26 07:21:57.939472'),(18,'device','0001_initial','2021-06-26 07:21:57.970789'),(19,'device','0002_auto_20210626_1516','2021-06-26 07:21:58.049088'),(20,'login','0001_initial','2021-06-26 07:21:58.111307'),(21,'login','0002_remove_user_sex','2021-06-26 07:21:58.158169'),(22,'sessions','0001_initial','2021-06-26 07:21:58.189412'),(23,'device','0003_deviceinfo','2021-06-27 07:12:14.106816');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('dbutsvb2amrzxo7xxx34puihcfwtjglb','ZjRkZjUxMmZkNTFkNTVhZjNkYmU2ZTFkNDkwYWIzNmFjMTA4MDA0Zjp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjoyLCJ1c2VyX25hbWUiOiJ4eHgifQ==','2021-07-13 12:30:28.510831'),('fy4rl513obiyy2j3qfp4m5n8qy74s4uv','ZjRkZjUxMmZkNTFkNTVhZjNkYmU2ZTFkNDkwYWIzNmFjMTA4MDA0Zjp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjoyLCJ1c2VyX25hbWUiOiJ4eHgifQ==','2021-07-11 06:28:04.387080'),('uqv6pofnksx6d6t1yb4v053zmdkrr0gs','ZjRkZjUxMmZkNTFkNTVhZjNkYmU2ZTFkNDkwYWIzNmFjMTA4MDA0Zjp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjoyLCJ1c2VyX25hbWUiOiJ4eHgifQ==','2021-07-13 07:05:39.901926');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_user`
--

DROP TABLE IF EXISTS `login_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(254) NOT NULL,
  `c_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_user`
--

LOCK TABLES `login_user` WRITE;
/*!40000 ALTER TABLE `login_user` DISABLE KEYS */;
INSERT INTO `login_user` VALUES (1,'ccc','85456c1133908b093bc10d93cf39a596528505b9f4cafab74717e1b5221a1ac9','1037564852@qq.com','2021-06-26 08:38:41.059188'),(2,'xxx','85456c1133908b093bc10d93cf39a596528505b9f4cafab74717e1b5221a1ac9','ddsadas@ds.com','2021-06-26 11:09:24.125896'),(3,'3180101969','85456c1133908b093bc10d93cf39a596528505b9f4cafab74717e1b5221a1ac9','1037564851@qq.com','2021-06-29 02:42:25.168699');
/*!40000 ALTER TABLE `login_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-29 20:45:31
