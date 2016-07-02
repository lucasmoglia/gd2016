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
    public partial class NuevoClienteForm : Form
    {
        public NuevoClienteForm()
        {
            InitializeComponent();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void NuevoClienteForm_Load(object sender, EventArgs e)
        {
            ddlRol.ValueMember = "cod_rol";
            ddlRol.DisplayMember = "nombre";
            ddlRol.DataSource = RolHandler.ListarRoles(true);
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
                //TODO EmpresaHandler.Guardar();
            }
            else
            {
                ClienteHandler.Guardar(txtNombreC.Text, txtApellido.Text, decimal.Parse(txtNumeroDocC.Text), txtTipoDocC.Text, txtMailC.Text, txtUserNameC.Text, txtPasswordC.Text, true, txtTelefonoC.Text, txtDirCalleC.Text, decimal.Parse(txtDirNumeroC.Text), decimal.Parse(txtDirPisoC.Text), txtDirDeptoC.Text, txtDirLocalidadC.Text, txtDirCPC.Text, DateTime.Parse(txtFechaNacC.Text));
            }

            this.Close();
        }
    }
}
