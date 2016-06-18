using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class TipoPublicacion
    {
        public decimal cod_tipo_publi { get; set; }
        public string nombre          { get; set; }

        public TipoPublicacion(decimal cod_tipo_publi, string nombre)
        {
            this.cod_tipo_publi = cod_tipo_publi;
            this.nombre = nombre;
        }

        public static TipoPublicacion GetTipoPublicacion(string tipoPubli)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetTiposPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@tipo_publi", SqlDbType.NVarChar).Value = tipoPubli;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    TipoPublicacion unTipoPubli = new TipoPublicacion(
                          int.Parse(reader["cod_tipo_publi"].ToString())
                        , reader["descripcion"].ToString()
                    );

                    return unTipoPubli;
                }else
                {
                    return null;
                }
            }
        }


        public static List<TipoPublicacion> GetTiposPublicacion()
        {
            List<TipoPublicacion> tipoPubliList = new List<TipoPublicacion>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetTiposPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    TipoPublicacion unTipoPubli = new TipoPublicacion(
                          int.Parse(reader["cod_tipo_publi"].ToString())
                        , reader["descripcion"].ToString()
                    );

                    tipoPubliList.Add(unTipoPubli);
                }
            }

            return tipoPubliList;
        }
    }
}
