# MySQL-Database
1. Download MySQL Installer 8.0.19 from https://dev.mysql.com/downloads/installer/
2. Create Database in MySQL workbench:
    a. Database Name: datahub
3.  Open SQL query tab and run this command (make sure datahub is selected):
			i. SET GLOBAL log_bin_trust_function_creators = 1;
4. Run sql script DataHub scripts.sql
5. To create scheduled event , run below script in SQL query tab:
			CREATE EVENT processRawData
			    ON SCHEDULE EVERY 5 SECOND
			    DO
			      CALL spProcessSensorData();
