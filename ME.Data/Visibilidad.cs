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
    {   //Variables de la clase Visibilidad
        public decimal cod_visibilidad  { get; set; }
        public string  descripcion      { get; set; }
        public decimal costo_publicar   { get; set; }
        public decimal porcentaje_venta { get; set; }
        public decimal costo_envio      { get; set; }

        //Constructor de la clase Visibilidad
        public Visibilidad(decimal cod_visibilidad, string descripcion, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            this.cod_visibilidad    = cod_visibilidad;
            this.descripcion        = descripcion;
            this.costo_publicar     = costo_publicar;
            this.porcentaje_venta   = porcentaje_venta;
            this.costo_envio        = costo_envio;
        }

        //Funcion que devuelve la visibilidad pedida
        public static Visibilidad GetVisibilidad(decimal cod_visibilidad)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetVisibilidad]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_visibilidad", SqlDbType.Decimal).Value = cod_visibilidad;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read()) {
                    Visibilidad unaVisibilidad = new Visibilidad(
                          decimal.Parse(reader["cod_visibilidad"].ToString())
                        , reader["descripcion"].ToString()
                        , decimal.Parse(reader["costo_publicar"].ToString())
                        , decimal.Parse(reader["porcentaje_venta"].ToString())
                        , decimal.Parse(reader["costo_envio"].ToString())
                    );

                    return unaVisibilidad;
                } else {
                    return null;
                }
            }
        }

        //Funcion que lista todas las visibilidades
        public static List<Visibilidad> GetVisibilidades()
        {
            List<Visibilidad> visibilidadList = new List<Visibilidad>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetVisibilidades]", connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
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
                    return visibilidadList;
                }
                else return null;
            }

        }

        //Procedimiento que Inserta un nuevo registro en la Tabla Visibilidades
        public static int Nuevo(string descripcion, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            int result = 0;
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[NuevaVisibilidad]", connection);
                command.CommandType = CommandType.StoredProcedure;

                SqlParameter param_descripcion = command.Parameters.AddWithValue("@descripcion", descripcion);
                param_descripcion.SqlDbType = SqlDbType.NVarChar;

                SqlParameter param_costo_publicar = command.Parameters.AddWithValue("@costo_publicar", costo_publicar);
                param_costo_publicar.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_porcentaje_venta = command.Parameters.AddWithValue("@porcentaje_venta", porcentaje_venta);
                param_porcentaje_venta.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_costo_envio = command.Parameters.AddWithValue("@costo_envio", costo_envio);
                param_costo_envio.SqlDbType = SqlDbType.Decimal;


                connection.Open();
                command.ExecuteScalar();
            }

            return result;
        }

        //Procedimiento que actualiza un registro existente en la Tabla Visibilidades
        public static void Actualizar(decimal cod_visibilidad, string descripcion, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[ActualizarVisibilidad]", connection);
                command.CommandType = CommandType.StoredProcedure;

                SqlParameter param_cod_visibilidad = command.Parameters.AddWithValue("@cod_visibilidad", cod_visibilidad);
                param_cod_visibilidad.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_descripcion = command.Parameters.AddWithValue("@descripcion", descripcion);
                param_descripcion.SqlDbType = SqlDbType.NVarChar;

                SqlParameter param_costo_publicar = command.Parameters.AddWithValue("@costo_publicar", costo_publicar);
                param_costo_publicar.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_porcentaje_venta = command.Parameters.AddWithValue("@porcentaje_venta", porcentaje_venta);
                param_porcentaje_venta.SqlDbType = SqlDbType.Decimal;

                SqlParameter param_costo_envio = command.Parameters.AddWithValue("@costo_envio", costo_envio);
                param_costo_envio.SqlDbType = SqlDbType.Decimal;


                connection.Open();
                command.ExecuteScalar();
            }
        }
 
    }
}
