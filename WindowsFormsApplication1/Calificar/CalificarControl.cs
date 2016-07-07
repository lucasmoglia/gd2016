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
            this.CalificarControlLoad();
        }
        private void CalificarControlLoad()
        {
            // Este Procedimiento carga las Data Grid Views del form Calificar Control
            listaComprasSinCalificar = CompraHandler.ListarComprasSinCalificar(UserLogged.cod_usuario);
            gvComprasSinCalificar.DataSource = listaComprasSinCalificar;

            listaComprasCalificadas = CompraHandler.Listar5ComprasCalificadas(UserLogged.cod_usuario);
            gvComprasCalificadas.DataSource = listaComprasCalificadas;

            listaComprasPorUsuario = CompraHandler.ListarComprasPorUsuario(UserLogged.cod_usuario);
            gvComprasUsuario.DataSource = listaComprasPorUsuario;
        }


        private void gvComprasSinCalificar_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            btnCalificar.Visible = true;
            btnCalificar.Enabled = true;
            
        }

        private void btnCalificar_Click(object sender, EventArgs e)
        {
            Compra compra = (Compra)gvComprasSinCalificar.SelectedRows[0].DataBoundItem;
            Form nuevaCalificacionForm = new NuevaCalificacionForm(compra);
            nuevaCalificacionForm.ShowDialog(this);
            this.CalificarControlLoad();
        }




    }
}
