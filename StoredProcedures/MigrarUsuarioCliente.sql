USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[MigrarUsuarioCliente]    Script Date: 25/5/2016 7:08:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lucas Moglia
-- Create date: 21/05/2016
-- Description:	migra datos desde la tabla maestra
-- creando usuarios y clientes!
-- =============================================
CREATE PROCEDURE [dbo].[MigrarUsuarioCliente]
AS
BEGIN
	DECLARE   @cod_usuario decimal(20,0)
			, @nombre nvarchar(255)
			, @apellido nvarchar(255)
			, @dni numeric(18,0)
			, @documento_tipo varchar(10)
			, @fecha_nac datetime
			, @mail nvarchar(255)
			, @dom_calle nvarchar(255)
			, @nro_calle numeric(18,0)
			, @piso numeric(18,0)
			, @depto nvarchar(50)
			, @cod_postal nvarchar(50);

	PRINT '-------- "Clientes" Migration --------';
	SET @documento_tipo = 'DNI';

	DECLARE clientes_cursor CURSOR FOR 
	SELECT   M.Cli_Nombre
			,M.Cli_Apeliido
			,M.Cli_Dni
			,M.Cli_Fecha_Nac
			,M.Cli_Mail
			,M.Cli_Dom_Calle
			,M.Cli_Nro_Calle
			,M.Cli_Piso
			,M.Cli_Depto
			,M.Cli_Cod_Postal
	FROM gd_esquema.Maestra as M
	WHERE M.Cli_Dni is not null
	GROUP BY M.Cli_Nombre
			,M.Cli_Apeliido
			,M.Cli_Dni
			,M.Cli_Fecha_Nac
			,M.Cli_Mail
			,M.Cli_Dom_Calle
			,M.Cli_Nro_Calle
			,M.Cli_Piso
			,M.Cli_Depto
			,M.Cli_Cod_Postal
	ORDER BY M.Cli_Dni

	OPEN clientes_cursor

	FETCH NEXT FROM clientes_cursor 
	INTO	  @nombre
			, @apellido
			, @dni
			, @fecha_nac
			, @mail
			, @dom_calle
			, @nro_calle
			, @piso
			, @depto
			, @cod_postal

	PRINT 'Comenzando importación de clientes...'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO Usuarios (nombre, fecha_nacimiento, mail, dir_calle,dir_nro, dir_piso, dir_depto, dir_cod_post, fecha_alta)
		VALUES(@nombre +   + @apellido
				, @fecha_nac
				, @mail
				, @dom_calle
				, @nro_calle
				, @piso
				, @depto
				, @cod_postal
				, GETDATE())

		INSERT INTO Clientes
		VALUES(IDENT_CURRENT('Usuarios')
			, @nombre
			, @apellido
			, @dni
			, @documento_tipo)

		FETCH NEXT FROM clientes_cursor 
		INTO @nombre
			, @apellido
			, @dni
			, @fecha_nac
			, @mail
			, @dom_calle
			, @nro_calle
			, @piso
			, @depto
			, @cod_postal
	END 
	CLOSE clientes_cursor;
	DEALLOCATE clientes_cursor;
END
