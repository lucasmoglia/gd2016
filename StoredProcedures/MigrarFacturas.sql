USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[MigrarPublicaciones]    Script Date: 28/5/2016 6:30:04 p. m. ******/
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
CREATE PROCEDURE [dbo].[MigrarFacturas]
AS
BEGIN
	IF (SELECT COUNT(P.cod_publi) FROM Publicaciones P) > 0
	BEGIN
		PRINT 'Migrando facturas...'

		INSERT INTO [Facturas]
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
END
