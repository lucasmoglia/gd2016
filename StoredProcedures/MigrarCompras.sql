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

/*
--  Este proc migra dos registros por compra, tal cual la tabla maestra, uno por la compra en sí y otro por la calificación de esa compra
	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , M.[Calificacion_Cant_Estrellas]
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario];
*/

-- Este procedimiento migra en dos partes, primero aquellos registros correspondientes a la compra calificada y luego aquellas compras no calificadas.
	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , M.[Calificacion_Cant_Estrellas]
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL and M.Calificacion_Codigo is not null
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario], M.[Calificacion_Codigo] desc;

-- Aca me fijo si ya existe un registro en la tabla destino con los datos en común, para no agregarlo. O sea, inserta las compras no calificadas.
	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , M.[Calificacion_Cant_Estrellas]
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL 	and M.Calificacion_Codigo is null 
								and not exists (select 1 from [DE_UNA].[Compras] p where 
															    p.cod_publi		= M.Publicacion_Cod
															and p.cod_usuario   = C.cod_usuario
															and p.cantidad		= M.Compra_Cantidad
															and p.fecha_compra  = M.Compra_Fecha
															and p.monto			= M.Publicacion_Precio
												)
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario], M.[Calificacion_Codigo] desc;


	PRINT '----- Tabla de Compras, Migrada -----';

END
GO

