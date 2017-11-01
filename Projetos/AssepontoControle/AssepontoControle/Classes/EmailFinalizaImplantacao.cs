using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;
using System.Configuration;
using System.Net.Mail;

namespace Asseponto.Classes
{
    public class EmailFinalizaImplantacao : EmailApp
    {
        string ClienteNome = "";
        string FuncionarioNome = "";
        BDApp bd;

        public EmailFinalizaImplantacao(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
            bd = new BDApp();
        }

        public void GetClieFuncNomes(int ind)
        {
            ClienteNome = bd.getClienteContatosFromImplantacao(ind);
            FuncionarioNome = bd.getSuporteNomeFromImplantacao(ind);
        }

        public SmtpStatusCode Send(string EmailTo, string EmailCC)
        {
            SmtpStatusCode retorno;
            string CorpoEmailTemplate = getBody();
            string CorpoEmail = CorpoEmailTemplate;

            EmailDados emaildados = new EmailDados();

            CorpoEmail = CorpoEmail.Replace("%CLIENTENOME%", ClienteNome);
            if (String.IsNullOrEmpty(FuncionarioNome))
                CorpoEmail = CorpoEmail.Replace("<br>Técnico: <b>%FUNCIONARIONOME%</b>.", "");
            else
                CorpoEmail = CorpoEmail.Replace("%FUNCIONARIONOME%", FuncionarioNome);

            emaildados.Subject = "Implantação Finalizada AssePonto 4";
            emaildados.Body = CorpoEmail;
            emaildados.Emails = new System.Collections.Generic.List<string>();
            emaildados.Emails.Add(EmailTo);
            emaildados.Emails.Add(EmailCC);
            emaildados.Emails.Add(ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"]);

            emaildados.ReplyTo = new List<string>();
            emaildados.ReplyTo.Add("suporte@assecont.com.br");
            emaildados.ReplyTo.Add("treinamento@assecont.com.br");

            retorno = base.Send(emaildados);
            return retorno;
        }
    }
}