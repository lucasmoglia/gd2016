﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace ME.Data
{
    public enum TipoAccion { Mod, View, New, Buy }

    public class Publicacion
    {
        public decimal  cod_publi          { get; set; }
        public string   descripcion        { get; set; }
        public ulong    stock              { get; set; }
        public DateTime fecha_inicio       { get; set; }
        public DateTime fecha_vencimiento  { get; set; }
        public decimal  precio_producto    { get; set; }

        public Visibilidad     visibilidad { get; set; }
        public string descr_visibilidad { get { return this.visibilidad.descripcion; }  }

        public Estado          estado      { get; set; }
        public string descr_estado { get { return this.estado.nombre; } }
        public Rubro           rubro       { get; set; }
        public string descr_rubro { get { return this.rubro.desc_larga; } }
//        public UsuarioModel    usuario     { get; set; }
        public decimal  cod_usuario        { get; set; }
        public string   username           { get; set; }

        public TipoPublicacion tipo_publi { get; set; }
        public string descr_tipo_publi { get { return this.tipo_publi.nombre; } }

        public bool con_envio              { get; set; }
        public bool con_preguntas          { get; set; }
        public DateTime ? fecha_finalizacion { get; set; }
        public decimal reputacion { get; set; }


        public Publicacion(decimal cod_publi, string descripcion, ulong stock, DateTime fecha_inicio, DateTime fecha_vencimiento, decimal precio_producto,
                           decimal cod_visibilidad, string visibilidad, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio,
                           decimal cod_estado, string estado, decimal cod_rubro, string desc_corta, string desc_larga, decimal cod_usuario, string username, 
                           decimal cod_tipo_publi, string tipo_publicacion, bool con_envio, bool con_preguntas, DateTime? fecha_finalizacion, decimal reputacion)
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
            this.fecha_finalizacion = fecha_finalizacion == DateTime.MinValue ? null : fecha_finalizacion;
            this.reputacion = reputacion;
        }

        public string Descr_visibilidad() {
            return this.visibilidad.descripcion;
        }

        public static decimal Crear(string descripcion, decimal stock, DateTime fechaInicio, DateTime fechaVenc, decimal precio, decimal cod_visibilidad,
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

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                return reader.Read() ? decimal.Parse(reader["cod_publi"].ToString()) : 0;
            }
        }

        public static decimal Save(decimal cod_publi, string descripcion, decimal stock, DateTime fechaInicio, DateTime fechaVenc, decimal precio, decimal cod_visibilidad,
                                  decimal cod_estado, decimal cod_rubro, decimal cod_usuario, decimal cod_tipo_publi, bool con_envio, bool con_preguntas,
                                  DateTime ? fecha_finaliz)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[ActualizarPublicacion]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@cod_publi", SqlDbType.Decimal).Value = cod_publi;
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

                if (fecha_finaliz == null) {
                    command.Parameters.Add("@fecha_finaliz", SqlDbType.DateTime).Value = DBNull.Value;
                } else {
                    command.Parameters.Add("@fecha_finaliz", SqlDbType.DateTime).Value = fecha_finaliz;
                }

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                return reader.Read() ? decimal.Parse(reader["cod_publi"].ToString()) : 0;
            }
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
                        , reader["fecha_finalizacion"] != DBNull.Value ? DateTime.Parse(reader["fecha_finalizacion"].ToString()) : DateTime.MinValue
                        , 0
                    );

                    return publicacion;
                } else {
                    return null;
                }
            }
        }

        public static List<Publicacion> GetPublicaciones(bool quiereComprar, /*List<decimal>*/ string rubros, string descripcion, decimal cod_usuario)
        {
            List<Publicacion> publicacionList = new List<Publicacion>();

            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[GetPublicaciones]", connection);
                command.CommandType = CommandType.StoredProcedure;

                //command.Parameters.Add("@estado", SqlDbType.Decimal).Value = estado;

                //DataTable rubrosTable = null;

                //if (rubros != null) {
                //    rubrosTable = new DataTable(); // Crea el Tipo Tabla Rubros, para pasar por parámetro.
                //    rubrosTable.Columns.Add("cod_rubro", typeof(decimal));

                //    for (var i = 0; i < rubros.Count(); i++) {
                //        rubrosTable.Rows.Add(new Object[] { rubros[i] });
                //    }
                //}
                
                //SqlParameter param_Rubros = command.Parameters.AddWithValue("@rubros", rubrosTable);
                //param_Rubros.SqlDbType = SqlDbType.Structured;
                //param_Rubros.TypeName = "[DE_UNA].Rubros";

                command.Parameters.Add("@rubros", SqlDbType.NVarChar).Value = rubros;
                command.Parameters.Add("@descripcion", SqlDbType.NVarChar).Value = descripcion;
                command.Parameters.Add("@usuario", SqlDbType.Decimal).Value = cod_usuario;
                command.Parameters.Add("@quiereComprar", SqlDbType.Bit).Value = quiereComprar;
                
                // parámetros para la paginación.
                command.Parameters.Add("@PageSize", SqlDbType.Int).Value = Globales.TamanioPag_Publi;  
                command.Parameters.Add("@PageNumber", SqlDbType.Int).Value = Globales.NumPag_Publi += 1;

                SqlParameter param_TotalPags = new SqlParameter("@TotalPags", SqlDbType.Int);
                param_TotalPags.Direction = ParameterDirection.Output;
                command.Parameters.Add(param_TotalPags);

                SqlParameter param_BloquePags = new SqlParameter("@bloqueDePaginas", SqlDbType.Int);
                param_BloquePags.Direction = ParameterDirection.Output;
                command.Parameters.Add(param_BloquePags);

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
                        , reader["fecha_finalizacion"] != DBNull.Value ? DateTime.Parse(reader["fecha_finalizacion"].ToString()) : DateTime.MinValue
                        , decimal.Parse(reader["reputacion"].ToString())
                    );

                    publicacionList.Add(publicacion);
                }
            }

            return publicacionList;
        }

        
        // función que finaliza las subastas que vencen hoy generando la compra asociada a la subasta ganadora.
        // asimismo finaliza las publicaciones de Compra Inmediata que vencen hoy.
        public static void finalizarPublicaciones()
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[FinalizaPublicaciones]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@hoy", SqlDbType.DateTime).Value = DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString());

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
            }
        }    
    
    
    }
}
