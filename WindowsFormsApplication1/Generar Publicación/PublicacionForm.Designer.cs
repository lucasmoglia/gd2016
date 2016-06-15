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
            this.label1 = new System.Windows.Forms.Label();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.ddlRol = new System.Windows.Forms.ComboBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.label21 = new System.Windows.Forms.Label();
            this.dateTimeFechaInicio = new System.Windows.Forms.DateTimePicker();
            this.txtMailC = new System.Windows.Forms.TextBox();
            this.txtTelefonoC = new System.Windows.Forms.TextBox();
            this.lblDescripción = new System.Windows.Forms.Label();
            this.label23 = new System.Windows.Forms.Label();
            this.txtDescripción = new System.Windows.Forms.TextBox();
            this.label24 = new System.Windows.Forms.Label();
            this.lblStock = new System.Windows.Forms.Label();
            this.txtApellido = new System.Windows.Forms.TextBox();
            this.label26 = new System.Windows.Forms.Label();
            this.lblPrecio = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.txtDirCPC = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.txtDirLocalidadC = new System.Windows.Forms.TextBox();
            this.label16 = new System.Windows.Forms.Label();
            this.txtDirCalleC = new System.Windows.Forms.TextBox();
            this.txtDirDeptoC = new System.Windows.Forms.TextBox();
            this.label17 = new System.Windows.Forms.Label();
            this.label18 = new System.Windows.Forms.Label();
            this.txtDirPisoC = new System.Windows.Forms.TextBox();
            this.txtDirNumeroC = new System.Windows.Forms.TextBox();
            this.label19 = new System.Windows.Forms.Label();
            this.label20 = new System.Windows.Forms.Label();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.label28 = new System.Windows.Forms.Label();
            this.txtUserNameC = new System.Windows.Forms.TextBox();
            this.txtPasswordC = new System.Windows.Forms.TextBox();
            this.label29 = new System.Windows.Forms.Label();
            this.pnlPublicacion = new System.Windows.Forms.Panel();
            this.lblFechaVencimiento = new System.Windows.Forms.Label();
            this.dateTimeFechaVencimiento = new System.Windows.Forms.DateTimePicker();
            this.numPrecio = new System.Windows.Forms.NumericUpDown();
            this.numStock = new System.Windows.Forms.NumericUpDown();
            this.groupBox4.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.pnlPublicacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(110, 7);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(26, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Rol";
            // 
            // btnGuardar
            // 
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
            this.btnCancelar.Location = new System.Drawing.Point(558, 372);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(75, 23);
            this.btnCancelar.TabIndex = 31;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // ddlRol
            // 
            this.ddlRol.FormattingEnabled = true;
            this.ddlRol.Location = new System.Drawing.Point(113, 23);
            this.ddlRol.Name = "ddlRol";
            this.ddlRol.Size = new System.Drawing.Size(207, 21);
            this.ddlRol.TabIndex = 0;
            this.ddlRol.SelectedIndexChanged += new System.EventHandler(this.ddlRol_SelectedIndexChanged);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.numStock);
            this.groupBox4.Controls.Add(this.numPrecio);
            this.groupBox4.Controls.Add(this.lblFechaVencimiento);
            this.groupBox4.Controls.Add(this.dateTimeFechaVencimiento);
            this.groupBox4.Controls.Add(this.label21);
            this.groupBox4.Controls.Add(this.dateTimeFechaInicio);
            this.groupBox4.Controls.Add(this.txtMailC);
            this.groupBox4.Controls.Add(this.txtTelefonoC);
            this.groupBox4.Controls.Add(this.label23);
            this.groupBox4.Controls.Add(this.label24);
            this.groupBox4.Controls.Add(this.lblStock);
            this.groupBox4.Controls.Add(this.txtApellido);
            this.groupBox4.Controls.Add(this.label26);
            this.groupBox4.Controls.Add(this.lblPrecio);
            this.groupBox4.Location = new System.Drawing.Point(25, 7);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(302, 255);
            this.groupBox4.TabIndex = 20;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Datos Personales";
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label21.Location = new System.Drawing.Point(27, 173);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(95, 13);
            this.label21.TabIndex = 15;
            this.label21.Text = "Fecha de Inicio";
            // 
            // dateTimeFechaInicio
            // 
            this.dateTimeFechaInicio.Location = new System.Drawing.Point(27, 189);
            this.dateTimeFechaInicio.Name = "dateTimeFechaInicio";
            this.dateTimeFechaInicio.Size = new System.Drawing.Size(251, 20);
            this.dateTimeFechaInicio.TabIndex = 14;
            this.dateTimeFechaInicio.Value = new System.DateTime(2016, 6, 6, 3, 16, 27, 0);
            // 
            // txtMailC
            // 
            this.txtMailC.Location = new System.Drawing.Point(27, 142);
            this.txtMailC.Name = "txtMailC";
            this.txtMailC.Size = new System.Drawing.Size(121, 20);
            this.txtMailC.TabIndex = 7;
            // 
            // txtTelefonoC
            // 
            this.txtTelefonoC.Location = new System.Drawing.Point(157, 142);
            this.txtTelefonoC.Name = "txtTelefonoC";
            this.txtTelefonoC.Size = new System.Drawing.Size(121, 20);
            this.txtTelefonoC.TabIndex = 13;
            // 
            // lblDescripción
            // 
            this.lblDescripción.AutoSize = true;
            this.lblDescripción.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDescripción.Location = new System.Drawing.Point(35, 9);
            this.lblDescripción.Name = "lblDescripción";
            this.lblDescripción.Size = new System.Drawing.Size(161, 13);
            this.lblDescripción.TabIndex = 2;
            this.lblDescripción.Text = "Descripción de publicación";
            this.lblDescripción.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // label23
            // 
            this.label23.AutoSize = true;
            this.label23.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label23.Location = new System.Drawing.Point(160, 126);
            this.label23.Name = "label23";
            this.label23.Size = new System.Drawing.Size(57, 13);
            this.label23.TabIndex = 12;
            this.label23.Text = "Teléfono";
            // 
            // txtDescripción
            // 
            this.txtDescripción.Location = new System.Drawing.Point(38, 25);
            this.txtDescripción.Multiline = true;
            this.txtDescripción.Name = "txtDescripción";
            this.txtDescripción.Size = new System.Drawing.Size(675, 60);
            this.txtDescripción.TabIndex = 3;
            // 
            // label24
            // 
            this.label24.AutoSize = true;
            this.label24.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label24.Location = new System.Drawing.Point(27, 85);
            this.label24.Name = "label24";
            this.label24.Size = new System.Drawing.Size(52, 13);
            this.label24.TabIndex = 4;
            this.label24.Text = "Apellido";
            // 
            // lblStock
            // 
            this.lblStock.AutoSize = true;
            this.lblStock.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblStock.Location = new System.Drawing.Point(27, 24);
            this.lblStock.Name = "lblStock";
            this.lblStock.Size = new System.Drawing.Size(40, 13);
            this.lblStock.TabIndex = 10;
            this.lblStock.Text = "Stock";
            // 
            // txtApellido
            // 
            this.txtApellido.Location = new System.Drawing.Point(27, 101);
            this.txtApellido.Name = "txtApellido";
            this.txtApellido.Size = new System.Drawing.Size(121, 20);
            this.txtApellido.TabIndex = 5;
            // 
            // label26
            // 
            this.label26.AutoSize = true;
            this.label26.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label26.Location = new System.Drawing.Point(27, 126);
            this.label26.Name = "label26";
            this.label26.Size = new System.Drawing.Size(30, 13);
            this.label26.TabIndex = 6;
            this.label26.Text = "Mail";
            // 
            // lblPrecio
            // 
            this.lblPrecio.AutoSize = true;
            this.lblPrecio.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPrecio.Location = new System.Drawing.Point(154, 25);
            this.lblPrecio.Name = "lblPrecio";
            this.lblPrecio.Size = new System.Drawing.Size(43, 13);
            this.lblPrecio.TabIndex = 8;
            this.lblPrecio.Text = "Precio";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.txtDirCPC);
            this.groupBox3.Controls.Add(this.label15);
            this.groupBox3.Controls.Add(this.txtDirLocalidadC);
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.label16);
            this.groupBox3.Controls.Add(this.ddlRol);
            this.groupBox3.Controls.Add(this.txtDirCalleC);
            this.groupBox3.Controls.Add(this.txtDirDeptoC);
            this.groupBox3.Controls.Add(this.label17);
            this.groupBox3.Controls.Add(this.label18);
            this.groupBox3.Controls.Add(this.txtDirPisoC);
            this.groupBox3.Controls.Add(this.txtDirNumeroC);
            this.groupBox3.Controls.Add(this.label19);
            this.groupBox3.Controls.Add(this.label20);
            this.groupBox3.Location = new System.Drawing.Point(333, 81);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(320, 181);
            this.groupBox3.TabIndex = 21;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Domicilio";
            // 
            // txtDirCPC
            // 
            this.txtDirCPC.Location = new System.Drawing.Point(38, 130);
            this.txtDirCPC.Name = "txtDirCPC";
            this.txtDirCPC.Size = new System.Drawing.Size(121, 20);
            this.txtDirCPC.TabIndex = 27;
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label15.Location = new System.Drawing.Point(38, 114);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(85, 13);
            this.label15.TabIndex = 26;
            this.label15.Text = "Código Postal";
            // 
            // txtDirLocalidadC
            // 
            this.txtDirLocalidadC.Location = new System.Drawing.Point(165, 130);
            this.txtDirLocalidadC.Name = "txtDirLocalidadC";
            this.txtDirLocalidadC.Size = new System.Drawing.Size(121, 20);
            this.txtDirLocalidadC.TabIndex = 29;
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label16.Location = new System.Drawing.Point(38, 31);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(35, 13);
            this.label16.TabIndex = 14;
            this.label16.Text = "Calle";
            // 
            // txtDirCalleC
            // 
            this.txtDirCalleC.Location = new System.Drawing.Point(38, 47);
            this.txtDirCalleC.Name = "txtDirCalleC";
            this.txtDirCalleC.Size = new System.Drawing.Size(248, 20);
            this.txtDirCalleC.TabIndex = 17;
            // 
            // txtDirDeptoC
            // 
            this.txtDirDeptoC.Location = new System.Drawing.Point(165, 89);
            this.txtDirDeptoC.Name = "txtDirDeptoC";
            this.txtDirDeptoC.Size = new System.Drawing.Size(121, 20);
            this.txtDirDeptoC.TabIndex = 20;
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label17.Location = new System.Drawing.Point(103, 73);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(31, 13);
            this.label17.TabIndex = 16;
            this.label17.Text = "Piso";
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label18.Location = new System.Drawing.Point(165, 73);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(41, 13);
            this.label18.TabIndex = 22;
            this.label18.Text = "Depto";
            // 
            // txtDirPisoC
            // 
            this.txtDirPisoC.Location = new System.Drawing.Point(106, 89);
            this.txtDirPisoC.Name = "txtDirPisoC";
            this.txtDirPisoC.Size = new System.Drawing.Size(53, 20);
            this.txtDirPisoC.TabIndex = 19;
            // 
            // txtDirNumeroC
            // 
            this.txtDirNumeroC.Location = new System.Drawing.Point(38, 89);
            this.txtDirNumeroC.Name = "txtDirNumeroC";
            this.txtDirNumeroC.Size = new System.Drawing.Size(50, 20);
            this.txtDirNumeroC.TabIndex = 18;
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.Location = new System.Drawing.Point(165, 114);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(62, 13);
            this.label19.TabIndex = 18;
            this.label19.Text = "Localidad";
            // 
            // label20
            // 
            this.label20.AutoSize = true;
            this.label20.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label20.Location = new System.Drawing.Point(38, 73);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(50, 13);
            this.label20.TabIndex = 20;
            this.label20.Text = "Número";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.label28);
            this.groupBox5.Controls.Add(this.txtUserNameC);
            this.groupBox5.Controls.Add(this.txtPasswordC);
            this.groupBox5.Controls.Add(this.label29);
            this.groupBox5.Location = new System.Drawing.Point(334, 8);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(319, 69);
            this.groupBox5.TabIndex = 22;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Datos de la cuenta";
            // 
            // label28
            // 
            this.label28.AutoSize = true;
            this.label28.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label28.Location = new System.Drawing.Point(34, 16);
            this.label28.Name = "label28";
            this.label28.Size = new System.Drawing.Size(50, 13);
            this.label28.TabIndex = 10;
            this.label28.Text = "Usuario";
            // 
            // txtUserNameC
            // 
            this.txtUserNameC.Location = new System.Drawing.Point(34, 32);
            this.txtUserNameC.Name = "txtUserNameC";
            this.txtUserNameC.Size = new System.Drawing.Size(121, 20);
            this.txtUserNameC.TabIndex = 15;
            // 
            // txtPasswordC
            // 
            this.txtPasswordC.Location = new System.Drawing.Point(164, 32);
            this.txtPasswordC.Name = "txtPasswordC";
            this.txtPasswordC.Size = new System.Drawing.Size(121, 20);
            this.txtPasswordC.TabIndex = 16;
            this.txtPasswordC.UseSystemPasswordChar = true;
            // 
            // label29
            // 
            this.label29.AutoSize = true;
            this.label29.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label29.Location = new System.Drawing.Point(161, 16);
            this.label29.Name = "label29";
            this.label29.Size = new System.Drawing.Size(71, 13);
            this.label29.TabIndex = 12;
            this.label29.Text = "Contraseña";
            // 
            // pnlPublicacion
            // 
            this.pnlPublicacion.Controls.Add(this.groupBox5);
            this.pnlPublicacion.Controls.Add(this.groupBox3);
            this.pnlPublicacion.Controls.Add(this.groupBox4);
            this.pnlPublicacion.Location = new System.Drawing.Point(38, 91);
            this.pnlPublicacion.Name = "pnlPublicacion";
            this.pnlPublicacion.Size = new System.Drawing.Size(675, 275);
            this.pnlPublicacion.TabIndex = 18;
            // 
            // lblFechaVencimiento
            // 
            this.lblFechaVencimiento.AutoSize = true;
            this.lblFechaVencimiento.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFechaVencimiento.Location = new System.Drawing.Point(27, 210);
            this.lblFechaVencimiento.Name = "lblFechaVencimiento";
            this.lblFechaVencimiento.Size = new System.Drawing.Size(133, 13);
            this.lblFechaVencimiento.TabIndex = 17;
            this.lblFechaVencimiento.Text = "Fecha de Vencimiento";
            // 
            // dateTimeFechaVencimiento
            // 
            this.dateTimeFechaVencimiento.Location = new System.Drawing.Point(27, 226);
            this.dateTimeFechaVencimiento.Name = "dateTimeFechaVencimiento";
            this.dateTimeFechaVencimiento.Size = new System.Drawing.Size(251, 20);
            this.dateTimeFechaVencimiento.TabIndex = 16;
            this.dateTimeFechaVencimiento.Value = new System.DateTime(2016, 6, 6, 3, 16, 27, 0);
            // 
            // numPrecio
            // 
            this.numPrecio.Location = new System.Drawing.Point(157, 40);
            this.numPrecio.Name = "numPrecio";
            this.numPrecio.Size = new System.Drawing.Size(120, 20);
            this.numPrecio.TabIndex = 18;
            // 
            // numStock
            // 
            this.numStock.Location = new System.Drawing.Point(27, 40);
            this.numStock.Name = "numStock";
            this.numStock.Size = new System.Drawing.Size(79, 20);
            this.numStock.TabIndex = 19;
            // 
            // PublicacionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(767, 407);
            this.Controls.Add(this.pnlPublicacion);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnGuardar);
            this.Controls.Add(this.txtDescripción);
            this.Controls.Add(this.lblDescripción);
            this.Name = "PublicacionForm";
            this.Text = "Publicación";
            this.Load += new System.EventHandler(this.PublicacionForm_Load);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.pnlPublicacion.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.ComboBox ddlRol;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label21;
        private System.Windows.Forms.DateTimePicker dateTimeFechaInicio;
        private System.Windows.Forms.TextBox txtMailC;
        private System.Windows.Forms.TextBox txtTelefonoC;
        private System.Windows.Forms.Label lblDescripción;
        private System.Windows.Forms.Label label23;
        private System.Windows.Forms.TextBox txtDescripción;
        private System.Windows.Forms.Label label24;
        private System.Windows.Forms.Label lblStock;
        private System.Windows.Forms.TextBox txtApellido;
        private System.Windows.Forms.Label label26;
        private System.Windows.Forms.Label lblPrecio;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox txtDirCPC;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.TextBox txtDirLocalidadC;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.TextBox txtDirCalleC;
        private System.Windows.Forms.TextBox txtDirDeptoC;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.TextBox txtDirPisoC;
        private System.Windows.Forms.TextBox txtDirNumeroC;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.Label label20;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Label label28;
        private System.Windows.Forms.TextBox txtUserNameC;
        private System.Windows.Forms.TextBox txtPasswordC;
        private System.Windows.Forms.Label label29;
        private System.Windows.Forms.Panel pnlPublicacion;
        private System.Windows.Forms.Label lblFechaVencimiento;
        private System.Windows.Forms.DateTimePicker dateTimeFechaVencimiento;
        private System.Windows.Forms.NumericUpDown numStock;
        private System.Windows.Forms.NumericUpDown numPrecio;
    }
}