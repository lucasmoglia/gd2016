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

        public static List<Rubro> GetRubros()
        {
            List<Rubro> rubrosList = new List<Rubro>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetRubros]", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Rubro rol = new Rubro(
                          int.Parse(reader["cod_rubro"].ToString())
                        , reader["desc_corta"].ToString()
                        , reader["desc_larga"].ToString()
                    );

                    rubrosList.Add(rol);
                }
            }

            return rubrosList;
        }
    }
}
