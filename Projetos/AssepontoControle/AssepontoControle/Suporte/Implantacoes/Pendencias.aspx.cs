using System;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class Pendencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int Implantacao = Convert.ToInt32(Request.QueryString["implantacao"]);
            RadMenu2.Items.FindItemByText("Nova Pendência").NavigateUrl = "~/suporte/Implantacoes/Pendencia.aspx?implantacao=" + Implantacao;
        }
    }
}