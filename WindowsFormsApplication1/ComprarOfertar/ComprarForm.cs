using ME.Data;
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
    public partial class ComprarForm : Form
    {
        public ComprarForm(bool esDirecta, decimal StockOBase)
        {
            InitializeComponent();

            if (esDirecta)
            {
                groupCompra.Text = "Compra";
                lblMontoCant.Text = "Cantidad:";
                btnAceptar.Text = "Comprar";

                numMontoCant.DecimalPlaces = 0;
                numMontoCant.Minimum = 1;
                numMontoCant.Maximum = StockOBase;
            } else {
                groupCompra.Text = "Subasta";
                lblMontoCant.Text = "Monto:";
                btnAceptar.Text = "Ofertar";

                numMontoCant.DecimalPlaces = 2;
                numMontoCant.Minimum = 0;
                numMontoCant.Maximum = StockOBase;
            }

            numMontoCant.Value = StockOBase;

        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                //UsuarioHandler.ResetPassword(UserLogged.cod_usuario, txtNuevaContraseña.Text);
                MessageBox.Show("La contraseña se modificó con éxito!", "Reestablecer contraseña", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch(Exception ex)
            {
                MessageBox.Show("Ocurrió un error al intentar modificar la contraseña \n" + ex.InnerException, "Reestablecer contraseña", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            this.Close();
        }

        private void ComprarForm_Load(object sender, EventArgs e)
        {

        }
    }
}
