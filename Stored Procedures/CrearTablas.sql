-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 15/05/2016
-- Description:	Procedimiento para crear todas las tablas del DER para la migración.
-- =============================================
CREATE PROCEDURE CrearTablas(@param bit)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	CREATE TABLE [Facturas] (
	  [num_factura] numeric(18),
	  [cod_publi] decimal(30),
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
	  [cod_publi] decimal(30),
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
	  [cod_usuario] decimal(20),
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
