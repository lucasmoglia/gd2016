USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetClientes]    Script Date: 6/6/2016 3:21:10 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetClientes]
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT U.cod_usuario
		, C.nombre
		, C.apellido
		, C.dni
		, U.username
		, U.mail
		, U.activo
		, U.telefono
		, U.dir_calle
		, U.dir_nro
		, U.dir_piso
		, U.dir_depto
		, U.dir_localidad
		, U.dir_cod_post
		, U.fecha_nacimiento
		, U.fecha_alta
		, U.publ_sin_cargo
		, U.cant_ventas
	FROM [DE_UNA].Usuarios U
		JOIN [DE_UNA].Clientes C
			ON U.cod_usuario = C.cod_usuario
	WHERE (@activeOnly = 1 AND U.activo = 1) OR @activeOnly = 0
END
