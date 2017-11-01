using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;
using Asseponto.Classes;
using System.Data;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RevendaPedidosPeriodo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            lbTitulo.Text = bd.getFieldValueString("SELECT REV_RAZAOSOCIAL FROM ASSEPONTOREVENDAS WHERE REV_IND = " + Request.QueryString["REVIND"]);
            lbTitulo.Style.Add("font-size", "25pt");
            lbTitulo.Style.Add("font-family", "Segoe UI");
            lbTitulo.Style.Add("letter-spacing", "1px");
            lbTitulo.Style.Add("color", "#1A4C83");
        }

        protected void ListRevendas_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Response.Redirect("~/Suporte/Relatorios/RevendaPedidosPeriodo.aspx?DATAINICIAL=" + Request.QueryString["DATAINICIAL"] + 
                                                                     "&DATAFINAL=" + Request.QueryString["DATAFINAL"] + 
                                                                     "&REP=" + Request.QueryString["REP"] + 
                                                                     "&REVIND=" + e.Value);
        }

        protected void ListReps_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Response.Redirect("~/Suporte/Relatorios/RevendaPedidosPeriodo.aspx?DATAINICIAL=" + Request.QueryString["DATAINICIAL"] +
                                                                        "&DATAFINAL=" + Request.QueryString["DATAFINAL"] +
                                                                        "&REP=" + e.Value +
                                                                        "&REVIND=" + Request.QueryString["REVIND"]);
        }
    }
}