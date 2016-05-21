USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nicolas Chiaradia
-- Create date: 21-05-2016
-- Description:	Eliminación de Tablas
-- =============================================
CREATE PROCEDURE DE_UNA.DropTablas 
AS
BEGIN
	DROP TABLE [Facturas], [Empresas], [Historica], [EstadosPublicacion], [Items], [Visibilidades], [Usuarios],
               [Administradores], [Perfiles], [Clientes], [Rubros], [Publicaciones], [Funcionalidades],
               [Items_por_facturas], [Roles_Usuario], [Roles];
END
GO
