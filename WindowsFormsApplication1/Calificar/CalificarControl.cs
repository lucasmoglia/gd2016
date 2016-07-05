using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI.Calificar
{
    public partial class CalificarControl : UserControl
    {
        private List<Compra> listaCompras = new List<Compra>();

        public CalificarControl()
        {
            InitializeComponent();
            listaCompras = CompraHandler.ListarComprasSinCalificar(UserLogged.cod_usuario);
            gvComprasSinCalificar.DataSource = listaCompras;
            // gvComprasSinCalificar.Columns.Remove("cod_visibilidad");

        }
    }
}
