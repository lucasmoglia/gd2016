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
            gvRoles.DataSource = RolesHandler.GetRoles();
        }

        private void btnNuevoRol_Click(object sender, EventArgs e)
        {
            NuevoRolForm nuevoRolForm = new NuevoRolForm(null);
            nuevoRolForm.ShowDialog(this);
        }
    }
}
