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

CREATE PROCEDURE DE_UNA.GetOfertas
@cod_usuario decimal(20,0)
as
begin
	select * from DE_UNA.Ofertas where (cod_usuario = @cod_usuario or @cod_usuario is null)
end
go

CREATE PROCEDURE [DE_UNA].[EliminarUsuario] 
	-- Add the parameters for the stored procedure here
	@cod_usuario decimal (12,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [DE_UNA].Usuarios SET fecha_baja = GETDATE() WHERE cod_usuario = @cod_usuario
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
			AND U.fecha_baja IS NULL
			AND U.activo = 1
			AND U.[password] = HASHBYTES('SHA2_256', @password))= 0)
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = login_fallidos + 1, activo=IIF(login_fallidos+1>=3, 0, 1)
		WHERE username = @username
		SELECT 0
	END
	ELSE
	BEGIN
		UPDATE [DE_UNA].Usuarios
		SET login_fallidos = 0, activo=1
		WHERE username = @username
		SELECT 1
	END
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

