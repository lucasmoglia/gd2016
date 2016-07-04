USE [GD1C2016]
GO

/****** Object:  Trigger [DE_UNA].[ValidarRepetidoE]    Script Date: 04/07/2016 3:09:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [DE_UNA].[ValidarRepetidoE] ON [DE_UNA].[Empresas]
FOR INSERT, UPDATE
AS
	DECLARE @razon_social nvarchar(255)
	DECLARE @cuit nvarchar(50)
	DECLARE @cod_usuario int

	SELECT TOP 1 @razon_social = razon_social FROM inserted
	SELECT TOP 1 @cuit = cuit FROM inserted
	SELECT @cod_usuario = cod_usuario FROM Empresas WHERE razon_social = @razon_social AND cuit = @cuit

	IF @cod_usuario IS NOT NULL
	BEGIN 
		rollback transaction;
		DELETE Usuarios WHERE cod_usuario = @cod_usuario
		raiserror('Ya existe una empresa registrada con la combinación de cuit y razón social ingresada', 18,0)
	END
GO


