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

-- Estados Posibles de una Publicacion
	INSERT @Estados VALUES (0, 'Borrador');
	INSERT @Estados VALUES (1, 'Activa');
	INSERT @Estados VALUES (2, 'Pausada');
	INSERT @Estados VALUES (3, 'Finalizada');

-- Estados de Publicacion
	INSERT INTO [EstadosPublicacion]
	     SELECT * FROM @Estados;

-- Visibilidades
	INSERT INTO [Visibilidades]
		SELECT DISTINCT
			  [Publicacion_Visibilidad_Cod]
			, [Publicacion_Visibilidad_Desc]
			, [Publicacion_Visibilidad_Precio]
			, [Publicacion_Visibilidad_Porcentaje]
			, 50.00
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Visibilidad_Cod];

-- Rubros
	INSERT INTO [Rubros]
		SELECT DISTINCT SUBSTRING([Publicacion_Rubro_Descripcion], 0, 50), 
		                          [Publicacion_Rubro_Descripcion]
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Rubro_Descripcion] ASC;

-- Roles
	INSERT INTO [Roles] VALUES (1, 'Empresa', 1);
	INSERT INTO [Roles] VALUES (2, 'Administrativo', 1);
	INSERT INTO [Roles] VALUES (3, 'Cliente', 1);

-- Funcionalidades de Usuarios comunes
	INSERT INTO [Funcionalidades] VALUES (0,'Comprar');
	INSERT INTO [Funcionalidades] VALUES (1,'Ofertar');
	INSERT INTO [Funcionalidades] VALUES (2,'Vender');
	INSERT INTO [Funcionalidades] VALUES (3,'Publicar');
	INSERT INTO [Funcionalidades] VALUES (4,'Estafar');
	INSERT INTO [Funcionalidades] VALUES (5,'Calificar');
	INSERT INTO [Funcionalidades] VALUES (6,'Preguntar');
	INSERT INTO [Funcionalidades] VALUES (7,'Crear Publicación');
	INSERT INTO [Funcionalidades] VALUES (8,'Modificar Publicación');
	INSERT INTO [Funcionalidades] VALUES (9,'Modificar Usuario');
-- Funcionalidades comunes a Todos los usuarios
	INSERT INTO [Funcionalidades] VALUES (10,'Ver Historial de Cliente');
	INSERT INTO [Funcionalidades] VALUES (11,'Consultar facturas realizadas al vendedor');
	INSERT INTO [Funcionalidades] VALUES (12,'Ver Estadísticas');
-- Funcionalidades exclusivas de Administradores
	INSERT INTO [Funcionalidades] VALUES (20,'ABM de Usuario');
	INSERT INTO [Funcionalidades] VALUES (21,'ABM de Rol');
	INSERT INTO [Funcionalidades] VALUES (22,'ABM de Rubro');
	INSERT INTO [Funcionalidades] VALUES (23,'ABM de Visibilidad');
	INSERT INTO [Funcionalidades] VALUES (24,'Borrar Publicación');

	RETURN 1;
END