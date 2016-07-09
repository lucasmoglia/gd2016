namespace ME.UI
{
    partial class FacturaUserControl
    {
        /// <summary> 
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de componentes

        /// <summary> 
        /// Método necesario para admitir el Diseñador. No se puede modificar 
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.gvFacturas = new System.Windows.Forms.DataGridView();
            this.DTPFechaHasta = new System.Windows.Forms.DateTimePicker();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.numMontoMin = new System.Windows.Forms.NumericUpDown();
            this.numMontoMax = new System.Windows.Forms.NumericUpDown();
            this.TxtDetalleFactura = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.DTPFechaDesde = new System.Windows.Forms.DateTimePicker();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.btnVerDetalle = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.gvFacturas)).BeginInit();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numMontoMin)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMontoMax)).BeginInit();
            this.SuspendLayout();
            // 
            // gvFacturas
            // 
            this.gvFacturas.AllowUserToAddRows = false;
            this.gvFacturas.AllowUserToDeleteRows = false;
            this.gvFacturas.AllowUserToOrderColumns = true;
            this.gvFacturas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvFacturas.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gvFacturas.Location = new System.Drawing.Point(23, 154);
            this.gvFacturas.Name = "gvFacturas";
            this.gvFacturas.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvFacturas.Size = new System.Drawing.Size(800, 280);
            this.gvFacturas.TabIndex = 1;
            this.gvFacturas.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvFacturas_CellContentClick);
            // 
            // DTPFechaHasta
            // 
            this.DTPFechaHasta.AllowDrop = true;
            this.DTPFechaHasta.Checked = false;
            this.DTPFechaHasta.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DTPFechaHasta.Location = new System.Drawing.Point(14, 70);
            this.DTPFechaHasta.Name = "DTPFechaHasta";
            this.DTPFechaHasta.Size = new System.Drawing.Size(200, 20);
            this.DTPFechaHasta.TabIndex = 3;
            this.DTPFechaHasta.ValueChanged += new System.EventHandler(this.dateTimePicker1_ValueChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.numMontoMin);
            this.groupBox1.Controls.Add(this.numMontoMax);
            this.groupBox1.Controls.Add(this.TxtDetalleFactura);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.DTPFechaDesde);
            this.groupBox1.Controls.Add(this.DTPFechaHasta);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(23, 18);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(746, 100);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Filtros";
            // 
            // numMontoMin
            // 
            this.numMontoMin.DecimalPlaces = 2;
            this.numMontoMin.Location = new System.Drawing.Point(237, 32);
            this.numMontoMin.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.numMontoMin.Name = "numMontoMin";
            this.numMontoMin.Size = new System.Drawing.Size(120, 20);
            this.numMontoMin.TabIndex = 16;
            // 
            // numMontoMax
            // 
            this.numMontoMax.DecimalPlaces = 2;
            this.numMontoMax.Location = new System.Drawing.Point(237, 70);
            this.numMontoMax.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.numMontoMax.Name = "numMontoMax";
            this.numMontoMax.Size = new System.Drawing.Size(120, 20);
            this.numMontoMax.TabIndex = 15;
            // 
            // TxtDetalleFactura
            // 
            this.TxtDetalleFactura.Location = new System.Drawing.Point(439, 35);
            this.TxtDetalleFactura.Name = "TxtDetalleFactura";
            this.TxtDetalleFactura.Size = new System.Drawing.Size(261, 20);
            this.TxtDetalleFactura.TabIndex = 14;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(436, 16);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(127, 13);
            this.label3.TabIndex = 13;
            this.label3.Text = "Detalle de la factura:";
            // 
            // label
            // 
            this.label.AutoSize = true;
            this.label.Location = new System.Drawing.Point(234, 55);
            this.label.Name = "label";
            this.label.Size = new System.Drawing.Size(92, 13);
            this.label.TabIndex = 10;
            this.label.Text = "Monto Maximo:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(234, 16);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(89, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "Monto Minimo:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 55);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(83, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Fecha Hasta:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(84, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Fecha desde:";
            // 
            // DTPFechaDesde
            // 
            this.DTPFechaDesde.AllowDrop = true;
            this.DTPFechaDesde.Checked = false;
            this.DTPFechaDesde.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DTPFechaDesde.Location = new System.Drawing.Point(15, 32);
            this.DTPFechaDesde.Name = "DTPFechaDesde";
            this.DTPFechaDesde.Size = new System.Drawing.Size(200, 20);
            this.DTPFechaDesde.TabIndex = 4;
            // 
            // btnLimpiar
            // 
            this.btnLimpiar.BackColor = System.Drawing.Color.LimeGreen;
            this.btnLimpiar.Location = new System.Drawing.Point(136, 125);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(75, 23);
            this.btnLimpiar.TabIndex = 5;
            this.btnLimpiar.Text = "Limpiar";
            this.btnLimpiar.UseVisualStyleBackColor = false;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            // 
            // btnBuscar
            // 
            this.btnBuscar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBuscar.Location = new System.Drawing.Point(37, 125);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(93, 23);
            this.btnBuscar.TabIndex = 6;
            this.btnBuscar.Text = "Buscar";
            this.btnBuscar.UseVisualStyleBackColor = true;
            this.btnBuscar.Click += new System.EventHandler(this.btnBuscar_Click);
            // 
            // btnVerDetalle
            // 
            this.btnVerDetalle.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnVerDetalle.Location = new System.Drawing.Point(730, 125);
            this.btnVerDetalle.Name = "btnVerDetalle";
            this.btnVerDetalle.Size = new System.Drawing.Size(93, 23);
            this.btnVerDetalle.TabIndex = 7;
            this.btnVerDetalle.Text = "Ver Detalle";
            this.btnVerDetalle.UseVisualStyleBackColor = true;
            this.btnVerDetalle.Click += new System.EventHandler(this.btnVerDetalle_Click);
            // 
            // FacturaUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnVerDetalle);
            this.Controls.Add(this.btnBuscar);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.gvFacturas);
            this.Name = "FacturaUserControl";
            this.Size = new System.Drawing.Size(838, 437);
            this.Load += new System.EventHandler(this.FacturaUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvFacturas)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numMontoMin)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMontoMax)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView gvFacturas;
        private System.Windows.Forms.DateTimePicker DTPFechaHasta;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker DTPFechaDesde;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.TextBox TxtDetalleFactura;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.NumericUpDown numMontoMin;
        private System.Windows.Forms.NumericUpDown numMontoMax;
        private System.Windows.Forms.Button btnVerDetalle;
    }
}
