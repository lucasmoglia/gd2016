USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[MigrarFacturas]    Script Date: 09/06/2016 03:07:05 a.m. ******/
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
