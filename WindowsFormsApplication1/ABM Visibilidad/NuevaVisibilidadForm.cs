using ME.Business;
using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI
{
    public partial class NuevaVisibilidadForm : Form
    {
        public NuevaVisibilidadForm(Visibilidad visibilidad)
        {
            InitializeComponent();

            if (visibilidad != null)
            {
                numCodVisibilidad.Value = visibilidad.cod_visibilidad;
                txtDescripcionV.Text    = visibilidad.descripcion;
                numCostoPublicar.Value  = visibilidad.costo_publicar;
                numPorcVenta.Value      = visibilidad.porcentaje_venta;
                numCostoEnvio.Value     = visibilidad.costo_envio;
            } else {
                numCodVisibilidad.Value = 0;
                txtDescripcionV.Text    = String.Empty;
                numCostoPublicar.Value  = 0;
                numPorcVenta.Value      = 0;
                numCostoEnvio.Value     = 0;
            }
        }

        private void NuevaVisibilidadForm_Load(object sender, EventArgs e)
        {

        }
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (numCodVisibilidad.Value == 0)
            {
            VisibilidadHandler.Nuevo(txtDescripcionV.Text, numCostoPublicar.Value, numPorcVenta.Value, numCostoEnvio.Value);
            } else {
            VisibilidadHandler.Actualizar(numCodVisibilidad.Value, txtDescripcionV.Text, numCostoPublicar.Value, numPorcVenta.Value, numCostoEnvio.Value);
            }
            this.Close();
        }
    }
}
