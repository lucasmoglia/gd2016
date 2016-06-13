SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	
-- =============================================
CREATE PROCEDURE [DE_UNA].DropProcedures AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF OBJECT_ID('[DE_UNA].CrearTablas', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].CrearTablas;
	IF OBJECT_ID('[DE_UNA].DropTables', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].DropTables;
	IF OBJECT_ID('[DE_UNA].Migrar_Ofertas', 'U')			  IS NOT NULL DROP PROCEDURE [DE_UNA].Migrar_Ofertas;
	IF OBJECT_ID('[DE_UNA].MigrarCompras', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarCompras;
	IF OBJECT_ID('[DE_UNA].MigrarFacturas', 'U')			  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarFacturas;
	IF OBJECT_ID('[DE_UNA].MigrarPublicaciones', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarPublicaciones;
	IF OBJECT_ID('[DE_UNA].MigrarUsuarioCliente', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarUsuarioCliente;
	IF OBJECT_ID('[DE_UNA].MigrarUsuarioEmpresa', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarUsuarioEmpresa;
	IF OBJECT_ID('[DE_UNA].PoblarTablasSinDependencias', 'U') IS NOT NULL DROP PROCEDURE [DE_UNA].PoblarTablasSinDependencias;

END
GO
