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
	BEGIN TRAN FACT
		declare @precio_producto numeric(18,2)
		declare @comision numeric(18,2)
		declare @envio numeric(18,2)
		declare @num_factura numeric(18,0) = 0
		declare @tiene_envio bit
		declare @cod_usuario decimal(20,0)

		SELECT @precio_producto = P.precio_producto, @comision = V.porcentaje_venta,
			   @envio = V.costo_envio, @tiene_envio = P.con_envio, @cod_usuario = P.cod_usuario
		  FROM [DE_UNA].Publicaciones P
		  JOIN [DE_UNA].Visibilidades V ON P.cod_visibilidad = V.cod_visibilidad
		 WHERE P.cod_publi = @cod_publi

		--Obtener numero de factura a insertar
		SELECT TOP 1 @num_factura = num_factura + 1 FROM Facturas ORDER BY num_factura DESC

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

	COMMIT TRAN FACT
	
	RETURN @num_factura;
END