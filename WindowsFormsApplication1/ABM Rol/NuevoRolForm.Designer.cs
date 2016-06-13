namespace ME.UI
{
    partial class NuevoRolForm
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
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.lblName = new System.Windows.Forms.Label();
            this.lstFuncionalidadesAsignadas = new System.Windows.Forms.ListBox();
            this.lstFuncionalidadesDisponibles = new System.Windows.Forms.ListBox();
            this.btnAgregarFuncionalidad = new System.Windows.Forms.Button();
            this.btnQuitarFuncionalidad = new System.Windows.Forms.Button();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(13, 43);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(150, 20);
            this.textBox1.TabIndex = 0;
            // 
            // lblName
            // 
            this.lblName.AutoSize = true;
            this.lblName.Location = new System.Drawing.Point(13, 24);
            this.lblName.Name = "lblName";
            this.lblName.Size = new System.Drawing.Size(44, 13);
            this.lblName.TabIndex = 1;
            this.lblName.Text = "Nombre";
            // 
            // lstFuncionalidadesAsignadas
            // 
            this.lstFuncionalidadesAsignadas.FormattingEnabled = true;
            this.lstFuncionalidadesAsignadas.Location = new System.Drawing.Point(13, 89);
            this.lstFuncionalidadesAsignadas.Name = "lstFuncionalidadesAsignadas";
            this.lstFuncionalidadesAsignadas.Size = new System.Drawing.Size(223, 303);
            this.lstFuncionalidadesAsignadas.TabIndex = 2;
            // 
            // lstFuncionalidadesDisponibles
            // 
            this.lstFuncionalidadesDisponibles.FormattingEnabled = true;
            this.lstFuncionalidadesDisponibles.Location = new System.Drawing.Point(379, 89);
            this.lstFuncionalidadesDisponibles.Name = "lstFuncionalidadesDisponibles";
            this.lstFuncionalidadesDisponibles.Size = new System.Drawing.Size(223, 303);
            this.lstFuncionalidadesDisponibles.TabIndex = 3;
            // 
            // btnAgregarFuncionalidad
            // 
            this.btnAgregarFuncionalidad.Location = new System.Drawing.Point(267, 173);
            this.btnAgregarFuncionalidad.Name = "btnAgregarFuncionalidad";
            this.btnAgregarFuncionalidad.Size = new System.Drawing.Size(75, 23);
            this.btnAgregarFuncionalidad.TabIndex = 4;
            this.btnAgregarFuncionalidad.Text = "<<";
            this.btnAgregarFuncionalidad.UseVisualStyleBackColor = true;
            this.btnAgregarFuncionalidad.Click += new System.EventHandler(this.btnAgregarFuncionalidad_Click);
            // 
            // btnQuitarFuncionalidad
            // 
            this.btnQuitarFuncionalidad.Location = new System.Drawing.Point(267, 235);
            this.btnQuitarFuncionalidad.Name = "btnQuitarFuncionalidad";
            this.btnQuitarFuncionalidad.Size = new System.Drawing.Size(75, 23);
            this.btnQuitarFuncionalidad.TabIndex = 4;
            this.btnQuitarFuncionalidad.Text = ">>";
            this.btnQuitarFuncionalidad.UseVisualStyleBackColor = true;
            this.btnQuitarFuncionalidad.Click += new System.EventHandler(this.btnQuitarFuncionalidad_Click);
            // 
            // btnGuardar
            // 
            this.btnGuardar.Location = new System.Drawing.Point(527, 425);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(75, 23);
            this.btnGuardar.TabIndex = 5;
            this.btnGuardar.Text = "Guardar";
            this.btnGuardar.UseVisualStyleBackColor = true;
            // 
            // btnCancelar
            // 
            this.btnCancelar.Location = new System.Drawing.Point(446, 425);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(75, 23);
            this.btnCancelar.TabIndex = 6;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = true;
            // 
            // NuevoRolForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(614, 473);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnGuardar);
            this.Controls.Add(this.btnQuitarFuncionalidad);
            this.Controls.Add(this.btnAgregarFuncionalidad);
            this.Controls.Add(this.lstFuncionalidadesDisponibles);
            this.Controls.Add(this.lstFuncionalidadesAsignadas);
            this.Controls.Add(this.lblName);
            this.Controls.Add(this.textBox1);
            this.Name = "NuevoRolForm";
            this.Text = "NuevoRolForm";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.ListBox lstFuncionalidadesAsignadas;
        private System.Windows.Forms.ListBox lstFuncionalidadesDisponibles;
        private System.Windows.Forms.Button btnAgregarFuncionalidad;
        private System.Windows.Forms.Button btnQuitarFuncionalidad;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
    }
}