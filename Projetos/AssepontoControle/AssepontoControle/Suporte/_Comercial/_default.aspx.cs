using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Suporte.Comercial
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PanelProposta.Visible = false;
        }

        protected void lkProposta_Click(object sender, EventArgs e)
        {
            PanelProposta.Visible = true;
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (txtContato.Text.Trim() != "" && txtEmailProposta.Text.Trim() != "")
            {
                BDApp bd = new BDApp();
                if (RadDatePicker1.SelectedDate.Value.ToString().Trim() == "")
                {
                    bd.executeCommand(string.Format("INSERT INTO AssepontoProposta (PROP_CLIENTE, PROP_CONTATO, PROP_EMAIL, GETDATE()) VALUES ('{0}', '{1}', '{2}', '{3}')", ind, txtContato.Text, txtEmailProposta.Text));
                }
                else
                {
                    bd.executeCommand(string.Format("INSERT INTO AssepontoProposta (PROP_CLIENTE, PROP_CONTATO, PROP_EMAIL, PROP_DATA_ENVIO) VALUES ('{0}', '{1}', '{2}', '{3}')", ind, txtContato.Text, txtEmailProposta.Text, RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy")));
                }

            }

            if (FormComercial.CurrentMode == FormViewMode.Edit)
                FormComercial.UpdateItem(((LinkButton)sender).CausesValidation);
        }

        protected void sqlClientes_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            Response.Redirect(string.Format("~/suporte/Clientes/Cliente.aspx?ind={0}", ind));
        }

        protected void FormComercial_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }
    }
}