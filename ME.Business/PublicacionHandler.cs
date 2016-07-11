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
                                   cod_usuario, username, cod_tipo_publi, tipo_publicacion, con_envio, con_preguntas, null);
        }

        public static List<Publicacion> ListarPublicaciones(byte estado, List<decimal> rubros, string descripcion)
        {
            return Publicacion.GetPublicaciones(estado, rubros, descripcion, 0);
        }

        public static Publicacion Guardar(bool esNueva, string descripcion, decimal stock, DateTime fechaInicio, DateTime fechaVenc, decimal precio, decimal cod_visibilidad,
                                  decimal cod_estado, decimal cod_rubro, decimal cod_usuario, decimal cod_tipo_publi, bool con_envio, bool con_preguntas, DateTime ? fecha_finalizacion)
        {
            decimal cod_publi = 0;
            if (esNueva) {
                cod_publi = Publicacion.Crear(descripcion, stock, fechaInicio, fechaVenc, precio, cod_visibilidad,
                                  cod_estado, cod_rubro, cod_usuario, cod_tipo_publi, con_envio, con_preguntas);
                // Se invoca al método de facturación directamente desde la vista, xq es más fácil para mostrarlo.

            } else {
                cod_publi = Publicacion.Save(descripcion, stock, fechaInicio, fechaVenc, precio, cod_visibilidad,
                                  cod_estado, cod_rubro, cod_usuario, cod_tipo_publi, con_envio, con_preguntas, fecha_finalizacion);
            }

            return cod_publi > 0 ? Publicacion.GetPublicacion(cod_publi) : null;
        }

        public static Factura Comprar(decimal cod_publi, decimal valor, Int32 motivo) // 1: Publicar, 2: Comprar, 3: Envío.
        {
            // Generar la compra.
            Compra compra = Compra.crearCompra(cod_publi, valor); // Hay que hacer algo con esta compra.

            return FacturaHandler.NuevaFactura(cod_publi, valor);
        }

        public static Int32 Ofertar(decimal cod_publi, decimal monto)
        {
            // Generar la oferta.
            return 0;//Oferta.Crear(cod_publi, valor); // Hacer.  // Hay que hacer algo con esta oferta.?
        }

        
        public static void FinalizarPublicaciones()
        {
            Publicacion.finalizarPublicaciones();
        }    
    
    }
}
