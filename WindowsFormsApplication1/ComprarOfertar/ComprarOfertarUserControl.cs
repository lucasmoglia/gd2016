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
        private List<Publicacion> listaPublicaciones;
        public UsuarioModel usuarioLogueado = null; // SACAR esto va a estar en la variable global de usuario logueado.
        
        public ComprarOfertarUserControl()
        {
            InitializeComponent();

            //listaPublicaciones = PublicacionHandler.ListarPublicaciones(1, null, String.Empty);
            //gvPublicaciones.DataSource = listaPublicaciones;
            //gvPublicaciones.Columns.Remove("cod_publi");
            bindNav1.BindingSource = bindSourcePublicaciones;
            bindSourcePublicaciones.CurrentChanged += new System.EventHandler(bindSourcePublicaciones_CurrentChanged);
            bindSourcePublicaciones.DataSource = new PageOffsetList(gvPublicaciones.RowCount);
        }

        private void bindSourcePublicaciones_CurrentChanged(object sender, EventArgs e)
        {
            // The desired page has changed, so fetch the page of records using the "Current" offset 
            int offset = (int)bindSourcePublicaciones.Current;
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
            txtDescripcion.Text = "Ingrese Búsqueda";

            lstRubros.DataSource = RubroHandler.ListarRubros();
            lstRubros.ValueMember = "cod_rubro";
            lstRubros.DisplayMember = "desc_larga";
            lstRubros.SelectedItem = null;
            lstRubros.Text = "(Ninguno)";

            //gvPublicaciones.DataSource = PublicacionHandler.ListarPublicaciones(1, null, String.Empty);
            listaPublicaciones = PublicacionHandler.ListarPublicaciones(1, null, String.Empty);
            gvPublicaciones.DataSource = listaPublicaciones;
            gvPublicaciones.Columns.Remove("cod_publi");

        }

        private void btnComprar_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null) {
                PublicacionForm publicacionForm = new PublicacionForm(publicacion, false);
                publicacionForm.ShowDialog(this);
            }
        }

        private void gvPublicaciones_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            bool esAdmin = false; // SACAR esto va a estar en la variable global de usuario logueado.

            if (esAdmin) {
                btnEditPublicacion.Visible = true;
                btnRemovePublicacion.Visible = true;
            }
        }

        private void btnEditPublicacion_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null && publicacion.username == usuarioLogueado.username && publicacion.estado.nombre == "Borrador") {
                Form nuevaPublicacionForm = new PublicacionForm(publicacion, true);
                nuevaPublicacionForm.ShowDialog(this);

                gvPublicaciones.Refresh();
            }
        }

        private void txtDescripcion_Click(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowText;

            if (txtDescripcion.Text == "Ingrese Búsqueda") {
                txtDescripcion.Text = String.Empty;
            }
        }

        private void txtDescripcion_Leave(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == String.Empty) {
                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = "Ingrese Búsqueda";
            }
        }

        private void lstRubros_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void lstRubros_Click(object sender, EventArgs e)
        {
            lstRubros.ForeColor = System.Drawing.SystemColors.WindowText;
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            txtDescripcion.Text = "Ingrese Búsqueda";

            //lstRubros.SelectedValue = null;
            lstRubros.ClearSelected();
            lstRubros.Text = "(Ninguno)";

        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            List<Rubro> rubros = null;
            List<decimal> cod_rubros = null;

            if (lstRubros.SelectedIndex > -1 && lstRubros.SelectedItems != null) {
                //rubros = lstRubros.SelectedItems.GetEnumerator();
                //cod_rubros = new List<decimal>();
                //rubros.AddRange(/*decimal.Parse */((lstRubros.SelectedItems.Cast<List<Rubro>>().ToList()) /*.ToString())*/);
                cod_rubros = rubros.ConvertAll(rubro => rubro.cod_rubro);
            }

            gvPublicaciones.DataSource = PublicacionHandler.ListarPublicaciones(1, cod_rubros, txtDescripcion.Text);
        }

        private void btnVer_Click(object sender, EventArgs e)
        {
            Publicacion publicacion = (Publicacion)gvPublicaciones.SelectedRows[0].DataBoundItem;

            if (publicacion != null) {
                PublicacionForm publicacionForm = new PublicacionForm(publicacion, false);
                publicacionForm.ShowDialog(this);
            }
        }


    }
}
