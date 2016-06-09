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
            if (_usuarioHandler.Login(txtUser.Text, txtPassword.Text) > 0)
            {
                MessageBox.Show("Bienvenido a MercadoEnvío", "Bienvenido!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                var frm = new Home();
                frm.Location = this.Location;
                frm.StartPosition = FormStartPosition.Manual;
                frm.FormClosing += delegate { this.Show(); };
                frm.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Los datos ingresados son incorrectos. Intente nuevamente", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }           
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {
            List<string> funcionalidades = new List<string>();
            funcionalidades.Add("Login");

            btnLogin.Visible = funcionalidades.Any(f => f == "Login");
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
