using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class FuncionalidadModel{
        public decimal cod_funcionalidad { get; set; }
        public string descripcion { get; set; }
    
        public FuncionalidadModel(decimal cod_funcionalidad, string descripcion)
        {
            this.cod_funcionalidad = cod_funcionalidad;
            this.descripcion = descripcion;
        }
    }

    public class Funcionalidad
    {
        public static List<FuncionalidadModel> GetFuncionalidades(bool activeOnly)
        {
            List<FuncionalidadModel> funcionalidadList = new List<FuncionalidadModel>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetFuncionalidades]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    funcionalidadList.Add(new FuncionalidadModel(decimal.Parse(reader["cod_funcionalidad"].ToString()), reader["descripcion"].ToString()));
                }
            }

            return funcionalidadList;
        }

        public static List<FuncionalidadModel> GetFuncionalidadesByRol(decimal cod_rol)
        {
            List<FuncionalidadModel> funcionalidadList = new List<FuncionalidadModel>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetFuncionalidadesByRol]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_rol", SqlDbType.Bit).Value = cod_rol;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    funcionalidadList.Add(new FuncionalidadModel(decimal.Parse(reader["cod_funcionalidad"].ToString()), reader["descripcion"].ToString()));
                }
            }

            return funcionalidadList;
        }
    }
}
