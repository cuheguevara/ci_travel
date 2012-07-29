-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 29, 2012 at 08:51 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ci_travel`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_departemen_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_delete`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_delete(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_departemen_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_insert`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_insert(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_departemen_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_update`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_update(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_GetModuleAuthenticationByUsername`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetModuleAuthenticationByUsername`(IN `i_username` varchar(50))
BEGIN
	#Routine body goes here...
	SELECT
tref_user.username,
conf_modul.modulID,
conf_modul.modulNama,
conf_modul.modulPage_Form_Controller,
tref_user.`password`,
t_hakakses.is_grant
FROM
t_hakakses
INNER JOIN conf_modul ON t_hakakses.modulID = conf_modul.modulID
INNER JOIN tref_user ON t_hakakses.username = tref_user.username
WHERE	t_hakakses.username = i_username AND t_hakakses.is_grant='Y';
END$$

DROP PROCEDURE IF EXISTS `sp_GetUserByNIP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserByNIP`(IN `i_nip` vaRCHAR(50))
BEGIN
	#Routine body goes here...
SELECT DISTINCT
tref_leveluser.levelID,
tref_user.nip,
tref_user.username,
tref_user.`password`,
tref_leveluser.levelName,
tref_leveluser.levelSlug,
tref_user.userID,
tref_karyawan.namalengkap,
tref_kota.kotaNama,
tref_propinsi.propinsiNama,
tref_karyawan.namapanggilan,
tref_karyawan.alamat,
tref_karyawan.nomortelepon,
tref_karyawan.tanggalmasuk,
tref_karyawan.tanggallahir,
fnKotaById(tref_karyawan.tempatlahir) as kotalahir ,
tref_karyawan.noregistrasikaryawan
FROM
tref_user
INNER JOIN tref_leveluser ON tref_leveluser.levelID = tref_user.levelID
INNER JOIN tref_karyawan ON tref_karyawan.nip = tref_user.nip
INNER JOIN tref_kota ON tref_karyawan.kotaID = tref_kota.kotaID 
INNER JOIN tref_propinsi ON tref_propinsi.propinsiID = tref_kota.propinsiID AND tref_propinsi.propinsiID = tref_karyawan.propinsiID
WHERE	
	tref_user.nip = i_nip ;
END$$

DROP PROCEDURE IF EXISTS `sp_GetUserByUserNameAndPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserByUserNameAndPassword`(IN `i_username` varchar(50),IN `i_password` varchar(50))
BEGIN
	#Routine body goes here...
SELECT DISTINCT
tref_leveluser.levelID,
tref_user.nip,
tref_user.username,
tref_user.`password`,
tref_leveluser.levelName,
tref_leveluser.levelSlug,
tref_user.userID,
tref_karyawan.namalengkap,
tref_kota.kotaNama,
tref_propinsi.propinsiNama,
tref_karyawan.namapanggilan,
tref_karyawan.alamat,
tref_karyawan.nomortelepon,
tref_karyawan.tanggalmasuk,
tref_karyawan.tanggallahir,
fnKotaById(tref_karyawan.tempatlahir) as kotalahir ,
tref_karyawan.noregistrasikaryawan
FROM
tref_user
INNER JOIN tref_leveluser ON tref_leveluser.levelID = tref_user.levelID
INNER JOIN tref_karyawan ON tref_karyawan.nip = tref_user.nip
INNER JOIN tref_kota ON tref_karyawan.kotaID = tref_kota.kotaID 
INNER JOIN tref_propinsi ON tref_propinsi.propinsiID = tref_kota.propinsiID AND tref_propinsi.propinsiID = tref_karyawan.propinsiID
WHERE	
	tref_user.username = username AND tref_user.`password` = i_password;
END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_delete`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_delete(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_insert`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_insert(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_update`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_update(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_kategori_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_kategori_delete`(IN `i_kategoriID` varchar(50),IN `i_kategoriNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefkategori_delete(i_kategoriID,i_kategoriNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_kategori_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_kategori_insert`(IN `i_kategoriID` varchar(50),IN `i_kategoriNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefkategori_insert(i_kategoriID,i_kategoriNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_kategori_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_kategori_update`(IN `i_kategoriID` varchar(50),IN `i_kategoriNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefkategori_update(i_kategoriID,i_kategoriNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_manufaktur_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_manufaktur_delete`(IN `i_manufakturID` varchar(50),IN `i_manufakturNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefmanufaktur_delete(i_manufakturID,i_manufakturNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_manufaktur_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_manufaktur_insert`(IN `i_manufakturID` varchar(50),IN `i_manufakturNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefmanufaktur_insert(i_manufakturID,i_manufakturNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_manufaktur_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_manufaktur_update`(IN `i_manufakturID` varchar(50),IN `i_manufakturNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefmanufaktur_update(i_manufakturID,i_manufakturNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_delete`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_delete(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_insert`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_insert(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_update`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_update(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_tlog_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tlog_insert`(IN `i_aktivitas` varchar(15), IN `i_table` varchar(50), IN `i_penjelasan` text, IN `i_alamatIP` varchar(150), IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	DECLARE logid VARCHAR(150);
	SET logid = UUID();

	INSERT INTO t_log
	(logID, logAktivitas, logTable, logPenjelasan, logKomputer, logTerakhir, logUser)
	VALUES
	(logid, i_aktivitas, i_table,i_penjelasan,i_alamatIP,SYSDATE(),i_user);

END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `fnKotaByID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnKotaByID`(`kotaID` int) RETURNS varchar(50) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaKota = '';
SELECT kotaNama AS kota INTO @namaKota FROM tref_kota WHERE kotaID = kotaID LIMIT 1;
  RETURN @namaKota;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_delete`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_departemen WHERE departemenID=i_departemenID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_insert`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_departemen (tref_departemen.departemenID,tref_departemen.departemenNama) VALUES (i_departemenID,i_departemenNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_update`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_departemen SET departemenNama=i_departemenNama WHERE departemenID=i_departemenID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_delete`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_jabatan WHERE jabatanID=i_jabatanID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_insert`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_jabatan (tref_jabatan.jabatanID,tref_jabatan.jabatanNama) VALUES (i_jabatanID,i_jabatanNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_update`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_jabatan SET jabatanNama=i_jabatanNama WHERE jabatanID=i_jabatanID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefkategori_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefkategori_delete`(`i_kategoriID` varchar(50),`i_kategoriNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_kategori WHERE kategoriID=i_kategoriID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('kategoriID','=',i_kategoriID,'|','kategoriNama','=',i_kategoriNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_KATEGORI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefkategori_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefkategori_insert`(`i_kategoriID` varchar(50),`i_kategoriNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_kategori (tref_kategori.kategoriID,tref_kategori.kategoriNama) VALUES (i_kategoriID,i_kategoriNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('kategoriID','=',i_kategoriID,'|','kategoriNama','=',i_kategoriNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_KATEGORI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefkategori_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefkategori_update`(`i_kategoriID` varchar(50),`i_kategoriNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_kategori SET kategoriNama=i_kategoriNama WHERE kategoriID=i_kategoriID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('kategoriID','=',i_kategoriID,'|','kategoriNama','=',i_kategoriNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_KATEGORI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefmanufaktur_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefmanufaktur_delete`(`i_manufakturID` varchar(50),`i_manufakturNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_manufaktur WHERE manufakturID=i_manufakturID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('manufakturID','=',i_manufakturID,'|','manufakturNama','=',i_manufakturNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_MANUFAKTUR',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefmanufaktur_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefmanufaktur_insert`(`i_manufakturID` varchar(50),`i_manufakturNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_manufaktur (tref_manufaktur.manufakturID,tref_manufaktur.manufakturNama) VALUES (i_manufakturID,i_manufakturNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('manufakturID','=',i_manufakturID,'|','manufakturNama','=',i_manufakturNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_MANUFAKTUR',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefmanufaktur_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefmanufaktur_update`(`i_manufakturID` varchar(50),`i_manufakturNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_manufaktur SET manufakturNama=i_manufakturNama WHERE manufakturID=i_manufakturID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('manufakturID','=',i_manufakturID,'|','manufakturNama','=',i_manufakturNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_MANUFAKTUR',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_delete`(`i_propinsiID` varchar(50),`i_propinsiNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_propinsi WHERE propinsiID=i_propinsiID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',i_propinsiID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_insert`(`i_propinsiID` varchar(50),`i_propinsiNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_propinsi (tref_propinsi.propinsiID,tref_propinsi.propinsiNama) VALUES (i_propinsiID,i_propinsiNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',i_propinsiID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_update`(`i_propinsiID` varchar(50),`i_propinsiNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_propinsi SET propinsiNama=i_propinsiNama WHERE propinsiID=i_propinsiID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',i_propinsiID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('1613a4ee37b1c702bfd6f2549e4f976b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20100101 Firefox/14.0.1 FirePHP/0.7.1', 1343583133, 'a:3:{s:9:"user_data";s:0:"";s:5:"uname";s:4:"sa01";s:3:"nip";s:7:"6304194";}'),
('cf4e2126a2c8dfd40bb005a87395aa9b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11', 1343577434, 'a:3:{s:9:"user_data";s:0:"";s:5:"uname";s:4:"sa01";s:3:"nip";s:7:"6304194";}'),
('d7973b12f68da869bda9fa2d86092ecc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20100101 Firefox/14.0.1', 1343578430, 'a:3:{s:9:"user_data";s:0:"";s:5:"uname";s:4:"sa01";s:3:"nip";s:7:"6304194";}');

-- --------------------------------------------------------

--
-- Table structure for table `conf_modul`
--

DROP TABLE IF EXISTS `conf_modul`;
CREATE TABLE IF NOT EXISTS `conf_modul` (
  `modulID` varchar(10) NOT NULL,
  `modulNama` varchar(50) NOT NULL DEFAULT '0',
  `modulPage_Form_Controller` varchar(150) NOT NULL DEFAULT '0',
  PRIMARY KEY (`modulID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh, Modul Master, Transaksi Booking, Pengadaan Barang, Penjualan, Pembelian';

--
-- Dumping data for table `conf_modul`
--

INSERT INTO `conf_modul` (`modulID`, `modulNama`, `modulPage_Form_Controller`) VALUES
('1', 'Data Master', '#'),
('2', 'Booking', '#'),
('3', 'Laporan', '#');

-- --------------------------------------------------------

--
-- Table structure for table `conf_submodul`
--

DROP TABLE IF EXISTS `conf_submodul`;
CREATE TABLE IF NOT EXISTS `conf_submodul` (
  `submodulID` int(10) NOT NULL AUTO_INCREMENT,
  `modulID` varchar(10) NOT NULL DEFAULT '0',
  `submodulNama` varchar(150) DEFAULT NULL,
  `submodulPage_Form_Controller` varchar(150) DEFAULT NULL,
  `is_aktif` enum('N','Y') DEFAULT 'Y',
  PRIMARY KEY (`submodulID`),
  KEY `modulID` (`modulID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Contoh : Master Kendaraan, master Manufaktur (table yang bersifat stand-alone' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `conf_submodul`
--

INSERT INTO `conf_submodul` (`submodulID`, `modulID`, `submodulNama`, `submodulPage_Form_Controller`, `is_aktif`) VALUES
(1, '1', 'Manufaktur', 'Trefmanufaktur', 'Y'),
(2, '1', 'Model', 'Trefmodel', 'N'),
(3, '1', 'Kategori', 'Trefkategori', 'Y'),
(4, '1', 'Propinsi', 'Trefpropinsi', 'Y'),
(5, '1', 'Departemen', 'Trefdepartemen', 'Y'),
(6, '1', 'Jabatan', 'Trefjabatan', 'Y'),
(7, '1', 'Kota', 'Trefkota', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `tref_departemen`
--

DROP TABLE IF EXISTS `tref_departemen`;
CREATE TABLE IF NOT EXISTS `tref_departemen` (
  `departemenID` varchar(5) NOT NULL,
  `departemenNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`departemenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_departemen`
--

INSERT INTO `tref_departemen` (`departemenID`, `departemenNama`) VALUES
('1', 'Sales'),
('2', 'Informasi dan Teknologi'),
('3', 'Bengkel'),
('4', 'Finance'),
('5', 'Accounting'),
('6', 'Customer Service'),
('M01', 'RnD');

-- --------------------------------------------------------

--
-- Table structure for table `tref_jabatan`
--

DROP TABLE IF EXISTS `tref_jabatan`;
CREATE TABLE IF NOT EXISTS `tref_jabatan` (
  `jabatanID` varchar(5) NOT NULL,
  `jabatanNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jabatanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_jabatan`
--

INSERT INTO `tref_jabatan` (`jabatanID`, `jabatanNama`) VALUES
('1', 'Staff'),
('2', 'Koordinator'),
('3', 'Supervisor'),
('4', 'Manager'),
('5', 'Direktur'),
('M01', 'Office Boy');

-- --------------------------------------------------------

--
-- Table structure for table `tref_karyawan`
--

DROP TABLE IF EXISTS `tref_karyawan`;
CREATE TABLE IF NOT EXISTS `tref_karyawan` (
  `nip` varchar(9) NOT NULL,
  `namalengkap` varchar(150) NOT NULL,
  `namapanggilan` varchar(50) DEFAULT NULL,
  `alamat` text,
  `propinsiID` varchar(4) DEFAULT NULL,
  `kotaID` varchar(8) DEFAULT NULL,
  `nomortelepon` varchar(50) DEFAULT NULL,
  `tanggalmasuk` date DEFAULT NULL,
  `tanggallahir` date DEFAULT NULL,
  `tempatlahir` varchar(5) DEFAULT NULL,
  `noregistrasikaryawan` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`nip`,`noregistrasikaryawan`),
  KEY `propinsiID` (`propinsiID`),
  KEY `FK_tref_karyawan_tref_kota` (`kotaID`),
  KEY `FK_tref_karyawan_tref_kota_2` (`tempatlahir`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_karyawan`
--

INSERT INTO `tref_karyawan` (`nip`, `namalengkap`, `namapanggilan`, `alamat`, `propinsiID`, `kotaID`, `nomortelepon`, `tanggalmasuk`, `tanggallahir`, `tempatlahir`, `noregistrasikaryawan`) VALUES
('6304194', 'Suhendra', 'hendra', 'Jalan Rengasdengklok 3 No 17 Bandung', 'P001', 'K0001', '0123', '2012-01-01', '1986-01-01', 'K0004', 'REG2407970001');

-- --------------------------------------------------------

--
-- Table structure for table `tref_kategori`
--

DROP TABLE IF EXISTS `tref_kategori`;
CREATE TABLE IF NOT EXISTS `tref_kategori` (
  `kategoriID` varchar(3) NOT NULL DEFAULT '0',
  `kategoriNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kategoriID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh : Truk, Sedan, Elf';

--
-- Dumping data for table `tref_kategori`
--

INSERT INTO `tref_kategori` (`kategoriID`, `kategoriNama`) VALUES
('K01', 'Truk'),
('K02', 'Sedan'),
('K03', 'Mobil Box');

-- --------------------------------------------------------

--
-- Table structure for table `tref_kendaraan`
--

DROP TABLE IF EXISTS `tref_kendaraan`;
CREATE TABLE IF NOT EXISTS `tref_kendaraan` (
  `kendaraanID` varchar(20) NOT NULL DEFAULT '',
  `kategoriID` varchar(3) NOT NULL DEFAULT '0',
  `modelID` varchar(5) NOT NULL DEFAULT '',
  `manufakturID` varchar(8) NOT NULL DEFAULT '',
  `nomorKendaraan` int(8) NOT NULL DEFAULT '0',
  `kapasitas` int(8) DEFAULT NULL,
  `foto` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kendaraanID`,`kategoriID`,`modelID`,`manufakturID`,`nomorKendaraan`),
  KEY `FK_tref_kendaraan_tref_model` (`modelID`),
  KEY `FK_tref_kendaraan_tref_manufaktur` (`manufakturID`),
  KEY `kategoriID` (`kategoriID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tref_konsumen`
--

DROP TABLE IF EXISTS `tref_konsumen`;
CREATE TABLE IF NOT EXISTS `tref_konsumen` (
  `konsumenID` varchar(15) NOT NULL DEFAULT '',
  `konsumenNama` varchar(75) DEFAULT NULL,
  `alamat` text,
  `kotaID` varchar(5) NOT NULL DEFAULT '0',
  `propinsiID` varchar(4) NOT NULL DEFAULT '0',
  `kodepos` varchar(5) DEFAULT NULL,
  `nomorKTP` varchar(30) NOT NULL DEFAULT '',
  `nomorTelepon` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`konsumenID`,`kotaID`,`propinsiID`,`nomorKTP`),
  KEY `propinsiID` (`propinsiID`),
  KEY `FK_tref_konsumen_tref_kota` (`kotaID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tref_kota`
--

DROP TABLE IF EXISTS `tref_kota`;
CREATE TABLE IF NOT EXISTS `tref_kota` (
  `kotaID` varchar(5) NOT NULL,
  `kotaNama` varchar(50) DEFAULT NULL,
  `propinsiID` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`kotaID`),
  KEY `propinsiID` (`propinsiID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_kota`
--

INSERT INTO `tref_kota` (`kotaID`, `kotaNama`, `propinsiID`) VALUES
('K0001', 'Jakarta', 'P001'),
('K0002', 'Bogor', 'P001'),
('K0003', 'Depok', 'P001'),
('K0004', 'Tangerang', 'P001'),
('K0005', 'Bekasi', 'P002'),
('K0006', 'Bandung', 'P002');

-- --------------------------------------------------------

--
-- Table structure for table `tref_leveluser`
--

DROP TABLE IF EXISTS `tref_leveluser`;
CREATE TABLE IF NOT EXISTS `tref_leveluser` (
  `levelID` int(8) NOT NULL AUTO_INCREMENT COMMENT 'ID Level dari User',
  `levelName` varchar(25) NOT NULL DEFAULT 'Administrator' COMMENT 'Nama Level dari User',
  `levelSlug` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`levelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tref_leveluser`
--

INSERT INTO `tref_leveluser` (`levelID`, `levelName`, `levelSlug`) VALUES
(1, 'Super Administrator', 'sa'),
(2, 'Administrator', 'admin'),
(3, 'Manager', 'mgr'),
(4, 'Operator', 'opr');

-- --------------------------------------------------------

--
-- Table structure for table `tref_lokasi`
--

DROP TABLE IF EXISTS `tref_lokasi`;
CREATE TABLE IF NOT EXISTS `tref_lokasi` (
  `lokasiID` int(8) NOT NULL DEFAULT '0',
  `kotaID` varchar(5) NOT NULL DEFAULT '0',
  `lokasiNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`lokasiID`,`kotaID`),
  KEY `FK_tref_lokasi_tref_kota` (`kotaID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh : Cabang Surapati, Pasteur, Dago, Sekeloa, Jatiwaringin, Pondok Gede';

-- --------------------------------------------------------

--
-- Table structure for table `tref_manufaktur`
--

DROP TABLE IF EXISTS `tref_manufaktur`;
CREATE TABLE IF NOT EXISTS `tref_manufaktur` (
  `manufakturID` varchar(8) NOT NULL,
  `manufakturNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`manufakturID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh : Toyota, Honda, Volkwagen dll';

--
-- Dumping data for table `tref_manufaktur`
--

INSERT INTO `tref_manufaktur` (`manufakturID`, `manufakturNama`) VALUES
('M01', 'Honda'),
('M02', 'Toyota XX'),
('M03', 'Nissan'),
('M04', 'Mobil');

-- --------------------------------------------------------

--
-- Table structure for table `tref_model`
--

DROP TABLE IF EXISTS `tref_model`;
CREATE TABLE IF NOT EXISTS `tref_model` (
  `modelID` varchar(5) NOT NULL,
  `manufakturID` varchar(8) DEFAULT NULL,
  `modelNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`modelID`),
  KEY `manufakturID` (`manufakturID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh : Camry AT, Camry MT, Jazz RS AT, Jazz RS MT, Elf Mesin Kuda AT';

-- --------------------------------------------------------

--
-- Table structure for table `tref_propinsi`
--

DROP TABLE IF EXISTS `tref_propinsi`;
CREATE TABLE IF NOT EXISTS `tref_propinsi` (
  `propinsiID` varchar(4) NOT NULL,
  `propinsiNama` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`propinsiID`),
  UNIQUE KEY `propinsiNama` (`propinsiNama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_propinsi`
--

INSERT INTO `tref_propinsi` (`propinsiID`, `propinsiNama`) VALUES
('P001', 'Jakarta'),
('P002', 'Jawa Barat'),
('P003', 'Jawa Tengah'),
('P004', 'Jawa Timur');

-- --------------------------------------------------------

--
-- Table structure for table `tref_user`
--

DROP TABLE IF EXISTS `tref_user`;
CREATE TABLE IF NOT EXISTS `tref_user` (
  `userID` varchar(8) NOT NULL,
  `levelID` int(8) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nip` varchar(9) NOT NULL,
  PRIMARY KEY (`userID`,`levelID`),
  UNIQUE KEY `nip` (`nip`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_tref_user_tref_leveluser` (`levelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_user`
--

INSERT INTO `tref_user` (`userID`, `levelID`, `username`, `password`, `nip`) VALUES
('UID00001', 1, 'sa01', 'sa01', '6304194');

-- --------------------------------------------------------

--
-- Table structure for table `t_booking`
--

DROP TABLE IF EXISTS `t_booking`;
CREATE TABLE IF NOT EXISTS `t_booking` (
  `orderID` varchar(50) NOT NULL,
  `orderTanggal` date DEFAULT NULL,
  `jadwalID` varchar(50) NOT NULL DEFAULT '',
  `konsumenID` varchar(15) NOT NULL DEFAULT '',
  `pengendaraID` varchar(9) NOT NULL DEFAULT '',
  `operatorID` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`orderID`,`jadwalID`,`konsumenID`,`pengendaraID`,`operatorID`),
  KEY `FK_t_booking_t_jadwal_berangkat` (`jadwalID`),
  KEY `FK_t_booking_tref_karyawan` (`pengendaraID`),
  KEY `FK_t_booking_tref_user` (`operatorID`),
  KEY `FK_t_booking_tref_konsumen` (`konsumenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_booking_detail`
--

DROP TABLE IF EXISTS `t_booking_detail`;
CREATE TABLE IF NOT EXISTS `t_booking_detail` (
  `indexBiayaTambahan` int(8) NOT NULL AUTO_INCREMENT,
  `orderID` varchar(50) NOT NULL DEFAULT '',
  `namaBiaya` varchar(150) DEFAULT NULL,
  `harga` double DEFAULT NULL,
  PRIMARY KEY (`indexBiayaTambahan`,`orderID`),
  KEY `FK_t_booking_detail_t_booking` (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `t_hakakses`
--

DROP TABLE IF EXISTS `t_hakakses`;
CREATE TABLE IF NOT EXISTS `t_hakakses` (
  `username` varchar(50) NOT NULL,
  `modulID` varchar(10) NOT NULL,
  `is_grant` enum('N','Y') DEFAULT 'Y',
  PRIMARY KEY (`username`,`modulID`),
  KEY `modulID` (`modulID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_hakakses`
--

INSERT INTO `t_hakakses` (`username`, `modulID`, `is_grant`) VALUES
('sa01', '1', 'Y'),
('sa01', '2', 'Y'),
('sa01', '3', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `t_jadwal_berangkat`
--

DROP TABLE IF EXISTS `t_jadwal_berangkat`;
CREATE TABLE IF NOT EXISTS `t_jadwal_berangkat` (
  `jadwalID` varchar(50) NOT NULL DEFAULT '',
  `kendaraanID` varchar(20) NOT NULL DEFAULT '',
  `lokasi_asal_id` int(8) NOT NULL DEFAULT '0',
  `lokasi_tujuan_id` int(8) NOT NULL DEFAULT '0',
  `waktu_keberangkatan` datetime DEFAULT NULL,
  PRIMARY KEY (`jadwalID`,`lokasi_asal_id`,`lokasi_tujuan_id`,`kendaraanID`),
  KEY `FK_t_jadwal_berangkat_tref_lokasi` (`lokasi_asal_id`),
  KEY `FK_t_jadwal_berangkat_tref_lokasi_2` (`lokasi_tujuan_id`),
  KEY `FK_t_jadwal_berangkat_tref_kendaraan` (`kendaraanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
CREATE TABLE IF NOT EXISTS `t_log` (
  `logID` varchar(64) NOT NULL DEFAULT '',
  `logAktivitas` enum('INSERT','UPDATE','DELETE') NOT NULL DEFAULT 'INSERT',
  `logTable` varchar(50) DEFAULT NULL,
  `logPenjelasan` text,
  `logKomputer` varchar(64) DEFAULT NULL,
  `logTerakhir` datetime DEFAULT NULL,
  `logUser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`logID`,`logAktivitas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_log`
--

INSERT INTO `t_log` (`logID`, `logAktivitas`, `logTable`, `logPenjelasan`, `logKomputer`, `logTerakhir`, `logUser`) VALUES
('041b007d-d98c-11e1-bf13-5442495fad6a', 'UPDATE', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota XX', '127.0.0.1', '2012-07-29 21:45:18', 'sa01'),
('638c3281-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Sedan', '127.0.0.1', '2012-07-28 02:08:02', 'sa01'),
('9342061e-d824-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_PROPINSI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:19', 'sa01'),
('9452be20-d8ae-11e1-99a8-5442495fad6a', 'INSERT', 'TREF_JABATAN', 'jabatanID=M01|jabatanNama=Office Boy', '127.0.0.1', '2012-07-28 19:20:12', 'sa01'),
('98c48277-d827-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_DEPARTEMEN', 'departemenID=2|departemenNama=Informasi dan Teknologi', '127.0.0.1', '2012-07-28 03:13:57', 'sa01'),
('99539e7f-d81d-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Truk', '127.0.0.1', '2012-07-28 02:02:23', 'sa01'),
('9edba2f1-d824-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=P001|propinsiNama=Jakarta', '127.0.0.1', '2012-07-28 02:52:39', 'sa01'),
('a1062034-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K03|kategoriNama=Mobil Box', '127.0.0.1', '2012-07-28 02:09:46', 'sa01'),
('a32a260d-d824-11e1-9bee-5442495fad6a', 'DELETE', 'TREF_KATEGORI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:46', 'sa01'),
('abd28a7c-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:25', 'sa01'),
('b05177f3-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:32', 'sa01'),
('b5d78df3-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:41', 'sa01'),
('b84cdadd-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:45', 'sa01'),
('c4ec09ae-d99e-11e1-bf13-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M04|manufakturNama=Mobil', '127.0.0.1', '2012-07-29 23:59:33', 'sa01'),
('c8c8e528-d827-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=M01|departemenNama=RnD', '127.0.0.1', '2012-07-28 03:15:18', 'sa01'),
('c9596993-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Honda', '127.0.0.1', '2012-07-28 02:25:12', 'sa01'),
('f47f3b66-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota', '127.0.0.1', '2012-07-28 02:26:25', 'sa01'),
('fe549894-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M03|manufakturNama=Nissan', '127.0.0.1', '2012-07-28 02:26:41', 'sa01');

-- --------------------------------------------------------

--
-- Table structure for table `t_menjabat`
--

DROP TABLE IF EXISTS `t_menjabat`;
CREATE TABLE IF NOT EXISTS `t_menjabat` (
  `menjabatID` varchar(9) NOT NULL DEFAULT '',
  `periodeAwal` date DEFAULT NULL,
  `periodeAkhir` date DEFAULT NULL,
  `nip` varchar(9) NOT NULL DEFAULT '',
  `departemenID` varchar(5) DEFAULT NULL,
  `jabatanID` varchar(5) DEFAULT NULL,
  `periodeTahunAwal` varchar(5) DEFAULT NULL,
  `periodeTahunAkhir` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`menjabatID`,`nip`),
  KEY `FK_t_menjabat_tref_karyawan` (`nip`),
  KEY `FK_t_menjabat_tref_departemen` (`departemenID`),
  KEY `FK_t_menjabat_tref_jabatan` (`jabatanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_menjabat`
--

INSERT INTO `t_menjabat` (`menjabatID`, `periodeAwal`, `periodeAkhir`, `nip`, `departemenID`, `jabatanID`, `periodeTahunAwal`, `periodeTahunAkhir`) VALUES
('JB0000107', '2012-07-28', '2015-07-28', '6304194', '2', '4', '2012', '2015');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `conf_submodul`
--
ALTER TABLE `conf_submodul`
  ADD CONSTRAINT `conf_submodul_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_karyawan`
--
ALTER TABLE `tref_karyawan`
  ADD CONSTRAINT `FK_tref_karyawan_tref_kota` FOREIGN KEY (`kotaID`) REFERENCES `tref_kota` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tref_karyawan_tref_kota_2` FOREIGN KEY (`tempatlahir`) REFERENCES `tref_kota` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_karyawan_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_kendaraan`
--
ALTER TABLE `tref_kendaraan`
  ADD CONSTRAINT `FK_tref_kendaraan_tref_manufaktur` FOREIGN KEY (`manufakturID`) REFERENCES `tref_manufaktur` (`manufakturID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tref_kendaraan_tref_model` FOREIGN KEY (`modelID`) REFERENCES `tref_model` (`modelID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_kendaraan_ibfk_1` FOREIGN KEY (`kategoriID`) REFERENCES `tref_kategori` (`kategoriID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_konsumen`
--
ALTER TABLE `tref_konsumen`
  ADD CONSTRAINT `FK_tref_konsumen_tref_kota` FOREIGN KEY (`kotaID`) REFERENCES `tref_kota` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_konsumen_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_kota`
--
ALTER TABLE `tref_kota`
  ADD CONSTRAINT `tref_kota_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_lokasi`
--
ALTER TABLE `tref_lokasi`
  ADD CONSTRAINT `FK_tref_lokasi_tref_kota` FOREIGN KEY (`kotaID`) REFERENCES `tref_kota` (`kotaID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tref_model`
--
ALTER TABLE `tref_model`
  ADD CONSTRAINT `FK_tref_model_tref_manufaktur` FOREIGN KEY (`manufakturID`) REFERENCES `tref_manufaktur` (`manufakturID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_user`
--
ALTER TABLE `tref_user`
  ADD CONSTRAINT `FK_tref_user_tref_leveluser` FOREIGN KEY (`levelID`) REFERENCES `tref_leveluser` (`levelID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `t_booking`
--
ALTER TABLE `t_booking`
  ADD CONSTRAINT `FK_t_booking_tref_karyawan` FOREIGN KEY (`pengendaraID`) REFERENCES `tref_karyawan` (`nip`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_booking_tref_konsumen` FOREIGN KEY (`konsumenID`) REFERENCES `tref_konsumen` (`konsumenID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_booking_tref_user` FOREIGN KEY (`operatorID`) REFERENCES `tref_user` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_booking_t_jadwal_berangkat` FOREIGN KEY (`jadwalID`) REFERENCES `t_jadwal_berangkat` (`jadwalID`) ON UPDATE CASCADE;

--
-- Constraints for table `t_booking_detail`
--
ALTER TABLE `t_booking_detail`
  ADD CONSTRAINT `FK_t_booking_detail_t_booking` FOREIGN KEY (`orderID`) REFERENCES `t_booking` (`orderID`) ON UPDATE CASCADE;

--
-- Constraints for table `t_hakakses`
--
ALTER TABLE `t_hakakses`
  ADD CONSTRAINT `FK_t_hakakses_tref_user` FOREIGN KEY (`username`) REFERENCES `tref_user` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `t_hakakses_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE;

--
-- Constraints for table `t_jadwal_berangkat`
--
ALTER TABLE `t_jadwal_berangkat`
  ADD CONSTRAINT `FK_t_jadwal_berangkat_tref_kendaraan` FOREIGN KEY (`kendaraanID`) REFERENCES `tref_kendaraan` (`kendaraanID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_jadwal_berangkat_tref_lokasi` FOREIGN KEY (`lokasi_asal_id`) REFERENCES `tref_lokasi` (`lokasiID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_jadwal_berangkat_tref_lokasi_2` FOREIGN KEY (`lokasi_tujuan_id`) REFERENCES `tref_lokasi` (`lokasiID`) ON UPDATE CASCADE;

--
-- Constraints for table `t_menjabat`
--
ALTER TABLE `t_menjabat`
  ADD CONSTRAINT `FK_t_menjabat_tref_departemen` FOREIGN KEY (`departemenID`) REFERENCES `tref_departemen` (`departemenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_menjabat_tref_jabatan` FOREIGN KEY (`jabatanID`) REFERENCES `tref_jabatan` (`jabatanID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_menjabat_tref_karyawan` FOREIGN KEY (`nip`) REFERENCES `tref_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
