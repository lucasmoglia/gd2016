using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Rubro
    {
        public decimal cod_rubro { get; set; }
        public string desc_corta { get; set; }
        public string desc_larga { get; set; }

        public Rubro(decimal cod_rubro, string desc_corta, string desc_larga)
        {
            this.cod_rubro = cod_rubro;
            this.desc_corta = desc_corta;
            this.desc_larga = desc_larga;
        }

        public static Rubro GetRubro(string rubro)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetRubro]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@rubro", SqlDbType.NVarChar).Value = rubro;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    Rubro unRubro = new Rubro(
                          decimal.Parse(reader["cod_rubro"].ToString())
                        , reader["desc_corta"].ToString()
                        , reader["desc_larga"].ToString()
                    );

                    return unRubro;
                } else {
                    return null;
                }

            }
        }

        public static List<Rubro> GetRubros()
        {
            List<Rubro> rubroList = new List<Rubro>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRubros]", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Rubro rubro = new Rubro(
                          int.Parse(reader["cod_rubro"].ToString())
                        , reader["desc_corta"].ToString()
                        , reader["desc_larga"].ToString()
                    );

                    rubroList.Add(rubro);
                }
            }

            return rubroList;
        }
    }
}
