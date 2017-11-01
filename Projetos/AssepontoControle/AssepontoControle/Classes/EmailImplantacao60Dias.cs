using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailImplantacao60Dias : EmailApp
    {
        public EmailImplantacao60Dias(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string EmailCC)
        {
            BDApp bd = new BDApp();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Comunicado Software AssePonto 4";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("implantacao@assecont.com.br");
            base.Send(emaildados);
        }
    }
}