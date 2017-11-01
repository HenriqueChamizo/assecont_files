using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Formulario
{
    public partial class Proposta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            VerificarValores();
        }

        void VerificarValores()
        {
            BDApp bd = new BDApp();
            lbContratacaoAvulso30dias.Text = string.Format("{0:n2}", bd.getValorAtendimentoAvulso30());
            lbContratacaoAvulso.Text = string.Format("{0:n2}", bd.getValorAtendimentoAvulso());
        }

        protected void btnbContratacaoAvulso30dias_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Suporte/Formulario/PropostaPedido.aspx?t=" + BDAppAssefin.atendimentoAvulso30);
        }

        protected void btnContratacaoAvulso_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Suporte/Formulario/PropostaPedido.aspx?t=" + BDAppAssefin.atendimentoAvulso);
        }
    }
}