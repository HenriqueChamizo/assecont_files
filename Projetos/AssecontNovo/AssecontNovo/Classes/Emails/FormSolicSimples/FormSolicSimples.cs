using System.Web.UI.WebControls;
using Wr.Classes;

namespace AssecontNovo.Classes.Emails.FormSolicSimples
{
    public class FormSolicSimples : EmailApp
    {
        public FormSolicSimples(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string Razao, string CNPJ_CPF, string Contato1, string Telefone1, string Email1)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
            CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ_CPF);

            CorpoEmail = CorpoEmail.Replace("%CONTATO1%", Contato1);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE1%", Telefone1);
            CorpoEmail = CorpoEmail.Replace("%EMAIL1%", Email1);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = " Atualização de Software - Asseponto4";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("comercial@assecont.com.br");
            //emaildados.EmailTo = "comercial@assecont.com.br";
            //emaildados.EmailCC = "flavia@assecont.com.br";
            base.Send(emaildados);
        }
    }
}