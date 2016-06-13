namespace ME.UI
{
    partial class RolUserControl
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
            this.gvRoles = new System.Windows.Forms.DataGridView();
            this.btnRemoveRol = new System.Windows.Forms.Button();
            this.btnEditRol = new System.Windows.Forms.Button();
            this.btnNuevoRol = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.gvRoles)).BeginInit();
            this.SuspendLayout();
            // 
            // gvRoles
            // 
            this.gvRoles.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvRoles.Location = new System.Drawing.Point(3, 109);
            this.gvRoles.Name = "gvRoles";
            this.gvRoles.Size = new System.Drawing.Size(794, 324);
            this.gvRoles.TabIndex = 0;
            // 
            // btnRemoveRol
            // 
            this.btnRemoveRol.BackColor = System.Drawing.Color.DarkRed;
            this.btnRemoveRol.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnRemoveRol.Location = new System.Drawing.Point(72, 80);
            this.btnRemoveRol.Name = "btnRemoveRol";
            this.btnRemoveRol.Size = new System.Drawing.Size(63, 23);
            this.btnRemoveRol.TabIndex = 5;
            this.btnRemoveRol.Text = "Borrar";
            this.btnRemoveRol.UseVisualStyleBackColor = false;
            this.btnRemoveRol.Visible = false;
            // 
            // btnEditRol
            // 
            this.btnEditRol.BackColor = System.Drawing.Color.LimeGreen;
            this.btnEditRol.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnEditRol.Location = new System.Drawing.Point(3, 80);
            this.btnEditRol.Name = "btnEditRol";
            this.btnEditRol.Size = new System.Drawing.Size(63, 23);
            this.btnEditRol.TabIndex = 4;
            this.btnEditRol.Text = "Editar";
            this.btnEditRol.UseVisualStyleBackColor = false;
            this.btnEditRol.Visible = false;
            // 
            // btnNuevoRol
            // 
            this.btnNuevoRol.Location = new System.Drawing.Point(721, 80);
            this.btnNuevoRol.Name = "btnNuevoRol";
            this.btnNuevoRol.Size = new System.Drawing.Size(75, 23);
            this.btnNuevoRol.TabIndex = 6;
            this.btnNuevoRol.Text = "Nuevo Rol";
            this.btnNuevoRol.UseVisualStyleBackColor = true;
            this.btnNuevoRol.Click += new System.EventHandler(this.btnNuevoRol_Click);
            // 
            // RolUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnNuevoRol);
            this.Controls.Add(this.btnRemoveRol);
            this.Controls.Add(this.btnEditRol);
            this.Controls.Add(this.gvRoles);
            this.Name = "RolUserControl";
            this.Size = new System.Drawing.Size(800, 500);
            this.Load += new System.EventHandler(this.RolUserControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gvRoles)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView gvRoles;
        private System.Windows.Forms.Button btnRemoveRol;
        private System.Windows.Forms.Button btnEditRol;
        private System.Windows.Forms.Button btnNuevoRol;
    }
}
