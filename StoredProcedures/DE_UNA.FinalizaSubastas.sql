USE [GD1C2016]
GO
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
	from   [DE_UNA].[Publicaciones] P
	where  P.cod_tipo_publi = 2 and (p.cod_estado = 1 or p.cod_estado = 3)    -- subastas activas
       and cast(p.fecha_vencimiento as date) = cast(getdate() As Date)    -- Que finalizan hoy

-- ((2)) -- Cambiar su estado a Finalizada.
	UPDATE [DE_UNA].[Publicaciones]
	SET cod_estado = (SELECT cod_estado FROM [DE_UNA].EstadosPublicacion WHERE descripcion = 'Finalizada')
	-- , stock = 0
	FROM #Publicaciones_Finalizando PF, [DE_UNA].[Publicaciones] P
	where PF.cod_publi = P.cod_publi

-- ((3)) -- Identificar sus respectivas Ofertas para tomar la última como Compra.
INSERT INTO [DE_UNA].Compras(cod_publi, cod_usuario, fecha_compra, monto)
select O1.cod_publi, O1.cod_usuario, O1.fecha_oferta as fecha_compra, O1.monto 
	from [DE_UNA].[Ofertas] O1, #Publicaciones_Finalizando PF
	where monto = (select max(monto) from [DE_UNA].[Ofertas] O2
						where O2.cod_publi = O1.cod_publi
						) and O1.cod_publi = PF.cod_publi

end