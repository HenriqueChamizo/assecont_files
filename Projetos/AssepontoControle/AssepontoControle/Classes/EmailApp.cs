using System.Web.UI.WebControls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using Wr.Classes;
using System.Net.Mail;

namespace Asseponto.Classes
{
    public class EmailApp : Email
    {
        public EmailApp(string EmailFrom, Label Mensagem, string TemplateFile, string host = "smtplw.com.br", int port = 587)
            : base(new EmailAuthentication(host, port, "assecont", "BwpGCkuA7951", true), EmailFrom, "", new TemplateFile(TemplateFile))
        {
        }
        public EmailApp(string EmailFrom, string Subject, Label Mensagem, string TemplateFile, string host = "smtplw.com.br", int port = 587)
            : base(new EmailAuthentication(host, port, "assecont", "BwpGCkuA7951", true), EmailFrom, Subject, new TemplateFile(TemplateFile))
        {
        }

        public SmtpStatusCode SendPublic(EmailDados emaildados)
        {
            return this.Send(emaildados);
        }
    }
}