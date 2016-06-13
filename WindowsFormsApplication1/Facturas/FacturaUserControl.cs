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

namespace ME.UI.Facturas
{
    public partial class FacturaUserControl : UserControl
    {
        public FacturaUserControl()
        {
            InitializeComponent();
        }

        private void FacturaUserControl_Load(object sender, EventArgs e)
        {
            //gvFacturas.DataSource = FacturaHandler.ListarFacturas(usuario, fecha_desde, fecha_hasta);
        }

        private void FacturaUserControl_QueryAccessibilityHelp(object sender, QueryAccessibilityHelpEventArgs e)
        {

        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {

        }

        private void TextUsuario_TextChanged(object sender, EventArgs e)
        {
   
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            gvFacturas.DataSource = FacturaHandler.ListarFacturas(TxtUsuario.Text, DTPFechaDesde.Value, DTPFechaHasta.Value);
        }
    }
}
