using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class ListadoEstadistico
    {
        public string Nombre { get; set; }
        public decimal Detalle { get; set; }

        public ListadoEstadistico(string nombre, decimal detalle)
        {
            this.Nombre = nombre;
            this.Detalle = detalle;
        }

        public static List<ListadoEstadistico> GetReporteVMMF(string mes, string anio)
        {
            List<ListadoEstadistico> result = new List<ListadoEstadistico>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("DE_UNA.ReporteMayorMontoFacturado", connection);
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter param_mes = command.Parameters.AddWithValue("@mes", mes);
                param_mes.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_anio = command.Parameters.AddWithValue("@anio", anio);
                param_anio.SqlDbType = SqlDbType.VarChar;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    ListadoEstadistico listadoEstadistico = new ListadoEstadistico(
                         reader["nombre"].ToString()
                        , decimal.Parse(reader["monto"].ToString())
                    );

                    result.Add(listadoEstadistico);
                }
            }

            return result;
        }

        public static List<ListadoEstadistico> GetReporteVMCF(string mes, string anio)
        {
            List<ListadoEstadistico> result = new List<ListadoEstadistico>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("DE_UNA.ReporteMayorCantidadFacturas", connection);
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter param_mes = command.Parameters.AddWithValue("@mes", mes);
                param_mes.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_anio = command.Parameters.AddWithValue("@anio", anio);
                param_anio.SqlDbType = SqlDbType.VarChar;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    ListadoEstadistico listadoEstadistico = new ListadoEstadistico(
                         reader["nombre"].ToString()
                        , decimal.Parse(reader["monto"].ToString())
                    );

                    result.Add(listadoEstadistico);
                }
            }

            return result;
        }

        public static List<ListadoEstadistico> GetReporteCMCPC(string mes, string anio, int rubro)
        {
            List<ListadoEstadistico> result = new List<ListadoEstadistico>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("DE_UNA.ReporteMayorCantProdComprados", connection);
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter param_mes = command.Parameters.AddWithValue("@mes", mes);
                param_mes.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_anio = command.Parameters.AddWithValue("@anio", anio);
                param_anio.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_rubro = command.Parameters.AddWithValue("@rubro", rubro);
                param_rubro.SqlDbType = SqlDbType.Decimal;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    ListadoEstadistico listadoEstadistico = new ListadoEstadistico(
                         reader["nombre"].ToString()
                        , decimal.Parse(reader["monto"].ToString())
                    );

                    result.Add(listadoEstadistico);
                }
            }

            return result;
        }

        public static List<ListadoEstadistico> GetReporteVMCPNV(string mes, string anio, int visibilidad)
        {
            List<ListadoEstadistico> result = new List<ListadoEstadistico>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("DE_UNA.ReporteMayorCantProdNoVendidos", connection);
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter param_mes = command.Parameters.AddWithValue("@trimestre", mes);
                param_mes.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_anio = command.Parameters.AddWithValue("@anio", anio);
                param_anio.SqlDbType = SqlDbType.VarChar;
                SqlParameter param_visibilidad = command.Parameters.AddWithValue("@visibilidad", visibilidad);
                param_visibilidad.SqlDbType = SqlDbType.Int;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    ListadoEstadistico listadoEstadistico = new ListadoEstadistico(
                         reader["nombre"].ToString()
                        , decimal.Parse(reader["monto"].ToString())
                    );

                    result.Add(listadoEstadistico);
                }
            }

            return result;
        }
    }
}
