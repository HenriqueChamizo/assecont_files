using Wr.Classes;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Net.Mail;
using AssecontNovo.Classes.Emails;

namespace AssecontNovo.Classes
{
    public class EmailInformativos : EmailApp
    {
        private string Titulo;
        private string CorpoEmail;
        private EmailDados emaildados;

        public EmailInformativos(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void CorpoEmailTemp(string Texto, string Numero)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%TITULO%", this.Titulo);
            CorpoEmail = CorpoEmail.Replace("%TEXTO%", Texto);
            CorpoEmail = CorpoEmail.Replace("%NUMERO%", Numero);
            emaildados = new EmailDados();
        }

        public void Send(List<string> listEmails)
        {
            emaildados.Subject = this.Titulo;
            emaildados.Body = this.CorpoEmail;
            emaildados.Emails = new List<string>();
            emaildados.Emails = listEmails;
#if DEBUG
            emaildados.Emails.Add("henrique@assecont.com.br");
#else
            emaildados.Emails = listEmails;
#endif
            //emaildados.Emails.Add("henrique@assecont.com.br");
            base.Send(emaildados);
        }

        public SmtpStatusCode Send(string email)
        {
            emaildados.Subject = this.Titulo;
            emaildados.Body = this.CorpoEmail;
            emaildados.Emails = new List<string>();

            #if DEBUG
                emaildados.Emails.Add("henrique@assecont.com.br");
            #else
                emaildados.Emails.Add(email);
            #endif
            return base.Send(emaildados);
        }

        public void setTitulo(string Titulo)
        {
            this.Titulo = Titulo.Trim();
        }
    }
}