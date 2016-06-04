USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[MigrarUsuarioCliente]    Script Date: 25/5/2016 7:08:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nicolas Chiaradia
-- Create date: 04/06/2016
-- Description:	migra datos desde la tabla maestra
-- creando usuarios y clientes!
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarUsuarioCliente]
AS
BEGIN
	PRINT 'Migrando Usuarios-Cliente';

	-- 1) Seleccionar clientes de publicaciones y clientes compradores a una tabla temporal comun para todos los clientes
	-- 2) Recorrer la tabla temporal y armar las tablas Usuarios y Clientes

	-- (1)
	IF OBJECT_ID('DE_UNA.#Usuario_cliente', 'U')	IS NOT NULL DROP TABLE DE_UNA.#Usuario_cliente; 

	SELECT DISTINCT * INTO DE_UNA.#Usuario_Cliente
	FROM	(
		SELECT DISTINCT   
			 M.Publ_Cli_Nombre		as nombre
			,M.Publ_Cli_Apeliido	as apellido
			,M.Publ_Cli_Dni			as dni
			,M.Publ_Cli_Fecha_Nac	as fecha_nacimiento
			,M.Publ_Cli_Mail		as mail
			,M.Publ_Cli_Dom_Calle	as dir_calle
			,M.Publ_Cli_Nro_Calle	as dir_nro
			,M.Publ_Cli_Piso		as dir_piso
			,M.Publ_Cli_Depto		as dir_depto
			,M.Publ_Cli_Cod_Postal	as dir_cod_post
		FROM gd_esquema.Maestra as M
		WHERE M.Publ_Cli_Dni is not null
		UNION ALL
		SELECT DISTINCT   
			 M.Cli_Nombre		as nombre
			,M.Cli_Apeliido		as apellido
			,M.Cli_Dni			as dni
			,M.Cli_Fecha_Nac	as fecha_nacimiento
			,M.Cli_Mail			as mail
			,M.Cli_Dom_Calle	as dir_calle
			,M.Cli_Nro_Calle	as dir_nro
			,M.Cli_Piso			as dir_piso
			,M.Cli_Depto		as dir_depto
			,M.Cli_Cod_Postal	as dir_cod_post
		FROM gd_esquema.Maestra as M
		WHERE M.Cli_Dni is not null
	) AS pepe

	--select * from DE_UNA.#Usuario_Cliente


	/*
	-- (2)
	SELECT DISTINCT   
			 T.fecha_nacimiento
			,T.mail
			,T.dir_calle
			,T.dir_nro
			,T.dir_piso
			,T.dir_depto
			,T.dir_cod_post
	INTO DE_UNA.Usuarios
	FROM DE_UNA.#Usuario_Cliente as T
	WHERE T.dni is not null

	SELECT DISTINCT 
			 U.cod_usuario  
			,T.nombre
			,T.apellido
			,T.dni
  			,'DNI'					as documento_tipo	varchar(10)

	INTO DE_UNA.Clientes
	FROM DE_UNA.#Usuario_Cliente T, DE_UNA.Usuarios U
	WHERE T.dni is not null
	*/





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
	SELECT   * FROM DE_UNA.#Usuario_Cliente T

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
		INSERT INTO DE_UNA.Usuarios (fecha_nacimiento, mail, dir_calle,dir_nro, dir_piso, dir_depto, dir_cod_post, fecha_alta)
		VALUES(
				  @fecha_nac
				, @mail
				, @dom_calle
				, @nro_calle
				, @piso
				, @depto
				, @cod_postal
				, GETDATE())

		INSERT INTO DE_UNA.Clientes
		VALUES(IDENT_CURRENT('Usuarios')
			, @nombre
			, @apellido
			, @dni
			, @documento_tipo)

		FETCH NEXT FROM clientes_cursor 
		INTO  @nombre
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