using ME.Business;
using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
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
        private decimal cod_usuario = 0;
        private bool saved = false;

        public bool somethingSaved { get { return saved; } }
        
        public NuevoUsuarioForm(UsuarioModel usuario)
        {
            List<Rol> rolesList = RolHandler.ListarRoles(true);
            InitializeComponent();
            ddlRol.ValueMember = "cod_rol";
            ddlRol.DisplayMember = "nombre";
            ddlRol.DataSource = rolesList;

            ddlRubro.ValueMember = "cod_rubro";
            ddlRubro.DisplayMember = "desc_larga";
            ddlRubro.DataSource = RubroHandler.ListarRubros();

            ddlTipoDocC.ValueMember = "Id";
            ddlTipoDocC.DisplayMember = "Value";
            ddlTipoDocC.DataSource = new List<object>() { new { Id = "1", Value = "DNI" }, new { Id = "2", Value = "LE" } };

            if (usuario != null)//CLIENTE POR PARAMETRO
            {
                cod_usuario = usuario.cod_usuario;
                ddlRol.Enabled = false;
                
                if (usuario.dni != null && !string.IsNullOrEmpty((usuario.dni.ToString())))
                {
                    txtNombreC.Text = usuario.nombre;
                    txtApellido.Text = usuario.apellido;
                    txtNumeroDocC.Text = usuario.dni;
                    ddlRol.SelectedItem = rolesList.Where(r => r.nombre.Trim().ToUpper().Contains("C")).FirstOrDefault();
                    ddlTipoDocC.SelectedText = usuario.documento_tipo;
                    ddlRubro.SelectedText = usuario.rubro.ToString();
                    txtMailC.Text = usuario.mail;
                    txtUserNameC.Text = usuario.username;
                    txtPasswordC.Enabled = false;
                    txtTelefonoC.Text = usuario.telefono;
                    txtDirCalleC.Text = usuario.dir_calle;
                    txtDirNumeroC.Text = usuario.dir_nro;
                    txtDirPisoC.Text = usuario.dir_piso;
                    txtDirDeptoC.Text = usuario.dir_depto;
                    txtDirLocalidadC.Text = usuario.dir_localidad;
                    txtDirCPC.Text = usuario.dir_cod_post;
                    txtFechaNacC.Text = usuario.fecha_nacimiento.ToString();
                }
                else//EMPRESA POR PARAMETRO
                {
                    txtRazonSocial.Text = usuario.razon_social;
                    txtCiudadE.Text = usuario.dir_ciudad;
                    txtNombreContacto.Text = usuario.nombre_contacto;
                    ddlRol.SelectedItem = rolesList.Where(r => r.nombre.Trim().ToUpper().Contains("P"));
                    ddlRubro.SelectedText = usuario.rubro;
                    txtCUIT.Text = usuario.cuit;
                    txtMailEmpresa.Text = usuario.mail;
                    txtUsernameE.Text = usuario.username;
                    txtPasswordE.Enabled = false;
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
                //ddlRol.SelectedValue = String.Empty;
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
            saved = false;
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
            #region SAVE
            if (ddlRol.SelectedValue.ToString() == "1")//Empresa
            {
                if(string.IsNullOrEmpty(txtRazonSocial.Text.Trim()) || 
                        string.IsNullOrEmpty(txtCiudadE.Text.Trim()) ||
                        string.IsNullOrEmpty(txtNombreContacto.Text.Trim()) ||
                        string.IsNullOrEmpty(ddlRubro.SelectedValue.ToString()) ||
                        string.IsNullOrEmpty(txtCUIT.Text.Trim()) ||
                        string.IsNullOrEmpty(txtMailEmpresa.Text.Trim()) ||
                        string.IsNullOrEmpty(txtUsernameE.Text.Trim()) ||
                        (string.IsNullOrEmpty(txtPasswordE.Text.Trim()) && cod_usuario == 0) ||
                        string.IsNullOrEmpty(txtTelefonoEmpresa.Text.Trim()) ||
                        string.IsNullOrEmpty(txtDomCalleE.Text.Trim()) || 
                        string.IsNullOrEmpty(txtDomNumeroE.Text.Trim()) ||
                        string.IsNullOrEmpty(txtDomPisoE.Text.Trim()) ||
                        string.IsNullOrEmpty(txtDomDeptoE.Text.Trim()) ||
                        string.IsNullOrEmpty(txtLocalidadE.Text.Trim()) ||
                        string.IsNullOrEmpty(txtDomCPE.Text.Trim()))
                {
                    MessageBox.Show("Debe completar todos los campos del formulario para continuar!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    try
                    {
                        EmpresaHandler.Guardar(txtRazonSocial.Text, txtCiudadE.Text, txtNombreContacto.Text, ddlRubro.SelectedValue.ToString(), txtCUIT.Text, txtMailEmpresa.Text, txtUsernameE.Text, txtPasswordE.Text, true, txtTelefonoEmpresa.Text, txtDomCalleE.Text, txtDomNumeroE.Text, txtDomPisoE.Text, txtDomDeptoE.Text, txtLocalidadE.Text, txtDomCPE.Text, cod_usuario, DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString()));
                        MessageBox.Show("Se guardaron los registros del usuario con éxito!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        saved = true;
                        this.Close();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("( =/ ) Ocurrió un error! Contacte al programador! Comuníquele que...\n\n" + ex.Message, "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            else
            {
                if (string.IsNullOrEmpty(txtNombreC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtApellido.Text.Trim()) ||
                            string.IsNullOrEmpty(txtNumeroDocC.Text.Trim()) ||
                            string.IsNullOrEmpty(ddlTipoDocC.SelectedValue.ToString()) ||
                            string.IsNullOrEmpty(txtMailC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtUserNameC.Text.Trim()) ||
                            (string.IsNullOrEmpty(txtPasswordC.Text.Trim()) && cod_usuario == 0) ||
                            string.IsNullOrEmpty(txtTelefonoC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirCalleC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirNumeroC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirPisoC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirDeptoC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirLocalidadC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtDirCPC.Text.Trim()) ||
                            string.IsNullOrEmpty(txtFechaNacC.Text.Trim()))
                {
                    MessageBox.Show("Debe completar todos los campos del formulario para continuar!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    try
                    {
                        ClienteHandler.Guardar(txtNombreC.Text, txtApellido.Text, decimal.Parse(txtNumeroDocC.Text), ddlTipoDocC.SelectedText, txtMailC.Text, txtUserNameC.Text, txtPasswordC.Text, true, txtTelefonoC.Text, txtDirCalleC.Text, decimal.Parse(txtDirNumeroC.Text), decimal.Parse(txtDirPisoC.Text), txtDirDeptoC.Text, txtDirLocalidadC.Text, txtDirCPC.Text, DateTime.Parse(txtFechaNacC.Text), cod_usuario, DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString()));
                        MessageBox.Show("Se guardaron los registros del usuario con éxito!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        saved = true;
                        this.Close();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Ocurrió un error al intentar guardar el usuario! \n\n" + ex.Message + "\n\n Todos los campos son obligatorios. Verifíquelos e intente nuevamente!", "Nuevo Usuario", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            #endregion


        }

        private void pnlEmpresa_Paint(object sender, PaintEventArgs e)
        {

        }

    }
}
