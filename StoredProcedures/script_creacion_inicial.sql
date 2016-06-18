USE [GD1C2016]
GO
/****** Object:  Schema [DE_UNA]    Script Date: 15/06/2016 11:52:50 ******/
CREATE SCHEMA [DE_UNA]
GO
/****** Object:  UserDefinedTableType [DE_UNA].[Rubros]    Script Date: 15/06/2016 11:52:50 ******/
CREATE TYPE [DE_UNA].[Rubros] AS TABLE(
	[cod_rubro] [decimal](10, 0) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[Migracion]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo DE_UNA.
-- Create date: 11/05/2016
-- Description:	Script de Migración.
-- =============================================
CREATE PROCEDURE [dbo].[Migracion] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	DECLARE @crearSchema nvarchar(200) = 'CREATE SCHEMA [DE_UNA]';

	EXECUTE [DE_UNA].[DropTables];
--	EXECUTE [DE_UNA].[DropProcedures];

--	DROP SCHEMA [DE_UNA];

--	EXEC(@crearSchema);

	EXECUTE [DE_UNA].[CrearTablas];
	EXECUTE [DE_UNA].[PoblarTablasSinDependencias];
	EXECUTE [DE_UNA].[MigrarUsuarioEmpresa];
	EXECUTE [DE_UNA].[MigrarUsuarioCliente];
	EXECUTE [DE_UNA].[MigrarPublicaciones];
	EXECUTE [DE_UNA].[MigrarCompras];
	EXECUTE [DE_UNA].[Migrar_Ofertas];
	EXECUTE [DE_UNA].[MigrarFacturas];

END

GO
/****** Object:  StoredProcedure [DE_UNA].[CrearTablas]    Script Date: 15/06/2016 11:52:50 ******/
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
		[forma_pago]		[nvarchar](255)		NULL
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
/****** Object:  StoredProcedure [DE_UNA].[DropProcedures]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	
-- =============================================
CREATE PROCEDURE [DE_UNA].[DropProcedures] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF OBJECT_ID('[DE_UNA].CrearTablas', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].CrearTablas;
	IF OBJECT_ID('[DE_UNA].DropTables', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].DropTables;
	IF OBJECT_ID('[DE_UNA].Migrar_Ofertas', 'U')			  IS NOT NULL DROP PROCEDURE [DE_UNA].Migrar_Ofertas;
	IF OBJECT_ID('[DE_UNA].MigrarCompras', 'U')				  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarCompras;
	IF OBJECT_ID('[DE_UNA].MigrarFacturas', 'U')			  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarFacturas;
	IF OBJECT_ID('[DE_UNA].MigrarPublicaciones', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarPublicaciones;
	IF OBJECT_ID('[DE_UNA].MigrarUsuarioCliente', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarUsuarioCliente;
	IF OBJECT_ID('[DE_UNA].MigrarUsuarioEmpresa', 'U')		  IS NOT NULL DROP PROCEDURE [DE_UNA].MigrarUsuarioEmpresa;
	IF OBJECT_ID('[DE_UNA].PoblarTablasSinDependencias', 'U') IS NOT NULL DROP PROCEDURE [DE_UNA].PoblarTablasSinDependencias;

END

GO
/****** Object:  StoredProcedure [DE_UNA].[DropTables]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Unknown
-- Create date: Unknown
-- Modificado por: Nicolás Chiaradia
-- Ultima Modificación: 03/06/2016
-- Description:	Nuevas Tablas en orden inverso a su creación.
-- =============================================

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
/****** Object:  StoredProcedure [DE_UNA].[FinalizaSubastas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DE_UNA].[FinalizaSubastas] 
AS
BEGIN
-- ((1)) -- Identificar las Subastas Activas que finalizan hoy.
	select P.cod_publi, P.fecha_vencimiento, P.cod_estado, P.cod_tipo_publi
	INTO   #Publicaciones_Finalizando
	from   [GD1C2016].[DE_UNA].[Publicaciones] P
	where  P.cod_tipo_publi = 2 and (p.cod_estado = 1 or p.cod_estado = 3)    -- subastas activas
       and cast(p.fecha_vencimiento as date) = cast(getdate() As Date)    -- Que finalizan hoy

-- ((2)) -- Cambiar su estado a Finalizada.
	UPDATE [GD1C2016].[DE_UNA].[Publicaciones]
	SET cod_estado = 5
	-- SET stock = 0
	FROM #Publicaciones_Finalizando PF, [GD1C2016].[DE_UNA].[Publicaciones] P
	where PF.cod_publi = P.cod_publi

-- ((3)) -- Identificar sus respectivas Ofertas para tomar la última como Compra.
INSERT INTO [GD1C2016].[DE_UNA].Compras(cod_publi, cod_usuario, fecha_compra, monto)
select O1.cod_publi, O1.cod_usuario, O1.fecha_oferta as fecha_compra, O1.monto 
	from [GD1C2016].[DE_UNA].[Ofertas] O1, #Publicaciones_Finalizando PF
	where monto = (select max(monto) from [GD1C2016].[DE_UNA].[Ofertas] O2
						where O2.cod_publi = O1.cod_publi
						) and O1.cod_publi = PF.cod_publi

end
GO
/****** Object:  StoredProcedure [DE_UNA].[GetClientes]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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
/****** Object:  StoredProcedure [DE_UNA].[GetEmpresas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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
/****** Object:  StoredProcedure [DE_UNA].[GetEstadosPublicacion]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar los Estados de Publicacion.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetEstadosPublicacion] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_estado
		 , descripcion
	  FROM [DE_UNA].EstadosPublicacion;
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetFuncionalidades]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar las Funcionalidades.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetFuncionalidades] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_funcionalidad
		 , descripcion
	  FROM [DE_UNA].Funcionalidades;
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetGridUsuarios]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetPublicaciones]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [DE_UNA].[GetPublicaciones]
	-- Add the parameters for the stored procedure here
	@estado numeric(1),
--	@rubros decimal(10),
	@rubros [DE_UNA].Rubros READONLY,
	@descripcion nvarchar(255)
	-- Faltarían poner 2 parametros: - cod_usuario
	--                               - una condicion que indique si se debe comparar el cod_usuario por igual o distinto
	-- para cumplir con lo sig.: "Además un vendedor no puede auto-comprarse u auto-ofertarse."
	-- y también poder seleccionar todas las publicaciones de un usuario
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--  DECLARE @publicada numeric(1) 

    --IF @estado IS NULL
    --    set @publicada = NULL
    --ELSE
    --    @publicada = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Publicada');
    --END
    DECLARE @publicada numeric(1) = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Publicada');

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
	WHERE (E.cod_estado    IN (@estado, @publicada)   OR @estado IS NULL)
	  AND (p.cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR (SELECT cod_Rubro FROM @rubros) IS NULL)
--	  AND (p.cod_rubro     IN (@rubros) OR @rubros IS NULL)
	  AND (P.descripcion LIKE '%@descripcion%'        OR @descripcion IS NULL)
	ORDER BY P.cod_visibilidad
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetRoles]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetRoles]
	-- Add the parameters for the stored procedure here
	@activeOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cod_rol, nombre
	FROM [DE_UNA].[Roles] 
	WHERE (@activeOnly = 1 AND activo = 1) OR @activeOnly = 0
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetRubros]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetRubros]
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
/****** Object:  StoredProcedure [DE_UNA].[GetTiposPublicacion]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar los Tipos de Publicacion.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetTiposPublicacion] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cod_tipo_publi
		 , descripcion
	  FROM [DE_UNA].Tipos_Publicacion;
END

GO
/****** Object:  StoredProcedure [DE_UNA].[GetUsuario]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para recuperar un usuario.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetUsuario]
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
/****** Object:  StoredProcedure [DE_UNA].[GetVisibilidad]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para recuperar una visibilidad.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetVisibilidad]
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
/****** Object:  StoredProcedure [DE_UNA].[GetVisibilidades]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para recuperar las visibilidades.
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetVisibilidades] AS
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
/****** Object:  StoredProcedure [DE_UNA].[Login]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[Login]
	-- Add the parameters for the stored procedure here
	@username nvarchar(50), 
	@password nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF((SELECT COUNT(U.cod_usuario) as result
		FROM [DE_UNA].[Usuarios] U
		WHERE U.username = @username 
			AND U.[password] = HASHBYTES('SHA2_256', @password)
			AND U.activo = 1)= 0)
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = login_fallidos + 1, activo=IIF(login_fallidos+1>=3, 0, 1)
		WHERE username = @username
		SELECT 0
	END
	ELSE
		SELECT 1
END

GO
/****** Object:  StoredProcedure [DE_UNA].[Migrar_Ofertas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 04/06/2016
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
/****** Object:  StoredProcedure [DE_UNA].[MigrarCompras]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 09/06/2016
-- Description:	SP de migración de Compras.
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarCompras] AS
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
/****** Object:  StoredProcedure [DE_UNA].[MigrarFacturas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lucas Moglia
-- Create date: 28/05/2016
-- Description:	migra datos desde la tabla maestra
-- Insertando Facturas!

-- Depende de INSERT DE PUBLICACIONES
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarFacturas]
AS
BEGIN
	IF (SELECT COUNT(P.cod_publi) FROM [DE_UNA].Publicaciones P) > 0
	BEGIN
		PRINT 'Migrando facturas...'

		INSERT INTO [DE_UNA].[Facturas]
		SELECT M.Factura_Nro
			, M.Publicacion_Cod
			, M.Factura_Fecha
			, M.Factura_Total
			, M.Forma_Pago_Desc
		FROM gd_esquema.Maestra M
		WHERE M.Factura_Nro IS NOT NULL
		GROUP BY M.Factura_Nro
			, M.Publicacion_Cod
			, M.Factura_Fecha
			, M.Factura_Total
			, M.Forma_Pago_Desc
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
/****** Object:  StoredProcedure [DE_UNA].[MigrarPublicaciones]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 06/06/2016
-- Description:	SP para migrar las Publicaciones
-- Éste SP no se podrá ejecutar antes de PoblarTablasSinDependencias ni MigrarUsuarios (Clientes y Empresas).
-- =============================================
CREATE PROCEDURE [DE_UNA].[MigrarPublicaciones] AS
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
/****** Object:  StoredProcedure [DE_UNA].[MigrarUsuarioCliente]    Script Date: 15/06/2016 11:52:50 ******/
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
/****** Object:  StoredProcedure [DE_UNA].[MigrarUsuarioEmpresa]    Script Date: 15/06/2016 11:52:50 ******/
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
/****** Object:  StoredProcedure [DE_UNA].[NuevaCompra]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una compra.
-- RETORNA: 0 --> No hay Stock.
--          1 --> Ejecución OK.
-- =============================================
CREATE PROCEDURE [DE_UNA].[NuevaCompra]
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

	INSERT INTO [DE_UNA].Compras
	VALUES(@cod_publi, @cod_usuario, @fecha_compra, @monto, @cantidad, @cod_calificacion, @estrellas, @desc_calificacion);

	RETURN 1;
END

GO
/****** Object:  StoredProcedure [DE_UNA].[NuevaOferta]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una oferta.
-- RETORNA: 0 --> No es una oferta mayor a la última.
--          1 --> Ejecución OK.
-- =============================================
CREATE PROCEDURE [DE_UNA].[NuevaOferta]
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

	DECLARE @stock numeric(18,0) = (SELECT stock FROM [DE_UNA].Publicaciones WHERE cod_publi = @cod_publi);

	--IF (!([DE_UNA].esMayorAUltimaOferta(@monto, @cod_publi))
	--	RETURN 0;

	INSERT INTO [DE_UNA].Ofertas
	VALUES(@cod_publi, @cod_usuario, @fecha_oferta, @monto);

	RETURN 1;
END

GO
/****** Object:  StoredProcedure [DE_UNA].[NuevoCliente]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[NuevoCliente]
	-- Add the parameters for the stored procedure here
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
	@fecha_nacimiento datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [DE_UNA].[Usuarios]
	VALUES(0,@username,HASHBYTES('SHA2_256', @password),1,@mail,@telefono,@dir_calle,@dir_nro,@dir_piso,@dir_depto,@dir_localidad,@dir_cod_post,@fecha_nacimiento,GETDATE(),1,0,0)

	INSERT INTO [DE_UNA].[Clientes]
	VALUES(IDENT_CURRENT('DE_UNA.Usuarios'),@nombre,@apellido,@dni,@documento_tipo)

	SELECT 1	
END

GO
/****** Object:  StoredProcedure [DE_UNA].[PoblarTablasSinDependencias]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		German Rodriguez
-- Create date: 04/06/2016
-- Description:	SP par poblar tablas que no tienen dependencias.
-- =============================================
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
/****** Object:  Table [DE_UNA].[Clientes]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DE_UNA].[Clientes](
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[nombre] [nvarchar](255) NULL,
	[apellido] [nvarchar](255) NULL,
	[dni] [numeric](18, 0) NULL,
	[documento_tipo] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [DE_UNA].[Compras]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Compras](
	[id_compra] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cod_publi] [numeric](18, 0) NOT NULL,
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[fecha_compra] [datetime] NOT NULL,
	[monto] [numeric](18, 2) NULL,
	[cantidad] [numeric](18, 0) NULL,
	[cod_calificacion] [numeric](18, 0) NULL,
	[estrellas] [numeric](18, 0) NULL,
	[desc_calificacion] [nvarchar](255) NULL,
 CONSTRAINT [KeyCompras] PRIMARY KEY CLUSTERED 
(
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Empresas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DE_UNA].[Empresas](
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[cuit] [nvarchar](50) NULL,
	[razon_social] [nvarchar](255) NULL,
	[dir_ciudad] [varchar](50) NULL,
	[nombre_contacto] [varchar](255) NULL,
	[cod_rubro] [decimal](10, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [DE_UNA].[EstadosPublicacion]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[EstadosPublicacion](
	[cod_estado] [numeric](1, 0) IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Facturas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Facturas](
	[num_factura] [numeric](18, 0) NOT NULL,
	[cod_publi] [numeric](18, 0) NOT NULL,
	[fecha_factura] [datetime] NULL,
	[total] [numeric](18, 2) NULL,
	[forma_pago] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Func_por_Rol]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Func_por_Rol](
	[cod_funcionalidad] [decimal](10, 0) NOT NULL,
	[cod_rol] [decimal](10, 0) NOT NULL,
 CONSTRAINT [KeyFuncPorRol] PRIMARY KEY CLUSTERED 
(
	[cod_funcionalidad] ASC,
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Funcionalidades]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Funcionalidades](
	[cod_funcionalidad] [decimal](10, 0) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_funcionalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Items]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DE_UNA].[Items](
	[id_item] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[num_factura] [numeric](18, 0) NOT NULL,
	[cod_item] [numeric](1, 0) NOT NULL,
	[descripcion_item] [varchar](30) NULL,
	[item_cantidad] [numeric](18, 0) NULL,
	[item_monto] [numeric](18, 2) NULL,
 CONSTRAINT [KeyItems] PRIMARY KEY CLUSTERED 
(
	[id_item] ASC,
	[num_factura] ASC,
	[cod_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [DE_UNA].[Ofertas]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Ofertas](
	[id_oferta] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cod_publi] [numeric](18, 0) NOT NULL,
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[fecha_oferta] [datetime] NOT NULL,
	[monto] [numeric](18, 2) NULL,
 CONSTRAINT [KeyOfertas] PRIMARY KEY CLUSTERED 
(
	[id_oferta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Publicaciones]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Publicaciones](
	[cod_publi] [numeric](18, 0) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[stock] [numeric](18, 0) NULL,
	[fecha_inicio] [datetime] NULL,
	[fecha_vencimiento] [datetime] NULL,
	[precio_producto] [numeric](18, 2) NULL,
	[cod_visibilidad] [numeric](18, 0) NOT NULL,
	[cod_estado] [numeric](1, 0) NOT NULL,
	[cod_rubro] [decimal](10, 0) NOT NULL,
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[cod_tipo_publi] [numeric](1, 0) NOT NULL,
	[con_envio] [bit] NULL,
	[con_preguntas] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_publi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Roles]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Roles](
	[cod_rol] [decimal](10, 0) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Roles_Usuario]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Roles_Usuario](
	[cod_usuario] [decimal](20, 0) NOT NULL,
	[cod_rol] [decimal](10, 0) NOT NULL,
 CONSTRAINT [KeyRolesUsuario] PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC,
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Rubros]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Rubros](
	[cod_rubro] [decimal](10, 0) IDENTITY(1,1) NOT NULL,
	[desc_corta] [nvarchar](50) NULL,
	[desc_larga] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rubro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Tipos_Publicacion]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Tipos_Publicacion](
	[cod_tipo_publi] [numeric](1, 0) IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_tipo_publi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [DE_UNA].[Usuarios]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DE_UNA].[Usuarios](
	[cod_usuario] [decimal](20, 0) IDENTITY(1,1) NOT NULL,
	[login_fallidos] [decimal](1, 0) NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](100) NULL,
	[activo] [bit] NOT NULL,
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
/****** Object:  Table [DE_UNA].[Visibilidades]    Script Date: 15/06/2016 11:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DE_UNA].[Visibilidades](
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
ALTER TABLE [DE_UNA].[Publicaciones] ADD  DEFAULT ((0)) FOR [con_envio]
GO
ALTER TABLE [DE_UNA].[Publicaciones] ADD  DEFAULT ((0)) FOR [con_preguntas]
GO
ALTER TABLE [DE_UNA].[Roles] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [DE_UNA].[Usuarios] ADD  DEFAULT ((0)) FOR [login_fallidos]
GO
ALTER TABLE [DE_UNA].[Usuarios] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [DE_UNA].[Usuarios] ADD  DEFAULT ((0)) FOR [cant_ventas]
GO
ALTER TABLE [DE_UNA].[Usuarios] ADD  DEFAULT ((0)) FOR [sum_calificacion]
GO
ALTER TABLE [DE_UNA].[Clientes]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [DE_UNA].[Compras]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [DE_UNA].[Publicaciones] ([cod_publi])
GO
ALTER TABLE [DE_UNA].[Compras]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [DE_UNA].[Empresas]  WITH CHECK ADD FOREIGN KEY([cod_rubro])
REFERENCES [DE_UNA].[Rubros] ([cod_rubro])
GO
ALTER TABLE [DE_UNA].[Empresas]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [DE_UNA].[Facturas]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [DE_UNA].[Publicaciones] ([cod_publi])
GO
ALTER TABLE [DE_UNA].[Func_por_Rol]  WITH CHECK ADD FOREIGN KEY([cod_funcionalidad])
REFERENCES [DE_UNA].[Funcionalidades] ([cod_funcionalidad])
GO
ALTER TABLE [DE_UNA].[Func_por_Rol]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [DE_UNA].[Roles] ([cod_rol])
GO
ALTER TABLE [DE_UNA].[Items]  WITH CHECK ADD FOREIGN KEY([num_factura])
REFERENCES [DE_UNA].[Facturas] ([num_factura])
GO
ALTER TABLE [DE_UNA].[Ofertas]  WITH CHECK ADD FOREIGN KEY([cod_publi])
REFERENCES [DE_UNA].[Publicaciones] ([cod_publi])
GO
ALTER TABLE [DE_UNA].[Ofertas]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [DE_UNA].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_estado])
REFERENCES [DE_UNA].[EstadosPublicacion] ([cod_estado])
GO
ALTER TABLE [DE_UNA].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_rubro])
REFERENCES [DE_UNA].[Rubros] ([cod_rubro])
GO
ALTER TABLE [DE_UNA].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_tipo_publi])
REFERENCES [DE_UNA].[Tipos_Publicacion] ([cod_tipo_publi])
GO
ALTER TABLE [DE_UNA].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
ALTER TABLE [DE_UNA].[Publicaciones]  WITH CHECK ADD FOREIGN KEY([cod_visibilidad])
REFERENCES [DE_UNA].[Visibilidades] ([cod_visibilidad])
GO
ALTER TABLE [DE_UNA].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_rol])
REFERENCES [DE_UNA].[Roles] ([cod_rol])
GO
ALTER TABLE [DE_UNA].[Roles_Usuario]  WITH CHECK ADD FOREIGN KEY([cod_usuario])
REFERENCES [DE_UNA].[Usuarios] ([cod_usuario])
GO
