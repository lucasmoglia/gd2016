USE GD2015C1
GO
-- Practica SQL Ej. 1
select c.clie_codigo, c.clie_razon_social, c.clie_limite_credito
from Cliente C
where c.clie_limite_credito >= 1000
order by c.clie_codigo

-- Practica SQL Ej. 2
select P.prod_codigo, P.prod_detalle, F.fact_fecha, I.item_cantidad
from Producto P, Factura F, Item_Factura I
where I.item_producto = P.prod_codigo 
  AND F.fact_tipo = I.item_tipo AND F.fact_sucursal = I.item_sucursal AND F.fact_numero = I.item_numero
  AND year(F.fact_fecha) = 2012
order by I.item_cantidad

-- Practica SQL Ej. 3
select P.prod_codigo, P.prod_detalle, sum(S.stoc_cantidad) as "stock total"
from Producto P, STOCK S
where p.prod_codigo = S.stoc_producto
group by p.prod_codigo, p.prod_detalle
order by 2, 1

-- Practica SQL Ej. 4
select P.prod_codigo, P.prod_detalle, sum(S.stoc_cantidad) as "stock total"
from Producto P, STOCK S
where p.prod_codigo = S.stoc_producto 
group by p.prod_codigo, p.prod_detalle
having avg(S.stoc_cantidad)>100
order by 2, 1

-- Practica SQL Ej. 5
select P.prod_codigo, P.prod_detalle, sum(I.item_cantidad) as "cantidad vendida"
from Producto P, Factura F, Item_Factura I
where I.item_producto = P.prod_codigo 
  AND F.fact_tipo = I.item_tipo AND F.fact_sucursal = I.item_sucursal AND F.fact_numero = I.item_numero
  AND year(F.fact_fecha) = 2012
group by p.prod_codigo, p.prod_detalle
having sum(I.item_cantidad) > (
  select sum(I1.item_cantidad) from Item_Factura I1, Factura F1
  where I1.item_producto = P.prod_codigo 
    AND F1.fact_tipo = I1.item_tipo AND F1.fact_sucursal = I1.item_sucursal AND F1.fact_numero = I1.item_numero
    AND year(F1.fact_fecha) = 2011
  )
order by sum(i.item_cantidad) desc

-- Practica SQL Ej. 6
select r.rubr_id, r.rubr_detalle, count(p.prod_codigo) as "Cant. Articulos", sum(s.stoc_cantidad) as "Stock Total"
from Rubro R, Producto P, STOCK S
where p.prod_rubro = r.rubr_id and s.stoc_producto = p.prod_codigo
and s.stoc_cantidad > (SELECT stoc_cantidad FROM STOCK where stoc_producto = '00000000' and stoc_deposito = '00')
group by r.rubr_id, r.rubr_detalle

-- Practica SQL Ej. 7

-- Practica SQL Ej. 8
select p.prod_detalle, max(S.stoc_cantidad) as "Mayor stock Deposito"
from Producto P, STOCK S, DEPOSITO D
where P.prod_codigo = S.stoc_producto and d.depo_codigo = s.stoc_deposito
group by p.prod_codigo, p.prod_detalle
HAVING count(p.prod_detalle) = (SELECT count(*) from DEPOSITO)
order by 2 desc

-- Practica SQL Ej. 9
select E1.empl_codigo as "Codigo Jefe", E2.empl_codigo as "Codigo Empleado", E2.empl_nombre as "Nombre Empleado"
     , (select count(depo_encargado) from DEPOSITO where depo_encargado = E1.empl_codigo) as "Depositos Asignados al Jefe"
     , (select count(depo_encargado) from DEPOSITO where depo_encargado = E2.empl_codigo) as "Depositos Asignados al Empleado"
from Empleado E1, Empleado E2
where E2.empl_jefe = E1.empl_codigo
order by 1

-- Practica SQL Ej. 10
select * from (
select top 10 It.item_producto, sum(It.item_cantidad) as total
          , (
		  select top 1 F.fact_cliente -- comprador mayoritario
          from Factura F, Item_Factura I
		  where  F.fact_tipo = I.item_tipo AND F.fact_sucursal = I.item_sucursal AND F.fact_numero = I.item_numero
		       and It.item_producto = I.item_producto
			order by I.item_cantidad desc
		  ) as "Cliente Mayor Compra"
from Item_Factura It
group by It.item_producto
order by 2 desc
  -- 10 productos mas vendidos
union all
  -- 10 productos menos vendidos
select top 10 It.item_producto, sum(It.item_cantidad) as total
          , (
		  select top 1 F.fact_cliente -- comprador mayoritario
          from Factura F, Item_Factura I
		  where  F.fact_tipo = I.item_tipo AND F.fact_sucursal = I.item_sucursal AND F.fact_numero = I.item_numero
		       and It.item_producto = I.item_producto
			order by I.item_cantidad desc
		  ) as "Cliente Mayor Compra"
from Item_Factura It
group by It.item_producto
order by 2
)as tablaUnida

-- Practica SQL Ej. 11
select p.prod_familia, f.fami_detalle, count(i.item_producto) as "Cant Prod Vendidos", sum(i.item_precio) as "Monto Ventas sin Impuestos"
from Producto P, Familia F, Factura C, Item_Factura I
where p.prod_familia = f.fami_id and p.prod_codigo = I.item_producto
and c.fact_tipo = I.item_tipo and c.fact_sucursal = i.item_sucursal and c.fact_numero = i.item_numero
group by p.prod_familia, f.fami_detalle
--having ('select de la familia y sus ventas del año 2012 > 20000')
having (select sum(it.item_precio) from Item_Factura it, Producto pr, Familia fa, Factura ct
		where pr.prod_familia = fa.fami_id and pr.prod_codigo = It.item_producto
		and ct.fact_tipo = It.item_tipo and ct.fact_sucursal = it.item_sucursal and ct.fact_numero = it.item_numero
		and pr.prod_familia = p.prod_familia
		) > 2000
order by 3 desc

-- Practica SQL Ej. 12
select p.prod_codigo, p.prod_detalle, count(distinct C.clie_codigo) as "Clientes Distintos q lo compraron",
		avg(I.item_precio) as "importe promedio"
		,(select count(*) from STOCK S where s.stoc_producto = p.prod_codigo and s.stoc_cantidad > 0 ) as "Depositos con stock"
		,(select sum(s.stoc_cantidad) from STOCK S where s.stoc_producto = p.prod_codigo) as "Stock Actual"
--		,(select sum(I.item_precio) from Item_Factura I where I.item_producto = P.prod_codigo) as "Importe vendido"
from Producto P, Cliente C, Factura F, Item_Factura I
where f.fact_tipo = I.item_tipo and f.fact_sucursal = I.item_sucursal and F.fact_numero = i.item_numero
	and p.prod_codigo = I.item_producto
	and c.clie_codigo = F.fact_cliente
	and year(F.fact_fecha) = 2012
group by p.prod_codigo, p.prod_detalle

order by (select sum(I.item_cantidad * I.item_precio) from Item_Factura I where I.item_producto = P.prod_codigo) desc

-- Practica SQL Ej. 13
select X.prod_codigo, X.prod_detalle, X.prod_precio, sum(X.Precio_Calculado) as "Precio Total"
from 
		(select P.prod_codigo, P.prod_detalle, P.prod_precio
				,(C.comp_cantidad * (select PR.prod_precio  
								from Producto PR 
								where PR.prod_codigo = C.comp_componente
								)
				) as "Precio_Calculado"
		from Producto P, Composicion C
		where p.prod_codigo = c.comp_producto
		) X
group by X.prod_codigo, X.prod_detalle, X.prod_precio


-- Practica SQL Ej. 14
select
C.clie_codigo
,(select count(*)          from Factura F 
		where F.fact_cliente = C.clie_codigo and cast(F.fact_fecha as date) > cast(dateadd(day,-2365,getdate()) As Date)) as "Cant_Compras_Ult_Año"
,(select isnull(avg(F.fact_total),0) from Factura F 
		where F.fact_cliente = C.clie_codigo and cast(F.fact_fecha as date) > cast(dateadd(day,-2365,getdate()) As Date)) as "Promedio_por_Compra_Ult_Año"
,(select isnull(count(distinct I.item_producto),0) from Factura F, Item_Factura I
		where F.fact_tipo = I.item_tipo and F.fact_sucursal = I.item_sucursal and F.fact_numero = I.item_numero
		and F.fact_cliente = C.clie_codigo and cast(F.fact_fecha as date) > cast(dateadd(day,-2365,getdate()) As Date)) as "Cant_Prod_Dif_Ult_Año"
,(select isnull(max(F.fact_total),0) from Factura F 
		where F.fact_cliente = C.clie_codigo and cast(F.fact_fecha as date) > cast(dateadd(day,-2365,getdate()) As Date)) as "Mayor_Compra_Ult_Año"
from Cliente C
order by 2 desc

-- Practica SQL Ej. 15



-- Ej 13 de otro 
select 
	p.prod_detalle,
	p.prod_precio,
	(
	select sum(compuesto.prod_precio * c.comp_cantidad) from Producto p1 
	inner join Composicion c on p1.prod_codigo = c.comp_producto
	inner join Producto compuesto on compuesto.prod_codigo = c.comp_componente
	where
		p1.prod_codigo = p.prod_codigo
	) as sumatoria   -- Entiendo que el enunciado pide la sumatoria de los precios de los componentes multiplicados por la cantidad de componentes necesarios
	
from Producto p 
inner join Composicion c on p.prod_codigo = c.comp_producto
group by p.prod_codigo,prod_detalle,p.prod_precio
having count(c.comp_producto) > 2
order by count(c.comp_producto)  desc