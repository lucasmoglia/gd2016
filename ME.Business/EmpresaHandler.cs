using ME.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class EmpresaHandler
    {
        public static List<Empresa> GetAll()
        {
            return Empresa.GetAll(true);
        }

        public static int Guardar(
                string razon_social
                , string dir_ciudad
                , string nombre_contacto
                , string rubro
                , string cuit
                , string mail
                , string username
                , string password
                , bool activo
                , string telefono
                , string dir_calle
                , string dir_nro
                , string dir_piso
                , string dir_depto
                , string dir_localidad
                , string dir_cod_post
                , decimal cod_usuario)
        {
            return Empresa.Guardar(
                razon_social
                ,  dir_ciudad
                ,  nombre_contacto
                ,  rubro
                ,  cuit
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
                ,  cod_usuario);
        }
    }
}
