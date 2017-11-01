using System.Configuration;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class EmailFormularioTreinamento : EmailApp
    {
        public EmailFormularioTreinamento(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string Razao, string CNPJ, string Contato, string Email, string Observacoes)
        {
            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
            CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ);
            CorpoEmail = CorpoEmail.Replace("%CONTATO%", Contato);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
            CorpoEmail = CorpoEmail.Replace("%OBSERVACOES%", Observacoes);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Treinamento Asseponto4 - " + Razao;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");
            base.Send(emaildados);
        }
    }
}