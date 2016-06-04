SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 04/06/2016
-- Description:	SP para Migrar las Ofertas y Compras.
-- Este SP no se podrá ejecutar antes de la Migración de la Tabla Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].[Migrar_Ofertas] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	PRINT '-------- Migrando Ofertas... --------';

	INSERT INTO [DE_UNA].[Ofertas]
	SELECT M.[Publicacion_Cod]
		 , C.[cod_usuario]
		 , M.[Oferta_Fecha]
		 , M.[Oferta_Monto]
	  FROM [gd_esquema].[Maestra] M
	  JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
	 WHERE M.[Oferta_Monto] IS NOT NULL;

END
GO
