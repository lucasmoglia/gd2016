using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ME.Data;
using ME.Business;

namespace ME.UI
{
    public partial class ListadoEstadisticoUserControl : UserControl
    {
        public ListadoEstadisticoUserControl()
        {
            InitializeComponent();
            rbtMMF.Select();
            gvResult.DataSource = ListadoEstadisticoHandler.GetReporteVMMF(ddlMes.Text, ddlAnio.Text);
            gvResult.Refresh();
            lblMes.Text = "Mes";
            ddlMes.DataSource = new object[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
            lblExtra.Text = string.Empty;
            ddlExtra.Visible = false;
        }

        public void GetReporteVMMF(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlMes.Text) && !string.IsNullOrEmpty(ddlAnio.Text))
            {
                gvResult.DataSource = ListadoEstadisticoHandler.GetReporteVMMF(ddlMes.Text, ddlAnio.Text);
                gvResult.Refresh();
            }

            if (lblExtra.Text == "Rubro" || lblMes.Text == "Trimestre")
            {
                lblMes.Text = "Mes";
                ddlMes.DataSource = new object[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
                lblExtra.Text = string.Empty;
                ddlExtra.Visible = false;
            }
        }

        public void GetReporteVMCF(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlMes.Text) && !string.IsNullOrEmpty(ddlAnio.Text))
            {
                gvResult.DataSource = ListadoEstadisticoHandler.GetReporteVMCF(ddlMes.Text, ddlAnio.Text);
                gvResult.Refresh();
            }

            if (lblExtra.Text == "Rubro" || lblMes.Text == "Trimestre")
            {
                lblMes.Text = "Mes";
                ddlMes.DataSource = new object[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
                lblExtra.Text = string.Empty;
                ddlExtra.Visible = false;
            }
        }

        public void GetReporteCMCPC(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            if (!string.IsNullOrEmpty(ddlMes.Text) && !string.IsNullOrEmpty(ddlAnio.Text) && ddlExtra.SelectedValue != null && !string.IsNullOrEmpty(ddlExtra.SelectedValue.ToString()))
            {
                gvResult.DataSource = ListadoEstadisticoHandler.GetReporteCMCPC(ddlMes.Text, ddlAnio.Text, int.Parse(ddlExtra.SelectedValue.ToString()));
                gvResult.Refresh();
            }

            if (lblExtra.Text != "Rubro")
            {
                lblMes.Text = "Mes";
                ddlMes.DataSource = new object[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
                lblExtra.Text = "Rubro";
                ddlExtra.Visible = true;
                ddlExtra.DataSource = Rubro.GetRubros();
                ddlExtra.Refresh();
                ddlExtra.ValueMember = "cod_rubro";
                ddlExtra.DisplayMember = "desc_larga";
            }
        }

        public void GetReporteVMCPNV(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlMes.Text) && !string.IsNullOrEmpty(ddlAnio.Text) && !string.IsNullOrEmpty(ddlExtra.SelectedValue.ToString()))
            {
                gvResult.DataSource = ListadoEstadisticoHandler.GetReporteVMCPNV(ddlMes.Text, ddlAnio.Text, int.Parse(ddlExtra.SelectedValue.ToString()));
                gvResult.Refresh();
            }

            if (lblMes.Text != "Trimestre")
            {
                lblMes.Text = "Trimestre";
                ddlMes.DataSource = new object[] { "1", "2", "3", "4" };

                lblExtra.Text = "Visibilidad";
                ddlExtra.Visible = true;
                ddlExtra.DataSource = Visibilidad.GetVisibilidades();
                ddlExtra.Refresh();
                ddlExtra.ValueMember = "cod_visibilidad";
                ddlExtra.DisplayMember = "descripcion";
            }
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            RadioButton checkedButton = this.Controls["vistas"].Controls.OfType<RadioButton>().FirstOrDefault(r => r.Checked);
            checkedButton.PerformClick();
        }
    }
}
