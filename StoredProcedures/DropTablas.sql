USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[DropTables]    Script Date: 25/5/2016 7:07:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DropTables]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF OBJECT_ID('dbo.Administradores', 'U') IS NOT NULL DROP TABLE dbo.Administradores; 
   IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL DROP TABLE dbo.Clientes; 
   IF OBJECT_ID('dbo.Empresas', 'U') IS NOT NULL DROP TABLE dbo.Empresas; 
   IF OBJECT_ID('dbo.EstadosPublicacion', 'U') IS NOT NULL DROP TABLE dbo.EstadosPublicacion; 
   IF OBJECT_ID('dbo.Facturas', 'U') IS NOT NULL DROP TABLE dbo.Facturas; 
   IF OBJECT_ID('dbo.Funcionalidades', 'U') IS NOT NULL DROP TABLE dbo.Funcionalidades; 
   IF OBJECT_ID('dbo.Historica', 'U') IS NOT NULL DROP TABLE dbo.Historica; 
   IF OBJECT_ID('dbo.Items', 'U') IS NOT NULL DROP TABLE dbo.Items; 
   IF OBJECT_ID('dbo.Items_por_factura', 'U') IS NOT NULL DROP TABLE dbo.Items_por_factura; 
   IF OBJECT_ID('dbo.Perfiles', 'U') IS NOT NULL DROP TABLE dbo.Perfiles; 
   IF OBJECT_ID('dbo.Publicaciones', 'U') IS NOT NULL DROP TABLE dbo.Publicaciones; 
   IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE dbo.Roles; 
   IF OBJECT_ID('dbo.Roles_Usuario', 'U') IS NOT NULL DROP TABLE dbo.Roles_Usuario; 
   IF OBJECT_ID('dbo.Rubros', 'U') IS NOT NULL DROP TABLE dbo.Rubros; 
   IF OBJECT_ID('dbo.Usuarios', 'U') IS NOT NULL DROP TABLE dbo.Usuarios; 
   IF OBJECT_ID('dbo.Visibilidades', 'U') IS NOT NULL DROP TABLE dbo.Visibilidades; 

END
