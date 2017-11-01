using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class EmailClientesExpirados : Email
    {
        private EmailDados emaildados;
        public EmailClientesExpirados(string EmailFrom, Label Mensagem, string TemplateFile)
        : base(EmailFrom, ConfigurationManager.AppSettings["EMAILPWD"], "", Mensagem, TemplateFile)
        {
            emaildados = new EmailDados();
        }

        public void Send(string EmailTo, string EmailCC, string EmailCC2)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            emaildados.Subject = "Comunicado Prazo de Suporte";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(EmailCC2);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");

            base.Send(emaildados);
        }
    }
}