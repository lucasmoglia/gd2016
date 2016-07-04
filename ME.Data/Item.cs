using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Item
    {
        public decimal id_item { get; set; }
        public decimal num_factura { get; set; }
        public decimal cod_item { get; set; }
        public string descripcion_item { get; set; }
        public decimal item_cantidad { get; set; }
        public decimal item_monto { get; set; }

        public Item(decimal id_item, decimal num_factura, decimal cod_item, string descripcion_item, decimal item_cantidad, decimal item_monto)
        {
            this.id_item = id_item;
            this.num_factura = num_factura;
            this.cod_item = cod_item;
            this.descripcion_item = descripcion_item;
            this.item_cantidad = item_cantidad;
            this.item_monto = item_monto;
        }

        public static List<Item> GetItems(decimal num_factura, string descripcion_item)
        {
            List<Item> facturaList = new List<Item>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetItems]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@numFactura", SqlDbType.Decimal).Value = num_factura;
                command.Parameters.Add("@descripcionItem", SqlDbType.VarChar).Value = descripcion_item;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Item unItem = new Item(
                          decimal.Parse(reader["id_item"].ToString())
                        , decimal.Parse(reader["num_factura"].ToString())
                        , decimal.Parse(reader["cod_item"].ToString())
                        , reader["descripcion_item"].ToString()
                        , decimal.Parse(reader["item_cantidad"].ToString())
                        , decimal.Parse(reader["item_monto"].ToString())
                    );

                    facturaList.Add(unItem);
                }
            }

            return facturaList;
        }

        public static List<decimal> buscarXdetalle(decimal cod_usuario, string detalle_facturado)
        {
            List<decimal> numsFactura = new List<decimal>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[BuscarXDetalle]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = detalle_facturado;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    numsFactura.Add(decimal.Parse(reader["num_factura"].ToString()));
                }
            }
            return numsFactura;
        }
    }
}
