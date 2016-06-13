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
        public static List<FacturaModel> ListarFacturas(decimal usuario, DateTime fecha_desde, DateTime fecha_hasta)
        {
            return Factura.GetFacturas(usuario, fecha_desde, fecha_hasta);
        }
    }
}
