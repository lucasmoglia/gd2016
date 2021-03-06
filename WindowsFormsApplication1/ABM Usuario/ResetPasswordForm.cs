﻿using ME.Data;
using ME.Business;
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
    public partial class ResetPasswordForm : Form
    {
        decimal idUsuario = 0;

        public ResetPasswordForm(decimal idUsuario)
        {
            InitializeComponent();
            this.idUsuario = idUsuario;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioHandler.ResetPassword(idUsuario, txtNuevaContraseña.Text);
                MessageBox.Show("La contraseña se modificó con éxito!", "Reestablecer contraseña", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch(Exception ex)
            {
                MessageBox.Show("Ocurrió un error al intentar modificar la contraseña \n" + ex.InnerException, "Reestablecer contraseña", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            this.Close();
        }
    }
}
