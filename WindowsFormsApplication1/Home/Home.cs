﻿using System;
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
            this.pnlMaster.Controls.Clear();
            this.pnlMaster.Controls.Add(new FacturaUserControl());

        }

        private void usuariosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            this.pnlMaster.Controls.Clear();
            this.pnlMaster.Controls.Add(new UsuarioUserControl());
        }

        private void inicioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //this.pnlMaster.Controls.Clear();
            //this.pnlMaster.Controls.Add(new ComprarOfertarUserControl());
            //PublicacionForm form = new PublicacionForm(null, false);
            //form.Show();
        }

        private void rolesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //Cuando hago click en una opción del menu, cambio el controlador.
            this.pnlMaster.Controls.Clear();
            this.pnlMaster.Controls.Add(new RolUserControl());
        }
    }
}
