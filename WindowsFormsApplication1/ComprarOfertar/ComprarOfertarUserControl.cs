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
        private List<Publicacion> listaPublicaciones;
        private List<Rubro> rubros = new List<Rubro>();
        private List<decimal> cod_rubros = new List<decimal>();
        
        public ComprarOfertarUserControl()
        {
            InitializeComponent();

            Globales.NumPag_Publi = 0;
            Globales.TamanioPag_Publi = 10;
            Globales.TotalPags_Publi = 0;
            Globales.PagsEnCache_Publi = 0;
            
            listaPublicaciones = PublicacionHandler.ListarPublicaciones(1, null, String.Empty);
            gvPublicaciones.DataSource = listaPublicaciones;
            //gvPublicaciones.Columns["visibilidad"].ValueType = class();
            gvPublicaciones.Columns["visibilidad"].DataPropertyName = "descripcion";
            //gvPublicaciones.Columns.Remove("cod_publi");
            bindNavPubli.BindingSource = bindSourcePubli;
            bindSourcePubli.CurrentChanged += new System.EventHandler(bindSourcePubli_CurrentChanged);
            bindSourcePubli.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
        }

        private void bindSourcePubli_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindSourcePubli.Current;
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

            //gvPublicaciones.Columns["visibilidad"].DataPropertyName = descripcion;
            //gvPublicaciones.Columns["estado"].DataPropertyName = nombre;
            //gvPublicaciones.Columns["rubro"].DataPropertyName = desc_larga;

        }

        private void btnComprar_Click(object sender, EventArgs e)
        {
            if (gvPublicaciones.SelectedRows != null) {
                Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

                if (publicacion.cod_usuario != UserLogged.cod_usuario) {
                    PublicacionForm publicacionForm = new PublicacionForm(publicacion, TipoAccion.Buy);
                    publicacionForm.ShowDialog(this);
                } else {
                     MessageBox.Show("No puede Comprar/Ofertar a sí mismo", "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void gvPublicaciones_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (UserLogged.esAdmin) {
                btnEditPublicacion.Visible = true;
                btnRemovePublicacion.Visible = true;
            }
        }

        private void btnEditPublicacion_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null && publicacion.username == UserLogged.username && publicacion.estado.cod_estado == 2 /* "Borrador" */) {
                Form nuevaPublicacionForm = new PublicacionForm(publicacion, TipoAccion.Mod);
                nuevaPublicacionForm.ShowDialog(this);

                gvPublicaciones.Refresh();
                this.Refresh();
            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            txtDescripcion.Text = descrVacia;

            //lstRubros.SelectedValue = null;
            lstRubros.ClearSelected();
            lstRubros.Text = "(Ninguno)";
            rubros.Clear();
            cod_rubros.Clear();

        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            descripcion = (txtDescripcion.Text != descrVacia && txtDescripcion.Text != String.Empty)?
                            txtDescripcion.Text
                            :
                            String.Empty;

            if (lstRubros.SelectedIndex > -1 && lstRubros.SelectedItems != null) {
                rubros.Clear();
                cod_rubros.Clear();
                listaPublicaciones.Clear();

                foreach (Rubro item in lstRubros.SelectedItems.Cast<Rubro>())
                {
                    rubros.Add(item);
                }

                cod_rubros.AddRange(rubros.ConvertAll(rubro => rubro.cod_rubro));
                
                listaPublicaciones = PublicacionHandler.ListarPublicaciones(1, cod_rubros, descripcion);
                bindSourcePubli.DataSource = listaPublicaciones;
            }

            gvPublicaciones.Refresh();
        }

        private void btnVer_Click(object sender, EventArgs e)
        {
            if (gvPublicaciones.SelectedRows != null){
                Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

                PublicacionForm publicacionForm = new PublicacionForm(publicacion, TipoAccion.View);
                
                publicacionForm.ShowDialog(this);
            }
        }

        private void bindNavNextItem_Click(object sender, EventArgs e)
        {
            if (Globales.NumPag_Publi + 1 > Globales.PagsEnCache_Publi){
                listaPublicaciones.AddRange(PublicacionHandler.ListarPublicaciones(1, cod_rubros, descripcion));
                bindSourcePubli.DataSource = listaPublicaciones;

                gvPublicaciones.Refresh();
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

        private void lstRubros_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void lstRubros_Click(object sender, EventArgs e)
        {
            lstRubros.ForeColor = System.Drawing.SystemColors.WindowText;
        }

        private void gvPublicaciones_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            this.btnComprar_Click(sender, e);
        }
    }
}
