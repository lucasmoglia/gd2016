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
using System.Configuration;

namespace ME.UI
{
    public partial class UsuarioUserControl : UserControl
    {
        private const int pageSize = 10;
        private List<UsuarioModel> listaUsuarios = new List<UsuarioModel>();
        private List<UsuarioModel> safe_listaUsuarios = new List<UsuarioModel>();

        private void FillGrid()
        {
            listaUsuarios = UsuarioHandler.GetUsuarios(false);
            safe_listaUsuarios = listaUsuarios; //Copia para hacer el filtrado
            gvClientes.DataSource = listaUsuarios;
            gvClientes.Columns.Remove("cod_usuario");
            bindingNavigator1.BindingSource = bindingSource1;
            bindingSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindingSource1.DataSource = new PageOffsetList(gvClientes.RowCount);
        }
        
        public UsuarioUserControl()
        {
            InitializeComponent();
            btnResetPass.Visible = false;
            FillGrid();
        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)(bindingSource1.Current ?? 0);
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
            Form nuevoUsuarioForm = new NuevoUsuarioForm(null);
            nuevoUsuarioForm.ShowDialog(this);
            FillGrid();
        }

        private void gvClientes_SelectionChanged(object sender, EventArgs e)
        {
            bool activo = bool.Parse(((DataGridView)sender).CurrentRow.Cells["Activo"].Value.ToString());
            btnDesbloquear.Visible = !activo;
            btnResetPass.Visible = true;
        }

        private void gvClientes_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            btnEditUser.Visible = true;
            btnRemoveUser.Visible = true;
        }

        private void btnEditUser_Click(object sender, EventArgs e)
        {
            UsuarioModel usuario = (UsuarioModel)gvClientes.SelectedRows[0].DataBoundItem;
            NuevoUsuarioForm nuevoUsuarioForm = new NuevoUsuarioForm(usuario);
            nuevoUsuarioForm.ShowDialog(this);
            if (nuevoUsuarioForm.somethingSaved)
            {
                FillGrid();
            }
        }

        private void bindingNavigator1_RefreshItems(object sender, EventArgs e)
        {

        }

        private void btnResetPass_Click(object sender, EventArgs e)
        {
            ResetPasswordForm resetPassForm = new ResetPasswordForm(decimal.Parse((gvClientes.SelectedRows[0].Cells["cod_usuario"].Value.ToString())));
            resetPassForm.StartPosition = FormStartPosition.CenterScreen;
            resetPassForm.ShowDialog(this);
        }

        private void btnDesbloquear_Click(object sender, EventArgs e)
        {
            var confirmResult = MessageBox.Show("Se va a desbloquear el usuario, continuar?", "Desbloquear Usuarios", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    UsuarioHandler.Desbloquear(decimal.Parse(gvClientes.SelectedRows[0].Cells["cod_usuario"].Value.ToString()));
                    MessageBox.Show("Se ha desbloqueado el usuario con éxito!", "Desbloquear Usuarios", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    FillGrid();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ocurrió un error al intentar desbloquear un usuario: \n\n" + ex.InnerException, "Desbloquear Usuarios", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

            }
        }

        private void btnBuscar_Click(object sender, EventArgs ev)
        {

            listaUsuarios = safe_listaUsuarios.Where(e => 
            (string.IsNullOrEmpty(txtFiltroNombre.Text) || (!string.IsNullOrEmpty(txtFiltroNombre.Text) &&
                e.nombre.Trim().ToUpper().Contains(txtFiltroNombre.Text.Trim().ToUpper())))
                &&
            (string.IsNullOrEmpty(txtFiltroApellido.Text) || (!string.IsNullOrEmpty(txtFiltroApellido.Text) &&
                e.apellido.Trim().ToUpper().Contains(txtFiltroApellido.Text.Trim().ToUpper())))
                &&
            (string.IsNullOrEmpty(txtFiltroDNI.Text) || (!string.IsNullOrEmpty(txtFiltroDNI.Text) && 
                e.dni.Trim().ToUpper().Contains(txtFiltroDNI.Text.Trim().ToUpper())))
                &&
            (string.IsNullOrEmpty(txtFiltroMail.Text) || (!string.IsNullOrEmpty(txtFiltroMail.Text) &&
                e.mail.Trim().ToUpper().Contains(txtFiltroMail.Text.Trim().ToUpper())))).ToList();
            gvClientes.DataSource = listaUsuarios;
            gvClientes.Refresh();
            bindingSource1.DataSource = new PageOffsetList(gvClientes.RowCount);
        }

        private void btnRestablecer_Click(object sender, EventArgs e)
        {
            txtFiltroNombre.Text = string.Empty;
            txtFiltroApellido.Text = string.Empty;
            txtFiltroDNI.Text = string.Empty;
            txtFiltroMail.Text = string.Empty;
            
            FillGrid();
        }

        private void btnRemoveUser_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioHandler.Eliminar(decimal.Parse(gvClientes.SelectedRows[0].Cells["cod_usuario"].Value.ToString()), DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString()));
                MessageBox.Show("El usuario ha sido eliminado correctamente!", "Eliminar Usuario", MessageBoxButtons.OK, MessageBoxIcon.Information);
                FillGrid();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ocurrió un error al intentar eliminar el usuario: \n\n" + ex.Message, "Desbloquear Usuarios", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

    }
}
