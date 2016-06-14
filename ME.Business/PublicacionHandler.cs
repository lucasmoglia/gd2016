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
                           UsuarioModel usuario, decimal cod_tipo_publi, string tipo_publicacion, bool con_envio, bool con_preguntas)
        {
            return new Publicacion(cod_publi, descripcion, stock, fecha_inicio, fecha_vencimiento, precio_producto,
                                   cod_visibilidad, visibilidad, costo_publicar, porcentaje_venta, costo_envio,
                                   cod_estado, estado, cod_rubro, desc_corta, desc_larga,
                                   usuario, cod_tipo_publi, tipo_publicacion, con_envio, con_preguntas);
        }

        public static List<Publicacion> ListarPublicaciones(string estado)
        {
            return Publicacion.GetPublicaciones(estado);
        }
    }
}
