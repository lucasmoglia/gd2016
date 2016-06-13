-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [DE_UNA].[GetGridUsuarios]
	-- Add the parameters for the stored procedure here
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  
	U.cod_usuario
	, C.nombre
	, C.apellido
	, C.dni
	, E.razon_social
	, E.dir_ciudad
	, E.nombre_contacto
	, R.desc_larga as rubro
	, E.cuit
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
	LEFT JOIN [DE_UNA].Clientes C
		ON U.cod_usuario = C.cod_usuario
	LEFT JOIN [DE_UNA].Empresas E
		ON U.cod_usuario = E.cod_usuario
		LEFT JOIN [DE_UNA].Rubros R
			ON E.cod_rubro = R.cod_rubro
END
GO
