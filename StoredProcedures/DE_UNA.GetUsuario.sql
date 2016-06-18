USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para recuperar un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetUsuario
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	DECLARE @esCliente numeric(18,0) = (SELECT dni FROM [DE_UNA].Clientes WHERE cod_usuario = @cod_usuario)

	SELECT U.cod_usuario
		 , C.dni
		 , C.nombre
		 , C.apellido
		 , E.cuit
		 , E.razon_social
		 , E.dir_ciudad
		 , E.nombre_contacto
		 , R.desc_larga AS rubro
		 , U.mail
		 , U.username
		 , U.activo
		 , U.telefono
		 , U.dir_calle
		 , U.dir_nro
		 , U.dir_piso
		 , U.dir_depto
		 , U.dir_localidad
		 , U.dir_cod_post
		 , U.fecha_nacimiento
	FROM [DE_UNA].Usuarios U
	 LEFT JOIN [DE_UNA].Clientes C ON U.cod_usuario = C.cod_usuario
	 LEFT JOIN [DE_UNA].Empresas E ON U.cod_usuario = E.cod_usuario
	 LEFT JOIN [DE_UNA].Rubros   R ON E.cod_rubro   = R.cod_rubro
	 WHERE (@cod_usuario IS NOT NULL AND U.cod_usuario = @cod_usuario)
	    OR @cod_usuario IS NULL;
END
