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
    public partial class ComprarOfertarUserControl : UserControl
    {
        private const int pageSize = 10;
        private List<Publicacion> listaPublicaciones = new List<Publicacion>();
        
        public ComprarOfertarUserControl()
        {
            InitializeComponent();
            listaPublicaciones = PublicacionHandler.ListarPublicaciones(1, null, null);
            gvPublicaciones.DataSource = listaPublicaciones;
            gvPublicaciones.Columns.Remove("cod_publi");
            bindNav1.BindingSource = bindSource1;
            bindSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindSource1.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindSource1.Current;
            var records = new List<Publicacion>();
            for (int i = offset; i < offset + pageSize && i < listaPublicaciones.Count; i++)
                records.Add(listaPublicaciones.ElementAt(i));
            gvPublicaciones.DataSource = records;
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

        private void PublicacionesUserControl_Load(object sender, EventArgs e)
        {
            this.gvPublicaciones.DataSource = PublicacionHandler.ListarPublicaciones(1,null,null);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form nuevaPublicacionForm = new NuevaPublicacionForm();
            nuevaPublicacionForm.ShowDialog(this);
        }

        private void gvClientes_SelectionChanged(object sender, EventArgs e)
        {
            
        }

        private void gvClientes_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            btnEditPublicacion.Visible = true;
            btnRemovePublicacion.Visible = true;
        }

        private void btnEditUser_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;
            Form nuevaPublicacionForm = new NuevaPublicacionForm(publicacion);
            nuevaPublicacionForm.ShowDialog(this);
        }

    }
}
