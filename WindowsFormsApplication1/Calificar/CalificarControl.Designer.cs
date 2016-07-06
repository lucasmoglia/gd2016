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
            this.gvComprasCalificadas = new System.Windows.Forms.DataGridView();
            this.gbComprasSinCalificar = new System.Windows.Forms.GroupBox();
            this.gvComprasSinCalificar = new System.Windows.Forms.DataGridView();
            this.btnCalificar = new System.Windows.Forms.Button();
            this.gbComprasPorUsuario = new System.Windows.Forms.GroupBox();
            this.gvComprasUsuario = new System.Windows.Forms.DataGridView();
            this.gbUltimas5Calificaciones.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasCalificadas)).BeginInit();
            this.gbComprasSinCalificar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasSinCalificar)).BeginInit();
            this.gbComprasPorUsuario.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasUsuario)).BeginInit();
            this.SuspendLayout();
            // 
            // gbUltimas5Calificaciones
            // 
            this.gbUltimas5Calificaciones.Controls.Add(this.gvComprasCalificadas);
            this.gbUltimas5Calificaciones.Location = new System.Drawing.Point(8, 170);
            this.gbUltimas5Calificaciones.Name = "gbUltimas5Calificaciones";
            this.gbUltimas5Calificaciones.Size = new System.Drawing.Size(817, 174);
            this.gbUltimas5Calificaciones.TabIndex = 1;
            this.gbUltimas5Calificaciones.TabStop = false;
            this.gbUltimas5Calificaciones.Text = "Ultimas 5 Compras Calificadas Por El Usuario";
            // 
            // gvComprasCalificadas
            // 
            this.gvComprasCalificadas.AllowUserToAddRows = false;
            this.gvComprasCalificadas.AllowUserToDeleteRows = false;
            this.gvComprasCalificadas.BackgroundColor = System.Drawing.SystemColors.ButtonFace;
            this.gvComprasCalificadas.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.gvComprasCalificadas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvComprasCalificadas.GridColor = System.Drawing.SystemColors.ControlDarkDark;
            this.gvComprasCalificadas.Location = new System.Drawing.Point(6, 19);
            this.gvComprasCalificadas.Name = "gvComprasCalificadas";
            this.gvComprasCalificadas.ReadOnly = true;
            this.gvComprasCalificadas.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.gvComprasCalificadas.Size = new System.Drawing.Size(806, 149);
            this.gvComprasCalificadas.TabIndex = 1;
            // 
            // gbComprasSinCalificar
            // 
            this.gbComprasSinCalificar.Controls.Add(this.gvComprasSinCalificar);
            this.gbComprasSinCalificar.Location = new System.Drawing.Point(8, 3);
            this.gbComprasSinCalificar.Name = "gbComprasSinCalificar";
            this.gbComprasSinCalificar.Size = new System.Drawing.Size(817, 131);
            this.gbComprasSinCalificar.TabIndex = 2;
            this.gbComprasSinCalificar.TabStop = false;
            this.gbComprasSinCalificar.Text = "Compras Sin Calificar";
            // 
            // gvComprasSinCalificar
            // 
            this.gvComprasSinCalificar.AllowUserToAddRows = false;
            this.gvComprasSinCalificar.AllowUserToDeleteRows = false;
            this.gvComprasSinCalificar.BackgroundColor = System.Drawing.SystemColors.ButtonFace;
            this.gvComprasSinCalificar.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.gvComprasSinCalificar.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvComprasSinCalificar.Location = new System.Drawing.Point(5, 16);
            this.gvComprasSinCalificar.Name = "gvComprasSinCalificar";
            this.gvComprasSinCalificar.ReadOnly = true;
            this.gvComprasSinCalificar.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.gvComprasSinCalificar.Size = new System.Drawing.Size(806, 109);
            this.gvComprasSinCalificar.TabIndex = 2;
            // 
            // btnCalificar
            // 
            this.btnCalificar.Enabled = false;
            this.btnCalificar.Location = new System.Drawing.Point(695, 140);
            this.btnCalificar.Name = "btnCalificar";
            this.btnCalificar.Size = new System.Drawing.Size(130, 24);
            this.btnCalificar.TabIndex = 3;
            this.btnCalificar.Text = "Calificar";
            this.btnCalificar.UseVisualStyleBackColor = true;
            // 
            // gbComprasPorUsuario
            // 
            this.gbComprasPorUsuario.Controls.Add(this.gvComprasUsuario);
            this.gbComprasPorUsuario.Location = new System.Drawing.Point(8, 350);
            this.gbComprasPorUsuario.Name = "gbComprasPorUsuario";
            this.gbComprasPorUsuario.Size = new System.Drawing.Size(817, 72);
            this.gbComprasPorUsuario.TabIndex = 3;
            this.gbComprasPorUsuario.TabStop = false;
            this.gbComprasPorUsuario.Text = "Totales De Compras Por Usuario";
            // 
            // gvComprasUsuario
            // 
            this.gvComprasUsuario.AllowUserToAddRows = false;
            this.gvComprasUsuario.AllowUserToDeleteRows = false;
            this.gvComprasUsuario.BackgroundColor = System.Drawing.SystemColors.ButtonFace;
            this.gvComprasUsuario.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.gvComprasUsuario.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvComprasUsuario.Location = new System.Drawing.Point(5, 19);
            this.gvComprasUsuario.Name = "gvComprasUsuario";
            this.gvComprasUsuario.ReadOnly = true;
            this.gvComprasUsuario.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.gvComprasUsuario.Size = new System.Drawing.Size(806, 44);
            this.gvComprasUsuario.TabIndex = 0;
            // 
            // CalificarControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gbComprasPorUsuario);
            this.Controls.Add(this.btnCalificar);
            this.Controls.Add(this.gbComprasSinCalificar);
            this.Controls.Add(this.gbUltimas5Calificaciones);
            this.Name = "CalificarControl";
            this.Size = new System.Drawing.Size(838, 437);
            this.gbUltimas5Calificaciones.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasCalificadas)).EndInit();
            this.gbComprasSinCalificar.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasSinCalificar)).EndInit();
            this.gbComprasPorUsuario.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasUsuario)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbUltimas5Calificaciones;
        private System.Windows.Forms.GroupBox gbComprasSinCalificar;
        private System.Windows.Forms.Button btnCalificar;
        private System.Windows.Forms.GroupBox gbComprasPorUsuario;
        private System.Windows.Forms.DataGridView gvComprasUsuario;
        private System.Windows.Forms.DataGridView gvComprasSinCalificar;
        private System.Windows.Forms.DataGridView gvComprasCalificadas;

    }
}
