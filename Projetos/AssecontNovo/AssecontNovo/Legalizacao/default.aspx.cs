using System;
using AssecontNovo.Classes;

namespace AssecontNovo.Legalizacao
{
    public partial class _default : System.Web.UI.Page
    {
        protected void lkAbertura_Click(object sender, EventArgs e)
        {
            ResponseCadastro(Types.LegalizacaoServicoTipo.Abertura);
        }

        protected void lkAlteracao_Click(object sender, EventArgs e)
        {
            ResponseCadastro(Types.LegalizacaoServicoTipo.Alteracao);
        }

        protected void lkEncerramento_Click(object sender, EventArgs e)
        {
            ResponseCadastro(Types.LegalizacaoServicoTipo.Encerramento);
        }

        protected void lkOutros_Click(object sender, EventArgs e)
        {
            ResponseCadastro(Types.LegalizacaoServicoTipo.Outro);
        }

        private void ResponseCadastro(Types.LegalizacaoServicoTipo servico)
        {
            Response.Redirect("~/Legalizacao/ExtranetCadastro.aspx?ind=" + (int)servico);
        }

        protected void lbVerificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Legalizacao/Extranet.aspx?ind=" + txtProtocolo.Text.Trim());
        }
    }
}