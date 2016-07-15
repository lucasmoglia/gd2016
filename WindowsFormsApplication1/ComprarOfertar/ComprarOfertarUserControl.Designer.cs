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
            this.bindNavPubli = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindSourcePubli = new System.Windows.Forms.BindingSource(this.components);
            this.bindNavCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindNavFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavPreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep = new System.Windows.Forms.ToolStripSeparator();
            this.bindNavPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindNavNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep2 = new System.Windows.Forms.ToolStripSeparator();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.gBoxFiltros = new System.Windows.Forms.GroupBox();
            this.lblRubros = new System.Windows.Forms.Label();
            this.txtDescripcion = new System.Windows.Forms.TextBox();
            this.lblDescripcion = new System.Windows.Forms.Label();
            this.btnVer = new System.Windows.Forms.Button();
            this.lstRubros = new System.Windows.Forms.ListBox();
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindNavPubli)).BeginInit();
            this.bindNavPubli.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindSourcePubli)).BeginInit();
            this.gBoxFiltros.SuspendLayout();
            this.SuspendLayout();
            // 
            // gvPublicaciones
            // 
            this.gvPublicaciones.AllowUserToAddRows = false;
            this.gvPublicaciones.AllowUserToDeleteRows = false;
            this.gvPublicaciones.AllowUserToOrderColumns = true;
            this.gvPublicaciones.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.DisplayedCellsExceptHeader;
            this.gvPublicaciones.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvPublicaciones.Cursor = System.Windows.Forms.Cursors.Hand;
            this.gvPublicaciones.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gvPublicaciones.Location = new System.Drawing.Point(3, 145);
            this.gvPublicaciones.MultiSelect = false;
            this.gvPublicaciones.Name = "gvPublicaciones";
            this.gvPublicaciones.RowHeadersVisible = false;
            this.gvPublicaciones.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvPublicaciones.Size = new System.Drawing.Size(835, 261);
            this.gvPublicaciones.TabIndex = 0;
            this.gvPublicaciones.CellContentDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvPublicaciones_CellContentDoubleClick);
            this.gvPublicaciones.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvPublicaciones_RowEnter);
            // 
            // btnComprar
            // 
            this.btnComprar.FlatAppearance.BorderColor = System.Drawing.Color.Blue;
            this.btnComprar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnComprar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnComprar.Location = new System.Drawing.Point(694, 411);
            this.btnComprar.Name = "btnComprar";
            this.btnComprar.Size = new System.Drawing.Size(137, 23);
            this.btnComprar.TabIndex = 1;
            this.btnComprar.Text = "Comprar / Ofertar";
            this.btnComprar.UseVisualStyleBackColor = true;
            this.btnComprar.Click += new System.EventHandler(this.btnComprar_Click);
            // 
            // bindNavPubli
            // 
            this.bindNavPubli.AddNewItem = null;
            this.bindNavPubli.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.bindNavPubli.BindingSource = this.bindSourcePubli;
            this.bindNavPubli.CountItem = this.bindNavCountItem;
            this.bindNavPubli.DeleteItem = null;
            this.bindNavPubli.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindNavFirstItem,
            this.bindNavPreviousItem,
            this.bindNavSep,
            this.bindNavPositionItem,
            this.bindNavCountItem,
            this.bindingNavigatorSeparator1,
            this.bindNavNextItem,
            this.bindNavLastItem,
            this.bindNavSep2});
            this.bindNavPubli.Location = new System.Drawing.Point(0, 0);
            this.bindNavPubli.MoveFirstItem = this.bindNavFirstItem;
            this.bindNavPubli.MoveLastItem = this.bindNavLastItem;
            this.bindNavPubli.MoveNextItem = this.bindNavNextItem;
            this.bindNavPubli.MovePreviousItem = this.bindNavPreviousItem;
            this.bindNavPubli.Name = "bindNavPubli";
            this.bindNavPubli.PositionItem = this.bindNavPositionItem;
            this.bindNavPubli.Size = new System.Drawing.Size(841, 25);
            this.bindNavPubli.TabIndex = 4;
            this.bindNavPubli.Text = "Barra de Navegación";
            this.bindNavPubli.RefreshItems += new System.EventHandler(this.bindNavPubli_RefreshItems);
            // 
            // bindNavCountItem
            // 
            this.bindNavCountItem.Name = "bindNavCountItem";
            this.bindNavCountItem.Size = new System.Drawing.Size(35, 22);
            this.bindNavCountItem.Text = "of {0}";
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
            this.bindNavNextItem.Click += new System.EventHandler(this.bindNavNextItem_Click);
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
            // btnLimpiar
            // 
            this.btnLimpiar.Location = new System.Drawing.Point(3, 117);
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
            this.btnBuscar.Location = new System.Drawing.Point(721, 117);
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
            this.gBoxFiltros.Controls.Add(this.txtDescripcion);
            this.gBoxFiltros.Controls.Add(this.lblDescripcion);
            this.gBoxFiltros.ForeColor = System.Drawing.SystemColors.HotTrack;
            this.gBoxFiltros.Location = new System.Drawing.Point(3, 27);
            this.gBoxFiltros.Name = "gBoxFiltros";
            this.gBoxFiltros.Size = new System.Drawing.Size(835, 84);
            this.gBoxFiltros.TabIndex = 7;
            this.gBoxFiltros.TabStop = false;
            this.gBoxFiltros.Text = "Filtros de Búsqueda";
            // 
            // lblRubros
            // 
            this.lblRubros.AutoSize = true;
            this.lblRubros.ForeColor = System.Drawing.SystemColors.ControlText;
            this.lblRubros.Location = new System.Drawing.Point(431, 19);
            this.lblRubros.Name = "lblRubros";
            this.lblRubros.Size = new System.Drawing.Size(41, 13);
            this.lblRubros.TabIndex = 3;
            this.lblRubros.Text = "Rubros";
            // 
            // txtDescripcion
            // 
            this.txtDescripcion.ForeColor = System.Drawing.SystemColors.WindowFrame;
            this.txtDescripcion.Location = new System.Drawing.Point(78, 16);
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
            this.lblDescripcion.Location = new System.Drawing.Point(12, 19);
            this.lblDescripcion.Name = "lblDescripcion";
            this.lblDescripcion.Size = new System.Drawing.Size(63, 13);
            this.lblDescripcion.TabIndex = 0;
            this.lblDescripcion.Text = "Descripción";
            // 
            // btnVer
            // 
            this.btnVer.Location = new System.Drawing.Point(547, 411);
            this.btnVer.Name = "btnVer";
            this.btnVer.Size = new System.Drawing.Size(76, 23);
            this.btnVer.TabIndex = 8;
            this.btnVer.Text = "Ver";
            this.btnVer.UseVisualStyleBackColor = true;
            this.btnVer.Click += new System.EventHandler(this.btnVer_Click);
            // 
            // lstRubros
            // 
            this.lstRubros.FormattingEnabled = true;
            this.lstRubros.Location = new System.Drawing.Point(481, 36);
            this.lstRubros.Name = "lstRubros";
            this.lstRubros.SelectionMode = System.Windows.Forms.SelectionMode.MultiSimple;
            this.lstRubros.Size = new System.Drawing.Size(351, 69);
            this.lstRubros.TabIndex = 9;
            // 
            // ComprarOfertarUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.lstRubros);
            this.Controls.Add(this.btnVer);
            this.Controls.Add(this.gBoxFiltros);
            this.Controls.Add(this.btnBuscar);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.bindNavPubli);
            this.Controls.Add(this.btnComprar);
            this.Controls.Add(this.gvPublicaciones);
            this.Name = "ComprarOfertarUserControl";
            this.Size = new System.Drawing.Size(841, 437);
            this.Load += new System.EventHandler(this.ComprarOfertarUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindNavPubli)).EndInit();
            this.bindNavPubli.ResumeLayout(false);
            this.bindNavPubli.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindSourcePubli)).EndInit();
            this.gBoxFiltros.ResumeLayout(false);
            this.gBoxFiltros.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gvPublicaciones;
        private System.Windows.Forms.Button btnComprar;
        private System.Windows.Forms.BindingNavigator bindNavPubli;
        private System.Windows.Forms.ToolStripLabel bindNavCountItem;
        private System.Windows.Forms.ToolStripButton bindNavFirstItem;
        private System.Windows.Forms.ToolStripButton bindNavPreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep;
        private System.Windows.Forms.ToolStripTextBox bindNavPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindNavNextItem;
        private System.Windows.Forms.ToolStripButton bindNavLastItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep2;
        private System.Windows.Forms.BindingSource bindSourcePubli;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.GroupBox gBoxFiltros;
        private System.Windows.Forms.Label lblDescripcion;
        private System.Windows.Forms.TextBox txtDescripcion;
        private System.Windows.Forms.Label lblRubros;
        private System.Windows.Forms.Button btnVer;
        private System.Windows.Forms.ListBox lstRubros;
    }
}
