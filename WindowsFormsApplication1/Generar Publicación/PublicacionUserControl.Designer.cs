namespace ME.UI
{
    partial class PublicacionesUserControl
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PublicacionesUserControl));
            this.gvPublicaciones = new System.Windows.Forms.DataGridView();
            this.btnNewPublicacion = new System.Windows.Forms.Button();
            this.btnEditPublicacion = new System.Windows.Forms.Button();
            this.btnRemovePublicacion = new System.Windows.Forms.Button();
            this.bindingNav1 = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindNavSep2 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingNav1)).BeginInit();
            this.bindingNav1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
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
            this.gvPublicaciones.Location = new System.Drawing.Point(3, 28);
            this.gvPublicaciones.Name = "gvPublicaciones";
            this.gvPublicaciones.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvPublicaciones.Size = new System.Drawing.Size(797, 423);
            this.gvPublicaciones.TabIndex = 0;
            this.gvPublicaciones.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvClientes_RowEnter);
            this.gvPublicaciones.SelectionChanged += new System.EventHandler(this.gvClientes_SelectionChanged);
            // 
            // btnNewPublicacion
            // 
            this.btnNewPublicacion.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnNewPublicacion.Location = new System.Drawing.Point(663, 467);
            this.btnNewPublicacion.Name = "btnNewPublicacion";
            this.btnNewPublicacion.Size = new System.Drawing.Size(137, 23);
            this.btnNewPublicacion.TabIndex = 1;
            this.btnNewPublicacion.Text = "Nueva Publicación";
            this.btnNewPublicacion.UseVisualStyleBackColor = true;
            this.btnNewPublicacion.Click += new System.EventHandler(this.button1_Click);
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
            this.btnEditPublicacion.Click += new System.EventHandler(this.btnEditUser_Click);
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
            // bindingNav1
            // 
            this.bindingNav1.AddNewItem = null;
            this.bindingNav1.CountItem = this.bindingNavigatorCountItem;
            this.bindingNav1.DeleteItem = null;
            this.bindingNav1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindNavSep,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindNavSep2});
            this.bindingNav1.Location = new System.Drawing.Point(0, 0);
            this.bindingNav1.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
            this.bindingNav1.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bindingNav1.MoveNextItem = this.bindingNavigatorMoveNextItem;
            this.bindingNav1.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
            this.bindingNav1.Name = "bindingNav1";
            this.bindingNav1.PositionItem = this.bindingNavigatorPositionItem;
            this.bindingNav1.Size = new System.Drawing.Size(803, 25);
            this.bindingNav1.TabIndex = 4;
            this.bindingNav1.Text = "bindingNavigator1";
            // 
            // bindingNavigatorCountItem
            // 
            this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
            this.bindingNavigatorCountItem.Size = new System.Drawing.Size(37, 22);
            this.bindingNavigatorCountItem.Text = "de {0}";
            this.bindingNavigatorCountItem.ToolTipText = "Total number of items";
            // 
            // bindingNavigatorMoveFirstItem
            // 
            this.bindingNavigatorMoveFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveFirstItem.Image")));
            this.bindingNavigatorMoveFirstItem.Name = "bindingNavigatorMoveFirstItem";
            this.bindingNavigatorMoveFirstItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveFirstItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveFirstItem.Text = "Move first";
            // 
            // bindingNavigatorMovePreviousItem
            // 
            this.bindingNavigatorMovePreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMovePreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMovePreviousItem.Image")));
            this.bindingNavigatorMovePreviousItem.Name = "bindingNavigatorMovePreviousItem";
            this.bindingNavigatorMovePreviousItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMovePreviousItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMovePreviousItem.Text = "Move previous";
            // 
            // bindNavSep
            // 
            this.bindNavSep.Name = "bindNavSep";
            this.bindNavSep.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorPositionItem
            // 
            this.bindingNavigatorPositionItem.AccessibleName = "Position";
            this.bindingNavigatorPositionItem.AutoSize = false;
            this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
            this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(50, 23);
            this.bindingNavigatorPositionItem.Text = "0";
            this.bindingNavigatorPositionItem.ToolTipText = "Current position";
            // 
            // bindingNavigatorSeparator1
            // 
            this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator1";
            this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorMoveNextItem
            // 
            this.bindingNavigatorMoveNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveNextItem.Image")));
            this.bindingNavigatorMoveNextItem.Name = "bindingNavigatorMoveNextItem";
            this.bindingNavigatorMoveNextItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveNextItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveNextItem.Text = "Move next";
            // 
            // bindingNavigatorMoveLastItem
            // 
            this.bindingNavigatorMoveLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveLastItem.Image")));
            this.bindingNavigatorMoveLastItem.Name = "bindingNavigatorMoveLastItem";
            this.bindingNavigatorMoveLastItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveLastItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveLastItem.Text = "Move last";
            // 
            // bindNavSep2
            // 
            this.bindNavSep2.Name = "bindNavSep2";
            this.bindNavSep2.Size = new System.Drawing.Size(6, 25);
            // 
            // PublicacionesUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.bindingNav1);
            this.Controls.Add(this.btnRemovePublicacion);
            this.Controls.Add(this.btnEditPublicacion);
            this.Controls.Add(this.btnNewPublicacion);
            this.Controls.Add(this.gvPublicaciones);
            this.Name = "PublicacionesUserControl";
            this.Size = new System.Drawing.Size(803, 500);
            this.Load += new System.EventHandler(this.UsuariosUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvPublicaciones)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingNav1)).EndInit();
            this.bindingNav1.ResumeLayout(false);
            this.bindingNav1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gvPublicaciones;
        private System.Windows.Forms.Button btnNewPublicacion;
        private System.Windows.Forms.Button btnEditPublicacion;
        private System.Windows.Forms.Button btnRemovePublicacion;
        private System.Windows.Forms.BindingNavigator bindingNav1;
        private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator bindNavSep2;
        private System.Windows.Forms.BindingSource bindingSource1;
    }
}
