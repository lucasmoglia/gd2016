using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI
{
    public partial class ComboUsuarioRolForm : Form
    {
        private Home form;

        public ComboUsuarioRolForm(Home homeForm, List<Rol> roles)
        {
            InitializeComponent();
            this.CenterToScreen();
            form = homeForm;
            ddlRoles.DataSource = roles;
            ddlRoles.DisplayMember = "nombre";
            ddlRoles.ValueMember = "cod_rol";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            UserLogged.cod_rol_seleccionado = (decimal)ddlRoles.SelectedValue;
            form.Show();
            this.Hide();
        }
    }
}
