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
using ME.Business;
using ME.Data;
using ME.UI.Properties;

namespace ME.UI
{
    public partial class LoginForm : Form
    {
        UsuarioHandler _usuarioHandler = new UsuarioHandler();
        ObjectUserLogged logueado = null;

        public LoginForm()
        {
            InitializeComponent();
            this.CenterToScreen();
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

                logueado = ObjectUserLogged.DatosUsuarioLogueado(txtUser.Text);

                if (logueado != null) {
                    UserLogged.cod_usuario    = logueado.cod_usuario;
                    UserLogged.username       = logueado.username;
                    UserLogged.activo         = logueado.activo;
                    UserLogged.esAdmin        = logueado.esAdmin;
                    UserLogged.esEmpresa      = logueado.esEmpresa;
                    UserLogged.publ_sin_cargo = logueado.publ_sin_cargo;
                    UserLogged.roles          = logueado.roles;
                }

                //Blanquea contraseña
                txtPassword.Text = string.Empty;

                var frm = new Home();
                frm.Location = this.Location;
                frm.StartPosition = FormStartPosition.Manual;
                frm.FormClosing += delegate { this.Show(); };
               
                if (logueado.roles.Count > 1)
                {
                    /*Instancia de Form para seleccion de rol*/
                    var comboURForm = new ComboUsuarioRolForm(frm, logueado.roles);
                    comboURForm.FormClosing += delegate { this.Hide(); };
                    comboURForm.ShowDialog();
                }
                else
                {
                    if (UserLogged.roles.Count == 1)
                    {
                        UserLogged.cod_rol_seleccionado = UserLogged.roles.First().cod_rol; //Como tiene un solo rol, es el seleccionado
                    }
                    frm.Show();
                }
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
            UserLogged.cod_usuario = 0;
            UserLogged.esAdmin = false;
            UserLogged.esEmpresa = false;
            UserLogged.username = String.Empty;

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
