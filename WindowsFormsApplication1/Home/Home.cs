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
    public partial class Home : Form
    {
        public Home()
        {
            InitializeComponent();
        }

        private void Home_Load(object sender, EventArgs e)
        {
            //this.pnlMaster.Clear();
            //this.pnlMaster.Controls.Add(new PublicacionUserControl());
        }

        private void misFacturasToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void usuariosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            this.pnlMaster.Controls.Clear();
            this.pnlMaster.Controls.Add(new PublicacionesUserControl());
        }

        private void inicioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NuevoUsuarioForm form = new NuevoUsuarioForm();
            form.Show();
        }

        private void rolesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            this.pnlMaster.Controls.Clear();
            this.pnlMaster.Controls.Add(new RolUserControl());
        }
    }
}
