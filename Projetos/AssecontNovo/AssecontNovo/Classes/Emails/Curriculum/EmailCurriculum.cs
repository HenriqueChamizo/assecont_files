using Wr.Classes;
using System.Web.UI.WebControls;

namespace AssecontNovo.Classes.Emails
{
    public class EmailCurriculo : EmailApp
    {
        public EmailCurriculo(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string Nome, string Telefone, string Email, string Objetivo)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%NOME%", Nome);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE%", Telefone);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
            CorpoEmail = CorpoEmail.Replace("%OBJETIVO%", Objetivo);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Curriculo :" + Nome;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            //emaildados.Emails.Add("flavia@assecont.com.br");
            emaildados.Emails.Add("marcela@assecont.com.br");

            base.Send(emaildados);
        }
    }
}