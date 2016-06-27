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
        public NuevaVisibilidadForm(VisibilidadModel visibilidad)
        {
            InitializeComponent();

            if (visibilidad != null)
            {
                if (visibilidad.cod_visibilidad != null)
                {
                    txtDescripcionV.Text    = visibilidad.descripcion;
                    txtCostoPublicar.Text   = visibilidad.costo_publicar;
                    txtPorcVenta.Text       = visibilidad.porcentaje_venta;
                    txtCostoEnvio.Text      = visibilidad.costo_envio;
                }
            } else {
                txtDescripcionV.Text    = String.Empty;
                txtCostoPublicar.Text   = String.Empty;
                txtPorcVenta.Text       = String.Empty;
                txtCostoEnvio.Text      = String.Empty;
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
            VisibilidadHandler.Nuevo(txtDescripcionV.Text, decimal.Parse(txtCostoPublicar.Text), decimal.Parse(txtPorcVenta.Text), decimal.Parse(txtCostoEnvio.Text));
//            VisibilidadHandler.Actualizar(decimal.Parse(txtCodVisibilidad.Text), txtDescripcionV.Text, decimal.Parse(txtCostoPublicar.Text), decimal.Parse(txtPorcVenta.Text), decimal.Parse(txtCostoEnvio.Text));
            this.Close();
        }
    }
}
