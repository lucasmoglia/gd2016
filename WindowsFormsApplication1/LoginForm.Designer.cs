﻿namespace ME.UI
{
    partial class LoginForm
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.txtUser = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lblTitle = new System.Windows.Forms.Label();
            this.btnLogin = new System.Windows.Forms.Button();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtUser
            // 
            this.txtUser.Location = new System.Drawing.Point(43, 140);
            this.txtUser.Name = "txtUser";
            this.txtUser.Size = new System.Drawing.Size(271, 20);
            this.txtUser.TabIndex = 0;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lblTitle);
            this.panel1.Controls.Add(this.btnLogin);
            this.panel1.Controls.Add(this.txtPassword);
            this.panel1.Controls.Add(this.txtUser);
            this.panel1.Location = new System.Drawing.Point(252, 127);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(356, 309);
            this.panel1.TabIndex = 1;
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTitle.Location = new System.Drawing.Point(82, 64);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(187, 31);
            this.lblTitle.TabIndex = 3;
            this.lblTitle.Text = "MercadoEnvío";
            this.lblTitle.Click += new System.EventHandler(this.label1_Click);
            // 
            // btnLogin
            // 
            this.btnLogin.Location = new System.Drawing.Point(43, 236);
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.Size = new System.Drawing.Size(271, 23);
            this.btnLogin.TabIndex = 2;
            this.btnLogin.Text = "Ingresar";
            this.btnLogin.UseVisualStyleBackColor = true;
            this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
            // 
            // txtPassword
            // 
            this.txtPassword.Location = new System.Drawing.Point(43, 184);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.Size = new System.Drawing.Size(271, 20);
            this.txtPassword.TabIndex = 1;
            this.txtPassword.UseSystemPasswordChar = true;
            // 
            // LoginForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(862, 476);
            this.Controls.Add(this.panel1);
            this.Name = "LoginForm";
            this.Text = "MercadoEnvío";
            this.Load += new System.EventHandler(this.LoginForm_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox txtUser;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btnLogin;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.Label lblTitle;
    }
}

