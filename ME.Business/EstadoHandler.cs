using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class EstadoHandler
    {
        //public static Estado ObtenerEstado(decimal cod_Estado)
        //{
        //    return Estado.GetEstado(cod_Estado);
        //}

        public static List<Estado> ListarEstados()
        {
            return Estado.GetEstados();
        }

    }
}
