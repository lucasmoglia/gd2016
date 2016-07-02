USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================

CREATE PROCEDURE [DE_UNA].ActualizarVisibilidad 
	@cod_visibilidad  numeric(18,0),
	@descripcion      nvarchar(255),
	@costo_publicar   numeric(18,2),
	@porcentaje_venta numeric(18,2),
	@costo_envio      numeric(18,2)
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		update Visibilidades
			set descripcion			= @descripcion
				,costo_publicar		= @costo_publicar
				,porcentaje_venta	= @porcentaje_venta
				,costo_envio		= @costo_envio
			where cod_visibilidad	= @cod_visibilidad;
	END TRY
	BEGIN CATCH
		SELECT 
 			 ERROR_NUMBER()		AS ErrorNumber
			,ERROR_SEVERITY()	AS ErrorSeverity
			,ERROR_STATE()		AS ErrorState
			,ERROR_PROCEDURE()	AS ErrorProcedure
			,ERROR_LINE()		AS ErrorLine
			,ERROR_MESSAGE()	AS ErrorMessage;

		IF @@TRANCOUNT > 0 	ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0 		COMMIT TRANSACTION;
END
