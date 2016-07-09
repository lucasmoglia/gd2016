using ME.Business;
using ME.Data;
using ME.UI.Calificar;
using ME.UI.Facturas;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI
{
    public partial class PublicacionForm : Form
    {
        bool esNuevaPubli = false, esModificable = false, esCompra = false, esView = false;
        Publicacion PublicacionExistente = null;
        private string descrVacia = "Ingrese aquí la descripción";

        #region publi Members
        public decimal valor = 0;
        #endregion

        private void habilitarTodo(bool valor)
        {
            txtDescripcion.Enabled = valor;
            cmbBoxTipoPubli.Enabled = valor;
            DTFechaInicio.Enabled = valor;
            DTFechaVencimiento.Enabled = valor;
            numStock.Enabled = valor;
            numPrecio.Enabled = valor;
            cmbBoxVisibilidad.Enabled = valor;
            cmbBoxEstado.Enabled = valor;
            cmbBoxRubro.Enabled = valor;
            cmbBoxEnvio.Enabled = valor;
            cmbBoxPreguntas.Enabled = valor;
        }

        public PublicacionForm(Publicacion publicacion, TipoAccion accion)
        {
            InitializeComponent();

            if (publicacion == null)
            {
                this.Text = "Nueva Publicación";
                this.esNuevaPubli = true;

                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = descrVacia;
                lblUsername.Text = UserLogged.username;

                cmbBoxTipoPubli.SelectedItem = null;
                DTFechaInicio.Value = System.DateTime.Today; // No anda con: DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString()); 
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

                habilitarTodo(true);

                btnGuardar.Enabled = true;
                btnGuardar.Visible = true;
            }
            else { // publicacion != null
                switch (accion) {
                    case TipoAccion.Mod:
                        this.Text = "Modificar Publicación " + publicacion.cod_publi.ToString();
                        this.esModificable = true;
                        btnCancelar.Text = "Cancelar";
                        btnGuardar.Text = "Guardar";

                        habilitarTodo(true);

                        btnGuardar.Enabled = true;
                        btnGuardar.Visible = true;
                    break;

                    case TipoAccion.Buy:
                        this.Text = (publicacion.tipo_publi.cod_tipo_publi == 1 /* Compra Inmediata */? "Comprar" : "Ofertar") + " Publicación " + publicacion.cod_publi.ToString();
                        this.esCompra = true;
                        btnCancelar.Text = "Cancelar";
                        btnGuardar.Text = (publicacion.tipo_publi.cod_tipo_publi == 1 /* Compra Inmediata */? "Comprar" : "Ofertar");

                        habilitarTodo(false);

                        btnGuardar.Enabled = true;
                        btnGuardar.Visible = true;
                    break;

                    default: // TipoAccion.View: 
                        this.Text = "Publicación " + publicacion.cod_publi.ToString();
                        this.esView = true;
                        btnCancelar.Text = "OK";

                        habilitarTodo(false);

                        btnGuardar.Enabled = false;
                        btnGuardar.Visible = false;
                    break;
                }

                this.esNuevaPubli = false;
                PublicacionExistente = publicacion;
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

            numStock.Enabled = (esNuevaPubli || esModificable);

            if (UserLogged.esEmpresa && (esNuevaPubli || esModificable)) {
                List<Rubro> listaRubro = new List<Rubro>();
                listaRubro.Add(RubroHandler.ObtenerRubro("Electrónicos"));

                cmbBoxRubro.DataSource = listaRubro;
                cmbBoxRubro.SelectedItem = listaRubro[0].cod_rubro;
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
            cmbBoxVisibilidad.DisplayMember = "descripcion";

            List<Estado> estados = EstadoHandler.ListarEstados();
            if (esNuevaPubli)
                estados.Remove(estados.Find(est => est.nombre == "Publicada"));

            cmbBoxEstado.DataSource = estados;
            cmbBoxEstado.ValueMember = "cod_estado";
            cmbBoxEstado.DisplayMember = "nombre";
            cmbBoxEstado.SelectedItem = estados[0];

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

            if (esNuevaPubli) {
                cmbBoxEnvio.SelectedValue = false;
                cmbBoxPreguntas.SelectedValue = false;
            } else {
                lblUsername.Text = PublicacionExistente.username;
                txtDescripcion.Text = PublicacionExistente.descripcion;
                cmbBoxTipoPubli.SelectedValue = PublicacionExistente.tipo_publi.cod_tipo_publi;
                DTFechaInicio.Value = PublicacionExistente.fecha_inicio;
                DTFechaInicio.MinDate = PublicacionExistente.fecha_inicio;
                DTFechaVencimiento.Value = PublicacionExistente.fecha_vencimiento;
                DTFechaVencimiento.MinDate = PublicacionExistente.fecha_vencimiento;
                numStock.Value = PublicacionExistente.stock;
                numPrecio.Value = PublicacionExistente.precio_producto;
                cmbBoxVisibilidad.SelectedValue = PublicacionExistente.visibilidad.cod_visibilidad;
                cmbBoxEstado.SelectedValue = PublicacionExistente.estado.cod_estado;
                cmbBoxRubro.SelectedValue = PublicacionExistente.rubro.cod_rubro;
                cmbBoxEnvio.SelectedValue = PublicacionExistente.con_envio;
                cmbBoxPreguntas.SelectedValue = PublicacionExistente.con_preguntas;
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private string validarForm()
        {
            if (txtDescripcion.Text == descrVacia || txtDescripcion.Text == String.Empty || txtDescripcion.Text == ".") {
                return "Debe Ingresar una Descripción para la publicación.";
            } else if (cmbBoxTipoPubli.SelectedIndex == -1)
                {
                return "Debe seleccionar un tipo de publicación";
            } else if (numStock.Value <= 1)
                {
                return "Stock debe ser mayor a 1 (uno)";
            } else if (numPrecio.Value <= 0)
                {
                return "El Precio debe ser mayor a 0 (cero)";
            } else if (cmbBoxVisibilidad.SelectedIndex == -1)
                {
                return "Debe seleccionar una Visibilidad";
            } else if (cmbBoxEstado.SelectedIndex == -1)
                {
                return "Debe seleccionar un Estado";
            } else if (cmbBoxRubro.SelectedIndex == -1)
                {
                return "Debe seleccionar un Rubro";
            } else if (DTFechaInicio.Value >= DTFechaVencimiento.Value)
                {
                return "La fecha de inicio no puede superar a la fecha de vencimiento";
            } else if (DTFechaVencimiento.Value <= DTFechaInicio.Value)
                {
                return "La fecha de vencimiento no puede superar a la fecha de inicio";
            } else if (cmbBoxEnvio.SelectedIndex == -1)
                {
                return "Debe indicar si incluye Envío";
            } else if (cmbBoxPreguntas.SelectedIndex == -1)
                {
                return "Debe indicar si se pueden hacer preguntas";
            } else
                return String.Empty;
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            string descrError = String.Empty;

            if (esNuevaPubli || esModificable)
            {
                descrError = this.validarForm();

                if (descrError != String.Empty)
                {
                    Publicacion nuevaPublicacion = PublicacionHandler.Guardar(
                        txtDescripcion.Text, numStock.Value, DTFechaInicio.Value, DTFechaVencimiento.Value, numPrecio.Value,
                        decimal.Parse(cmbBoxVisibilidad.SelectedValue.ToString()), decimal.Parse(cmbBoxEstado.SelectedValue.ToString()),
                        decimal.Parse(cmbBoxRubro.SelectedValue.ToString()), UserLogged.cod_usuario, decimal.Parse(cmbBoxTipoPubli.SelectedValue.ToString()),
                        bool.Parse(cmbBoxEnvio.SelectedValue.ToString()), bool.Parse(cmbBoxPreguntas.SelectedValue.ToString())
                    );

                    PublicacionForm muestraDeNuevaPubli = new PublicacionForm(nuevaPublicacion, TipoAccion.View);

                    muestraDeNuevaPubli.Show();

                    this.Close();
                } else {
                    MessageBox.Show(descrError, "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            } else if (esCompra) {
                if (PublicacionExistente.stock > 0) {
                    // PARA CONTROLAR QUE NO TENGA MAS DE 3 COMPRAS SIN CALIFICACIONES.
                    List<Compra> comprasSinCalificar = CompraHandler.ListarComprasSinCalificar(UserLogged.cod_usuario);

                    if (comprasSinCalificar != null && comprasSinCalificar.Count <= 3)
                    {
                        ComprarForm formDeCompra = new ComprarForm(PublicacionExistente.tipo_publi.cod_tipo_publi == 1 /* Compra Inmediata */, PublicacionExistente.stock);

                        formDeCompra.ShowDialog(this); // Ver como recuperar el valor que setea en ese form.

                        Factura factura = PublicacionHandler.Comprar(PublicacionExistente.cod_publi, 2);

                        FacturaForm formFactura = new FacturaForm(factura);
                        
                    } else {
                        string msjErrorCalif = "Usted tiene " + comprasSinCalificar.Count.ToString() + " compras pendientes de calificación.\n" +
                                               "No podrá comprar/ofertar con 3 o más calificaciones pendientes.";
                        MessageBox.Show(msjErrorCalif, "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);

                        Home home = (Home)this.Owner; // Setea el Formulario Home en una variable.
                        
                        home.cargarPanel(new CalificarControl()); // llama al método del form Home y hace que se cargue en el panel del Home el User Control de Calificar.

                        this.Close();
                    }
                } else {
                    MessageBox.Show("No puede Comprar/Ofertar, No hay Stock disponible.", "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

            }

            if (PublicacionExistente.estado.cod_estado == 1 /* Publicada */ ||
                PublicacionExistente.estado.cod_estado == 3 /* Activa */  && !esView)
            {
                // Mostrar la factura por pantalla.

                //Factura nuevaFactura = FacturaHandler.nuevaFactura()
                //FacturaForm muestraDeFactura = new FacturaForm(nuevaFactura);

                //muestraDeFactura.Show();


                this.Close();
            }


        }

        private void txtDescripcion_Enter(object sender, EventArgs e)
        {
            txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowText;

            if (txtDescripcion.Text == descrVacia) {
                txtDescripcion.Text = String.Empty;
            }
        }

        private void txtDescripcion_Leave(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == String.Empty || txtDescripcion.Text == descrVacia) {
                txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
                txtDescripcion.Text = descrVacia;
            }
        }

        private void cmbBoxTipoPubli_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (esNuevaPubli) {
                if (((TipoPublicacion)cmbBoxTipoPubli.SelectedItem).cod_tipo_publi == 2 /* Subasta */) {
                    numStock.Value = 1;
                    numStock.Enabled = false;
                } else {
                    numStock.Enabled = true;
                }
            }
        }

        private void cmbBoxVisibilidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (esNuevaPubli || esModificable) {
                if (((Visibilidad)cmbBoxVisibilidad.SelectedItem).cod_visibilidad == 10006 /* Gratis */) {
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
            if (esNuevaPubli || esModificable) {
                btnGuardar.Text = ((Estado)cmbBoxEstado.SelectedItem).cod_estado == 3 /* "Activa" */ ? "Publicar" : "Guardar";
            }

        }
    }
}
