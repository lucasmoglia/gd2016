namespace ME.UI
{
    partial class NuevaVisibilidadForm
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
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.pnlVisibilidad = new System.Windows.Forms.Panel();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.txtPorcVenta = new System.Windows.Forms.TextBox();
            this.label22 = new System.Windows.Forms.Label();
            this.txtDescripcionV = new System.Windows.Forms.TextBox();
            this.label24 = new System.Windows.Forms.Label();
            this.txtCostoPublicar = new System.Windows.Forms.TextBox();
            this.txtCostoEnvio = new System.Windows.Forms.TextBox();
            this.label26 = new System.Windows.Forms.Label();
            this.label27 = new System.Windows.Forms.Label();
            this.pnlVisibilidad.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.SuspendLayout();
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
            // pnlVisibilidad
            // 
            this.pnlVisibilidad.Controls.Add(this.groupBox4);
            this.pnlVisibilidad.Location = new System.Drawing.Point(38, 42);
            this.pnlVisibilidad.Name = "pnlVisibilidad";
            this.pnlVisibilidad.Size = new System.Drawing.Size(675, 275);
            this.pnlVisibilidad.TabIndex = 18;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.txtPorcVenta);
            this.groupBox4.Controls.Add(this.label22);
            this.groupBox4.Controls.Add(this.txtDescripcionV);
            this.groupBox4.Controls.Add(this.label24);
            this.groupBox4.Controls.Add(this.txtCostoPublicar);
            this.groupBox4.Controls.Add(this.txtCostoEnvio);
            this.groupBox4.Controls.Add(this.label26);
            this.groupBox4.Controls.Add(this.label27);
            this.groupBox4.Location = new System.Drawing.Point(25, 7);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(647, 246);
            this.groupBox4.TabIndex = 20;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Datos De la Nueva Visibilidad";
            // 
            // txtPorcVenta
            // 
            this.txtPorcVenta.Location = new System.Drawing.Point(156, 126);
            this.txtPorcVenta.Name = "txtPorcVenta";
            this.txtPorcVenta.Size = new System.Drawing.Size(334, 20);
            this.txtPorcVenta.TabIndex = 7;
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label22.Location = new System.Drawing.Point(24, 43);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(74, 13);
            this.label22.TabIndex = 2;
            this.label22.Text = "Descripción";
            // 
            // txtDescripcionV
            // 
            this.txtDescripcionV.Location = new System.Drawing.Point(156, 43);
            this.txtDescripcionV.Name = "txtDescripcionV";
            this.txtDescripcionV.Size = new System.Drawing.Size(334, 20);
            this.txtDescripcionV.TabIndex = 3;
            // 
            // label24
            // 
            this.label24.AutoSize = true;
            this.label24.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label24.Location = new System.Drawing.Point(24, 85);
            this.label24.Name = "label24";
            this.label24.Size = new System.Drawing.Size(89, 13);
            this.label24.TabIndex = 4;
            this.label24.Text = "Costo Publicar";
            // 
            // txtCostoPublicar
            // 
            this.txtCostoPublicar.Location = new System.Drawing.Point(156, 85);
            this.txtCostoPublicar.Name = "txtCostoPublicar";
            this.txtCostoPublicar.Size = new System.Drawing.Size(334, 20);
            this.txtCostoPublicar.TabIndex = 5;
            // 
            // txtCostoEnvio
            // 
            this.txtCostoEnvio.Location = new System.Drawing.Point(156, 176);
            this.txtCostoEnvio.Name = "txtCostoEnvio";
            this.txtCostoEnvio.Size = new System.Drawing.Size(334, 20);
            this.txtCostoEnvio.TabIndex = 9;
            // 
            // label26
            // 
            this.label26.AutoSize = true;
            this.label26.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label26.Location = new System.Drawing.Point(24, 126);
            this.label26.Name = "label26";
            this.label26.Size = new System.Drawing.Size(105, 13);
            this.label26.TabIndex = 6;
            this.label26.Text = "Porcentaje Venta";
            // 
            // label27
            // 
            this.label27.AutoSize = true;
            this.label27.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label27.Location = new System.Drawing.Point(24, 176);
            this.label27.Name = "label27";
            this.label27.Size = new System.Drawing.Size(77, 13);
            this.label27.TabIndex = 8;
            this.label27.Text = "Costo Envío";
            // 
            // NuevaVisibilidadForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(767, 407);
            this.Controls.Add(this.pnlVisibilidad);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnGuardar);
            this.Name = "NuevaVisibilidadForm";
            this.Text = "Nueva Visibilidad";
            this.Load += new System.EventHandler(this.NuevaVisibilidadForm_Load);
            this.pnlVisibilidad.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Panel pnlVisibilidad;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.TextBox txtPorcVenta;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.TextBox txtDescripcionV;
        private System.Windows.Forms.Label label24;
        private System.Windows.Forms.TextBox txtCostoPublicar;
        private System.Windows.Forms.TextBox txtCostoEnvio;
        private System.Windows.Forms.Label label26;
        private System.Windows.Forms.Label label27;
    }
}