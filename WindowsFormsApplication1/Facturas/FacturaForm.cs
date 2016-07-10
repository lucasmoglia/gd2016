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
            gvFacturas.Columns["id_item"].Visible = false;
            gvFacturas.Columns["num_factura"].Visible = false;
            gvFacturas.Columns["cod_item"].Visible = false;

            txtBoxFactura.Text = factura.num_factura.ToString();
            txtBoxFecha.Text = factura.fecha_factura.ToShortDateString();
            txtTotal.Text = factura.total.ToString();

            CabeceraFactura cabeceraFactura = CabeceraFactura.GetDatosCabeceraFactura(UserLogged.cod_usuario);

            txtBoxNomApellidoUsuario.Text = cabeceraFactura.nombre_apellido;
            txtBoxDomicilio.Text = cabeceraFactura.domicilio;
            txtBoxDNIoCUIT.Text = cabeceraFactura.DNI_CUIT;
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

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtBoxFactura_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
