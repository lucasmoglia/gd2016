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
    public partial class PublicacionForm : Form
    {
        public PublicacionForm(Publicacion publicacion)
        {
            //InitializeComponent();

            //if(publicacion.dni != null){
            //    txtDescripción.Text = publicacion.nombre;
            //    txtApellido.Text = publicacion.apellido;
            //    txtNumeroDocC.Text = publicacion.dni;
            //    ddlRol.SelectedValue = publicacion.cod_rol;
            //    //txtTipoDocC.Text 
            //    txtMailC.Text = publicacion.mail;
            //    txtUserNameC.Text = publicacion.username;
            //    //txtPasswordC.Text = publicacion.password;
            //    txtTelefonoC.Text = publicacion.telefono;
            //    txtDirCalleC.Text = publicacion.dir_calle;
            //    txtDirNumeroC.Text = publicacion.dir_nro;
            //    txtDirPisoC.Text = publicacion.dir_piso;
            //    txtDirDeptoC.Text = publicacion.dir_depto;
            //    txtDirLocalidadC.Text = publicacion.dir_localidad;
            //    txtDirCPC.Text = publicacion.dir_cod_post;
            //    dateTimeFechaInicio.Text = publicacion.fecha_nacimiento.ToString();
            //}
        }

        private void PublicacionForm_Load(object sender, EventArgs e)
        {
            //ddlRol.ValueMember = "cod_rol";
            //ddlRol.DisplayMember = "nombre";
            //ddlRol.DataSource = RolesHandler.GetRoles();

            //ddlRubro.ValueMember = "cod_rubro";
            //ddlRubro.DisplayMember = "desc_larga";
            //ddlRubro.DataSource = RubrosHandler.GetRubros();
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlRol.SelectedValue.ToString() == "1")//Empresa
            //{
            //    pnlCliente.Visible = false;
            //    pnlEmpresa.Visible = true;
            //}
            //else
            //{
            //    pnlEmpresa.Visible = false;
            //    pnlCliente.Visible = true;
            //}
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            //if (ddlRol.SelectedValue.ToString() == "1")//Empresa
            //{
            //    EmpresaHandler.Guardar(txtRazonSocial.Text, txtCiudadE.Text, txtNombreContacto.Text, ddlRubro.SelectedValue.ToString(), txtCUIT.Text, txtMailEmpresa.Text, txtUsernameE.Text, txtPasswordE.Text, true, txtTelefonoEmpresa.Text, txtDomCalleE.Text, txtDomNumeroE.Text, txtDomPisoE.Text, txtDomDeptoE.Text, txtLocalidadE.Text, txtDomCPE.Text);
            //}
            //else
            //{
            //    ClienteHandler.Guardar(txtDescripción.Text, txtApellido.Text, decimal.Parse(txtNumeroDocC.Text), txtPrecio.Text, txtMailC.Text, txtUserNameC.Text, txtPasswordC.Text, true, txtTelefonoC.Text, txtDirCalleC.Text, decimal.Parse(txtDirNumeroC.Text), decimal.Parse(txtDirPisoC.Text), txtDirDeptoC.Text, txtDirLocalidadC.Text, txtDirCPC.Text, DateTime.Parse(dateTimeFechaInicio.Text));
            //}

            this.Close();
        }
    }
}
