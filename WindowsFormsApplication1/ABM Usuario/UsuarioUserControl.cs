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
    public partial class UsuarioUserControl : UserControl
    {
        private const int pageSize = 10;
        private List<UsuarioModel> listaUsuarios = new List<UsuarioModel>();
        
        public UsuarioUserControl()
        {
            InitializeComponent();
            listaUsuarios = UsuarioHandler.GetUsuarios(true);
            gvClientes.DataSource = listaUsuarios;
            gvClientes.Columns.Remove("cod_usuario");
            bindingNavigator1.BindingSource = bindingSource1;
            bindingSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindingSource1.DataSource = new PageOffsetList(gvClientes.RowCount);
        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindingSource1.Current;
            var records = new List<UsuarioModel>();
            for (int i = offset; i < offset + pageSize && i < listaUsuarios.Count; i++)
                records.Add(listaUsuarios.ElementAt(i));
            gvClientes.DataSource = records;
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

        private void UsuariosUserControl_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form nuevoUsuarioForm = new NuevoUsuarioForm();
            nuevoUsuarioForm.ShowDialog(this);
        }

        private void gvClientes_SelectionChanged(object sender, EventArgs e)
        {
            
        }

        private void gvClientes_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            btnEditUser.Visible = true;
            btnRemoveUser.Visible = true;
        }

        private void btnEditUser_Click(object sender, EventArgs e)
        {
            UsuarioModel usuario = (UsuarioModel)gvClientes.SelectedRows[0].DataBoundItem;
            Form nuevoUsuarioForm = new NuevoUsuarioForm(usuario);
            nuevoUsuarioForm.ShowDialog(this);
        }

    }
}
