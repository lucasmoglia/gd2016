USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DE_UNA].[GenerarFactura]
	  @cod_publi numeric(18,0)
	, @cantidad int
	, @fecha datetime
AS
BEGIN
	declare @num_factura numeric(18,0) = 0

	BEGIN TRAN FACT
		declare @precio_producto numeric(18,2)
		declare @comision numeric(18,2)
		declare @envio numeric(18,2)
		
		declare @tiene_envio bit
		declare @cod_usuario decimal(20,0)
		declare @ya_facturada bit

		SELECT @precio_producto = P.precio_producto, 
			   @comision = IIF(@cantidad != 0, V.porcentaje_venta, V.costo_publicar),
			   @envio = V.costo_envio, @tiene_envio = P.con_envio, @cod_usuario = P.cod_usuario
		  FROM [DE_UNA].Publicaciones P
		  JOIN [DE_UNA].Visibilidades V ON P.cod_visibilidad = V.cod_visibilidad
		 WHERE P.cod_publi = @cod_publi

		--Obtener numero de factura a insertar
		SELECT TOP 1 @num_factura = num_factura + 1 FROM Facturas ORDER BY num_factura DESC

		IF @cantidad != 0 /* Es comisión por venta. */
		  BEGIN
			--Inserta factura
			INSERT INTO Facturas
				VALUES (@num_factura, @cod_publi, @fecha, ((@comision * 100)/@precio_producto) + IIF(@tiene_envio = 1, @envio, 0), 'Efectivo', @cod_usuario)

			--Inserta item
			INSERT INTO Items
				VALUES (@num_factura, 2, 'Comision venta', @cantidad, @cantidad * @precio_producto)

			--Si tiene envio, inserta item por envío
			IF @tiene_envio = 1
				INSERT INTO Items
					VALUES (@num_factura, 3, 'Envío', 1, @envio)
		  END
		ELSE /* Es comisión por Publicar. */
		  BEGIN
			--Busca Si la publicación ya fue facturada. Busca un Item codigo 1, (descripción: 'Costo por publicar')
			SET @ya_facturada = IIF(
				EXISTS(SELECT F.num_factura FROM DE_UNA.Facturas F 
				  JOIN DE_UNA.Items I ON I.num_factura = F.num_factura
				 WHERE F.cod_publi = @cod_publi
				   AND I.cod_item = 1 /*'Costo por publicar'*/), 1, 0)
			
			IF @ya_facturada = 0 /* No fue facturada. */
			  BEGIN
				--Inserta factura
				INSERT INTO Facturas
					VALUES (@num_factura, @cod_publi, @fecha, @comision, 'Efectivo', @cod_usuario)

				--Inserta item
				INSERT INTO Items
					VALUES (@num_factura, 1, 'Costo por publicar', @cantidad, @cantidad)
			  END
			ELSE /* Ya fue facturada. (Sería una Publicación reactivada.) */
				SET @num_factura = 0
		  END
	COMMIT TRAN FACT
	
	RETURN @num_factura;
END