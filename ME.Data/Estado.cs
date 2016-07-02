using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Estado
    {
        public decimal cod_estado { get; set; }
        public string  nombre     { get; set; }

        public Estado(decimal cod_estado, string nombre)
        {
            this.cod_estado = cod_estado;
            this.nombre     = nombre;
        }

        //public static Estado GetEstado(decimal cod_estado)
        //{
        //    using (SqlConnection connection = MEEntity.GetConnection())
        //    {
        //        SqlCommand command = new SqlCommand("[DE_UNA].[GetEstado]", connection);
        //        command.CommandType = CommandType.StoredProcedure;
        //        command.Parameters.Add("@cod_estado", SqlDbType.Decimal).Value = cod_estado;

        //        connection.Open();
        //        SqlDataReader reader = command.ExecuteReader();

        //        reader.Read();

        //        Estado unEstado = new Estado(
        //              decimal.Parse(reader["cod_estado"].ToString())
        //            , reader["descripcion"].ToString()
        //        );

        //        return unEstado;
        //    }
        //}

        public static List<Estado> GetEstados()
        {
            List<Estado> estadoList = new List<Estado>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetEstadosPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Estado unEstado = new Estado(
                          decimal.Parse(reader["cod_estado"].ToString())
                        , reader["descripcion"].ToString()
                    );

                    estadoList.Add(unEstado);
                }
            }

            return estadoList;
        }
    }
}
