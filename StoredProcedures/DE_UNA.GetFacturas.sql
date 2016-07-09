USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [DE_UNA].[GetFacturas]
	@TablaNrosFacturas [DE_UNA].[ListaNrosFacturas] READONLY,
	@usuario DECIMAL(20),
	@fechaDesde DATETIME,
	@fechaHasta DATETIME,
	@montoMinimo NUMERIC (18,2),
	@montoMaximo NUMERIC (18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (SELECT 1 FROM @TablaNrosFacturas WHERE [nro_factura] = 0) IS NULL
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE [num_factura] IN (SELECT num_factura FROM @TablaNrosFacturas) AND
			  ([fecha_factura] >= @fechaDesde AND [fecha_factura] <= @fechaHasta) AND
			  ([total] >= @montoMinimo AND [total] <= @montoMaximo) AND
			    @usuario = [cod_usuario]
	ELSE
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE ([fecha_factura] >= @fechaDesde AND [fecha_factura] <= @fechaHasta) AND
			  ([total] >= @montoMinimo AND [total] <= @montoMaximo) AND
			    @usuario = [cod_usuario]

END
GO
