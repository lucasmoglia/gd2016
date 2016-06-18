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
            
            if(usuario.dni != null){
                txtNombreC.Text = usuario.nombre;
                txtApellido.Text = usuario.apellido;
                txtNumeroDocC.Text = usuario.dni;
                ddlRol.SelectedValue = usuario.cod_rol;
                //txtTipoDocC.Text 
                txtMailC.Text = usuario.mail;
                txtUserNameC.Text = usuario.username;
                //txtPasswordC.Text = usuario.password;
                txtTelefonoC.Text = usuario.telefono;
                txtDirCalleC.Text = usuario.dir_calle;
                txtDirNumeroC.Text = usuario.dir_nro;
                txtDirPisoC.Text = usuario.dir_piso;
                txtDirDeptoC.Text = usuario.dir_depto;
                txtDirLocalidadC.Text = usuario.dir_localidad;
                txtDirCPC.Text = usuario.dir_cod_post;
                txtFechaNacC.Text = usuario.fecha_nacimiento.ToString();
            }
            else{
                txtRazonSocial.Text = usuario.razon_social;
                txtCiudadE.Text = usuario.dir_ciudad;
                txtNombreContacto.Text = usuario.nombre_contacto;
                ddlRol.SelectedValue = usuario.cod_rol;
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
        }

        private void NuevoUsuarioForm_Load(object sender, EventArgs e)
        {
            ddlRol.ValueMember = "cod_rol";
            ddlRol.DisplayMember = "nombre";
            ddlRol.DataSource = RolHandler.ListarRoles();

            ddlRubro.ValueMember = "cod_rubro";
            ddlRubro.DisplayMember = "desc_larga";
            ddlRubro.DataSource = RubroHandler.ListarRubros();
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
                ClienteHandler.Guardar(txtNombreC.Text, txtApellido.Text, decimal.Parse(txtNumeroDocC.Text), txtTipoDocC.Text, txtMailC.Text, txtUserNameC.Text, txtPasswordC.Text, true, txtTelefonoC.Text, txtDirCalleC.Text, decimal.Parse(txtDirNumeroC.Text), decimal.Parse(txtDirPisoC.Text), txtDirDeptoC.Text, txtDirLocalidadC.Text, txtDirCPC.Text, DateTime.Parse(txtFechaNacC.Text));
            }

            this.Close();
        }

        private void pnlEmpresa_Paint(object sender, PaintEventArgs e)
        {

        }

    }
}
