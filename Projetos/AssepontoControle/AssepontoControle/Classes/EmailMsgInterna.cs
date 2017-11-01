using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailMsgInterna : EmailApp
    {
        public EmailMsgInterna(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string msg, string assunto)
        {
            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%MSG%", msg);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = assunto;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");

            base.Send(emaildados);
        }
    }
}