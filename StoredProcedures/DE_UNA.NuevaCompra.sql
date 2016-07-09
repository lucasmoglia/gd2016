USE [GD1C2016]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	SP para la creación de una compra.
-- RETORNA: 0 --> No hay Stock.
--          1 --> Ejecución OK.
-- =============================================
ALTER PROCEDURE [DE_UNA].NuevaCompra
	-- PARAMETROS:
	@cod_publi numeric(18, 0),
	@cod_usuario decimal(20, 0),
	@fecha_compra datetime,
	@monto numeric(18, 2),
	@cantidad numeric(18, 0),
	@cod_calificacion numeric(18, 0),
	@estrellas numeric(18, 0),
	@desc_calificacion nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @stock numeric(18,0) = (SELECT stock FROM [DE_UNA].Publicaciones WHERE cod_publi = @cod_publi);

	IF (@stock IS NULL OR @stock < 1)
		RETURN 0;
	BEGIN TRAN COMPRA
		INSERT INTO [DE_UNA].Compras
			VALUES(@cod_publi, @cod_usuario, @fecha_compra, @monto, @cantidad, @cod_calificacion, @estrellas, @desc_calificacion);
		
		--Actualizo la cantidad en la publicación
		UPDATE [DE_UNA].Publicaciones SET stock = (stock - @cantidad) WHERE cod_publi = @cod_publi

		--Cambia estado de una publicacion a finalizada LMoglia 08072016
		IF((@stock - @cantidad) = 0)
			UPDATE [DE_UNA].Publicaciones SET cod_estado = 5 WHERE cod_publi = @cod_publi;
	COMMIT TRAN COMPRA
	RETURN 1;
END
GO
