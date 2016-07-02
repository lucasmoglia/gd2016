USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[ActualizarRol]    Script Date: 19/06/2016 13:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================
-- Author:		Lucas Moglia
-- Create date: 19/06/2016
-- Description: Actualizar Rol y sus funcionalidades
-- ==================================================
CREATE PROCEDURE [DE_UNA].[ActualizarRol] 
	-- Add the parameters for the stored procedure here
	@cod_rol decimal, 
	@funcionalidades [DE_UNA].FuncionalidadesList READONLY
AS
BEGIN
	declare @cod_funcionalidad decimal

	BEGIN TRANSACTION;
	BEGIN TRY
		-- Generate a constraint violation error.
		DELETE FROM DE_UNA.Func_por_Rol
		WHERE cod_rol = @cod_rol;
	
		-- Cursor para funcionalidades por parametro
		DECLARE IDS_FUNCIONALIDADES CURSOR 
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT cod_funcionalidad 
		FROM @funcionalidades

		OPEN IDS_FUNCIONALIDADES
		FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			--Do something with Id here
			INSERT INTO DE_UNA.Func_por_Rol VALUES (@cod_funcionalidad, @cod_rol)
			FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		END
		CLOSE IDS_FUNCIONALIDADES
		DEALLOCATE IDS_FUNCIONALIDADES
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY() AS ErrorSeverity
			,ERROR_STATE() AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage;

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;

END
