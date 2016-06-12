using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class RolesHandler
    {
        public static List<Rol> GetRoles()
        {
            return Rol.GetRoles(true);
        }

    }
}
