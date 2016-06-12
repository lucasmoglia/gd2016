using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class MEEntity
    {
        //Crea un objeto para la conexión a la base de datos
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["gd2016"].ToString());
        }

        public object ExecuteFn(string fnName, List<SqlParameter> parameters)
        {
            object result = "";

            using (SqlConnection connection = GetConnection())
            {
                SqlDataAdapter da2 = new SqlDataAdapter();
                string query = "Execute DE_UNA." + fnName + "(";
                SqlCommand command = new SqlCommand(query, connection);
                if (parameters.Count > 0)
                {
                    command.Parameters.AddRange(parameters.ToArray());
                }
                result = command.ExecuteScalar();
            }

            return result;
        }

        public static int ExecuteSP(string spName, List<SqlParameter> parameters)
        {
            string result;

            using (SqlConnection connection = GetConnection())
            {
                using (SqlCommand command = new SqlCommand(spName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    if (parameters.Count > 0)
                    {
                        command.Parameters.AddRange(parameters.ToArray());
                    }

                    connection.Open();
                    result = command.ExecuteScalar().ToString();
                }
            }

            return int.Parse(result);
        }
    }
}
