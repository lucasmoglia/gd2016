USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar los Tipos de Publicacion.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetTiposPublicacion AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_tipo_publi
		 , descripcion
	  FROM [DE_UNA].Tipos_Publicacion;
END
