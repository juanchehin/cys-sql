DROP procedure IF EXISTS `bsp_reporte_sueldo`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_reporte_sueldo`()
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

END $$
DELIMITER ;