using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using ME.UI;
using ME.Business;
using ME.Data;
using ME.UI.Calificar;

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
            //this.Text = string.Concat("Bienvenido ", System.Configuration.ConfigurationManager.AppSettings["user"].ToString(), "!");
            this.Text = string.Concat("Bienvenido ", UserLogged.username, "!");

            if (UserLogged.esAdmin) {
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

            PublicacionForm nuevaPublicacion = new PublicacionForm(null, TipoAccion.New);

            nuevaPublicacion.ShowDialog(this);
        }

        private void visibilidadesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new VisibilidadControl());
        }

        private void Home_FormClosed(object sender, FormClosedEventArgs e)
        {
            // Open App.Config of executable
            //System.Configuration.Configuration config =
            //  ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

            //// Add an Application Setting.
            //config.AppSettings.Settings.Remove("user");
            //config.AppSettings.Settings.Remove("password");

            //// Save the configuration file.
            //config.Save(ConfigurationSaveMode.Modified);

            //// Force a reload of a changed section.
            //ConfigurationManager.RefreshSection("appSettings");
        }

        private void misPublicacionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            //pnlMaster.Controls.Add(new ComprarOfertarUserControl(UserLogged.cod_usuario));

        }

        private void calificarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new CalificarControl());

        }

        public void cargarPanel(UserControl unControl) {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(unControl);
        }
    }
}
