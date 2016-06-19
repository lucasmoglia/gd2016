using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Business;

namespace ME.UI
{
    public partial class LoginForm : Form
    {
        UsuarioHandler _usuarioHandler = new UsuarioHandler();

        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtUser.Text))
            {
                errLogin.SetError(txtUser, "El nombre de usuario es requerido");
                label1.Text = "El nombre de usuario es requerido";
                label1.Visible = true;
            }
            else if (String.IsNullOrEmpty(txtPassword.Text))
            {
                errLogin.SetError(txtPassword, "La contraseña es requerida");
                label1.Text = "La contraseña es requerida";
                label1.Visible = true;
            }
            else if (_usuarioHandler.Login(txtUser.Text, txtPassword.Text) > 0)
            {
                label1.Visible = false;
                errLogin.Clear();

                var frm = new Home();
                frm.Location = this.Location;
                frm.StartPosition = FormStartPosition.Manual;
                frm.FormClosing += delegate { this.Show(); };
                frm.Show();
                this.Hide();
            }
            else
            {
                errLogin.SetError(txtPassword, "Los datos ingresados son incorrectos");
                txtPassword.Text = string.Empty;
                label1.Text = "Los datos ingresados son incorrectos";
                label1.Visible = true;
                txtUser.Focus();
            }           
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {
            List<string> funcionalidades = new List<string>();
            funcionalidades.Add("Login");

            btnLogin.Visible = funcionalidades.Any(f => f == "Login");
        }

        private void txtPassword_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                this.btnLogin_Click(sender, e);
            }
        }

    }
}
