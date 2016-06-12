USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[PoblarTablasSinDependencias]    Script Date: 25/5/2016 7:08:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		German Rodriguez
-- Create date: 04/06/2016
-- Description:	SP par poblar tablas que no tienen dependencias.
-- =============================================
CREATE PROCEDURE [DE_UNA].[PoblarTablasSinDependencias]
AS
BEGIN

-- VISIBILIDADES
	INSERT INTO [DE_UNA].[Visibilidades]
		SELECT DISTINCT
			  [Publicacion_Visibilidad_Cod]
			, [Publicacion_Visibilidad_Desc]
			, [Publicacion_Visibilidad_Precio]
			, [Publicacion_Visibilidad_Porcentaje]
			, 50.00
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Visibilidad_Cod];

-- ESTADOS DE PUBLICACION
	INSERT INTO [DE_UNA].[EstadosPublicacion]
	     SELECT DISTINCT [Publicacion_Estado]
		   FROM [gd_esquema].[Maestra]

	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Borrador');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Activa');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Pausada');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Finalizada');

-- TIPOS DE PUBLICACION
	INSERT INTO [DE_UNA].[Tipos_Publicacion]
		SELECT DISTINCT [Publicacion_Tipo]
		FROM [gd_esquema].[Maestra]

-- RUBROS
	INSERT INTO [DE_UNA].[Rubros]
		SELECT DISTINCT SUBSTRING([Publicacion_Rubro_Descripcion], 0, 50), 
		                          [Publicacion_Rubro_Descripcion]
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Rubro_Descripcion] ASC;

-- ROLES
	INSERT INTO [DE_UNA].[Roles] VALUES (1, 'Empresa', 1);
	INSERT INTO [DE_UNA].[Roles] VALUES (2, 'Cliente', 1);

-- FUNCIONALIDADES DE USUARIOS COMUNES
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (0,'Comprar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (1,'Ofertar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (2,'Vender');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (3,'Publicar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (4,'Estafar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (5,'Calificar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (6,'Preguntar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (7,'Crear Publicación');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (8,'Modificar Publicación');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (9,'Modificar Usuario'); -- Modificar a su propio Usuario (cambiar mail, telefono, etc.)
-- Funcionalidades comunes a Todos los usuarios
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (10,'Ver Historial de Cliente');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (11,'Consultar facturas realizadas al vendedor');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (12,'Ver Estadísticas');
-- Funcionalidades exclusivas de Administradores
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (20,'ABM de Usuario');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (21,'ABM de Rol');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (22,'ABM de Rubro');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (23,'ABM de Visibilidad');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (24,'Borrar Publicación');

-- Funciones para el Rol Empresa
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (2,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (3,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (5,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (7,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (8,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (9,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (10,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (11,1);
-- Funciones para el Rol Cliente
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (0,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (1,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (2,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (3,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (4,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (5,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (6,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (7,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (8,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (9,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (10,2);

	RETURN 1;
END