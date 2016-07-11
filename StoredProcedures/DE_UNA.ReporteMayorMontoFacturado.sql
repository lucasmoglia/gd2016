-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Lucas Moglia
-- Create date: 10-07-2016
-- Description:	Vendedores con mayor monto facturado dentro de un mes y a�o particular.
-- ==========================================================================================
ALTER PROCEDURE [DE_UNA].[ReporteMayorMontoFacturado]
	-- Add the parameters for the stored procedure here
	@mes varchar(2),
	@anio varchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5
	IIF(c.dni IS NULL, E.razon_social, c.Nombre + c.Apellido) as 'nombre'
	, (SELECT SUM(total) 
	   FROM DE_UNA.Facturas F2 
	   WHERE F2.cod_usuario = F.cod_usuario
	   AND MONTH(F2.fecha_factura) = @mes 
	   AND YEAR(F2.fecha_factura) = @anio) as 'monto'
	FROM DE_UNA.Facturas F
			LEFT JOIN DE_UNA.Empresas E
				ON F.cod_usuario = E.cod_usuario 
			LEFT JOIN DE_UNA.Clientes c
				ON F.cod_usuario = c.cod_usuario 
	WHERE MONTH(F.fecha_factura) = @mes AND YEAR(F.fecha_factura) = @anio
	GROUP BY F.cod_usuario, c.dni , E.razon_social, c.Nombre, c.Apellido
	ORDER BY (SELECT SUM(total) 
		   FROM DE_UNA.Facturas F2 
		   WHERE F2.cod_usuario = F.cod_usuario
		   AND MONTH(F2.fecha_factura) = @mes 
		   AND YEAR(F2.fecha_factura) = @anio) desc
END
GO
