using Wr.Classes;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Data;
using AssecontNovo.Classes.Emails;

namespace AssecontNovo.Classes
{
    public class EmailQuestSocio : EmailApp
    {
        private string CorpoEmailTemplate;
        public EmailQuestSocio(string EmailFrom, Label Mensagem, string TemplateFile)
            : base(EmailFrom, Mensagem, TemplateFile)
        {
            this.CorpoEmailTemplate = Files.ReadFile(TemplateFile);
        }

        public void send(int indSocio, string periodo, string url)
        {
            string CorpoEmail = CorpoEmailTemplate;
            string Email = string.Empty;
            string Subject = string.Empty;

            url += "?i=" + (new Wr.Classes.Crypto()).Encrypt(indSocio.ToString());
            CorpoEmail = CorpoEmail.Replace("%LINK_PESQUISA%", url);

            DataTable dt = (new BDAppAssecont()).getDataTable("SELECT CLISOC_NOME, CLISOC_EMAIL, CLI_RAZAOSOCIAL FROM ClientesSocios INNER JOIN Clientes ON CLI_IND = CLISOC_CLIENTE WHERE CLISOC_IND = " + indSocio);

            foreach (DataRow dr in dt.Rows)
            {
                CorpoEmail = CorpoEmail.Replace("%NOME%", dr["CLISOC_NOME"].ToString());
                CorpoEmail = CorpoEmail.Replace("%PERIODO%", periodo);
                Email = dr["CLISOC_EMAIL"].ToString().Trim();
                Subject = dr["CLI_RAZAOSOCIAL"].ToString();
            }

            EmailDados emaildados = new EmailDados();
            emaildados.Body = CorpoEmail;
            emaildados.Subject = "Assecont - Pesquisa Satisfação da empresa " + Subject;
            emaildados.Emails = new List<string>();
            emaildados.Emails.Add(Email);
            //emaildados.Emails.Add("flavia@assecont.com.br");
            base.Send(emaildados);
        }
    }
}