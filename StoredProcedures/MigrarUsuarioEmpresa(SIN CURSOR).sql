USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[MigrarUsuarioEmpresa]    Script Date: 25/5/2016 7:08:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lucas Moglia
-- Modificado por: Germán Rodriguez
-- Create date: 21/05/2016
-- Description:	migra datos desde la tabla maestra
-- creando usuarios y Empresas!
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarUsuarioEmpresa]
AS
BEGIN

	PRINT '-------- Migrando Empresas...  --------';

	IF OBJECT_ID('[DE_UNA].#Usuario_empresas', 'U')	IS NOT NULL DROP TABLE [DE_UNA].#Usuario_empresas; 

	SELECT DISTINCT * INTO [DE_UNA].#Usuario_empresas
	FROM (
		  SELECT DISTINCT
				  Publ_Empresa_Cuit
				, Publ_Empresa_Razon_Social
				, Publ_Empresa_Fecha_Creacion
				, Publ_Empresa_Mail
				, Publ_Empresa_Dom_Calle
				, Publ_Empresa_Nro_Calle
				, Publ_Empresa_Piso
				, Publ_Empresa_Depto
				, Publ_Empresa_Cod_Postal
			FROM [gd_esquema].Maestra
		   WHERE Publ_Empresa_Cuit IS NOT NULL) AS datosDeEmpresas

	INSERT INTO [DE_UNA].Usuarios (username, fecha_nacimiento, mail, dir_calle, dir_nro, dir_piso, dir_depto, dir_cod_post, fecha_alta)
		 SELECT   Publ_Empresa_Cuit
				, Publ_Empresa_Fecha_Creacion
				, Publ_Empresa_Mail
				, Publ_Empresa_Dom_Calle
				, Publ_Empresa_Nro_Calle
				, Publ_Empresa_Piso
				, Publ_Empresa_Depto
				, Publ_Empresa_Cod_Postal
				, GETDATE() AS fecha_alta
			FROM [DE_UNA].#Usuario_empresas


	PRINT '----  Usuarios Empresas migrados!  ----';

	INSERT INTO [DE_UNA].Empresas (cod_usuario, cuit, razon_social)
	SELECT U.cod_usuario
		 , E.Publ_Empresa_Cuit
		 , E.Publ_Empresa_Razon_Social
	  FROM [DE_UNA].#Usuario_empresas E
	  JOIN [DE_UNA].Usuarios          U ON E.Publ_Empresa_Cuit = U.username

	PRINT '---------  Empresas migradas!  --------';

	-- SI TOMAMOS COMO USERNAME EL CUIT, => HAY Q DEJAR ESTO COMENTADO. 
	-- SI DEFINIMOS QUE LOS MIGRADOS NO VAN A TENER USERNAME, HAY Q DESCOMENTAR ESTO.
	--UPDATE [DE_UNA].Usuarios
	--   SET username = NULL
	--  FROM [DE_UNA].Usuarios U JOIN [DE_UNA].Empresas E	ON U.cod_usuario = E.cod_usuario
	-- WHERE U.cod_usuario IS NOT NULL

	INSERT INTO [DE_UNA].[Roles_Usuario]	
	     SELECT E.[cod_usuario], R.[cod_rol]
		   FROM [DE_UNA].[Empresas] E
		   JOIN [DE_UNA].[Roles] R ON R.nombre = 'Empresa'
END
