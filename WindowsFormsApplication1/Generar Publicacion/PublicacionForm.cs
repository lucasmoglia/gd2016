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
        bool esNuevaPubli = false, esModificable = false, esCompra = false, esDirecta = true;
        Publicacion PublicacionExistente = null;
        private string descrVacia = "Ingrese aquí la descripción";
        List<Estado> estados = null;
        DateTime fechaConfig = DateTime.Parse(ConfigurationManager.AppSettings["fecha"].ToString());

        #region publi Members
        public int valor = 0;
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


        private void mostrarErrorTransicionEstados()
        {
            MessageBox.Show("No puede cambiar el estado de " + PublicacionExistente.estado.nombre + " a " +
                                                              ((Estado)cmbBoxEstado.SelectedItem).nombre,
                            "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Error);

            cmbBoxEstado.SelectedItem = PublicacionExistente.estado;
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
                DTFechaInicio.Value = fechaConfig;
                DTFechaInicio.MinDate = fechaConfig; 
                DTFechaVencimiento.Value = fechaConfig;
                DTFechaVencimiento.MinDate = fechaConfig;
                numStock.Value = 1;
                numStock.Minimum = 1;
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

                        if (publicacion.estado.cod_estado == 4 /* Pausada */ ||
                            publicacion.estado.cod_estado == 3 /* Activa */)
                        {
                            habilitarTodo(false);

                            cmbBoxEstado.Enabled = true;

                            btnGuardar.Enabled = true;
                            btnGuardar.Visible = true;
                        }
                        else {
                            habilitarTodo(true);

                            btnGuardar.Enabled = true;
                            btnGuardar.Visible = true;
                        }
                    break;

                    case TipoAccion.Buy:
                        this.Text = (publicacion.tipo_publi.cod_tipo_publi == 1 /* Compra Inmediata */? "Comprar" : "Ofertar") + " Publicación " + publicacion.cod_publi.ToString();
                        this.esCompra = true;
                        btnCancelar.Text = "Cancelar";
                        btnGuardar.Text = (publicacion.tipo_publi.cod_tipo_publi == 1 /* Compra Inmediata */? "Comprar" : "Ofertar");

                        habilitarTodo(false);

                        if (publicacion.estado.cod_estado == 4 /* Pausada */) {
                            btnGuardar.Enabled = false;
                            btnGuardar.Visible = true;
                        } else {
                            btnGuardar.Enabled = true;
                            btnGuardar.Visible = true;
                        }
                    break;

                    default: // TipoAccion.View: 
                        this.Text = "Publicación " + publicacion.cod_publi.ToString();
                        //this.esView = true;
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

        private void PublicacionForm_Load(object sender, EventArgs e)
        {
//            txtDescripcion.Focus();

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

            estados = EstadoHandler.ListarEstados();
            if (esNuevaPubli) {
                estados.RemoveAll(est => (est.nombre == "Publicada" || est.nombre == "Finalizada"));
            }
            else if (PublicacionExistente.estado.cod_estado == 3 /* Activa */)// esModificable y está Activa
            { 
                     estados.RemoveAll(est => (est.nombre == "Publicada" || est.nombre == "Borrador"));
            }
            else if (PublicacionExistente.estado.cod_estado == 1 /* Publicada */) // esModificable y está Publicada
            {
                estados.RemoveAll(est => (est.nombre == "Borrador"));
            }

            cmbBoxEstado.DataSource = estados;
            cmbBoxEstado.ValueMember = "cod_estado";
            cmbBoxEstado.DisplayMember = "nombre";
            cmbBoxEstado.SelectedItem = estados[0];

            VoF si = new VoF(true, "Si");
            VoF no = new VoF(false, "No");

            List<VoF> si_No_Envio = new List<VoF>();
            si_No_Envio.Add(si); si_No_Envio.Add(no);
            
            List<VoF> si_No_Preg = new List<VoF>();
            si_No_Preg.Add(si); si_No_Preg.Add(no);

            cmbBoxEnvio.DataSource = si_No_Envio;
            cmbBoxEnvio.ValueMember = "cod_valor";
            cmbBoxEnvio.DisplayMember = "valor";

            cmbBoxPreguntas.DataSource = si_No_Preg;
            cmbBoxPreguntas.ValueMember = "cod_valor";
            cmbBoxPreguntas.DisplayMember = "valor";

            if (esNuevaPubli) {
                cmbBoxEnvio.SelectedValue = false;
                cmbBoxPreguntas.SelectedValue = false;
                cmbBoxEstado.SelectedItem = estados.Find(est => est.nombre == "Borrador");
                lblReputacion.Text = String.Empty;
            } else { // es Modificacion o Compra/Oferta
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

                if (PublicacionExistente.estado.cod_estado == 5 /* Finalizada */) {
                    lblFinalizada.Text = "Finalizada: " + PublicacionExistente.fecha_finalizacion.ToString();
                    lblFinalizada.Visible = true;
                } else {
                    lblFinalizada.Text = String.Empty;
                    lblFinalizada.Visible = false;
                }

                cmbBoxRubro.SelectedValue = PublicacionExistente.rubro.cod_rubro;
                cmbBoxEnvio.SelectedValue = PublicacionExistente.con_envio;
                cmbBoxPreguntas.SelectedValue = PublicacionExistente.con_preguntas;
                lblReputacion.Text = PublicacionExistente.reputacion.ToString();
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
            } else if (numStock.Value < 1)
                {
                return "Stock debe ser mayor a 0 (cero)";
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
            } else if (DTFechaInicio.Value > DTFechaVencimiento.Value)
                {
                return "La fecha de inicio no puede superar a la fecha de vencimiento";
            } else if (DTFechaVencimiento.Value < DTFechaInicio.Value)
                {
                return "La fecha de vencimiento no puede ser anterior a la fecha de inicio";
            } else if (cmbBoxEnvio.SelectedIndex == -1)
                {
                return "Debe indicar si incluye Envío";
            } else if (cmbBoxPreguntas.SelectedIndex == -1)
                {
                return "Debe indicar si se pueden hacer preguntas";
            } else
                return String.Empty;
        }

        private void nuevaOmodificacion()
        {
            string descrError = String.Empty;

            descrError = this.validarForm(); // Se validan los campos del formulario.

            if (descrError == String.Empty) // No hay error en el Form
            {
                decimal codPubli = esNuevaPubli ? 0 : PublicacionExistente.cod_publi;

                Publicacion unaPublicacion = null;

                if (cmbBoxEstado.SelectedItem == estados.Find(est => est.cod_estado == 5 /* Finalizada */))
                { // Si se seteó en estado FINALIZADA hay q enviarle la fecha de finalización.
                    unaPublicacion = PublicacionHandler.Guardar(codPubli, false,
                        txtDescripcion.Text, numStock.Value, DTFechaInicio.Value, DTFechaVencimiento.Value, numPrecio.Value,
                        decimal.Parse(cmbBoxVisibilidad.SelectedValue.ToString()), decimal.Parse(cmbBoxEstado.SelectedValue.ToString()),
                        decimal.Parse(cmbBoxRubro.SelectedValue.ToString()), UserLogged.cod_usuario, decimal.Parse(cmbBoxTipoPubli.SelectedValue.ToString()),
                        bool.Parse(cmbBoxEnvio.SelectedValue.ToString()), bool.Parse(cmbBoxPreguntas.SelectedValue.ToString()), fechaConfig);
                }
                else {// No se finalizó. Puede ser Nueva o Modificación.
                    unaPublicacion = PublicacionHandler.Guardar(codPubli, esNuevaPubli,
                        txtDescripcion.Text, numStock.Value, DTFechaInicio.Value, DTFechaVencimiento.Value, numPrecio.Value,
                        decimal.Parse(cmbBoxVisibilidad.SelectedValue.ToString()), decimal.Parse(cmbBoxEstado.SelectedValue.ToString()),
                        decimal.Parse(cmbBoxRubro.SelectedValue.ToString()), UserLogged.cod_usuario, decimal.Parse(cmbBoxTipoPubli.SelectedValue.ToString()),
                        bool.Parse(cmbBoxEnvio.SelectedValue.ToString()), bool.Parse(cmbBoxPreguntas.SelectedValue.ToString()), null);
                }

                PublicacionForm muestraDeNuevaPubli = new PublicacionForm(unaPublicacion, TipoAccion.View);

                muestraDeNuevaPubli.Show();

                this.Enabled = false;

                // Si se generó una publicación en estado "Activa" y No es Gratuita Hay que facturarla.
                if (unaPublicacion.estado.cod_estado == 3 /* Activa */ &&
                    unaPublicacion.visibilidad.cod_visibilidad != 10006 /* Gratis */)
                {
                    Factura factura = null;
                    try {
                        factura = FacturaHandler.NuevaFactura(unaPublicacion.cod_publi, 0); // Comisión por Publicación
                    } catch {
                        MessageBox.Show("Error al facturar la Nueva Publicación", "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }

                    if (factura != null) {
                        MessageBox.Show("¡Felicidades, Usted ha generado una nueva Publicación!", "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

                        FacturaForm facturaForm = new FacturaForm(factura);

                        facturaForm.ShowDialog(this);

                    } else { // No se facturó.
                        if (esModificable) { // fue reactivada y no habia q facturarla o era un usuario con promocion de 1ra facturación gratuita o hubo error al facturar.
                            MessageBox.Show("Publicación guardada.", "Modificación", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        } else {
                            MessageBox.Show("Error al facturar la Nueva Publicación", "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                } else { // No es una Publicación con estado "Activa".
                    if (unaPublicacion != null) {
                        MessageBox.Show("Publicación guardada.", "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }

                this.Close();

            } else { // Si hay error en el Form.
                MessageBox.Show(descrError, "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void compraOsubasta()
        {
            if (PublicacionExistente.stock > 0 && PublicacionExistente.fecha_vencimiento.Date >= fechaConfig.Date)
            {// Tiene que haber stock y no estar vencida.

                List<Compra> comprasSinCalificar = CompraHandler.ListarComprasSinCalificar(UserLogged.cod_usuario);

                // PARA CONTROLAR QUE NO TENGA MAS DE 3 COMPRAS SIN CALIFICACIONES.
                if (comprasSinCalificar != null && comprasSinCalificar.Count < 3)
                {
                    esDirecta = PublicacionExistente.tipo_publi.cod_tipo_publi == 1; /* Compra Inmediata */
                    ComprarForm formDeCompra = null;

                    if (esDirecta) {
                        formDeCompra = new ComprarForm(true, PublicacionExistente.stock);
                    } else {
                        formDeCompra = new ComprarForm(false, PublicacionExistente.precio_producto);
                    }

                    formDeCompra.ShowDialog(this); // En éste Form setea la variable "valor".

                    if (esDirecta) {
                        if (valor > 0) {
                            Factura factura = null;
                            //  try {
                                factura = PublicacionHandler.Comprar(PublicacionExistente.cod_publi, valor); // Comisión por Venta.
                            /*  } catch {
                                  MessageBox.Show("Error al facturar la Compra", "Comprar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                              }*/

                            if (factura != null)
                            {
                                MessageBox.Show("¡Felicidades, Usted ha realizado una nueva Compra!", "Publicación", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

                                FacturaForm formFactura = new FacturaForm(factura);

                                formFactura.Show();
                            } else {
                                MessageBox.Show("Error al facturar la Compra", "Comprar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            }
                        }
                    }
                    else { // Es Subasta.
                        if (valor > PublicacionExistente.precio_producto) { // Oferta válida
                            try {
                                if (PublicacionHandler.Ofertar(PublicacionExistente.cod_publi, valor) > 0) {
                                    MessageBox.Show("¡Oferta realizada con éxito!", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                                } else {
                                    MessageBox.Show("Error al ofertar sobre la subasta", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                }

                                this.Close();

                            } catch {
                                MessageBox.Show("Error al ofertar sobre la subasta", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            }
                        }
                        else { // Valor es menor o igual al precio actual
                            MessageBox.Show("No puede ofertar menos del valor actual de la subasta", "Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        }
                    }
                }
                else { // Tiene más de 3 compras o subastas sin calificar.
                    string msjErrorCalif = "Usted tiene " + comprasSinCalificar.Count.ToString() + " compras pendientes de calificación.\n" +
                                           "No podrá comprar/ofertar con 3 o más calificaciones pendientes.";
                    MessageBox.Show(msjErrorCalif, "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);

                    Home home = (Home)this.Owner; // Setea el Formulario Home en una variable.

                    home.cargarPanel(new CalificarControl()); // llama al método del form Home y hace que se cargue en el panel del Home el User Control de Calificar.

                    this.Close();
                }
            } else { // No hay stock o está vencida
                string noPuedeComprarDescrip = String.Empty;

                if (PublicacionExistente.stock == 0) {
                    noPuedeComprarDescrip = "No hay Stock disponible.";
                } else {
                    noPuedeComprarDescrip = "La publicación ha .";
                }

                MessageBox.Show("No puede Comprar/Ofertar. " + noPuedeComprarDescrip, "Comprar/Ofertar", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        
        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (esNuevaPubli || esModificable)
            {
                nuevaOmodificacion();
            } 
            else if (esCompra) 
            {
                compraOsubasta();
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
                    cmbBoxEnvio.SelectedValue = false;
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

            if (cmbBoxEstado.SelectedIndex != -1)
            {
                if (esNuevaPubli || esModificable) {
                    btnGuardar.Text = ((Estado)cmbBoxEstado.SelectedItem).cod_estado == 3 /* "Activa" */ ? "Publicar" : "Guardar";
                } else {
                    // Se controlan las transiciones entre los estados de la publicación.
                    string estado = ((Estado)cmbBoxEstado.SelectedItem).cod_estado.ToString();

                    switch (estado)
                    {
                        case "1" /* Publicada */:
                            if (PublicacionExistente.estado.cod_estado == 4 /* Pausada */) {
                                mostrarErrorTransicionEstados();
                            }

                            break;

                        case "2" /* Borrador */:
                            if (PublicacionExistente.estado.cod_estado == 3 /* Activa */    ||
                                PublicacionExistente.estado.cod_estado == 1 /* Publicada */ ||
                                PublicacionExistente.estado.cod_estado == 4 /* Pausada */) {
                                mostrarErrorTransicionEstados();
                            }
                            break;

                        case "3" /* Activa */:
                            if (PublicacionExistente.estado.cod_estado == 5 /* Finalizada */) {
                                mostrarErrorTransicionEstados();
                            }
                            break;

                        case "4" /* Pausada */:
                            if (PublicacionExistente.estado.cod_estado == 4 /* Pausada */) {
                                mostrarErrorTransicionEstados();
                            }
                            break;

                        case "5" /* Finalizada */:
                            if (PublicacionExistente.estado.cod_estado != 3 /* Activa */ &&
                                PublicacionExistente.estado.cod_estado != 1 /* Publicada */) {
                                mostrarErrorTransicionEstados();
                            }
                            break;
                    }
                }
            }
        }
    }
}
