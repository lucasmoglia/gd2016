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
    public partial class VisibilidadControl : UserControl
    {
        private const int pageSize = 10;
        private List<VisibilidadModel> listaVisibilidades = new List<VisibilidadModel>();
        
        public VisibilidadControl()
        {
            InitializeComponent();
            listaVisibilidades = VisibilidadHandler.ListarVisibilidades(true);
            gvVisibilidades.DataSource = listaVisibilidades;
            gvVisibilidades.Columns.Remove("cod_visibilidad");
            bindingNavigator1.BindingSource = bindingSource1;
            bindingSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindingSource1.DataSource = new PageOffsetList(gvVisibilidades.RowCount);
        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindingSource1.Current;
            var records = new List<VisibilidadModel>();
            for (int i = offset; i < offset + pageSize && i < listaVisibilidades.Count; i++)
                records.Add(listaVisibilidades.ElementAt(i));
            gvVisibilidades.DataSource = records;
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

        private void VisibilidadesControl_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form nuevaVisibilidadForm = new NuevaVisibilidadForm(null);
            nuevaVisibilidadForm.ShowDialog(this);
        }

        private void gvVisibilidades_SelectionChanged(object sender, EventArgs e)
        {
            
        }

        private void gvVisibilidades_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            btnEditVisibilidad.Visible = true;
            btnRemoveVisibilidad.Visible = true;
        }

        private void btnEditVisibilidad_Click(object sender, EventArgs e)
        {
            VisibilidadModel visibilidad = (VisibilidadModel)gvVisibilidades.SelectedRows[0].DataBoundItem;
            Form nuevaVisibilidadForm = new NuevaVisibilidadForm(visibilidad);
            nuevoUsuarioForm.ShowDialog(this);
        }

        private void bindingNavigator1_RefreshItems(object sender, EventArgs e)
        {

        }

    }
}
