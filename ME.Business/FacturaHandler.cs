using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class FacturaHandler
    {
        public static List<Factura> ListarFacturas(DateTime ? fecha_desde, DateTime ? fecha_hasta, decimal monto_minimo, decimal monto_maximo, string detalle_facturado)
        {
            List<Factura> facturas = new List<Factura>();

            if (detalle_facturado != null) {
                List<decimal> nrosfactura = Item.buscarXdetalle(UserLogged.cod_usuario, detalle_facturado);

                facturas.AddRange(Factura.GetFacturas(nrosfactura, fecha_desde, fecha_hasta, monto_minimo, monto_maximo));

                for (int i = 0; i <= facturas.Count; i++) 
                {
                    facturas.ElementAt(i).items.AddRange(Item.GetItems(facturas.ElementAt(i).num_factura, null));
                }
                nrosfactura.Clear();
                return facturas;
            } else{

                facturas.AddRange(Factura.GetFacturas(null, fecha_desde, fecha_hasta, monto_minimo, monto_maximo)); //chequear si anda mandando el primer parametro (una tabla) como null

                for (int i = 0; i <= facturas.Count; i++) 
                {
                    facturas.ElementAt(i).items.AddRange(Item.GetItems(facturas.ElementAt(i).num_factura, null));
                }
            
             }

        return facturas;
        }
    }
}
