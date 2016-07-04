USE [GD1C2016]
GO
/****** Object:  StoredProcedure [DE_UNA].[GetItems]    Script Date: 02/07/2016 07:59:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [DE_UNA].[GetItems]
	-- Add the parameters for the stored procedure here
	@numFactura DECIMAL,
	@descripcionItem VARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [id_item], 
		   [num_factura],
		   [cod_item],
		   [descripcion_item],
		   [item_cantidad],
		   [item_monto]
	FROM [DE_UNA].[Items]
	WHERE [num_factura] = @numFactura AND
	      ([descripcion_item] = @descripcionItem OR @descripcionItem IS NULL)
END
