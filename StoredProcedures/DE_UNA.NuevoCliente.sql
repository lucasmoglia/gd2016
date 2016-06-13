SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[NuevoCliente]
	-- Add the parameters for the stored procedure here
	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@dni numeric(18,0),
	@documento_tipo varchar(10),
	@mail nvarchar(255),
	@username nvarchar(50),
	@password nvarchar(100),
	@activo bit,
	@telefono varchar(100),
	@dir_calle nvarchar(255),
	@dir_nro numeric(18,0),
	@dir_piso numeric(18,0),
	@dir_depto nvarchar(50),
	@dir_localidad nvarchar(100),
	@dir_cod_post nvarchar(50),
	@fecha_nacimiento datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [DE_UNA].[Usuarios]
	VALUES(0,@username,HASHBYTES('SHA2_256', @password),1,@mail,@telefono,@dir_calle,@dir_nro,@dir_piso,@dir_depto,@dir_localidad,@dir_cod_post,@fecha_nacimiento,GETDATE(),1,0,0)

	INSERT INTO [DE_UNA].[Clientes]
	VALUES(IDENT_CURRENT('DE_UNA.Usuarios'),@nombre,@apellido,@dni,@documento_tipo)

	SELECT 1	
END
GO
