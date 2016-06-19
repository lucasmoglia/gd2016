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
    public partial class RolUserControl : UserControl
    {
        private const int pageSize = 10;
        private List<Rol> listaRoles = new List<Rol>();

        public RolUserControl()
        {
            InitializeComponent();
        }

        private void RolUserControl_Load(object sender, EventArgs e)
        {
            listaRoles = RolHandler.ListarRoles(true);
            gvRoles.DataSource = listaRoles;
            gvRoles.Columns.Remove("cod_rol");
            bindingNavigator1.BindingSource = bindingSource1;
            bindingSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindingSource1.DataSource = new PageOffsetList(gvRoles.RowCount);
        }
        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindingSource1.Current;
            var records = new List<Rol>();
            for (int i = offset; i < offset + pageSize && i < listaRoles.Count; i++)
                records.Add(listaRoles.ElementAt(i));
            gvRoles.DataSource = records;
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


        private void btnNuevoRol_Click(object sender, EventArgs e)
        {
            NuevoRolForm nuevoRolForm = new NuevoRolForm(null);
            nuevoRolForm.ShowDialog(this);
            this.RolUserControl_Load(sender, e);
        }

        private void btnEditRol_Click(object sender, EventArgs e)
        {
            NuevoRolForm nuevoRolForm = new NuevoRolForm((Rol)gvRoles.SelectedRows[0].DataBoundItem);
            nuevoRolForm.ShowDialog(this);
            this.RolUserControl_Load(sender, e);
        }

        private void btnRemoveRol_Click(object sender, EventArgs e)
        {
            RolHandler.Eliminar((decimal)gvRoles.SelectedRows[0].Cells["cod_rol"].Value);
            this.RolUserControl_Load(sender, e);
        }
        

    }
}
