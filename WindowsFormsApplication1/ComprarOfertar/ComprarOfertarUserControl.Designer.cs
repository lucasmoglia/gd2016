namespace ME.UI
{
    partial class ComprarOfertarUserControl
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ComprarOfertarUserControl));
            this.gvPublicaciones = new System.Windows.Forms.DataGridView();
            this.btnComprar = new System.Windows.Forms.Button();
            this.btnEditPublicacion = new System.Windows.Forms.Button();
            this.btnRemovePublicacion = new System.Windows.Forms.Button();
            this.bindNav1 = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindSourcePublicaciones = new System.Windows.Forms.BindingSource(this.components);
            this.bindNavCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindNavFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavPreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep = new System.Windows.Forms.ToolStripSeparator();
            this.bindNavPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindNavNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep2 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripButton1 = new System.Windows.Forms.ToolStripButton();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.gBoxFiltros = new System.Windows.Forms.GroupBox();
            this.lblRubros = new System.Windows.Forms.Label();
            this.cmbBoxRubros = new System.Windows.Forms.ComboBox();
            this.txtDescripcion = new System.Windows.Forms.TextBox();
            this.lblDescripcion = new System.Windows.Forms.Label();
            this.btnVer = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindNav1)).BeginInit();
            this.bindNav1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindSourcePublicaciones)).BeginInit();
            this.gBoxFiltros.SuspendLayout();
            this.SuspendLayout();
            // 
            // gvPublicaciones
            // 
            this.gvPublicaciones.AllowUserToAddRows = false;
            this.gvPublicaciones.AllowUserToDeleteRows = false;
            this.gvPublicaciones.AllowUserToOrderColumns = true;
            this.gvPublicaciones.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            this.gvPublicaciones.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvPublicaciones.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gvPublicaciones.Location = new System.Drawing.Point(3, 157);
            this.gvPublicaciones.Name = "gvPublicaciones";
            this.gvPublicaciones.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvPublicaciones.Size = new System.Drawing.Size(800, 300);
            this.gvPublicaciones.TabIndex = 0;
            this.gvPublicaciones.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvPublicaciones_RowEnter);
            // 
            // btnComprar
            // 
            this.btnComprar.FlatAppearance.BorderColor = System.Drawing.Color.Blue;
            this.btnComprar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnComprar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnComprar.Location = new System.Drawing.Point(663, 467);
            this.btnComprar.Name = "btnComprar";
            this.btnComprar.Size = new System.Drawing.Size(137, 23);
            this.btnComprar.TabIndex = 1;
            this.btnComprar.Text = "Comprar / Ofertar";
            this.btnComprar.UseVisualStyleBackColor = true;
            this.btnComprar.Click += new System.EventHandler(this.btnComprar_Click);
            // 
            // btnEditPublicacion
            // 
            this.btnEditPublicacion.BackColor = System.Drawing.Color.LimeGreen;
            this.btnEditPublicacion.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnEditPublicacion.Location = new System.Drawing.Point(12, 467);
            this.btnEditPublicacion.Name = "btnEditPublicacion";
            this.btnEditPublicacion.Size = new System.Drawing.Size(63, 23);
            this.btnEditPublicacion.TabIndex = 2;
            this.btnEditPublicacion.Text = "Editar";
            this.btnEditPublicacion.UseVisualStyleBackColor = false;
            this.btnEditPublicacion.Visible = false;
            this.btnEditPublicacion.Click += new System.EventHandler(this.btnEditPublicacion_Click);
            // 
            // btnRemovePublicacion
            // 
            this.btnRemovePublicacion.BackColor = System.Drawing.Color.DarkRed;
            this.btnRemovePublicacion.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnRemovePublicacion.Location = new System.Drawing.Point(81, 467);
            this.btnRemovePublicacion.Name = "btnRemovePublicacion";
            this.btnRemovePublicacion.Size = new System.Drawing.Size(63, 23);
            this.btnRemovePublicacion.TabIndex = 3;
            this.btnRemovePublicacion.Text = "Borrar";
            this.btnRemovePublicacion.UseVisualStyleBackColor = false;
            this.btnRemovePublicacion.Visible = false;
            // 
            // bindNav1
            // 
            this.bindNav1.AddNewItem = null;
            this.bindNav1.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.bindNav1.BindingSource = this.bindSourcePublicaciones;
            this.bindNav1.CountItem = this.bindNavCountItem;
            this.bindNav1.DeleteItem = null;
            this.bindNav1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindNavFirstItem,
            this.bindNavPreviousItem,
            this.bindNavSep,
            this.bindNavPositionItem,
            this.bindNavCountItem,
            this.bindingNavigatorSeparator1,
            this.bindNavNextItem,
            this.bindNavLastItem,
            this.bindNavSep2,
            this.toolStripButton1});
            this.bindNav1.Location = new System.Drawing.Point(0, 0);
            this.bindNav1.MoveFirstItem = this.bindNavFirstItem;
            this.bindNav1.MoveLastItem = this.bindNavLastItem;
            this.bindNav1.MoveNextItem = this.bindNavNextItem;
            this.bindNav1.MovePreviousItem = this.bindNavPreviousItem;
            this.bindNav1.Name = "bindNav1";
            this.bindNav1.PositionItem = this.bindNavPositionItem;
            this.bindNav1.Size = new System.Drawing.Size(806, 25);
            this.bindNav1.TabIndex = 4;
            this.bindNav1.Text = "Barra de Navegación";
            // 
            // bindNavCountItem
            // 
            this.bindNavCountItem.Name = "bindNavCountItem";
            this.bindNavCountItem.Size = new System.Drawing.Size(37, 22);
            this.bindNavCountItem.Text = "de {0}";
            this.bindNavCountItem.ToolTipText = "Total number of items";
            // 
            // bindNavFirstItem
            // 
            this.bindNavFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindNavFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindNavFirstItem.Image")));
            this.bindNavFirstItem.Name = "bindNavFirstItem";
            this.bindNavFirstItem.RightToLeftAutoMirrorImage = true;
            this.bindNavFirstItem.Size = new System.Drawing.Size(23, 22);
            this.bindNavFirstItem.Text = "Move first";
            // 
            // bindNavPreviousItem
            // 
            this.bindNavPreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindNavPreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindNavPreviousItem.Image")));
            this.bindNavPreviousItem.Name = "bindNavPreviousItem";
            this.bindNavPreviousItem.RightToLeftAutoMirrorImage = true;
            this.bindNavPreviousItem.Size = new System.Drawing.Size(23, 22);
            this.bindNavPreviousItem.Text = "Move previous";
            // 
            // bindNavSep
            // 
            this.bindNavSep.Name = "bindNavSep";
            this.bindNavSep.Size = new System.Drawing.Size(6, 25);
            // 
            // bindNavPositionItem
            // 
            this.bindNavPositionItem.AccessibleName = "Position";
            this.bindNavPositionItem.AutoSize = false;
            this.bindNavPositionItem.Name = "bindNavPositionItem";
            this.bindNavPositionItem.Size = new System.Drawing.Size(50, 23);
            this.bindNavPositionItem.Text = "0";
            this.bindNavPositionItem.ToolTipText = "Current position";
            // 
            // bindingNavigatorSeparator1
            // 
            this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator1";
            this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindNavNextItem
            // 
            this.bindNavNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindNavNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindNavNextItem.Image")));
            this.bindNavNextItem.Name = "bindNavNextItem";
            this.bindNavNextItem.RightToLeftAutoMirrorImage = true;
            this.bindNavNextItem.Size = new System.Drawing.Size(23, 22);
            this.bindNavNextItem.Text = "Move next";
            // 
            // bindNavLastItem
            // 
            this.bindNavLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindNavLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindNavLastItem.Image")));
            this.bindNavLastItem.Name = "bindNavLastItem";
            this.bindNavLastItem.RightToLeftAutoMirrorImage = true;
            this.bindNavLastItem.Size = new System.Drawing.Size(23, 22);
            this.bindNavLastItem.Text = "Move last";
            // 
            // bindNavSep2
            // 
            this.bindNavSep2.Name = "bindNavSep2";
            this.bindNavSep2.Size = new System.Drawing.Size(6, 25);
            // 
            // toolStripButton1
            // 
            this.toolStripButton1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton1.Enabled = false;
            this.toolStripButton1.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton1.Image")));
            this.toolStripButton1.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton1.Name = "toolStripButton1";
            this.toolStripButton1.Size = new System.Drawing.Size(23, 22);
            this.toolStripButton1.Text = "toolStripButton1";
            // 
            // btnLimpiar
            // 
            this.btnLimpiar.Location = new System.Drawing.Point(3, 124);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(97, 24);
            this.btnLimpiar.TabIndex = 5;
            this.btnLimpiar.Text = "Limpiar";
            this.btnLimpiar.UseVisualStyleBackColor = true;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            // 
            // btnBuscar
            // 
            this.btnBuscar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBuscar.Location = new System.Drawing.Point(686, 124);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(117, 24);
            this.btnBuscar.TabIndex = 6;
            this.btnBuscar.Text = "Buscar";
            this.btnBuscar.UseVisualStyleBackColor = true;
            this.btnBuscar.Click += new System.EventHandler(this.btnBuscar_Click);
            // 
            // gBoxFiltros
            // 
            this.gBoxFiltros.Controls.Add(this.lblRubros);
            this.gBoxFiltros.Controls.Add(this.cmbBoxRubros);
            this.gBoxFiltros.Controls.Add(this.txtDescripcion);
            this.gBoxFiltros.Controls.Add(this.lblDescripcion);
            this.gBoxFiltros.ForeColor = System.Drawing.SystemColors.HotTrack;
            this.gBoxFiltros.Location = new System.Drawing.Point(3, 37);
            this.gBoxFiltros.Name = "gBoxFiltros";
            this.gBoxFiltros.Size = new System.Drawing.Size(800, 70);
            this.gBoxFiltros.TabIndex = 7;
            this.gBoxFiltros.TabStop = false;
            this.gBoxFiltros.Text = "Filtros de Búsqueda";
            // 
            // lblRubros
            // 
            this.lblRubros.AutoSize = true;
            this.lblRubros.ForeColor = System.Drawing.SystemColors.ControlText;
            this.lblRubros.Location = new System.Drawing.Point(458, 24);
            this.lblRubros.Name = "lblRubros";
            this.lblRubros.Size = new System.Drawing.Size(41, 13);
            this.lblRubros.TabIndex = 3;
            this.lblRubros.Text = "Rubros";
            // 
            // cmbBoxRubros
            // 
            this.cmbBoxRubros.DataSource = this.bindSourcePublicaciones;
            this.cmbBoxRubros.ForeColor = System.Drawing.SystemColors.WindowFrame;
            this.cmbBoxRubros.FormattingEnabled = true;
            this.cmbBoxRubros.Location = new System.Drawing.Point(503, 20);
            this.cmbBoxRubros.MaxDropDownItems = 10;
            this.cmbBoxRubros.Name = "cmbBoxRubros";
            this.cmbBoxRubros.Size = new System.Drawing.Size(291, 21);
            this.cmbBoxRubros.TabIndex = 2;
            this.cmbBoxRubros.SelectedIndexChanged += new System.EventHandler(this.cmbBoxRubros_SelectedIndexChanged);
            this.cmbBoxRubros.Click += new System.EventHandler(this.cmbBoxRubros_Click);
            // 
            // txtDescripcion
            // 
            this.txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            this.txtDescripcion.Location = new System.Drawing.Point(77, 21);
            this.txtDescripcion.Multiline = true;
            this.txtDescripcion.Name = "txtDescripcion";
            this.txtDescripcion.Size = new System.Drawing.Size(326, 20);
            this.txtDescripcion.TabIndex = 1;
            this.txtDescripcion.Text = "Ingrese búsqueda";
            this.txtDescripcion.Click += new System.EventHandler(this.txtDescripcion_Click);
            this.txtDescripcion.Leave += new System.EventHandler(this.txtDescripcion_Leave);
            // 
            // lblDescripcion
            // 
            this.lblDescripcion.AutoSize = true;
            this.lblDescripcion.ForeColor = System.Drawing.SystemColors.ControlText;
            this.lblDescripcion.Location = new System.Drawing.Point(11, 24);
            this.lblDescripcion.Name = "lblDescripcion";
            this.lblDescripcion.Size = new System.Drawing.Size(63, 13);
            this.lblDescripcion.TabIndex = 0;
            this.lblDescripcion.Text = "Descripción";
            // 
            // btnVer
            // 
            this.btnVer.Location = new System.Drawing.Point(547, 467);
            this.btnVer.Name = "btnVer";
            this.btnVer.Size = new System.Drawing.Size(76, 23);
            this.btnVer.TabIndex = 8;
            this.btnVer.Text = "Ver";
            this.btnVer.UseVisualStyleBackColor = true;
            this.btnVer.Click += new System.EventHandler(this.btnVer_Click);
            // 
            // ComprarOfertarUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.btnVer);
            this.Controls.Add(this.gBoxFiltros);
            this.Controls.Add(this.btnBuscar);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.bindNav1);
            this.Controls.Add(this.btnRemovePublicacion);
            this.Controls.Add(this.btnEditPublicacion);
            this.Controls.Add(this.btnComprar);
            this.Controls.Add(this.gvPublicaciones);
            this.Name = "ComprarOfertarUserControl";
            this.Size = new System.Drawing.Size(806, 500);
            this.Load += new System.EventHandler(this.PublicacionesUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindNav1)).EndInit();
            this.bindNav1.ResumeLayout(false);
            this.bindNav1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindSourcePublicaciones)).EndInit();
            this.gBoxFiltros.ResumeLayout(false);
            this.gBoxFiltros.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gvPublicaciones;
        private System.Windows.Forms.Button btnComprar;
        private System.Windows.Forms.Button btnEditPublicacion;
        private System.Windows.Forms.Button btnRemovePublicacion;
        private System.Windows.Forms.BindingNavigator bindNav1;
        private System.Windows.Forms.ToolStripLabel bindNavCountItem;
        private System.Windows.Forms.ToolStripButton bindNavFirstItem;
        private System.Windows.Forms.ToolStripButton bindNavPreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep;
        private System.Windows.Forms.ToolStripTextBox bindNavPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindNavNextItem;
        private System.Windows.Forms.ToolStripButton bindNavLastItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep2;
        private System.Windows.Forms.BindingSource bindSourcePublicaciones;
        private System.Windows.Forms.ToolStripButton toolStripButton1;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.GroupBox gBoxFiltros;
        private System.Windows.Forms.Label lblDescripcion;
        private System.Windows.Forms.TextBox txtDescripcion;
        private System.Windows.Forms.Label lblRubros;
        private System.Windows.Forms.ComboBox cmbBoxRubros;
        private System.Windows.Forms.Button btnVer;
    }
}
