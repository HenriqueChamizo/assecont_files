using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailInstalacao : EmailApp
    {
        public EmailInstalacao(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string EmailCC)
        {
            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Comunicado Software AssePonto 4";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"]);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");

            base.Send(emaildados);
        }
    }
}