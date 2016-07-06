using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Compra
    {
        // Atributos de la Clase Compra
        public decimal  id_compra            { get; set; }
        public decimal  cod_publi            { get; set; }
        public decimal  cod_usuario          { get; set; }
        public DateTime fecha_compra         { get; set; }
        public decimal  monto                { get; set; }
        public decimal  cantidad             { get; set; }
        public decimal  cod_calificacion     { get; set; }
        public decimal  estrellas            { get; set; }
        public string   desc_calificacion    { get; set; }

        //constructor de la clase Compra
        public Compra(decimal id_compra, decimal cod_publi, decimal cod_usuario, DateTime fecha_compra, decimal monto, decimal cantidad, decimal cod_calificacion, decimal estrellas, string desc_calificacion)
        {
            this.id_compra         = id_compra;
            this.cod_publi         = cod_publi;
            this.cod_usuario       = cod_usuario;
            this.fecha_compra      = fecha_compra;
            this.monto             = monto;
            this.cantidad          = cantidad;
            this.cod_calificacion  = cod_calificacion;
            this.estrellas         = estrellas;
            this.desc_calificacion = desc_calificacion;
        }


        //intento de funcion que traiga la lista de compras no calificadas del usuario mediante una funcion en la BD
        public static List<Compra> GetComprasSinCalificar(decimal cod_usuario)
        {
            List<Compra> compraList = new List<Compra>();
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("SELECT * from DE_UNA.fn_Compras_Sin_Calificar(@cod_usuario)", connection);
//                command.CommandType = CommandType.StoredProcedure;
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;

                connection.Open();
//                SqlDataReader reader = command.ExecuteReader();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    while (reader.Read())
                    {
                        Compra unaCompra = new Compra(
                              decimal.Parse(reader["id_compra"].ToString())
                            , decimal.Parse(reader["cod_publi"].ToString())
                            , decimal.Parse(reader["cod_usuario"].ToString())
                            , DateTime.Parse(reader["fecha_compra"].ToString())
                            , decimal.Parse(reader["monto"].ToString())
                            , decimal.Parse(reader["cantidad"].ToString())
                            , decimal.Parse(reader["cod_calificacion"].ToString())
                            , decimal.Parse(reader["estrellas"].ToString())
                            , reader["desc_calificacion"].ToString()
                            );
                        compraList.Add(unaCompra);
                    }
                    return compraList;
                }
                else return null;
            }
        }


        //intento de funcion que traiga la lista de las ultimas 5 compras calificadas del usuario mediante una funcion en la BD
        public static List<Compra> Get5ComprasCalificadas(decimal cod_usuario)
        {
            List<Compra> compraList = new List<Compra>();
            using (SqlConnection connection = MEEntity.GetConnection())
            {
//                SqlCommand command = new SqlCommand("[DE_UNA].[fn_Ultimas_5_Compras_Calificadas]", connection);
                SqlCommand command = new SqlCommand("select * from DE_UNA.fn_Ultimas_5_Compras_Calificadas(@cod_usuario)", connection);
//                command.CommandType = CommandType.StoredProcedure;
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    while (reader.Read())
                    {
                        Compra unaCompra = new Compra(
                              decimal.Parse(reader["id_compra"].ToString())
                            , decimal.Parse(reader["cod_publi"].ToString())
                            , decimal.Parse(reader["cod_usuario"].ToString())
                            , DateTime.Parse(reader["fecha_compra"].ToString())
                            , decimal.Parse(reader["monto"].ToString())
                            , decimal.Parse(reader["cantidad"].ToString())
                            , decimal.Parse(reader["cod_calificacion"].ToString())
                            , decimal.Parse(reader["estrellas"].ToString())
                            , reader["desc_calificacion"].ToString()
                            );
                        compraList.Add(unaCompra);
                    }
                    return compraList;
                }
                else return null;
            }
        }














    }
}
