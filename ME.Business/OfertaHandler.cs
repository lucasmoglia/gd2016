using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ME.Business
{
    public class OfertaHandler
    {


        public static List<Oferta> ListarOfertas(decimal cod_usuario)
        {
            return Oferta.GetOfertas(cod_usuario);
        }



    }
}
