USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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