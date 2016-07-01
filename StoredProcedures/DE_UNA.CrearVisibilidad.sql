USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

CREATE PROCEDURE [DE_UNA].NuevaVisibilidad
	-- Parámetros para los filtros.
	@descripcion      nvarchar(255),
	@costo_publicar   numeric(18,2),
	@porcentaje_venta numeric(18,2),
	@costo_envio      numeric(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Habría que poner todo esto en un Transacción así me devuelve el CURRENT ID correcto
-- y evitamos problemas de concurrencia.

	DECLARE @cod_visibilidad numeric(18,0) = (SELECT isnull(MAX(cod_visibilidad),0) + 1 AS cod_visibilidad FROM [DE_UNA].Visibilidades);

	INSERT INTO [DE_UNA].Visibilidades
	 VALUES( @cod_visibilidad
		   , @descripcion
		   , @costo_publicar
		   , @porcentaje_venta
		   , @costo_envio
	 );

	 SELECT @cod_visibilidad AS cod_visibilidad;
END
