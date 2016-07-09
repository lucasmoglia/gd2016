using ME.Data;
using ME.Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI.Facturas
{
    public partial class FacturaForm : Form
    {
        public FacturaForm(Factura factura)
        {
            InitializeComponent();
            List<Item> itemsFactura = new List<Item>();
            gvFacturas.DataSource = Item.GetItems(factura.num_factura, string.Empty);

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void FacturaForm_Load(object sender, EventArgs e)
        {

        }

        private void gvFacturas_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
