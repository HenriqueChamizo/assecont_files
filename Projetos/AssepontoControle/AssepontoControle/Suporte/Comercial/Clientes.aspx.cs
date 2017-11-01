using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asseponto.Suporte.Comercial
{
    public partial class Clientes : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["datainicial"]))
            {
                string MonthYear = DateTime.Now.ToString("/MM/yyyy");
                Response.Redirect("~/Suporte/Comercial/Clientes.aspx?datainicial=01" + MonthYear + 
                                        "&datafinal=" + DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString() + MonthYear);
            }
            bd = new BDApp();
            user = new UserApp();
        }

        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            string[] split = btn.Text.Split(new String[] { ": " }, StringSplitOptions.None);
            string query = "UPDATE AssepontoClientesComercial SET COM_FECHADOPOR = {0}, COM_FECHADOEM = GETDATE() WHERE COM_IND = {1}";
            query = string.Format(query, UserApp.UserId, Convert.ToInt32(split[1]));
            bd.executeCommand(query);
            Response.Redirect("~/Suporte/Comercial/Clientes.aspx");
        }

        protected void ckbFechado_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string fechado = Request.QueryString["FECHADO"];
                if (string.IsNullOrEmpty(fechado) || fechado == "0")
                    ckbFechado.Checked = false;
                else
                    ckbFechado.Checked = true;
            }
            ckbFechado.CssClass = "ckbFechado";
            ckbFechado.CheckedChanged += ckbFechado_CheckedChanged;
            ckbFechado.AutoPostBack = true;
            ckbFechado.DataBind();
        }

        protected void ckbFechado_CheckedChanged(object sender, EventArgs e)
        {
            string fechado = Request.QueryString["fechado"];
            string Query = Request.QueryString.ToString();
            if (string.IsNullOrEmpty(fechado))
            {
                Response.Redirect("~/Suporte/Comercial/Clientes.aspx?" + Query + "&fechado=" + (ckbFechado.Checked ? "1" : "0"));
            }
            else
            {
                Response.Redirect("~/Suporte/Comercial/Clientes.aspx?" + Query.Replace("&fechado=" + fechado, "&fechado=" + (ckbFechado.Checked ? "1" : "0")));
            }
        }
    }
}