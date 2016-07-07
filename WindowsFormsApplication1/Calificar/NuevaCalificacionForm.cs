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
using ME.Data;
using ME.UI.Calificar;

namespace ME.UI.Calificar
{
    public partial class NuevaCalificacionForm : Form
    {
        public NuevaCalificacionForm(Compra compra)
        {
            InitializeComponent();

            if (compra != null)
            {
                //Traigo los datos de la compra
                lbl_IdCompra.Text    = compra.id_compra.ToString();
                lbl_CodPubli.Text    = compra.cod_publi.ToString();
                lbl_FechaCompra.Text = compra.fecha_compra.ToString();
                lbl_Cantidad.Text    = compra.cantidad.ToString();
                lbl_Monto.Text       = compra.monto.ToString();
            }
     
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            CompraHandler.Calificar(decimal.Parse(lbl_IdCompra.Text), numEstrellas.Value, txtDescCalificacion.Text);
            this.Close();
        }


    }
}
