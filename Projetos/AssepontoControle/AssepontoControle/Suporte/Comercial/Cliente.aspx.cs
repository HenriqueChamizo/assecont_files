using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.Suporte.Comercial
{
    public partial class Cliente : System.Web.UI.Page
    {
        BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ind"]))
            {
                bd = new BDApp();
                lbTitulo.Text = bd.getFieldValueString("SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes where CAD_IND = " +
                    Convert.ToInt32(Request.QueryString["ind"]));
                lbTitulo.Style.Add("font-size", "25pt");
                lbTitulo.Style.Add("font-family", "Segoe UI");
                lbTitulo.Style.Add("letter-spacing", "1px");
                lbTitulo.Style.Add("color", "#1A4C83");
                radListClieComercial.Style.Add("margin-top", "15px");
            }
            else
                Response.Redirect("~/Suporte/");
        }
    }
}