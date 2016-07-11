using System;
using System.Configuration;
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

        public static decimal crearFactura(decimal cod_publi, decimal valor)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GenerarFactura]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_publi", SqlDbType.Decimal).Value = cod_publi;
                command.Parameters.Add("@cantidad", SqlDbType.Int).Value = valor;
                command.Parameters.Add("@fecha", SqlDbType.DateTime).Value = DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString());

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                return reader.Read() == true ? decimal.Parse(reader["num_factura"].ToString()) : 0;
            }
        }

        public static Factura GetFactura(decimal num_factura)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetFactura]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Num_factura", SqlDbType.Decimal).Value = num_factura;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read()) {
                    Factura factura = new Factura(
                          decimal.Parse(reader["num_factura"].ToString())
                        , decimal.Parse(reader["cod_publi"].ToString())
                        , DateTime.Parse(reader["fecha_factura"].ToString())
                        , decimal.Parse(reader["total"].ToString())
                        , reader["forma_pago"].ToString()
                        , decimal.Parse(reader["cod_usuario"].ToString())
                        , null
                    );

                    return factura;
                } else {
                    return null;
                }
            }
        }

        public static List<Factura> GetFacturas(decimal cod_usuario, List<decimal> nros_facturas, DateTime ? fecha_desde, DateTime ? fecha_hasta, decimal ? monto_minimo, decimal ? monto_maximo)
        {
            List<Factura> facturaList = new List<Factura>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetFacturas]", connection);
                command.CommandType = CommandType.StoredProcedure;

                DataTable nrosFacturasTable = null;
                nrosFacturasTable = new DataTable(); // Crea el Tipo Tabla Rubros, para pasar por parámetro.
                nrosFacturasTable.Columns.Add("nro_factura", typeof(decimal));

                if (nros_facturas != null)
                {

                    for (var i = 0; i < nros_facturas.Count(); i++)
                    {
                        nrosFacturasTable.Rows.Add(new Object[] { nros_facturas[i] });
                    }
                }
                else
                {
                    nros_facturas = new List<decimal>();
                    nros_facturas.Add(0);
                    nrosFacturasTable.Rows.Add(nros_facturas[0]);
                }

                SqlParameter param_lista_facturas = command.Parameters.AddWithValue("@TablaNrosFacturas", nrosFacturasTable);
                param_lista_facturas.SqlDbType = SqlDbType.Structured;
                param_lista_facturas.TypeName = "[DE_UNA].ListaNrosFacturas";

                command.Parameters.Add("@usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@fechaDesde", SqlDbType.DateTime).Value = fecha_desde;
                command.Parameters.Add("@fechaHasta", SqlDbType.DateTime).Value = fecha_hasta;
                command.Parameters.Add("@montoMinimo", SqlDbType.Decimal).Value = monto_minimo;
                command.Parameters.Add("@montoMaximo", SqlDbType.Decimal).Value = monto_maximo;

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


    public class CabeceraFactura
    {
        public string nombre_apellido { get; set; }
        public string domicilio { get; set; }
        public string DNI_CUIT { get; set; }

        public CabeceraFactura(string nombre_apellido, string domicilio, string DNI_CUIT)
        {
            this.nombre_apellido = nombre_apellido;
            this.domicilio = domicilio;
            this.DNI_CUIT = DNI_CUIT;
        }

        public static CabeceraFactura GetDatosCabeceraFactura(decimal cod_usuario)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {

                SqlCommand command = new SqlCommand("[DE_UNA].[GetDatosCabeceraFactura]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    CabeceraFactura cabeceraFactura = new CabeceraFactura(
                          reader["nombre_apellido"].ToString()
                        , reader["domicilio"].ToString()
                        , reader["DNI_CUIT"].ToString()
                    );

                    return cabeceraFactura;
                }
                else
                {
                    return null;
                }
            }
        }
    }
}
