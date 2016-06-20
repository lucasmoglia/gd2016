USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[SetRolInactivo]    Script Date: 19/06/2016 13:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [DE_UNA].[SetRolInactivo]
	-- Add the parameters for the stored procedure here
	@cod_rol decimal
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [DE_UNA].Roles SET activo=0 WHERE cod_rol = @cod_rol

	SELECT cod_rol FROM [DE_UNA].Roles WHERE cod_rol = @cod_rol
END
