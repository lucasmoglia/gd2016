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
//        public UsuarioModel    usuario     { get; set; }
        public decimal  cod_usuario        { get; set; }
        public string   username           { get; set; }

        public TipoPublicacion tipo_publi { get; set; }

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

        public static Publicacion GetPublicacion(decimal cod_publi)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_publi", SqlDbType.Decimal).Value = cod_publi;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
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
                        , decimal.Parse(reader["cod_usuario"].ToString())
                        , reader["username"].ToString()
                        , decimal.Parse(reader["cod_tipo_publi"].ToString())
                        , reader["tipo_publi"].ToString()
                        , bool.Parse(reader["con_envio"].ToString())
                        , bool.Parse(reader["con_preguntas"].ToString())
                    );

                    return publicacion;
                } else {
                    return null;
                }
            }
        }

        public static List<Publicacion> GetPublicaciones(byte estado, List<decimal> rubros, string descripcion)
        {
            List<Publicacion> publicacionList = new List<Publicacion>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetPublicaciones]", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@estado", SqlDbType.Decimal).Value = estado;

                DataTable rubrosTable = null;

                if (rubros != null) {
                    rubrosTable = new DataTable(); // Crea el Tipo Tabla Rubros, para pasar por parámetro.
                    rubrosTable.Columns.Add("cod_rubro", typeof(decimal));

                    for (var i = 0; i < rubros.Count(); i++) {
                        rubrosTable.Rows.Add(new Object[] { rubros[i] });
                    }
                }
                
                SqlParameter param_Rubros = command.Parameters.AddWithValue("@rubros", rubrosTable);
                param_Rubros.SqlDbType = SqlDbType.Structured;
                param_Rubros.TypeName = "[DE_UNA].Rubros";

                command.Parameters.Add("@descripcion", SqlDbType.NVarChar).Value = descripcion;

                // parámetros para la paginación.
                command.Parameters.Add("@PageSize", SqlDbType.Int).Value = Globales.TamanioPag_Publi;
                command.Parameters.Add("@PageNumber", SqlDbType.Int).Value = Globales.NumPag_Publi += 1;

                SqlParameter param_TotalPags = new SqlParameter("@TotalPags", SqlDbType.Int);
                param_TotalPags.Direction = ParameterDirection.Output;
                command.Parameters.Add(param_TotalPags);


                SqlParameter param_BloquePags = new SqlParameter("@bloqueDePaginas", SqlDbType.Int);
                param_BloquePags.Direction = ParameterDirection.Output;
                command.Parameters.Add(param_BloquePags);

                //command.Parameters.Add("@TotalPags", SqlDbType.Int).Value = Globales.TotalPags_Publi;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Globales.TotalPags_Publi = Convert.ToInt32(command.Parameters["@TotalPags"].Value);
                Globales.PagsEnCache_Publi += Convert.ToInt32(command.Parameters["@bloqueDePaginas"].Value);

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
                        , decimal.Parse(reader["cod_usuario"].ToString())
                        , reader["username"].ToString()
                        , decimal.Parse(reader["cod_tipo_publi"].ToString())
                        , reader["tipo_publi"].ToString()
                        , bool.Parse(reader["con_envio"].ToString())
                        , bool.Parse(reader["con_preguntas"].ToString())

                        //, Usuario.GetUsuario(decimal.Parse(reader["cod_usuario"].ToString()))
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

        public static decimal Save(string descripcion, decimal stock, DateTime fechaInicio, DateTime fechaVenc, decimal precio, decimal cod_visibilidad,
                                  decimal cod_estado, decimal cod_rubro, decimal cod_usuario, decimal cod_tipo_publi, bool con_envio, bool con_preguntas)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[CrearPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@descripcion", SqlDbType.NVarChar).Value = descripcion;
                command.Parameters.Add("@stock", SqlDbType.Decimal).Value = stock;
                command.Parameters.Add("@fecha_inicio", SqlDbType.DateTime).Value = fechaInicio;
                command.Parameters.Add("@fecha_venc", SqlDbType.DateTime).Value = fechaVenc;
                command.Parameters.Add("@precio", SqlDbType.Decimal).Value = precio;
                command.Parameters.Add("@cod_visibilidad", SqlDbType.Decimal).Value = cod_visibilidad;
                command.Parameters.Add("@cod_estado", SqlDbType.Decimal).Value = cod_estado;
                command.Parameters.Add("@cod_rubro", SqlDbType.Decimal).Value = cod_rubro;
                command.Parameters.Add("@cod_usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@cod_tipo_publi", SqlDbType.Decimal).Value = cod_tipo_publi;
                command.Parameters.Add("@con_envio", SqlDbType.Bit).Value = con_envio;
                command.Parameters.Add("@con_preguntas", SqlDbType.Bit).Value = con_preguntas;
                //command.Parameters.Add("@cod_publi", SqlDbType.Decimal).Value = null;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read()) {
                    return decimal.Parse(reader["cod_publi"].ToString());
                } else {
                    return 0;
                }
            }
        }
    }
}
