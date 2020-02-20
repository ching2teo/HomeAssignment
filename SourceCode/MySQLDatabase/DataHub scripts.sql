-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: datahub
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
-- Table structure for table `gpssensor`
--

DROP TABLE IF EXISTS `gpssensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gpssensor` (
  `transaction_id` int unsigned NOT NULL AUTO_INCREMENT,
  `sensor_id` varchar(20) NOT NULL,
  `longtitude` decimal(25,20) DEFAULT NULL,
  `latitude` decimal(25,20) DEFAULT NULL,
  `reading_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imusensor`
--

DROP TABLE IF EXISTS `imusensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imusensor` (
  `transaction_id` int unsigned NOT NULL AUTO_INCREMENT,
  `sensor_id` varchar(20) NOT NULL,
  `accelerometer_x` decimal(25,20) DEFAULT NULL,
  `accelerometer_y` decimal(25,20) DEFAULT NULL,
  `accelerometer_z` decimal(25,20) DEFAULT NULL,
  `gyroscope_x` decimal(25,20) DEFAULT NULL,
  `gyroscope_y` decimal(25,20) DEFAULT NULL,
  `gyroscope_z` decimal(25,20) DEFAULT NULL,
  `reading_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8921 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raw_data`
--

DROP TABLE IF EXISTS `raw_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_data` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `created_date` timestamp NOT NULL,
  `raw_data` longtext NOT NULL,
  `status` varchar(2) NOT NULL DEFAULT 'N',
  `updated_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temperaturesensor`
--

DROP TABLE IF EXISTS `temperaturesensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temperaturesensor` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `sensor_id` varchar(20) NOT NULL,
  `temperature` decimal(10,2) DEFAULT NULL,
  `reading_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `temperature_id_UNIQUE` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'datahub'
--
/*!50003 DROP FUNCTION IF EXISTS `SPLIT_STRING` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SPLIT_STRING`(
	str longtext ,
	delim VARCHAR(12) ,
	pos INT
) RETURNS varchar(255) CHARSET utf8
RETURN REPLACE(
	SUBSTRING(
		SUBSTRING_INDEX(str , delim , pos) ,
		CHAR_LENGTH(
			SUBSTRING_INDEX(str , delim , pos - 1)
		) + 1
	) ,
	delim ,
	''
) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spProcessSensorData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spProcessSensorData`()
BEGIN	
  Declare v_Id varchar(45) Default NULL;
  Declare v_RawData longtext Default NULL;
  Declare v_RowData longtext Default NULL;
  Declare v_CurrentRowIndex INT Default 1;
  Declare v_TotalRows INT Default 0;
/*
  CREATE TEMPORARY TABLE IF NOT EXISTS sensorRawData AS (SELECT * FROM datahub.raw_data WHERE status = 'N' LIMIT 3);
  drop temporary table if exists temp;
  create temporary table temp( val char(255) );
  */
  SELECT transaction_id, raw_data INTO v_Id, v_RawData
  FROM datahub.raw_data
  WHERE status = 'N'
  LIMIT 1;
  
  SELECT (CHAR_LENGTH(v_RawData) - CHAR_LENGTH(REPLACE(v_RawData, ';', ''))) INTO v_TotalRows;
  
  IF v_TotalRows = 1 THEN
	SELECT SPLIT_STRING(v_RawData, ';', 1) INTO v_RowData;
	IF SPLIT_STRING(v_RowData, '|', 1) = 'gps' THEN -- Process GPS data
		insert into gpssensor(sensor_id, reading_date, longtitude, latitude, created_date) 
        values(SPLIT_STRING(v_RowData, '|', 2), SPLIT_STRING(v_RowData, '|', 3), 
        SPLIT_STRING(v_RowData, '|', 4), SPLIT_STRING(v_RowData, '|', 5), current_timestamp());
	ELSEIF SPLIT_STRING(v_RowData, '|', 1) = 'temp' THEN  -- Process Temperature data
		insert into temperaturesensor(sensor_id, reading_date, temperature, created_date) 
        values(SPLIT_STRING(v_RowData, '|', 2), SPLIT_STRING(v_RowData, '|', 3), SPLIT_STRING(v_RowData, '|', 4), current_timestamp());
    END IF;   
 ELSEIF v_TotalRows > 1 THEN
	loop_label: LOOP
		IF v_CurrentRowIndex <= v_TotalRows THEN
			SELECT SPLIT_STRING(v_RawData, ';', v_CurrentRowIndex) INTO v_RowData;
            -- SELECT v_CurrentRowIndex as rowIndex, v_RowData as rowData, SPLIT_STRING(v_RowData, '|', 2) AS sensor_id, SPLIT_STRING(v_RowData, '|', 3) AS reading_date, SPLIT_STRING(v_RowData, '|', 4) AS accelerometer_x;
            insert into imusensor(created_date, sensor_id, reading_date, 
                    accelerometer_x, accelerometer_y, accelerometer_z, 
                    gyroscope_x, gyroscope_y, gyroscope_z) 
					values(current_timestamp(), SPLIT_STRING(v_RowData, '|', 2), SPLIT_STRING(v_RowData, '|', 3), 
                    SPLIT_STRING(v_RowData, '|', 4),SPLIT_STRING(v_RowData, '|', 5), SPLIT_STRING(v_RowData, '|', 6), 
                    SPLIT_STRING(v_RowData, '|', 7), SPLIT_STRING(v_RowData, '|', 8), SPLIT_STRING(v_RowData, '|', 9));
                
            SET v_CurrentRowIndex = v_CurrentRowIndex + 1; 
		ELSE 
			LEAVE loop_label;
		END IF;
    END LOOP;
	   
 END IF;
	UPDATE raw_data
    SET status = 'P',
		updated_date = current_timestamp()
    WHERE transaction_id = v_Id;
 
 /*
  loop_label: LOOP
	IF v_Id <> '' THEN
		-- process raw data
        
        loop_row: LOOP
			IF
        END LOOP;
        -- insert to table
        -- update sensorRawData table with status = 'P'
        -- fetch next data
		SELECT 'not empty';
        SELECT '' INTO v_Id; 
	ELSE
		-- update raw_data table with status = 'P' from sensorRawData
		SELECT 'empty';
        LEAVE  loop_label;
	END IF;
	END LOOP;
  SELECT v_Id, v_RawData, v_TotalRows;
  */
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-16 15:00:09
