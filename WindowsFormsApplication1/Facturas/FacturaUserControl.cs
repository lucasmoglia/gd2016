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
        
        public FacturaUserControl()
        {
            InitializeComponent();

            gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null); // verificar el parametro de fechaDesde, no deberia ir el TODAY
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;
        }

        private void FacturaUserControl_Load(object sender, EventArgs e)
        {
            DTPFechaDesde.Value = System.DateTime.Today; // poner fecha de archivo de configuracion
            DTPFechaHasta.Value = System.DateTime.Today; // poner fecha de archivo de configuracion
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;
            gvFacturas.Columns["cod_usuario"].Visible = false;
        }

         private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null);
            DTPFechaDesde.Value = System.DateTime.Today;
            DTPFechaHasta.Value = System.DateTime.Today;
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;
            TxtDetalleFactura.Text = null;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, DTPFechaDesde.Value, DTPFechaHasta.Value, numMontoMin.Value, numMontoMax.Value, TxtDetalleFactura.Text);
        }

        private void btnVerDetalle_Click(object sender, EventArgs e)
        {
            if (gvFacturas.SelectedRows != null)
            {
                Factura factura = (Factura)gvFacturas.SelectedRows[0].DataBoundItem;

                FacturaForm facturaForm = new FacturaForm(factura);

                facturaForm.ShowDialog(this);
            }
        }

        private void gvFacturas_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
