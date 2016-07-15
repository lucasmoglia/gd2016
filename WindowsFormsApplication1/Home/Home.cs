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
            PublicacionHandler.FinalizarPublicaciones();
        }

        #region home Members
        public void cargarPanel(UserControl unControl)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(unControl);
        }
        #endregion

        private void Home_Load(object sender, EventArgs e)
        {
            this.Text = string.Concat(DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString()).Date.ToShortDateString(), "  - Bienvenido ", UserLogged.username, "!");
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new HomeControl());

            comprarToolStripMenuItem.Visible = !UserLogged.esAdmin && !UserLogged.roles.Any(r => r.cod_rol == 1) && UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 0);
            venderToolStripMenuItem.Visible = !UserLogged.esAdmin && UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 1);
            calificarToolStripMenuItem.Visible = UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 2);
            misFacturasToolStripMenuItem.Visible = UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 6);
            miHistorialToolStripMenuItem.Visible = UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 5);
            reportesToolStripMenuItem.Visible = UserLogged.esAdmin || UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 7);
            administracionToolStripMenuItem.Visible = UserLogged.esAdmin;
            misDatosToolStripMenuItem.Visible = UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 4);
            misPublicacionesToolStripMenuItem.Visible = !UserLogged.esAdmin;
            /*Menu admin funcionalidad*/
            usuariosToolStripMenuItem.Visible = UserLogged.esAdmin || UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 8);
            rolesToolStripMenuItem1.Visible = UserLogged.esAdmin || UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 9);
            visibilidadesToolStripMenuItem.Visible = UserLogged.esAdmin || UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 10);
        }

        private void inicioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //pnlMaster.Controls.Clear();
            //pnlMaster.Controls.Add(new ComprarOfertarUserControl());
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new HomeControl());
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


        /*
        public void cargarPanel(UserControl unControl) {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(unControl);
        }
        */


        private void miHistorialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new HistorialControl());
        }

        private void listadoEstadísticoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new ListadoEstadisticoUserControl());
        }

        private void misPublicacionesToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            pnlMaster.Controls.Clear();
            pnlMaster.Controls.Add(new MisPublicacionesUserControl());
        }
    }
}
