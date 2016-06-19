using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;
using System.Data.SqlClient;

namespace ME.Business
{
    public class RolHandler
    {
        public static Rol ObtenerRol(decimal cod_rol)
        {
            return Rol.GetRol(cod_rol);
        }

        public static List<Rol> ListarRoles(bool activeOnly)
        {
            return Rol.GetRoles(activeOnly);
        }

        public static int Nuevo(string nombre, List<FuncionalidadModel> funcionalidades)
        {
            decimal[] funcionalidades_id = new decimal[funcionalidades.Count];
            for(var i=0; i < funcionalidades.Count; i++)
            {
                funcionalidades_id[i] = funcionalidades[i].cod_funcionalidad;
            }

            return Rol.Nuevo(nombre, funcionalidades_id);
        }

        public static void Actualizar(decimal cod_rol, string descripcion, List<FuncionalidadModel> funcionalidades)
        {
            decimal[] ids_funcionalidades = new decimal[funcionalidades.Count];
            for (var i = 0; i < funcionalidades.Count; i++)
            {
                ids_funcionalidades[i] = funcionalidades[i].cod_funcionalidad;
            }

            Rol.Actualizar(cod_rol, ids_funcionalidades);
        }
    
        public static void Eliminar (decimal cod_rol)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_rol", cod_rol));
            MEEntity.ExecuteSP("[DE_UNA].[SetRolInactivo]", parameters);
        }
    }
}
