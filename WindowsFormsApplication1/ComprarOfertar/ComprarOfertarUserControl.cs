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
    public partial class ComprarOfertarUserControl : UserControl
    {
        private const int pageSize = 10;
        private string descripcion = String.Empty, descrVacia = "Ingrese Búsqueda";
        private List<Publicacion> listaPublicaciones = new List<Publicacion>();
//        private List<Rubro> rubros = new List<Rubro>();
//        private List<decimal> cod_rubros = new List<decimal>();
        private string rubros = String.Empty;
        
        public ComprarOfertarUserControl()
        {
            InitializeComponent();
            ComprarOfertar_Load();

        }

        private void habilitarTodo(bool valor)
        {
            txtDescripcion.Enabled = valor;
            lstRubros.Enabled = valor;
            btnBuscar.Enabled = valor;
            btnLimpiar.Enabled = valor;
            gvPublicaciones.Enabled = valor;
            btnVer.Enabled = valor;
            btnComprar.Enabled = valor;
        }

        private void ComprarOfertar_Load()
        {
            Globales.NumPag_Publi = 0;
            Globales.TamanioPag_Publi = 10;
            Globales.TotalPags_Publi = 0;
            Globales.PagsEnCache_Publi = 0;

            habilitarTodo(false);
            
            listaPublicaciones = PublicacionHandler.ListarPublicaciones(true, string.Empty, String.Empty);
            //Init Grid
            gvPublicaciones.DataSource = listaPublicaciones;
            gvPublicaciones.Columns["visibilidad"].Visible = false;
            gvPublicaciones.Columns["estado"].Visible = false;
            gvPublicaciones.Columns["rubro"].Visible = false;
            gvPublicaciones.Columns["tipo_publi"].Visible = false;
            gvPublicaciones.Columns["fecha_finalizacion"].Visible = false;

            bindNavPubli.BindingSource = bindSourcePubli;
            bindSourcePubli.CurrentChanged += new System.EventHandler(bindSourcePubli_CurrentChanged);
            bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);

            habilitarTodo(true);
        }

        private void bindSourcePubli_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = bindSourcePubli.Current == null ? 0 : (int)bindSourcePubli.Current;

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
                for (int offset = 0; offset < totalRecords; offset += pageSize)
                    pageOffsets.Add(offset);
                return pageOffsets;
            }
        }

        private void ComprarOfertarUserControl_Load(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            txtDescripcion.Text = descrVacia;

            lstRubros.DataSource = RubroHandler.ListarRubros();
            lstRubros.ValueMember = "cod_rubro";
            lstRubros.DisplayMember = "desc_larga";
            lstRubros.SelectedItem = null;
            lstRubros.Text = "(Ninguno)";
        }

        private void btnComprar_Click(object sender, EventArgs e)
        {
            if (gvPublicaciones.SelectedRows.Count > 0) {
                Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

                if (publicacion.cod_usuario != UserLogged.cod_usuario) {
                    PublicacionForm publicacionForm = new PublicacionForm(publicacion, TipoAccion.Buy);
                    publicacionForm.ShowDialog(this);
                    ComprarOfertar_Load();
                } else {
                     MessageBox.Show("No puede Comprar/Ofertar a sí mismo", "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void gvPublicaciones_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
        }

        private void btnEditPublicacion_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null && publicacion.username == UserLogged.username && publicacion.estado.cod_estado == 2 /* "Borrador" */) {
                Form nuevaPublicacionForm = new PublicacionForm(publicacion, TipoAccion.Mod);
                nuevaPublicacionForm.ShowDialog(this);

                gvPublicaciones.Refresh();
                this.Refresh();
                ComprarOfertar_Load();

            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            txtDescripcion.Text = descrVacia;

            //lstRubros.SelectedValue = null;
            lstRubros.ClearSelected();
            lstRubros.Text = "(Ninguno)";
            //rubros.Clear();
            //cod_rubros.Clear();
            rubros = String.Empty;

            this.ComprarOfertar_Load();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            //Traigo la descripción que voy a pasar como parámetro
            descripcion = (txtDescripcion.Text != descrVacia && txtDescripcion.Text != String.Empty)?
                            txtDescripcion.Text : String.Empty;
            //Cargo los rubros seleccionados, si existen
            if (lstRubros.SelectedIndex > -1 && lstRubros.SelectedItems != null) {
                //rubros.Clear();
                //cod_rubros.Clear();
                listaPublicaciones.Clear();
                rubros = string.Empty;
                foreach (Rubro item in lstRubros.SelectedItems.Cast<Rubro>()) {
                    rubros += "|" + item.cod_rubro.ToString();
                    //rubros.Add(item); 
                }
                rubros += "|";
                
                //cod_rubros.AddRange(rubros.ConvertAll(rubro => rubro.cod_rubro));

                //for (int i = 0; i <= lstRubros.SelectedItems.Count; i++) {
                //    rubros += "|" + (Rubro)(lstRubros.SelectedItems[i])
                //}
            }
                
            //Llamo a mis publicaciones por parametros de busqueda 
            listaPublicaciones = PublicacionHandler.ListarPublicaciones(true, /*cod_rubros*/ rubros, descripcion);
            gvPublicaciones.DataSource = listaPublicaciones;
            gvPublicaciones.Refresh();
            bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
        }

        private void btnVer_Click(object sender, EventArgs e)
        {
            if (gvPublicaciones.SelectedRows.Count > 0){
                Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

                PublicacionForm publicacionForm = new PublicacionForm(publicacion, TipoAccion.View);
                
                publicacionForm.ShowDialog(this);
            }
        }

        private void bindNavNextItem_Click(object sender, EventArgs e)
        {
            if (bindNavPubli.PositionItem.Text != string.Empty && int.Parse(bindNavPubli.PositionItem.Text) * 10 == listaPublicaciones.Count)
            {
                listaPublicaciones.AddRange(PublicacionHandler.ListarPublicaciones(true, /*cod_rubros*/ rubros, descripcion));
                gvPublicaciones.DataSource = listaPublicaciones;
                gvPublicaciones.Refresh();
                bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
            }
        }

        private void txtDescripcion_Click(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowText;

            if (txtDescripcion.Text == descrVacia) {
                txtDescripcion.Text = String.Empty;
            }
        }

        private void txtDescripcion_Leave(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == String.Empty) {
                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = descrVacia;
            }
        }

        private void lstRubros_Click(object sender, EventArgs e)
        {
            lstRubros.ForeColor = System.Drawing.SystemColors.WindowText;
        }

        private void FillGrid()
        {
            gvPublicaciones.DataSource = listaPublicaciones;
        }

        private void bindNavPubli_RefreshItems(object sender, EventArgs e)
        {

        }

        private void gvPublicaciones_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            this.btnComprar_Click(sender, e);
        }
    }
}
