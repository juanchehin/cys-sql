DROP procedure IF EXISTS `bsp_reporte_sueldo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_reporte_sueldo`(pIdUsuario int,pDesde int)
BEGIN
	/*
	Permite listar los pedidos pendientes de un usuario dado su IdUsuario
    */
-- Control de el parametro 'pDesde' por si viene igualado a cero

    IF pDesde <=0 THEN
        SET pDesde = 0;
    END IF;

    SELECT		ped.IdPedido,pad.Apellidos,pad.Nombres,tp.Pedido,ped.Fecha,ped.Estado,u.Usuario
    FROM		pedidos	ped 
				LEFT JOIN padron pad ON ped.IdPersonaBeneficiario = pad.IdPersona
				LEFT JOIN tipospedidos tp on ped.IdTipoPedido = tp.IdTipoPedido
                LEFT JOIN usuarios u on ped.IdUsuario = u.IdUsuario
	WHERE		ped.Estado = 'P' AND ped.IdUsuario = pIdUsuario
    LIMIT 		pDesde,5;
    
	-- SELECT MAX(IdConstruccion) AS maximo
	-- FROM construcciones; 
END ;;
DELIMITER ;