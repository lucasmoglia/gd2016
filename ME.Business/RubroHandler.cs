using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class RubroHandler
    {
        public static Rubro ObtenerRubro(string rubro)
        {
            return Rubro.GetRubro(rubro);
        }

        public static List<Rubro> ListarRubros()
        {
            return Rubro.GetRubros();
        }
    }
}
