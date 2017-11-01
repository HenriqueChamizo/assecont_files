using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailImplantacao40Dias : Email
    {
        public EmailImplantacao40Dias(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, ConfigurationManager.AppSettings["EMAILPWD"], "", Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo)
        {
            BDApp bd = new BDApp();

            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Comunicado Software AssePonto 4";
            emaildados.Body = CorpoEmail;
            emaildados.EmailTo = EmailTo;
            base.Send(emaildados);
        }
    }
}