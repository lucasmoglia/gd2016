USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetDatosCabeceraFactura]   Script Date: 09/07/2016 07:28:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Facundo Samassa
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetDatosCabeceraFactura]
	@cod_usuario decimal (20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF ((SELECT COUNT(*) FROM [DE_UNA].Clientes WHERE [cod_usuario] = @cod_usuario) > 0 )
		BEGIN
			SELECT  C.[nombre] + ' ' + C.[apellido]
				   ,C.[dni]
				   ,U.[dir_calle] + ' ' + convert(varchar(10),U.[dir_nro]) + '. Piso: ' + isnull(convert(varchar(10),U.[dir_piso]),' -') + '. Dpto: ' + isnull(U.[dir_depto],' -') + ' ' + isnull(U.[dir_localidad],'') 
			FROM [DE_UNA].Clientes C JOIN [DE_UNA].[Usuarios] U ON C.[cod_usuario] = U.[cod_usuario]
			WHERE C.[cod_usuario] = @cod_usuario
		END
	ELSE
		BEGIN
			SELECT  E.[razon_social]
				   ,E.[cuit]
				   ,isnull([dir_ciudad],' - ')
			FROM [DE_UNA].[Empresas] E JOIN [DE_UNA].[Usuarios] U ON E.[cod_usuario] = U.[cod_usuario]
			WHERE E.[cod_usuario] = @cod_usuario
		END
END