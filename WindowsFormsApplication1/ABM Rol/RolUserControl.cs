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
        public RolUserControl()
        {
            InitializeComponent();
        }

        private void RolUserControl_Load(object sender, EventArgs e)
        {
            gvRoles.DataSource = RolHandler.ListarRoles(true);
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
