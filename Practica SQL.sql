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
