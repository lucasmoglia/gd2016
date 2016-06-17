USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	SP para recuperar las Ofertas de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetOfertas AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id_oferta, cod_publi, cod_usuario, fecha_oferta, monto
	  FROM [DE_UNA].Ofertas;
END
