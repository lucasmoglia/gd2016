USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	SP para recuperar las Compras de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetCompras AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id_compra, cod_publi, cod_usuario, fecha_compra, monto, cantidad, cod_calificacion, estrellas, desc_calificacion
	  FROM [DE_UNA].Compras;
END
