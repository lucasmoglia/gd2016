using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Business;
using ME.Data;

namespace ME.UI
{
    public partial class ClienteUserControl : UserControl
    {
        public ClienteUserControl()
        {
            InitializeComponent();
        }

        private void UsuariosUserControl_Load(object sender, EventArgs e)
        {
            gvClientes.DataSource = ClienteHandler.GetAll();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form nuevoUsuarioForm = new NuevoClienteForm();
            nuevoUsuarioForm.ShowDialog(this);
        }
    }
}
