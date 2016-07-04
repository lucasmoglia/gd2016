USE [GD1C2016]
GO

/****** Object:  Trigger [DE_UNA].[ValidarRepetido]    Script Date: 04/07/2016 3:09:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [DE_UNA].[ValidarRepetido] ON [DE_UNA].[Clientes]
FOR INSERT,UPDATE
AS
	DECLARE @documento_tipo varchar(10)
	DECLARE @dni numeric(18,0)
	DECLARE @cod_usuario int

	SELECT TOP 1 @documento_tipo = documento_tipo FROM inserted
	SELECT TOP 1 @dni = dni FROM inserted
	SELECT @cod_usuario = cod_usuario FROM Clientes WHERE documento_tipo = @documento_tipo AND dni = @dni

	IF @cod_usuario IS NOT NULL
	BEGIN 
		rollback transaction;
		DELETE Usuarios WHERE cod_usuario = @cod_usuario
		raiserror('Ya existe un cliente registrado con la combinación de dni y tipo ingresada', 18,0)
	END

GO


