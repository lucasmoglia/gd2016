using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class VisibilidadHandler
    {
        public static Visibilidad ObtenerVisibilidad(decimal cod_visibilidad)
        {
            return Visibilidad.GetVisibilidad(cod_visibilidad);
        }

        public static List<Visibilidad> ListarVisibilidades()
        {
            return Visibilidad.GetVisibilidades();
        }
    }
}
