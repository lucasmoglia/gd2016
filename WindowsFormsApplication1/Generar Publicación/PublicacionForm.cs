using ME.Business;
using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI
{
    public partial class PublicacionForm : Form
    {
        bool esNuevaPubli = false, EsModificable = false;

        public PublicacionForm(Publicacion publicacion, bool modificable)
        {
            InitializeComponent();

            if (publicacion == null)
            {
                this.Text = "Nueva Publicación";
                this.esNuevaPubli = true;

                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = "Ingrese aquí la descripción";
                //lblUsername.Text = UsuarioLogueado.username

                cmbBoxTipoPubli.SelectedItem = null;
                DTFechaInicio.Value = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                DTFechaInicio.MinDate = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                DTFechaVencimiento.Value = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                DTFechaVencimiento.MinDate = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                numStock.Value = 1;
                numPrecio.Value = 0;
                cmbBoxVisibilidad.SelectedItem = null;
                cmbBoxEstado.SelectedItem = null;
                cmbBoxRubro.SelectedItem = null;
                cmbBoxEnvio.SelectedItem = null;
                //cmbBoxPreguntas.SelectedItem = null;
                btnCancelar.Text = "Cancelar";

                txtDescripcion.Enabled = true;
                cmbBoxTipoPubli.Enabled = true;
                DTFechaInicio.Enabled = true;
                DTFechaVencimiento.Enabled = true;
                numStock.Enabled = true;
                numPrecio.Enabled = true;
                cmbBoxVisibilidad.Enabled = true;
                cmbBoxEstado.Enabled = true;
                cmbBoxRubro.Enabled = true;
                cmbBoxEnvio.Enabled = true;
                cmbBoxPreguntas.Enabled = true;
                btnGuardar.Enabled = true;
                btnGuardar.Visible = true;

            } else {
                if (modificable) {
                    this.Text = "Modificar Publicación " + publicacion.cod_publi.ToString();
                    this.EsModificable = true;
                    btnCancelar.Text = "Cancelar";

                    txtDescripcion.Enabled = true;
                    cmbBoxTipoPubli.Enabled = true;
                    DTFechaInicio.Enabled = true;
                    DTFechaVencimiento.Enabled = true;
                    numStock.Enabled = true;
                    numPrecio.Enabled = true;
                    cmbBoxVisibilidad.Enabled = true;
                    cmbBoxEstado.Enabled = true;
                    cmbBoxRubro.Enabled = true;
                    cmbBoxEnvio.Enabled = true;
                    cmbBoxPreguntas.Enabled = true;
                    btnGuardar.Enabled = true;
                    btnGuardar.Visible = true;
                } else {
                    this.Text = "Publicación " + publicacion.cod_publi.ToString();
                    btnCancelar.Text = "OK";

                    txtDescripcion.Enabled = false;
                    cmbBoxTipoPubli.Enabled = false;
                    DTFechaInicio.Enabled = false;
                    DTFechaVencimiento.Enabled = false;
                    numStock.Enabled = false;
                    numPrecio.Enabled = false;
                    cmbBoxVisibilidad.Enabled = false;
                    cmbBoxEstado.Enabled = false;
                    cmbBoxRubro.Enabled = false;
                    cmbBoxEnvio.Enabled = false;
                    cmbBoxPreguntas.Enabled = false;
                    btnGuardar.Enabled = false;
                    btnGuardar.Visible = false;
                }

                this.esNuevaPubli = false;
                lblUsername.Text = publicacion.username;
                txtDescripcion.Text = publicacion.descripcion;
                cmbBoxTipoPubli.SelectedItem = publicacion.tipo_publi;
                DTFechaInicio.Value = publicacion.fecha_inicio;
                DTFechaInicio.MinDate = publicacion.fecha_inicio;
                DTFechaVencimiento.Value = publicacion.fecha_vencimiento;
                DTFechaVencimiento.MinDate = publicacion.fecha_vencimiento;
                numStock.Value = publicacion.stock;
                numPrecio.Value = publicacion.precio_producto;
                cmbBoxVisibilidad.SelectedItem = publicacion.visibilidad;
                cmbBoxEstado.SelectedItem = publicacion.estado;
                cmbBoxRubro.SelectedItem = publicacion.rubro;
                cmbBoxEnvio.SelectedItem = publicacion.con_envio;
                cmbBoxPreguntas.SelectedItem = publicacion.con_preguntas;
            }
        }

        private class VoF
        {
            public bool cod_valor { get; set; }
            public string valor { get; set; }

            public VoF(bool cod_valor, string valor)
            {
                this.cod_valor = cod_valor;
                this.valor = valor;
            }
        }

        private void PublicacionForm_Load(object sender, EventArgs e)
        {
//            txtDescripcion.Focus();

            bool esEmpresa = true; //SACAR. Esto representa a un usuario Empresa.

            if (esNuevaPubli || EsModificable) {

                numStock.Enabled = true;

                if (esEmpresa) {
                    List<Rubro> listaRubros = new List<Rubro>();
                    listaRubros.Add(RubroHandler.ObtenerRubro("Electrónicos"));

                    cmbBoxRubro.DataSource = listaRubros;
                } else {
                    cmbBoxRubro.DataSource = RubroHandler.ListarRubros();
                }

                cmbBoxRubro.ValueMember = "cod_rubro";
                cmbBoxRubro.DisplayMember = "desc_larga";

                cmbBoxTipoPubli.DataSource = TipoPublicacionHandler.ListarTiposPublicacion();
                cmbBoxTipoPubli.ValueMember = "cod_tipo_publi";
                cmbBoxTipoPubli.DisplayMember = "nombre";

                cmbBoxVisibilidad.DataSource = VisibilidadHandler.ListarVisibilidades();
                cmbBoxVisibilidad.ValueMember = "cod_visibilidad";
                cmbBoxVisibilidad.DisplayMember = "nombre";

                List<Estado> estados = EstadoHandler.ListarEstados();
                estados.Remove(estados.Find(est => est.nombre == "Publicada"));

                cmbBoxEstado.DataSource = estados;
                cmbBoxEstado.ValueMember = "cod_estado";
                cmbBoxEstado.DisplayMember = "nombre";

                VoF si = new VoF(true, "Si");
                VoF no = new VoF(false, "No");

                List<VoF> si_No_Envio = new List<VoF>();
                si_No_Envio.Add(si);
                si_No_Envio.Add(no);
                List<VoF> si_No_Preg = new List<VoF>();
                si_No_Preg.Add(si);
                si_No_Preg.Add(no);

                cmbBoxEnvio.DataSource = si_No_Envio;
                cmbBoxEnvio.ValueMember = "cod_valor";
                cmbBoxEnvio.DisplayMember = "valor";

                cmbBoxPreguntas.DataSource = si_No_Preg;
                cmbBoxPreguntas.ValueMember = "cod_valor";
                cmbBoxPreguntas.DisplayMember = "valor";
            }

            if (esNuevaPubli) {
                cmbBoxEnvio.SelectedValue = false;
                cmbBoxPreguntas.SelectedValue = false;
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            decimal usuarioLogueado = 1; // Usar Variable global

            if (txtDescripcion.Text != String.Empty)
            {
                Publicacion nuevaPublicacion = PublicacionHandler.Guardar(txtDescripcion.Text, numStock.Value, DTFechaInicio.Value, DTFechaVencimiento.Value, numPrecio.Value, decimal.Parse(cmbBoxVisibilidad.SelectedValue.ToString()),
                                               decimal.Parse(cmbBoxEstado.SelectedValue.ToString()), decimal.Parse(cmbBoxRubro.SelectedValue.ToString()), usuarioLogueado, decimal.Parse(cmbBoxTipoPubli.SelectedValue.ToString()),
                                               bool.Parse(cmbBoxEnvio.SelectedValue.ToString()), bool.Parse(cmbBoxPreguntas.SelectedValue.ToString()));

                PublicacionForm muestraDeNuevaPubli = new PublicacionForm(nuevaPublicacion, false);

                muestraDeNuevaPubli.Show();

                this.Close();
            }
        }

        private void txtDescripcion_Enter(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowText;

            if (txtDescripcion.Text == "Ingrese aquí la descripción")
            {
                txtDescripcion.Text = String.Empty;
            }
        }

        private void txtDescripcion_Leave(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == String.Empty)
            {
                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = "Ingrese aquí la descripción";
            }
        }

        private void cmbBoxTipoPubli_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (esNuevaPubli) {
                if (((TipoPublicacion)cmbBoxTipoPubli.SelectedItem).nombre == "Subasta") {
                    numStock.Value = 1;
                    numStock.Enabled = false;
                } else {
                    numStock.Enabled = true;
                }
            }
        }

        private void cmbBoxVisibilidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (esNuevaPubli || EsModificable) {
                if (((Visibilidad)cmbBoxVisibilidad.SelectedItem).nombre == "Gratis") {
                    cmbBoxEnvio.SelectedValue = true;
                    cmbBoxEnvio.Enabled = false;
                } else {
                    cmbBoxEnvio.Enabled = true;
                }
            }
        }

        private void DTFechaInicio_ValueChanged(object sender, EventArgs e)
        {
            if (DTFechaVencimiento.Value < DTFechaInicio.Value) {
                DTFechaVencimiento.Value = DTFechaInicio.Value;
            }
        }

        private void cmbBoxEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (esNuevaPubli || EsModificable)
            {
                if (((Estado)cmbBoxEstado.SelectedItem).nombre == "Activa") {
                    btnGuardar.Text = "Publicar";
                } else {
                    btnGuardar.Text = "Guardar";
                }
            }

        }
    }
}
