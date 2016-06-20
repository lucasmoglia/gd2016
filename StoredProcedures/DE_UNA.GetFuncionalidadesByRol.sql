USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetFuncionalidadesByRol]    Script Date: 19/06/2016 13:34:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [DE_UNA].[GetFuncionalidadesByRol] 
	-- Add the parameters for the stored procedure here
	@cod_rol decimal
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT F.cod_funcionalidad, F.descripcion
	FROM [DE_UNA].Func_por_Rol FR
	JOIN [DE_UNA].Funcionalidades F
		ON FR.cod_funcionalidad = F.cod_funcionalidad
	WHERE FR.cod_rol = @cod_rol

END
