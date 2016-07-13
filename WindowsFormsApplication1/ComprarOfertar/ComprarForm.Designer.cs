namespace ME.UI
{
    partial class ComprarForm
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
            this.lblMontoCant = new System.Windows.Forms.Label();
            this.btnAceptar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.numMontoCant = new System.Windows.Forms.NumericUpDown();
            this.groupCompra = new System.Windows.Forms.GroupBox();
            ((System.ComponentModel.ISupportInitialize)(this.numMontoCant)).BeginInit();
            this.groupCompra.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblMontoCant
            // 
            this.lblMontoCant.AutoSize = true;
            this.lblMontoCant.Location = new System.Drawing.Point(12, 25);
            this.lblMontoCant.Name = "lblMontoCant";
            this.lblMontoCant.Size = new System.Drawing.Size(59, 13);
            this.lblMontoCant.TabIndex = 2;
            this.lblMontoCant.Text = "MontoCant";
            this.lblMontoCant.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // btnAceptar
            // 
            this.btnAceptar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAceptar.Location = new System.Drawing.Point(138, 78);
            this.btnAceptar.Name = "btnAceptar";
            this.btnAceptar.Size = new System.Drawing.Size(115, 23);
            this.btnAceptar.TabIndex = 4;
            this.btnAceptar.Text = "Comprar";
            this.btnAceptar.UseVisualStyleBackColor = true;
            this.btnAceptar.Click += new System.EventHandler(this.btnAceptar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelar.Location = new System.Drawing.Point(6, 78);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(115, 23);
            this.btnCancelar.TabIndex = 5;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // numMontoCant
            // 
            this.numMontoCant.DecimalPlaces = 2;
            this.numMontoCant.Location = new System.Drawing.Point(90, 36);
            this.numMontoCant.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.numMontoCant.Name = "numMontoCant";
            this.numMontoCant.Size = new System.Drawing.Size(120, 20);
            this.numMontoCant.TabIndex = 6;
            // 
            // groupCompra
            // 
            this.groupCompra.Controls.Add(this.btnCancelar);
            this.groupCompra.Controls.Add(this.lblMontoCant);
            this.groupCompra.Controls.Add(this.btnAceptar);
            this.groupCompra.Location = new System.Drawing.Point(13, 13);
            this.groupCompra.Name = "groupCompra";
            this.groupCompra.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.groupCompra.Size = new System.Drawing.Size(259, 125);
            this.groupCompra.TabIndex = 7;
            this.groupCompra.TabStop = false;
            this.groupCompra.Text = "Compra";
            // 
            // ComprarForm
            // 
            this.AcceptButton = this.btnAceptar;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.ForestGreen;
            this.CancelButton = this.btnCancelar;
            this.ClientSize = new System.Drawing.Size(284, 150);
            this.ControlBox = false;
            this.Controls.Add(this.numMontoCant);
            this.Controls.Add(this.groupCompra);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Location = new System.Drawing.Point(15, 10);
            this.MaximizeBox = false;
            this.Name = "ComprarForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "Comprar";
            this.Load += new System.EventHandler(this.ComprarForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.numMontoCant)).EndInit();
            this.groupCompra.ResumeLayout(false);
            this.groupCompra.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblMontoCant;
        private System.Windows.Forms.Button btnAceptar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.NumericUpDown numMontoCant;
        private System.Windows.Forms.GroupBox groupCompra;
    }
}