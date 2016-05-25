USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[PoblarTablasSinDependencias]    Script Date: 25/5/2016 7:08:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PoblarTablasSinDependencias]
AS
BEGIN
	DECLARE @Estados TABLE (
	 Id numeric(1),
	 Descripcion nvarchar(255)
	)

	INSERT @Estados VALUES (0, 'Borrador');
	INSERT @Estados VALUES (1, 'Activa');
	INSERT @Estados VALUES (2, 'Pausada');
	INSERT @Estados VALUES (3, 'Finalizada');

	INSERT INTO [EstadosPublicacion]
	     SELECT * FROM @Estados;

	INSERT INTO [Visibilidades]
		SELECT DISTINCT
			  [Publicacion_Visibilidad_Cod]
			, [Publicacion_Visibilidad_Desc]
			, [Publicacion_Visibilidad_Precio]
			, [Publicacion_Visibilidad_Porcentaje]
			, 50
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Visibilidad_Cod];

	INSERT INTO [Rubros]
		SELECT DISTINCT '', [Publicacion_Rubro_Descripcion]
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Rubro_Descripcion] ASC
END
