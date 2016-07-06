using ME.Data;
using ME.Business;
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
        private List<Compra> listaComprasSinCalificar = new List<Compra>();
        private List<Compra> listaComprasCalificadas = new List<Compra>();
        private List<Calificaciones> listaComprasPorUsuario = new List<Calificaciones>();

        public CalificarControl()
        {
            InitializeComponent();
//            listaComprasSinCalificar = CompraHandler.ListarComprasSinCalificar(UserLogged.cod_usuario);
            listaComprasSinCalificar = CompraHandler.ListarComprasSinCalificar(81);
            gvComprasSinCalificar.DataSource = listaComprasSinCalificar;
//            gvComprasSinCalificar.Columns.Remove("id_compra");

            listaComprasCalificadas = CompraHandler.Listar5ComprasCalificadas(81);
//            listaComprasCalificadas = CompraHandler.Listar5ComprasCalificadas(UserLogged.cod_usuario);
            gvComprasCalificadas.DataSource = listaComprasCalificadas;
//            gvComprasCalificadas.Columns.Remove("id_compra");

            listaComprasPorUsuario = CompraHandler.ListarComprasPorUsuario(81);
//            listaComprasCalificadas = CompraHandler.Listar5ComprasCalificadas(UserLogged.cod_usuario);
            gvComprasUsuario.DataSource = listaComprasPorUsuario;
//            gvComprasCalificadas.Columns.Remove("id_compra");

        }

        private void btnCalificar_Click(object sender, EventArgs e)
        {
            Compra compra = (Compra)gvComprasSinCalificar.SelectedRows[0].DataBoundItem;
            Form nuevaCalificacionForm = new NuevaCalificacionForm(compra);
            nuevaCalificacionForm.ShowDialog(this);
        }
    }
}
