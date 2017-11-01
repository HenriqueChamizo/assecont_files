using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class EmailTreinamento : EmailApp
    {
        private string CorpoEmail;
        private EmailDados emaildados;
        private string assunto;
        public EmailTreinamento(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {

        }

        public void Send(string EmailTo)
        {
            emaildados = new EmailDados();
            emaildados.Subject = assunto;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            emaildados.ReplyTo.Add("treinamento@assecont.com.br");
            base.Send(emaildados);
        }

        public void Send(List<string> Emails)
        {
            emaildados = new EmailDados();
            emaildados.Subject = assunto;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails = Emails;

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            emaildados.ReplyTo.Add("treinamento@assecont.com.br");
            base.Send(emaildados);
        }

        public void templateConfirmarTreinamento(string Razao, string dataHora, string CNPJ, string Contato, string Email, string Telefone)
        {
            string CorpoEmailTemplate = getBody();
            this.CorpoEmail = CorpoEmailTemplate;

            this.CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao.Trim());
            this.CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ.Trim());
            this.CorpoEmail = CorpoEmail.Replace("%CONTATO%", Contato.Trim());
            this.CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email.Trim());
            this.CorpoEmail = CorpoEmail.Replace("%TEEFONE%", Telefone.Trim());
            this.CorpoEmail = CorpoEmail.Replace("%DATAHORA% ", dataHora.Trim());

            this.assunto = "Confirmação - Treinamento Asseponto4";
        }

        public void templateEnviarCodigo(string dataHora, string codigo)
        {
            string CorpoEmailTemplate = getBody();
            CorpoEmail = CorpoEmailTemplate;


            this.CorpoEmail = CorpoEmail.Replace("%DATAHORA% ", dataHora);
            this.CorpoEmail = CorpoEmail.Replace("%CODIGO%", codigo);

            this.assunto = "Acesso - Treinamento Asseponto4";
        }
    }
}