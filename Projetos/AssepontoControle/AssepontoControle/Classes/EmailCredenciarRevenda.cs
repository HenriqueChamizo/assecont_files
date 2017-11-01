using System;
using Wr.Classes;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailCredenciarRevenda : EmailApp
    {
        private EmailDados emaildados;

        public EmailCredenciarRevenda(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, string EmailCC, string EmailCC2, int UsuarioRevenda, string contato)
        {
            BDApp bd = new BDApp();

            UsuarioRevenda = Convert.ToInt32(bd.getFieldValueString(string.Format("SELECT USUREV_IND FROM AssepontoUsuariosRevendas WHERE USUREV_REVENDA = '{0}'", UsuarioRevenda)));
            string RazaoSocial = bd.getRevendaRazaoSocialFromUsuariosRevendas(UsuarioRevenda).ToUpper();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%CONTATO%", contato);
            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", RazaoSocial);
            CorpoEmail = CorpoEmail.Replace("%LOGIN%", bd.getLoginFromUsuariosRevendas(UsuarioRevenda));
            CorpoEmail = CorpoEmail.Replace("%SENHA%", bd.getPasswordFromUsuariosRevendas(UsuarioRevenda));

            emaildados = new EmailDados();

            emaildados.Subject = String.Format("Confirmação de Credeciamento da {0}", RazaoSocial);
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(EmailCC2);

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("comercial@assecont.com.br");

            base.Send(emaildados);
        }

        //public void sendRevendaGold(string EmailTo, string EmailCC, string EmailCC2, string CorpoEmailTemplate)
        //{
        //    string CorpoEmail = Files.ReadFile(CorpoEmailTemplate);

        //    emaildados.Subject = String.Format("Informações - Revenda Gold");
        //    emaildados.Body = CorpoEmail;
        //    emaildados.Emails = new System.Collections.Generic.List<string>();
        //    emaildados.Emails.Add(EmailTo);
        //    emaildados.Emails.Add(EmailCC);
        //    emaildados.Emails.Add(EmailCC2);
        //    base.Send(emaildados);
        //}
    }
}