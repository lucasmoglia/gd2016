USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DE_UNA].GenerarCompra
	  @cod_publi numeric(18,0)
	, @cantidad  int
	, @fecha     datetime
AS
BEGIN
	declare @id_compra numeric(18,0) = NULL;

	BEGIN TRAN COMPRA
		declare @precio_producto numeric(18,2)
		declare @stock numeric(18,2)
		declare @monto numeric(18,2)
		declare @num_factura numeric(18,0) = 0
		declare @tiene_envio bit
		declare @cod_usuario decimal(20,0)

		SELECT @precio_producto = precio_producto, @stock = stock,
			   @monto = precio_producto, @cod_usuario = cod_usuario
		  FROM [DE_UNA].Publicaciones
		 WHERE cod_publi = @cod_publi

		--Inserta Compra
		INSERT INTO [DE_UNA].Compras (cod_publi, cod_usuario, fecha_compra, monto, cantidad, cod_calificacion, estrellas, desc_calificacion)
			         VALUES(@cod_publi, @cod_usuario, @fecha, @monto, @cantidad, NULL, NULL, NULL)
		
		IF (@stock - @cantidad) >= 0
		  BEGIN
			--Descuenta Stock
			set @id_compra = @@IDENTITY;
			UPDATE [DE_UNA].Publicaciones
			   SET stock = stock - @cantidad
		  END
		ELSE
			ROLLBACK TRANSACTION COMPRA;

	COMMIT TRAN COMPRA
	
	RETURN SELECT * FROM DE_UNA.Compras WHERE id_compra = @id_compra;
END