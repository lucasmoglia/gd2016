using ME.Business;
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
    public partial class NuevoUsuarioForm : Form
    {
        public NuevoUsuarioForm(UsuarioModel usuario)
        {
            InitializeComponent();
            ddlRol.ValueMember = "cod_rol";
            ddlRol.DisplayMember = "nombre";
            ddlRol.DataSource = RolHandler.ListarRoles(true);

            ddlRubro.ValueMember = "cod_rubro";
            ddlRubro.DisplayMember = "desc_larga";
            ddlRubro.DataSource = RubroHandler.ListarRubros();

            if (usuario != null)
            {
                ddlRol.Enabled = false;

                if (usuario.dni != null && !string.IsNullOrEmpty((usuario.dni.ToString())))
                {
                    txtNombreC.Text = usuario.nombre;
                    txtApellido.Text = usuario.apellido;
                    txtNumeroDocC.Text = usuario.dni;
                    ddlRol.SelectedValue = usuario.cod_rol.ToString();
                    txtMailC.Text = usuario.mail;
                    txtUserNameC.Text = usuario.username;
                    txtTelefonoC.Text = usuario.telefono;
                    txtDirCalleC.Text = usuario.dir_calle;
                    txtDirNumeroC.Text = usuario.dir_nro;
                    txtDirPisoC.Text = usuario.dir_piso;
                    txtDirDeptoC.Text = usuario.dir_depto;
                    txtDirLocalidadC.Text = usuario.dir_localidad;
                    txtDirCPC.Text = usuario.dir_cod_post;
                    txtFechaNacC.Text = usuario.fecha_nacimiento.ToString();
                }
                else
                {
                    txtRazonSocial.Text = usuario.razon_social;
                    txtCiudadE.Text = usuario.dir_ciudad;
                    txtNombreContacto.Text = usuario.nombre_contacto;
                    ddlRol.SelectedItem = usuario.cod_rol.ToString();
                    ddlRubro.SelectedValue = usuario.cod_rubro;
                    txtCUIT.Text = usuario.cuit;
                    txtMailEmpresa.Text = usuario.mail;
                    txtUsernameE.Text = usuario.username;
                    //txtPasswordE.Text = usuario.password;
                    txtTelefonoEmpresa.Text = usuario.telefono;
                    txtDomCalleE.Text = usuario.dir_calle;
                    txtDomNumeroE.Text = usuario.dir_nro;
                    txtDomPisoE.Text = usuario.dir_piso;
                    txtDomDeptoE.Text = usuario.dir_depto;
                    txtLocalidadE.Text = usuario.dir_localidad;
                    txtDomCPE.Text = usuario.dir_cod_post;
                }
            } else {
                txtRazonSocial.Text = String.Empty;
                txtCiudadE.Text = String.Empty;
                txtNombreContacto.Text = String.Empty;
                ddlRol.SelectedValue = String.Empty;
                ddlRubro.SelectedValue = String.Empty;
                txtCUIT.Text = String.Empty;
                txtMailEmpresa.Text = String.Empty;
                txtUsernameE.Text = String.Empty;
                txtPasswordE.Text = String.Empty;
                txtTelefonoEmpresa.Text = String.Empty;
                txtDomCalleE.Text = String.Empty;
                txtDomNumeroE.Text = String.Empty;
                txtDomPisoE.Text = String.Empty;
                txtDomDeptoE.Text = String.Empty;
                txtLocalidadE.Text = String.Empty;
                txtDomCPE.Text = String.Empty;
            }
        }

        private void NuevoUsuarioForm_Load(object sender, EventArgs e)
        {
           
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRol.SelectedValue.ToString() == "1")//Empresa
            {
                pnlCliente.Visible = false;
                pnlEmpresa.Visible = true;
            }
            else
            {
                pnlEmpresa.Visible = false;
                pnlCliente.Visible = true;
            }
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlRol.SelectedValue.ToString() == "1")//Empresa
            {
                EmpresaHandler.Guardar(txtRazonSocial.Text, txtCiudadE.Text, txtNombreContacto.Text, ddlRubro.SelectedValue.ToString(), txtCUIT.Text, txtMailEmpresa.Text, txtUsernameE.Text, txtPasswordE.Text, true, txtTelefonoEmpresa.Text, txtDomCalleE.Text, txtDomNumeroE.Text, txtDomPisoE.Text, txtDomDeptoE.Text, txtLocalidadE.Text, txtDomCPE.Text);
            }
            else
            {
                try
                {
                    ClienteHandler.Guardar(txtNombreC.Text, txtApellido.Text, decimal.Parse(txtNumeroDocC.Text), txtTipoDocC.Text, txtMailC.Text, txtUserNameC.Text, txtPasswordC.Text, true, txtTelefonoC.Text, txtDirCalleC.Text, decimal.Parse(txtDirNumeroC.Text), decimal.Parse(txtDirPisoC.Text), txtDirDeptoC.Text, txtDirLocalidadC.Text, txtDirCPC.Text, DateTime.Parse(txtFechaNacC.Text));
                    this.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ocurrió un error al intentar guardar el usuario! \n\n" + ex.Message + "\n\n Todos los campos son obligatorios. Verifíquelos e intente nuevamente!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void pnlEmpresa_Paint(object sender, PaintEventArgs e)
        {

        }

    }
}
