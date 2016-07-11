USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SCHEMA [DE_UNA]
GO
CREATE PROCEDURE [DE_UNA].[DropTables] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF OBJECT_ID('DE_UNA.Items', 'U')				IS NOT NULL DROP TABLE DE_UNA.Items; 
	IF OBJECT_ID('DE_UNA.Facturas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Facturas;
	IF OBJECT_ID('DE_UNA.Ofertas', 'U')				IS NOT NULL DROP TABLE DE_UNA.Ofertas; 
	IF OBJECT_ID('DE_UNA.Compras', 'U')				IS NOT NULL DROP TABLE DE_UNA.Compras; 
	IF OBJECT_ID('DE_UNA.Publicaciones', 'U')		IS NOT NULL DROP TABLE DE_UNA.Publicaciones; 
	IF OBJECT_ID('DE_UNA.Tipos_Publicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.Tipos_Publicacion; 
	IF OBJECT_ID('DE_UNA.EstadosPublicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.EstadosPublicacion; 
	IF OBJECT_ID('DE_UNA.Visibilidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Visibilidades; 
	IF OBJECT_ID('DE_UNA.Empresas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Empresas; 
	IF OBJECT_ID('DE_UNA.Clientes', 'U')			IS NOT NULL DROP TABLE DE_UNA.Clientes; 
	IF OBJECT_ID('DE_UNA.Rubros', 'U')				IS NOT NULL DROP TABLE DE_UNA.Rubros; 
	IF OBJECT_ID('DE_UNA.Roles_Usuario', 'U')		IS NOT NULL DROP TABLE DE_UNA.Roles_Usuario; 
	IF OBJECT_ID('DE_UNA.Func_por_Rol', 'U')		IS NOT NULL DROP TABLE DE_UNA.Func_por_Rol; 
	IF OBJECT_ID('DE_UNA.Funcionalidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Funcionalidades; 
	IF OBJECT_ID('DE_UNA.Roles', 'U')				IS NOT NULL DROP TABLE DE_UNA.Roles; 
	IF OBJECT_ID('DE_UNA.Usuarios', 'U')			IS NOT NULL DROP TABLE DE_UNA.Usuarios;
END
--------------- insertar Crear Tablas
--------------- Insertar Poblar Tablas Sin Dependencias
--------------- Migrar Usuario Empresa
--------------- Migrar Usuario Cliente
--------------- [DE_UNA].MigrarPublicaciones AS
--------------- [DE_UNA].MigrarCompras AS
--------------- [DE_UNA].[Migrar_Ofertas] AS
--------------- [DE_UNA].[MigrarFacturas]

EXECUTE [DE_UNA].[DropTables];
GO
EXECUTE [DE_UNA].[CrearTablas];
GO
EXECUTE [DE_UNA].[PoblarTablasSinDependencias];
GO
EXECUTE [DE_UNA].[MigrarUsuarioEmpresa];
GO
EXECUTE [DE_UNA].[MigrarUsuarioCliente];
GO
EXECUTE [DE_UNA].[MigrarPublicaciones];
GO
EXECUTE [DE_UNA].[MigrarCompras];
GO
EXECUTE [DE_UNA].[Migrar_Ofertas];
GO
EXECUTE [DE_UNA].[MigrarFacturas];
GO
