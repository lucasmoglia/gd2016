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
        public List<FuncionalidadModel> funcionalidades { get; set; }

        public Rol(decimal cod_rol, string nombre)
        {
            this.cod_rol = cod_rol;
            this.nombre = nombre;
            this.funcionalidades = null;
        }

        public static Rol GetRol(decimal cod_rol)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRol]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_rol", SqlDbType.Bit).Value = cod_rol;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    Rol unRol = new Rol(
                          int.Parse(reader["cod_rol"].ToString())
                        , reader["nombre"].ToString()
                    );

                    return unRol;
                }else
                {
                    return null;
                }
            }
        }


        public static List<Rol> GetRoles(bool? activeOnly)
        {
            List<Rol> rolesList = new List<Rol>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRoles]", connection);
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter param_cod_rol = command.Parameters.AddWithValue("@activeOnly", activeOnly);
                param_cod_rol.SqlDbType = SqlDbType.Bit;

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

        public static List<Rol> GetRolesDeUsuario(decimal cod_usuario)
        {
            List<Rol> rolesList = new List<Rol>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRolesDeUsuario]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Rol unRol = new Rol(
                          int.Parse(reader["cod_rol"].ToString())
                        , reader["nombre"].ToString()
                    );

                    rolesList.Add(unRol);
                }
            }

            return rolesList;
        }

        public static int Nuevo(string nombre, decimal[] funcionalidades)
        {
            int result = 0; 
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[NuevoRol]", connection);
                command.CommandType = CommandType.StoredProcedure;

                DataTable _dt;
                // create data table to insert items
                _dt = new DataTable();
                _dt.Columns.Add("cod_funcionalidad", typeof(decimal));

                for (var i = 0; i < funcionalidades.Count(); i++)
                {
                    _dt.Rows.Add(new Object[] { funcionalidades[i] });
                }

                SqlParameter param_cod_rol = command.Parameters.AddWithValue("@nombre", nombre);
                param_cod_rol.SqlDbType = SqlDbType.NVarChar;

                SqlParameter param_func = command.Parameters.AddWithValue("@funcionalidades", _dt);
                param_func.SqlDbType = SqlDbType.Structured;
                param_func.TypeName = "DE_UNA.FuncionalidadesList";

                connection.Open();
                command.ExecuteScalar();
            }

            return result;
        }
    
        public static void Actualizar(decimal cod_rol, decimal[] funcionalidades)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[ActualizarRol]", connection);
                command.CommandType = CommandType.StoredProcedure;

                DataTable _dt;
                // create data table to insert items
                _dt = new DataTable();
                _dt.Columns.Add("cod_funcionalidad", typeof(decimal));

                for (var i = 0; i < funcionalidades.Count(); i++)
                {
                    _dt.Rows.Add(new Object[] { funcionalidades[i] });
                }
                    
                SqlParameter param_cod_rol = command.Parameters.AddWithValue("@cod_rol", cod_rol);
                param_cod_rol.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_func = command.Parameters.AddWithValue("@funcionalidades", _dt);
                param_func.SqlDbType = SqlDbType.Structured;
                param_func.TypeName = "[DE_UNA].FuncionalidadesList";

                
                connection.Open();
                command.ExecuteScalar();
            }
        }
    }
}
