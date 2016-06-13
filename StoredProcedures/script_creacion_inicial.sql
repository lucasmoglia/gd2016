USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo DE_UNA.
-- Create date: 11/05/2016
-- Description:	Script de Migración.
-- =============================================
CREATE PROCEDURE script_creacion_inicial AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	DECLARE @crearSchema nvarchar(200) = 'CREATE SCHEMA [DE_UNA]';

	EXECUTE [DE_UNA].[DropTables];
--	EXECUTE [DE_UNA].[DropProcedures];

--	DROP SCHEMA [DE_UNA];

--	EXEC(@crearSchema);

	EXECUTE [DE_UNA].[CrearTablas];
	EXECUTE [DE_UNA].[PoblarTablasSinDependencias];
	EXECUTE [DE_UNA].[MigrarUsuarioEmpresa];
	EXECUTE [DE_UNA].[MigrarUsuarioCliente];
	EXECUTE [DE_UNA].[MigrarPublicaciones];
	EXECUTE [DE_UNA].[MigrarCompras];
	EXECUTE [DE_UNA].[Migrar_Ofertas];
	EXECUTE [DE_UNA].[MigrarFacturas];

END
GO
