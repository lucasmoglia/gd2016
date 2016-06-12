USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[MigrarUsuarioCliente]    Script Date: 25/5/2016 7:08:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 04/06/2016
-- Modificador por: Germán Rodriguez
-- Description:	migra datos desde la tabla maestra
-- creando usuarios y clientes!
-- =============================================
ALTER PROCEDURE [DE_UNA].[MigrarUsuarioCliente]
AS
BEGIN
	-- 1) Seleccionar clientes de publicaciones y clientes compradores a una tabla temporal comun para todos los clientes.
	-- 2) Insertar desde select a las tablas temporales, en las tablas Usuarios y Clientes.

	IF OBJECT_ID('DE_UNA.#Usuarios_cliente', 'U')	IS NOT NULL DROP TABLE DE_UNA.#Usuarios_cliente; 

	PRINT '-------- Migrando Clientes...  --------';

	SELECT DISTINCT * INTO DE_UNA.#Usuarios_Cliente
	FROM (SELECT DISTINCT
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
		    FROM gd_esquema.Maestra M
		   WHERE M.Publ_Cli_Dni IS NOT NULL
		 UNION ALL
		  SELECT DISTINCT
			 M.Cli_Nombre		    as nombre
			,M.Cli_Apeliido		    as apellido
			,M.Cli_Dni			    as dni
			,M.Cli_Fecha_Nac	    as fecha_nacimiento
			,M.Cli_Mail			    as mail
			,M.Cli_Dom_Calle	    as dir_calle
			,M.Cli_Nro_Calle	    as dir_nro
			,M.Cli_Piso			    as dir_piso
			,M.Cli_Depto		    as dir_depto
			,M.Cli_Cod_Postal	    as dir_cod_post
		    FROM gd_esquema.Maestra M
		   WHERE M.Cli_Dni IS NOT NULL
		 ) AS TodosLosClientes

	INSERT INTO [DE_UNA].Usuarios (username, fecha_nacimiento, mail, dir_calle, dir_nro, dir_piso, dir_depto, dir_cod_post, fecha_alta)
		 SELECT   dni
				, fecha_nacimiento
				, mail
				, dir_calle
				, dir_nro
				, dir_piso
				, dir_depto
				, dir_cod_post
				, GETDATE() AS fecha_alta
			FROM [DE_UNA].#Usuarios_Cliente

	PRINT '----  Usuarios Cliente migrados!  ----';

	INSERT INTO [DE_UNA].Clientes(cod_usuario, nombre, apellido, dni)
		SELECT U.cod_usuario
			 , C.nombre
			 , C.apellido
			 , C.dni
		  FROM [DE_UNA].#Usuarios_Cliente C
		   JOIN [DE_UNA].Usuarios        U ON CAST(C.dni AS nvarchar(50)) = U.username;

	PRINT '---------  Clientes migrados!  --------';

	-- SI TOMAMOS COMO USERNAME EL CUIT, => HAY Q DEJAR ESTO COMENTADO. 
	-- SI DEFINIMOS QUE LOS MIGRADOS NO VAN A TENER USERNAME, HAY Q DESCOMENTAR ESTO.
	--UPDATE [DE_UNA].Usuarios
	--   SET username = NULL
	--  FROM [DE_UNA].Usuarios U JOIN [DE_UNA].Empresas E	ON U.cod_usuario = E.cod_usuario
	-- WHERE U.cod_usuario IS NOT NULL

END

