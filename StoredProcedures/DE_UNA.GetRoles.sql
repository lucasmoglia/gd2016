USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetRoles]    Script Date: 6/6/2016 3:20:55 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [DE_UNA].[GetRoles]
	-- Add the parameters for the stored procedure here
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cod_rol, nombre
	FROM [DE_UNA].[Roles] 
	WHERE (@activeOnly = 1 AND activo = 1) OR @activeOnly = 0
END
