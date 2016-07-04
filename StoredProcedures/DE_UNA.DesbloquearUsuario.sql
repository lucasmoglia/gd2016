USE [GD1C2016]
GO

/****** Object:  StoredProcedure [DE_UNA].[DesbloquearUsuario]    Script Date: 04/07/2016 3:12:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[DesbloquearUsuario]
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Usuarios SET activo=1, login_fallidos=0 WHERE cod_usuario=@cod_usuario

	select 1
END

GO


