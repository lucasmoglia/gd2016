USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para recuperar una visibilidad.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetVisibilidad
	-- Add the parameters for the stored procedure here
	@cod_visibilidad numeric(18)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_visibilidad
		 , descripcion
		 , costo_publicar
		 , porcentaje_venta
		 , costo_envio
	  FROM [DE_UNA].Visibilidades
	 WHERE (@cod_visibilidad IS NOT NULL AND cod_visibilidad = @cod_visibilidad)
	    OR @cod_visibilidad IS NULL;
END
