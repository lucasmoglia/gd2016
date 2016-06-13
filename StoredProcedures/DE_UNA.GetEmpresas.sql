USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetClientes]    Script Date: 6/6/2016 8:36:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetEmpresas]
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT U.cod_usuario
		, E.razon_social
		, E.dir_ciudad
		, E.nombre_contacto
		, R.desc_larga
		, E.cuit
		, U.mail
		, U.username
		, case when U.activo = 1 then 'Si' else 'No' end as activo
		, U.telefono
		, U.dir_calle
		, U.dir_nro
		, U.dir_piso
		, U.dir_depto
		, U.dir_localidad
		, U.dir_cod_post
		, U.fecha_alta
	FROM [DE_UNA].Usuarios U
		JOIN [DE_UNA].Empresas E
			ON U.cod_usuario = E.cod_usuario
		LEFT JOIN [DE_UNA].[Rubros] R
			ON E.cod_rubro = R.cod_rubro
	WHERE (@activeOnly = 1 AND U.activo = 1) OR @activeOnly = 0
END
