﻿USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetGridUsuarios]    Script Date: 13/06/2016 0:01:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 14/06/2016
-- Description:	SP para llenar la grilla de Publicaciones.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetPublicaciones
	-- Add the parameters for the stored procedure here
	@estado numeric(1)
	@rubros TABLE(cod_Rubro decimal(10))
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

        DECLARE @publicada numeric(1) 

        IF @estado IS NULL
            @publicada = NULL;
        ELSE
            @publicada = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Publicada');
        END

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
		  ,P.cod_tipo_publi
		  ,T.descripcion AS tipo_publi
		  ,P.con_envio
		  ,P.con_preguntas
	FROM [DE_UNA].Publicaciones P
	 LEFT JOIN [DE_UNA].Visibilidades      V ON P.cod_visibilidad = V.cod_visibilidad
	 LEFT JOIN [DE_UNA].EstadosPublicacion E ON P.cod_estado = E.cod_estado
	 LEFT JOIN [DE_UNA].Rubros             R ON P.cod_rubro = R.cod_rubro
	 LEFT JOIN [DE_UNA].Tipos_Publicacion  T ON P.cod_tipo_publi = T.cod_tipo_publi
	WHERE (E.cod_estado    IN (@estado, @publicada)   OR @estado IS NULL)
	  AND (p.cod_rubro     IN (SELECT cod_Rubro FROM @rubros) OR @rubros IS NULL)
	  AND (P.descripcion LIKE (%@descripcion%)        OR @descripcion IS NULL)
	ORDER BY P.cod_visibilidad
END
