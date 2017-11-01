using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailFormulario : EmailApp
    {
        public EmailFormulario(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string Razao, string CNPJ, string Contato, string Email, string Funcionarios, string Observacoes)
        {
            BDApp bd = new BDApp();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
            CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ);
            CorpoEmail = CorpoEmail.Replace("%CONTATO%", Contato);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
            CorpoEmail = CorpoEmail.Replace("%FUNCIONARIOS%", Funcionarios);
            CorpoEmail = CorpoEmail.Replace("%OBSERVACOES%", Observacoes);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = "Contrato de Suporte Técnico Mensal";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");
            base.Send(emaildados);
        }
    }
}