using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Revendas
{
    public partial class Manuntecao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            (new Permissoes(new BDApp())).getAcessoResponse("Manutencao", Response);

            ManutencaoRevendaLancamento.Revenda = Convert.ToInt32(Request.QueryString["revenda"]);
            ManutencaoCancelamento.Revenda = Convert.ToInt32(Request.QueryString["revenda"]);
        }

        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            switch (e.Item.Text)
            {
                case "Lançar Manutenção":
                    expandirLancarManutencao();
                    break;
                case "Cancelamento":
                    expandirCancelamento();
                    break;
            }
        }

        private void expandirLancarManutencao()
        {
            ManutencaoRevendaLancamento.Visible = true;

            if (ManutencaoCancelamento.Visible)
            {
                ManutencaoCancelamento.Visible = false;
            }
        }

        private void expandirCancelamento()
        {
            ManutencaoCancelamento.Visible = true;

            if (ManutencaoRevendaLancamento.Visible)
            {
                ManutencaoRevendaLancamento.Visible = false;
            }
        }
    }
}