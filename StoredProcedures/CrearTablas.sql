USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[CrearTablas]    Script Date: 21/05/2016 15:26:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 15/05/2016
-- Description:	Procedimiento para crear todas las tablas del DER para la migración.
-- =============================================
ALTER PROCEDURE [dbo].[CrearTablas](@param bit)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	DROP TABLE [Facturas], [Empresas], [Historica], [EstadosPublicacion], [Items], [Visibilidades], [Usuarios],
	           [Administradores], [Perfiles], [Clientes], [Rubros], [Publicaciones], [Funcionalidades], 
			   [Items_por_factura], [Roles_Usuario], [Roles];

	CREATE TABLE [Facturas] (
	  [num_factura] numeric(18),
	  [cod_publi] numeric(18,0),
	  [fecha_factura] datetime,
	  [total] numeric(18,2),
	  [forma_pago] nvarchar(255),
	  PRIMARY KEY ([num_factura])
	);
	CREATE INDEX [idx_Fac_cod_publi] ON  [Facturas] ([cod_publi]);

	CREATE TABLE [Empresas] (
	  [cod_usuario] decimal(20),
	  [cuit] nvarchar(50),
	  [razon_social] nvarchar(255),
	  [dir_ciudad] varchar(50),
	  [nombre_contacto] varchar(255),
	  [rubro_empresa] varchar(255),
	  PRIMARY KEY ([cod_usuario])
	);
	CREATE INDEX [idx_Emp_cod_usuario] ON  [Empresas] ([cod_usuario]);

	CREATE TABLE [Historica] (
	  [cod_publi] numeric(18,0),
	  [cod_comprador] decimal(20),
	  [fecha_oferta] datetime,
	  [monto_ofertado] numeric(18,2),
	  [calificacion] numeric(18,0),
	  [desc_calificacion] nvarchar(255),
	  [cantidad_comprada] numeric(18,0),
	  [usuario_ganador] decimal(20),
	  PRIMARY KEY ([cod_publi], [cod_comprador], [fecha_oferta])
	);
	CREATE INDEX [idx_Historica] ON  [Historica] ([cod_comprador], [cod_publi], [fecha_oferta]);

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
	CREATE INDEX [idx_Usu_cod_rol] ON  [Usuarios] ([cod_rol]);

	CREATE TABLE [Administradores] (
	  [cod_usuario] decimal(20) PRIMARY KEY
	);
	CREATE INDEX [idx_Adm_cod_usuario] ON  [Administradores] ([cod_usuario]);

	CREATE TABLE [Perfiles] (
	  [cod_funcionalidad] decimal(10),
	  [cod_rol] decimal(10),
	  PRIMARY KEY ([cod_funcionalidad], [cod_rol])
	);
	CREATE INDEX [idx_Perfiles] ON  [Perfiles] ([cod_funcionalidad], [cod_rol]);

	CREATE TABLE [Clientes] (
	  [cod_usuario] decimal(20),
	  [nombre] nvarchar(255),
	  [apellido] nvarchar(255),
	  [dni] numeric(18,0),
	  [documento_tipo] varchar(10),
	  PRIMARY KEY ([cod_usuario])
	);
	CREATE INDEX [idx_Cli_cod_usuario] ON  [Clientes] ([cod_usuario]);

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
	CREATE INDEX [idx_Publicaciones] ON  [Publicaciones] ([cod_visibilidad], [cod_estado], [cod_rubro], [cod_usuario]);

	CREATE TABLE [Funcionalidades] (
	  [cod_funcionalidad] decimal(10),
	  [descripcion] nvarchar(50),
	  PRIMARY KEY ([cod_funcionalidad])
	);

	CREATE TABLE [Items_por_factura] (
	  [num_factura] numeric(18),
	  [cod_item] numeric(1),
	  [item_cantidad] numeric(18,0),
	  [item_subtotal] numeric(18,2),
	  PRIMARY KEY ([num_factura], [cod_item])
	);
	CREATE INDEX [idx_Items_por_facturas] ON  [Items_por_factura] ([num_factura], [cod_item]);

	CREATE TABLE [Roles_Usuario] (
	  [cod_usuario] decimal(20),
	  [cod_rol] decimal(10),
	  PRIMARY KEY ([cod_usuario], [cod_rol])
	);
	CREATE INDEX [idx_Roles_Usuario] ON  [Roles_Usuario] ([cod_usuario], [cod_rol]);

	CREATE TABLE [Roles] (
	  [cod_rol] decimal(10),
	  [nombre] nvarchar(50),
	  [activo] bit,
	  PRIMARY KEY ([cod_rol])
	);

	ALTER TABLE [Facturas]
	  ADD CONSTRAINT Facturas_FK_Publicaciones 
	  FOREIGN KEY ([cod_publi]) 
	  REFERENCES [Publicaciones].[cod_publi]
	;

	ALTER TABLE [Empresas]
	  ADD CONSTRAINT Empresas_FK_Usuarios
	  FOREIGN KEY ([cod_usuario])
	  REFERENCES [Usuarios].[cod_usuario]
	;

	ALTER TABLE [Historica]
	  ADD CONSTRAINT Historica_FK_Publicaciones 
	  FOREIGN KEY ([cod_publi])
	  REFERENCES [Publicaciones].[cod_publi]
	;

	ALTER TABLE [Historica]
	  ADD CONSTRAINT Historica_FK_Usuarios
	  FOREIGN KEY ([cod_comprador])
	  REFERENCES [Usuarios].[cod_usuario]
	;

	ALTER TABLE [Usuarios]
	  ADD CONSTRAINT Usuarios_FK_Roles
	  FOREIGN KEY ([cod_rol])
	  REFERENCES [Roles_Usuario].[cod_rol]
	;

	ALTER TABLE [Administradores]
	  ADD CONSTRAINT Administradores_FK_Usuarios
	  FOREIGN KEY ([cod_usuario])
	  REFERENCES [Usuarios].[cod_usuario]
	;

	ALTER TABLE [Perfiles]
	  ADD CONSTRAINT Perfiles_FK_Funcionalidades
	  FOREIGN KEY ([cod_funcionalidad])
	  REFERENCES [Funcionalidades].[cod_funcionalidad]
	;
	ALTER TABLE [Perfiles]
	  ADD CONSTRAINT Perfiles_FK_Roles 
	  FOREIGN KEY ([cod_rol])
	  REFERENCES [Roles].[cod_rol]
	;

	ALTER TABLE [Clientes]
	  ADD CONSTRAINT Clientes_FK_Usuarios
	  FOREIGN KEY ([cod_usuario])
	  REFERENCES [Usuarios].[cod_usuario]
	;

	ALTER TABLE [Publicaciones]
	  ADD CONSTRAINT Publicaciones_FK_Visibilidades
	  FOREIGN KEY ([cod_visibilidad])
	  REFERENCES [Visibilidades].[cod_visibilidad]
	;

	ALTER TABLE [Publicaciones]
	  ADD CONSTRAINT Publicaciones_FK_EstadosPublicacion
	  FOREIGN KEY ([cod_estado])
	  REFERENCES [EstadosPublicacion].[cod_estado]
	;

	ALTER TABLE [Publicaciones]
	  ADD CONSTRAINT Publicaciones_FK_Rubros
	  FOREIGN KEY ([cod_rubro])
	  REFERENCES [Rubros].[cod_rubro]
	;

	ALTER TABLE [Publicaciones]
	  ADD CONSTRAINT Publicaciones_FK_Usuarios
	  FOREIGN KEY ([cod_usuario])
	  REFERENCES [Usuarios].[cod_usuario]
	;

	ALTER TABLE [Items_por_factura]
	  ADD CONSTRAINT Items_por_facturas_FK_Facturas
	  FOREIGN KEY ([num_factura])
	  REFERENCES [Facturas].[num_factura]
	;

	ALTER TABLE [Items_por_factura]
	  ADD CONSTRAINT Items_por_facturas_FK_Items
	  FOREIGN KEY ([cod_item])
	  REFERENCES [Items].[cod_item]
	;
	ALTER TABLE [Roles_Usuario]
	  ADD CONSTRAINT Roles_Usuario_FK_Usuarios
	  FOREIGN KEY (cod_usuario)
	  REFERENCES [Usuarios].[cod_usuario]
	;
	ALTER TABLE [Roles_Usuario]
	  ADD CONSTRAINT Roles_Usuario_FK_Roles
	  FOREIGN KEY ([cod_rol])
	  REFERENCES [Roles].[cod_rol]
	;

	RETURN 0;

END
