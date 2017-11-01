using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asseponto.Revenda.Clientes
{
    public partial class Cliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int cliente = Convert.ToInt32(Request.QueryString["ind"]);
            RadMenu2.Items.FindItemByText("Histórico de Pendências").NavigateUrl = "~/Revenda/Clientes/Pendencias.aspx?cliente=" + Request.QueryString["ind"];
            ManutencaoStatus1.Cliente = cliente;
        }
    }
}