using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Data
{
    public class Publicacion
    {
        public decimal  cod_publi          { get; set; }
        public string   descripcion        { get; set; }
        public ulong    stock              { get; set; }
        public DateTime fecha_inicio       { get; set; }
        public DateTime fecha_vencimiento  { get; set; }
        public decimal  precio_producto    { get; set; }

        public Visibilidad     visibilidad { get; set; }
        public Estado          estado      { get; set; }
        public Rubro           rubro       { get; set; }
        public UsuarioModel    usuario     { get; set; }
        public TipoPublicacion tipo_publi  { get; set; }

        public bool con_envio              { get; set; }
        public bool con_preguntas          { get; set; }


        public Publicacion(decimal cod_publi, string descripcion, ulong stock, DateTime fecha_inicio, DateTime fecha_vencimiento, decimal precio_producto,
                           decimal cod_visibilidad, string  visibilidad, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio,
                           decimal cod_estado, string  estado, decimal cod_rubro, string  desc_corta, string  desc_larga,
                           //UsuarioModel usuario, 
                           decimal cod_usuario, string username,decimal cod_tipo_publi, string tipo_publicacion, bool con_envio, bool con_preguntas)
        {
            this.cod_publi = cod_publi;
            this.descripcion = descripcion;
            this.stock = stock;
            this.fecha_inicio = fecha_inicio;
            this.fecha_vencimiento = fecha_vencimiento;
            this.precio_producto = precio_producto;
            this.visibilidad = new Visibilidad(cod_visibilidad, visibilidad, costo_publicar, porcentaje_venta, costo_envio);
            this.estado = new Estado(cod_estado, estado);
            this.rubro = new Rubro(cod_rubro, desc_corta, desc_larga);
            //this.usuario = usuario;
            this.cod_usuario = cod_usuario;
            this.username = username;
            this.tipo_publi = new TipoPublicacion(cod_tipo_publi, tipo_publicacion);
            this.con_envio = con_envio;
            this.con_preguntas = con_preguntas;
        }

        //public static int Login(string username, string password)
        //{
        //    List<SqlParameter> parameters = new List<SqlParameter>();
        //    parameters.Add(new SqlParameter("@username", username));
        //    parameters.Add(new SqlParameter("@password", password));
            
        //    return MEEntity.ExecuteSP("[DE_UNA].[Login]", parameters);
        //}

        public static List<Publicacion> GetPublicaciones(byte estado, List<decimal> rubros, string descripcion)
        {
            List<Publicacion> publicacionList = new List<Publicacion>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetPublicaciones]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@estado", SqlDbType.Byte).Value = estado;
                command.Parameters.Add("@rubros", SqlDbType.Structured).Value = rubros;
                command.Parameters.Add("@descripcion", SqlDbType.NVarChar).Value = descripcion;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Publicacion publicacion = new Publicacion(
                          decimal.Parse(reader["cod_publi"].ToString())
                        , reader["descripcion"].ToString()
                        , ulong.Parse(reader["stock"].ToString())
                        , DateTime.Parse(reader["fecha_inicio"].ToString())
                        , DateTime.Parse(reader["fecha_vencimiento"].ToString())
                        , decimal.Parse(reader["precio_producto"].ToString())
                        , decimal.Parse(reader["cod_visibilidad"].ToString())
                        , reader["visibilidad"].ToString()
                        , decimal.Parse(reader["costo_publicar"].ToString())
                        , decimal.Parse(reader["costo_publicar"].ToString())
                        , decimal.Parse(reader["porcentaje_venta"].ToString())
                        , decimal.Parse(reader["cod_estado"].ToString())
                        , reader["estado"].ToString()
                        , decimal.Parse(reader["cod_rubro"].ToString())
                        , reader["desc_corta"].ToString()
                        , reader["desc_larga"].ToString()
                        //, Usuario.GetUsuario(decimal.Parse(reader["cod_usuario"].ToString()))
                        , decimal.Parse(reader["cod_usuario"].ToString())
                        , reader["username"].ToString()
                        , decimal.Parse(reader["cod_tipo_publi"].ToString())
                        , reader["tipo_publi"].ToString()
                        , bool.Parse(reader["con_envio"].ToString())
                        , bool.Parse(reader["con_preguntas"].ToString())

                        //, Visibilidad.GetVisibilidad(decimal.Parse(reader["cod_visibilidad"].ToString()))
                        //, Estado.GetEstado(decimal.Parse(reader["cod_estado"].ToString()))
                        //, Rubro.GetRubro(decimal.Parse(reader["cod_rubro"].ToString()))
                        //, Usuario.GetUsuario(decimal.Parse(reader["cod_usuario"].ToString()))
                        //, TipoPubli.GetTipoPubli(decimal.Parse(reader["cod_tipo_publi"].ToString()))
                    );

                    publicacionList.Add(publicacion);
                }
            }

            return publicacionList;
        }
    }
}
