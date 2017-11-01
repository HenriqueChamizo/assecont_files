using Wr.Classes;
using System.Web.UI.WebControls;

namespace AssecontNovo.Classes.Emails.Cotacao
{
    public class EmailCotacao : EmailApp
    {
        private string CorpoEmail;

        public EmailCotacao(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send()
        {
            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Resposta Contacao On-line";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            //emaildados.Emails.Add("flavia@assecont.com.br");
            //emaildados.EmailTo = "flavia@assecont.com.br";
            emaildados.Emails.Add("atendimento@assecont.com.br");
            base.Send(emaildados);
        }

        public void CorpoEmailReplace(string Nome, string Email, string Telefone, string Celular, string Constituida,
               string RamoAtividade, string RamoExploracao, string Localizacao, string Regime, string NfEntrada,
               string NfSaida, string FuncRegistrados, string ProLabore, string ChegouNos, string indicacao)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%NOME%", Nome);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE%", Telefone);
            CorpoEmail = CorpoEmail.Replace("%CELULAR%", Celular);
            CorpoEmail = CorpoEmail.Replace("%CONSTIUIDA%", Constituida);
            CorpoEmail = CorpoEmail.Replace("%RAMO_EMPRESA%", RamoAtividade);
            CorpoEmail = CorpoEmail.Replace("%RAMO_EXPLORACAO%", RamoExploracao);
            CorpoEmail = CorpoEmail.Replace("%LOCALIZACAO_EMPRESA%", Localizacao);
            CorpoEmail = CorpoEmail.Replace("%REGIME_EMPRESA%", Regime);
            CorpoEmail = CorpoEmail.Replace("%NF_ENTRADA%", NfEntrada);
            CorpoEmail = CorpoEmail.Replace("%NF_SAIDA%", NfSaida);
            CorpoEmail = CorpoEmail.Replace("%FUNCIONARIOS_REGIS%", FuncRegistrados);
            CorpoEmail = CorpoEmail.Replace("%PRO_LABORE%", ProLabore);
            CorpoEmail = CorpoEmail.Replace("%CHEGOU_NOS%", ChegouNos);
            CorpoEmail = CorpoEmail.Replace("%INDICACAO%", indicacao);
        }
    }
}