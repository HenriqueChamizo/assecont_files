using System.Configuration;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class EmailQuestionarios : EmailApp
    {
        public EmailQuestionarios(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
        }

        public void Send(string EmailTo, int Indice, string Tecnico, string Nome, string Titulo)
        { 
             BDApp bd = new BDApp();

            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            CorpoEmail = CorpoEmail.Replace("%INDICE%", Indice.ToString());
            CorpoEmail = CorpoEmail.Replace("%TECNICO%", Tecnico);
            //CorpoEmail = CorpoEmail.Replace("%LINK_PESQUISA%", Tecnico);
            //CorpoEmail = CorpoEmail.Replace("%NOME%", Tecnico);

            EmailDados emaildados = new EmailDados();

            emaildados.Subject = Titulo;
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            //emaildados.EmailCC = "rayssa@assecont.com.br";

            emaildados.ReplyTo = new System.Collections.Generic.List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            base.Send(emaildados);
        }
    }
}