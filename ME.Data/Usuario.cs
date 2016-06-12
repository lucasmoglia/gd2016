using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class UsuarioModel
    {
        public decimal cod_usuario { get; set; }
        public string username { get; set; }
        public bool activo { get; set; }
        public string mail { get; set; }
        public string telefono { get; set; }
        public string dir_calle { get; set; }
        public string dir_nro { get; set; }
        public string dir_piso { get; set; }
        public string dir_depto { get; set; }
        public string dir_localidad { get; set; }
        public string dir_cod_post { get; set; }
        public DateTime? fecha_nacimiento { get; set; }
        public decimal cod_rol { get; set; }
        public decimal cod_rubro { get; set; }

        //Cliente
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string dni { get; set; }

        //Empresa
        public string cuit { get; set; }
        public string razon_social { get; set; }
        public string dir_ciudad { get; set; }
        public string nombre_contacto { get; set; }
        public string rubro { get; set; }
    }

    public class Usuario
    {
        public decimal cod_usuario { get; set; }
        public decimal login_fallidos { get; set; }

        public string username { get; set; }
        public string password { get; set; }
        public bool activo { get; set; }
        public string mail { get; set; }
        public string telefono { get; set; }
        public string dir_calle { get; set; }
        public string dir_nro { get; set; }
        public string dir_piso { get; set; }
        public string dir_depto { get; set; }
        public string dir_localidad { get; set; }
        public string dir_cod_post { get; set; }
        public DateTime? fecha_nacimiento { get; set; }
        public DateTime fecha_alta { get; set; }
        public bool publ_sin_cargo { get; set; }
        public int cant_ventas { get; set; }
        public int sum_calificacion { get; set; }

        public static int Login(string username, string password)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@username", username));
            parameters.Add(new SqlParameter("@password", password));
            
            return MEEntity.ExecuteSP("[DE_UNA].[Login]", parameters);
        }

        public static List<UsuarioModel> GetUsuarios(bool activeOnly)
        {
            List<UsuarioModel> usuarioList = new List<UsuarioModel>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetGridUsuarios]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    UsuarioModel usuario = new UsuarioModel()
                    {
                         cod_usuario = decimal.Parse(reader["cod_usuario"].ToString())
                        ,nombre = reader["nombre"].ToString()
                        ,apellido = reader["apellido"].ToString()
                        ,dni = reader["dni"].ToString()
                        ,razon_social = reader["razon_social"].ToString()
                        ,dir_ciudad = reader["dir_ciudad"].ToString()
                        ,nombre_contacto = reader["nombre_contacto"].ToString()
                        ,rubro = reader["rubro"].ToString()
                        ,cuit = reader["cuit"].ToString()
                        ,mail = reader["mail"].ToString()
                        ,username = reader["username"].ToString()
                        ,activo = bool.Parse(reader["activo"].ToString())
                        ,telefono = reader["telefono"].ToString()
                        ,dir_calle = reader["dir_calle"].ToString()
                        ,dir_nro = reader["dir_nro"].ToString()
                        ,dir_piso = reader["dir_piso"].ToString()
                        ,dir_depto = reader["dir_depto"].ToString()
                        ,dir_localidad = reader["dir_localidad"].ToString()
                        ,dir_cod_post = reader["dir_cod_post"].ToString()
                        ,fecha_nacimiento = reader["fecha_nacimiento"].ToString() != "" ? DateTime.Parse(reader["fecha_nacimiento"].ToString()) : (DateTime?)null
                    };

                    usuarioList.Add(usuario);
                }
            }

            return usuarioList;
        }
    }
}
