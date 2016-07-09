/****** Objetos de BD para Calificar Compras ******/
USE [GD1C2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Trigger TR_Compras_Calif_Vendedor
  -- Trigger que actualiza la reputación del vendedor cuando se califica una compra o subasta...
  on [DE_UNA].[Compras]
  after UPDATE as
  Begin
  if update(estrellas)
		begin
			-- Verifico que no esté cambiando la calificación de una compra ya calificada
			if ( select count (*) from deleted where estrellas is not null and estrellas != 0) > 0 rollback transaction
		
			-- luego hago el update de la calificación del vendedor
			begin transaction
				update DE_UNA.Usuarios SET 
				sum_calificacion	= sum_calificacion	+ (select estrellas from inserted) --inserted tiene 1 solo registro 
			  , cant_ventas			= cant_ventas		+ 1
				where DE_UNA.Usuarios.cod_usuario = (select P.cod_usuario from Publicaciones P, inserted I where I.cod_publi = P.cod_publi)
			commit transaction
		end
  end
go

Create procedure DE_UNA.Calificar_Compra
  @id_compra	numeric(18,0)
, @estrellas	numeric(18,0)
, @desc_Calif	nvarchar(255)
as
Begin
	-- validaciones
	if @estrellas < 1 or @estrellas > 5		return 1
	if @id_compra < 1						return 1
	-- Actualizo La Calificacion en la compra
	begin transaction
	update DE_UNA.Compras SET 
				estrellas			= @estrellas
			  , desc_calificacion	= @desc_Calif
			  , cod_calificacion	= (select max(cod_calificacion) from DE_UNA.Compras) + 1
				where id_compra		= @id_compra
	commit transaction
	return 0
end
go

create function DE_UNA.fn_Ultimas_5_Compras_Calificadas(@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve sus ultimas 5 calificaciones de compras u ofertas
returns table
as 
	return (
	select top 5 * from DE_UNA.Compras C 
		where c.cod_usuario = @cod_usuario and c.cod_calificacion is not null 
		order by c.cod_calificacion desc
	)
go


Create function DE_UNA.fn_Cant_Compras_Por_Cliente (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve Cantidad de compras y desglose de sus calificaciones por estrellas
	returns @Calificaciones_Cliente table(
			Cant_Compras_Cliente	int, Compras_Con_5_Estrellas	int, Compras_Con_4_Estrellas	int, 
			Compras_Con_3_Estrellas	int, Compras_Con_2_Estrellas	int, Compras_Con_1_Estrella	int)
as 
Begin
	declare @total int, @est5 int, @est4 int, @est3 int, @est2 int, @est1 int

	set @total	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario) as Cant_Compras_Cliente);
	set @est5	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=5) as Compras_Con_5_Estrellas);
	set @est4	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=4) as Compras_Con_4_Estrellas);
	set @est3	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=3) as Compras_Con_3_Estrellas);
	set @est2	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=2) as Compras_Con_2_Estrellas);
	set @est1	 = (select count(cod_usuario) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and C.estrellas=1) as Compras_Con_1_Estrella);
 
	insert into @Calificaciones_Cliente (Cant_Compras_Cliente, Compras_Con_5_Estrellas, Compras_Con_4_Estrellas, Compras_Con_3_Estrellas, Compras_Con_2_Estrellas, Compras_Con_1_Estrella)	
	values (@total, @est5, @est4, @est3, @est2, @est1)

	return
end
go

Create function DE_UNA.fn_Compras_Sin_Calificar (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve las compras aun no calificadas.
returns table
as 
	return (
	select id_compra, cod_publi, cod_usuario, fecha_compra, monto, cantidad, isnull(cod_calificacion,0) as cod_calificacion, isnull(estrellas,0) as estrellas, desc_calificacion from DE_UNA.Compras C 
		where c.cod_usuario = @cod_usuario 
			and (c.cod_calificacion is null or c.cod_calificacion = 0) 
	)
go

Create function DE_UNA.fn_Get_Reputacion_Vendedor (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve las compras aun no calificadas.
returns decimal(18,2)
as begin
	return (select (u.sum_calificacion / u.cant_ventas) 
			from DE_UNA.Usuarios U 
			where U.cod_usuario = @cod_usuario 
			)
	end
go