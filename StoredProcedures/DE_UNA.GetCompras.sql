USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	SP para recuperar las Compras de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetCompras 
	-- Parámetros para los filtros.
	@cod_publi   numeric(18,0),
	@cod_usuario decimal(20,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id_compra
	, cod_publi
	, cod_usuario
	, fecha_compra
	, monto
	, cantidad
	, cod_calificacion
	, estrellas
	, desc_calificacion
	FROM [DE_UNA].Compras
	WHERE		(cod_publi    = @cod_publi   OR @cod_publi	IS NULL)
		  AND	(cod_usuario  = @cod_usuario OR @cod_usuario IS NULL)
	ORDER BY cod_publi
END
