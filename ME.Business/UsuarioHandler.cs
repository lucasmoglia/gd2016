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
        public static string mensaje { get; set; }

        public int Login(string username, string password)
        {
            return Usuario.Login(username, password);
        }

        public static List<UsuarioModel> GetUsuarios(bool activeOnly)
        {
            return Usuario.GetUsuarios(activeOnly);
        }

        public static void ResetPassword(decimal cod_usuario, string password)
        {
            Usuario.ResetPassword(cod_usuario, password);
        }

        public static void Desbloquear(decimal cod_usuario)
        {
            Usuario.Desbloquear(cod_usuario);
        }

        public static void Eliminar(decimal cod_usuario, DateTime fecha_actual)
        {
            Usuario.Eliminar(cod_usuario, fecha_actual);
        }
    }
}
