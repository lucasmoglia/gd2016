using System;
using System.Configuration;
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

        public static Int32 Crear(decimal cod_publi, decimal cod_usuario, decimal cantidad)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[CrearCompra]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_publi", SqlDbType.Decimal).Value = cod_publi;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@cantidad", SqlDbType.Int).Value = cantidad;
                command.Parameters.Add("@fecha_compra", SqlDbType.DateTime).Value = DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString());
    
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                return reader.Read() ? Int32.Parse(reader["id_compra"].ToString()) : 0;
            }
        }

        //intento de funcion que traiga la lista de compras no calificadas del usuario mediante una funcion en la BD
        public static List<Compra> GetComprasSinCalificar(decimal cod_usuario)
        {
            List<Compra> compraList = new List<Compra>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("SELECT * from DE_UNA.fn_Compras_Sin_Calificar(@cod_usuario)", connection);
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

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
        }


        //intento de funcion que traiga la lista de las ultimas 5 compras calificadas del usuario mediante una funcion en la BD
        public static List<Compra> Get5ComprasCalificadas(decimal cod_usuario)
        {
            List<Compra> compraList = new List<Compra>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("select * from DE_UNA.fn_Ultimas_5_Compras_Calificadas(@cod_usuario)", connection);
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read()) {
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
        }


        //intento de funcion que traiga la cantidad total de calificaciones otorgadas por el usuario mas un desglose por su cantidad de estrellas
        public static List<Calificaciones> GetComprasPorUsuario(decimal cod_usuario)
        {
            List<Calificaciones> califList = new List<Calificaciones>();
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("select * from DE_UNA.fn_Cant_Compras_Por_Usuario(@cod_usuario)", connection);
                command.CommandType = CommandType.Text;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.CommandTimeout = 0;
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Calificaciones unaLinea = new Calificaciones(
                              decimal.Parse(reader["Cant_Compras_Cliente"].ToString())
                            , decimal.Parse(reader["Compras_Con_5_Estrellas"].ToString())
                            , decimal.Parse(reader["Compras_Con_4_Estrellas"].ToString())
                            , decimal.Parse(reader["Compras_Con_3_Estrellas"].ToString())
                            , decimal.Parse(reader["Compras_Con_2_Estrellas"].ToString())
                            , decimal.Parse(reader["Compras_Con_1_Estrella"].ToString())
                            , decimal.Parse(reader["Sin_Calificar"].ToString())
                    );

                    califList.Add(unaLinea);
                }
                
                return califList;
            }
        }

        
        //Procedimiento que Califica una Compra 
        public static void Calificar(decimal id_compra, decimal estrellas, string desc_Calif)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[Calificar_Compra]", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@id_compra", SqlDbType.Decimal).Value = id_compra;
                command.Parameters.Add("@estrellas", SqlDbType.Decimal).Value = estrellas;
                command.Parameters.Add("@desc_Calif", SqlDbType.NVarChar).Value = desc_Calif;

                connection.Open();

                command.ExecuteScalar();
            }
        }
     }

    //Defino la clase Calificaciones para poder devolver la lista de GetComprasPorUsuario
    public class Calificaciones
    {
        // Atributos de la Clase Calificaciones
        public decimal  Total_Compras          { get; set; }
        public decimal  Estrellas_5            { get; set; }
        public decimal  Estrellas_4            { get; set; }
        public decimal  Estrellas_3            { get; set; }
        public decimal  Estrellas_2            { get; set; }
        public decimal  Estrellas_1            { get; set; }
        public decimal  Sin_Calificar          { get; set; }

        //constructor de la clase Compra

        public Calificaciones(decimal Cant_Compras_Cliente, decimal Compras_Con_5_Estrellas, decimal Compras_Con_4_Estrellas,
                              decimal Compras_Con_3_Estrellas, decimal Compras_Con_2_Estrellas, decimal Compras_Con_1_Estrella, decimal Sin_Calificar)
        {
            this.Total_Compras       = Cant_Compras_Cliente;
            this.Estrellas_5         = Compras_Con_5_Estrellas;
            this.Estrellas_4         = Compras_Con_4_Estrellas;
            this.Estrellas_3         = Compras_Con_3_Estrellas;
            this.Estrellas_2         = Compras_Con_2_Estrellas;
            this.Estrellas_1         = Compras_Con_1_Estrella;
            this.Sin_Calificar       = Sin_Calificar;
        }
    }
}
