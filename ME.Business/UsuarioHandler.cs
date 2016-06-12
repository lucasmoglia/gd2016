using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class UsuarioHandler
    {
        public int Login(string username, string password)
        {
            return Usuario.Login(username, password);
        }

        public static List<UsuarioModel> GetUsuarios(bool activeOnly)
        {
            return Usuario.GetUsuarios(activeOnly);
        }
    }
}
