using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class RubrosHandler
    {
        public static List<Rubro> GetRubros()
        {
            return Rubro.GetRubros();
        }
    }
}
