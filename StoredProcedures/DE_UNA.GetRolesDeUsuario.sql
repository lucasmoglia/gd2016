USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 02/07/2016
-- Description:	SP para obtener los roles de un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetRolesDeUsuario
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT RU.cod_rol
		 , R.nombre
	FROM [DE_UNA].Roles_Usuario RU
	 JOIN [DE_UNA].Roles R ON R.cod_rol = RU.cod_rol
	WHERE RU.cod_usuario = @cod_usuario
	  AND R.activo = 1
END
