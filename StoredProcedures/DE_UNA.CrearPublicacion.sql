USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar las Funcionalidades.
-- =============================================
CREATE PROCEDURE [DE_UNA].CrearPublicacion AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @estados          TABLE(cod_estado numeric(1, 0) NOT NULL, 
									descripcion nvarchar(255) NULL) = EXEC [DE_UNA].[GetEstadosPublicacion]);
	DECLARE @rubros           TABLE(EXEC [DE_UNA].[GetRubros]);
	DECLARE @visibilidades    TABLE() = EXEC [DE_UNA].[GetVisibilidades];
	DECLARE @tiposPublicacion TABLE = EXEC [DE_UNA].[GetTiposPublicacion];
END
