using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{


    public class Cliente
    {
        public decimal cod_usuario { get; set; }

        //usuario
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
        public DateTime fecha_nacimiento { get; set; }
        public DateTime fecha_alta { get; set; }
        public bool publ_sin_cargo { get; set; }
        public int cant_ventas { get; set; }

        //Cliente
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string dni { get; set; }

        public Cliente(decimal cod_usuario
                        , string nombre
                        , string apellido
                        , string dni
                        , string mail
                        , string username
                        , bool activo
                        , string telefono
                        , string dir_calle
                        , string dir_nro
                        , string dir_piso
                        , string dir_depto
                        , string dir_localidad
                        , string dir_cod_post
                        , DateTime fecha_nacimiento
                        , DateTime fecha_alta
                        , bool publ_sin_cargo
                        , int cant_ventas)
        {
            this.cod_usuario = cod_usuario;
            this.nombre = nombre;
            this.apellido = apellido;
            this.dni = dni;
            this.mail = mail;
            this.username= username;
            this.activo = activo;
            this.mail = mail;
            this.telefono = telefono;
            this.dir_calle = dir_calle;
            this.dir_nro = dir_nro;
            this.dir_piso = dir_piso;
            this.dir_depto = dir_depto;
            this.dir_localidad = dir_localidad;
            this.dir_cod_post = dir_cod_post;
            this.fecha_nacimiento = fecha_nacimiento;
            this.fecha_alta = fecha_alta;
            this.publ_sin_cargo = publ_sin_cargo;
            this.cant_ventas = cant_ventas;
        }

        public static List<Cliente> GetAll(bool activeOnly)
        {
            List<Cliente> usuariosList = new List<Cliente>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                
                SqlCommand command = new SqlCommand("[DE_UNA].[GetClientes]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Cliente usuario = new Cliente(
                          int.Parse(reader["cod_usuario"].ToString())
                        , reader["nombre"].ToString()
                        , reader["apellido"].ToString()
                        , reader["dni"].ToString()
                        , reader["username"].ToString()
                        , reader["mail"].ToString()
                        , bool.Parse(reader["activo"].ToString())
                        , reader["telefono"].ToString()
                        , reader["dir_calle"].ToString()
                        , reader["dir_nro"].ToString()
                        , reader["dir_piso"].ToString()
                        , reader["dir_depto"].ToString()
                        , reader["dir_localidad"].ToString()
                        , reader["dir_cod_post"].ToString()
                        , DateTime.Parse(reader["fecha_nacimiento"].ToString())
                        , DateTime.Parse(reader["fecha_alta"].ToString())
                        , bool.Parse(reader["publ_sin_cargo"].ToString() == "" ? "False" : reader["publ_sin_cargo"].ToString())
                        , int.Parse(reader["cant_ventas"].ToString())
                    );
                    
                    usuariosList.Add(usuario);
                }
            }

            return usuariosList;
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
                        , decimal cod_usuario
                        , DateTime fecha_actual)
        {
            int result = 0;

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[NuevoCliente]", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@cod_usuario", SqlDbType.NVarChar).Value = cod_usuario;
                command.Parameters.Add("@nombre", SqlDbType.NVarChar).Value = nombre;
                command.Parameters.Add("@apellido", SqlDbType.NVarChar).Value = apellido;
                command.Parameters.Add("@dni", SqlDbType.Decimal).Value = dni;
                command.Parameters.Add("@documento_tipo", SqlDbType.NVarChar).Value = documento_tipo;
                command.Parameters.Add("@mail", SqlDbType.NVarChar).Value = mail;
                command.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;
                command.Parameters.Add("@password", SqlDbType.NVarChar).Value = password;
                command.Parameters.Add("@activo", SqlDbType.Bit).Value = 1;
                command.Parameters.Add("@telefono", SqlDbType.NVarChar).Value = telefono;
                command.Parameters.Add("@dir_calle", SqlDbType.NVarChar).Value = dir_calle;
                command.Parameters.Add("@dir_nro", SqlDbType.Decimal).Value = dir_nro;
                command.Parameters.Add("@dir_piso", SqlDbType.Decimal).Value = dir_piso;
                command.Parameters.Add("@dir_depto", SqlDbType.NVarChar).Value = dir_depto;
                command.Parameters.Add("@dir_localidad", SqlDbType.NVarChar).Value = dir_localidad;
                command.Parameters.Add("@dir_cod_post", SqlDbType.NVarChar).Value = dir_cod_post;
                command.Parameters.Add("@fecha_nacimiento", SqlDbType.DateTime).Value = fecha_nacimiento;
                command.Parameters.Add("@fecha_actual", SqlDbType.DateTime).Value = fecha_actual;

                connection.Open();
                result = int.Parse(command.ExecuteScalar().ToString());
            }
                
            return result;
        }
    }
}
