USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ::::::::::::    Creación del SCHEMA DE_UNA Correspondiente al Grupo 27 sobre el que se guardan los objetos de este TP :::::::::: */
CREATE SCHEMA [DE_UNA]
GO
CREATE PROCEDURE [DE_UNA].[DropTables] AS
BEGIN
	SET NOCOUNT ON;

	IF OBJECT_ID('DE_UNA.Items', 'U')				IS NOT NULL DROP TABLE DE_UNA.Items; 
	IF OBJECT_ID('DE_UNA.Facturas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Facturas;
	IF OBJECT_ID('DE_UNA.Ofertas', 'U')				IS NOT NULL DROP TABLE DE_UNA.Ofertas; 
	IF OBJECT_ID('DE_UNA.Compras', 'U')				IS NOT NULL DROP TABLE DE_UNA.Compras; 
	IF OBJECT_ID('DE_UNA.Publicaciones', 'U')		IS NOT NULL DROP TABLE DE_UNA.Publicaciones; 
	IF OBJECT_ID('DE_UNA.Tipos_Publicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.Tipos_Publicacion; 
	IF OBJECT_ID('DE_UNA.EstadosPublicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.EstadosPublicacion; 
	IF OBJECT_ID('DE_UNA.Visibilidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Visibilidades; 
	IF OBJECT_ID('DE_UNA.Empresas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Empresas; 
	IF OBJECT_ID('DE_UNA.Clientes', 'U')			IS NOT NULL DROP TABLE DE_UNA.Clientes; 
	IF OBJECT_ID('DE_UNA.Rubros', 'U')				IS NOT NULL DROP TABLE DE_UNA.Rubros; 
	IF OBJECT_ID('DE_UNA.Roles_Usuario', 'U')		IS NOT NULL DROP TABLE DE_UNA.Roles_Usuario; 
	IF OBJECT_ID('DE_UNA.Func_por_Rol', 'U')		IS NOT NULL DROP TABLE DE_UNA.Func_por_Rol; 
	IF OBJECT_ID('DE_UNA.Funcionalidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Funcionalidades; 
	IF OBJECT_ID('DE_UNA.Roles', 'U')				IS NOT NULL DROP TABLE DE_UNA.Roles; 
	IF OBJECT_ID('DE_UNA.Usuarios', 'U')			IS NOT NULL DROP TABLE DE_UNA.Usuarios;
END
GO

-- Procedimiento para crear todas las tablas del DER para la migración.
CREATE PROCEDURE [DE_UNA].[CrearTablas]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- ( 1)
	CREATE TABLE [DE_UNA].[Usuarios](
		[cod_usuario]		[decimal](20, 0) IDENTITY PRIMARY KEY,
		[login_fallidos]	[decimal](1, 0)		NULL DEFAULT(0),
		[username]			[nvarchar](50)      NULL,
--		[password]			[nvarchar](100)		NULL,
		[password]			varbinary(100)		NULL,
		[activo]			[bit]				NOT NULL DEFAULT(1),
		[mail]				[nvarchar](255)		NULL,
		[telefono]			[varchar](100)		NULL,
		[dir_calle]			[nvarchar](255)		NULL,
		[dir_nro]			[numeric](18, 0)	NULL,
		[dir_piso]			[numeric](18, 0)	NULL,
		[dir_depto]			[nvarchar](50)		NULL,
		[dir_localidad]		[nvarchar](100)		NULL,
		[dir_cod_post]		[nvarchar](50)		NULL,
		[fecha_nacimiento]	[datetime]			NULL,
		[fecha_alta]		[datetime]			NULL,
		[fecha_baja]		[datetime]			NULL,
		[publ_sin_cargo]	[bit]				NULL,
		[cant_ventas]		[numeric](18, 0)	NULL DEFAULT(0),
		[sum_calificacion]	[numeric](18, 0)	NULL DEFAULT(0)
	) ON [PRIMARY]

-- ( 2)
	CREATE TABLE [DE_UNA].[Roles](
		[cod_rol]			[decimal](10, 0) IDENTITY PRIMARY KEY,
		[nombre]			[nvarchar](50)		NULL,
		[activo]			[bit]				NULL DEFAULT(1)
	) ON [PRIMARY]

-- ( 3)
	CREATE TABLE [DE_UNA].[Funcionalidades](
		[cod_funcionalidad]	[decimal](10, 0)	PRIMARY KEY,
		[descripcion]		[nvarchar](50)		NULL
	) ON [PRIMARY]

-- ( 4)
	CREATE TABLE [DE_UNA].[Func_por_Rol](
		[cod_funcionalidad]	[decimal](10, 0)	NOT NULL REFERENCES [DE_UNA].[Funcionalidades],
		[cod_rol]			[decimal](10, 0)	NOT NULL REFERENCES [DE_UNA].[Roles],
		CONSTRAINT KeyFuncPorRol PRIMARY KEY(cod_funcionalidad, cod_rol)
	) ON [PRIMARY]

-- ( 5)
	CREATE TABLE [DE_UNA].[Roles_Usuario](
		[cod_usuario]		[decimal](20, 0)	NOT NULL REFERENCES [DE_UNA].[Usuarios],
		[cod_rol]			[decimal](10, 0)	NOT NULL REFERENCES [DE_UNA].[Roles],
		CONSTRAINT KeyRolesUsuario PRIMARY KEY(cod_usuario, cod_rol)
	) ON [PRIMARY]

-- ( 6)
	CREATE TABLE [DE_UNA].[Rubros](
		[cod_rubro]			[decimal](10, 0) IDENTITY PRIMARY KEY,
		[desc_corta]		[nvarchar](50)		NULL,
		[desc_larga]		[nvarchar](255)		NULL
	) ON [PRIMARY]

-- ( 7)
	CREATE TABLE [DE_UNA].[Clientes](
		[cod_usuario]		[decimal](20, 0)	PRIMARY KEY REFERENCES [DE_UNA].[Usuarios],
		[nombre]			[nvarchar](255)		NULL,
		[apellido]			[nvarchar](255)		NULL,
		[dni]				[numeric](18, 0)	NULL,
		[documento_tipo]	[varchar](10)		NULL
	) ON [PRIMARY]

-- ( 8)
	CREATE TABLE [DE_UNA].[Empresas](
		[cod_usuario]		[decimal](20, 0)	PRIMARY KEY REFERENCES [DE_UNA].[Usuarios],
		[cuit]				[nvarchar](50)		NULL,
		[razon_social]		[nvarchar](255)		NULL,
		[dir_ciudad]		[varchar](50)		NULL,
		[nombre_contacto]	[varchar](255)		NULL,
		[cod_rubro]			[decimal](10, 0)	NULL REFERENCES [DE_UNA].[Rubros]
	) ON [PRIMARY]

-- ( 9)
	CREATE TABLE [DE_UNA].[Visibilidades](
		[cod_visibilidad]	[numeric](18, 0)	PRIMARY KEY,
		[descripcion]		[nvarchar](255)		NULL,
		[costo_publicar]	[numeric](18, 2)	NULL,
		[porcentaje_venta]	[numeric](18, 2)	NULL,
		[costo_envio]		[numeric](18, 2)	NULL
	) ON [PRIMARY]

-- (10)
	CREATE TABLE [DE_UNA].[EstadosPublicacion](
		[cod_estado]		[numeric](1, 0)	 IDENTITY PRIMARY KEY,
		[descripcion]		[nvarchar](255)		NULL
	) ON [PRIMARY]

-- (11)
	CREATE TABLE [DE_UNA].[Tipos_Publicacion](
		[cod_tipo_publi]	[numeric](1, 0) IDENTITY PRIMARY KEY,
		[descripcion]		[nvarchar](255)		NULL
	) ON [PRIMARY]

-- (12)
	CREATE TABLE [DE_UNA].[Publicaciones](
		[cod_publi]			[numeric](18, 0)	PRIMARY KEY,
		[descripcion]		[nvarchar](255)		NULL,
		[stock]				[numeric](18, 0)	NULL,
		[fecha_inicio]		[datetime]			NULL,
		[fecha_vencimiento]	[datetime]			NULL,
		[precio_producto]	[numeric](18, 2)	NULL,
		[cod_visibilidad]	[numeric](18, 0)	NOT NULL REFERENCES [DE_UNA].[Visibilidades],
		[cod_estado]		[numeric](1, 0)		NOT NULL REFERENCES [DE_UNA].[EstadosPublicacion],
		[cod_rubro]			[decimal](10, 0)	NOT NULL REFERENCES [DE_UNA].[Rubros],
		[cod_usuario]		[decimal](20, 0)	NOT NULL REFERENCES [DE_UNA].[Usuarios],
		[cod_tipo_publi]	[numeric](1, 0)		NOT NULL REFERENCES [DE_UNA].[Tipos_Publicacion],
		[con_envio]			[bit]				NULL DEFAULT 0,
		[con_preguntas]		[bit]				NULL DEFAULT 0,
		[fecha_finalizacion] [datetime]			NULL DEFAULT NULL
	) ON [PRIMARY]

-- (13)
	CREATE TABLE [DE_UNA].[Compras](
		[id_compra]			[numeric](18, 0) IDENTITY NOT NULL,
		[cod_publi]			[numeric](18, 0)	NOT NULL REFERENCES [DE_UNA].[Publicaciones],
		[cod_usuario]		[decimal](20, 0)	NOT NULL REFERENCES [DE_UNA].[Usuarios],
		[fecha_compra]		[datetime]			NOT NULL,
		[monto]				[numeric](18, 2)	NULL,
		[cantidad]			[numeric](18, 0)	NULL,
		[cod_calificacion]	[numeric](18, 0)	NULL,
		[estrellas]			[numeric](18, 0)	NULL,
		[desc_calificacion]	[nvarchar](255)		NULL,
		CONSTRAINT KeyCompras PRIMARY KEY([id_compra])
	) ON [PRIMARY]

-- (14)
	CREATE TABLE [DE_UNA].[Ofertas](
		[id_oferta]			[numeric](18, 0) IDENTITY NOT NULL,
		[cod_publi]			[numeric](18, 0)	NOT NULL REFERENCES [DE_UNA].[Publicaciones],
		[cod_usuario]		[decimal](20, 0)	NOT NULL REFERENCES [DE_UNA].[Usuarios],
		[fecha_oferta]		[datetime]			NOT NULL,
		[monto]				[numeric](18, 2)	NULL,
		CONSTRAINT KeyOfertas PRIMARY KEY([id_oferta])
	) ON [PRIMARY]

-- (15)
	CREATE TABLE [DE_UNA].[Facturas](
		[num_factura]		[numeric](18, 0)	PRIMARY KEY,
		[cod_publi]			[numeric](18, 0)	NOT NULL REFERENCES [DE_UNA].[Publicaciones],
		[fecha_factura]		[datetime]			NULL,
		[total]				[numeric](18, 2)	NULL,
		[forma_pago]		[nvarchar](255)		NULL,
		[cod_usuario]		[decimal](20, 0)	NOT NULL REFERENCES [DE_UNA].[Usuarios]
	) ON [PRIMARY]

-- (16)
	CREATE TABLE [DE_UNA].[Items](
		[id_item]			[numeric](18, 0)	NOT NULL IDENTITY,
		[num_factura]		[numeric](18, 0)	NOT NULL REFERENCES [DE_UNA].[Facturas],
		[cod_item]			[numeric](1, 0)		NOT NULL,
		[descripcion_item]	[varchar](30)		NULL,
		[item_cantidad]		[numeric](18, 0)	NULL,
		[item_monto]		[numeric](18, 2)	NULL,
		CONSTRAINT KeyItems PRIMARY KEY(id_item, num_factura, cod_item)
	) ON [PRIMARY]

END
GO


-- Description:	SP par poblar tablas que no tienen dependencias.
CREATE PROCEDURE [DE_UNA].[PoblarTablasSinDependencias] AS
BEGIN

-- VISIBILIDADES
	INSERT INTO [DE_UNA].[Visibilidades]
		SELECT DISTINCT
			  [Publicacion_Visibilidad_Cod]
			, [Publicacion_Visibilidad_Desc]
			, [Publicacion_Visibilidad_Precio]
			, [Publicacion_Visibilidad_Porcentaje]
			, 50.00
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Visibilidad_Cod];

-- ESTADOS DE PUBLICACION
	INSERT INTO [DE_UNA].[EstadosPublicacion]
	     SELECT DISTINCT [Publicacion_Estado]
		   FROM [gd_esquema].[Maestra]

	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Borrador');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Activa');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Pausada');
	INSERT [DE_UNA].[EstadosPublicacion] VALUES ('Finalizada');

-- TIPOS DE PUBLICACION
	INSERT INTO [DE_UNA].[Tipos_Publicacion]
		SELECT DISTINCT [Publicacion_Tipo]
		FROM [gd_esquema].[Maestra]

-- RUBROS
	INSERT INTO [DE_UNA].[Rubros]
		SELECT DISTINCT SUBSTRING([Publicacion_Rubro_Descripcion], 0, 50), 
		                          [Publicacion_Rubro_Descripcion]
		FROM [gd_esquema].[Maestra]
		ORDER BY [Publicacion_Rubro_Descripcion] ASC;

-- ROLES
	INSERT INTO [DE_UNA].[Roles] VALUES (1, 'Empresa', 1);
	INSERT INTO [DE_UNA].[Roles] VALUES (2, 'Cliente', 1);

-- USUARIO ADMINISTRADOR
	INSERT INTO [DE_UNA].Usuarios (username, [password], fecha_alta, activo)
	VALUES ('admin', HASHBYTES('SHA2_256', 'w23e'), GETDATE(), 1);

-- FUNCIONALIDADES DE USUARIOS COMUNES
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (0,'Comprar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (1,'Ofertar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (2,'Vender');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (3,'Publicar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (4,'Estafar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (5,'Calificar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (6,'Preguntar');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (7,'Crear Publicación');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (8,'Modificar Publicación');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (9,'Modificar Usuario'); -- Modificar a su propio Usuario (cambiar mail, telefono, etc.)
-- Funcionalidades comunes a Todos los usuarios
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (10,'Ver Historial de Cliente');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (11,'Consultar facturas realizadas al vendedor');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (12,'Ver Estadísticas');
-- Funcionalidades exclusivas de Administradores
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (20,'ABM de Usuario');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (21,'ABM de Rol');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (22,'ABM de Rubro');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (23,'ABM de Visibilidad');
	INSERT INTO [DE_UNA].[Funcionalidades] VALUES (24,'Borrar Publicación');

-- Funciones para el Rol Empresa
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (2,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (3,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (5,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (7,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (8,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (9,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (10,1);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (11,1);
-- Funciones para el Rol Cliente
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (0,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (1,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (2,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (3,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (4,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (5,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (6,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (7,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (8,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (9,2);
	INSERT INTO [DE_UNA].[Func_por_Rol] VALUES (10,2);

	RETURN 1;
END
GO


-- Description:	migra datos desde la tabla maestra creando usuarios y Empresas!
-- Author:		Lucas Moglia
-- Modificado por: Germán Rodriguez
-- Create date: 21/05/2016
-- Description:	migra datos desde la tabla maestra
-- creando usuarios y Empresas!
CREATE PROCEDURE [DE_UNA].[MigrarUsuarioEmpresa] AS
BEGIN

	PRINT '-------- Migrando Empresas...  --------';

	IF OBJECT_ID('[DE_UNA].#Usuario_empresas', 'U')	IS NOT NULL DROP TABLE [DE_UNA].#Usuario_empresas; 

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
	  INTO [DE_UNA].#Usuario_empresas
	  FROM [gd_esquema].Maestra
	 WHERE Publ_Empresa_Cuit IS NOT NULL;

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
			FROM [DE_UNA].#Usuario_empresas;

	PRINT '----  Usuarios Empresas migrados!  ----';

	INSERT INTO [DE_UNA].Empresas (cod_usuario, cuit, razon_social)
		SELECT U.cod_usuario
			 , E.Publ_Empresa_Cuit
			 , E.Publ_Empresa_Razon_Social
		  FROM [DE_UNA].#Usuario_empresas E
		   JOIN [DE_UNA].Usuarios         U ON E.Publ_Empresa_Cuit = U.username;

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
		    JOIN [DE_UNA].[Roles]   R ON R.nombre = 'Empresa'
END
GO

-- Description:	migra datos desde la tabla maestra
-- creando usuarios y clientes!
CREATE PROCEDURE [DE_UNA].[MigrarUsuarioCliente]
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
GO

-- Description:	SP para migrar las Publicaciones
-- Éste SP no se podrá ejecutar antes de PoblarTablasSinDependencias ni MigrarUsuarios (Clientes y Empresas).
-- =============================================
CREATE PROCEDURE [DE_UNA].MigrarPublicaciones AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '----- Migrando Publicaciones... -----';

	INSERT INTO [DE_UNA].[Publicaciones] ([cod_publi], [descripcion], [stock], [fecha_inicio], [fecha_vencimiento], [precio_producto],
										  [cod_visibilidad], [cod_estado], [cod_rubro], [cod_usuario], [cod_tipo_publi])
		 SELECT DISTINCT M.[Publicacion_Cod]
			  , M.[Publicacion_Descripcion]
			  , M.[Publicacion_Stock]
			  , M.[Publicacion_Fecha]
			  , M.[Publicacion_Fecha_Venc]
			  , M.[Publicacion_Precio]
			  , M.[Publicacion_Visibilidad_Cod]
			  , EP.[cod_estado]
			  , R.[cod_rubro]
			  , CASE
					WHEN M.[Publ_Empresa_Cuit] IS NOT NULL THEN
						E.[cod_usuario]
					ELSE
						C.[cod_usuario]
				END AS cod_usuario
			  , T.[cod_tipo_publi]
		   FROM [gd_esquema].[Maestra] M
			   JOIN [DE_UNA].[EstadosPublicacion] EP ON M.[Publicacion_Estado] = EP.[descripcion]
			   JOIN [DE_UNA].[Rubros]             R  ON M.[Publicacion_Rubro_Descripcion] = R.[desc_larga]
			   LEFT JOIN [DE_UNA].[Empresas]      E  ON M.[Publ_Empresa_Cuit] = E.[cuit]
			   LEFT JOIN [DE_UNA].[Clientes]      C  ON M.[Publ_Cli_Dni] = C.[dni]
			   JOIN [DE_UNA].[Tipos_Publicacion]  T  ON M.[Publicacion_Tipo] = T.[descripcion]
		   WHERE M.[Publicacion_Cod] IS NOT NULL
		   ORDER BY [Publicacion_Cod];

	PRINT '------- Publicaciones migradas -------';

END
GO

CREATE PROCEDURE [DE_UNA].MigrarCompras AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '-------- Migrando Compras... --------';

-- Este procedimiento migra en dos partes, primero aquellos registros correspondientes a las compras ya calificadas 
-- y luego aquellas compras aun no calificadas. Asimismo, una vez que migró las compras ya calificadas, se encarga
-- mediante un cursor de actualizar los datos para el cálculo de la reputación de los vendedores asociados a esas compras.

-- Migro Compras ya Calificadas
	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , round((M.[Calificacion_Cant_Estrellas] / 2),0)  -- la cantidad de estrellas adaptada al nuevo formato.
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL and M.Calificacion_Codigo is not null and M.Calificacion_Cant_Estrellas is not null
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario], M.[Calificacion_Codigo] desc;


	-- Acá va el cursor que recorre la tabla Compras recién migrada y por cada registro suma la cantidad de estrellas 
	-- en Usuarios.sum_calificacion e incrementa en uno Usuarios.cant_ventas donde 
	-- Compras.cod_publi = Publicaciones.cod_publi y Publicaciones.cod_usuario = Usuarios.cod_usuario

	DECLARE usuarios_cursor CURSOR FOR SELECT  C.cod_publi, c.estrellas FROM DE_UNA.Compras C
	DECLARE   @cod_publi			numeric(18,0), @estrellas			numeric(18,0);
	
	OPEN usuarios_cursor
	FETCH NEXT FROM usuarios_cursor INTO @cod_publi, @estrellas

	PRINT 'Comenzando Migracion de Calificaciones de Vendedores'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		update DE_UNA.Usuarios
		set   sum_calificacion = sum_calificacion + @estrellas
				, cant_ventas  = cant_ventas + 1
			where DE_UNA.Usuarios.cod_usuario = (select P.cod_usuario from Publicaciones P where P.cod_publi = @cod_publi)
		FETCH NEXT FROM usuarios_cursor INTO @cod_publi, @estrellas
	END 

	CLOSE usuarios_cursor;
	DEALLOCATE usuarios_cursor;

	PRINT '----- Calificaciones de Vendedores Migradas -----';


-- Migro Compras aun sin calificar.
-- Aca me fijo si ya existe un registro en la tabla destino con los datos en común, para no agregarlo. O sea, inserta las compras no calificadas.
	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , (isnull(M.[Calificacion_Cant_Estrellas],0)/2)
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL 	and M.Calificacion_Codigo is null 
								and not exists (select 1 from [DE_UNA].[Compras] p where 
															    p.cod_publi		= M.Publicacion_Cod
															and p.cod_usuario   = C.cod_usuario
															and p.cantidad		= M.Compra_Cantidad
															and p.fecha_compra  = M.Compra_Fecha
															and p.monto			= M.Publicacion_Precio
												)
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario], M.[Calificacion_Codigo] desc;
	PRINT '----- Tabla de Compras, Migrada -----';

END
GO


-- Description:	SP para Migrar las Ofertas.
-- Este SP no se podrá ejecutar antes de la Migración de las Tablas Clientes y Publicaciones.
-- =============================================
CREATE PROCEDURE [DE_UNA].[Migrar_Ofertas] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT '-------- Migrando Ofertas... --------';

	INSERT INTO [DE_UNA].[Ofertas]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Oferta_Fecha]
			  , M.[Oferta_Monto]
		  FROM [gd_esquema].[Maestra] M
		  JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		 WHERE M.[Oferta_Monto] IS NOT NULL
		 ORDER BY M.[Publicacion_Cod], C.[cod_usuario];

	PRINT '----- Tabla de ofertas, Migrada -----';
END
GO

-- Description:	migra datos desde la tabla maestra Insertando Facturas!
-- Depende de INSERT DE PUBLICACIONES
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarFacturas]
AS
BEGIN
	IF (SELECT COUNT(P.cod_publi) FROM [DE_UNA].Publicaciones P) > 0
	BEGIN
		PRINT 'Migrando facturas...'

		INSERT INTO [DE_UNA].[Facturas]
		SELECT DISTINCT M.Factura_Nro
			, M.Publicacion_Cod
			, M.Factura_Fecha
			, M.Factura_Total
			, M.Forma_Pago_Desc
			, CASE
					WHEN M.[Publ_Empresa_Cuit] IS NOT NULL THEN
						E.[cod_usuario]
					ELSE
						C.[cod_usuario]
			  END AS cod_usuario
		FROM gd_esquema.Maestra M
		    LEFT JOIN [DE_UNA].[Empresas] E ON M.[Publ_Empresa_Cuit] = E.[cuit]
			LEFT JOIN [DE_UNA].[Clientes] C ON M.[Publ_Cli_Dni] = C.[dni]
		WHERE M.Factura_Nro IS NOT NULL
		--GROUP BY M.Factura_Nro
		--	, M.Publicacion_Cod
		--	, M.Factura_Fecha
		--	, M.Factura_Total
		--	, M.Forma_Pago_Desc
		ORDER BY M.Factura_Nro
	END
	ELSE
		PRINT 'No existen publicaciones. Migralas, e intentá de nuevo!'

	PRINT 'Migrando items de las facturas'

	DECLARE   @EsPrimero       varchar(2)
	        , @FacturaAnterior numeric(18)
			, @nro_fact        numeric(18)
			, @cod_item        numeric(1)
			, @desc_item       varchar(30)
			, @item_cant       numeric(18,0)
			, @item_mont       numeric(18,2);

	DECLARE @itemsTemp TABLE (
	 nro_fact  numeric(18),
	 cod_item  numeric(1),
	 desc_item varchar(30),
	 item_cant numeric(18,0),
	 item_mont numeric(18,2)
	)

	DECLARE ITEM_cursor CURSOR FOR 
	SELECT  nro_fact,
			cod_item, 
			desc_item,
			item_cant, 
			item_mont
	FROM @itemsTemp
	ORDER BY nro_fact

	INSERT INTO @itemsTemp
		SELECT  Factura_Nro
				,2
				,'Comision venta'
				,Item_Factura_Cantidad
				,Item_Factura_Monto
		FROM gd_esquema.Maestra
		WHERE Factura_Nro IS NOT NULL

	UPDATE @itemsTemp
		SET cod_item = 1,
			desc_item = 'Costo por publicar'
		WHERE item_mont IN (60, 100, 140, 180)

	OPEN ITEM_cursor

	FETCH NEXT FROM ITEM_cursor 
	INTO	  @nro_fact
			, @cod_item
			, @desc_item
			, @item_cant
			, @item_mont

	SET @EsPrimero       = 'SI'
	SET @FacturaAnterior = @nro_fact

	-- CORTE DE CONTROL: Identifica entre 'Comision de venta' y 'Costo por publicar' para publicaciones gratuitas (ambas con monto cero)

	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF (@cod_item = 2 AND @desc_item = 'Comision venta' AND @item_cant = 1 AND @item_mont = 0 AND @EsPrimero = 'SI')
			BEGIN
				INSERT INTO [DE_UNA].[Items] ([num_factura], [cod_item], [descripcion_item], [item_cantidad], [item_monto])
					VALUES(	  @nro_fact
							, 1
							, 'Costo por publicar'
							, @item_cant
							, @item_mont)

				SET @EsPrimero = 'NO'
				 
			END 
		ELSE
			BEGIN
				INSERT INTO [DE_UNA].[Items] ([num_factura], [cod_item], [descripcion_item], [item_cantidad], [item_monto])
					VALUES(	  @nro_fact
							, @cod_item
							, @desc_item
							, @item_cant
							, @item_mont)
			END
		
		FETCH NEXT FROM ITEM_cursor 
			INTO   @nro_fact
				 , @cod_item
				 , @desc_item
				 , @item_cant
				 , @item_mont
		
		IF (@FacturaAnterior <> @nro_fact)
		    BEGIN
		      SET @FacturaAnterior = @nro_fact
			  SET @EsPrimero = 'SI'
		    END

	END 
	CLOSE ITEM_cursor;
	DEALLOCATE ITEM_cursor;

END
GO

--EXECUTE [DE_UNA].[DropTables];
--GO
EXECUTE [DE_UNA].[CrearTablas];
GO
EXECUTE [DE_UNA].[PoblarTablasSinDependencias];
GO
EXECUTE [DE_UNA].[MigrarUsuarioEmpresa];
GO
EXECUTE [DE_UNA].[MigrarUsuarioCliente];
GO
EXECUTE [DE_UNA].[MigrarPublicaciones];
GO
EXECUTE [DE_UNA].[MigrarCompras];
GO
EXECUTE [DE_UNA].[Migrar_Ofertas];
GO
EXECUTE [DE_UNA].[MigrarFacturas];
GO


/****** Object:  UserDefinedTableType [DE_UNA].[FuncionalidadesList]    Script Date: 19/06/2016 13:29:30 ******/
CREATE TYPE [DE_UNA].[Rubros] AS TABLE(
	[cod_rubro] [decimal](10, 0) NULL
)
GO
CREATE TYPE [DE_UNA].[FuncionalidadesList] AS TABLE(
	[cod_funcionalidad] [decimal](18, 0) NULL
)
GO

CREATE TYPE [DE_UNA].[ListaNrosFacturas] AS TABLE(
	[nro_factura] [decimal](18, 0) NULL
)
GO



CREATE PROCEDURE [DE_UNA].NuevaVisibilidad
	-- Parámetros para los filtros.
	@descripcion      nvarchar(255),
	@costo_publicar   numeric(18,2),
	@porcentaje_venta numeric(18,2),
	@costo_envio      numeric(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Habría que poner todo esto en un Transacción así me devuelve el CURRENT ID correcto
-- y evitamos problemas de concurrencia.

	DECLARE @cod_visibilidad numeric(18,0) = (SELECT isnull(MAX(cod_visibilidad),0) + 1 AS cod_visibilidad FROM [DE_UNA].Visibilidades);

	INSERT INTO [DE_UNA].Visibilidades
	 VALUES( @cod_visibilidad
		   , @descripcion
		   , @costo_publicar
		   , @porcentaje_venta
		   , @costo_envio
	 );

	 SELECT @cod_visibilidad AS cod_visibilidad;
END
GO

-- Author:		Germán Rodriguez
-- Create date: 18/06/2016
-- Description:	SP para guardar una publicación.
-- =============================================
CREATE PROCEDURE [DE_UNA].CrearPublicacion
	-- Parámetros para los filtros.
	@descripcion     nvarchar(255),
	@stock           numeric(18,0),
	@fecha_inicio    datetime,
	@fecha_venc      datetime,
	@precio          numeric(18,2),
	@cod_visibilidad numeric(18,0),
	@cod_estado      numeric(1),
	@cod_rubro       decimal(10),
	@cod_usuario     decimal(20),
	@cod_tipo_publi  numeric (1),
	@con_envio       bit,
	@con_preguntas   bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Habría que poner todo esto en un Transacción así me devuelve el CURRENT ID correcto
-- y evitamos problemas de concurrencia.

	DECLARE @cod_publi numeric(18, 0) = (SELECT MAX(cod_publi) + 1 AS cod_publi FROM [DE_UNA].Publicaciones);

	INSERT INTO [DE_UNA].Publicaciones
	 VALUES( @cod_publi
		   , @descripcion
		   , @stock
		   , @fecha_inicio
		   , @fecha_venc
		   , @precio
		   , @cod_visibilidad
		   , @cod_estado
		   , @cod_rubro
		   , @cod_usuario
		   , @cod_tipo_publi
		   , @con_envio
		   , @con_preguntas
		   , NULL
	 );

	 SELECT @cod_publi AS cod_publi;
END
GO

CREATE PROCEDURE [DE_UNA].[NuevoRol]
	-- Add the parameters for the stored procedure here
	@nombre nvarchar(50),
	@funcionalidades [DE_UNA].FuncionalidadesList READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @cod_funcionalidad decimal

    -- Insert statements for procedure here
	BEGIN TRANSACTION;
	BEGIN TRY
		-- Cursor para funcionalidades por parametro
		DECLARE IDS_FUNCIONALIDADES CURSOR 
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT cod_funcionalidad 
		FROM @funcionalidades

		-- Generate a constraint violation error.
		INSERT INTO [DE_UNA].Roles (nombre, activo) VALUES(@nombre, 1)

		OPEN IDS_FUNCIONALIDADES
		FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			
			--Do something with Id here
			INSERT INTO DE_UNA.Func_por_Rol VALUES (@cod_funcionalidad, IDENT_CURRENT('DE_UNA.Roles'))

			FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		END
		CLOSE IDS_FUNCIONALIDADES
		DEALLOCATE IDS_FUNCIONALIDADES
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY() AS ErrorSeverity
			,ERROR_STATE() AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage;

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;
END
GO

-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una oferta.
-- RETORNA: 0 --> No es una oferta mayor a la última.
--          1 --> Ejecución OK.
-- =============================================
CREATE PROCEDURE [DE_UNA].NuevaOferta
	-- PARAMETROS:
	@cod_publi numeric(18, 0),
	@cod_usuario decimal(20, 0),
	@fecha_oferta datetime,
	@monto numeric(18, 2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRAN OFERTA
		DECLARE @stock numeric(18,0) = (SELECT stock FROM [DE_UNA].Publicaciones WHERE cod_publi = @cod_publi);

		--IF (!([DE_UNA].esMayorAUltimaOferta(@monto, @cod_publi))
		--	RETURN 0;
		--Inserta una oferta
		INSERT INTO [DE_UNA].Ofertas
			VALUES(@cod_publi, @cod_usuario, @fecha_oferta, @monto);
		--Actualiza el valor del producto
		UPDATE Publicaciones SET precio_producto = precio_producto + @monto WHERE cod_publi = @cod_publi
	COMMIT TRAN OFERTA
	RETURN 1;
END
GO




-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 09/07/2016
-- Description:	SP para modificar una publicación.
-- =============================================
CREATE PROCEDURE [DE_UNA].ActualizarPublicacion
	-- Parámetros para los filtros.
	@descripcion     nvarchar(255),
	@stock           numeric(18,0),
	@fecha_inicio    datetime,
	@fecha_venc      datetime,
	@precio          numeric(18,2),
	@cod_visibilidad numeric(18,0),
	@cod_estado      numeric(1),
	@cod_rubro       decimal(10),
	@cod_usuario     decimal(20),
	@cod_tipo_publi  numeric (1),
	@con_envio       bit,
	@con_preguntas   bit,
	@fecha_finaliz  datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Habría que poner todo esto en un Transacción así me devuelve el CURRENT ID correcto
-- y evitamos problemas de concurrencia.

	DECLARE @cod_publi numeric(18, 0) = (SELECT MAX(cod_publi) + 1 AS cod_publi FROM [DE_UNA].Publicaciones);

	UPDATE [DE_UNA].Publicaciones
	 SET  descripcion = @descripcion
		, stock = @stock
		, fecha_inicio = @fecha_inicio
		, fecha_vencimiento = @fecha_venc
		, precio_producto   = @precio
		, cod_visibilidad = @cod_visibilidad
		, cod_estado = @cod_estado
		, cod_rubro = @cod_rubro
		, cod_usuario = @cod_usuario
		, cod_tipo_publi = @cod_tipo_publi
		, con_envio = @con_envio
		, con_preguntas = @con_preguntas
		, fecha_finalizacion = @fecha_finaliz
	 WHERE cod_publi = @cod_publi

	 SELECT @cod_publi AS cod_publi;
END
GO

-- ==================================================
-- Author:		Lucas Moglia
-- Create date: 19/06/2016
-- Description: Actualizar Rol y sus funcionalidades
-- ==================================================
CREATE PROCEDURE [DE_UNA].[ActualizarRol] 
	-- Add the parameters for the stored procedure here
	@cod_rol decimal, 
	@funcionalidades [DE_UNA].FuncionalidadesList READONLY
AS
BEGIN
	declare @cod_funcionalidad decimal

	BEGIN TRANSACTION;
	BEGIN TRY
		-- Generate a constraint violation error.
		DELETE FROM DE_UNA.Func_por_Rol
		WHERE cod_rol = @cod_rol;
	
		-- Cursor para funcionalidades por parametro
		DECLARE IDS_FUNCIONALIDADES CURSOR 
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT cod_funcionalidad 
		FROM @funcionalidades

		OPEN IDS_FUNCIONALIDADES
		FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			--Do something with Id here
			INSERT INTO DE_UNA.Func_por_Rol VALUES (@cod_funcionalidad, @cod_rol)
			FETCH NEXT FROM IDS_FUNCIONALIDADES INTO @cod_funcionalidad
		END
		CLOSE IDS_FUNCIONALIDADES
		DEALLOCATE IDS_FUNCIONALIDADES
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY() AS ErrorSeverity
			,ERROR_STATE() AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage;

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;

END
GO

CREATE PROCEDURE [DE_UNA].ActualizarVisibilidad 
	@cod_visibilidad  numeric(18,0),
	@descripcion      nvarchar(255),
	@costo_publicar   numeric(18,2),
	@porcentaje_venta numeric(18,2),
	@costo_envio      numeric(18,2)
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		update Visibilidades
			set descripcion			= @descripcion
				,costo_publicar		= @costo_publicar
				,porcentaje_venta	= @porcentaje_venta
				,costo_envio		= @costo_envio
			where cod_visibilidad	= @cod_visibilidad;
	END TRY
	BEGIN CATCH
		SELECT 
 			 ERROR_NUMBER()		AS ErrorNumber
			,ERROR_SEVERITY()	AS ErrorSeverity
			,ERROR_STATE()		AS ErrorState
			,ERROR_PROCEDURE()	AS ErrorProcedure
			,ERROR_LINE()		AS ErrorLine
			,ERROR_MESSAGE()	AS ErrorMessage;

		IF @@TRANCOUNT > 0 	ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0 		COMMIT TRANSACTION;
END
GO

CREATE PROCEDURE [DE_UNA].GetFuncionalidades AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_funcionalidad
		 , descripcion
	  FROM [DE_UNA].Funcionalidades;
END
GO

CREATE PROCEDURE [DE_UNA].[GetFuncionalidadesByRol] 
	-- Add the parameters for the stored procedure here
	@cod_rol decimal
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT F.cod_funcionalidad, F.descripcion
	FROM [DE_UNA].Func_por_Rol FR
	JOIN [DE_UNA].Funcionalidades F
		ON FR.cod_funcionalidad = F.cod_funcionalidad
	WHERE FR.cod_rol = @cod_rol

END
GO

CREATE PROCEDURE [DE_UNA].[GetClientes]
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT U.cod_usuario
		, C.nombre
		, C.apellido
		, C.dni
		, U.username
		, U.mail
		, U.activo
		, U.telefono
		, U.dir_calle
		, U.dir_nro
		, U.dir_piso
		, U.dir_depto
		, U.dir_localidad
		, U.dir_cod_post
		, U.fecha_nacimiento
		, U.fecha_alta
		, U.publ_sin_cargo
		, U.cant_ventas
	FROM [DE_UNA].Usuarios U
		JOIN [DE_UNA].Clientes C
			ON U.cod_usuario = C.cod_usuario
	WHERE (@activeOnly = 1 AND U.activo = 1) OR @activeOnly = 0
END
GO

-- =============================================
-- Description:	SP para recuperar las Compras de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetCompras 
	-- Parámetros para los filtros.
	@cod_publi   numeric(18,0),
	@cod_usuario decimal(20,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id_compra
	, cod_publi
	, cod_usuario
	, fecha_compra
	, monto
	, cantidad
	, cod_calificacion
	, estrellas
	, desc_calificacion
	FROM [DE_UNA].Compras
	WHERE		(cod_publi    = @cod_publi   OR @cod_publi	IS NULL)
		  AND	(cod_usuario  = @cod_usuario OR @cod_usuario IS NULL)
	ORDER BY cod_publi
END
GO

CREATE PROCEDURE [DE_UNA].[GetEmpresas]
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT U.cod_usuario
		, E.razon_social
		, E.dir_ciudad
		, E.nombre_contacto
		, R.desc_larga
		, E.cuit
		, U.mail
		, U.username
		, case when U.activo = 1 then 'Si' else 'No' end as activo
		, U.telefono
		, U.dir_calle
		, U.dir_nro
		, U.dir_piso
		, U.dir_depto
		, U.dir_localidad
		, U.dir_cod_post
		, U.fecha_alta
	FROM [DE_UNA].Usuarios U
		JOIN [DE_UNA].Empresas E
			ON U.cod_usuario = E.cod_usuario
		LEFT JOIN [DE_UNA].[Rubros] R
			ON E.cod_rubro = R.cod_rubro
	WHERE (@activeOnly = 1 AND U.activo = 1) OR @activeOnly = 0
END
GO

CREATE PROCEDURE [DE_UNA].[GetGridUsuarios]
	-- Add the parameters for the stored procedure here
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  
	U.cod_usuario
	, C.nombre
	, C.apellido
	, C.dni
	, C.documento_tipo
	, E.razon_social
	, E.dir_ciudad
	, E.nombre_contacto
	, R.desc_larga as rubro
	, E.cuit
	, U.mail
	, U.username
	, U.activo
	, U.telefono
	, U.dir_calle
	, U.dir_nro
	, U.dir_piso
	, U.dir_depto
	, U.dir_localidad
	, U.dir_cod_post
	, U.fecha_nacimiento

	FROM [DE_UNA].Usuarios U
	LEFT JOIN [DE_UNA].Clientes C
		ON U.cod_usuario = C.cod_usuario
	LEFT JOIN [DE_UNA].Empresas E
		ON U.cod_usuario = E.cod_usuario
		LEFT JOIN [DE_UNA].Rubros R
			ON E.cod_rubro = R.cod_rubro

	WHERE U.fecha_baja IS NULL
END
GO

CREATE PROCEDURE [DE_UNA].GetVisibilidad
	-- Add the parameters for the stored procedure here
	@cod_visibilidad numeric(18)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_visibilidad
		 , descripcion
		 , costo_publicar
		 , porcentaje_venta
		 , costo_envio
	  FROM [DE_UNA].Visibilidades
	 WHERE (@cod_visibilidad IS NOT NULL AND cod_visibilidad = @cod_visibilidad)
	    OR @cod_visibilidad IS NULL;
END
GO

CREATE PROCEDURE [DE_UNA].GetVisibilidades AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_visibilidad
		 , descripcion
		 , costo_publicar
		 , porcentaje_venta
		 , costo_envio
	  FROM [DE_UNA].Visibilidades
END
GO

-- Description:	SP para recuperar un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetUsuario
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	DECLARE @esCliente numeric(18,0) = (SELECT dni FROM [DE_UNA].Clientes WHERE cod_usuario = @cod_usuario)

	SELECT U.cod_usuario
		 , C.dni
		 , C.nombre
		 , C.apellido
		 , E.cuit
		 , E.razon_social
		 , E.dir_ciudad
		 , E.nombre_contacto
		 , R.desc_larga AS rubro
		 , U.mail
		 , U.username
		 , U.activo
		 , U.telefono
		 , U.dir_calle
		 , U.dir_nro
		 , U.dir_piso
		 , U.dir_depto
		 , U.dir_localidad
		 , U.dir_cod_post
		 , U.fecha_nacimiento
	FROM [DE_UNA].Usuarios U
	 LEFT JOIN [DE_UNA].Clientes C ON U.cod_usuario = C.cod_usuario
	 LEFT JOIN [DE_UNA].Empresas E ON U.cod_usuario = E.cod_usuario
	 LEFT JOIN [DE_UNA].Rubros   R ON E.cod_rubro   = R.cod_rubro
	 WHERE (@cod_usuario IS NOT NULL AND U.cod_usuario = @cod_usuario)
	    OR @cod_usuario IS NULL;
END
GO

CREATE PROCEDURE [DE_UNA].GetTiposPublicacion AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_tipo_publi
		 , descripcion
	  FROM [DE_UNA].Tipos_Publicacion;
END
GO

-- =============================================
CREATE PROCEDURE [DE_UNA].[GetRoles]
	@activeOnly bit
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cod_rol, nombre
	FROM [DE_UNA].[Roles] 
	WHERE (@activeOnly = 1 AND activo = 1) OR @activeOnly = 0
END
GO

-- Description:	SP para recuperar los Estados de Publicacion.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetEstadosPublicacion AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_estado
		 , descripcion
	  FROM [DE_UNA].EstadosPublicacion;
END
GO

-- =============================================
-- Description:	SP para recuperar las Ofertas de un Usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetOfertas
	-- Parámetros para los filtros.
	@cod_publi   numeric(18,0),
	@cod_usuario decimal(20,0)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id_oferta, cod_publi, cod_usuario, fecha_oferta, monto

	FROM [DE_UNA].Ofertas

	WHERE (cod_publi    = @cod_publi   OR @cod_publi   IS NULL)
	  AND (cod_usuario  = @cod_usuario OR @cod_usuario IS NULL)
	ORDER BY cod_publi
END
GO

-- =============================================
CREATE PROCEDURE [DE_UNA].GetRubros
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cod_rubro, desc_corta, desc_larga
	FROM [DE_UNA].[Rubros] 
END
GO

-- Description:	SP para obtener una Publicacion por codigo de publicación.
-- =============================================

CREATE PROCEDURE [DE_UNA].GetPublicacion
	-- Parámetros para los filtros.
	@cod_publi numeric(18,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT P.cod_publi
		  ,P.descripcion
		  ,P.stock
		  ,P.fecha_inicio
		  ,P.fecha_vencimiento
		  ,P.precio_producto
		  ,P.cod_visibilidad
		  ,V.descripcion AS visibilidad
		  ,V.costo_publicar
		  ,V.costo_publicar
		  ,V.porcentaje_venta
		  ,P.cod_estado
		  ,E.descripcion AS estado
		  ,P.cod_rubro
		  ,R.desc_corta
		  ,R.desc_larga
		  ,P.cod_usuario
		  ,U.username
		  ,P.cod_tipo_publi
		  ,T.descripcion AS tipo_publi
		  ,P.con_envio
		  ,P.con_preguntas
	FROM [DE_UNA].Publicaciones P
	 LEFT JOIN [DE_UNA].Visibilidades      V ON P.cod_visibilidad = V.cod_visibilidad
	 LEFT JOIN [DE_UNA].EstadosPublicacion E ON P.cod_estado = E.cod_estado
	 LEFT JOIN [DE_UNA].Rubros             R ON P.cod_rubro = R.cod_rubro
	 LEFT JOIN [DE_UNA].Tipos_Publicacion  T ON P.cod_tipo_publi = T.cod_tipo_publi
	 LEFT JOIN [DE_UNA].Usuarios           U ON P.cod_usuario = U.cod_usuario
	WHERE (P.cod_publi = @cod_publi OR @cod_publi IS NULL)
END
GO



-- Description:	SP para obtener un rubro por buscando por descripción.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetRubro
	-- Add the parameters for the stored procedure here
	@descripcion nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 
		cod_rubro,
		desc_corta,
		desc_larga
	FROM [DE_UNA].Rubros
	WHERE desc_larga LIKE('%' + @descripcion + '%');
END
GO

-- Description:	SP para obtener los roles de un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetRolesDeUsuario
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT RU.cod_rol
		 , R.nombre
	FROM [DE_UNA].Roles_Usuario RU
	 JOIN [DE_UNA].Roles R ON R.cod_rol = RU.cod_rol
	WHERE RU.cod_usuario = @cod_usuario
	  AND R.activo = 1
END
GO


-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para llenar la grilla de Publicaciones y permitir filtrar.
-- =============================================
/* Creo un Tipo Tabla que va a ser un parametro. 
CREATE TYPE [DE_UNA].Rubros AS TABLE
( cod_rubro decimal(10) );  
GO  

CREATE PROCEDURE [DE_UNA].GetPublicaciones
	-- Parámetros para los filtros.
	@estado numeric(1),
	@rubros [DE_UNA].Rubros READONLY,
	@descripcion nvarchar(255),
	@usuario decimal(20,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @publicada numeric(1) = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Publicada');

	SELECT TOP 1000 P.cod_publi
		  ,P.descripcion
		  ,P.stock
		  ,P.fecha_inicio
		  ,P.fecha_vencimiento
		  ,P.precio_producto
		  ,P.cod_visibilidad
		  ,V.descripcion AS visibilidad
		  ,V.costo_publicar
		  ,V.costo_publicar
		  ,V.porcentaje_venta
		  ,P.cod_estado
		  ,E.descripcion AS estado
		  ,P.cod_rubro
		  ,R.desc_corta
		  ,R.desc_larga
		  ,P.cod_usuario
		  ,U.username
		  ,P.cod_tipo_publi
		  ,T.descripcion AS tipo_publi
		  ,P.con_envio
		  ,P.con_preguntas
	FROM [DE_UNA].Publicaciones P
	 LEFT JOIN [DE_UNA].Visibilidades      V ON P.cod_visibilidad = V.cod_visibilidad
	 LEFT JOIN [DE_UNA].EstadosPublicacion E ON P.cod_estado = E.cod_estado
	 LEFT JOIN [DE_UNA].Rubros             R ON P.cod_rubro = R.cod_rubro
	 LEFT JOIN [DE_UNA].Tipos_Publicacion  T ON P.cod_tipo_publi = T.cod_tipo_publi
	 LEFT JOIN [DE_UNA].Usuarios           U ON P.cod_usuario = U.cod_usuario
	WHERE (U.cod_usuario     = @usuario               OR @usuario IS NULL)
	  AND (E.cod_estado    IN (@estado, @publicada)   OR @estado IS NULL)
	  AND (p.cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR (SELECT cod_Rubro FROM @rubros) IS NULL)
	  AND (P.descripcion LIKE ('%' + @descripcion + '%')      OR @descripcion IS NULL)
	ORDER BY P.cod_visibilidad
END
GO
*/


CREATE PROCEDURE [DE_UNA].[GetItems]
	-- Add the parameters for the stored procedure here
	@numFactura DECIMAL,
	@descripcionItem VARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [id_item], 
		   [num_factura],
		   [cod_item],
		   [descripcion_item],
		   [item_cantidad],
		   [item_monto]
	FROM [DE_UNA].[Items]
	WHERE [num_factura] = @numFactura AND
	      ([descripcion_item] LIKE '%' + @descripcionItem + '%' OR @descripcionItem = '')
END
GO

-- =============================================
CREATE PROCEDURE [DE_UNA].[GetDatosCabeceraFactura]
	@cod_usuario decimal (20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF ((SELECT COUNT(*) FROM [DE_UNA].Clientes WHERE [cod_usuario] = @cod_usuario) > 0 )
		BEGIN
			SELECT  C.[nombre] + ' ' + C.[apellido]
				   ,C.[dni]
				   ,U.[dir_calle] + ' ' + convert(varchar(10),U.[dir_nro]) + '. Piso: ' + isnull(convert(varchar(10),U.[dir_piso]),' -') + '. Dpto: ' + isnull(U.[dir_depto],' -') + ' ' + isnull(U.[dir_localidad],'') 
			FROM [DE_UNA].Clientes C JOIN [DE_UNA].[Usuarios] U ON C.[cod_usuario] = U.[cod_usuario]
			WHERE C.[cod_usuario] = @cod_usuario
		END
	ELSE
		BEGIN
			SELECT  E.[razon_social]
				   ,E.[cuit]
				   ,isnull([dir_ciudad],' - ')
			FROM [DE_UNA].[Empresas] E JOIN [DE_UNA].[Usuarios] U ON E.[cod_usuario] = U.[cod_usuario]
			WHERE E.[cod_usuario] = @cod_usuario
		END
END
GO

-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para llenar la grilla de Publicaciones y permitir filtrar.
-- =============================================
/* Creo un Tipo Tabla que va a ser un parametro.
CREATE TYPE [DE_UNA].Rubros AS TABLE
( cod_rubro decimal(10) );  
GO  
*/
CREATE PROCEDURE [DE_UNA].GetPublicaciones  --ConOffset
	-- Parámetros para los filtros.
	  @estado numeric(1)				-- filtro por estado de publicación
	, @rubros [DE_UNA].Rubros READONLY  -- filtro por rubros
	, @descripcion nvarchar(255)		-- filtro por descripción de publicación
	, @usuario decimal(20,0)            -- filtro pot usuario (para la opción "Mis Publicaciones")
	-- Parámetros para la paginación.
	, @PageSize int					-- Tamaño de página
	, @PageNumber int				-- Número de página
	, @TotalPags       int OUT		-- Retorno de total de páginas existentes
	, @bloqueDePaginas int OUT      -- Retorno de cantidad de páginas recuperadas
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @publicada numeric(1) = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Publicada');

	SET @TotalPags = 0;
	SET @bloqueDePaginas = 0;

    --Validación de precondiciones
	IF @PageSize < 1 OR @PageNumber < 1 
		RETURN;

	--Ajuste de cantidad de páginas
	DECLARE @TotalRegistros int = 
		  ( SELECT COUNT(*) FROM [DE_UNA].Publicaciones
			 WHERE (cod_estado    IN (@estado, @publicada)           OR @estado IS NULL)
			   AND (cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR (SELECT cod_Rubro FROM @rubros) IS NULL)
			   AND (descripcion LIKE ('%' + @descripcion + '%')      OR @descripcion IS NULL)
		  );

	IF @usuario = 0
		SET @usuario = null

	IF @TotalRegistros = 0
	    SET @TotalPags = 0
	ELSE IF @TotalRegistros % @PageSize = 0
	    SET @TotalPags = @TotalRegistros / @PageSize
	ELSE
	    SET @TotalPags = (@TotalRegistros / @PageSize) + 1

	--Registros paginados y filtrados
    DECLARE @desplazamiento int =  (@PageSize * (@PageNumber - 1)) 
    
	--IF @desplazamiento + @PageSize * 10 > @TotalPags
		SET @bloqueDePaginas = @PageSize * 10

	SELECT 
		   P.cod_publi
		  ,P.descripcion
		  ,P.stock
		  ,P.fecha_inicio
		  ,P.fecha_vencimiento
		  ,P.precio_producto
		  ,P.cod_visibilidad
		  ,V.descripcion AS visibilidad
		  ,V.costo_publicar
		  ,V.costo_publicar
		  ,V.porcentaje_venta
		  ,P.cod_estado
		  ,E.descripcion AS estado
		  ,P.cod_rubro
		  ,R.desc_corta
		  ,R.desc_larga
		  ,P.cod_usuario
		  ,U.username
		  ,P.cod_tipo_publi
		  ,T.descripcion AS tipo_publi
		  ,P.con_envio
		  ,P.con_preguntas
		  ,P.fecha_finalizacion
	FROM [DE_UNA].Publicaciones P
	 LEFT JOIN [DE_UNA].Visibilidades      V ON P.cod_visibilidad = V.cod_visibilidad
	 LEFT JOIN [DE_UNA].EstadosPublicacion E ON P.cod_estado      = E.cod_estado
	 LEFT JOIN [DE_UNA].Rubros             R ON P.cod_rubro       = R.cod_rubro
	 LEFT JOIN [DE_UNA].Tipos_Publicacion  T ON P.cod_tipo_publi  = T.cod_tipo_publi
	 LEFT JOIN [DE_UNA].Usuarios           U ON P.cod_usuario     = U.cod_usuario
	WHERE (U.cod_usuario     = @usuario               OR 
		  (@usuario IS NULL AND P.cod_estado != 2 /* Borrador */ AND @usuario IS NULL AND P.cod_estado != 5 /* Finalizada */ ))
	  AND (E.cod_estado    IN (@estado, @publicada)   OR @estado IS NULL)
	  AND (p.cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR (SELECT cod_Rubro FROM @rubros) IS NULL)
	  AND (P.descripcion LIKE ('%' + @descripcion + '%')      OR @descripcion IS NULL)
	ORDER BY IIF(@usuario IS NULL, P.cod_visibilidad, P.cod_estado)
	OFFSET @desplazamiento ROWS FETCH NEXT @bloqueDePaginas ROWS ONLY;

END
GO

CREATE PROCEDURE [DE_UNA].[GetFacturas]
	@TablaNrosFacturas [DE_UNA].[ListaNrosFacturas] READONLY,
	@usuario DECIMAL(20),
	@fechaDesde DATETIME,
	@fechaHasta DATETIME,
	@montoMinimo NUMERIC (18,2),
	@montoMaximo NUMERIC (18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (SELECT 1 FROM @TablaNrosFacturas WHERE [nro_factura] = 0) IS NULL
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE [num_factura] IN (SELECT nro_factura FROM @TablaNrosFacturas) AND
			  ([fecha_factura] >= @fechaDesde AND [fecha_factura] <= @fechaHasta) AND
			  ([total] >= @montoMinimo AND [total] <= @montoMaximo) AND
			    @usuario = [cod_usuario]
	ELSE
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE ([fecha_factura] >= @fechaDesde AND [fecha_factura] <= @fechaHasta) AND
			  ([total] >= @montoMinimo AND [total] <= @montoMaximo) AND
			    @usuario = [cod_usuario]

END
GO

Create Trigger TR_Compras_Calif_Vendedor
  -- Trigger que actualiza la reputación del vendedor cuando se califica una compra o subasta...
  on [DE_UNA].[Compras]
  after UPDATE as
  Begin
  if update(estrellas)
		begin
			-- Verifico que no esté cambiando la calificación de una compra ya calificada
			if ( select count (*) from deleted where estrellas is not null and estrellas != 0) > 0 rollback transaction
		
			-- luego hago el update de la calificación del vendedor
			begin transaction
				update DE_UNA.Usuarios SET 
				sum_calificacion	= sum_calificacion	+ (select estrellas from inserted) --inserted tiene 1 solo registro 
			  , cant_ventas			= cant_ventas		+ 1
				where DE_UNA.Usuarios.cod_usuario = (select P.cod_usuario from Publicaciones P, inserted I where I.cod_publi = P.cod_publi)
			commit transaction
		end
  end
go

Create procedure DE_UNA.Calificar_Compra
  @id_compra	numeric(18,0)
, @estrellas	numeric(18,0)
, @desc_Calif	nvarchar(255)
as
Begin
	-- validaciones
	if @estrellas < 1 or @estrellas > 5		return 1
	if @id_compra < 1						return 1
	-- Actualizo La Calificacion en la compra
	begin transaction
	update DE_UNA.Compras SET 
				estrellas			= @estrellas
			  , desc_calificacion	= @desc_Calif
			  , cod_calificacion	= (select max(cod_calificacion) from DE_UNA.Compras) + 1
				where id_compra		= @id_compra
	commit transaction
	return 0
end
go

create function DE_UNA.fn_Ultimas_5_Compras_Calificadas(@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve sus ultimas 5 calificaciones de compras u ofertas
returns table
as 
	return (
	select top 5 * from DE_UNA.Compras C 
		where c.cod_usuario = @cod_usuario and c.cod_calificacion is not null 
		order by c.cod_calificacion desc
	)
go

CREATE function DE_UNA.fn_Cant_Compras_Por_Usuario (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve Cantidad de compras y desglose de sus calificaciones por estrellas
	returns @Calificaciones_Cliente table(
			Cant_Compras_Cliente	int, Compras_Con_5_Estrellas	int, Compras_Con_4_Estrellas	int, 
			Compras_Con_3_Estrellas	int, Compras_Con_2_Estrellas	int, Compras_Con_1_Estrella	int, Sin_Calificar int)
as 
Begin
	declare @total int, @est5 int, @est4 int, @est3 int, @est2 int, @est1 int, @sinCalif int

	set @total	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario) as Cant_Compras_Cliente);
	set @est5	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=5) as Compras_Con_5_Estrellas);
	set @est4	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=4) as Compras_Con_4_Estrellas);
	set @est3	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=3) as Compras_Con_3_Estrellas);
	set @est2	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=2) as Compras_Con_2_Estrellas);
	set @est1	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=1) as Compras_Con_1_Estrella);
	set @sinCalif= (select count(id_compra)   from DE_UNA.fn_Compras_Sin_Calificar(@cod_usuario) as Sin_Calificar);

	insert into @Calificaciones_Cliente (Cant_Compras_Cliente, Compras_Con_5_Estrellas, Compras_Con_4_Estrellas, Compras_Con_3_Estrellas, Compras_Con_2_Estrellas, Compras_Con_1_Estrella, Sin_Calificar)	
	values (@total, @est5, @est4, @est3, @est2, @est1, @sinCalif)

	return
end
go

Create function DE_UNA.fn_Compras_Sin_Calificar (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve las compras aun no calificadas.
returns table
as 
	return (
	select id_compra, cod_publi, cod_usuario, fecha_compra, monto, cantidad, isnull(cod_calificacion,0) as cod_calificacion, isnull(estrellas,0) as estrellas, desc_calificacion from DE_UNA.Compras C 
		where c.cod_usuario = @cod_usuario 
			and (c.cod_calificacion is null or c.cod_calificacion = 0) 
	)
go

Create function DE_UNA.fn_Get_Reputacion_Vendedor (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve las compras aun no calificadas.
returns decimal(18,2)
as begin
	return (select (u.sum_calificacion / u.cant_ventas) 
			from DE_UNA.Usuarios U 
			where U.cod_usuario = @cod_usuario 
			)
	end
go

CREATE PROCEDURE [DE_UNA].GetHistorial
@cod_usuario decimal(20,0)
AS
BEGIN
	SET NOCOUNT ON;
	select * from (
	SELECT C.cod_publi as Publicacion
		 , P.descripcion as Detalle
		 , T.descripcion as Tipo
		 , C.fecha_compra as Fecha
		 , C.monto as Monto
		 , IIF(isnull(C.estrellas,0)>0,CONVERT(varchar(30),C.estrellas)+' Estrellas','Compra Aun No Calificada') as Calificacion
	  FROM [DE_UNA].Compras C, DE_UNA.Tipos_Publicacion T, Publicaciones P
	  where C.cod_usuario = @cod_usuario
		and T.cod_tipo_publi = P.cod_tipo_publi
		and P.cod_publi = C.cod_publi

	union 

	SELECT O.cod_publi as Publicacion
		 , P.descripcion as Detalle
		 , T.descripcion as Tipo
		 , O.fecha_oferta as Fecha
		 , O.monto as Monto
		 , IIF(exists (select 1 from Compras C where c.cod_publi = O.cod_publi and C.cod_usuario = @cod_usuario and C.monto = O.monto),'Oferta Ganadora','Oferta No Ganadora') as Calificacion
	  FROM DE_UNA.Tipos_Publicacion T, Publicaciones P, Ofertas O
	  where O.cod_usuario    = @cod_usuario
		and T.cod_tipo_publi = P.cod_tipo_publi
		and O.cod_publi      = P.cod_publi

		) as OfertasYCompras
		order by 4 desc
END
go

CREATE PROCEDURE DE_UNA.GetOfertasUsuario
@cod_usuario decimal(20,0)
as
begin
	select * from DE_UNA.Ofertas where (cod_usuario = @cod_usuario or @cod_usuario is null)
end
go

CREATE PROCEDURE [DE_UNA].[EliminarUsuario] 
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal (12,0),
	@fecha_actual datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [DE_UNA].Usuarios SET fecha_baja = @fecha_actual WHERE cod_usuario = @cod_usuario
	SELECT 1
END

GO

CREATE PROCEDURE [DE_UNA].[EliminarVisibilidad] 
	@cod_visibilidad  numeric(18,0)
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		delete from Visibilidades
			where cod_visibilidad	= @cod_visibilidad;
	END TRY
	BEGIN CATCH
		SELECT 
 			 ERROR_NUMBER()		AS ErrorNumber
			,ERROR_SEVERITY()	AS ErrorSeverity
			,ERROR_STATE()		AS ErrorState
			,ERROR_PROCEDURE()	AS ErrorProcedure
			,ERROR_LINE()		AS ErrorLine
			,ERROR_MESSAGE()	AS ErrorMessage;

		IF @@TRANCOUNT > 0 	ROLLBACK TRANSACTION;
		return 1;
	END CATCH;

	IF @@TRANCOUNT > 0 		COMMIT TRANSACTION;
	return 0;
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[Login]
	-- Add the parameters for the stored procedure here
	@username nvarchar(50), 
	@password varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @temp_pass varbinary(100)
	(SELECT @temp_pass = U.[password]
		FROM [DE_UNA].[Usuarios] U
		WHERE U.username = @username 
			AND U.fecha_baja IS NULL
			AND U.activo = 1
			AND U.[password] = HASHBYTES('SHA2_256', @password))


	IF(@temp_pass IS NOT NULL AND @temp_pass <> HASHBYTES('SHA2_256', @password))
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = login_fallidos + 1, activo=IIF(login_fallidos+1>=3, 0, 1)
		WHERE username = @username
		SELECT 0
	END
	ELSE IF(@temp_pass IS NOT NULL)
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = 0, activo=1
		WHERE username = @username
		SELECT 1
	END
	ELSE
		SELECT -1
END
GO

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

CREATE PROCEDURE [DE_UNA].[DesbloquearUsuario]
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(20,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Usuarios SET activo=1, login_fallidos=0 WHERE cod_usuario=@cod_usuario

	select 1
END

GO

CREATE PROCEDURE [DE_UNA].[SetRolInactivo]
	-- Add the parameters for the stored procedure here
	@cod_rol decimal
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [DE_UNA].Roles SET activo=0 WHERE cod_rol = @cod_rol

	SELECT cod_rol FROM [DE_UNA].Roles WHERE cod_rol = @cod_rol
END
GO

-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 02/07/2016
-- Description:	SP para obtener los roles de un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].DatosUsuarioLogueado
	-- Add the parameters for the stored procedure here
	@username nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_usuario
		 , activo
		 , CASE 
			WHEN (SELECT 1 FROM [DE_UNA].Empresas E WHERE E.cod_usuario = U.cod_usuario) IS NOT NULL THEN
				1
		   ELSE
		        0
		   END AS esEmpresa
		 , ISNULL(publ_sin_cargo,0) AS publ_sin_cargo
	FROM [DE_UNA].Usuarios U
	 --JOIN [DE_UNA].Roles R ON R.cod_rol = RU.cod_rol
	WHERE username = @username
END
GO

-- Description:	SP para buscar Items por detalle de Descripcion.
CREATE PROCEDURE [DE_UNA].BuscarXdetalle
	-- Parámetros para los filtros.
	@cod_usuario decimal(10),
	@descripcion nvarchar(30)
AS
BEGIN


	SELECT I.num_factura
	  FROM [DE_UNA].Items I
	   JOIN [DE_UNA].Facturas F ON I.num_factura = F.num_factura
	   WHERE F.cod_usuario = @cod_usuario AND
			 (I.descripcion_item LIKE '%' + @descripcion + '%' OR @descripcion = '')
END
GO

CREATE PROCEDURE [DE_UNA].GenerarCompra
	  @cod_publi numeric(18,0)
	, @cantidad  int
	, @fecha     datetime
AS
BEGIN
	declare @id_compra numeric(18,0) = NULL;

	BEGIN TRAN COMPRA
		declare @precio_producto numeric(18,2)
		declare @stock numeric(18,2)
		declare @monto numeric(18,2)
		declare @num_factura numeric(18,0) = 0
		declare @tiene_envio bit
		declare @cod_usuario decimal(20,0)

		SELECT @precio_producto = precio_producto, @stock = stock,
			   @monto = precio_producto, @cod_usuario = cod_usuario
		  FROM [DE_UNA].Publicaciones
		 WHERE cod_publi = @cod_publi

		--Inserta Compra
		INSERT INTO [DE_UNA].Compras (cod_publi, cod_usuario, fecha_compra, monto, cantidad, cod_calificacion, estrellas, desc_calificacion)
			         VALUES(@cod_publi, @cod_usuario, @fecha, @monto, @cantidad, NULL, NULL, NULL)
		
		IF (@stock - @cantidad) >= 0
		  BEGIN
			--Descuenta Stock
			set @id_compra = @@IDENTITY;
			UPDATE [DE_UNA].Publicaciones
			   SET stock = stock - @cantidad
		  END
		ELSE
			ROLLBACK TRANSACTION COMPRA;

	COMMIT TRAN COMPRA
	
	RETURN SELECT * FROM DE_UNA.Compras WHERE id_compra = @id_compra;
END
GO

-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una compra.
-- RETORNA: 0 --> No hay Stock.
--          1 --> Ejecución OK.
-- =============================================
CREATE PROCEDURE [DE_UNA].NuevaCompra
	-- PARAMETROS:
	@cod_publi numeric(18, 0),
	@cod_usuario decimal(20, 0),
	@fecha_compra datetime,
	@monto numeric(18, 2),
	@cantidad numeric(18, 0),
	@cod_calificacion numeric(18, 0),
	@estrellas numeric(18, 0),
	@desc_calificacion nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @stock numeric(18,0) = (SELECT stock FROM [DE_UNA].Publicaciones WHERE cod_publi = @cod_publi);

	IF (@stock IS NULL OR @stock < 1)
		RETURN 0;
	BEGIN TRAN COMPRA
		INSERT INTO [DE_UNA].Compras
			VALUES(@cod_publi, @cod_usuario, @fecha_compra, @monto, @cantidad, @cod_calificacion, @estrellas, @desc_calificacion);
		
		--Actualizo la cantidad en la publicación
		UPDATE [DE_UNA].Publicaciones SET stock = (stock - @cantidad) WHERE cod_publi = @cod_publi

		--Cambia estado de una publicacion a finalizada LMoglia 08072016
		IF((@stock - @cantidad) = 0)
			UPDATE [DE_UNA].Publicaciones SET cod_estado = 5, fecha_finalizacion = GETDATE() WHERE cod_publi = @cod_publi;
	COMMIT TRAN COMPRA
	RETURN 1;
END
GO

CREATE PROCEDURE [DE_UNA].[GenerarFactura]
	  @cod_publi numeric(18,0)
	, @cantidad int
	, @fecha datetime
AS
BEGIN
	declare @num_factura numeric(18,0) = 0

	BEGIN TRAN FACT
		declare @precio_producto numeric(18,2)
		declare @comision numeric(18,2)
		declare @envio numeric(18,2)
		
		declare @tiene_envio bit
		declare @cod_usuario decimal(20,0)
		declare @ya_facturada bit

		SELECT @precio_producto = P.precio_producto, 
			   @comision = IIF(@cantidad != 0, V.porcentaje_venta, V.costo_publicar),
			   @envio = V.costo_envio, @tiene_envio = P.con_envio, @cod_usuario = P.cod_usuario
		  FROM [DE_UNA].Publicaciones P
		  JOIN [DE_UNA].Visibilidades V ON P.cod_visibilidad = V.cod_visibilidad
		 WHERE P.cod_publi = @cod_publi

		--Obtener numero de factura a insertar
		SELECT TOP 1 @num_factura = num_factura + 1 FROM Facturas ORDER BY num_factura DESC

		IF @cantidad != 0 /* Es comisión por venta. */
		  BEGIN
			--Inserta factura
			INSERT INTO Facturas
				VALUES (@num_factura, @cod_publi, @fecha, ((@comision * 100)/@precio_producto) + IIF(@tiene_envio = 1, @envio, 0), 'Efectivo', @cod_usuario)

			--Inserta item
			INSERT INTO Items
				VALUES (@num_factura, 2, 'Comision venta', @cantidad, @cantidad * @precio_producto)

			--Si tiene envio, inserta item por envío
			IF @tiene_envio = 1
				INSERT INTO Items
					VALUES (@num_factura, 3, 'Envío', 1, @envio)
		  END
		ELSE /* Es comisión por Publicar. */
		  BEGIN
			--Busca Si la publicación ya fue facturada. Busca un Item codigo 1, (descripción: 'Costo por publicar')
			SET @ya_facturada = IIF(
				EXISTS(SELECT F.num_factura FROM DE_UNA.Facturas F 
				  JOIN DE_UNA.Items I ON I.num_factura = F.num_factura
				 WHERE F.cod_publi = @cod_publi
				   AND I.cod_item = 1 /*'Costo por publicar'*/), 1, 0)
			
			IF @ya_facturada = 0 /* No fue facturada. */
			  BEGIN
				--Inserta factura
				INSERT INTO Facturas
					VALUES (@num_factura, @cod_publi, @fecha, @comision, 'Efectivo', @cod_usuario)

				--Inserta item
				INSERT INTO Items
					VALUES (@num_factura, 1, 'Costo por publicar', @cantidad, @cantidad)
			  END
			ELSE /* Ya fue facturada. (Sería una Publicación reactivada.) */
				SET @num_factura = 0
		  END
	COMMIT TRAN FACT
	
	RETURN @num_factura;
END
GO

CREATE PROCEDURE [DE_UNA].[FinalizaPublicaciones] 
@hoy datetime
AS
BEGIN
-- ((1)) -- Identificar las Subastas Activas que finalizan hoy.
	select P.cod_publi, P.fecha_vencimiento, P.cod_estado, P.cod_tipo_publi
	INTO   #Publicaciones_Finalizando
	from   [DE_UNA].[Publicaciones] P
	where  P.cod_tipo_publi		= (SELECT cod_tipo_publi FROM [DE_UNA].Tipos_Publicacion WHERE descripcion = 'Subasta')
		and (p.cod_estado		= (SELECT cod_estado FROM [DE_UNA].[EstadosPublicacion] WHERE descripcion = 'Publicada') 
		or p.cod_estado			= (SELECT cod_estado FROM [DE_UNA].[EstadosPublicacion] WHERE descripcion = 'Activa') 
		)    -- subastas activas
       and cast(p.fecha_vencimiento as date) = cast(@hoy As Date)    -- Que finalizan hoy

-- ((2)) -- Cambiar su estado a Finalizada.
	UPDATE [DE_UNA].[Publicaciones]
	SET cod_estado = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Finalizada')
	    , fecha_finalizacion = @hoy
	FROM #Publicaciones_Finalizando PF, [DE_UNA].[Publicaciones] P
	where PF.cod_publi = P.cod_publi

-- ((3)) -- Identificar sus respectivas Ofertas para tomar la última como Compra.
INSERT INTO [DE_UNA].Compras(cod_publi, cod_usuario, fecha_compra, monto)
select O1.cod_publi, O1.cod_usuario, O1.fecha_oferta as fecha_compra, O1.monto 
	from [DE_UNA].[Ofertas] O1, #Publicaciones_Finalizando PF
	where monto = (select max(monto) from [DE_UNA].[Ofertas] O2
						where O2.cod_publi = O1.cod_publi
						) and O1.cod_publi = PF.cod_publi

-- ((4)) -- Finalizar Publicaciones de compra inmedita que vencen hoy.
	UPDATE [DE_UNA].[Publicaciones]
	SET cod_estado = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Finalizada')
	  , fecha_finalizacion = @hoy
	FROM [DE_UNA].[Publicaciones] P
	where P.cod_tipo_publi		= (SELECT cod_tipo_publi FROM [DE_UNA].Tipos_Publicacion WHERE descripcion = 'Compra Inmediata')
		and (p.cod_estado		= (SELECT cod_estado FROM [DE_UNA].[EstadosPublicacion] WHERE descripcion = 'Publicada') 
		  or p.cod_estado		= (SELECT cod_estado FROM [DE_UNA].[EstadosPublicacion] WHERE descripcion = 'Activa')  )  
		and cast(p.fecha_vencimiento as date) = cast(@hoy As Date)  -- que finaliza HOY

-- ((5)) -- Facturar Subastas Finalizadas y Ofertadas.
	-- Acá va el cursor que recorre la tabla temporal creada en (1) y por cada Publicación Subasta 
	-- que tenga una compra asociada en la tabla compras, llama al SP GenerarFactura

	DECLARE publicaciones_cursor CURSOR FOR SELECT  PF.cod_publi FROM #Publicaciones_Finalizando PF
	DECLARE   @cod_publi			numeric(18,0)
	
	OPEN publicaciones_cursor
	FETCH NEXT FROM publicaciones_cursor INTO @cod_publi

	PRINT 'Facturando Subastas Finaliadas Hoy'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		if exists (select 1 from DE_UNA.Compras C where C.cod_publi = @cod_publi)
			exec DE_UNA.GenerarFactura @cod_publi = @cod_publi, @cantidad = 1, @fecha =@hoy
		FETCH NEXT FROM publicaciones_cursor INTO @cod_publi
	END 

	CLOSE publicaciones_cursor;
	DEALLOCATE publicaciones_cursor;

	PRINT '----- Fin SP FinalizaPublicaciones -----';
end
GO

CREATE PROCEDURE [DE_UNA].[NuevaEmpresa]
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(18,0),
	@razon_social nvarchar(255),
	@dir_ciudad nvarchar(50),
	@nombre_contacto nvarchar(255),
	@rubro decimal(10),
	@cuit nvarchar(50),
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
	@fecha_actual datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@cod_usuario = 0)
	BEGIN
		INSERT INTO [DE_UNA].[Usuarios]
		VALUES(0,@username,HASHBYTES('SHA2_256', @password),1,@mail,@telefono,@dir_calle,@dir_nro,@dir_piso,@dir_depto,@dir_localidad,@dir_cod_post,null, @fecha_actual, null, 1, 0, 0)

		INSERT INTO [DE_UNA].[Empresas]
		VALUES(IDENT_CURRENT('DE_UNA.[Usuarios]'),@cuit,@razon_social,@dir_ciudad,@nombre_contacto,@rubro)
	
		SELECT 1	
	END
	ELSE
	BEGIN
		UPDATE Usuarios SET
		 	  mail = @mail
			, username = @username
			, [password] = HASHBYTES('SHA2_256', @password)
			, activo = @activo
			, telefono = @telefono
			, dir_calle = @dir_calle
			, dir_nro = @dir_nro
			, dir_piso = @dir_piso
			, dir_depto = @dir_depto
			, dir_localidad = @dir_localidad
			, dir_cod_post = @dir_cod_post
		WHERE cod_usuario = @cod_usuario

		UPDATE Empresas SET
			razon_social = @razon_social,
			dir_ciudad = @dir_ciudad,
			nombre_contacto = @nombre_contacto,
			cod_rubro = @rubro,
			cuit = @cuit
		WHERE cod_usuario = @cod_usuario

		SELECT 1
	END		
END
GO

CREATE PROCEDURE [DE_UNA].[NuevoCliente]
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal(18,0),
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
	@fecha_nacimiento datetime,
	@fecha_actual datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@cod_usuario = 0)
	BEGIN
		INSERT INTO [DE_UNA].[Usuarios]
		VALUES(0,@username,HASHBYTES('SHA2_256', @password),1,@mail,@telefono,@dir_calle,@dir_nro,@dir_piso,@dir_depto,@dir_localidad,@dir_cod_post,@fecha_nacimiento,@fecha_actual, NULL,1,0,0)

		INSERT INTO [DE_UNA].[Clientes]
		VALUES(IDENT_CURRENT('DE_UNA.Usuarios'),@nombre,@apellido,@dni,@documento_tipo)

		SELECT 1	
	END
	ELSE
	BEGIN
		UPDATE Usuarios SET
		 	  mail = @mail
			, username = @username
			, [password] = HASHBYTES('SHA2_256', @password)
			, activo = @activo
			, telefono = @telefono
			, dir_calle = @dir_calle
			, dir_nro = @dir_nro
			, dir_piso = @dir_piso
			, dir_depto = @dir_depto
			, dir_localidad = @dir_localidad
			, dir_cod_post = @dir_cod_post
			, fecha_nacimiento = @fecha_nacimiento
		WHERE cod_usuario = @cod_usuario

		UPDATE [DE_UNA].[Clientes] SET
			nombre = @nombre
			, apellido = @apellido
			, dni = @dni
			, documento_tipo = @documento_tipo
		WHERE cod_usuario = @cod_usuario

		SELECT 1
	END		
END
GO

-- ==========================================================================================
-- Author:		Lucas Moglia
-- Create date: 10-07-2016
-- Description:	Vendedores con mayor monto facturado dentro de un mes y año particular.
-- ==========================================================================================
CREATE PROCEDURE [DE_UNA].[ReporteMayorMontoFacturado]
	-- Add the parameters for the stored procedure here
	@mes varchar(2),
	@anio varchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5
	IIF(c.dni IS NULL, E.razon_social, c.Nombre + c.Apellido) as 'nombre'
	, (SELECT SUM(total) 
	   FROM DE_UNA.Facturas F2 
	   WHERE F2.cod_usuario = F.cod_usuario
	   AND MONTH(F2.fecha_factura) = @mes 
	   AND YEAR(F2.fecha_factura) = @anio) as 'monto'
	FROM DE_UNA.Facturas F
			LEFT JOIN DE_UNA.Empresas E
				ON F.cod_usuario = E.cod_usuario 
			LEFT JOIN DE_UNA.Clientes c
				ON F.cod_usuario = c.cod_usuario 
	WHERE MONTH(F.fecha_factura) = @mes AND YEAR(F.fecha_factura) = @anio
	GROUP BY F.cod_usuario, c.dni , E.razon_social, c.Nombre, c.Apellido
	ORDER BY (SELECT SUM(total) 
		   FROM DE_UNA.Facturas F2 
		   WHERE F2.cod_usuario = F.cod_usuario
		   AND MONTH(F2.fecha_factura) = @mes 
		   AND YEAR(F2.fecha_factura) = @anio) desc
END
GO

-- ==========================================================================================
-- Author:		Lucas Moglia
-- Create date: 10-07-2016
-- Description:	Vendedores con mayor cantidad de facturas dentro de un mes y año particular
-- ==========================================================================================
CREATE PROCEDURE DE_UNA.ReporteMayorCantidadFacturas
	-- Add the parameters for the stored procedure here
	 @mes varchar(2),
	 @anio varchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5
		IIF(CL.dni IS NULL, E.razon_social, CL.Nombre + CL.Apellido) as 'nombre'
		, ( SELECT COUNT(num_factura) 
			FROM DE_UNA.Facturas F2 
			WHERE F2.cod_usuario = F.cod_usuario
				AND MONTH(F2.fecha_factura) = @mes 
				AND YEAR(F2.fecha_factura) = @anio) as 'monto'
	FROM DE_UNA.Facturas F
		LEFT JOIN DE_UNA.Empresas E
			ON F.cod_usuario = E.cod_usuario 
			LEFT JOIN DE_UNA.Clientes CL
				ON F.cod_usuario = CL.cod_usuario 
	WHERE MONTH(F.fecha_factura) = @mes AND YEAR(F.fecha_factura) = @anio
	GROUP BY F.cod_usuario, CL.dni , E.razon_social, CL.Nombre, CL.Apellido
	ORDER BY ( SELECT COUNT(num_factura) 
			FROM DE_UNA.Facturas F2 
			WHERE F2.cod_usuario = F.cod_usuario
				AND MONTH(F2.fecha_factura) = @mes 
				AND YEAR(F2.fecha_factura) = @anio) desc
END
GO

-- ==============================================================================================
-- Author:		Lucas Moglia
-- Create date: 10-07-2016
-- Description:	Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de
--				un rubro particular
-- ==============================================================================================
CREATE PROCEDURE DE_UNA.ReporteMayorCantProdComprados
	-- Add the parameters for the stored procedure here
	@mes varchar(2),
	@anio varchar(4),
	@rubro decimal(10,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5
		IIF(CL.dni IS NULL, E.razon_social, CL.Nombre + CL.Apellido) as 'nombre'
		, ISNULL((SELECT SUM(cantidad) 
			FROM DE_UNA.Compras C2 
			WHERE C2.cod_usuario = C.cod_usuario
			AND MONTH(C2.fecha_compra) = @mes 
			AND YEAR(C2.fecha_compra) = @anio
			AND C2.cod_publi IN (SELECT P3.cod_publi FROM DE_UNA.Publicaciones P3 WHERE P3.cod_rubro = @rubro)),0) as 'monto'
	FROM DE_UNA.Compras C
		LEFT JOIN DE_UNA.Empresas E
			ON C.cod_usuario = E.cod_usuario 
		LEFT JOIN DE_UNA.Clientes CL
			ON C.cod_usuario = CL.cod_usuario 
		JOIN DE_UNA.Publicaciones P
			ON C.cod_publi = P.cod_publi
				AND (P.cod_rubro = @rubro OR @rubro = 0)
			
	GROUP BY C.cod_usuario, CL.dni , E.razon_social, CL.Nombre, CL.Apellido
	ORDER BY (SELECT SUM(cantidad) 
			FROM DE_UNA.Compras C2 
			WHERE C2.cod_usuario = C.cod_usuario
			AND MONTH(C2.fecha_compra) = @mes 
			AND YEAR(C2.fecha_compra) = @anio
			AND C2.cod_publi IN (SELECT P3.cod_publi FROM DE_UNA.Publicaciones P3 WHERE P3.cod_rubro = @rubro)) desc
END
GO

-- =======================================================================================================================================
-- Author:		Lucas Moglia
-- Create date: 11-07-2016 01:42 =/
-- Description:	mostrar el nombre de los 5 vendedores con mayor cantidad de productos no vendidos.
--				El tipo de visibilidad a mostrar, lo selecciona el usuario del filtro y las publicaciones a considerar 
--				son aquellas finalizadas en el trimestre seleccionado.
--				En el caso que el vendedor tenga más de una publicación es la sumatoria de las unidades no vendidas.
	--Por ejemplo:

	--Filtro Fechas - Opciones: 1er Tri 2015 - 2er Tri 2015- 3er Tri 2015- 4to Tri 2015 - 1er Tri 2016- 2do Tri 2016...

	--Filtro Visibilidad - Opciones: Oro-Bronce-Plata-Gratis

	--Listado Vendedores ( Resultado)
	--Fabrizio Toro
	--Paz Heli
	--Bustamante Krin
	--Razon Social Nº:7
	--Razon Social Nº:8
-- =======================================================================================================================================
CREATE PROCEDURE DE_UNA.ReporteMayorCantProdNoVendidos 
	-- Add the parameters for the stored procedure here
	@trimestre int, --Numero de trimestre a consultar 1/2/3/4
	@anio varchar(4), --Año
	@visibilidad numeric(18,0) = 0 --Una visibilidad para filtrar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @k int
	SET @k=-1

	--0 - 1 - 2 - 3   INDICE (2X)
	--1 - 2 - 3 - 4   TRIMESTRES
	--1 - 4 - 7 - 10  MES DESDE 
	--3 - 6 - 9 - 12  MES HASTA
	DECLARE @mes_desde varchar(2)
	SET @mes_desde = @trimestre + (2*(@trimestre + @k))
	DECLARE @mes_hasta varchar(2)
	SET @mes_hasta = @mes_desde + 2 

	SELECT TOP 5
		IIF(c.dni IS NULL, E.razon_social, c.Nombre + c.Apellido) as 'nombre'
		, (SELECT SUM(stock) 
		   FROM DE_UNA.Publicaciones P2
		   WHERE P2.cod_usuario = P.cod_usuario 
		   AND P2.stock > 0	
		   AND MONTH(P2.[fecha_finalizacion]) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P2.[fecha_finalizacion]) = @anio
		   AND (P2.cod_visibilidad = @visibilidad OR @visibilidad = 0)) as 'monto'

	FROM DE_UNA.Publicaciones P
		LEFT JOIN DE_UNA.Empresas E
			ON P.cod_usuario = E.cod_usuario 
		LEFT JOIN DE_UNA.Clientes c
			ON P.cod_usuario = c.cod_usuario 
	WHERE  P.stock > 0	
		   AND MONTH(P.[fecha_finalizacion]) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P.[fecha_finalizacion]) = @anio
		   AND (P.cod_visibilidad = @visibilidad OR @visibilidad = 0)

	GROUP BY P.cod_usuario, c.dni , E.razon_social, c.Nombre, c.Apellido
	ORDER BY (SELECT SUM(stock) 
		   FROM DE_UNA.Publicaciones P2
		   WHERE P2.cod_usuario = P.cod_usuario 
		   AND P2.stock > 0	
		   AND MONTH(P2.[fecha_finalizacion]) BETWEEN @mes_desde AND @mes_hasta
		   AND YEAR(P2.[fecha_finalizacion]) = @anio
		   AND (P2.cod_visibilidad = @visibilidad OR @visibilidad = 0)) desc
END
GO

CREATE PROCEDURE [DE_UNA].[DropTables] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF OBJECT_ID('DE_UNA.Items', 'U')				IS NOT NULL DROP TABLE DE_UNA.Items; 
	IF OBJECT_ID('DE_UNA.Facturas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Facturas;
	IF OBJECT_ID('DE_UNA.Ofertas', 'U')				IS NOT NULL DROP TABLE DE_UNA.Ofertas; 
	IF OBJECT_ID('DE_UNA.Compras', 'U')				IS NOT NULL DROP TABLE DE_UNA.Compras; 
	IF OBJECT_ID('DE_UNA.Publicaciones', 'U')		IS NOT NULL DROP TABLE DE_UNA.Publicaciones; 
	IF OBJECT_ID('DE_UNA.Tipos_Publicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.Tipos_Publicacion; 
	IF OBJECT_ID('DE_UNA.EstadosPublicacion', 'U')	IS NOT NULL DROP TABLE DE_UNA.EstadosPublicacion; 
	IF OBJECT_ID('DE_UNA.Visibilidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Visibilidades; 
	IF OBJECT_ID('DE_UNA.Empresas', 'U')			IS NOT NULL DROP TABLE DE_UNA.Empresas; 
	IF OBJECT_ID('DE_UNA.Clientes', 'U')			IS NOT NULL DROP TABLE DE_UNA.Clientes; 
	IF OBJECT_ID('DE_UNA.Rubros', 'U')				IS NOT NULL DROP TABLE DE_UNA.Rubros; 
	IF OBJECT_ID('DE_UNA.Roles_Usuario', 'U')		IS NOT NULL DROP TABLE DE_UNA.Roles_Usuario; 
	IF OBJECT_ID('DE_UNA.Func_por_Rol', 'U')		IS NOT NULL DROP TABLE DE_UNA.Func_por_Rol; 
	IF OBJECT_ID('DE_UNA.Funcionalidades', 'U')		IS NOT NULL DROP TABLE DE_UNA.Funcionalidades; 
	IF OBJECT_ID('DE_UNA.Roles', 'U')				IS NOT NULL DROP TABLE DE_UNA.Roles; 
	IF OBJECT_ID('DE_UNA.Usuarios', 'U')			IS NOT NULL DROP TABLE DE_UNA.Usuarios;
END
GO

