using Wr.Classes;
using System.Web.UI.WebControls;
using AssecontNovo.Classes.Emails;

namespace AssecontNovo.Classes
{
    public class EmailSac : EmailApp
    {
        public EmailSac(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string Mensagem, string Cliente, string Produto, string Assunto)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CLIENTE%", Cliente);
            CorpoEmail = CorpoEmail.Replace("%MENSAGEM%", Mensagem);
            CorpoEmail = CorpoEmail.Replace("%PRODUTO%", Produto);
            CorpoEmail = CorpoEmail.Replace("%ASSUNTO%", Assunto);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Resposta do SAC";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("atendimento@assecont.com.br");
            //emaildados.EmailTo = "atendimento@assecont.com.br";
            //emaildados.EmailCC = "flavia@assecont.com.br"; 
            base.Send(emaildados);
        }
    }
}