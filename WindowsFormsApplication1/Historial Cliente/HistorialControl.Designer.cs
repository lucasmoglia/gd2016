namespace ME.UI
{
    partial class HistorialControl
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(HistorialControl));
            this.bindingNavigator1 = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.gbComprasPorUsuario = new System.Windows.Forms.GroupBox();
            this.gvComprasUsuario = new System.Windows.Forms.DataGridView();
            this.gvHistorial = new System.Windows.Forms.DataGridView();
            this.gbHistorial = new System.Windows.Forms.GroupBox();
            this.gbFiltros = new System.Windows.Forms.GroupBox();
            this.rb1 = new System.Windows.Forms.RadioButton();
            this.rb2 = new System.Windows.Forms.RadioButton();
            this.rb3 = new System.Windows.Forms.RadioButton();
            this.rb4 = new System.Windows.Forms.RadioButton();
            this.gbReputacion = new System.Windows.Forms.GroupBox();
            this.lbl1 = new System.Windows.Forms.Label();
            this.lblUser = new System.Windows.Forms.Label();
            this.lbl2 = new System.Windows.Forms.Label();
            this.lblRepu = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.bindingNavigator1)).BeginInit();
            this.bindingNavigator1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
            this.gbComprasPorUsuario.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasUsuario)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvHistorial)).BeginInit();
            this.gbHistorial.SuspendLayout();
            this.gbFiltros.SuspendLayout();
            this.gbReputacion.SuspendLayout();
            this.SuspendLayout();
            // 
            // bindingNavigator1
            // 
            this.bindingNavigator1.AddNewItem = null;
            this.bindingNavigator1.CountItem = this.bindingNavigatorCountItem;
            this.bindingNavigator1.DeleteItem = null;
            this.bindingNavigator1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindingNavigatorSeparator,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindingNavigatorSeparator2});
            this.bindingNavigator1.Location = new System.Drawing.Point(0, 0);
            this.bindingNavigator1.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
            this.bindingNavigator1.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bindingNavigator1.MoveNextItem = this.bindingNavigatorMoveNextItem;
            this.bindingNavigator1.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
            this.bindingNavigator1.Name = "bindingNavigator1";
            this.bindingNavigator1.PositionItem = this.bindingNavigatorPositionItem;
            this.bindingNavigator1.Size = new System.Drawing.Size(831, 25);
            this.bindingNavigator1.TabIndex = 4;
            this.bindingNavigator1.Text = "bindingNavigator1";
            // 
            // bindingNavigatorCountItem
            // 
            this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
            this.bindingNavigatorCountItem.Size = new System.Drawing.Size(35, 22);
            this.bindingNavigatorCountItem.Text = "of {0}";
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
            // bindingNavigatorSeparator
            // 
            this.bindingNavigatorSeparator.Name = "bindingNavigatorSeparator";
            this.bindingNavigatorSeparator.Size = new System.Drawing.Size(6, 25);
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
            // bindingNavigatorSeparator2
            // 
            this.bindingNavigatorSeparator2.Name = "bindingNavigatorSeparator2";
            this.bindingNavigatorSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // gbComprasPorUsuario
            // 
            this.gbComprasPorUsuario.Controls.Add(this.gvComprasUsuario);
            this.gbComprasPorUsuario.Location = new System.Drawing.Point(8, 359);
            this.gbComprasPorUsuario.Name = "gbComprasPorUsuario";
            this.gbComprasPorUsuario.Size = new System.Drawing.Size(820, 72);
            this.gbComprasPorUsuario.TabIndex = 5;
            this.gbComprasPorUsuario.TabStop = false;
            this.gbComprasPorUsuario.Text = "Totales De Compras Por Usuario";
            // 
            // gvComprasUsuario
            // 
            this.gvComprasUsuario.AllowUserToAddRows = false;
            this.gvComprasUsuario.AllowUserToDeleteRows = false;
            this.gvComprasUsuario.BackgroundColor = System.Drawing.SystemColors.ButtonFace;
            this.gvComprasUsuario.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.gvComprasUsuario.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvComprasUsuario.Location = new System.Drawing.Point(5, 20);
            this.gvComprasUsuario.Name = "gvComprasUsuario";
            this.gvComprasUsuario.ReadOnly = true;
            this.gvComprasUsuario.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders;
            this.gvComprasUsuario.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.gvComprasUsuario.Size = new System.Drawing.Size(806, 44);
            this.gvComprasUsuario.TabIndex = 0;
            // 
            // gvHistorial
            // 
            this.gvHistorial.AllowUserToAddRows = false;
            this.gvHistorial.AllowUserToDeleteRows = false;
            this.gvHistorial.AllowUserToOrderColumns = true;
            this.gvHistorial.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            this.gvHistorial.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvHistorial.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gvHistorial.Location = new System.Drawing.Point(5, 21);
            this.gvHistorial.Name = "gvHistorial";
            this.gvHistorial.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders;
            this.gvHistorial.RowTemplate.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.gvHistorial.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvHistorial.ShowEditingIcon = false;
            this.gvHistorial.Size = new System.Drawing.Size(809, 244);
            this.gvHistorial.TabIndex = 0;
            // 
            // gbHistorial
            // 
            this.gbHistorial.Controls.Add(this.gvHistorial);
            this.gbHistorial.Location = new System.Drawing.Point(8, 77);
            this.gbHistorial.Name = "gbHistorial";
            this.gbHistorial.Size = new System.Drawing.Size(820, 276);
            this.gbHistorial.TabIndex = 6;
            this.gbHistorial.TabStop = false;
            this.gbHistorial.Text = "Compras y Ofertas del Usuario";
            // 
            // gbFiltros
            // 
            this.gbFiltros.Controls.Add(this.rb4);
            this.gbFiltros.Controls.Add(this.rb3);
            this.gbFiltros.Controls.Add(this.rb2);
            this.gbFiltros.Controls.Add(this.rb1);
            this.gbFiltros.Location = new System.Drawing.Point(429, 28);
            this.gbFiltros.Name = "gbFiltros";
            this.gbFiltros.Size = new System.Drawing.Size(399, 43);
            this.gbFiltros.TabIndex = 7;
            this.gbFiltros.TabStop = false;
            this.gbFiltros.Text = "Filtros";
            // 
            // rb1
            // 
            this.rb1.AutoSize = true;
            this.rb1.Location = new System.Drawing.Point(11, 17);
            this.rb1.Name = "rb1";
            this.rb1.Size = new System.Drawing.Size(55, 17);
            this.rb1.TabIndex = 0;
            this.rb1.TabStop = true;
            this.rb1.Text = "Todas";
            this.rb1.UseVisualStyleBackColor = true;
            // 
            // rb2
            // 
            this.rb2.AutoSize = true;
            this.rb2.Location = new System.Drawing.Point(72, 17);
            this.rb2.Name = "rb2";
            this.rb2.Size = new System.Drawing.Size(110, 17);
            this.rb2.TabIndex = 1;
            this.rb2.TabStop = true;
            this.rb2.Text = "Compra Inmediata";
            this.rb2.UseVisualStyleBackColor = true;
            // 
            // rb3
            // 
            this.rb3.AutoSize = true;
            this.rb3.Location = new System.Drawing.Point(188, 17);
            this.rb3.Name = "rb3";
            this.rb3.Size = new System.Drawing.Size(69, 17);
            this.rb3.TabIndex = 2;
            this.rb3.TabStop = true;
            this.rb3.Text = "Subastas";
            this.rb3.UseVisualStyleBackColor = true;
            // 
            // rb4
            // 
            this.rb4.AutoSize = true;
            this.rb4.Location = new System.Drawing.Point(263, 17);
            this.rb4.Name = "rb4";
            this.rb4.Size = new System.Drawing.Size(124, 17);
            this.rb4.TabIndex = 3;
            this.rb4.TabStop = true;
            this.rb4.Text = "Compras Sin Calificar";
            this.rb4.UseVisualStyleBackColor = true;
            // 
            // gbReputacion
            // 
            this.gbReputacion.Controls.Add(this.lblRepu);
            this.gbReputacion.Controls.Add(this.lbl2);
            this.gbReputacion.Controls.Add(this.lblUser);
            this.gbReputacion.Controls.Add(this.lbl1);
            this.gbReputacion.Location = new System.Drawing.Point(8, 28);
            this.gbReputacion.Name = "gbReputacion";
            this.gbReputacion.Size = new System.Drawing.Size(399, 43);
            this.gbReputacion.TabIndex = 8;
            this.gbReputacion.TabStop = false;
            this.gbReputacion.Text = "Usuario";
            // 
            // lbl1
            // 
            this.lbl1.AutoSize = true;
            this.lbl1.Location = new System.Drawing.Point(8, 19);
            this.lbl1.Name = "lbl1";
            this.lbl1.Size = new System.Drawing.Size(63, 13);
            this.lbl1.TabIndex = 0;
            this.lbl1.Text = "UserName: ";
            // 
            // lblUser
            // 
            this.lblUser.AutoSize = true;
            this.lblUser.Location = new System.Drawing.Point(80, 19);
            this.lblUser.Name = "lblUser";
            this.lblUser.Size = new System.Drawing.Size(57, 13);
            this.lblUser.TabIndex = 1;
            this.lblUser.Text = "UserName";
            // 
            // lbl2
            // 
            this.lbl2.AutoSize = true;
            this.lbl2.Location = new System.Drawing.Point(246, 19);
            this.lbl2.Name = "lbl2";
            this.lbl2.Size = new System.Drawing.Size(68, 13);
            this.lbl2.TabIndex = 2;
            this.lbl2.Text = "Reputación: ";
            // 
            // lblRepu
            // 
            this.lblRepu.AutoSize = true;
            this.lblRepu.Location = new System.Drawing.Point(323, 19);
            this.lblRepu.Name = "lblRepu";
            this.lblRepu.Size = new System.Drawing.Size(57, 13);
            this.lblRepu.TabIndex = 3;
            this.lblRepu.Text = "reputacion";
            // 
            // HistorialControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.gbReputacion);
            this.Controls.Add(this.gbFiltros);
            this.Controls.Add(this.gbComprasPorUsuario);
            this.Controls.Add(this.bindingNavigator1);
            this.Controls.Add(this.gbHistorial);
            this.Name = "HistorialControl";
            this.Size = new System.Drawing.Size(831, 500);
            ((System.ComponentModel.ISupportInitialize)(this.bindingNavigator1)).EndInit();
            this.bindingNavigator1.ResumeLayout(false);
            this.bindingNavigator1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
            this.gbComprasPorUsuario.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gvComprasUsuario)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvHistorial)).EndInit();
            this.gbHistorial.ResumeLayout(false);
            this.gbFiltros.ResumeLayout(false);
            this.gbFiltros.PerformLayout();
            this.gbReputacion.ResumeLayout(false);
            this.gbReputacion.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.BindingNavigator bindingNavigator1;
        private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator2;
        private System.Windows.Forms.BindingSource bindingSource1;
        private System.Windows.Forms.GroupBox gbComprasPorUsuario;
        private System.Windows.Forms.DataGridView gvComprasUsuario;
        private System.Windows.Forms.DataGridView gvHistorial;
        private System.Windows.Forms.GroupBox gbHistorial;
        private System.Windows.Forms.GroupBox gbFiltros;
        private System.Windows.Forms.RadioButton rb4;
        private System.Windows.Forms.RadioButton rb3;
        private System.Windows.Forms.RadioButton rb2;
        private System.Windows.Forms.RadioButton rb1;
        private System.Windows.Forms.GroupBox gbReputacion;
        private System.Windows.Forms.Label lblRepu;
        private System.Windows.Forms.Label lbl2;
        private System.Windows.Forms.Label lblUser;
        private System.Windows.Forms.Label lbl1;
    }
}
