USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[MigrarUsuarioEmpresa]    Script Date: 25/5/2016 7:08:28 p. m. ******/
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
CREATE PROCEDURE [dbo].[MigrarUsuarioEmpresa]
AS
BEGIN
	DECLARE   @cod_usuario decimal(20,0)
			, @cuit nvarchar(50)
			, @cod_postal nvarchar(50)
			, @razonsocial nvarchar(255)
			, @depto nvarchar(50)
			, @dom_calle nvarchar(100)
			, @fecha_creacion datetime
			, @mail nvarchar(50)
			, @piso numeric(18,0)
			, @nro_calle numeric(18,0);

	PRINT '-------- "Empresas" Migration --------';
	DECLARE empresas_cursor CURSOR FOR 
	
	SELECT	 M.Publ_Empresa_Cuit 
			,M.Publ_Empresa_Cod_Postal
			,M.Publ_Empresa_Razon_Social
			,M.Publ_Empresa_Depto
			,M.Publ_Empresa_Dom_Calle
			,M.Publ_Empresa_Fecha_Creacion
			,M.Publ_Empresa_Mail
			,M.Publ_Empresa_Piso
			,M.Publ_Empresa_Nro_Calle
		FROM gd_esquema.Maestra as M
		WHERE M.Publ_Empresa_Cuit is not null
		GROUP BY M.Publ_Empresa_Cuit
				,M.Publ_Empresa_Razon_Social
				,M.Publ_Empresa_Cod_Postal
				,M.Publ_Empresa_Depto
				,M.Publ_Empresa_Dom_Calle
				,M.Publ_Empresa_Fecha_Creacion
				,M.Publ_Empresa_Mail
				,M.Publ_Empresa_Piso
				,M.Publ_Empresa_Nro_Calle
		ORDER BY M.Publ_Empresa_Cuit

		OPEN empresas_cursor

	FETCH NEXT FROM empresas_cursor 
	INTO	  @cuit 
			, @cod_postal 
			, @razonsocial 
			, @depto 
			, @dom_calle
			, @fecha_creacion 
			, @mail 
			, @piso 
			, @nro_calle

	PRINT 'Comenzando importación de empresas...'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO Usuarios (nombre, fecha_nacimiento, mail, dir_calle,dir_nro, dir_piso, dir_depto, dir_cod_post, fecha_alta)
		VALUES(	  @cuit
				, @fecha_creacion
				, @mail
				, @dom_calle
				, @nro_calle
				, @piso
				, @depto
				, @cod_postal
				, GETDATE())

		INSERT INTO Empresas (cod_usuario, cuit, razon_social, dir_ciudad)
		VALUES(IDENT_CURRENT('Usuarios')
			, @cuit
			, @razonsocial
			, @dom_calle)

		FETCH NEXT FROM empresas_cursor 
		INTO	  @cuit 
				, @cod_postal 
				, @razonsocial 
				, @depto 
				, @dom_calle
				, @fecha_creacion 
				, @mail 
				, @piso 
				, @nro_calle
	END 
	CLOSE empresas_cursor;
	DEALLOCATE empresas_cursor;

	INSERT INTO [Roles_Usuario]
	    SELECT [cod_usuario], 1
		FROM [Empresas]
END
