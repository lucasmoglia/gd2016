using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Factura
    {
        public decimal num_factura { get; set; }
        public decimal cod_publi { get; set; }
        public DateTime fecha_factura { get; set; }
        public decimal total { get; set; }
        public string forma_pago { get; set; }
        public decimal cod_usuario { get; set; }

        public static List<Factura> GetFacturas(decimal usuario, DateTime? fecha_desde, DateTime? fecha_hasta)
        {
            List<Factura> facturaList = new List<Factura>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetFacturas]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Usuario", SqlDbType.NVarChar).Value = usuario;
                command.Parameters.Add("@Fecha_desde", SqlDbType.DateTime).Value = fecha_desde;
                command.Parameters.Add("@Fecha_hasta", SqlDbType.DateTime).Value = fecha_hasta;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Factura factura = new Factura(
                          decimal.Parse(reader["num_factura"].ToString())
                        , decimal.Parse(reader["cod_publi"].ToString())
                        , DateTime.Parse(reader["fecha_factura"].ToString())
                        , decimal.Parse(reader["total"].ToString())
                        , reader["forma_pago"].ToString()
                        , decimal.Parse(reader["cod_usuario"].ToString())
                    );

                    facturaList.Add(factura);
                }
            }

            return facturaList;
        }
    }
}
