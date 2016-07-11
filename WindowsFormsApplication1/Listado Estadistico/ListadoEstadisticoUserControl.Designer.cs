namespace ME.UI
{
    partial class ListadoEstadisticoUserControl
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
            this.Vistas = new System.Windows.Forms.GroupBox();
            this.rbtMCPNV = new System.Windows.Forms.RadioButton();
            this.rbtMCPC = new System.Windows.Forms.RadioButton();
            this.rbtMCF = new System.Windows.Forms.RadioButton();
            this.rbtMMF = new System.Windows.Forms.RadioButton();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblExtra = new System.Windows.Forms.Label();
            this.lblAnio = new System.Windows.Forms.Label();
            this.lblMes = new System.Windows.Forms.Label();
            this.ddlExtra = new System.Windows.Forms.ComboBox();
            this.ddlAnio = new System.Windows.Forms.ComboBox();
            this.ddlMes = new System.Windows.Forms.ComboBox();
            this.gvResult = new System.Windows.Forms.DataGridView();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.Vistas.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvResult)).BeginInit();
            this.SuspendLayout();
            // 
            // Vistas
            // 
            this.Vistas.Controls.Add(this.rbtMCPNV);
            this.Vistas.Controls.Add(this.rbtMCPC);
            this.Vistas.Controls.Add(this.rbtMCF);
            this.Vistas.Controls.Add(this.rbtMMF);
            this.Vistas.Location = new System.Drawing.Point(3, 3);
            this.Vistas.Name = "Vistas";
            this.Vistas.Size = new System.Drawing.Size(800, 91);
            this.Vistas.TabIndex = 0;
            this.Vistas.TabStop = false;
            this.Vistas.Text = "Vistas";
            // 
            // rbtMCPNV
            // 
            this.rbtMCPNV.AutoSize = true;
            this.rbtMCPNV.Location = new System.Drawing.Point(397, 52);
            this.rbtMCPNV.Name = "rbtMCPNV";
            this.rbtMCPNV.Size = new System.Drawing.Size(304, 17);
            this.rbtMCPNV.TabIndex = 3;
            this.rbtMCPNV.TabStop = true;
            this.rbtMCPNV.Text = "Vendedores con mayor cantidad de productos no vendidos";
            this.rbtMCPNV.UseVisualStyleBackColor = true;
            this.rbtMCPNV.Click += new System.EventHandler(this.GetReporteVMCPNV);
            // 
            // rbtMCPC
            // 
            this.rbtMCPC.AutoSize = true;
            this.rbtMCPC.Location = new System.Drawing.Point(397, 29);
            this.rbtMCPC.Name = "rbtMCPC";
            this.rbtMCPC.Size = new System.Drawing.Size(278, 17);
            this.rbtMCPC.TabIndex = 2;
            this.rbtMCPC.TabStop = true;
            this.rbtMCPC.Text = "Clientes con mayor cantidad de productos comprados";
            this.rbtMCPC.UseVisualStyleBackColor = true;
            this.rbtMCPC.Click += new System.EventHandler(this.GetReporteCMCPC);
            // 
            // rbtMCF
            // 
            this.rbtMCF.AutoSize = true;
            this.rbtMCF.Location = new System.Drawing.Point(118, 52);
            this.rbtMCF.Name = "rbtMCF";
            this.rbtMCF.Size = new System.Drawing.Size(234, 17);
            this.rbtMCF.TabIndex = 1;
            this.rbtMCF.TabStop = true;
            this.rbtMCF.Text = "Vendedores con mayor cantidad de facturas";
            this.rbtMCF.UseVisualStyleBackColor = true;
            this.rbtMCF.Click += new System.EventHandler(this.GetReporteVMCF);
            // 
            // rbtMMF
            // 
            this.rbtMMF.AutoSize = true;
            this.rbtMMF.Location = new System.Drawing.Point(118, 29);
            this.rbtMMF.Name = "rbtMMF";
            this.rbtMMF.Size = new System.Drawing.Size(214, 17);
            this.rbtMMF.TabIndex = 0;
            this.rbtMMF.TabStop = true;
            this.rbtMMF.Text = "Vendedores con mayor monto facturado";
            this.rbtMMF.UseVisualStyleBackColor = true;
            this.rbtMMF.Click += new System.EventHandler(this.GetReporteVMMF);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnBuscar);
            this.groupBox1.Controls.Add(this.lblExtra);
            this.groupBox1.Controls.Add(this.lblAnio);
            this.groupBox1.Controls.Add(this.lblMes);
            this.groupBox1.Controls.Add(this.ddlExtra);
            this.groupBox1.Controls.Add(this.ddlAnio);
            this.groupBox1.Controls.Add(this.ddlMes);
            this.groupBox1.Location = new System.Drawing.Point(190, 100);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(399, 108);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Filtros";
            // 
            // lblExtra
            // 
            this.lblExtra.AutoSize = true;
            this.lblExtra.Location = new System.Drawing.Point(143, 26);
            this.lblExtra.Name = "lblExtra";
            this.lblExtra.Size = new System.Drawing.Size(0, 13);
            this.lblExtra.TabIndex = 7;
            // 
            // lblAnio
            // 
            this.lblAnio.AutoSize = true;
            this.lblAnio.Location = new System.Drawing.Point(73, 26);
            this.lblAnio.Name = "lblAnio";
            this.lblAnio.Size = new System.Drawing.Size(26, 13);
            this.lblAnio.TabIndex = 5;
            this.lblAnio.Text = "Año";
            // 
            // lblMes
            // 
            this.lblMes.AutoSize = true;
            this.lblMes.Location = new System.Drawing.Point(7, 26);
            this.lblMes.Name = "lblMes";
            this.lblMes.Size = new System.Drawing.Size(27, 13);
            this.lblMes.TabIndex = 4;
            this.lblMes.Text = "Mes";
            // 
            // ddlExtra
            // 
            this.ddlExtra.FormattingEnabled = true;
            this.ddlExtra.Location = new System.Drawing.Point(146, 45);
            this.ddlExtra.Name = "ddlExtra";
            this.ddlExtra.Size = new System.Drawing.Size(247, 21);
            this.ddlExtra.TabIndex = 3;
            // 
            // ddlAnio
            // 
            this.ddlAnio.AutoCompleteCustomSource.AddRange(new string[] {
            "2010",
            "2011",
            "2012",
            "2013",
            "2014",
            "2015",
            "2016"});
            this.ddlAnio.FormattingEnabled = true;
            this.ddlAnio.Items.AddRange(new object[] {
            "2000",
            "2001",
            "2002",
            "2003",
            "2004",
            "2005",
            "2006",
            "2007",
            "2008",
            "2009",
            "2010",
            "2011",
            "2012",
            "2013",
            "2014",
            "2015"});
            this.ddlAnio.Location = new System.Drawing.Point(76, 45);
            this.ddlAnio.Name = "ddlAnio";
            this.ddlAnio.Size = new System.Drawing.Size(64, 21);
            this.ddlAnio.TabIndex = 1;
            // 
            // ddlMes
            // 
            this.ddlMes.AutoCompleteCustomSource.AddRange(new string[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"});
            this.ddlMes.FormattingEnabled = true;
            this.ddlMes.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"});
            this.ddlMes.Location = new System.Drawing.Point(6, 45);
            this.ddlMes.Name = "ddlMes";
            this.ddlMes.Size = new System.Drawing.Size(64, 21);
            this.ddlMes.TabIndex = 0;
            // 
            // gvResult
            // 
            this.gvResult.AllowUserToAddRows = false;
            this.gvResult.AllowUserToDeleteRows = false;
            this.gvResult.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.gvResult.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvResult.Location = new System.Drawing.Point(190, 214);
            this.gvResult.Name = "gvResult";
            this.gvResult.ReadOnly = true;
            this.gvResult.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvResult.Size = new System.Drawing.Size(399, 133);
            this.gvResult.TabIndex = 2;
            // 
            // btnBuscar
            // 
            this.btnBuscar.Location = new System.Drawing.Point(317, 79);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(75, 23);
            this.btnBuscar.TabIndex = 8;
            this.btnBuscar.Text = "Consultar!";
            this.btnBuscar.UseVisualStyleBackColor = true;
            this.btnBuscar.Click += new System.EventHandler(this.btnBuscar_Click);
            // 
            // ListadoEstadisticoUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gvResult);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.Vistas);
            this.Name = "ListadoEstadisticoUserControl";
            this.Size = new System.Drawing.Size(806, 500);
            this.Vistas.ResumeLayout(false);
            this.Vistas.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvResult)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox Vistas;
        private System.Windows.Forms.RadioButton rbtMCPNV;
        private System.Windows.Forms.RadioButton rbtMCPC;
        private System.Windows.Forms.RadioButton rbtMCF;
        private System.Windows.Forms.RadioButton rbtMMF;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label lblExtra;
        private System.Windows.Forms.Label lblAnio;
        private System.Windows.Forms.Label lblMes;
        private System.Windows.Forms.ComboBox ddlExtra;
        private System.Windows.Forms.ComboBox ddlAnio;
        private System.Windows.Forms.ComboBox ddlMes;
        private System.Windows.Forms.DataGridView gvResult;
        private System.Windows.Forms.Button btnBuscar;
    }
}
