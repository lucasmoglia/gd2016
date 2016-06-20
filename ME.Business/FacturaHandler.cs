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
        public static List<Factura> ListarFacturas(decimal cod_usuario, DateTime ? fecha_desde, DateTime ? fecha_hasta, decimal monto_minimo, decimal monto_maximo, string detalle_facturado)
        {
            List<decimal> nrosfactura = Item.buscarXdetalle(cod_usuario, detalle_facturado); // usar variable global para el cod_usuario

            List<Factura> facturas = new List<Factura>();

            for (int i = 0; i <= nrosfactura.Count; i++)
            {
                //Agrega una factura a la lista.
                facturas.Add(Factura.GetFactura(decimal.Parse(nrosfactura.ElementAt(i).ToString())));

                //Agrega los Items a la lista de items de la factura.
                facturas.ElementAt(i).items.AddRange(Item.GetItems(facturas.ElementAt(i).num_factura, null));
            }
            nrosfactura.Clear();

            return facturas;
        }
    }
}
