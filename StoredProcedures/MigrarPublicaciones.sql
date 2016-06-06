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
CREATE PROCEDURE MigrarPublicaciones AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '----- Migrando Publicaciones... -----';

	INSERT INTO [DE_UNA].[Publicaciones]
		 SELECT M.[Publicacion_Cod]
			  , M.[Publicacion_Descripcion]
			  , M.[Publicacion_Stock]
			  , M.[Publicacion_Fecha]
			  , M.[Publicacion_Fecha_Venc]
			  , M.[Publicacion_Precio]
			  , M.[Publicacion_Visibilidad_Cod]
			  , P.[cod_estado]
			  , R.[cod_rubro]
			  --, (IF [Publ_Empresa_Cuit] IS NULL 
			  --      C.[cod_usuario]
			  --   ELSE
			  --      E.[cod_usuario] 
			  --   END) -- O algo así...!
			  , T.[cod_tipo_publi]
			  , 0 AS con_envio
			  , 0 AS con_preguntas
		   FROM [gd_esquema].[Maestra] M
		   JOIN [DE_UNA].[EstadosPublicacion] P ON M.[Publicacion_Estado] = P.[descripcion]
		   JOIN [DE_UNA].[Tipos_Publicacion] T  ON M.[Publicacion_Tipo] = T.[descripcion]
		   JOIN [DE_UNA].[Rubros] R ON M.[Publicacion_Rubro_Descripcion] = R.[desc_larga]
		   --JOIN [DE_UNA].[Clientes] C ON M.[Publ_Cli_Dni] = C.[dni]
		   --JOIN [DE_UNA].[Empresas] E ON M.[Publ_Empresa_Cuit] = E.[cuit]
		   WHERE M.[Publicacion_Cod] IS NOT NULL;

	PRINT '------- Publicaciones migradas -------';

END
GO
