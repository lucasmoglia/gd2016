using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.UI;

namespace ME.UI
{
    public partial class Home : Form
    {
        bool esAdmin = true; // SACAR, esto va a estar en la variable global de usuario logueado.

        public Home()
        {
            InitializeComponent();
        }

        private void Home_Load(object sender, EventArgs e)
        {
            if (esAdmin) {
                administracionToolStripMenuItem.Enabled = true;
                administracionToolStripMenuItem.Visible = true;
            } else {
                administracionToolStripMenuItem.Enabled = false;
                administracionToolStripMenuItem.Visible = false;
            }
            //pnlMaster.Clear();
            //pnlMaster.Controls.Add(new PublicacionUserControl());
        }

        private void inicioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //pnlMaster.Controls.Clear();
            //pnlMaster.Controls.Add(new ComprarOfertarUserControl());
        }

        private void misFacturasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new FacturaUserControl());

        }

        private void usuariosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new UsuarioUserControl());
        }

        private void rolesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new RolUserControl());
        }

        private void comprarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new ComprarOfertarUserControl());
        }

        private void venderToolStripMenuItem_Click(object sender, EventArgs e)
        {
//            pnlMaster.Controls.Clear();
//            pnlMaster.Controls.Add(new ComprarOfertarUserControl());

            PublicacionForm nuevaPublicacion = new PublicacionForm(null, false);

            nuevaPublicacion.ShowDialog(this);
        }

        private void visibilidadesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new VisibilidadControl());
        }
    }
}
