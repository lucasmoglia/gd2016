namespace ME.UI.Calificar
{
    partial class CalificarControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.gbUltimas5Calificaciones = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.btnCalificar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // gbUltimas5Calificaciones
            // 
            this.gbUltimas5Calificaciones.Location = new System.Drawing.Point(8, 283);
            this.gbUltimas5Calificaciones.Name = "gbUltimas5Calificaciones";
            this.gbUltimas5Calificaciones.Size = new System.Drawing.Size(817, 151);
            this.gbUltimas5Calificaciones.TabIndex = 1;
            this.gbUltimas5Calificaciones.TabStop = false;
            this.gbUltimas5Calificaciones.Text = "Ultimas 5 Compras Calificadas Por El Usuario";
            // 
            // groupBox2
            // 
            this.groupBox2.Location = new System.Drawing.Point(8, 31);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(817, 145);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Compras Sin Calificar";
            // 
            // btnCalificar
            // 
            this.btnCalificar.Location = new System.Drawing.Point(695, 200);
            this.btnCalificar.Name = "btnCalificar";
            this.btnCalificar.Size = new System.Drawing.Size(130, 24);
            this.btnCalificar.TabIndex = 3;
            this.btnCalificar.Text = "Calificar";
            this.btnCalificar.UseVisualStyleBackColor = true;
            // 
            // CalificarControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnCalificar);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.gbUltimas5Calificaciones);
            this.Name = "CalificarControl";
            this.Size = new System.Drawing.Size(838, 437);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbUltimas5Calificaciones;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btnCalificar;

    }
}
