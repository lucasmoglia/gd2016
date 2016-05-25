USE [GD1C2016]
GO
/****** Object:  User [gd]    Script Date: 25/5/2016 2:32:22 p. m. ******/
CREATE USER [gd] FOR LOGIN [gd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[CrearTablas]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 15/05/2016
-- Description:	Procedimiento para crear todas las tablas del DER para la migración.
-- =============================================
CREATE PROCEDURE [dbo].[CrearTablas](@param bit)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	CREATE TABLE [Facturas] (
	  [num_factura] numeric(18),
	  [cod_publi] numeric(18),
	  [fecha_factura] datetime,
	  [total] numeric(18,2),
	  [forma_pago] nvarchar(255),
	  PRIMARY KEY ([num_factura])
	);

	CREATE INDEX [FK] ON  [Facturas] ([cod_publi]);

	CREATE TABLE [Empresas] (
	  [cod_usuario] decimal(20),
	  [cuit] nvarchar(50),
	  [razon_social] nvarchar(255),
	  [dir_ciudad] varchar(50),
	  [nombre_contacto] varchar(255),
	  [rubro_empresa] varchar(255)
	);

	CREATE INDEX [PK / FK] ON  [Empresas] ([cod_usuario]);

	CREATE TABLE [Historica] (
	  [cod_comprador] decimal(20),
	  [cod_publi] numeric(18),
	  [fecha_oferta] datetime,
	  [monto_ofertado] numeric(18,2),
	  [calificacion] numeric(18,0),
	  [desc_calificacion] nvarchar(255),
	  [cantidad_comprada] numeric(18,0),
	  [usuario_ganador] decimal(20)
	);

	CREATE INDEX [PK / FK] ON  [Historica] ([cod_comprador], [cod_publi], [fecha_oferta]);

	CREATE TABLE [EstadosPublicacion] (
	  [cod_estado] numeric(1),
	  [descripcion] nvarchar(255),
	  PRIMARY KEY ([cod_estado])
	);

	CREATE TABLE [Items] (
	  [cod_item] numeric(1),
	  [descripcion_item] varchar(30),
	  [item_monto] numeric(18,2),
	  PRIMARY KEY ([cod_item])
	);

	CREATE TABLE [Visibilidades] (
	  [cod_visibilidad] numeric(18,0),
	  [descripcion] nvarchar(255),
	  [costo_publicar] numeric(18,2),
	  [porcentaje_venta] numeric(18,2),
	  [costo_envio] numeric(18,2),
	  PRIMARY KEY ([cod_visibilidad])
	);

	CREATE TABLE [Usuarios] (
	  [cod_usuario] decimal(20) IDENTITY(1,1) NOT NULL,
	  [nombre] nvarchar(255),
	  [cod_rol] decimal(10),
	  [login_fallidos] decimal(1),
	  [password] nvarchar(100),
	  [activo] bit,
	  [mail] nvarchar(255),
	  [telefono] varchar(100),
	  [dir_calle] nvarchar(255),
	  [dir_nro] numeric(18,0),
	  [dir_piso] numeric(18,0),
	  [dir_depto] nvarchar(50),
	  [dir_localidad] nvarchar(100),
	  [dir_cod_post] nvarchar(50),
	  [fecha_nacimiento] datetime,
	  [fecha_alta] datetime,
	  [publ_sin_cargo] bit,
	  [cant_ventas] numeric(18),
	  [sum_calificacion] numeric(18),
	  PRIMARY KEY ([cod_usuario])
	);

	CREATE INDEX [FK] ON  [Usuarios] ([cod_rol]);

	CREATE TABLE [Administradores] (
	  [cod_usuario] decimal(20)
	);

	CREATE INDEX [FK] ON  [Administradores] ([cod_usuario]);

	CREATE TABLE [Perfiles] (
	  [cod_funcionalidad] decimal(10),
	  [cod_rol] decimal(10)
	);

	CREATE INDEX [PK FK] ON  [Perfiles] ([cod_funcionalidad], [cod_rol]);

	CREATE TABLE [Clientes] (
	  [cod_usuario] decimal(20),
	  [nombre] nvarchar(255),
	  [apellido] nvarchar(255),
	  [dni] numeric(18,0),
	  [documento_tipo] varchar(10)
	);

	CREATE INDEX [PK / FK] ON  [Clientes] ([cod_usuario]);

	CREATE TABLE [Rubros] (
	  [cod_rubro] decimal(10),
	  [desc_corta] nvarchar(50),
	  [desc_larga] nvarchar(255),
	  PRIMARY KEY ([cod_rubro])
	);

	CREATE TABLE [Publicaciones] (
	  [cod_publi] numeric(18,0),
	  [descripcion] nvarchar(255),
	  [stock] numeric(18,0),
	  [fecha_inicio] datetime,
	  [fecha_vencimiento] datetime,
	  [precio_producto] numeric(18,2),
	  [cod_visibilidad] numeric(18),
	  [cod_estado] numeric(1),
	  [cod_rubro] decimal(10),
	  [cod_usuario] decimal(20),
	  [cod_tipo_publi] nvarchar(255),
	  [con_envio] bit,
	  [con_preguntas] bit,
	  PRIMARY KEY ([cod_publi])
	);

	CREATE INDEX [FK] ON  [Publicaciones] ([cod_visibilidad], [cod_estado], [cod_rubro], [cod_usuario]);

	CREATE TABLE [Funcionalidades] (
	  [cod_funcionalidad] decimal(10),
	  [descripcion] nvarchar(50),
	  PRIMARY KEY ([cod_funcionalidad])
	);

	CREATE TABLE [Items_por_facturas] (
	  [num_factura] numeric(18),
	  [cod_item] numeric(1),
	  [item_cantidad] numeric(18,0),
	  [item_subtotal] numeric(18,2)
	);

	CREATE INDEX [PK / FK] ON  [Items_por_facturas] ([num_factura], [cod_item]);

	CREATE TABLE [Roles_Usuario] (
	  [cod_usuario] decimal(20),
	  [cod_rol] decimal(10)
	);

	CREATE INDEX [PK FK] ON  [Roles_Usuario] ([cod_usuario], [cod_rol]);

	CREATE TABLE [Roles] (
	  [cod_rol] decimal(10),
	  [nombre] nvarchar(50),
	  [activo] bit,
	  PRIMARY KEY ([cod_rol])
	);

	RETURN 0;

END

GO
/****** Object:  StoredProcedure [dbo].[DropTables]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DropTables]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF OBJECT_ID('dbo.Administradores', 'U') IS NOT NULL DROP TABLE dbo.Administradores; 
   IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL DROP TABLE dbo.Clientes; 
   IF OBJECT_ID('dbo.Empresas', 'U') IS NOT NULL DROP TABLE dbo.Empresas; 
   IF OBJECT_ID('dbo.EstadosPublicacion', 'U') IS NOT NULL DROP TABLE dbo.EstadosPublicacion; 
   IF OBJECT_ID('dbo.Facturas', 'U') IS NOT NULL DROP TABLE dbo.Facturas; 
   IF OBJECT_ID('dbo.Funcionalidades', 'U') IS NOT NULL DROP TABLE dbo.Funcionalidades; 
   IF OBJECT_ID('dbo.Historica', 'U') IS NOT NULL DROP TABLE dbo.Historica; 
   IF OBJECT_ID('dbo.Items', 'U') IS NOT NULL DROP TABLE dbo.Items; 
   IF OBJECT_ID('dbo.Items_por_facturas', 'U') IS NOT NULL DROP TABLE dbo.Items_por_facturas; 
   IF OBJECT_ID('dbo.Perfiles', 'U') IS NOT NULL DROP TABLE dbo.Perfiles; 
   IF OBJECT_ID('dbo.Publicaciones', 'U') IS NOT NULL DROP TABLE dbo.Publicaciones; 
   IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE dbo.Roles; 
   IF OBJECT_ID('dbo.Roles_Usuario', 'U') IS NOT NULL DROP TABLE dbo.Roles_Usuario; 
   IF OBJECT_ID('dbo.Rubros', 'U') IS NOT NULL DROP TABLE dbo.Rubros; 
   IF OBJECT_ID('dbo.Usuarios', 'U') IS NOT NULL DROP TABLE dbo.Usuarios; 
   IF OBJECT_ID('dbo.Visibilidades', 'U') IS NOT NULL DROP TABLE dbo.Visibilidades; 

END

GO
/****** Object:  StoredProcedure [dbo].[MigrarUsuarioCliente]    Script Date: 25/5/2016 2:32:23 p. m. ******/
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

GO
/****** Object:  Table [dbo].[Administradores]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administradores](
	[cod_usuario] [decimal](20, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[cod_usuario] [decimal](20, 0) NULL,
	[nombre] [nvarchar](255) NULL,
	[apellido] [nvarchar](255) NULL,
	[dni] [numeric](18, 0) NULL,
	[documento_tipo] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresas]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresas](
	[cod_usuario] [decimal](20, 0) NULL,
	[cuit] [nvarchar](50) NULL,
	[razon_social] [nvarchar](255) NULL,
	[dir_ciudad] [varchar](50) NULL,
	[nombre_contacto] [varchar](255) NULL,
	[rubro_empresa] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EstadosPublicacion]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadosPublicacion](
	[cod_estado] [numeric](1, 0) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[num_factura] [numeric](18, 0) NOT NULL,
	[cod_publi] [numeric](18, 0) NULL,
	[fecha_factura] [datetime] NULL,
	[total] [numeric](18, 2) NULL,
	[forma_pago] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Funcionalidades]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcionalidades](
	[cod_funcionalidad] [decimal](10, 0) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_funcionalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Historica]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historica](
	[cod_comprador] [decimal](20, 0) NULL,
	[cod_publi] [numeric](18, 0) NULL,
	[fecha_oferta] [datetime] NULL,
	[monto_ofertado] [numeric](18, 2) NULL,
	[calificacion] [numeric](18, 0) NULL,
	[desc_calificacion] [nvarchar](255) NULL,
	[cantidad_comprada] [numeric](18, 0) NULL,
	[usuario_ganador] [decimal](20, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Items]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[cod_item] [numeric](1, 0) NOT NULL,
	[descripcion_item] [varchar](30) NULL,
	[item_monto] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items_por_facturas]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items_por_facturas](
	[num_factura] [numeric](18, 0) NULL,
	[cod_item] [numeric](1, 0) NULL,
	[item_cantidad] [numeric](18, 0) NULL,
	[item_subtotal] [numeric](18, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[cod_funcionalidad] [decimal](10, 0) NULL,
	[cod_rol] [decimal](10, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publicaciones]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publicaciones](
	[cod_publi] [numeric](18, 0) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[stock] [numeric](18, 0) NULL,
	[fecha_inicio] [datetime] NULL,
	[fecha_vencimiento] [datetime] NULL,
	[precio_producto] [numeric](18, 2) NULL,
	[cod_visibilidad] [numeric](18, 0) NULL,
	[cod_estado] [numeric](1, 0) NULL,
	[cod_rubro] [decimal](10, 0) NULL,
	[cod_usuario] [decimal](20, 0) NULL,
	[cod_tipo_publi] [nvarchar](255) NULL,
	[con_envio] [bit] NULL,
	[con_preguntas] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_publi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[cod_rol] [decimal](10, 0) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles_Usuario]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles_Usuario](
	[cod_usuario] [decimal](20, 0) NULL,
	[cod_rol] [decimal](10, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rubros]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rubros](
	[cod_rubro] [decimal](10, 0) NOT NULL,
	[desc_corta] [nvarchar](50) NULL,
	[desc_larga] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rubro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[cod_usuario] [decimal](20, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](255) NULL,
	[cod_rol] [decimal](10, 0) NULL,
	[login_fallidos] [decimal](1, 0) NULL,
	[password] [nvarchar](100) NULL,
	[activo] [bit] NULL,
	[mail] [nvarchar](255) NULL,
	[telefono] [varchar](100) NULL,
	[dir_calle] [nvarchar](255) NULL,
	[dir_nro] [numeric](18, 0) NULL,
	[dir_piso] [numeric](18, 0) NULL,
	[dir_depto] [nvarchar](50) NULL,
	[dir_localidad] [nvarchar](100) NULL,
	[dir_cod_post] [nvarchar](50) NULL,
	[fecha_nacimiento] [datetime] NULL,
	[fecha_alta] [datetime] NULL,
	[publ_sin_cargo] [bit] NULL,
	[cant_ventas] [numeric](18, 0) NULL,
	[sum_calificacion] [numeric](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visibilidades]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visibilidades](
	[cod_visibilidad] [numeric](18, 0) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[costo_publicar] [numeric](18, 2) NULL,
	[porcentaje_venta] [numeric](18, 2) NULL,
	[costo_envio] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_visibilidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [gd_esquema].[Maestra]    Script Date: 25/5/2016 2:32:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gd_esquema].[Maestra](
	[Publ_Cli_Dni] [numeric](18, 0) NULL,
	[Publ_Cli_Apeliido] [nvarchar](255) NULL,
	[Publ_Cli_Nombre] [nvarchar](255) NULL,
	[Publ_Cli_Fecha_Nac] [datetime] NULL,
	[Publ_Cli_Mail] [nvarchar](255) NULL,
	[Publ_Cli_Dom_Calle] [nvarchar](255) NULL,
	[Publ_Cli_Nro_Calle] [numeric](18, 0) NULL,
	[Publ_Cli_Piso] [numeric](18, 0) NULL,
	[Publ_Cli_Depto] [nvarchar](50) NULL,
	[Publ_Cli_Cod_Postal] [nvarchar](50) NULL,
	[Publ_Empresa_Razon_Social] [nvarchar](255) NULL,
	[Publ_Empresa_Cuit] [nvarchar](50) NULL,
	[Publ_Empresa_Fecha_Creacion] [datetime] NULL,
	[Publ_Empresa_Mail] [nvarchar](50) NULL,
	[Publ_Empresa_Dom_Calle] [nvarchar](100) NULL,
	[Publ_Empresa_Nro_Calle] [numeric](18, 0) NULL,
	[Publ_Empresa_Piso] [numeric](18, 0) NULL,
	[Publ_Empresa_Depto] [nvarchar](50) NULL,
	[Publ_Empresa_Cod_Postal] [nvarchar](50) NULL,
	[Publicacion_Cod] [numeric](18, 0) NULL,
	[Publicacion_Descripcion] [nvarchar](255) NULL,
	[Publicacion_Stock] [numeric](18, 0) NULL,
	[Publicacion_Fecha] [datetime] NULL,
	[Publicacion_Fecha_Venc] [datetime] NULL,
	[Publicacion_Precio] [numeric](18, 2) NULL,
	[Publicacion_Tipo] [nvarchar](255) NULL,
	[Publicacion_Visibilidad_Cod] [numeric](18, 0) NULL,
	[Publicacion_Visibilidad_Desc] [nvarchar](255) NULL,
	[Publicacion_Visibilidad_Precio] [numeric](18, 2) NULL,
	[Publicacion_Visibilidad_Porcentaje] [numeric](18, 2) NULL,
	[Publicacion_Estado] [nvarchar](255) NULL,
	[Publicacion_Rubro_Descripcion] [nvarchar](255) NULL,
	[Cli_Dni] [numeric](18, 0) NULL,
	[Cli_Apeliido] [nvarchar](255) NULL,
	[Cli_Nombre] [nvarchar](255) NULL,
	[Cli_Fecha_Nac] [datetime] NULL,
	[Cli_Mail] [nvarchar](255) NULL,
	[Cli_Dom_Calle] [nvarchar](255) NULL,
	[Cli_Nro_Calle] [numeric](18, 0) NULL,
	[Cli_Piso] [numeric](18, 0) NULL,
	[Cli_Depto] [nvarchar](50) NULL,
	[Cli_Cod_Postal] [nvarchar](50) NULL,
	[Compra_Fecha] [datetime] NULL,
	[Compra_Cantidad] [numeric](18, 0) NULL,
	[Oferta_Fecha] [datetime] NULL,
	[Oferta_Monto] [numeric](18, 2) NULL,
	[Calificacion_Codigo] [numeric](18, 0) NULL,
	[Calificacion_Cant_Estrellas] [numeric](18, 0) NULL,
	[Calificacion_Descripcion] [nvarchar](255) NULL,
	[Item_Factura_Monto] [numeric](18, 2) NULL,
	[Item_Factura_Cantidad] [numeric](18, 0) NULL,
	[Factura_Nro] [numeric](18, 0) NULL,
	[Factura_Fecha] [datetime] NULL,
	[Factura_Total] [numeric](18, 2) NULL,
	[Forma_Pago_Desc] [nvarchar](255) NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Administradores]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Empresas]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [dbo].[Publicaciones] ([cod_publi])
GO
ALTER TABLE [dbo].[Historica]  WITH CHECK ADD FOREIGN KEY([cod_comprador])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Historica]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [dbo].[Publicaciones] ([cod_publi])
GO
ALTER TABLE [dbo].[Items_por_facturas]  WITH CHECK ADD FOREIGN KEY([cod_item])
REFERENCES [dbo].[Items] ([cod_item])
GO
ALTER TABLE [dbo].[Items_por_facturas]  WITH CHECK ADD FOREIGN KEY([num_factura])
REFERENCES [dbo].[Facturas] ([num_factura])
GO
ALTER TABLE [dbo].[Perfiles]  WITH CHECK ADD FOREIGN KEY([cod_funcionalidad])
REFERENCES [dbo].[Funcionalidades] ([cod_funcionalidad])
GO
ALTER TABLE [dbo].[Perfiles]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])
GO
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_estado])
REFERENCES [dbo].[EstadosPublicacion] ([cod_estado])
GO
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_rubro])
REFERENCES [dbo].[Rubros] ([cod_rubro])
GO
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_visibilidad])
REFERENCES [dbo].[Visibilidades] ([cod_visibilidad])
GO
ALTER TABLE [dbo].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])
GO
ALTER TABLE [dbo].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])
GO
