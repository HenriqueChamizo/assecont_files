using System;
using Wr.Classes;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Mail;
using AssecontNovo.Classes.Emails;

namespace AssecontNovo.Classes
{
    public class EmailOrcamentoFolhaPag : EmailApp
    {
        public EmailOrcamentoFolhaPag(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string Assunto, string Razao, string CNPJ, string Contato, string Email, string Funcionarios, string Telefone, string Obs)
        {
            string CorpoEmailTemplate = Files.ReadFile(TemplateFile);
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
            CorpoEmail = CorpoEmail.Replace("%CNPJ%", CNPJ);
            CorpoEmail = CorpoEmail.Replace("%CONTATO%", Contato);
            CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
            CorpoEmail = CorpoEmail.Replace("%FUNCIONARIOS%", Funcionarios);
            CorpoEmail = CorpoEmail.Replace("%TELEFONE%", Telefone);
            CorpoEmail = CorpoEmail.Replace("%OBS", Obs);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = Assunto;
            emaildados.Body = CorpoEmail;
            //emaildados.EmailCC = "flavia@assecont.com.br"; 
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add("valmirreis@assecont.com.br");
            //emaildados.EmailTo = "valmirreis@assecont.com.br";
            base.Send(emaildados);
        }
    }
}