using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Empresa
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
        public DateTime fecha_alta { get; set; }

        //Empresa
        public string cuit { get; set; }
        public string razon_social { get; set; }
        public string dir_ciudad { get; set; }
        public string nombre_contacto { get; set; }
        public string rubro { get; set; }

        public Empresa(decimal cod_usuario
                , string razon_social
                , string dir_ciudad
                , string nombre_contacto
                , string rubro
                , string cuit
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
                , DateTime fecha_alta)
        {
            this.cod_usuario = cod_usuario;
            this.razon_social = razon_social;
            this.dir_ciudad = dir_ciudad;
            this.nombre_contacto = nombre_contacto;
            this.rubro = rubro;
            this.cuit = cuit;
            this.mail = mail;
            this.username = username;
            this.activo = activo;
            this.telefono = telefono;
            this.dir_calle = dir_calle;
            this.dir_nro = dir_nro;
            this.dir_piso = dir_piso;
            this.dir_depto = dir_depto;
            this.dir_localidad = dir_localidad;
            this.dir_cod_post = dir_cod_post;
            this.fecha_alta = fecha_alta;
        }


        public static List<Empresa> GetAll(bool activeOnly)
        {
            List<Empresa> empresasList = new List<Empresa>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetEmpresas]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Empresa empresa = new Empresa(
                          int.Parse(reader["cod_usuario"].ToString())
                        , reader["razon_social"].ToString()
                        , reader["dir_ciudad"].ToString()
                        , reader["nombre_contacto"].ToString()
                        , reader["rubro"].ToString()
                        , reader["cuit"].ToString()
                        , reader["mail"].ToString()
                        , reader["username"].ToString()
                        , bool.Parse(reader["activo"].ToString())
                        , reader["telefono"].ToString()
                        , reader["dir_calle"].ToString()
                        , reader["dir_nro"].ToString()
                        , reader["dir_piso"].ToString()
                        , reader["dir_depto"].ToString()
                        , reader["dir_localidad"].ToString()
                        , reader["dir_cod_post"].ToString()
                        , DateTime.Parse(reader["fecha_alta"].ToString())
                    );

                    empresasList.Add(empresa);
                }
            }

            return empresasList;
        }

        public static int Guardar(string razon_social
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
                , decimal cod_usuario
                , DateTime fecha_actual)
        {
            int result = 0;

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[NuevaEmpresa]", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@razon_social", SqlDbType.NVarChar).Value = razon_social;
                command.Parameters.Add("@dir_ciudad", SqlDbType.NVarChar).Value = dir_ciudad;
                command.Parameters.Add("@nombre_contacto", SqlDbType.NVarChar).Value = nombre_contacto;
                command.Parameters.Add("@rubro", SqlDbType.NVarChar).Value = rubro;
                command.Parameters.Add("@cuit", SqlDbType.NVarChar).Value = cuit;
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
                command.Parameters.Add("@fecha_actual", SqlDbType.DateTime).Value = fecha_actual;

                connection.Open();
                result = int.Parse(command.ExecuteScalar().ToString());

            }

            return result;
        }
    }
}
