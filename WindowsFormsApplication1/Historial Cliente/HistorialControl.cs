using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Business;
using ME.Data;

namespace ME.UI
{
    public partial class HistorialControl : UserControl
    {
        private const int pageSize = 10;
        private List<Historial> listaHistorial = new List<Historial>();
        private List<Calificaciones> listaComprasPorUsuario = new List<Calificaciones>();

        public HistorialControl()
        {
            InitializeComponent();
            HistorialControlLoad();
        }

        private void HistorialControlLoad()
        {
            listaHistorial = HistorialHandler.ListarHistorial(UserLogged.cod_usuario);
            gvHistorial.DataSource = listaHistorial;
            listaComprasPorUsuario = CompraHandler.ListarComprasPorUsuario(UserLogged.cod_usuario);
            gvComprasUsuario.DataSource = listaComprasPorUsuario;

            bindingNavigator1.BindingSource = bindingSource1;
            bindingSource1.CurrentChanged += new System.EventHandler(bindingSource1_CurrentChanged);
            bindingSource1.DataSource = new PageOffsetList(gvHistorial.RowCount);
        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindingSource1.Current;
            var records = new List<Historial>(); 
            for (int i = offset; i < offset + pageSize && i < listaHistorial.Count; i++)
                records.Add(listaHistorial.ElementAt(i));
            gvHistorial.DataSource = records;
        }

        class PageOffsetList : System.ComponentModel.IListSource
        {
            private int totalRecords { get; set; }
            public PageOffsetList(int totalRecords)
            {
                this.totalRecords = totalRecords;
            }

            public bool ContainsListCollection { get; protected set; }

            public System.Collections.IList GetList()
            {
                // Return a list of page offsets based on "totalRecords" and "pageSize"
                var pageOffsets = new List<int>();
                for (int offset = 0; offset < totalRecords; offset += pageSize)
                    pageOffsets.Add(offset);
                return pageOffsets;
            }
        }

    }
}
