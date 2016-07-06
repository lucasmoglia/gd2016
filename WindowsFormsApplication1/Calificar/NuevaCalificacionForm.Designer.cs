namespace ME.UI.Calificar
{
    partial class NuevaCalificacionForm
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
            this.gbCompra = new System.Windows.Forms.GroupBox();
            this.gbCalificacion = new System.Windows.Forms.GroupBox();
            this.numericUpDown1 = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtDescCalif = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.gbCompra.SuspendLayout();
            this.gbCalificacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown1)).BeginInit();
            this.SuspendLayout();
            // 
            // gbCompra
            // 
            this.gbCompra.Controls.Add(this.label6);
            this.gbCompra.Controls.Add(this.label5);
            this.gbCompra.Controls.Add(this.label4);
            this.gbCompra.Controls.Add(this.label3);
            this.gbCompra.Location = new System.Drawing.Point(8, 15);
            this.gbCompra.Name = "gbCompra";
            this.gbCompra.Size = new System.Drawing.Size(455, 103);
            this.gbCompra.TabIndex = 0;
            this.gbCompra.TabStop = false;
            this.gbCompra.Text = "Datos de la Compra a Calificar";
            // 
            // gbCalificacion
            // 
            this.gbCalificacion.Controls.Add(this.txtDescCalif);
            this.gbCalificacion.Controls.Add(this.label2);
            this.gbCalificacion.Controls.Add(this.label1);
            this.gbCalificacion.Controls.Add(this.numericUpDown1);
            this.gbCalificacion.Location = new System.Drawing.Point(8, 151);
            this.gbCalificacion.Name = "gbCalificacion";
            this.gbCalificacion.Size = new System.Drawing.Size(455, 111);
            this.gbCalificacion.TabIndex = 1;
            this.gbCalificacion.TabStop = false;
            this.gbCalificacion.Text = "Calificación";
            // 
            // numericUpDown1
            // 
            this.numericUpDown1.Location = new System.Drawing.Point(144, 19);
            this.numericUpDown1.Maximum = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.numericUpDown1.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericUpDown1.Name = "numericUpDown1";
            this.numericUpDown1.Size = new System.Drawing.Size(305, 20);
            this.numericUpDown1.TabIndex = 0;
            this.numericUpDown1.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "label1";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 49);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(35, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "label2";
            // 
            // txtDescCalif
            // 
            this.txtDescCalif.Location = new System.Drawing.Point(144, 49);
            this.txtDescCalif.MaxLength = 254;
            this.txtDescCalif.Name = "txtDescCalif";
            this.txtDescCalif.Size = new System.Drawing.Size(304, 20);
            this.txtDescCalif.TabIndex = 3;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(10, 16);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(35, 13);
            this.label3.TabIndex = 0;
            this.label3.Text = "label3";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(10, 38);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(35, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "label4";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(10, 62);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(35, 13);
            this.label5.TabIndex = 2;
            this.label5.Text = "label5";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(10, 87);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(35, 13);
            this.label6.TabIndex = 3;
            this.label6.Text = "label6";
            // 
            // NuevaCalificacionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(471, 312);
            this.Controls.Add(this.gbCalificacion);
            this.Controls.Add(this.gbCompra);
            this.Name = "NuevaCalificacionForm";
            this.Text = "Nueva Calificación";
            this.gbCompra.ResumeLayout(false);
            this.gbCompra.PerformLayout();
            this.gbCalificacion.ResumeLayout(false);
            this.gbCalificacion.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbCompra;
        private System.Windows.Forms.GroupBox gbCalificacion;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtDescCalif;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown numericUpDown1;
    }
}