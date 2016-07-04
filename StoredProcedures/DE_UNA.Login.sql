USE [GD1C2016]
GO

/****** Object:  StoredProcedure [DE_UNA].[Login]    Script Date: 04/07/2016 3:11:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[Login]
	-- Add the parameters for the stored procedure here
	@username nvarchar(50), 
	@password nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF((SELECT COUNT(U.cod_usuario) as result
		FROM [DE_UNA].[Usuarios] U
		WHERE U.username = @username 
			AND U.fecha_baja IS NULL
			AND U.activo = 1)= 0)
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = login_fallidos + 1, activo=IIF(login_fallidos+1>=3, 0, 1)
		WHERE username = @username
		SELECT 0
	END
	ELSE
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = 0, activo=1
		WHERE username = @username
		SELECT 1
	END
END

GO


