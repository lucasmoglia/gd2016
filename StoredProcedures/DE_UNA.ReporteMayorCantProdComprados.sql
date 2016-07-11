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
-- ==============================================================================================
-- Author:		Lucas Moglia
-- Create date: 10-07-2016
-- Description:	Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de
--				un rubro particular
-- ==============================================================================================
CREATE PROCEDURE DE_UNA.ReporteMayorCantProdComprados
	-- Add the parameters for the stored procedure here
	@mes varchar(2),
	@anio varchar(4),
	@rubro decimal(10,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5
		IIF(CL.dni IS NULL, E.razon_social, CL.Nombre + CL.Apellido) as 'nombre'
		, (SELECT SUM(cantidad) 
			FROM DE_UNA.Compras C2 
			WHERE C2.cod_usuario = C.cod_usuario
			AND MONTH(C2.fecha_compra) = @mes 
			AND YEAR(C2.fecha_compra) = @anio) as 'monto'
	FROM DE_UNA.Compras C
			JOIN DE_UNA.Publicaciones P
				ON C.cod_publi = P.cod_publi
					AND (P.cod_rubro = @rubro OR @rubro = 0)
			LEFT JOIN DE_UNA.Empresas E
				ON C.cod_usuario = E.cod_usuario 
			LEFT JOIN DE_UNA.Clientes CL
				ON C.cod_usuario = CL.cod_usuario 
	GROUP BY C.cod_usuario, CL.dni , E.razon_social, CL.Nombre, CL.Apellido
	ORDER BY (SELECT SUM(cantidad) 
			FROM DE_UNA.Compras C2 
			WHERE C2.cod_usuario = C.cod_usuario
			AND MONTH(C2.fecha_compra) = @mes 
			AND YEAR(C2.fecha_compra) = @anio) desc
END
GO
