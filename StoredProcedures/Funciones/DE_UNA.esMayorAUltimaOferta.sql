USE [GD1C2016]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	Función que comprueba si es una oferta mayor
--              a la última ofertada.
-- =============================================
CREATE FUNCTION [DE_UNA].esMayorAUltimaOferta
(
	-- Add the parameters for the function here
	@monto numeric(18, 2),
	@cod_publi numeric(18,0)
)
RETURNS bool
AS
BEGIN
	-- Declare the return variable here
	DECLARE @res bool;
	DECLARE @max_monto numeric (18,2) = (SELECT MAX(monto) FROM [DE_UNA].[Ofertas] WHERE cod_publi = @cod_publi);

	IF (@monto > @max_monto) 
		@res = 1
	ELSE
		@res = 0;

	-- Return the result of the function
	RETURN @res
END
GO

