﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Factura
    {
        public decimal num_factura { get; set; }
        public decimal cod_publi { get; set; }
        public DateTime fecha_factura { get; set; }
        public decimal total { get; set; }
        public string forma_pago { get; set; }
        public decimal cod_usuario { get; set; }
        public List<Item> items { get; set; }

        public Factura(decimal num_factura, decimal cod_publi, DateTime fecha_factura,
                       decimal total, string forma_pago, decimal cod_usuario, List<Item> items)
        {
            this.num_factura   = num_factura;
            this.cod_publi     = cod_publi;
            this.fecha_factura = fecha_factura;
            this.total         = total;
            this.forma_pago    = forma_pago;
            this.cod_usuario   = cod_usuario;
            this.items         = items;
        }
    
        public static List<Factura> GetFacturas(decimal num_factura, DateTime fecha_desde, DateTime fecha_hasta, decimal monto_minimo, decimal monto_maximo)
        {
            List<Factura> facturaList = new List<Factura>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetFacturas]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Num_factura", SqlDbType.Decimal).Value = num_factura;
                command.Parameters.Add("@Fecha_desde", SqlDbType.DateTime).Value = fecha_desde;
                command.Parameters.Add("@Fecha_hasta", SqlDbType.DateTime).Value = fecha_hasta;
                command.Parameters.Add("@Monto_minimo", SqlDbType.Decimal).Value = monto_minimo;
                command.Parameters.Add("@Monto_maximo", SqlDbType.Decimal).Value = monto_maximo;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Factura factura = new Factura(
                          decimal.Parse(reader["num_factura"].ToString())
                        , decimal.Parse(reader["cod_publi"].ToString())
                        , DateTime.Parse(reader["fecha_factura"].ToString())
                        , decimal.Parse(reader["total"].ToString())
                        , reader["forma_pago"].ToString()
                        , decimal.Parse(reader["cod_usuario"].ToString())
                        , null
                    );

                    facturaList.Add(factura);
                }
            }

            return facturaList;
        }
    }
}
