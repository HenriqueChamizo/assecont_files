using System;

namespace Asseponto.Revenda.Implantacoes
{
    public partial class Implantacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int Implantacao = Convert.ToInt32(Request.QueryString["ind"]);

            RadMenu2.Items.FindItemByText("Pendências").NavigateUrl = "~/Revenda/Implantacoes/Pendencias.aspx?implantacao=" + Implantacao;
        }
    }
}