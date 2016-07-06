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
//                numCodVisibilidad.Value = visibilidad.cod_visibilidad;
//                txtDescripcionV.Text = visibilidad.descripcion;
            }
     
        }







    }
}
