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
using ME.UI.Facturas;

namespace ME.UI
{
    public partial class FacturaUserControl : UserControl
    {
        private const int pageSize = 10;
        private List<Factura> listaFacturas;

        public FacturaUserControl()
        {
            InitializeComponent();
            //gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null); // verificar el parametro de fechaDesde, no deberia ir el TODAY
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;

            listaFacturas = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null); // verificar el parametro de fechaDesde, no deberia ir el TODAY
            //Init Grid
            gvFacturas.DataSource = listaFacturas;
         // gvFacturas.Columns["visibilidad"].DataPropertyName = "descripcion";

            bindNavFacturas.BindingSource = bindSourceFacturas;
            bindSourceFacturas.CurrentChanged += new System.EventHandler(bindSourceFacturas_CurrentChanged);
            bindSourceFacturas.DataSource = new PageOffsetList(gvFacturas.RowCount);
        }

        private void bindSourceFacturas_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindSourceFacturas.Current;
            var records = new List<Factura>();

            for (int i = offset; i < offset + pageSize && i < listaFacturas.Count; i++)
                records.Add(listaFacturas.ElementAt(i));
            gvFacturas.DataSource = records;
        }

        class PageOffsetList : System.ComponentModel.IListSource
        {
            private int totalRecords { get; set; }

            public PageOffsetList(int totalRecords)
            {
                this.totalRecords = totalRecords;
            }

            public bool ContainsListCollection { get; protected set; }

            public System.Collections.IList GetList()
            {
                // Return a list of page offsets based on "totalRecords" and "pageSize"
                var pageOffsets = new List<int>();
                for (int offset = 0; offset < totalRecords; offset += pageSize)
                    pageOffsets.Add(offset);
                return pageOffsets;
            }
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
          //  gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null);
            listaFacturas = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, Convert.ToDateTime("01/01/1800"), DateTime.MaxValue, 0, int.MaxValue, null);
            //Init Grid
           gvFacturas.DataSource = listaFacturas;            
            
            DTPFechaDesde.Value = System.DateTime.Today;
            DTPFechaHasta.Value = System.DateTime.Today;
            numMontoMax.Value = 0;
            numMontoMin.Value = 0;
            TxtDetalleFactura.Text = null;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
           // gvFacturas.DataSource = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, DTPFechaDesde.Value, DTPFechaHasta.Value, numMontoMin.Value, numMontoMax.Value, TxtDetalleFactura.Text);
            listaFacturas = FacturaHandler.ListarFacturas(UserLogged.cod_usuario, DTPFechaDesde.Value, DTPFechaHasta.Value, numMontoMin.Value, numMontoMax.Value, TxtDetalleFactura.Text);
            //Init Grid
            gvFacturas.DataSource = listaFacturas;
           // bindNavFacturas.BindingSource = bindSourceFacturas;
           // bindSourceFacturas.CurrentChanged += new System.EventHandler(bindSourceFacturas_CurrentChanged);
           // bindSourceFacturas.DataSource = new PageOffsetList(gvFacturas.RowCount);
        
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

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void numMontoMin_ValueChanged(object sender, EventArgs e)
        {

        }

        private void bindingNavigatorCountItem_Click(object sender, EventArgs e)
        {

        }
    }
}
