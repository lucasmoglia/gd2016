using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Historial
    {   //Variables de la clase Historial
        public decimal Publicacion  { get; set; }
        public string Detalle { get; set; }
        public string Tipo { get; set; }
        public string Calificacion { get; set; }


        //Constructor de la clase Historial
        public Historial(decimal Publicacion, string Detalle, string Tipo, string Calificacion)
        {
            this.Publicacion    = Publicacion;
            this.Detalle        = Detalle;
            this.Tipo           = Tipo;
            this.Calificacion   = Calificacion;

        }


        //Funcion que lista todo el Historial del usuario
        public static List<Historial> GetHistorial(decimal cod_usuario)
        {
            List<Historial> historialList = new List<Historial>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetHistorial]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;


                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    do
                    {
                        Historial unHistorial = new Historial(
                              decimal.Parse(reader["Publicacion"].ToString())
                            , reader["Detalle"].ToString()
                            , reader["Tipo"].ToString()
                            , reader["Calificacion"].ToString()

                            );

                        historialList.Add(unHistorial);
                    } while (reader.Read());
                    return historialList;
                }
                else return null;
            }

        }


    }
}
