using System;
using Wr.Classes;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Asseponto.Classes
{
    public class EmailRevendas : EmailApp
    {
         public EmailRevendas(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

         public void Send(string EmailTo, string EmailCC, string EmailCC2, string Email2, string Razao, DateTime Data, string Email, string Contato, string Revenda)
         {
             BDApp bd = new BDApp();

             string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

             CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", Razao);
             CorpoEmail = CorpoEmail.Replace("%DATA%", Convert.ToString(Data));
             CorpoEmail = CorpoEmail.Replace("%CONTATO%", Contato);
             CorpoEmail = CorpoEmail.Replace("%EMAIL%", Email);
             CorpoEmail = CorpoEmail.Replace("%EMAIL2%", Email2);
             CorpoEmail = CorpoEmail.Replace("%REVENDA%", Revenda);

             EmailDados emaildados = new EmailDados();

             emaildados.Subject = string.Format("Credenciar - Revenda {0}", Razao);
             emaildados.Body = CorpoEmail;
             emaildados.Emails = new System.Collections.Generic.List<string>();
             emaildados.Emails.Add(EmailTo);
             emaildados.Emails.Add(EmailCC);
             emaildados.Emails.Add(EmailCC2);

             emaildados.ReplyTo = new System.Collections.Generic.List<string>();
             emaildados.ReplyTo.Add("comercial@assecont.com.br");
             base.Send(emaildados);
         }
    }
}