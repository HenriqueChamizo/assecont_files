using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class EmailComercial : EmailApp
    {
        public EmailComercial(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(List<string> EmailTo, string razao, int userid, string Titulo)
        { 
             BDApp bd = new BDApp();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%RAZAOSOCIAL%", razao);
            CorpoEmail = CorpoEmail.Replace("%ENVIADO%", bd.getFieldValueString("select SUP_NOME from AssepontoSuporte where SUP_IND = " + userid.ToString()));

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = Titulo;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = EmailTo;
            //emaildados.EmailCC = "rayssa@assecont.com.br";

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            base.Send(emaildados);
        }
    }
}