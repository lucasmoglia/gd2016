USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER PROCEDURE [DE_UNA].GetPublicaciones
	-- Parámetros para los filtros.
	  @estado numeric(1)				-- filtro por estado de publicación
	, @rubros [DE_UNA].Rubros READONLY  -- filtro por rubros
	, @descripcion nvarchar(255)		-- filtro por descripción de publicación
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
	FROM [DE_UNA].Publicaciones P
	 LEFT JOIN [DE_UNA].Visibilidades      V ON P.cod_visibilidad = V.cod_visibilidad
	 LEFT JOIN [DE_UNA].EstadosPublicacion E ON P.cod_estado      = E.cod_estado
	 LEFT JOIN [DE_UNA].Rubros             R ON P.cod_rubro       = R.cod_rubro
	 LEFT JOIN [DE_UNA].Tipos_Publicacion  T ON P.cod_tipo_publi  = T.cod_tipo_publi
	 LEFT JOIN [DE_UNA].Usuarios           U ON P.cod_usuario     = U.cod_usuario
	WHERE (E.cod_estado    IN (@estado, @publicada)   OR @estado IS NULL)
	  AND (p.cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR (SELECT cod_Rubro FROM @rubros) IS NULL)
	  AND (P.descripcion LIKE ('%' + @descripcion + '%')      OR @descripcion IS NULL)
	ORDER BY P.cod_visibilidad
	OFFSET @desplazamiento ROWS FETCH NEXT @bloqueDePaginas ROWS ONLY;

END
