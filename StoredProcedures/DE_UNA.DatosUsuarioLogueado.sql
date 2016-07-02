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
CREATE PROCEDURE [DE_UNA].DatosUsuarioLogueado
	-- Add the parameters for the stored procedure here
	@username nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_usuario
		 , activo
		 , CASE 
			WHEN (SELECT 1 FROM [DE_UNA].Empresas E WHERE E.cod_usuario = U.cod_usuario) IS NOT NULL THEN
				1
		   ELSE
		        0
		   END AS esEmpresa
		 , ISNULL(publ_sin_cargo,0) AS publ_sin_cargo
	FROM [DE_UNA].Usuarios U
	 --JOIN [DE_UNA].Roles R ON R.cod_rol = RU.cod_rol
	WHERE username = @username
END
