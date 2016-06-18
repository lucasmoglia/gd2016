USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SCHEMA [DE_UNA]
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
CREATE PROCEDURE [DE_UNA].[CrearTablas]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

-- ( 1)
	CREATE TABLE [DE_UNA].[Usuarios](
		[cod_usuario]		[decimal](20, 0) IDENTITY PRIMARY KEY,
		[login_fallidos]	[decimal](1, 0)		NULL DEFAULT(0),
		[username]			[nvarchar](50)      NULL,
		[password]			[nvarchar](100)		NULL,
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
		[publ_sin_cargo]	[bit]				NULL,
		[cant_ventas]		[numeric](18, 0)	NULL DEFAULT(0),
		[sum_calificacion]	[numeric](18, 0)	NULL DEFAULT(0)
	) ON [PRIMARY]

-- ( 2)
	CREATE TABLE [DE_UNA].[Roles](
		[cod_rol]			[decimal](10, 0) 	PRIMARY KEY,
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
		[con_preguntas]		[bit]				NULL DEFAULT 0
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
	VALUES ('admin', HASHBYTES('SHA2_256', 'admin'), GETDATE(), 1);

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

	INSERT INTO [DE_UNA].[Compras]
		 SELECT M.[Publicacion_Cod]
			  , C.[cod_usuario]
	 		  , M.[Compra_fecha]
			  , M.[Publicacion_Precio]
			  , M.[Compra_Cantidad]
			  , M.[Calificacion_Codigo]
			  , M.[Calificacion_Cant_Estrellas]
			  , M.[Calificacion_Descripcion]
		   FROM [gd_esquema].[Maestra] M
			JOIN [DE_UNA].[Clientes] C ON M.[cli_dni] = C.[dni]
		  WHERE [Compra_fecha] IS NOT NULL
		  ORDER BY M.[Publicacion_Cod], C.[cod_usuario];

	PRINT '----- Tabla de Compras, Migrada -----';

END
GO

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

EXECUTE [DE_UNA].[DropTables];
GO
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
