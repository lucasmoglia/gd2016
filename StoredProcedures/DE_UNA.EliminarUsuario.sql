USE [GD1C2016]
GO

/****** Object:  StoredProcedure [DE_UNA].[EliminarUsuario]    Script Date: 04/07/2016 3:12:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[EliminarUsuario] 
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal (12,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [DE_UNA].Usuarios SET fecha_baja = GETDATE() WHERE cod_usuario = @cod_usuario
	SELECT 1
END

GO


