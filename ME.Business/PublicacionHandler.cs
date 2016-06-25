using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ME.Data;

namespace ME.Business
{
    public class PublicacionHandler
    {
        public Publicacion CrearPublicacion(decimal cod_publi, string descripcion, ulong stock, DateTime fecha_inicio, DateTime fecha_vencimiento, decimal precio_producto,
                           decimal cod_visibilidad, string visibilidad, decimal costo_publicar, decimal porcentaje_venta, decimal costo_envio,
                           decimal cod_estado, string estado, decimal cod_rubro, string desc_corta, string desc_larga,
                           //UsuarioModel usuario, 
                           decimal cod_usuario, string username, decimal cod_tipo_publi, string tipo_publicacion, bool con_envio, bool con_preguntas)
        {
            return new Publicacion(cod_publi, descripcion, stock, fecha_inicio, fecha_vencimiento, precio_producto,
                                   cod_visibilidad, visibilidad, costo_publicar, porcentaje_venta, costo_envio,
                                   cod_estado, estado, cod_rubro, desc_corta, desc_larga,
                                   //usuario,
                                   cod_usuario, username, cod_tipo_publi, tipo_publicacion, con_envio, con_preguntas);
        }

        public static List<Publicacion> ListarPublicaciones(byte estado, List<decimal> rubros, string descripcion)
        {
            return Publicacion.GetPublicaciones(estado, rubros, descripcion);
        }

        public static Publicacion Guardar(string descripcion, decimal stock, DateTime fechaInicio, DateTime fechaVenc, decimal precio, decimal cod_visibilidad,
                                  decimal cod_estado, decimal cod_rubro, decimal cod_usuario, decimal cod_tipo_publi, bool con_envio, bool con_preguntas)
        {
            decimal cod_publi = Publicacion.Save(descripcion, stock, fechaInicio, fechaVenc, precio, cod_visibilidad,
                                    cod_estado, cod_rubro, cod_usuario, cod_tipo_publi, con_envio, con_preguntas);

            if (cod_publi > 0)
            {
                return Publicacion.GetPublicacion(cod_publi);
            }
            else {
                return null;
            }
        }
    }
}
