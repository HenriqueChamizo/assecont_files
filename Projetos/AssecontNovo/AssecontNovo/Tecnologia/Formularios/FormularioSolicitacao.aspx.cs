using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Teste.Formularios
{
    public partial class FormularioSolicitacao : System.Web.UI.Page
    {
        private string orcamentoTipo;
        protected void Page_Load(object sender, EventArgs e)
        {
            int orc = Convert.ToInt32(Request.QueryString["orc"]);

            switch (orc)
            {
                case 1:
                    orcamentoTipo = "Solicitação de orçamento da folha de pagamento";
                    lblIntroducao.Text = "Para realizar a solicitação de orçamento da folha de pagamento, preencha o formulário abaixo.";
                    break;
                case 2:
                    orcamentoTipo = "Solicitação de um més gratis da folha de pagamento";
                    lblIntroducao.Text = "Para realizar a solicitação de um més gratis da folha de pagamento, preencha o formulário abaixo.";
                    break;
                case 3:
                    orcamentoTipo = "Solicitação de orçamento de Manutenção";
                    lblIntroducao.Text = "Para realizar a solicitação de orçamento de Manutenção, preencha o formulário abaixo.";
                    break;
            }
        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            string EmailFrom = "suporte@assecont.com.br";

            EmailOrcamentoFolhaPag email = new EmailOrcamentoFolhaPag(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Classes\\Email\\OrcamentoTecnologia\\EmailOrcamentoFolhaPag.htm");
            email.Send(orcamentoTipo, txtRazaoSocial.Text, txtCnpj.Text, txtContato.Text, txtEmail.Text, txtFuncionario.Text, txtTelefone.Text, "");
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            //Custom validator é obigatorio que preencha o campo para validar, mas se tirar o control to validate,
            //pode configurar o que vai ? ou como vai validar?, depois de clicar no button.
            if (txtCnpj.Text == "" && txtCpf.Text == "")
            {
                args.IsValid = false;
            }
        }
    }
}