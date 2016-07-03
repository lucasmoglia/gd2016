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
CREATE PROCEDURE [DE_UNA].[GetFacturas]
	@TablaNrosFacturas [DE_UNA].[ListaNrosFacturas] READONLY,
	@fechaDesde DATETIME,
	@fechaHasta DATETIME,
	@montoMinimo NUMERIC (18,2),
	@montoMaximo NUMERIC (18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (SELECT 1 FROM @TablaNrosFacturas) IS NOT NULL
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE [num_factura] IN (SELECT num_factura FROM @TablaNrosFacturas) AND
			  (([fecha_factura] <= @fechaHasta AND [fecha_factura] >= @fechaDesde) OR @fechaHasta IS NULL OR  @fechaDesde IS NULL) AND
			  (([total] <= @montoMaximo AND [total] >= @montoMinimo) OR @montoMinimo IS NULL OR @montoMaximo IS NULL)
	ELSE
		SELECT [num_factura],
				[cod_publi],
				[fecha_factura],
				[total],
				[forma_pago],
				[cod_usuario]
		FROM [DE_UNA].[Facturas]
		WHERE (([fecha_factura] BETWEEN @fechaDesde AND @fechaHasta) OR @fechaDesde IS NULL OR @fechaHasta IS NULL) AND
				(([total] BETWEEN @montoMinimo AND @montoMaximo) OR @montoMinimo IS NULL OR @montoMaximo IS NULL)

END
GO
