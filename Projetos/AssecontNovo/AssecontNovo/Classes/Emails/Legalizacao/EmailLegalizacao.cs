using System.Net.Mail;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace AssecontNovo.Classes.Emails.Legalizacao
{
    public class EmailLegalizacao : EmailApp
    {
        public EmailLegalizacao()
            : base("notificacao@assecont.com.br", (new Label()), "")
        {}

        protected void Send(string subject, string emailTo)
        {
            getDados();

            string CorpoEmail = CorpoEmailTemplate();

            EmailDados emaildados = new EmailDados();
            emaildados.Subject = subject;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(emailTo);

            SmtpStatusCode smtp = base.Send(emaildados);

            if(smtp.Equals("OK"))
                atualizar();           
        }

        protected virtual void getDados() { }
        protected virtual string CorpoEmailTemplate() { return string.Empty; }
        protected virtual void atualizar() { }
    }
}