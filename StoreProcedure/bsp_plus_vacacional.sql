DROP procedure IF EXISTS `bsp_plus_vacacional`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_plus_vacacional`()
SALIR:BEGIN
	/*
	Permite generar un listado de todos los empleados que 
    tengan planificadas las vacaciones en el mes de abril o que, 
    en su defecto, no tengan vacaciones planificadas.
    */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje,
				NULL AS Id;
		ROLLBACK;
	END;
    SELECT 	e.Nombre,
			e.Posicion,
            'Si' as vacacionesAbril
            FROM vacaciones_2021 v
            INNER JOIN emp e
            ON v.id_emp = e.ID
            WHERE	v.fecha
            BETWEEN '2023-04-01' AND '2023-04-30'; 
            
	SELECT 	e.Nombre,
			e.Posicion,
            'No' as vacacionesAbril
            FROM vacaciones_2021 v
            INNER JOIN emp e
            ON v.id_emp = e.ID
            WHERE	v.fecha < '2023-04-01' OR v.fecha > '2023-04-30'; 

END $$
DELIMITER ;