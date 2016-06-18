USE [GD1C2016]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una oferta.
-- RETORNA: 0 --> No es una oferta mayor a la última.
--          1 --> Ejecución OK.
-- =============================================
CREATE PROCEDURE [DE_UNA].NuevaOferta
	-- PARAMETROS:
	@cod_publi numeric(18, 0),
	@cod_usuario decimal(20, 0),
	@fecha_oferta datetime,
	@monto numeric(18, 2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @stock numeric(18,0) = (SELECT stock FROM [DE_UNA].Publicaciones WHERE cod_publi = @cod_publi);

	--IF (!([DE_UNA].esMayorAUltimaOferta(@monto, @cod_publi))
	--	RETURN 0;

	INSERT INTO [DE_UNA].Ofertas
	VALUES(@cod_publi, @cod_usuario, @fecha_oferta, @monto);

	RETURN 1;
END
GO
