USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	SP para recuperar las Ofertas de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetOfertas
	-- Parámetros para los filtros.
	@cod_publi   numeric(18,0),
	@cod_usuario decimal(20,0)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id_oferta, cod_publi, cod_usuario, fecha_oferta, monto

	FROM [DE_UNA].Ofertas

	WHERE (cod_publi    IN (@cod_publi)   OR @cod_publi IS NULL)
	  AND (cod_usuario     IN (@cod_usuario) OR (@cod_usuario) IS NULL)
	ORDER BY cod_publi
END
