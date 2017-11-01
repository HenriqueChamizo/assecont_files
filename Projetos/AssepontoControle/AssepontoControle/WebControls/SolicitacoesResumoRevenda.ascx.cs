using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class SolicitacoesResumoRevenda : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             int NSolicitacoes = 0;

            BDApp bd = new BDApp();

            NSolicitacoes = bd.getFieldValueInteger("SELECT COUNT(*) FROM [AssepontoRevendasProvisorios] WHERE CADP_REV_LIBERADO_EM IS NULL");
            linkNSolicitacoes.NavigateUrl = "~/suporte/Atendimento/SolicitacoesDesbloqueioRevenda.aspx";

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