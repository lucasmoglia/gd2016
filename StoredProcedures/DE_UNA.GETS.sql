USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedTableType [DE_UNA].[FuncionalidadesList]    Script Date: 19/06/2016 13:29:30 ******/
CREATE TYPE [DE_UNA].[FuncionalidadesList] AS TABLE(
	[cod_funcionalidad] [decimal](18, 0) NULL
)
GO

CREATE TYPE [DE_UNA].[ListaNrosFacturas] AS TABLE(
	[nro_factura] [decimal](18, 0) NULL
)
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
*/
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

