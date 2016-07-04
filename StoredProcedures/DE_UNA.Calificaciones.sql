/****** Objetos de BD para Calificar Compras ******/
/* ...queries a las tablas para revisar...
SELECT TOP 100 *
  FROM [GD1C2016].[gd_esquema].[Maestra]
  where Compra_Fecha is not null and Calificacion_Codigo is not null
  order by Calificacion_Codigo

SELECT TOP 100 *
  FROM [GD1C2016].[DE_UNA].[Compras]
*/
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
				sum_calificacion	= sum_calificacion	+ (select estrellas from inserted) --entiendo que inserted tiene 1 solo registro
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
	if @estrellas < 1 or @estrellas > 10	return 1
	if @id_compra = 0						return 1
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

create function DE_UNA.fn_Compras_Ultimas_5_Calificadas(@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve sus ultimas 5 calificaciones de compras u ofertas
returns table
as 
	return (
	select top 5 * from DE_UNA.Compras C 
		where c.cod_usuario = @cod_usuario and c.cod_calificacion is not null 
		order by c.desc_calificacion desc
	)
go
-- select * from fn_Compras_Ultimas_5_Calificadas(81)

Create function DE_UNA.fn_Compras_Por_Cliente (@cod_usuario decimal(20,0))
-- Funcion que recibe un usuario y devuelve Cantidad de compras y desglose de sus calificaciones por estrellas
	returns @Calificaciones_Cliente table(
			Cant_Compras_Cliente	int, Compras_Con_5_Estrellas	int, Compras_Con_4_Estrellas	int, 
			Compras_Con_3_Estrellas	int, Compras_Con_2_Estrellas	int, Compras_Con_1_Estrella	int)
as 
Begin
	declare @total int, @est5 int, @est4 int, @est3 int, @est2 int, @est1 int

	set @total	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario) as Cant_Compras_Cliente);
	set @est5	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and (C.estrellas=9 or C.estrellas =10)) as Compras_Con_5_Estrellas);
	set @est4	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and (C.estrellas=7 or C.estrellas =8)) as Compras_Con_4_Estrellas);
	set @est3	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and (C.estrellas=5 or C.estrellas =6)) as Compras_Con_3_Estrellas);
	set @est2	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and (C.estrellas=3 or C.estrellas =4)) as Compras_Con_2_Estrellas);
	set @est1	 = (select count(*) from (select distinct C.cod_publi, C.cod_usuario, C.fecha_compra, C.monto, C.cantidad from DE_UNA.Compras C where C.cod_usuario = @cod_usuario and (C.estrellas=1 or C.estrellas =2)) as Compras_Con_1_Estrella);
 
	insert into @Calificaciones_Cliente (Cant_Compras_Cliente, Compras_Con_5_Estrellas, Compras_Con_4_Estrellas, Compras_Con_3_Estrellas, Compras_Con_2_Estrellas, Compras_Con_1_Estrella)	
	values (@total, @est5, @est4, @est3, @est2, @est1)

	return
end
go
