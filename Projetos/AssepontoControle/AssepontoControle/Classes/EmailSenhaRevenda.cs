using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;
using System.Net.Mail;

namespace Asseponto.Classes
{
    public class EmailSenhaRevenda : EmailApp
    {
        private EmailDados emaildados;
        public EmailSenhaRevenda(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public SmtpStatusCode Send(string EmailTo, string EmailCC, int UsuarioRevenda)
        {
            BDApp bd = new BDApp();
            bd.openConnection();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CONTATO%", bd.getLoginFromContatoRevendas(UsuarioRevenda));
            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", bd.getRevendaRazaoSocialFromUsuariosRevendas(UsuarioRevenda));
            CorpoEmail = CorpoEmail.Replace("%LOGIN%", bd.getLoginFromUsuariosRevendas(UsuarioRevenda));
            CorpoEmail = CorpoEmail.Replace("%SENHA%", bd.getPasswordFromUsuariosRevendas(UsuarioRevenda));
            bd.closeConnection();

            emaildados = new EmailDados();

            emaildados.Subject = "Envio de senha de acesso";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");
            return base.Send(emaildados);
        }

        //public void sendRevendaGold(string EmailTo, string EmailCC, string CorpoEmailTemplate)
        //{
        //    string CorpoEmail = Files.ReadFile(CorpoEmailTemplate);

        //    emaildados.Subject = String.Format("Informações - Revenda Gold");
        //    emaildados.Body = CorpoEmail;
        //    emaildados.Emails = new System.Collections.Generic.List<string>();
        //    emaildados.Emails.Add(EmailTo);
        //    emaildados.Emails.Add(EmailCC);

        //    emaildados.ReplyTo = new System.Collections.Generic.List<string>();
        //    emaildados.ReplyTo.Add("comercial@assecont.com.br");
        //    base.Send(emaildados);
        //}
    }
}