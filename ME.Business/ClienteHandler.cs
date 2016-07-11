using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class ClienteHandler
    {
        public static List<Cliente> GetAll()
        {
            return Cliente.GetAll(true);
        }

        public static int Guardar(
                          string nombre
                        , string apellido
                        , decimal dni
                        , string documento_tipo
                        , string mail
                        , string username
                        , string password
                        , bool activo
                        , string telefono
                        , string dir_calle
                        , decimal dir_nro
                        , decimal dir_piso
                        , string dir_depto
                        , string dir_localidad
                        , string dir_cod_post
                        , DateTime fecha_nacimiento
                        , decimal cod_usuario)
        {
            return Cliente.Guardar(
                           nombre
                        ,  apellido
                        ,  dni
                        ,  documento_tipo
                        ,  mail
                        ,  username
                        ,  password
                        ,  activo
                        ,  telefono
                        ,  dir_calle
                        ,  dir_nro
                        ,  dir_piso
                        ,  dir_depto
                        ,  dir_localidad
                        ,  dir_cod_post
                        ,  fecha_nacimiento
                        ,  cod_usuario);
        }
    }
}
