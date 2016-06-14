using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Visibilidad
    {
        public decimal   cod_visibilidad  { get; set; }
        public string  nombre           { get; set; }
        public decimal costo_publicar   { get; set; }
        public decimal porcentaje_venta { get; set; }
        public decimal costo_envio      { get; set; }

        public Visibilidad(decimal cod_visibilidad, string nombre, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            this.cod_visibilidad = cod_visibilidad;
            this.nombre = nombre;
            this.costo_publicar = costo_publicar;
            this.porcentaje_venta = porcentaje_venta;
            this.costo_envio = costo_envio;
        }

        public static Visibilidad GetVisibilidad(decimal cod_visibilidad)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetVisibilidad]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_visibilidad", SqlDbType.Decimal).Value = cod_visibilidad;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();

                Visibilidad unaVisibilidad = new Visibilidad(
                      decimal.Parse(reader["cod_visibilidad"].ToString())
                    , reader["descripcion"].ToString()
                    , decimal.Parse(reader["costo_publicar"].ToString())
                    , decimal.Parse(reader["porcentaje_venta"].ToString())
                    , decimal.Parse(reader["costo_envio"].ToString())
                );

                return unaVisibilidad;
            }
        }

        public static List<Visibilidad> GetVisibilidades(bool? activeOnly)
        {
            List<Visibilidad> visibilidadList = new List<Visibilidad>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetVisibilidades]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@activeOnly", SqlDbType.Bit).Value = activeOnly ?? false;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Visibilidad unaVisibilidad = new Visibilidad(
                          decimal.Parse(reader["cod_visibilidad"].ToString())
                        , reader["descripcion"].ToString()
                        , decimal.Parse(reader["costo_publicar"].ToString())
                        , decimal.Parse(reader["porcentaje_venta"].ToString())
                        , decimal.Parse(reader["costo_envio"].ToString())
                    );

                    visibilidadList.Add(unaVisibilidad);
                }
            }

            return visibilidadList;
        }
    }
}
