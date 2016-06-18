using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class RolHandler
    {
        public static Rol ObtenerRol(decimal cod_rol)
        {
            return Rol.GetRol(cod_rol);
        }

        public static List<Rol> ListarRoles()
        {
            return Rol.GetRoles(true);
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
    }
}
