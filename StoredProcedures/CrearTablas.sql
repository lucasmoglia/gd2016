USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[CrearTablas]    Script Date: 25/5/2016 2:55:18 p. m. ******/
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
CREATE TABLE [dbo].[Administradores](
	[cod_usuario] [decimal](20, 0) NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[Clientes](
	[cod_usuario] [decimal](20, 0) NULL,
	[nombre] [nvarchar](255) NULL,
	[apellido] [nvarchar](255) NULL,
	[dni] [numeric](18, 0) NULL,
	[documento_tipo] [varchar](10) NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[Empresas](
	[cod_usuario] [decimal](20, 0) NULL,
	[cuit] [nvarchar](50) NULL,
	[razon_social] [nvarchar](255) NULL,
	[dir_ciudad] [varchar](50) NULL,
	[nombre_contacto] [varchar](255) NULL,
	[rubro_empresa] [varchar](255) NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[EstadosPublicacion](
	[cod_estado] [numeric](1, 0) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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

CREATE TABLE [dbo].[Funcionalidades](
	[cod_funcionalidad] [decimal](10, 0) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_funcionalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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

CREATE TABLE [dbo].[Items](
	[cod_item] [numeric](1, 0) NOT NULL,
	[descripcion_item] [varchar](30) NULL,
	[item_monto] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Items_por_facturas](
	[num_factura] [numeric](18, 0) NULL,
	[cod_item] [numeric](1, 0) NULL,
	[item_cantidad] [numeric](18, 0) NULL,
	[item_subtotal] [numeric](18, 2) NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[Perfiles](
	[cod_funcionalidad] [decimal](10, 0) NULL,
	[cod_rol] [decimal](10, 0) NULL
) ON [PRIMARY]

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

CREATE TABLE [dbo].[Roles](
	[cod_rol] [decimal](10, 0) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Roles_Usuario](
	[cod_usuario] [decimal](20, 0) NULL,
	[cod_rol] [decimal](10, 0) NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[Rubros](
	[cod_rubro] [decimal](10, 0) NOT NULL,
	[desc_corta] [nvarchar](50) NULL,
	[desc_larga] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rubro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


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


ALTER TABLE [dbo].[Administradores]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])

ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])

ALTER TABLE [dbo].[Empresas]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [dbo].[Publicaciones] ([cod_publi])

ALTER TABLE [dbo].[Historica]  WITH CHECK ADD FOREIGN KEY([cod_comprador])
REFERENCES [dbo].[Usuarios] ([cod_usuario])

ALTER TABLE [dbo].[Historica]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [dbo].[Publicaciones] ([cod_publi])

ALTER TABLE [dbo].[Items_por_facturas]  WITH CHECK ADD FOREIGN KEY([cod_item])
REFERENCES [dbo].[Items] ([cod_item])

ALTER TABLE [dbo].[Items_por_facturas]  WITH CHECK ADD FOREIGN KEY([num_factura])
REFERENCES [dbo].[Facturas] ([num_factura])

ALTER TABLE [dbo].[Perfiles]  WITH CHECK ADD FOREIGN KEY([cod_funcionalidad])
REFERENCES [dbo].[Funcionalidades] ([cod_funcionalidad])

ALTER TABLE [dbo].[Perfiles]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])

ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_estado])
REFERENCES [dbo].[EstadosPublicacion] ([cod_estado])
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_rubro])
REFERENCES [dbo].[Rubros] ([cod_rubro])
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_visibilidad])
REFERENCES [dbo].[Visibilidades] ([cod_visibilidad])
ALTER TABLE [dbo].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])
ALTER TABLE [dbo].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [dbo].[Usuarios] ([cod_usuario])
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [dbo].[Roles] ([cod_rol])



END
