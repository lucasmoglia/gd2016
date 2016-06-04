SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 04/06/2016
-- Description:	SP para Migrar las Ofertas y Compras
-- =============================================
CREATE PROCEDURE [DE_UNA].[Migrar_Ofertas] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	PRINT '-------- Migración de Ofertas --------';

	INSERT INTO [DE_UNA].[Ofertas]
	SELECT *
	  FROM [gd_esquema].[Maestra]
	 WHERE 
END
GO
