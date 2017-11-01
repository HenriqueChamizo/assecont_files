using System.Web.UI.WebControls;
using System.Collections.Generic;
using Wr.Classes;
using System.Configuration;

namespace Assecontweb.Classes.Views
{
    public class EmailPesquisaFromAtendimento : Wr.Classes.Email
    {
        public EmailPesquisaFromAtendimento(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, EmailFrom, "admasseCONT01", "", Mensagem, TemplateFile)
        {

        }

        public void send(string Nome, string Empresa, string Url, int Indice, string EmailFor)
        {
            string CorpoEmail = TemplateFile;
            string param = (new Wr.Classes.Crypto()).Encrypt(Indice.ToString());

            Url += "?i=" + param;
            Url += "&v=" + (new Wr.Classes.Crypto()).Encrypt("true");

            Nome = Wr.Classes.Strings.getWord(Nome);

            CorpoEmail = CorpoEmail.Replace("%NOME%", Nome);
            CorpoEmail = CorpoEmail.Replace("%EMPRESAS%", Empresa);
            CorpoEmail = CorpoEmail.Replace("%LINK_ACESSO%", Url);

            EmailDados emaildados = new EmailDados();

            emaildados.Body = CorpoEmail;
            emaildados.Subject = "Pesquisa Satisfacao - Resposta de " + (string.IsNullOrEmpty(Nome) ? Empresa : Nome);
            emaildados.Emails = new List<string>();
            emaildados.Emails.Add(EmailFor);
            //emaildados.Emails.Add("flavia@assecont.com.br");
            base.Send(emaildados);
        }
    }
}
