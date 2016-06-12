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
        public UsuarioUserControl()
        {
            InitializeComponent();
        }

        private void UsuariosUserControl_Load(object sender, EventArgs e)
        {
            //gvClientes.DataSource = UsuarioHandler.GetUsuarios(true);
            //gvClientes.Columns.Remove("cod_usuario");
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
