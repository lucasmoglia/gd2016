USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para buscar Items por detalle de Descripcion.
-- =============================================

ALTER PROCEDURE [DE_UNA].BuscarXdetalle
	-- Parámetros para los filtros.
	@cod_usuario decimal(10),
	@descripcion nvarchar(30)
AS
BEGIN


	SELECT I.num_factura
	  FROM [DE_UNA].Items I
	   JOIN [DE_UNA].Facturas F ON I.num_factura = F.num_factura
	   WHERE F.cod_usuario = @cod_usuario AND
			 (I.descripcion_item LIKE '%' + @descripcion + '%' OR @descripcion = '')
END
