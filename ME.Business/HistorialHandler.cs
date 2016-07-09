using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ME.Business
{
    public class HistorialHandler
    {

        public static List<Historial> ListarHistorial(decimal cod_usuario)
        {
            return Historial.GetHistorial(cod_usuario);
        }

    }
}
