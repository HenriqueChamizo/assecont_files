using AssecontNovo.Classes.Emails;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace AssecontNovo.Holerite.Classes
{
    public class EmailSenha : EmailApp
    {
        public EmailSenha(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string Senha, string Nome, string Registro, string CPF)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%NOME%", Nome);
            CorpoEmail = CorpoEmail.Replace("%SENHA%", Senha);
            CorpoEmail = CorpoEmail.Replace("%REGISTRO%", Registro);
            CorpoEmail = CorpoEmail.Replace("%CPF%", CPF);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Solicitação de acesso";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.ReplyTo = new System.Collections.Generic.List<string>(); 
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            //emaildados.EmailTo = EmailTo;

            base.Send(emaildados);
        }
    }
}