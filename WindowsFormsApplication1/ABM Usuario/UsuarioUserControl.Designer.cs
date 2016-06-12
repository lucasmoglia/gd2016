namespace ME.UI
{
    partial class UsuarioUserControl
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
            this.gvClientes = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.btnEditUser = new System.Windows.Forms.Button();
            this.btnRemoveUser = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.gvClientes)).BeginInit();
            this.SuspendLayout();
            // 
            // gvClientes
            // 
            this.gvClientes.AllowUserToAddRows = false;
            this.gvClientes.AllowUserToDeleteRows = false;
            this.gvClientes.AllowUserToOrderColumns = true;
            this.gvClientes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvClientes.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.gvClientes.Location = new System.Drawing.Point(31, 91);
            this.gvClientes.Name = "gvClientes";
            this.gvClientes.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gvClientes.Size = new System.Drawing.Size(746, 346);
            this.gvClientes.TabIndex = 0;
            this.gvClientes.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvClientes_RowEnter);
            this.gvClientes.SelectionChanged += new System.EventHandler(this.gvClientes_SelectionChanged);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(640, 62);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(137, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Nuevo Usuario";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // btnEditUser
            // 
            this.btnEditUser.BackColor = System.Drawing.Color.LimeGreen;
            this.btnEditUser.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnEditUser.Location = new System.Drawing.Point(31, 62);
            this.btnEditUser.Name = "btnEditUser";
            this.btnEditUser.Size = new System.Drawing.Size(63, 23);
            this.btnEditUser.TabIndex = 2;
            this.btnEditUser.Text = "Editar";
            this.btnEditUser.UseVisualStyleBackColor = false;
            this.btnEditUser.Visible = false;
            this.btnEditUser.Click += new System.EventHandler(this.btnEditUser_Click);
            // 
            // btnRemoveUser
            // 
            this.btnRemoveUser.BackColor = System.Drawing.Color.DarkRed;
            this.btnRemoveUser.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnRemoveUser.Location = new System.Drawing.Point(100, 62);
            this.btnRemoveUser.Name = "btnRemoveUser";
            this.btnRemoveUser.Size = new System.Drawing.Size(63, 23);
            this.btnRemoveUser.TabIndex = 3;
            this.btnRemoveUser.Text = "Borrar";
            this.btnRemoveUser.UseVisualStyleBackColor = false;
            this.btnRemoveUser.Visible = false;
            // 
            // UsuarioUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnRemoveUser);
            this.Controls.Add(this.btnEditUser);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.gvClientes);
            this.Name = "UsuarioUserControl";
            this.Size = new System.Drawing.Size(800, 500);
            this.Load += new System.EventHandler(this.UsuariosUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvClientes)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView gvClientes;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button btnEditUser;
        private System.Windows.Forms.Button btnRemoveUser;
    }
}
