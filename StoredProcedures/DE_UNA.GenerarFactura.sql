USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GenerarFactura]    Script Date: 08/07/2016 23:46:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [DE_UNA].[GenerarFactura]
@cod_publi numeric(18,0)
, @cantidad int
AS
BEGIN
	BEGIN TRAN FACT
		declare @precio_producto numeric(18,2)
		declare @comision numeric(18,2)
		declare @envio numeric(18,2)
		declare @num_factura numeric(18,0)
		declare @tiene_envio tinyint

		SELECT @precio_producto = P.precio_producto, @comision = V.porcentaje_venta, @envio = V.costo_envio, @tiene_envio = P.con_envio
		FROM [DE_UNA].Publicaciones P
			JOIN [DE_UNA].Visibilidades V
				ON P.cod_visibilidad = V.cod_visibilidad
		WHERE P.cod_publi = @cod_publi
		--Obtener numero de factura a insertar
		SELECT TOP 1 @num_factura = num_factura + 1 FROM Facturas ORDER BY num_factura DESC
		--Inserta factura
		INSERT INTO Facturas
			VALUES (@num_factura, @cod_publi, GETDATE(), ((@comision*100)/@precio_producto) + IIF(@tiene_envio = 1, @envio, 0), 'Efectivo')
		--Inserta item
		INSERT INTO Items
			VALUES (@num_factura, 2, 'Comision venta', @cantidad, @cantidad*@precio_producto)
		--Si tiene envio, inserta item por envío
		IF @tiene_envio = 1
			INSERT INTO Items
				VALUES (@num_factura, 3, 'Envío', 1, @envio)

	COMMIT TRAN FACT
END