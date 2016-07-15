using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Data;
using ME.Business;

namespace ME.UI
{
    public partial class MisPublicacionesUserControl : UserControl
    {
        private List<Publicacion> listaPublicaciones = new List<Publicacion>();
        private const int pageSize = 10;

        public MisPublicacionesUserControl()
        {
            InitializeComponent();
            btnEditar.Visible = UserLogged.funcionalidades.Any(f => f.cod_funcionalidad == 3);
            FillGrid();
        }

        private void FillGrid()
        {
            Globales.NumPag_Publi = 0;
            Globales.TamanioPag_Publi = 10;
            Globales.TotalPags_Publi = 0;
            Globales.PagsEnCache_Publi = 0;

            this.listaPublicaciones = PublicacionHandler.ListarMisPublicaciones();
            gvPublicaciones.DataSource = listaPublicaciones;
            #region hide_columns
            gvPublicaciones.Columns["visibilidad"].Visible = false;
            gvPublicaciones.Columns["estado"].Visible = false;
            gvPublicaciones.Columns["rubro"].Visible = false;
            gvPublicaciones.Columns["tipo_publi"].Visible = false;
            gvPublicaciones.Columns["fecha_finalizacion"].Visible = false;
            #endregion
            gvPublicaciones.Refresh();
            bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
            bindingNavigator1.BindingSource = bindSourcePubli;
            bindSourcePubli.CurrentChanged += new System.EventHandler(bindSourcePubli_CurrentChanged);
            bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);

            btnEditar.Visible = gvPublicaciones.RowCount > 0;
        }

        private void bindSourcePubli_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)(bindSourcePubli.Current ?? 0);
            var records = new List<Publicacion>();
            for (int i = offset; i < offset + pageSize && i < listaPublicaciones.Count; i++)
                records.Add(listaPublicaciones.ElementAt(i));
            gvPublicaciones.DataSource = records;
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

                if (totalRecords == 0)
                {
                    pageOffsets.Add(0);
                    return pageOffsets;
                }

                for (int offset = 0; offset < totalRecords; offset += pageSize)
                    pageOffsets.Add(offset);
                return pageOffsets;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null)
            {
                Form nuevaPublicacionForm = new PublicacionForm(publicacion, TipoAccion.Mod);
                nuevaPublicacionForm.ShowDialog(this);
                gvPublicaciones.Refresh();
            }
        }
    
        private void onPublicacionSelected(object sender, EventArgs e)
        {
            Publicacion publicacion;

            if (gvPublicaciones.SelectedRows.Count > 0 && (publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem) != null)
            {
                /*cod_estado	descripcion
                            1	Publicada
                            2	Borrador
                            3	Activa
                            4	Pausada
                            5	Finalizada
                 */
                switch (publicacion.estado.cod_estado.ToString())
                {
                    case "2":
                        {
                            btnEditar.Visible = true;
                            break;
                        }
                    case "3":
                        {
                            btnEditar.Visible = false;
                            break;
                        }
                    case "4":
                        {
                            btnEditar.Visible = false;
                            break;
                        }
                    case "5":
                        {
                            btnEditar.Visible = false;
                            break;
                        }
                }
            }
        }

        private void bindingNavigatorPositionItem_TextChanged(object sender, EventArgs e){
            if (bindingNavigator1.PositionItem.Text != string.Empty && int.Parse(bindingNavigator1.PositionItem.Text) * 10 == listaPublicaciones.Count)
            {
                listaPublicaciones.Clear();
                listaPublicaciones.AddRange(PublicacionHandler.ListarMisPublicaciones());
                gvPublicaciones.DataSource = listaPublicaciones;
                gvPublicaciones.Refresh();
                bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
            }
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            PublicacionForm publicacionForm = new PublicacionForm(publicacion, TipoAccion.View);

            publicacionForm.ShowDialog(this);
        }
    }
}
