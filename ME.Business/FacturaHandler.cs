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
        public static List<Factura> ListarFacturas(string cod_usuario, DateTime fecha_desde, DateTime fecha_hasta, decimal monto_minimo, decimal monto_maximo, string detalle_facturado)
        {
            List<decimal> facturasSolicitadas = Item.buscarXdetalle(cod_usuario, detalle_facturado); // usar variable global para el cod_usuario
            return Factura.GetFacturas(num_factura, fecha_desde, fecha_hasta, monto_minimo, monto_maximo);
        }
    }
}
