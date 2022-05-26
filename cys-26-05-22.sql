-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.31 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para cys
CREATE DATABASE IF NOT EXISTS `cys` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cys`;

-- Volcando estructura para procedimiento cys.bsp_plus_vacacional
DELIMITER //
CREATE PROCEDURE `bsp_plus_vacacional`()
SALIR:BEGIN
	/*
	Permite generar un listado de todos los empleados que 
    tengan planificadas las vacaciones en el mes de abril o que, 
    en su defecto, no tengan vacaciones planificadas.
    */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
    
    (SELECT e.Nombre,
			e.Posicion,
            'Si' as vacacionesAbril
            FROM vacaciones_2021 v
            INNER JOIN emp e
            ON v.id_emp = e.ID
            WHERE	v.fecha
            BETWEEN '2021-04-01' AND '2021-04-30'
	)
    UNION
    (            
	SELECT 	e.Nombre,
			e.Posicion,
            'No' as vacacionesAbril
            FROM vacaciones_2021 v
            INNER JOIN emp e
            ON v.id_emp = e.ID
            WHERE	v.fecha < '2021-04-01' OR v.fecha > '2021-04-30'
	);
END//
DELIMITER ;

-- Volcando estructura para procedimiento cys.bsp_reporte_sueldo
DELIMITER //
CREATE PROCEDURE `bsp_reporte_sueldo`()
SALIR:BEGIN
	/*
	Permite generar un reporte que muestre sueldo mínimo, 
    máximo, y promedio por posición dentro de la empresa, 
    para poder ver el impacto del aumento por inflación de este año
    */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
    SELECT 	e.Posicion,
			MAX(sueldo) AS SueldoMaximo,
			MIN(sueldo) AS SueldoMinimo,
            AVG(sueldo) AS SueldoPromedio 
            FROM sueldos s
            INNER JOIN emp e
            ON s.id_emp = e.ID 
            GROUP BY e.Posicion; 

END//
DELIMITER ;

-- Volcando estructura para tabla cys.emp
CREATE TABLE IF NOT EXISTS `emp` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Posicion` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla cys.emp: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` (`ID`, `Nombre`, `Posicion`) VALUES
	(1, 'Juan', 'Dev Ssr'),
	(2, 'Carolina', 'Dev Sr'),
	(3, 'Carlos', 'Diseñador'),
	(4, 'Josefina', 'Analista Func'),
	(5, 'Antonio', 'Dev Sr'),
	(6, 'Josesito', 'Dev Sr');
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;

-- Volcando estructura para tabla cys.sueldos
CREATE TABLE IF NOT EXISTS `sueldos` (
  `id` int(11) NOT NULL,
  `id_emp` int(11) NOT NULL,
  `sueldo` float DEFAULT NULL,
  PRIMARY KEY (`id`,`id_emp`),
  KEY `fk_Sueldos_Emp_idx` (`id_emp`),
  CONSTRAINT `fk_Sueldos_Emp` FOREIGN KEY (`id_emp`) REFERENCES `emp` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla cys.sueldos: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `sueldos` DISABLE KEYS */;
INSERT INTO `sueldos` (`id`, `id_emp`, `sueldo`) VALUES
	(1, 3, 1000),
	(2, 4, 2000),
	(3, 1, 2500),
	(4, 6, 1500),
	(5, 2, 900);
/*!40000 ALTER TABLE `sueldos` ENABLE KEYS */;

-- Volcando estructura para tabla cys.vacaciones_2021
CREATE TABLE IF NOT EXISTS `vacaciones_2021` (
  `id` int(11) NOT NULL,
  `id_emp` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`id_emp`),
  KEY `fk_vacaciones_2021_Emp1_idx` (`id_emp`),
  CONSTRAINT `fk_vacaciones_2021_Emp1` FOREIGN KEY (`id_emp`) REFERENCES `emp` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla cys.vacaciones_2021: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `vacaciones_2021` DISABLE KEYS */;
INSERT INTO `vacaciones_2021` (`id`, `id_emp`, `fecha`) VALUES
	(1, 4, '2021-01-01 00:00:00'),
	(2, 1, '2021-04-04 00:00:00');
/*!40000 ALTER TABLE `vacaciones_2021` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
