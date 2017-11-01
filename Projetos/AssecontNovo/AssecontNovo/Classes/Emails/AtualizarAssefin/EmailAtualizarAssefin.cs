using Wr.Classes;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace AssecontNovo.Classes.Emails.AtualizarAssefin
{
    public class EmailAtualizarAssefin : EmailApp
    {
        private string CorpoEmail;

        public EmailAtualizarAssefin(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send()
        {
            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Atualização Email Boleto";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("lays@assecont.com.br");
            emaildados.Emails.Add("debora@assecont.com.br");
            //emaildados.Emails.Add("flavia@assecont.com.br");
            base.Send(emaildados);
        }

        public void CorpoEmailReplace(string Empresa, string CNPJ, string Email1, string Email2, string Email3)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%EMPRESANOME%", Empresa);
	        CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ);
	        CorpoEmail = CorpoEmail.Replace("%EMAIL1%", Email1);
	        CorpoEmail = CorpoEmail.Replace("%EMAIL2%", Email2);
            CorpoEmail = CorpoEmail.Replace("%EMAIL3%", Email3);
        }
    }
}