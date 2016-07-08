using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ME.Business
{
    public class CompraHandler
    {


        public static List<Compra> ListarComprasSinCalificar(decimal cod_usuario)
        {
            return Compra.GetComprasSinCalificar(cod_usuario);
        }

        public static List<Compra> Listar5ComprasCalificadas(decimal cod_usuario)
        {
            return Compra.Get5ComprasCalificadas(cod_usuario);
        }

        public static List<Calificaciones> ListarComprasPorUsuario(decimal cod_usuario)
        {
            return Compra.GetComprasPorUsuario(cod_usuario);
        }

        public static void Calificar(decimal id_compra, decimal estrellas, string desc_Calif)
        {
            Compra.Calificar(id_compra, estrellas, desc_Calif);
        }


    }
}
