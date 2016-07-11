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
-- =======================================================================================================================================
-- Author:		Lucas Moglia
-- Create date: 11-07-2016 01:42 =/
-- Description:	mostrar el nombre de los 5 vendedores con mayor cantidad de productos no vendidos.
--				El tipo de visibilidad a mostrar, lo selecciona el usuario del filtro y las publicaciones a considerar 
--				son aquellas finalizadas en el trimestre seleccionado.
--				En el caso que el vendedor tenga más de una publicación es la sumatoria de las unidades no vendidas.
	--Por ejemplo:

	--Filtro Fechas - Opciones: 1er Tri 2015 - 2er Tri 2015- 3er Tri 2015- 4to Tri 2015 - 1er Tri 2016- 2do Tri 2016...

	--Filtro Visibilidad - Opciones: Oro-Bronce-Plata-Gratis

	--Listado Vendedores ( Resultado)
	--Fabrizio Toro
	--Paz Heli
	--Bustamante Krin
	--Razon Social Nº:7
	--Razon Social Nº:8
-- =======================================================================================================================================
CREATE PROCEDURE DE_UNA.ReporteMayorCantProdNoVendidos 
	-- Add the parameters for the stored procedure here
	@trimestre int, --Numero de trimestre a consultar 1/2/3/4
	@anio varchar(4), --Año
	@visibilidad numeric(18,0) = 0 --Una visibilidad para filtrar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @k int
	SET @k=-1

	--0 - 1 - 2 - 3   INDICE (2X)
	--1 - 2 - 3 - 4   TRIMESTRES
	--1 - 4 - 7 - 10  MES DESDE 
	--3 - 6 - 9 - 12  MES HASTA
	DECLARE @mes_desde varchar(2)
	SET @mes_desde = @trimestre + (2*(@trimestre + @k))
	DECLARE @mes_hasta varchar(2)
	SET @mes_hasta = @mes_desde + 2 

	SELECT TOP 5
		IIF(c.dni IS NULL, E.razon_social, c.Nombre + c.Apellido) as 'nombre'
		, (SELECT SUM(stock) 
		   FROM DE_UNA.Publicaciones P2
		   WHERE P2.cod_usuario = P.cod_usuario 
		   AND P2.stock > 0	
		   AND MONTH(P2.fecha_inicio) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P2.fecha_inicio) = @anio
		   AND (P2.cod_visibilidad = @visibilidad OR @visibilidad = 0)) as 'monto'

	FROM DE_UNA.Publicaciones P
		LEFT JOIN DE_UNA.Empresas E
			ON P.cod_usuario = E.cod_usuario 
		LEFT JOIN DE_UNA.Clientes c
			ON P.cod_usuario = c.cod_usuario 
	WHERE  P.stock > 0	
		   AND MONTH(P.fecha_inicio) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P.fecha_inicio) = @anio
		   AND (P.cod_visibilidad = @visibilidad OR @visibilidad = 0)

	GROUP BY P.cod_usuario, c.dni , E.razon_social, c.Nombre, c.Apellido
	ORDER BY (SELECT SUM(stock) 
		   FROM DE_UNA.Publicaciones P2
		   WHERE P2.cod_usuario = P.cod_usuario 
		   AND P2.stock > 0	
		   AND MONTH(P2.fecha_inicio) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P2.fecha_inicio) = @anio
		   AND (P2.cod_visibilidad = @visibilidad OR @visibilidad = 0)) desc
END
GO
