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
        decimal StockBase = 0;
        bool Directa = false;

        public ComprarForm(bool esDirecta, decimal StockOBase)
        {
            InitializeComponent();

            StockBase = StockOBase;

            if (esDirecta) {
                Directa = true;
                groupCompra.Text = "Compra";
                lblMontoCant.Text = "Cantidad:";
                btnAceptar.Text = "Comprar";

                numMontoCant.DecimalPlaces = 0;
                numMontoCant.Minimum = 1;
                numMontoCant.Maximum = StockOBase;
            } else { // Subasta
                Directa = false;
                groupCompra.Text = "Subasta";
                lblMontoCant.Text = "Monto:";
                btnAceptar.Text = "Ofertar";

                numMontoCant.DecimalPlaces = 2;
                numMontoCant.Minimum = StockOBase;
                numMontoCant.Maximum = Decimal.MaxValue;
            }

            numMontoCant.Value = StockOBase;
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if (Directa) {
                if (numMontoCant.Value >= 1 && numMontoCant.Value <= StockBase) {
                    PublicacionForm publi = (PublicacionForm)this.Owner; // Setea el Formulario PublicacionForm en una variable.

                    publi.valor = numMontoCant.Value; // Setea la variable "valor" del form PublicacionForm.

                    this.Close();
                } else {
                    MessageBox.Show("No se puede ofertar menos del valor actual de la oferta", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            } else { // Subasta
                if (numMontoCant.Value > 0 && numMontoCant.Value > StockBase) {
                    PublicacionForm publi = (PublicacionForm)this.Owner; // Setea el Formulario PublicacionForm en una variable.

                    publi.valor = numMontoCant.Value; // Setea la variable "valor" del form PublicacionForm.

                    this.Close();
                } else {
                    MessageBox.Show("No se puede ofertar menos del valor actual de la oferta", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void ComprarForm_Load(object sender, EventArgs e)
        {

        }
    }
}
