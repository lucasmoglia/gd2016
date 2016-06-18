using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Business;
using ME.Data;

namespace ME.UI
{
    public partial class FacturaUserControl : UserControl
    {
        decimal cod_usuario = 1; // SACAR esto va a estar en la variable global usuario logueado.

        public FacturaUserControl()
        {
            InitializeComponent();

            gvFacturas.DataSource = FacturaHandler.ListarFacturas(cod_usuario, null, null, 0, Decimal.MaxValue, null);
            DTPFechaDesde.Value = System.DateTime.Today;
            DTPFechaHasta.Value = System.DateTime.Today;
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;
        }

        private void FacturaUserControl_Load(object sender, EventArgs e)
        {

        }

         private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            gvFacturas.DataSource = FacturaHandler.ListarFacturas(cod_usuario, null, null, 0, decimal.MaxValue, null);
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            gvFacturas.DataSource = FacturaHandler.ListarFacturas(cod_usuario, DTPFechaDesde.Value, DTPFechaHasta.Value, numMontoMin.Value, numMontoMax.Value, TxtDetalleFactura.Text);
        }
    }
}
