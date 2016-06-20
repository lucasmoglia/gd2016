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
        public PublicacionForm(Publicacion publicacion, bool modificable)
        {
            InitializeComponent();

            if (publicacion == null)
            {
                this.Text = "Nueva Publicación";
                txtDescripcion.Text = "";

                cmbBoxTipoPubli.SelectedItem = null;
                DTFechaInicio.Value = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                DTFechaVencimiento.Value = System.DateTime.Today; // Poner la fecha del archivo de configuración.
                numStock.Value = 0;
                numPrecio.Value = 0;
                cmbBoxVisibilidad.SelectedItem = null;
                cmbBoxEstado.SelectedItem = null;
                cmbBoxRubro.SelectedItem = null;
                cmbBoxEnvio.SelectedItem = null;
                cmbBoxPreguntas.SelectedItem = null;
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
                    this.Text = "Modificar Publicación" + publicacion.cod_publi.ToString();
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
                }
                else
                {
                    this.Text = "Publicación" + publicacion.cod_publi.ToString();
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

                txtDescripcion.Text = publicacion.descripcion;
                cmbBoxTipoPubli.SelectedItem = publicacion.tipo_publi;
                DTFechaInicio.Value = publicacion.fecha_inicio;
                DTFechaVencimiento.Value = publicacion.fecha_vencimiento;
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
            List<VoF> si_No = new List<VoF>();
            VoF si = new VoF(true, "Si");
            VoF no = new VoF(false, "No");    
            si_No.Add(si);
            si_No.Add(no);

            this.numStock.Enabled = true;
            this.DTFechaInicio.MinDate = System.DateTime.Today; // Poner la fecha del archivo de configuración.
            this.DTFechaVencimiento.MinDate = System.DateTime.Today; // Poner la fecha del archivo de configuración.

            this.cmbBoxTipoPubli.ValueMember   = "cod_tipo_publi";
            this.cmbBoxTipoPubli.DisplayMember = "descripcion";
            this.cmbBoxTipoPubli.DataSource = TipoPublicacionHandler.ListarTiposPublicacion();

            this.cmbBoxVisibilidad.ValueMember   = "cod_visibilidad";
            this.cmbBoxVisibilidad.DisplayMember = "descripcion";
            this.cmbBoxVisibilidad.DataSource = VisibilidadHandler.ListarVisibilidades();

            this.cmbBoxEstado.ValueMember   = "cod_estado";
            this.cmbBoxEstado.DisplayMember = "descripcion";
            this.cmbBoxEstado.DataSource = EstadoHandler.ListarEstados();

            this.cmbBoxRubro.ValueMember   = "cod_rubro";
            this.cmbBoxRubro.DisplayMember = "desc_larga";

            bool esEmpresa = true; //SACAR. Esto representa a un usuario Empresa.

            if (esEmpresa)
            {
                this.cmbBoxRubro.DataSource = RubroHandler.ObtenerRubro("Tecnología");
            }else {
                this.cmbBoxRubro.DataSource = RubroHandler.ListarRubros();
            }

            this.cmbBoxEnvio.ValueMember = "cod_valor";
            this.cmbBoxEnvio.DisplayMember = "valor";
            this.cmbBoxEnvio.DataSource = si_No;

            this.cmbBoxPreguntas.ValueMember = "cod_valor";
            this.cmbBoxPreguntas.DisplayMember = "valor";
            this.cmbBoxPreguntas.DataSource = si_No;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
//            bool esEmpresa = true;   //SACAR. Esto representa a un usuario Empresa.

            Publicacion nuevaPublicacion = PublicacionHandler.Guardar(txtDescripcion.Text, cmbBoxTipoPubli.SelectedIndex, DTFechaInicio.Value, DTFechaVencimiento.Value, numStock.Value, numPrecio.Value,
                                       cmbBoxVisibilidad.SelectedIndex, cmbBoxEstado.SelectedIndex, cmbBoxRubro.SelectedIndex, cmbBoxEnvio.SelectedIndex, cmbBoxPreguntas.SelectedIndex);
            
            new PublicacionForm(nuevaPublicacion, false);

            this.Close();
        }

        private void cmbBoxTipoPubli_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbBoxTipoPubli.SelectedValue.ToString() == "Subasta")
            {
                numStock.Value = 1;
                numStock.Enabled = false;
            }
        }
    }
}
