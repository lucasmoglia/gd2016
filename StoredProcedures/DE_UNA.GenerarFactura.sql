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

		SELECT TOP 1 @num_factura = num_factura + 1 FROM Facturas ORDER BY num_factura DESC

		INSERT INTO Facturas
			VALUES (@num_factura, @cod_publi, GETDATE(), ((@comision*100)/@precio_producto) + IIF(@tiene_envio = 1, @envio, 0), 'Efectivo')
	COMMIT TRAN FACT
END