using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Rol
    {
        public decimal cod_rol { get; set; }
        public string nombre { get; set; }

        public Rol(decimal cod_rol, string nombre)
        {
            this.cod_rol = cod_rol;

            this.nombre = nombre;
        }

        public static List<Rol> GetRoles(bool? activeOnly)
        {
            List<Rol> rolesList = new List<Rol>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRoles]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly ?? false;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Rol rol = new Rol(
                          int.Parse(reader["cod_rol"].ToString())
                        , reader["nombre"].ToString()
                    );

                    rolesList.Add(rol);
                }
            }

            return rolesList;
        }

        public static int Nuevo(string nombre, decimal[] funcionalidades)
        {
            int result = 0; 
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[CrearRol]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@nombre", SqlDbType.NVarChar).Value = nombre;
                command.Parameters.Add("@activo", SqlDbType.Bit).Value = true;
                command.Parameters.Add("@funcionalidades", SqlDbType.Structured).Value = funcionalidades;

                connection.Open();
                result = int.Parse(command.ExecuteScalar().ToString());
            }

            return result;
        }
    }
}
