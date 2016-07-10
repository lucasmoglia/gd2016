using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Oferta
    {
        // Atributos de la Clase Oferta
        public decimal  id_oferta            { get; set; }
        public decimal  cod_publi            { get; set; }
        public decimal  cod_usuario          { get; set; }
        public DateTime fecha_oferta         { get; set; }
        public decimal  monto                { get; set; }

        //constructor de la clase Oferta
        public Oferta(decimal id_oferta, decimal cod_publi, decimal cod_usuario, DateTime fecha_oferta, decimal monto)
        {
            this.id_oferta         = id_oferta;
            this.cod_publi         = cod_publi;
            this.cod_usuario       = cod_usuario;
            this.fecha_oferta      = fecha_oferta;
            this.monto             = monto;
        }


        //funcion que trae la lista de las ofertas del usuario que recibe como parámetro mediante un SP en la BD
        public static List<Oferta> GetOfertas(decimal cod_usuario)
        {
            List<Oferta> ofertaList = new List<Oferta>();
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("DE_UNA.GetOfertas", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    do
                    {
                        Oferta unaOferta = new Oferta(
                              decimal.Parse(reader["id_oferta"].ToString())
                            , decimal.Parse(reader["cod_publi"].ToString())
                            , decimal.Parse(reader["cod_usuario"].ToString())
                            , DateTime.Parse(reader["fecha_oferta"].ToString())
                            , decimal.Parse(reader["monto"].ToString())
                            );
                        ofertaList.Add(unaOferta);
                    } while (reader.Read());
                    return ofertaList;
                }
                else return null;
            }
        }

        
    }

}
