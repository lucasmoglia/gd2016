USE [GD1C2016]
GO

/****** Object:  StoredProcedure [DE_UNA].[ResetPassword]    Script Date: 04/07/2016 3:12:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[ResetPassword] 
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal (20,0),
	@password nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	UPDATE [DE_UNA].Usuarios SET [password] = HASHBYTES('SHA2_256', @password) WHERE cod_usuario = @cod_usuario
	SELECT 1
END

GO


