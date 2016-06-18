USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 17/06/2016
-- Description:	SP para obtener un rubro por buscando por descripción.
-- =============================================
CREATE PROCEDURE [DE_UNA].GetRubro
	-- Add the parameters for the stored procedure here
	@descripcion nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 
		cod_rubro,
		desc_corta,
		desc_larga
	FROM [DE_UNA].Rubros
	WHERE desc_larga LIKE('%@descripcion%');
END
