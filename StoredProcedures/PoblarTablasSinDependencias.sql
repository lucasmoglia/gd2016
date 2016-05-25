-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[PoblarTablasSinDependencias]
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
		--SELECT CASE WHEN MAX([cod_rubro]) IS NULL THEN 1
		--			ELSE MAX([cod_rubro]) + 1
		--		END
		--  FROM [Rubros]
		SELECT ROW_NUMBER(DISTINCT [Publicacion_Rubro_Descripcion])
		  FROM [gd_esquema].[Maestra]
	  , SELECT DISTINCT SUBSTRING([Publicacion_Rubro_Descripcion],0,50) 
	      FROM [gd_esquema].[Maestra]
	  , SELECT DISTINCT [Publicacion_Rubro_Descripcion]
	      FROM [gd_esquema].[Maestra]

SELECT * FROM [Rubros]

END
GO
