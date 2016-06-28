USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[CrearTablas]    Script Date: 28/5/2016 5:54:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:					Germán Rodriguez
-- Modificado por:			Nicolás Chiaradia.
-- Create date:				15/05/2016
-- Ultima Actualizacion:	03/06/2016
-- Description:	Procedimiento para crear todas las tablas del DER para la migración.
-- =============================================
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
