using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

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

        public static int Nuevo(string descripcion, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            return Visibilidad.Nuevo(descripcion, costo_publicar, porcentaje_venta, costo_envio);
        }

        public static void Actualizar(decimal cod_visibilidad, string descripcion, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            Visibilidad.Actualizar(cod_visibilidad, descripcion, costo_publicar, porcentaje_venta, costo_envio);
        }

        public static void Eliminar(decimal cod_visibilidad)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_visibilidad", cod_visibilidad));
            MEEntity.ExecuteSP("[DE_UNA].[EliminarVisibilidad]", parameters);
        }
    }
}
