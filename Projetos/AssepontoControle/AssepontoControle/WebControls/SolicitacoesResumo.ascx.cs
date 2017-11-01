using System;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class SolicitacoesResumo : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int NSolicitacoes = 0;

            BDApp bd = new BDApp();

            NSolicitacoes = bd.getCountSolicitacoesCliente();
            //NSolicitacoes = bd.getFieldValueInteger("SELECT COUNT(*) FROM [AssepontoSolicitacoes] WHERE ASOL_LIBERADO_MANUAL = 0 AND ASOL_LIBERADOEM IS NULL");
            linkNSolicitacoes.NavigateUrl = "~/suporte/Atendimento/SolicitacoesDesbloqueio.aspx";

            SolicitacoesResumoWrapper.Visible = (NSolicitacoes > 0);

            if (NSolicitacoes > 0)
            {
                if (NSolicitacoes == 1)
                {
                    linkNSolicitacoes.Text = "1 solicitação";
                }
                else
                {
                    linkNSolicitacoes.Text = String.Format("{0} solicitações", NSolicitacoes);
                }
            }
        }
    }
}