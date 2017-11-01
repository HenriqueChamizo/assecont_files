using System.Web.UI.WebControls;
using Wr.Classes;

namespace AssecontNovo.Classes.Emails.FormularioWorkShop
{
    public class FormularioWorkShop : EmailApp
    {
        public FormularioWorkShop(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string Razao, string CNPJ_CPF, string Contato1, string Telefone1, string Email1,
              string Contato2, string Telefone2, string Email2, string Contato3, string Telefone3, string Email3)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
            CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ_CPF);

            CorpoEmail = CorpoEmail.Replace("%CONTATO1%", Contato1);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE1%", Telefone1);
            CorpoEmail = CorpoEmail.Replace("%EMAIL1%", Email1);

            CorpoEmail = CorpoEmail.Replace("%CONTATO2%", Contato2);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE2%", Telefone2);
            CorpoEmail = CorpoEmail.Replace("%EMAIL2%", Email2);
            
            CorpoEmail = CorpoEmail.Replace("%CONTATO3%", Contato3);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE3%", Telefone3);
            CorpoEmail = CorpoEmail.Replace("%EMAIL3%", Email3);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Confirmação Workshop";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("comercial@assecont.com.br");
            //emaildados.EmailTo = "comercial@assecont.com.br";
            //emaildados.EmailCC = "flavia@assecont.com.br";
            base.Send(emaildados);
        }
    }
}