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
        public string documento_tipo { get; set; }

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
        public string username { get; set; }
        public decimal login_fallidos { get; set; }
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

        public static int Eliminar(decimal cod_usuario, DateTime fecha_actual)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_usuario", cod_usuario));
            parameters.Add(new SqlParameter("@fecha_actual", cod_usuario));

            return MEEntity.ExecuteSP("[DE_UNA].[EliminarUsuario]", parameters);
        }

        public static UsuarioModel GetUsuario(decimal cod_usuario)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetUsuario]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                reader.Read();

                UsuarioModel unUsuario = new UsuarioModel()
                    {
                         dni = reader["dni"].ToString()
                        ,nombre = reader["nombre"].ToString()
                        ,apellido = reader["apellido"].ToString()
                        ,cuit = reader["cuit"].ToString()
                        ,razon_social = reader["razon_social"].ToString()
                        ,dir_ciudad = reader["dir_ciudad"].ToString()
                        ,nombre_contacto = reader["nombre_contacto"].ToString()
                        ,rubro = reader["rubro"].ToString()
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

                return unUsuario;
            }
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
                    UsuarioModel unUsuario = new UsuarioModel()
                    {
                         cod_usuario = decimal.Parse(reader["cod_usuario"].ToString())
                        ,nombre = reader["nombre"].ToString()
                        ,apellido = reader["apellido"].ToString()
                        ,dni = reader["dni"].ToString()
                        ,documento_tipo = reader["documento_tipo"].ToString()
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

                    usuarioList.Add(unUsuario);
                }
            }

            return usuarioList;
        }

        public static int ResetPassword(decimal cod_usuario, string password)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_usuario", cod_usuario));
            parameters.Add(new SqlParameter("@password", password));

            return MEEntity.ExecuteSP("[DE_UNA].[ResetPassword]", parameters);
        }

        public static int Desbloquear(decimal cod_usurio)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_usuario", cod_usurio));

            return MEEntity.ExecuteSP("[DE_UNA].[DesbloquearUsuario]", parameters);

        }


/*        public static decimal reputacion(decimal cod_usuario)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@cod_usuario", cod_usuario));

            return MEEntity.ExecuteSP("DE_UNA.ReputacionVendedor", parameters);
        }
        */



        public static decimal reputacion(decimal cod_usuario)
        {
            decimal unValor = 0;
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[ReputacionVendedor]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                    unValor=decimal.Parse(reader[0].ToString());
                return unValor;
            }
        }




        /*
        public static decimal reputacion(decimal cod_usuario)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("select * from [DE_UNA].fn_Get_Reputacion_Vendedor(@cod_usuario)", connection);
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                return decimal.Parse(reader[0].ToString());

            }
        }
*/





    }
}
