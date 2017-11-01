using System;
using Asseponto.Classes;

namespace Asseponto.Revenda
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            int Revenda = Convert.ToInt32(Session["Revenda"]);
            labelRevendaRazaoSocial.Text = (new BDApp()).getRevendaRazaoSocial(Revenda);
            PedidosResumo1.Revenda = Revenda;
            ImplantacoesResumo1.Revenda = Revenda;
        }
    }
}