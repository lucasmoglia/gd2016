using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class FuncionalidadHandler
    {
        public static List<FuncionalidadModel> GetFuncionalidades()
        {
            return Funcionalidad.GetFuncionalidades(true);
        }

        public static List<FuncionalidadModel> GetFuncionalidadesByRol(decimal cod_rol)
        {
            return Funcionalidad.GetFuncionalidadesByRol(cod_rol);
        }
    }
}
