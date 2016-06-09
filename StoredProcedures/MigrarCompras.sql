SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 09/06/2016
-- Description:	SP de migración de Compras.
-- =============================================
CREATE PROCEDURE [DE_UNA].MigrarCompras AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '-------- Migrando Compras... --------';

	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Factura_Total] -- NO! Hay que ver q mandarle aca!
			  , M.[Calificacion_Cant_Estrellas]
			  , M.[Calificacion_Descripcion]
			  , M.[Compra_Cantidad]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL;

	PRINT '----- Tabla de Compras, Migrada -----';

END
GO
