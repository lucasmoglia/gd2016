USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 09/07/2016
-- Description:	SP para modificar una publicación.
-- =============================================
CREATE PROCEDURE [DE_UNA].ActualizarPublicacion
	-- Parámetros para los filtros.
	@descripcion     nvarchar(255),
	@stock           numeric(18,0),
	@fecha_inicio    datetime,
	@fecha_venc      datetime,
	@precio          numeric(18,2),
	@cod_visibilidad numeric(18,0),
	@cod_estado      numeric(1),
	@cod_rubro       decimal(10),
	@cod_usuario     decimal(20),
	@cod_tipo_publi  numeric (1),
	@con_envio       bit,
	@con_preguntas   bit,
	@fecha_finaliz  datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Habría que poner todo esto en un Transacción así me devuelve el CURRENT ID correcto
-- y evitamos problemas de concurrencia.

	DECLARE @cod_publi numeric(18, 0) = (SELECT MAX(cod_publi) + 1 AS cod_publi FROM [DE_UNA].Publicaciones);

	UPDATE [DE_UNA].Publicaciones
	 SET  descripcion = @descripcion
		, stock = @stock
		, fecha_inicio = @fecha_inicio
		, fecha_vencimiento = @fecha_venc
		, precio_producto   = @precio
		, cod_visibilidad = @cod_visibilidad
		, cod_estado = @cod_estado
		, cod_rubro = @cod_rubro
		, cod_usuario = @cod_usuario
		, cod_tipo_publi = @cod_tipo_publi
		, con_envio = @con_envio
		, con_preguntas = @con_preguntas
		, fecha_finalizacion = @fecha_finaliz
	 WHERE cod_publi = @cod_publi

	 SELECT @cod_publi AS cod_publi;
END
