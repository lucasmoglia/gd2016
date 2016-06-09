SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 06/06/2016
-- Description:	SP para migrar las Publicaciones
-- Éste SP no se podrá ejecutar antes de PoblarTablasSinDependencias ni MigrarUsuarios (Clientes y Empresas).
-- =============================================
ALTER PROCEDURE [DE_UNA].MigrarPublicaciones AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '----- Migrando Publicaciones... -----';

	INSERT INTO [DE_UNA].[Publicaciones] ([cod_publi], [descripcion], [stock], [fecha_inicio], [fecha_vencimiento], [precio_producto],
										  [cod_visibilidad], [cod_estado], [cod_rubro], [cod_usuario], [cod_tipo_publi])
		 SELECT DISTINCT M.[Publicacion_Cod]
			  , M.[Publicacion_Descripcion]
			  , M.[Publicacion_Stock]
			  , M.[Publicacion_Fecha]
			  , M.[Publicacion_Fecha_Venc]
			  , M.[Publicacion_Precio]
			  , M.[Publicacion_Visibilidad_Cod]
			  , EP.[cod_estado]
			  , R.[cod_rubro]
			  , CASE
					WHEN M.[Publ_Empresa_Cuit] IS NOT NULL THEN
						E.[cod_usuario]
					ELSE
						C.[cod_usuario]
				END AS cod_usuario
			  , T.[cod_tipo_publi]
		   FROM [gd_esquema].[Maestra] M
			   JOIN [DE_UNA].[EstadosPublicacion] EP ON M.[Publicacion_Estado] = EP.[descripcion]
			   JOIN [DE_UNA].[Rubros]             R  ON M.[Publicacion_Rubro_Descripcion] = R.[desc_larga]
			   LEFT JOIN [DE_UNA].[Empresas]      E  ON M.[Publ_Empresa_Cuit] = E.[cuit]
			   LEFT JOIN [DE_UNA].[Clientes]      C  ON M.[Publ_Cli_Dni] = C.[dni]
			   JOIN [DE_UNA].[Tipos_Publicacion]  T  ON M.[Publicacion_Tipo] = T.[descripcion]
		   WHERE M.[Publicacion_Cod] IS NOT NULL
		   ORDER BY [Publicacion_Cod];

	PRINT '------- Publicaciones migradas -------';

END
GO

