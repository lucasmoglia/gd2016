USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[NuevoRol]    Script Date: 19/06/2016 13:34:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[NuevoRol]
	-- Add the parameters for the stored procedure here
	@nombre nvarchar(50),
	@funcionalidades FuncionalidadesList READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @cod_funcionalidad decimal

    -- Insert statements for procedure here
	BEGIN TRANSACTION;
	BEGIN TRY
		-- Cursor para funcionalidades por parametro
		DECLARE IDS_FUNCIONALIDADES CURSOR 
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT cod_funcionalidad 
		FROM @funcionalidades

		-- Generate a constraint violation error.
		INSERT INTO [DE_UNA].Roles VALUES(@nombre, 1)

		OPEN IDS_FUNCIONALIDADES
		FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			
			--Do something with Id here
			INSERT INTO DE_UNA.Func_por_Rol VALUES (@cod_funcionalidad, IDENT_CURRENT('DE_UNA.Roles'))

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
