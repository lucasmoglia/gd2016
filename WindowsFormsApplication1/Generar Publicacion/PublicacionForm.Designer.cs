namespace ME.UI
{
    partial class PublicacionForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblVisibilidad = new System.Windows.Forms.Label();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.cmbBoxVisibilidad = new System.Windows.Forms.ComboBox();
            this.groupMonto = new System.Windows.Forms.GroupBox();
            this.numStock = new System.Windows.Forms.NumericUpDown();
            this.numPrecio = new System.Windows.Forms.NumericUpDown();
            this.lblStock = new System.Windows.Forms.Label();
            this.lblPrecio = new System.Windows.Forms.Label();
            this.lblFechaVencimiento = new System.Windows.Forms.Label();
            this.DTFechaVencimiento = new System.Windows.Forms.DateTimePicker();
            this.label21 = new System.Windows.Forms.Label();
            this.DTFechaInicio = new System.Windows.Forms.DateTimePicker();
            this.lblDescripción = new System.Windows.Forms.Label();
            this.txtDescripcion = new System.Windows.Forms.TextBox();
            this.groupCaracteristicas = new System.Windows.Forms.GroupBox();
            this.cmbBoxPreguntas = new System.Windows.Forms.ComboBox();
            this.cmbBoxEnvio = new System.Windows.Forms.ComboBox();
            this.lblPreguntas = new System.Windows.Forms.Label();
            this.lblEnvio = new System.Windows.Forms.Label();
            this.lblRubro = new System.Windows.Forms.Label();
            this.cmbBoxRubro = new System.Windows.Forms.ComboBox();
            this.lblEstado = new System.Windows.Forms.Label();
            this.cmbBoxEstado = new System.Windows.Forms.ComboBox();
            this.lblItemPubli = new System.Windows.Forms.Label();
            this.cmbBoxTipoPubli = new System.Windows.Forms.ComboBox();
            this.pnlPublicacion = new System.Windows.Forms.Panel();
            this.groupPropietario = new System.Windows.Forms.GroupBox();
            this.lblUsername = new System.Windows.Forms.Label();
            this.lblIdUsuario = new System.Windows.Forms.Label();
            this.groupTipoPublicacion = new System.Windows.Forms.GroupBox();
            this.groupVigencia = new System.Windows.Forms.GroupBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblFinalizada = new System.Windows.Forms.Label();
            this.groupMonto.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).BeginInit();
            this.groupCaracteristicas.SuspendLayout();
            this.pnlPublicacion.SuspendLayout();
            this.groupPropietario.SuspendLayout();
            this.groupTipoPublicacion.SuspendLayout();
            this.groupVigencia.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblVisibilidad
            // 
            this.lblVisibilidad.AutoSize = true;
            this.lblVisibilidad.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblVisibilidad.Location = new System.Drawing.Point(12, 17);
            this.lblVisibilidad.Name = "lblVisibilidad";
            this.lblVisibilidad.Size = new System.Drawing.Size(53, 13);
            this.lblVisibilidad.TabIndex = 1;
            this.lblVisibilidad.Text = "Visibilidad";
            // 
            // btnGuardar
            // 
            this.btnGuardar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGuardar.Location = new System.Drawing.Point(638, 372);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(75, 23);
            this.btnGuardar.TabIndex = 30;
            this.btnGuardar.Text = "Guardar";
            this.btnGuardar.UseVisualStyleBackColor = true;
            this.btnGuardar.Click += new System.EventHandler(this.btnGuardar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.Location = new System.Drawing.Point(550, 372);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(75, 23);
            this.btnCancelar.TabIndex = 31;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // cmbBoxVisibilidad
            // 
            this.cmbBoxVisibilidad.FormattingEnabled = true;
            this.cmbBoxVisibilidad.Location = new System.Drawing.Point(15, 33);
            this.cmbBoxVisibilidad.Name = "cmbBoxVisibilidad";
            this.cmbBoxVisibilidad.Size = new System.Drawing.Size(139, 21);
            this.cmbBoxVisibilidad.TabIndex = 0;
            this.cmbBoxVisibilidad.SelectedIndexChanged += new System.EventHandler(this.cmbBoxVisibilidad_SelectedIndexChanged);
            // 
            // groupMonto
            // 
            this.groupMonto.Controls.Add(this.numStock);
            this.groupMonto.Controls.Add(this.numPrecio);
            this.groupMonto.Controls.Add(this.lblStock);
            this.groupMonto.Controls.Add(this.lblPrecio);
            this.groupMonto.Location = new System.Drawing.Point(352, 7);
            this.groupMonto.Name = "groupMonto";
            this.groupMonto.Size = new System.Drawing.Size(302, 55);
            this.groupMonto.TabIndex = 20;
            this.groupMonto.TabStop = false;
            this.groupMonto.Text = "Monto y Stock";
            // 
            // numStock
            // 
            this.numStock.Location = new System.Drawing.Point(16, 30);
            this.numStock.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.numStock.Name = "numStock";
            this.numStock.Size = new System.Drawing.Size(109, 20);
            this.numStock.TabIndex = 19;
            this.numStock.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // numPrecio
            // 
            this.numPrecio.DecimalPlaces = 2;
            this.numPrecio.Location = new System.Drawing.Point(163, 30);
            this.numPrecio.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.numPrecio.Name = "numPrecio";
            this.numPrecio.Size = new System.Drawing.Size(120, 20);
            this.numPrecio.TabIndex = 18;
            // 
            // lblStock
            // 
            this.lblStock.AutoSize = true;
            this.lblStock.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblStock.Location = new System.Drawing.Point(16, 14);
            this.lblStock.Name = "lblStock";
            this.lblStock.Size = new System.Drawing.Size(35, 13);
            this.lblStock.TabIndex = 10;
            this.lblStock.Text = "Stock";
            // 
            // lblPrecio
            // 
            this.lblPrecio.AutoSize = true;
            this.lblPrecio.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPrecio.Location = new System.Drawing.Point(160, 15);
            this.lblPrecio.Name = "lblPrecio";
            this.lblPrecio.Size = new System.Drawing.Size(37, 13);
            this.lblPrecio.TabIndex = 8;
            this.lblPrecio.Text = "Precio";
            // 
            // lblFechaVencimiento
            // 
            this.lblFechaVencimiento.AutoSize = true;
            this.lblFechaVencimiento.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFechaVencimiento.Location = new System.Drawing.Point(23, 69);
            this.lblFechaVencimiento.Name = "lblFechaVencimiento";
            this.lblFechaVencimiento.Size = new System.Drawing.Size(113, 13);
            this.lblFechaVencimiento.TabIndex = 17;
            this.lblFechaVencimiento.Text = "Fecha de Vencimiento";
            // 
            // DTFechaVencimiento
            // 
            this.DTFechaVencimiento.Location = new System.Drawing.Point(23, 85);
            this.DTFechaVencimiento.Name = "DTFechaVencimiento";
            this.DTFechaVencimiento.Size = new System.Drawing.Size(236, 20);
            this.DTFechaVencimiento.TabIndex = 16;
            this.DTFechaVencimiento.Value = new System.DateTime(2016, 6, 6, 3, 16, 27, 0);
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label21.Location = new System.Drawing.Point(23, 29);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(80, 13);
            this.label21.TabIndex = 15;
            this.label21.Text = "Fecha de Inicio";
            // 
            // DTFechaInicio
            // 
            this.DTFechaInicio.Location = new System.Drawing.Point(23, 45);
            this.DTFechaInicio.Name = "DTFechaInicio";
            this.DTFechaInicio.Size = new System.Drawing.Size(236, 20);
            this.DTFechaInicio.TabIndex = 14;
            this.DTFechaInicio.Value = new System.DateTime(2016, 6, 6, 3, 16, 27, 0);
            this.DTFechaInicio.ValueChanged += new System.EventHandler(this.DTFechaInicio_ValueChanged);
            // 
            // lblDescripción
            // 
            this.lblDescripción.AutoSize = true;
            this.lblDescripción.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDescripción.Location = new System.Drawing.Point(6, 16);
            this.lblDescripción.Name = "lblDescripción";
            this.lblDescripción.Size = new System.Drawing.Size(135, 13);
            this.lblDescripción.TabIndex = 2;
            this.lblDescripción.Text = "Descripción de publicación";
            this.lblDescripción.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // txtDescripcion
            // 
            this.txtDescripcion.Location = new System.Drawing.Point(9, 32);
            this.txtDescripcion.Multiline = true;
            this.txtDescripcion.Name = "txtDescripcion";
            this.txtDescripcion.Size = new System.Drawing.Size(666, 60);
            this.txtDescripcion.TabIndex = 3;
            this.txtDescripcion.Enter += new System.EventHandler(this.txtDescripcion_Enter);
            this.txtDescripcion.Leave += new System.EventHandler(this.txtDescripcion_Leave);
            // 
            // groupCaracteristicas
            // 
            this.groupCaracteristicas.Controls.Add(this.lblFinalizada);
            this.groupCaracteristicas.Controls.Add(this.cmbBoxPreguntas);
            this.groupCaracteristicas.Controls.Add(this.cmbBoxEnvio);
            this.groupCaracteristicas.Controls.Add(this.lblPreguntas);
            this.groupCaracteristicas.Controls.Add(this.lblEnvio);
            this.groupCaracteristicas.Controls.Add(this.lblRubro);
            this.groupCaracteristicas.Controls.Add(this.cmbBoxRubro);
            this.groupCaracteristicas.Controls.Add(this.lblEstado);
            this.groupCaracteristicas.Controls.Add(this.cmbBoxEstado);
            this.groupCaracteristicas.Controls.Add(this.lblVisibilidad);
            this.groupCaracteristicas.Controls.Add(this.cmbBoxVisibilidad);
            this.groupCaracteristicas.Location = new System.Drawing.Point(352, 68);
            this.groupCaracteristicas.Name = "groupCaracteristicas";
            this.groupCaracteristicas.Size = new System.Drawing.Size(342, 156);
            this.groupCaracteristicas.TabIndex = 21;
            this.groupCaracteristicas.TabStop = false;
            this.groupCaracteristicas.Text = "Características";
            // 
            // cmbBoxPreguntas
            // 
            this.cmbBoxPreguntas.FormattingEnabled = true;
            this.cmbBoxPreguntas.Location = new System.Drawing.Point(179, 124);
            this.cmbBoxPreguntas.Name = "cmbBoxPreguntas";
            this.cmbBoxPreguntas.Size = new System.Drawing.Size(71, 21);
            this.cmbBoxPreguntas.TabIndex = 37;
            // 
            // cmbBoxEnvio
            // 
            this.cmbBoxEnvio.FormattingEnabled = true;
            this.cmbBoxEnvio.Location = new System.Drawing.Point(52, 124);
            this.cmbBoxEnvio.Name = "cmbBoxEnvio";
            this.cmbBoxEnvio.Size = new System.Drawing.Size(71, 21);
            this.cmbBoxEnvio.TabIndex = 36;
            // 
            // lblPreguntas
            // 
            this.lblPreguntas.AutoSize = true;
            this.lblPreguntas.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPreguntas.Location = new System.Drawing.Point(176, 108);
            this.lblPreguntas.Name = "lblPreguntas";
            this.lblPreguntas.Size = new System.Drawing.Size(92, 13);
            this.lblPreguntas.TabIndex = 35;
            this.lblPreguntas.Text = "Permitir Preguntas";
            // 
            // lblEnvio
            // 
            this.lblEnvio.AutoSize = true;
            this.lblEnvio.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEnvio.Location = new System.Drawing.Point(49, 108);
            this.lblEnvio.Name = "lblEnvio";
            this.lblEnvio.Size = new System.Drawing.Size(67, 13);
            this.lblEnvio.TabIndex = 34;
            this.lblEnvio.Text = "Incluir Envío";
            // 
            // lblRubro
            // 
            this.lblRubro.AutoSize = true;
            this.lblRubro.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblRubro.Location = new System.Drawing.Point(12, 59);
            this.lblRubro.Name = "lblRubro";
            this.lblRubro.Size = new System.Drawing.Size(36, 13);
            this.lblRubro.TabIndex = 33;
            this.lblRubro.Text = "Rubro";
            // 
            // cmbBoxRubro
            // 
            this.cmbBoxRubro.FormattingEnabled = true;
            this.cmbBoxRubro.Location = new System.Drawing.Point(15, 75);
            this.cmbBoxRubro.Name = "cmbBoxRubro";
            this.cmbBoxRubro.Size = new System.Drawing.Size(316, 21);
            this.cmbBoxRubro.TabIndex = 32;
            // 
            // lblEstado
            // 
            this.lblEstado.AutoSize = true;
            this.lblEstado.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEstado.Location = new System.Drawing.Point(188, 17);
            this.lblEstado.Name = "lblEstado";
            this.lblEstado.Size = new System.Drawing.Size(40, 13);
            this.lblEstado.TabIndex = 31;
            this.lblEstado.Text = "Estado";
            // 
            // cmbBoxEstado
            // 
            this.cmbBoxEstado.FormattingEnabled = true;
            this.cmbBoxEstado.Location = new System.Drawing.Point(191, 33);
            this.cmbBoxEstado.Name = "cmbBoxEstado";
            this.cmbBoxEstado.Size = new System.Drawing.Size(122, 21);
            this.cmbBoxEstado.TabIndex = 30;
            this.cmbBoxEstado.SelectedIndexChanged += new System.EventHandler(this.cmbBoxEstado_SelectedIndexChanged);
            // 
            // lblItemPubli
            // 
            this.lblItemPubli.AutoSize = true;
            this.lblItemPubli.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblItemPubli.Location = new System.Drawing.Point(12, 25);
            this.lblItemPubli.Name = "lblItemPubli";
            this.lblItemPubli.Size = new System.Drawing.Size(100, 13);
            this.lblItemPubli.TabIndex = 35;
            this.lblItemPubli.Text = "Tipo de publicación";
            // 
            // cmbBoxTipoPubli
            // 
            this.cmbBoxTipoPubli.FormattingEnabled = true;
            this.cmbBoxTipoPubli.Location = new System.Drawing.Point(15, 41);
            this.cmbBoxTipoPubli.Name = "cmbBoxTipoPubli";
            this.cmbBoxTipoPubli.Size = new System.Drawing.Size(125, 21);
            this.cmbBoxTipoPubli.TabIndex = 34;
            this.cmbBoxTipoPubli.SelectedIndexChanged += new System.EventHandler(this.cmbBoxTipoPubli_SelectedIndexChanged);
            // 
            // pnlPublicacion
            // 
            this.pnlPublicacion.Controls.Add(this.groupPropietario);
            this.pnlPublicacion.Controls.Add(this.groupTipoPublicacion);
            this.pnlPublicacion.Controls.Add(this.groupVigencia);
            this.pnlPublicacion.Controls.Add(this.groupCaracteristicas);
            this.pnlPublicacion.Controls.Add(this.groupMonto);
            this.pnlPublicacion.Location = new System.Drawing.Point(30, 127);
            this.pnlPublicacion.Name = "pnlPublicacion";
            this.pnlPublicacion.Size = new System.Drawing.Size(703, 239);
            this.pnlPublicacion.TabIndex = 18;
            // 
            // groupPropietario
            // 
            this.groupPropietario.Controls.Add(this.lblUsername);
            this.groupPropietario.Controls.Add(this.lblIdUsuario);
            this.groupPropietario.Location = new System.Drawing.Point(172, 7);
            this.groupPropietario.Name = "groupPropietario";
            this.groupPropietario.Size = new System.Drawing.Size(146, 85);
            this.groupPropietario.TabIndex = 24;
            this.groupPropietario.TabStop = false;
            this.groupPropietario.Text = "Propietario";
            // 
            // lblUsername
            // 
            this.lblUsername.AutoSize = true;
            this.lblUsername.Enabled = false;
            this.lblUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUsername.Location = new System.Drawing.Point(6, 49);
            this.lblUsername.Name = "lblUsername";
            this.lblUsername.Size = new System.Drawing.Size(0, 13);
            this.lblUsername.TabIndex = 36;
            // 
            // lblIdUsuario
            // 
            this.lblIdUsuario.AutoSize = true;
            this.lblIdUsuario.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIdUsuario.Location = new System.Drawing.Point(6, 25);
            this.lblIdUsuario.Name = "lblIdUsuario";
            this.lblIdUsuario.Size = new System.Drawing.Size(61, 13);
            this.lblIdUsuario.TabIndex = 35;
            this.lblIdUsuario.Text = "Id. Usuario:";
            // 
            // groupTipoPublicacion
            // 
            this.groupTipoPublicacion.Controls.Add(this.lblItemPubli);
            this.groupTipoPublicacion.Controls.Add(this.cmbBoxTipoPubli);
            this.groupTipoPublicacion.Location = new System.Drawing.Point(9, 7);
            this.groupTipoPublicacion.Name = "groupTipoPublicacion";
            this.groupTipoPublicacion.Size = new System.Drawing.Size(155, 85);
            this.groupTipoPublicacion.TabIndex = 23;
            this.groupTipoPublicacion.TabStop = false;
            this.groupTipoPublicacion.Text = "Tipo";
            // 
            // groupVigencia
            // 
            this.groupVigencia.Controls.Add(this.DTFechaInicio);
            this.groupVigencia.Controls.Add(this.label21);
            this.groupVigencia.Controls.Add(this.lblFechaVencimiento);
            this.groupVigencia.Controls.Add(this.DTFechaVencimiento);
            this.groupVigencia.Location = new System.Drawing.Point(9, 102);
            this.groupVigencia.Name = "groupVigencia";
            this.groupVigencia.Size = new System.Drawing.Size(309, 122);
            this.groupVigencia.TabIndex = 22;
            this.groupVigencia.TabStop = false;
            this.groupVigencia.Text = "Vigencia";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.lblDescripción);
            this.groupBox1.Controls.Add(this.txtDescripcion);
            this.groupBox1.Location = new System.Drawing.Point(38, 19);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(687, 102);
            this.groupBox1.TabIndex = 32;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Publicación";
            // 
            // lblFinalizada
            // 
            this.lblFinalizada.AutoSize = true;
            this.lblFinalizada.Enabled = false;
            this.lblFinalizada.Location = new System.Drawing.Point(191, 58);
            this.lblFinalizada.Name = "lblFinalizada";
            this.lblFinalizada.Size = new System.Drawing.Size(57, 13);
            this.lblFinalizada.TabIndex = 38;
            this.lblFinalizada.Text = "Finalizada:";
            this.lblFinalizada.Visible = false;
            // 
            // PublicacionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancelar;
            this.ClientSize = new System.Drawing.Size(767, 407);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.pnlPublicacion);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnGuardar);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "PublicacionForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Nueva Publicación";
            this.Load += new System.EventHandler(this.PublicacionForm_Load);
            this.groupMonto.ResumeLayout(false);
            this.groupMonto.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).EndInit();
            this.groupCaracteristicas.ResumeLayout(false);
            this.groupCaracteristicas.PerformLayout();
            this.pnlPublicacion.ResumeLayout(false);
            this.groupPropietario.ResumeLayout(false);
            this.groupPropietario.PerformLayout();
            this.groupTipoPublicacion.ResumeLayout(false);
            this.groupTipoPublicacion.PerformLayout();
            this.groupVigencia.ResumeLayout(false);
            this.groupVigencia.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblVisibilidad;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.ComboBox cmbBoxVisibilidad;
        private System.Windows.Forms.GroupBox groupMonto;
        private System.Windows.Forms.Label label21;
        private System.Windows.Forms.DateTimePicker DTFechaInicio;
        private System.Windows.Forms.Label lblDescripción;
        private System.Windows.Forms.TextBox txtDescripcion;
        private System.Windows.Forms.Label lblStock;
        private System.Windows.Forms.Label lblPrecio;
        private System.Windows.Forms.GroupBox groupCaracteristicas;
        private System.Windows.Forms.Panel pnlPublicacion;
        private System.Windows.Forms.Label lblFechaVencimiento;
        private System.Windows.Forms.DateTimePicker DTFechaVencimiento;
        private System.Windows.Forms.NumericUpDown numStock;
        private System.Windows.Forms.NumericUpDown numPrecio;
        private System.Windows.Forms.Label lblEstado;
        private System.Windows.Forms.ComboBox cmbBoxEstado;
        private System.Windows.Forms.Label lblRubro;
        private System.Windows.Forms.ComboBox cmbBoxRubro;
        private System.Windows.Forms.Label lblItemPubli;
        private System.Windows.Forms.ComboBox cmbBoxTipoPubli;
        private System.Windows.Forms.GroupBox groupVigencia;
        private System.Windows.Forms.GroupBox groupTipoPublicacion;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ComboBox cmbBoxPreguntas;
        private System.Windows.Forms.ComboBox cmbBoxEnvio;
        private System.Windows.Forms.Label lblPreguntas;
        private System.Windows.Forms.Label lblEnvio;
        private System.Windows.Forms.GroupBox groupPropietario;
        private System.Windows.Forms.Label lblUsername;
        private System.Windows.Forms.Label lblIdUsuario;
        private System.Windows.Forms.Label lblFinalizada;
    }
}