using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class TipoPublicacionHandler
    {
        public static List<TipoPublicacion> ListarTiposPublicacion()
        {
            //bool usuarioEmpresa = true;   //SACAR. Esto representa a un usuario Empresa.

            //if (usuarioEmpresa)
            //{
            //    return TipoPublicacion.GetTipoPublicacion("Compra Directa");
            //}
            return TipoPublicacion.GetTiposPublicacion();
        }
    }
}
