using ME.Business;
using ME.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ME.UI
{
    public partial class NuevoRolForm : Form
    {
        //Recibo como parametro el codigo del rol que voy a editar en caso de edición.
        public NuevoRolForm(decimal? cod_rol)
        {
            InitializeComponent();
            lstFuncionalidadesAsignadas.DataSource = cod_rol.HasValue ? Funcionalidad.GetFuncionalidadesByRol(cod_rol.Value) : null;
            lstFuncionalidadesDisponibles.DataSource = Funcionalidad.GetFuncionalidades().Where(x => lstFuncionalidadesAsignadas.Items.IndexOf(x) < 0).ToList();
            lstFuncionalidadesDisponibles.DisplayMember = "descripcion";
            lstFuncionalidadesDisponibles.ValueMember = "cod_funcionalidad";
            lstFuncionalidadesAsignadas.DisplayMember = "descripcion";
            lstFuncionalidadesAsignadas.ValueMember = "cod_funcionalidad";
        }


        private void btnAgregarFuncionalidad_Click(object sender, EventArgs e)
        {
            if (lstFuncionalidadesDisponibles.SelectedIndex > -1)
            {
                List<FuncionalidadModel> list_disponibles = (List<FuncionalidadModel>)lstFuncionalidadesDisponibles.DataSource;
                List<FuncionalidadModel> list_asignadas = (List<FuncionalidadModel>)lstFuncionalidadesAsignadas.DataSource ?? new List<FuncionalidadModel>();
                list_asignadas.Add(list_disponibles[lstFuncionalidadesDisponibles.SelectedIndex]);
                list_disponibles.Remove(lstFuncionalidadesDisponibles.SelectedItem as FuncionalidadModel);

                lstFuncionalidadesDisponibles.DataSource = null;
                lstFuncionalidadesDisponibles.DataSource = list_disponibles;

                lstFuncionalidadesAsignadas.DataSource = null;
                lstFuncionalidadesAsignadas.DataSource = list_asignadas;
                lstFuncionalidadesDisponibles.DisplayMember = "descripcion";
                lstFuncionalidadesDisponibles.ValueMember = "cod_funcionalidad";
                lstFuncionalidadesAsignadas.DisplayMember = "descripcion";
                lstFuncionalidadesAsignadas.ValueMember = "cod_funcionalidad";
            }
        }

        private void btnQuitarFuncionalidad_Click(object sender, EventArgs e)
        {
            if (lstFuncionalidadesAsignadas.SelectedIndex > -1)
            {
                List<FuncionalidadModel> list_disponibles = (List<FuncionalidadModel>)lstFuncionalidadesDisponibles.DataSource;
                List<FuncionalidadModel> list_asignadas = (List<FuncionalidadModel>)lstFuncionalidadesAsignadas.DataSource ?? new List<FuncionalidadModel>();
                list_asignadas.Remove(list_asignadas[lstFuncionalidadesAsignadas.SelectedIndex]);
                list_disponibles.Add(lstFuncionalidadesAsignadas.SelectedItem as FuncionalidadModel);

                lstFuncionalidadesDisponibles.DataSource = null;
                lstFuncionalidadesDisponibles.DataSource = list_disponibles;

                lstFuncionalidadesAsignadas.DataSource = null;
                lstFuncionalidadesAsignadas.DataSource = list_asignadas;
                lstFuncionalidadesDisponibles.DisplayMember = "descripcion";
                lstFuncionalidadesDisponibles.ValueMember = "cod_funcionalidad";
                lstFuncionalidadesAsignadas.DisplayMember = "descripcion";
                lstFuncionalidadesAsignadas.ValueMember = "cod_funcionalidad";
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            RolesHandler.nuevo(txtNombre.Text, lstFuncionalidadesAsignadas.DataSource as List<FuncionalidadModel>);
        }
    }
}
